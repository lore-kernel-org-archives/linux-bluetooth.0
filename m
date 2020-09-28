Return-Path: <SRS0=BM5K=DF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F59BC2D0A8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Sep 2020 18:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E3CB207D8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Sep 2020 18:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gn6VzwJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgI1SgF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Sep 2020 14:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgI1SgE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Sep 2020 14:36:04 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB78DC0613CE
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2020 11:36:04 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id a2so1168861qkg.19
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2020 11:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Tn/LaOrUNrdOmh0p1ZC2vQ4GALA/j8S73iPKwqfJSk0=;
        b=gn6VzwJTzwCz4WnSvHdqSzuQPbtGMWNoere2Dw6b9DNwiAPDAUVvHDPKqhPH/5fsd4
         5ATisJl7Xp48B9OWZc7CkK1LcGhxtMk2DkPYtUUvufeJYNbNlbs48LV9aS+yfVpvSPjA
         ZW95HwwT4YPkph9G1DgFKATksCnmflP0btOvCwTfobQilxOcZtNEWtKg+5s2mWnqa5cH
         ZKldlsXzh7mTWafBKg77F+VEMRCnVgS89PERTvTgv3+KLwuH+W+iC9vBPETm4m4z0073
         D7vtJ6elNo2KIgh/qG+MoFqMRl788dRMp5gcnTxdYgDrj39OjfYc++8sJNG1QToxBbC8
         n23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Tn/LaOrUNrdOmh0p1ZC2vQ4GALA/j8S73iPKwqfJSk0=;
        b=BI/BqyIt4TUlnd2xvJhXFG5tjW7EtczdenF9T1GsWlsqSbaJ0hOQFtXMTqtGfeuzrr
         Sq4sCWFBuMPX+F0nWjRjlSRIaURJvp0rxX0IbQ0SEuVxV2WXhLY31KLSGNjhSVlKcMfp
         8upimC9aKF0Fh2WhldQvwjnYEU1slgyPNqsohE2EduOKwH2QB7cluf8HBWewvu43dpEt
         J7zSu5+56uPPFjzK0aJ5am5/nPtn/LPlUnlSg4iepXQsuyphAnqFHFe6dr7UdMHoY8tS
         APDzPESq+iRzsPFfRzbQYjh9iFpsLSYMTQxzW3YUXsa732CbmbAujJQojL2HlmKbB1We
         kJgQ==
X-Gm-Message-State: AOAM530WvfzSy5dQ4biOuaIiKQFRl66fX+ZUlsbOgijjiOZcu1b5n2yf
        xAsh48i3aKrA2BQkm8PATNwx2ByObpScmtEkXWQwhrKmmmRc+kpiwgxnABWpuExVwMfMm/MAqac
        QyK2SH6Q9wFk+SHnQJG7YDVytW5Z9T4bynRxTPJZtPWSpaicDC+pCQD4OTend6OYGFAWqfm6q8s
        KK0gpwMmqnryk=
X-Google-Smtp-Source: ABdhPJzT/rufVmHRab2kYI8sKe5kHbv2ep328NuVYy78uZx5gEvzi7tSiuw5uFah+awbP3/itowaR/0BITCRnoITXA==
Sender: "michaelfsun via sendgmr" 
        <michaelfsun@michaelfsun.mtv.corp.google.com>
X-Received: from michaelfsun.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4a4d])
 (user=michaelfsun job=sendgmr) by 2002:ad4:5006:: with SMTP id
 s6mr748717qvo.51.1601318163786; Mon, 28 Sep 2020 11:36:03 -0700 (PDT)
Date:   Mon, 28 Sep 2020 11:35:59 -0700
Message-Id: <20200928113550.Bluez.1.I229012141d7dab6013840265bc871a2c0712bec9@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [Bluez PATCH] hog: null-check attrib channel at report_map_read_cb
From:   Michael Sun <michaelfsun@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

According to user reported crash dumps, function 'report_map_read_cb'
can pass down a null channel pointer, which will cause a segfault later
at g_io_channel_unix_get_fd upon dereferencing. Add null check to
prevent crashes.

thread #1, stop reason = signal SIGSEGV
frame #0: 0x00007ac089e199f7 libglib-2.0.so.0`g_io_channel_unix_get_fd at giounix.c:655
frame #1: 0x00005cdb60776a52 bluetoothd`bt_io_get_type at btio.c:105
frame #2: 0x00005cdb60777224 bluetoothd`bt_io_get at btio.c:1548
frame #3: 0x00005cdb607706ca bluetoothd`report_map_read_cb at hog-lib.c:993
frame #4: 0x00005cdb60775a60 bluetoothd`read_blob_helper at gatt.c:804
frame #5: 0x00005cdb60775f13 bluetoothd`attrib_callback_result at gattrib.c:273
frame #6: 0x00005cdb607bf30b bluetoothd`can_read_data at att.c:820
frame #7: 0x00005cdb607ca58f bluetoothd`watch_callback at io-glib.c:170
frame #8: 0x00007ac089dda73b libglib-2.0.so.0`g_main_context_dispatch at gmain.c:3182
frame #9: 0x00007ac089ddaa5a libglib-2.0.so.0`g_main_context_iterate at gmain.c:3920
frame #10: 0x00007ac089ddac9f libglib-2.0.so.0`g_main_loop_run at gmain.c:4116
frame #11: 0x00005cdb607ca712 bluetoothd`mainloop_run at mainloop-glib.c:79
frame #12: 0x00005cdb607ca9fe bluetoothd`mainloop_run_with_signal at mainloop-notify.c:201
frame #13: 0x00005cdb607b04bb bluetoothd`main at main.c:969
frame #14: 0x00007ac0894c0ad4 libc.so.6`__libc_start_main at libc-start.c:308
frame #15: 0x00005cdb6074eb0a bluetoothd`_start + 42

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Archie Pusaka <apusaka@chromium.org>
Signed-off-by: Michael Sun <michaelfsun@google.com>
---

 profiles/input/hog-lib.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index e96c969b7755..58d6b556dc9c 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -945,6 +945,7 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	char itemstr[20]; /* 5x3 (data) + 4 (continuation) + 1 (null) */
 	int i, err;
 	GError *gerr = NULL;
+	GIOChannel *io = NULL;
 
 	destroy_gatt_req(req);
 
@@ -988,7 +989,13 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	memset(&ev, 0, sizeof(ev));
 	ev.type = UHID_CREATE;
 
-	bt_io_get(g_attrib_get_channel(hog->attrib), &gerr,
+	io = g_attrib_get_channel(hog->attrib);
+	if (!io) {
+		error("Get channel failed");
+		return;
+	}
+
+	bt_io_get(io, &gerr,
 			BT_IO_OPT_SOURCE, ev.u.create.phys,
 			BT_IO_OPT_DEST, ev.u.create.uniq,
 			BT_IO_OPT_INVALID);
-- 
2.28.0.709.gb0816b6eb0-goog

