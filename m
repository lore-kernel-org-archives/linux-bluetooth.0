Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942AA3C8713
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521870; cv=none; b=paLU1DdiMVcxYQTPX5I7UuLdeBg+Nm88G9kafHS+Z64SwpQGPhB/OerfpYCBMIm0wBpBD4DVXVqfktRKuCEbqBwNdsVVTKaQDVkINv6cWxWdRzP2OLLOpywnUrYBovsCDde/ZN9OJaIicCyz+tItUamAftRtPX1eum3B3/ofrOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521870; c=relaxed/simple;
	bh=n9ar95Y/ViZjeUhiFc9DbHZpIE/qehXlBA7Skb551zU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MxgG+3HJNwjTBZDKzZ0kjNs8ZjYgSHeib4b5WaB5sgCi1qx2fGsa9rttlUkYzgQjFKmZgJlweLF8QE8gCItrZf2M9yuhBQEUe/OGtWPho5NvHPIqpQohE2dLVpgQnzxNXbjwxlzfZ3yLq9v2djaBbucr6Rbk5dzvc9bUeujaCZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id E18E13EE67
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 08:04:19 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ, v4 6/9] sdp-xml: Optimise parsing large sequences
Date: Wed, 12 Aug 2026 10:01:37 +0200
Message-ID: <20260812080410.2116906-7-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812080410.2116906-1-hadess@hadess.net>
References: <20260812080410.2116906-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: dmFkZTGnQGjbKmJd+Y1MDjSo4aN39TQZ1m7TiiY5swXGq+cBi1hlzlgQeWT5sd4v9pGo2Nult/OOPKFeC13MfhnGyEUlm7mauNaNtYRSeH0HVQvJT6SPmzqJl1RlOB7yVKDhDY5kCqJc0c7WnSfTn3uUh4zzQBNdk9XWciFveg7ufvMNisAUO8qq6QjjOns56rugpCW9OQnsy0EBXkM1hLpdmrTuFKryV78jHsSAizA96ZGrEL2yS9/PqU0nyfqgPjtlqOboqqA3QP7N3a15ICheKLviMZFIh02+gbGL8UUH6STBWhpbmEF7EZx5iFMWSGAhB2nw8OMVROSckGhTcuZ94yRltfrhLxyov3hRSg6TLT+qHkl3REzE/LrcIHUYEV8igJekPSyePxoC+vWGnlryZUHOpMKL01K7wfe8DofF1lz63YJbtfaEmD9GlqGE+V0tcibz5UC2ahlCQ2XmlWoPk75WN9Tq/qJGAL34EA3vo6vB+TFGIvRUs0eihUQpgi/MZvuB8p0SKJmCVylXN/Z6WmU0Vm4OVKG8CoLqTvi1KpXSwUlTIAm5Yr8rBvVByEQXidZcLz9v1cq1agyoMlESchwf0P3GpUFxS9plCaoCh8zbCUCVqiSzLdBh78qoXJe28ByWS9E+bJu17asZfBgl7XDlEwyUTAu9YWBfZDKsppBtSA
X-GND-State: clean

SDP sequences are stored as single-linked lists, so appending members
to a sequence requires finding the tail of the list before the
insertion.

Finding the tail of the list always starts at the beginning of the list,
so takes longer and longer as the list grows bigger.

Keep track of the tail to avoid that problem. This cuts down the
sequence_on_squared() test from around 3 to 4 seconds to less than
0.1 seconds.
---
 src/sdp-xml.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/src/sdp-xml.c b/src/sdp-xml.c
index 816d19611f8b..95431f6ca2dd 100644
--- a/src/sdp-xml.c
+++ b/src/sdp-xml.c
@@ -44,6 +44,7 @@ struct sdp_xml_data {
 	char type;			/* 0 = Text or Hexadecimal */
 	char *name;			/* Name, optional in the dtd */
 	/* TODO: What is it used for? */
+	sdp_data_t *tail;		/* Tail for O(1) dataseq append */
 };
 
 struct context_data {
@@ -609,6 +610,7 @@ static void element_end(GMarkupParseContext *context,
 
 	if (ctx_data->stack_head->next && ctx_data->stack_head->data &&
 					ctx_data->stack_head->next->data) {
+		sdp_data_t *tail;
 		switch (ctx_data->stack_head->next->data->dtd) {
 		case SDP_SEQ8:
 		case SDP_SEQ16:
@@ -616,10 +618,19 @@ static void element_end(GMarkupParseContext *context,
 		case SDP_ALT8:
 		case SDP_ALT16:
 		case SDP_ALT32:
-			ctx_data->stack_head->next->data->val.dataseq =
-				sdp_seq_append(ctx_data->stack_head->next->data->val.dataseq,
-								ctx_data->stack_head->data);
+			tail = ctx_data->stack_head->next->data->val.dataseq ?
+				ctx_data->stack_head->next->tail : NULL;
+			if (tail) {
+				sdp_seq_append(tail,
+					ctx_data->stack_head->data);
+			} else {
+				ctx_data->stack_head->next->data->val.dataseq =
+					sdp_seq_append(NULL,
+						ctx_data->stack_head->data);
+			}
+			ctx_data->stack_head->next->tail = ctx_data->stack_head->data;
 			ctx_data->stack_head->data = NULL;
+			ctx_data->stack_head->tail = NULL;
 			break;
 		}
 
-- 
2.55.0

