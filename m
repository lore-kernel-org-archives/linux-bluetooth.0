Return-Path: <SRS0=dAEe=7O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4F3C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jun 2020 06:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA6A82076B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jun 2020 06:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megamailservers.eu header.i=@megamailservers.eu header.b="WLqrgKuR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgFAGlh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Jun 2020 02:41:37 -0400
Received: from mail152c50.megamailservers.eu ([91.136.10.162]:46036 "EHLO
        mail50c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726107AbgFAGlg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Jun 2020 02:41:36 -0400
X-Greylist: delayed 1375 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Jun 2020 02:41:34 EDT
X-Authenticated-User: 017623705678@o2online.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megamailservers.eu;
        s=maildub; t=1590992304;
        bh=Z/brSrFLhtcIYUkOaSqPdk3J09e7z63WS9a8otPRBMk=;
        h=To:Cc:From:Subject:Date:From;
        b=WLqrgKuRlto5mshAnCOn5suv1QKNMsOVspP3XCXqb9h1QlyU2DJ0XrHmF3ZogqO3O
         BuUVEIso9H7tqpzQf5GPtnWQjh1EYNlXiK+bG5wuMidr7T+FBYIeeoAx4cRPR3c6wS
         LhT6fMivCIPcw3clqZ2fFdgclqkVVNmz2ruamnrY=
Feedback-ID: 017623705678@o2
Received: from [192.168.2.2] (dslb-178-011-017-047.178.011.pools.vodafone-ip.de [178.11.17.47])
        (authenticated bits=0)
        by mail50c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id 0516IL0W011365;
        Mon, 1 Jun 2020 06:18:23 +0000
To:     linux-bluetooth@vger.kernel.org
Cc:     alistair@alistair23.me, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, jwboyer@kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
From:   Tobias Baumann <017623705678@o2online.de>
Subject: Bluetooth part of RTL8723BS
Message-ID: <fb9c3d0e-813e-90f6-2492-c7eaaf0b490d@o2online.de>
Date:   Mon, 1 Jun 2020 08:18:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Antivirus: AVG (VPS 200531-0, 31.05.2020), Outbound message
X-Antivirus-Status: Clean
X-CTCH-RefID: str=0001.0A782F1D.5ED49D48.003F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-VOD: Unknown
X-CTCH-Spam: Unknown
X-CTCH-Score: 0.000
X-CTCH-Rules: 
X-CTCH-Flags: 0
X-CTCH-ScoreCust: 0.000
X-CSC:  0
X-CHA:  v=2.3 cv=NoevjPVJ c=1 sm=1 tr=0 a=cfXdPu6Ul6OsnrHrce2WRQ==:117
        a=cfXdPu6Ul6OsnrHrce2WRQ==:17 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8
        a=oCcaPWc0AAAA:8 a=Dv3bG469tIUHqy_wcw4A:9 a=QEXdDO2ut3YA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=pHzHmUro8NiASowvMSCR:22
        a=nt3jZW36AmriUCFCBwmW:22
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

REF: Linux Firmware commit e6b9001e91110c654573b8f8e2db6155d10d3b57 
<https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/rtl_bt?id=e6b9001e91110c654573b8f8e2db6155d10d3b57>

REF: rtl_bt: Add firmware and configuration files for the Bluetooth part 
of RTL8723BS


Hello Community

Hardware :
  M8S ARM S812 RTL8723BS
ODIS Wintab8 Intel Atom RTL8723BS


I'm working together with Martin (xdarklight) to get the new kernel 
working for older Android Tv boxes with ARM chipset (Amlogic s802 - 
Amlogic S812; Ubuntu , Debian ).

After Martin has successfully integrated the patch for SDIO controller . 
I got my internal Wlan Adapter (RTL8723BS) working.

We are now also activating the Bluetooth part. But we encountered the 
problem with the config file.  Hans was nice enough to extract the 
RTL8723BS firmware file from the Realtek driver file.

As Hans has already written there are almost no differences in the 
tablet area with config file, I can only confirm this after looking at 
different driver files (Realtek bluetooth UART).

I found only 4 ACPI ID : once the already mentioned OBDA:8723 which is 
the default version ,one for ACER tablet OBDA:0623 and the BESTbuy ( 
Chuwi Hi10 ? ) OBDA:0242 ; in the driver version of 2015/2016 there were 
still 2 config files available(standart and ACER) in the version 2017 
only ONE so that also the Default, ACER and BESTbuy use the same config 
files.

I myself and Martin are currently using the two files from the firmware 
repro successfully.

!! So I ask you to remove the ACPI ID from the file and rename the file 
to RTL8723b_config.bin ; furthermore I ask you to set the reference when 
loading the RTL8723BS Blueooth driver to the RTL8723b_firmware.bin so 
that it corresponds to the standard file name. !!!!




-- 
Diese E-Mail wurde von AVG auf Viren geprüft.
http://www.avg.com

