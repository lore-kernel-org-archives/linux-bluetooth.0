Return-Path: <SRS0=CXZ/=PT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59323C43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jan 2019 13:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C412133F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jan 2019 13:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732566AbfAKNHd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:07:33 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:44850 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732564AbfAKNHd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Jan 2019 08:07:33 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 586992984D
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jan 2019 13:07:32 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 4966B2986B; Fri, 11 Jan 2019 13:07:32 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 202213] bluez trunk tests fail with GCC 9 (or with
 -fsanitize=address with GCC 9)
Date:   Fri, 11 Jan 2019 13:07:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mliska@suse.cz
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-202213-62941-y8A00ZXH3M@https.bugzilla.kernel.org/>
In-Reply-To: <bug-202213-62941@https.bugzilla.kernel.org/>
References: <bug-202213-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=202213

--- Comment #7 from Martin Liška (mliska@suse.cz) ---
The test works for me with:

diff --git a/unit/test-sdp.c b/unit/test-sdp.c
index 5a50cbbf1..ebe00571d 100644
--- a/unit/test-sdp.c
+++ b/unit/test-sdp.c
@@ -59,14 +59,14 @@ struct test_data {
 #define raw_pdu(args...) \
        {                                                       \
                .valid = true,                                  \
-               .raw_data = raw_data(args),                     \
+    .raw_data = g_memdup(raw_data(args), sizeof(raw_data(args))), \
                .raw_size = sizeof(raw_data(args)),             \
        }

 #define raw_pdu_cont(cont, args...) \
        {                                                       \
                .valid = true,                                  \
-               .raw_data = raw_data(args),                     \
+    .raw_data = g_memdup(raw_data(args), sizeof(raw_data(args))), \
                .raw_size = sizeof(raw_data(args)),             \
                .cont_len = cont,                               \
        }
@@ -104,7 +104,7 @@ struct test_data_de {
 #define define_test_de_attr(name, input, exp) \
        do {                                                            \
                static struct test_data_de data;                        \
-               data.input_data = input;                                \
+               data.input_data = g_memdup(input, sizeof (input));             
                \
                data.input_size = sizeof(input);                        \
                data.expected = exp;                                    \
                tester_add("/sdp/DE/ATTR/" name, &data, NULL,           \

thanks for help.

-- 
You are receiving this mail because:
You are the assignee for the bug.
