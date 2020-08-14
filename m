Return-Path: <SRS0=Aqt4=BY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BE5C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 07:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FACA20771
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 07:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b="B3QqD0b5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgHNHxN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Aug 2020 03:53:13 -0400
Received: from mailrelay.tugraz.at ([129.27.2.202]:60399 "EHLO
        mailrelay.tugraz.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgHNHxM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Aug 2020 03:53:12 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Aug 2020 03:53:11 EDT
Received: from [129.27.228.116] (tug-swl-228-116.tugraz.at [129.27.228.116])
        by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4BSb8q37dmz3x42
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2020 09:46:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
        s=mailrelay; t=1597391163;
        bh=SA8BRs4UvPAdIj12RFtIhXoPxHJyIrccxcow0rqIa9M=;
        h=To:From:Subject:Date;
        b=B3QqD0b5H7+YYEDwTvK+axVJquOfP1FNgBGtFEdDAoQtF1dmFSW5abS+3mD7aSNLH
         9s8Qmbs55UCPnmMcCu7nS7oPGFlBDz3iQzJFEvmFaH2EEc3X9dXn9QUu2sE2unTB4h
         dxjJbI8vAVItuwTuYAVkNjd+m3h/Ym+Z6JDdLbTM=
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
From:   Christian Seifert <christian.seifert@student.tugraz.at>
Subject: [BlueZ] BLE Security Mode 2 Support
Message-ID: <edd02903-6460-76c0-7b96-169c15d42699@student.tugraz.at>
Date:   Fri, 14 Aug 2020 09:46:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: Avast (VPS 200813-8, 13.08.2020), Outbound message
X-Antivirus-Status: Clean
X-TUG-Backscatter-control: 8/uCiIPrZbSKetTI+3UC4A
X-Scanned-By: MIMEDefang 2.74 on 129.27.10.117
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

i am trying to implement a communication channel that uses BLE Security 
Mode 2 Lvl 1 or 2. Both participants that need to communicate are 
Raspberry Pi's running Raspberry Pi OS and BlueZ as Bluetooth Stack. The 
data i want to send is already encrypted which makes Data Signing 
interesting for me.

Does BlueZ Support BLE Security Mode 2 Lvl 1/2 and if yes how can i 
access the functionality?

Furthermore in my research to find the answer for this question i always 
seemed to come across Security Mode 3 mentioned in combination with 
BlueZ. Does this simply refer to Security Mode 1 Lvl 3?

In order to find an answer for this question: I searched the web 
rigorously / Tried to find an answer in forums / Read the Documentation 
/ Tried to read the source code / Checked the archives

As i found nearly nothing regarding this topic my last resort is to ask 
this E-Mail Chain and i would be extremely gratefull if someone would be 
able to answer my question or tip me off into the right direction.

Thank you very much for your time and help in advance!

Best regards,
Christian Seifert

PS: Please excuse my poor Translation attempts as English is not my 
first language. I will gladly try to rewrite any confusing or misleading 
parts in my message if pointed out!

