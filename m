Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 18/22] blueatchat: Add more data parsing functionality
Date: Mon, 14 Oct 2013 10:34:34 +0200
Message-Id: <1381739678-16260-19-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds data recognition for the compound value, char, quoted
string and value sepparator.
---
 src/shared/blueatchat.c |   62 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/dparser.c    |   39 +++++++++++++++++++++++++++++
 src/shared/dparser.h    |    2 ++
 3 files changed, 103 insertions(+)

diff --git a/src/shared/blueatchat.c b/src/shared/blueatchat.c
index 6a12b22..06d8c65 100644
--- a/src/shared/blueatchat.c
+++ b/src/shared/blueatchat.c
@@ -152,6 +152,7 @@ static int blueatchat_parse_data(char *descriptor, int *descr_off,
 				struct blueatchat_session *session,
 				int *data_off, int amount)
 {
+	/* TODO: Add simple recursive call depth counter? */
 	unsigned int i;
 	int begin_offset = *data_off;
 	bool optional = false;
@@ -169,9 +170,29 @@ static int blueatchat_parse_data(char *descriptor, int *descr_off,
 		if (*data_off - begin_offset == amount)
 			return 0;
 
+		/* offset storage for recursive calls */
+		*descr_off = i;
+
 		switch (ch) {
 		case '(':	/* compound value start */
 			BLUEATCHAT_DEBUG(session, "(");
+
+			if (*cbuffer_peek_tail(session->buffer, *data_off) ==
+								'(')
+				++(*data_off);
+			else if (!optional)
+				return -ENODATA;
+
+			++(*descr_off);
+			if (blueatchat_parse_data(descriptor, descr_off,
+						session, data_off, amount) < 0)
+				return -ENODATA;
+			/*
+			 * After recursive call returns, descr_off holds offset
+			 * indicating how much the descriptor was processed.
+			 * Advance by this value to not process this data again.
+			 */
+			i = *descr_off;
 			break;
 		case 'o':	/* optional value */
 			BLUEATCHAT_DEBUG(session, "o");
@@ -188,17 +209,58 @@ static int blueatchat_parse_data(char *descriptor, int *descr_off,
 
 			session->data = g_slist_prepend(session->data, newdata);
 			break;
+		case 'c':	/* single char */
+			BLUEATCHAT_DEBUG(session, "c");
+
+			newdata = dparse_char(session->buffer, data_off);
+			if (!newdata && !optional)
+				return -ENODATA;
+
+			session->data = g_slist_prepend(session->data, newdata);
+			break;
 		case 'q':	/* quoted string */
 			BLUEATCHAT_DEBUG(session, "q");
+
+			newdata = dparse_qstr(session->buffer, data_off);
+			if (!newdata && !optional)
+				return -ENODATA;
+
+			session->data = g_slist_prepend(session->data, newdata);
 			break;
 		case 's':	/* TODO: unquoted string */
 			BLUEATCHAT_DEBUG(session, "s");
 			break;
 		case ')':	/* compound value end */
 			BLUEATCHAT_DEBUG(session, ")");
+
+			if (*cbuffer_peek_tail(session->buffer, *data_off)
+									== ')')
+				++(*data_off);
+			else if (!optional)
+				return -ENODATA;
+
+			return 0;
+		case '-':	/* TODO: value range */
+			BLUEATCHAT_DEBUG(session, "-");
+
+			++(*data_off); /* For now it just skip it */
 			break;
 		case ',':	/* value separator */
 			BLUEATCHAT_DEBUG(session, ",");
+
+			if (*cbuffer_peek_tail(session->buffer, *data_off)
+									== ',')
+				++(*data_off);
+			else if (!optional)
+				return -ENODATA;
+
+			/*
+			 * Optional classifier works on a single descriptor, but
+			 * turn this flag off only when this is not the opening
+			 * one, like in "uo,u", where ',' is also optional.
+			 */
+			if (i > 0 && descriptor[i - 1] != 'o')
+				optional = 0;
 			break;
 		case '*':
 			/*
diff --git a/src/shared/dparser.c b/src/shared/dparser.c
index 7b7a2a2..0de7038 100644
--- a/src/shared/dparser.c
+++ b/src/shared/dparser.c
@@ -43,3 +43,42 @@ unsigned int *dparse_uint(struct circular_buffer *buffer, int *offset)
 	}
 	return ret;
 }
+
+char *dparse_qstr(struct circular_buffer *buffer, int *offset)
+{
+	char *str;
+	int len;
+	int i;
+
+	if (*cbuffer_peek_tail(buffer, *offset) != '"')
+		return NULL;
+
+	len = cbuffer_seek_tail_for_seq(buffer, "\"", *offset + 1) - *offset;
+	if (len <= 0)
+		return NULL;
+
+	str = g_malloc(len);
+
+	for (i = 0; i < len - 1; ++i)
+		str[i] = *cbuffer_peek_tail(buffer, *offset + i + 1);
+	str[i] = '\0';
+	/* Move offset on first char after closing quotation mark */
+	*offset += len + 1;
+	return str;
+}
+
+char *dparse_char(struct circular_buffer *buffer, int *offset)
+{
+	const char *c = NULL;
+	char *ret = NULL;
+
+	c = cbuffer_peek_tail(buffer, *offset);
+	if (!isascii(*c))
+		return NULL;
+
+	ret = g_new(char, 1);
+	*ret = *c;
+	++(*offset);
+
+	return ret;
+}
diff --git a/src/shared/dparser.h b/src/shared/dparser.h
index 7c0bf58..66dd4a7 100644
--- a/src/shared/dparser.h
+++ b/src/shared/dparser.h
@@ -22,3 +22,5 @@
  */
 
 unsigned int *dparse_uint(struct circular_buffer *buffer, int *offset);
+char *dparse_qstr(struct circular_buffer *buffer, int *offset);
+char *dparse_char(struct circular_buffer *buffer, int *offset);
-- 
1.7.9.5

