Return-Path: <SRS0=9nD+=7R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819A3C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jun 2020 13:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D202207D8
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jun 2020 13:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYDzk+ok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgFDNHq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Jun 2020 09:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgFDNHq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Jun 2020 09:07:46 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45EDC08C5C0
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2020 06:07:44 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id v79so5831111qkb.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2020 06:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=mYZXTXdIlBM9C3Qe0Mbo4lkm3AD6nXgxP4WiKDC68xs=;
        b=ZYDzk+okDPYbR0BLC2engoM6nE6GOp+DRGPgnN6z07tZJ2ChhgdIrG8HiKJ/8Kzbks
         bFjPBcmTT+cCEa9Wy8Nsk28x6A4LthNjCXoE47ngYLJ95s4f8NKNFqWE9shfW9ULPAFR
         /yjdXXyprQIRQ5eDlnhHZwmlhXZ3LI7IjIKEJOPOaammrFl3QZjRWPmAt0e6sLiff8Bk
         kJKQcZ9h2oBreVWwNPbmM9h/d3MoK3VOMJ6J4l70C41+MM36jAYzaaXo69rTUm//EyS2
         2wSxgQDZmREh+V1HsplR5U1UCFxSWgEa5DuYNdCSs55f7hHwYsR2pfoeSrryUMky4ieA
         jUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=mYZXTXdIlBM9C3Qe0Mbo4lkm3AD6nXgxP4WiKDC68xs=;
        b=CFC+P6au+auevm+IR1F5/ROVdTdvWa5VQmoQ/Sq05rDr7bPe3oU5T1rTWySOXyhPs6
         vK2dzMhaLDH+7Be3QpR3B3kvhbs7dXOSqV3fPu/QG7uN8R0K2MHEUe/eIqtz4p8cCi3T
         6agvqCsvuxcQLS2UR+6i8Skt8VaR338vKGRHWER32lgnD1njp41sEPA3w+f0dCZdkQ7L
         uAGBssIHMFPmErH7dR2J8AfzdQUCXJzAFNPv9MOdAhuOTsybKWH0vHNJRusOM5PQAkH3
         LxhKqNk4p1nNDu7jM2KO5nPdDalYklla7lD8ncVvSC2SzUCWw6Gb8nODYwFNM4cwejHi
         e7Qw==
X-Gm-Message-State: AOAM533fC5ob9FXTvuvMeBEyHklcBqnOa6FA+B/s7RtpTU0LdolCSXxK
        joQWdltyeC3HDLD0eoiXIRbaZ83xJbY=
X-Google-Smtp-Source: ABdhPJzP66OW64+yFscDyZM1U7x/z8Wyk9APJEtBKH/1ZRw3+9IlEiCu9IrV+sOn8ubK7gdgVVnkpw==
X-Received: by 2002:a37:2c05:: with SMTP id s5mr4580521qkh.379.1591276063973;
        Thu, 04 Jun 2020 06:07:43 -0700 (PDT)
Received: from [172.17.0.2] ([52.188.209.39])
        by smtp.gmail.com with ESMTPSA id w26sm4369966qtt.86.2020.06.04.06.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 06:07:32 -0700 (PDT)
Message-ID: <5ed8f214.1c69fb81.14964.6e67@mx.google.com>
Date:   Thu, 04 Jun 2020 06:07:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5012219319050418054=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, d.grigorev@omprussia.ru
Subject: RE: gobex: Fix segfault caused by interrupted transfer
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <a86f93d2d5a946d86bcdccb52218f20a959434cd.camel@omprussia.ru>
References: <a86f93d2d5a946d86bcdccb52218f20a959434cd.camel@omprussia.ru>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5012219319050418054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkpatch Failed

Outputs:
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#15: 
0xecc6eeda in dbus_connection_get_object_path_data () from /usr/lib/libdbus-1.so.3

ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit fatal: bad o ("36dee8bcf29a51e94")'
#33: 
2baea85dec1aebe0b100d4836dee8bcf29a51e94 - Bluetooth: L2CAP ERTM shutdown protect sk and chan

ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit fatal: bad o ("0e80a485b99b7de05")'
#34: 
f65468f6e26c3bd05e642e10e80a485b99b7de05 - Bluetooth: Make __l2cap_wait_ack more efficient

ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit fatal: bad o ("eb9f6d4c2c476043c")'
#35: 
451e4c6c6b3fd1a9f446a10eb9f6d4c2c476043c - Bluetooth: Add BT_DBG to l2cap_sock_shutdown()

ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit fatal: bad o ("cd092485d754964f9")'
#36: 
cb02a25583b59ce48267472cd092485d754964f9 - Bluetooth: __l2cap_wait_ack() use msecs_to_jiffies()

ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit fatal: bad o ("2a5f548dc1f0ef4dc")'
#37: 
e432c72c464d2deb6c66d1e2a5f548dc1f0ef4dc - Bluetooth: __l2cap_wait_ack() add defensive timeout

ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit fatal: bad o ("c2b12b06876f285f0")'
#38: 
e7456437c15a2fd42cedd25c2b12b06876f285f0 - Bluetooth: Unwind l2cap_sock_shutdown()

ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit fatal: bad o ("73f08782870473fa1")'
#39: 
04ba72e6b24f1e0e2221fcd73f08782870473fa1 - Bluetooth: Reorganize mutex lock in l2cap_sock_shutdown()

ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit fatal: bad o ("21a9ddb769523baf2")'
#40: 
9f7378a9d6ced1784e08d3e21a9ddb769523baf2 - Bluetooth: l2cap_disconnection_req priority over shutdown

- total: 8 errors, 1 warnings, 34 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============5012219319050418054==--
