Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EB2C43217
	for <linux-bluetooth@archiver.kernel.org>; Sun, 12 Dec 2021 05:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhLLFlB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 12 Dec 2021 00:41:01 -0500
Received: from relay.wiredblade.com ([168.235.105.136]:54289 "EHLO
        relay.wiredblade.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbhLLFlA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 12 Dec 2021 00:41:00 -0500
dkim-signature: v=1; a=rsa-sha256; d=relay.compata.com; s=mail;
        c=relaxed/relaxed; q=dns/txt; h=From:Reply-To:Subject:Date:Message-ID:To:MIME-Version:Content-Type;
        bh=eZSJd1eJPcNUK8fAKQGnrXr73p9G43NdcKGG6LJz2mQ=;
        b=q1kWGE7fpm2pDsFiwQMRkXFx7AatFLSbC0JOrMIOh8xxlGhgZ2Ubu2+EaXO+UuUz4QoXXD0448NtlWRck2EBd/J6Ga66sIzwy5qC5aKxCxbZ1+Rpa52K0zmK+Ai/fLH0OfcafQOvpGfqfmI3t0HK96o+jbs3ByTYaIYqZscn2q1n30TPwgIdXknjfSPLYHL7YPxlnVlyDMJUjLN1aoGNrY9ZCegf35XtFAGmJiRoAk/HVcfHutRkCkB/Kz
        SmGrB3TAt8GzO+HQQHsxYHjGF5J40zeNwqnlUKF9rsSYjV10Is8uQXzUqIQvqiXgcGCGPW2e+LbL9x5QPH08Yy/cuHtA==
Received: from compata.com (ip68-5-142-19.oc.oc.cox.net [68.5.142.19]) by relay.wiredblade.com
 with ESMTPSA (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256)
 ; Sun, 12 Dec 2021 05:40:58 +0000
Received: from d7010.compata.com ([192.168.44.19]) by compata.com (8.16.1/8.16.1) with
 ESMTP id 1BC5evbU710558 for <linux-bluetooth@vger.kernel.org>; Sat, 11 Dec
 2021 21:40:58 -0800
Received: from d7010 (localhost [127.0.0.1]) by d7010.compata.com (8.16.1/8.15.2) with
 ESMTP id 1BC5evj82621220 for <linux-bluetooth@vger.kernel.org>; Sat, 11
 Dec 2021 21:40:57 -0800
Message-Id: <202112120540.1BC5evj82621220@d7010.compata.com>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7.1
To:     linux-bluetooth@vger.kernel.org
reply-To: linux-bluetooth@vger.kernel.org
Subject: Reconciling hcidump output with btmon
From:   Dave Close <dave@compata.com>
X-Face: $?&5f7w4GjUJOb-[FmngebA}V`5Dv)QEdHg|d%mytVRm]'o}*{J6:PP%(LfN
 LmOcb#>"^wDF*|ZzuS??S*vLH[.miV(<v!QArMJG;~Mx<jl!LQ3)Gy9xw7w!EBQx9H~*[
 *XF#\wyQK,dciSN=F_gd#{`rb43?hn5C9I&@Q2C+epIAS
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Sat, 11 Dec 2021 21:40:57 -0800
X-Scanned-By: MIMEDefang 2.85 on 192.168.44.23
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When I run "hcidump -R", I see (among other output) lines like these,

  > 04 3E 26 02 01 03 01 69 57 93 F1 99 F8 1A 02 01 04 09 09 39
    36 37 35 39 39 38 46 07 16 09 18 EB 03 00 FE 04 16 0F 18 3E
    A5

But trying every available option for "btmon", I can't find anything
remotely similar. How can I get this information using "btmon"? Or can
I -- does "btmon" show this type of information? Is there some other
command that would be more appropriate?

I understand that "hcidump" has been deprecated for several years. Yet
the output of "btmon" seems to imply that it is calling "hcidump". That
doesn't make sense to me. For example,

  @ RAW Open: hcidump (privileged) version 2.22 {0x0002} [hci0] 1.894682
  @ RAW Open: hcidump (privileged) version 2.22 {0x0003} 1.894702
  @ RAW Close: hcidump                          {0x0003} 1.894708
  @ RAW Close: hcidump                          {0x0002} [hci0] 1.894718

My system is running Fedora 34 with these packages:

  bluez-5.62-2.fc34.x86_64 (includes /usr/bin/btmon)
  bluez-deprecated-5.62-2.fc34.x86_64 (includes /usr/bin/hcidump)
  bluez-hcidump-2.5-18.fc34.x86_64 (includes /usr/sbin/hcidump)
-- 
Dave Close, Compata, Irvine CA      "Curiosity is insubordination
dave@compata.com, +1 714 434 7359    in its purest form."
dhclose@alumni.caltech.edu             -- Vladimir Nabokov


