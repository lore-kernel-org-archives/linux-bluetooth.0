Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0C4C38A2D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Oct 2022 08:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiJYIFF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Oct 2022 04:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiJYIFD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Oct 2022 04:05:03 -0400
X-Greylist: delayed 1616 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Oct 2022 01:04:59 PDT
Received: from smtpq4.tb.mail.iss.as9143.net (smtpq4.tb.mail.iss.as9143.net [212.54.42.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BABE2871E
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Oct 2022 01:04:58 -0700 (PDT)
Received: from [212.54.42.106] (helo=smtp2.tb.mail.iss.as9143.net)
        by smtpq4.tb.mail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <fabrizio.ge@tiscalinet.it>)
        id 1onEVc-0007vl-Pt
        for linux-bluetooth@vger.kernel.org; Tue, 25 Oct 2022 09:38:00 +0200
Received: from [192.168.178.171] ([95.96.5.22])
        by smtp2.tb.mail.iss.as9143.net with ESMTPA
        id nEVboOOyKnLZXnEVco8p95; Tue, 25 Oct 2022 09:38:00 +0200
X-Env-Mailfrom: fabrizio.ge@tiscalinet.it
X-Env-Rcptto: linux-bluetooth@vger.kernel.org
X-SourceIP: 95.96.5.22
X-CNFS-Analysis: v=2.4 cv=J6S5USrS c=1 sm=1 tr=0 ts=63579258 cx=a_exe
 a=OsQTkdxsvPZRyRYdxlniGQ==:117 a=OsQTkdxsvPZRyRYdxlniGQ==:17
 a=IkcTkHD0fZMA:10 a=jU4qhlNgAAAA:8 a=l_ntp0G6eeSyGZe4ARwA:9 a=QEXdDO2ut3YA:10
X-Authenticated-Sender: fabbo@ziggo.nl
Message-ID: <5c5d1ce5-0ec5-a29b-a0f6-121703464f54@tiscalinet.it>
Date:   Tue, 25 Oct 2022 09:37:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     linux-bluetooth@vger.kernel.org
From:   Fabrizio Gennari <fabrizio.ge@tiscalinet.it>
Subject: Article on history of the BCSP driver
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfLMGzOgI49yJ29umuZt16f0zGAxwVkHgzP10NCDQMgDccIzkE31VChEvWCbgkb99P3Dmatztst/cuJDF5VWekDd38msE0DQ4zWnQ8WmLfmO5aZ1jmUhC
 he1CX4Y5ICXTyp3XWeYfymz/2JeF5dfj8tAXScnIClgx28kWdhyUrhT8iva/I+jjpbY/ol4p8nIZ74m6kSvfaNZ1vzmhsxnHK1w=
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

long, long time ago, I used to contribute to BlueZ: sent a few patches 
to the libraries, wrote a few man pages (e.g. hciconfig and hcitool), 
and wrote a kernel driver for the BCSP protocol used by CSR devices. In 
occasion of the 20th anniversary of the latter being merged into the 
kernel, I wrote an article about the driver and the context in which it 
was born (including the lab being shut down and its employees being laid 
off shortly after).

Writing it involved digging into the history of mailing lists and Web 
pages. The fact that the archives of the old bluez-users mailing list 
seem to be nowhere did not help.

https://www.linkedin.com/pulse/history-linux-kernel-driver-hcibcspc-fabrizio-gennari 
. Hope you enjoy reading it

Best regards,
Fabrizio

