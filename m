Return-Path: <SRS0=5+i7=ZL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE715C432C3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 16:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F7F222A2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 16:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="w2uRT2N4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbfKSQVx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Nov 2019 11:21:53 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39386 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfKSQVx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Nov 2019 11:21:53 -0500
Received: by mail-pj1-f67.google.com with SMTP id t103so2822845pjb.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Nov 2019 08:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=oacvrEbnemNEWpa/kHdksKf5pPfCFptIEeZDtrmtsi0=;
        b=w2uRT2N4HK2W5wciCauZoHxV4C1VjhN+e0EYIFb0DYAuAkrFzA0lbwYkVpS1Usq5i7
         tYnuiWRL8+KTsZKoFHKuJunXTSQZXDB44Turf7BHd2POEXVj8y6+0REdFHuYaMPpsSqZ
         /z2CedJ1HuaNDSO75wPkH7IzmvWt34GTaAOl8KzHsWA/nUd2J+o55aWysK6Vy5I5c8Vt
         Jz0RETIpqqdkT27DIqOt6woGJD/Nr1pjV+HW0Zq2bczBUJwEgk8oVkDt9GsD8Hptw7JL
         YYoDtM1Ska6W5wlQpcr0/HgixD4+RHNstKlaKE9MP+LjsI9NW1ZXkW0tSZPANRgwp5/J
         F+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=oacvrEbnemNEWpa/kHdksKf5pPfCFptIEeZDtrmtsi0=;
        b=baRlGVcLx1aOiFFpQlULAi4QCLO8nS2xWUtPT0nDuTST2S0vGGmgEZhkS5nMwCOCb8
         n3sybXg20i5r4LbB50L4NxZgjvyNO2Xl8K101TXPQ6iaa3hx4xbsLDCcjpSQa1i2C4lD
         izaw7DbMUukyfjIjbodQWuob05TYq27O+Zb5x71QfvPJOvgXqd7gnJQM+dBnHbSWQdTR
         F/mJtgNa+846d7zImmsDcBvj5SCI3VJufEulVb6R79ITZcOPVIjfl0DjeM++17O2m4tu
         JKUtQMjbp3fKDcgRYkjywmWUYrXR3mws/Ad0BGV4jSt2uBfLAWPHsr4kLycLOK0VbYjt
         TEjw==
X-Gm-Message-State: APjAAAW7E/vixkoZaCut9Pi7WezS9cEBCtflKDSrvepL/h+6IZzuNmYD
        EiMOvo/VhjajnigSu3Y0Sj+B6g5ynOBCyg==
X-Google-Smtp-Source: APXvYqzJ5M2OOEIfPjbbf/1rXKCp36j+wJEggIcxs23y9U2WyNCqrM3UsMsqdiipo1g/9pH31ksHRQ==
X-Received: by 2002:a17:90a:8901:: with SMTP id u1mr7583642pjn.64.1574180511874;
        Tue, 19 Nov 2019 08:21:51 -0800 (PST)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id y123sm25636233pfg.64.2019.11.19.08.21.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 08:21:51 -0800 (PST)
Date:   Tue, 19 Nov 2019 08:21:42 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     linux-bluetooth@vger.kernel.org
Subject: Fw: [Bug 205579] New: rfcomm causes very high cpu usage during
 serial connectivity
Message-ID: <20191119082142.3c838895@hermes.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org



Begin forwarded message:

Date: Tue, 19 Nov 2019 09:52:12 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: stephen@networkplumber.org
Subject: [Bug 205579] New: rfcomm causes very high cpu usage during serial connectivity


https://bugzilla.kernel.org/show_bug.cgi?id=205579

            Bug ID: 205579
           Summary: rfcomm causes very high cpu usage during serial
                    connectivity
           Product: Networking
           Version: 2.5
    Kernel Version: Everything
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: epigramx@yahoo.com
        Regression: No

This appears to be a long standing issue that is mentioned only in old Debian
bug reports and current Raspbian discussions but it remains important for
embedded systems because they are not powerful systems.

Sources:

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=565485
https://www.raspberrypi.org/forums/viewtopic.php?t=181796

Issue Description:

"I use 'rfcomm listen' in combination with 'gpspipe' to relay GPS data
from my eeePC to my Blackberry.  I noticed, however, that the CPU
overhead from 'rfcomm listen' is quite significant -- over 10% on my
eeePC 901.

Running 'strace' reveals that rfcomm is in a tight loop between
'waitpid' (with WNOHANG) and 'ppoll' (with a 200 nanosecond(!!)
timeout).  This is evidently the source of the extreme CPU usage.

If it's critical that rfcomm know the child has died ASAP, I would
expect it should be watching for the SIGCHLD signal rather than trying
to use waitpid().  If it's not all that critical, it probably doesn't
need to be watching for child death at a rate of five millions checks
per second. :)"

also

"I am experimenting with a serial connection to Pi Zero W using the on-board
Bluetooth module. I can successfully establish a connection and send data to
Pi. However as soon as the connection starts, the rfcomm process consumes
almost 50% of the processor (as top shows). This noticeably slows down other
processes."

The issue remains on current code.

-- 
You are receiving this mail because:
You are the assignee for the bug.
