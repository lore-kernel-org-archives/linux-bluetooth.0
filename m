Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EC1C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Nov 2022 16:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240052AbiKQQSb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 11:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbiKQQS1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 11:18:27 -0500
X-Greylist: delayed 523 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Nov 2022 08:18:22 PST
Received: from hmr112.pwrz.at (hmr112.pwrz.at [194.30.191.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EBD786F9
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 08:18:22 -0800 (PST)
Received: from srv345.pwrz.at (unknown [10.10.30.15])
        by hmr112.pwrz.at (Postfix) with ESMTP id 28C48402E4
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 17:09:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by srv345.pwrz.at (Postfix) with ESMTP id 04048D21D5;
        Thu, 17 Nov 2022 17:09:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at pwrz.at
Received: from srv345.pwrz.at ([127.0.0.1])
        by localhost (srv345.pwrz.at [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UY85BUYg1-ZB; Thu, 17 Nov 2022 17:09:31 +0100 (CET)
Received: from srv557.sprz.at (srv557.sprz.at [80.122.189.88])
        by srv345.pwrz.at (Postfix) with ESMTP id 9C5A8D176D
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 17:09:31 +0100 (CET)
Received: from [192.168.2.139] (unknown [80.243.174.92])
        by srv557.sprz.at (Postfix) with ESMTPSA id 481F2E20605
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 17:09:31 +0100 (CET)
Message-ID: <92dfa5c7-90db-8100-b481-2bd4972a0ec1@voxel.at>
Date:   Thu, 17 Nov 2022 17:09:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
From:   Simon Vogl <simon@voxel.at>
Subject: Connecting to a BR/EDR+BLE device a via dbus?
To:     linux-bluetooth@vger.kernel.org
Content-Language: it
Organization: VoXel Interaction Design
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <166870137165.43692.6116230956194055906@srv557.sprz.at>
X-PPP-Vhost: voxel.at
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear all,

we are communicating with a headset-ish device that offers classic 
bluetooth services and BLE characteristics in parallel.

We have code to talk to the Bluetooth classic part via bluetoothd/dbus, 
and we have code for talking to the BLE parts based on the C-library / 
gatt-client code ; both run in parallel for some time but not 
super-stable, so I'd like to move the code over to a dbus version.

As the device starts advertising BLE characteristics only after a 
classic connection has been established, it appears as a Bluetooth 
classic device on the system bus, and I did not find a way to start GATT 
discovery via the 'official' dbus-API.

I don't fear to tweak bluetoothd nor ~ctl, but would like to know if 
someone already some development going in that direction?

Simon

-- 

VoXel Interaction Design  |www.voxel.at
DI Dr.techn. Simon Vogl   |simon@voxel.at
Tomaschekweg 46           |  +43 650 2323 555
A-4040 Linz - Austria     |
Office address: Industriezeile 35, 4020 Linz (2nd floor)

