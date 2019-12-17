Return-Path: <SRS0=Cjqc=2H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E24FC43603
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 06:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2C2206B7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 06:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrkoOyPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfLQGgm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Dec 2019 01:36:42 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45004 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfLQGgm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Dec 2019 01:36:42 -0500
Received: by mail-ot1-f66.google.com with SMTP id x3so12345412oto.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Dec 2019 22:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=++C5xazeBTPIwQBG8y8u62HM1MTxVPzhsJS5U679fyI=;
        b=UrkoOyPtNNdnLmvQcgUS0xXtBme+hNmskc7rVVm0zCa0IZYbrdrHNe18bJhEWsxnAH
         eu/6z2s6BOOTi4Qis9dPvedSrcxlTz74Oefab0zqPzRMepW7QJQH5mKvJ00pEBtIgYx8
         Y2YCj4iGVX71nx14q2GiB//OTn5Adz0X9OamfnNKl/i5TSeIzbzXNlYYtfnpSjFPJ+yv
         6rSXVmlNHiavs8u7xhEVh9BHpFLJregtk4bcM1tGBwMU+2SiV8IHJqMAkDyMZEeygLb0
         zu9Au6pkEt7GiLL7TjBnz/yqzQbrPpxrlgn1bfGxb6ugrKc2vZHGW8XOTczh2FA235qm
         /yCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=++C5xazeBTPIwQBG8y8u62HM1MTxVPzhsJS5U679fyI=;
        b=EVTmKrZqnWFCPCMm/SRASqdXrlGzLsT2TfV6Hg2VE2fG7etHmegxIqno4eon+25Unl
         IZmaQEpgHRV/1cOg8Ce/vwI1B8HcTSLTH3tP+Mnwy1Nxzdct4zJpJpMtO5yhP7NLqe9o
         7kcyPnvwlcitMndDdZanI7cM+iHErmPYFFKP+QlbkwGSEufPnjxB5SRmCFli8bh5rkv9
         VMuWqZf8Kz9BXpC4OZlTcpDAu4gyxTd9BGyCYAhw+c5WuMK8VTgELILczUyboUKetzvH
         OPcfYbXxLshMkK9fV/1AxbKdCcN5LEY5kbweaAYjnUHiIEJ277IiFb3bkQePnMkFjyqC
         QFuw==
X-Gm-Message-State: APjAAAXQ3Z8AxAUTzu3wqamZU2vnJbXrbkJkTAXLzxkHPd+KXdRNqSXY
        pepXAdxGir9RmXlDSV1OT5Jr+jdK/gg2ZZgiWk4WE8Uim5OC5w==
X-Google-Smtp-Source: APXvYqzWglOE3jwIgNhXU2As8gYci4zPpWO3X8uHm8fkEFUEv/E9T7sbbwY1+AILp97YARiwwe5jppfpXJSR1j6Wk8I=
X-Received: by 2002:a9d:5c88:: with SMTP id a8mr34109052oti.348.1576564601213;
 Mon, 16 Dec 2019 22:36:41 -0800 (PST)
MIME-Version: 1.0
From:   chethan tn <chethantn@gmail.com>
Date:   Tue, 17 Dec 2019 12:06:30 +0530
Message-ID: <CAMH2TCooGyxiZbhersOCFMHLpjSAqKFq2_XswXx3nt200L-qBQ@mail.gmail.com>
Subject: L2CAP mtu preference set by user space clarification
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        =?UTF-8?B?Y2hldGhhbiDgsprgs4fgsqTgsqjgs40=?= <chethantn@gmail.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        nsathish41@gmail.com, sathish.narasimman@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I would like to understand why the Source device L2CAP mtu is always
set to the remote device mtu during L2CAP connection?

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git/tree/net/bluetooth/l2cap_core.c#n3370
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git/tree/net/bluetooth/l2cap_core.c#n3474



I tried to set the specific MTU for specific profile connection( For
Ex: A2DP connection - PSM  25) patch mentioned below, but the same is
not reflected because of the below code.

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git/tree/net/bluetooth/l2cap_core.c#n3474

Here the patch to set the MTU from the use space bluez.

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 58e1534a4..7d8a718c0 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1573,6 +1573,7 @@ static bool a2dp_server_listen(struct a2dp_server *server)
                                BT_IO_OPT_SOURCE_BDADDR,
                                btd_adapter_get_address(server->adapter),
                                BT_IO_OPT_PSM, AVDTP_PSM,
+                               BT_IO_OPT_OMTU, AVDTP_MTU,
                                BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
                                BT_IO_OPT_MASTER, true,
                                BT_IO_OPT_INVALID);
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 51ead684a..786702cec 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -2394,6 +2394,7 @@ static GIOChannel *l2cap_connect(struct avdtp *session)
                                BT_IO_OPT_DEST_BDADDR,
                                device_get_address(session->device),
                                BT_IO_OPT_PSM, AVDTP_PSM,
+                               BT_IO_OPT_OMTU, AVDTP_MTU,
                                BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
                                BT_IO_OPT_INVALID);
        if (!io) {
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index 621a6e3cf..372b2579d 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h



Can you please suggest what is the best way to set the L2CAP mtu as
user defined.


Thanks

Chethan
