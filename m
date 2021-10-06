Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570B1C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 21:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D80160E05
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 21:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239735AbhJFVjE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Oct 2021 17:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239700AbhJFVjB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Oct 2021 17:39:01 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C398C061746
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Oct 2021 14:37:09 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id q7-20020a17090a2e0700b001a01027dd88so2934543pjd.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Oct 2021 14:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KE0neh7W2V5GWZ4UDb/CSGh4FX+7JJzh6FtEngsLnV8=;
        b=C0BCV93ewJ19tao8ex3FqhSJVsseEyAuak52I4ooBsYuJZX9+QviizehVg4nxWew2z
         DC4ukluusZdOAqXCa1fLkvuvCL4TM2kQBcx1WtFwFu1mWfkNpUtFB+XzO16F03hfWBPq
         2ITXADo/YoTptedtT9eBLIrHBrG8r96BWJ/azZA3ZPyx5jPb2b653uqOgEngjQwc5gpU
         JuyfS94/yjUJH9roeL2G/Lz9GzgoyaF/YDlF8kNTKuUSTqLXaiVPKbvPG3lVRkrUDYkC
         zSkEqpLvqjH/UO0OtPAFTLTf5oKRNRnXKbwrWTZuE0fM/uFaErccxvNqPVkH+KZ6Jxyk
         SHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KE0neh7W2V5GWZ4UDb/CSGh4FX+7JJzh6FtEngsLnV8=;
        b=AeTKxBgyy/J+ICVS6cyXk21AoKERysJO0bdrgpE53PeqGSoj/vilkKdlxLAY+04LeS
         c4gkknRb6hQ56Ls2z0QcfoJ89/leMWpSGKVxesWb7ni2MVs++hXECa7/s65zvUN2Tknq
         N9ZOPHiU/OOyy/8hhyxPfRmpFvbfIBLyS8l2RFsqIj9ONaPHDYxWAdsQYIi1BxU9WZ0X
         ejztHBThO2agbC+9O8rPlsKzPucfzMnlTN6FqslPvr8UKM5aqjW/MgAa2vKJd0K/JmpO
         Kj3nsV+lWhFWd4pQsR62qfLLvBEuhuls+77vn30lFGdaAvXp2u/33UlXbJThfhlUPfam
         aHTQ==
X-Gm-Message-State: AOAM533v2lQI7iV9leozeNbP+b58QbsVePOL8Dtte6+y7OCNAoh5BydO
        8l/U6L3RzQPnzhEE4xqFCf9L60GXM4I=
X-Google-Smtp-Source: ABdhPJxuFar32nelC5IDfEMGaul84I974b6ffCPwDb9BT2zOSlGXqYJg2T+lau0Nce/Qd8z/6qHixA==
X-Received: by 2002:a17:90b:4b48:: with SMTP id mi8mr579653pjb.26.1633556228423;
        Wed, 06 Oct 2021 14:37:08 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e6sm11858763pgf.59.2021.10.06.14.37.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 14:37:08 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] attrib: Make use of bt_att_resend
Date:   Wed,  6 Oct 2021 14:37:03 -0700
Message-Id: <20211006213704.1093265-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211006213704.1093265-1-luiz.dentz@gmail.com>
References: <20211006213704.1093265-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the id != 0 that means that a proceedure that needs multiple PDUs is
in progress so use bt_att_resend with its id that way the bt_att id and
gattrib shall always be the same.
---
 attrib/gattrib.c | 95 +++++++++++-------------------------------------
 1 file changed, 22 insertions(+), 73 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index bc7d4f22c..270a37ebe 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -41,13 +41,8 @@ struct _GAttrib {
 	struct queue *track_ids;
 };
 
-struct id_pair {
-	unsigned int org_id;
-	unsigned int pend_id;
-};
-
 struct attrib_callbacks {
-	struct id_pair *id;
+	unsigned int id;
 	GAttribResultFunc result_func;
 	GAttribNotifyFunc notify_func;
 	GDestroyNotify destroy_func;
@@ -56,32 +51,6 @@ struct attrib_callbacks {
 	uint16_t notify_handle;
 };
 
-static bool find_with_org_id(const void *data, const void *user_data)
-{
-	const struct id_pair *p = data;
-	unsigned int orig_id = PTR_TO_UINT(user_data);
-
-	return (p->org_id == orig_id);
-}
-
-static struct id_pair *store_id(GAttrib *attrib, unsigned int org_id,
-							unsigned int pend_id)
-{
-	struct id_pair *t;
-
-	t = new0(struct id_pair, 1);
-	if (!t)
-		return NULL;
-
-	t->org_id = org_id;
-	t->pend_id = pend_id;
-
-	if (queue_push_tail(attrib->track_ids, t))
-		return t;
-
-	return NULL;
-}
-
 GAttrib *g_attrib_new(GIOChannel *io, guint16 mtu, bool ext_signed)
 {
 	gint fd;
@@ -150,9 +119,6 @@ static void attrib_callbacks_destroy(void *data)
 	if (cb->destroy_func)
 		cb->destroy_func(cb->user_data);
 
-	if (queue_remove(cb->parent->track_ids, cb->id))
-		free(cb->id);
-
 	free(data);
 }
 
@@ -182,7 +148,7 @@ void g_attrib_unref(GAttrib *attrib)
 	bt_att_unref(attrib->att);
 
 	queue_destroy(attrib->callbacks, attrib_callbacks_destroy);
-	queue_destroy(attrib->track_ids, free);
+	queue_destroy(attrib->track_ids, NULL);
 
 	free(attrib->buf);
 
@@ -295,7 +261,6 @@ guint g_attrib_send(GAttrib *attrib, guint id, const guint8 *pdu, guint16 len,
 	struct attrib_callbacks *cb = NULL;
 	bt_att_response_func_t response_cb = NULL;
 	bt_att_destroy_func_t destroy_cb = NULL;
-	unsigned int pend_id;
 
 	if (!attrib)
 		return 0;
@@ -317,62 +282,47 @@ guint g_attrib_send(GAttrib *attrib, guint id, const guint8 *pdu, guint16 len,
 
 	}
 
-	pend_id = bt_att_send(attrib->att, pdu[0], (void *) pdu + 1, len - 1,
-						response_cb, cb, destroy_cb);
-
-	/*
-	 * We store here pair as it is easier to handle it in response and in
-	 * case where user request us to use specific id request - see below.
-	 */
 	if (id == 0)
-		id = pend_id;
+		id = bt_att_send(attrib->att, pdu[0], (void *) pdu + 1,
+					len - 1, response_cb, cb, destroy_cb);
+	else {
+		int err;
+
+		err = bt_att_resend(attrib->att, id, pdu[0], (void *) pdu + 1,
+					len - 1, response_cb, cb, destroy_cb);
+		if (err)
+			return 0;
+	}
+
+	if (!id)
+		return id;
 
 	/*
 	 * If user what us to use given id, lets keep track on that so we give
 	 * user a possibility to cancel ongoing request.
 	 */
-	if (cb)
-		cb->id = store_id(attrib, id, pend_id);
+	if (cb) {
+		cb->id = id;
+		queue_push_tail(attrib->track_ids, UINT_TO_PTR(id));
+	}
 
 	return id;
 }
 
 gboolean g_attrib_cancel(GAttrib *attrib, guint id)
 {
-	struct id_pair *p;
-
 	if (!attrib)
 		return FALSE;
 
-	/*
-	 * If request belongs to gattrib and is not yet done it has to be on
-	 * the tracking id queue
-	 *
-	 * FIXME: It can happen that on the queue there is id_pair with
-	 * given id which was provided by the user. In the same time it might
-	 * happen that other attrib user got dynamic allocated req_id with same
-	 * value as the one provided by the other user.
-	 * In such case there are two clients having same request id and in
-	 * this point of time we don't know which one calls cancel. For
-	 * now we cancel request in which id was specified by the user.
-	 */
-	p = queue_remove_if(attrib->track_ids, find_with_org_id,
-							UINT_TO_PTR(id));
-	if (!p)
-		return FALSE;
-
-	id = p->pend_id;
-	free(p);
-
 	return bt_att_cancel(attrib->att, id);
 }
 
 static void cancel_request(void *data, void *user_data)
 {
-	struct id_pair *p = data;
+	unsigned int id = PTR_TO_UINT(data);
 	GAttrib *attrib = user_data;
 
-	bt_att_cancel(attrib->att, p->pend_id);
+	bt_att_cancel(attrib->att, id);
 }
 
 gboolean g_attrib_cancel_all(GAttrib *attrib)
@@ -380,9 +330,8 @@ gboolean g_attrib_cancel_all(GAttrib *attrib)
 	if (!attrib)
 		return FALSE;
 
-	/* Cancel only request which belongs to gattrib */
 	queue_foreach(attrib->track_ids, cancel_request, attrib);
-	queue_remove_all(attrib->track_ids, NULL, NULL, free);
+	queue_remove_all(attrib->track_ids, NULL, NULL, NULL);
 
 	return TRUE;
 }
-- 
2.31.1

