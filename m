Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 4/6] att: Fix sending pdu's with invalid data
Date: Wed, 10 Oct 2012 20:35:01 -0300
Message-Id: <1349912103-663-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1349912103-663-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1349912103-663-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When encoding an att_data_list we need to make sure that each element
lenght of the data list will not exceed 255, because that information
will be encoded as a octet later.
---
 attrib/att.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/attrib/att.c b/attrib/att.c
index fc510f4..f262bb6 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -101,6 +101,9 @@ struct att_data_list *att_data_list_alloc(uint16_t num, uint16_t len)
 	struct att_data_list *list;
 	int i;
 
+	if (len > UINT8_MAX)
+		return NULL;
+
 	list = g_new0(struct att_data_list, 1);
 	list->len = len;
 	list->num = num;
-- 
1.7.12.3

