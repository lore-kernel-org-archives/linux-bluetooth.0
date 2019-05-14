Return-Path: <SRS0=jb0q=TO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251B5C04AB4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 May 2019 09:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9369821473
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 May 2019 09:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=phytec.in header.i=@phytec.in header.b="PLxWvxey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfENJfo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 May 2019 05:35:44 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:55830 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfENJfo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 May 2019 05:35:44 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 May 2019 05:35:43 EDT
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.in; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.in; t=1557825640; x=1560417640;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sA1f8i3PASKtePuhE0MCqJ3LZWpu9MuERm+dUvz9ink=;
        b=PLxWvxeyTrbaWcpoQzaG6XWgIqq1AEKfRXDxVElLwQRZJgz17YrD2NgEHc6Mnpwe
        Oz0P1WH9aGMa+eH7/Z7nLN09xUU6OGHglvQKp0BggFbhLoMlWhx2gKQXFl/Q2YgT
        IUQKdgPeC06sg7rJzy3TOqXtB4bKDbo/jtUrEC3Ym/8=;
X-AuditID: c39127d2-6d5ff70000000df6-08-5cda8868260f
Received: from tumirnix.phytec.de (tumirnix.phytec.de [172.16.0.38])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 2B.5C.03574.8688ADC5; Tue, 14 May 2019 11:20:40 +0200 (CEST)
Received: from [192.168.1.15] ([106.51.130.232])
          by tumirnix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2019051411202949-24 ;
          Tue, 14 May 2019 11:20:29 +0200 
From:   Shaik Mahaboob Nazeer <nazeer.m@phytec.in>
To:     linux-bluetooth@vger.kernel.org
Cc:     Jonas Remmert <j.remmert@phytec.de>
Subject: Issue with mesh provisioning.
Message-ID: <33a1f056-12c2-1aaa-4172-ea1fba341428@phytec.in>
Date:   Tue, 14 May 2019 14:50:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Tumirnix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 14.05.2019 11:20:30,
        Serialize by Router on Tumirnix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 14.05.2019 11:20:30,
        Serialize complete at 14.05.2019 11:20:30
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMLMWRmVeSWpSXmKPExsWyRoBBTTej41aMwb1D8hZzrvUxOzB6fN4k
        F8AYxWWTkpqTWZZapG+XwJXx6NcUloLFShXNl1exNTCuku5i5OCQEDCRWNNX0MXIxSEksIdR
        4uvdx4wQzilGicd9a1i7GDk52AQMJLbOOsgOYosIKEs823eYCcRmFlCXOHJpCViNsICaxMF/
        CxhBbF4BG4nP7z+C1bAIqEqcaDrJAmKLCkRInHm/ggWiRlDi5MwnLCDLJARamSRm/NgN1iAh
        ICRxevFZZogF8hLb385hhln2Z94lKFtc4taT+UwTGAVmIZk1C0nLLCQts5C0LGBkWcUolJuZ
        nJ1alJmtV5BRWZKarJeSuokRGJSHJ6pf2sHYN8fjEKMAB6MSD++LyJsxQqyJZcWVuYcYJTiY
        lUR4oxRvxAjxpiRWVqUW5ccXleakFh9ilOZgURLn3cBbEiYkkJ5YkpqdmlqQWgSTZeLglGpg
        nHux8Uz/d2btvq4b9xP5/fS5qmq3rSp+luLUvbiTQVTBKyTfMHROwewlveliL7qcOsSL+Z8f
        szJp51sqZaMaWsrTLbsqrzdjuzy7NP8LdR2Rxcbllzy61fKYqnzup1ta/lEXmN5WtP16YJ1W
        uH5ou379441zGnLXKYkEvF9yN+jw1eU2N5RYijMSDbWYi4oTAS/bWm1GAgAA
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

hi,

-> We tried Zephyr Mesh onoff example on nrf52 eval kit to test the Mesh Functionality.For provisioning of the node
   we are using meshctl, built from the latest current master of the bluez source.So during the provisioning of the node when we
   start the "meshctl" and run the "discover-unprovisioned on" we are able to get the Device UUID for the provisioning.

   Later when we try to provision the node using the "provision <UUID>" command it initiate the provision and does not wait
   for the user to enter OOB .You can find the log as below.
   /*******************************************/
   $meshctl
   Waiting to connect to bluetoothd...Reading prov_db.json and local_node.json
   from /home/nazeer/.config/meshctl directory
   [meshctl]# discover-unprovisioned on
   SetDiscoveryFilter success
   Discovery started
   Adapter property changed
   [CHG] Controller 00:1B:DC:06:96:17 Discovering: yes
             Mesh Provisioning Service (00001827-0000-1000-8000-00805f9b34fb)
             Device UUID: 81f5d3bd49fa00000000000000000000
             OOB: 0000
   [meshctl]# provision 81f5d3bd49fa00000000000000000000
   Trying to connect Device FA:49:BD:D3:F5:81 Zephyr
   Adapter property changed
   [CHG] Controller 00:1B:DC:06:96:17 Discovering: no
   Connection successful 
   Services resolved yes
   Found matching char: path
   /org/bluez/hci0/dev_FA_49_BD_D3_F5_81/service0010/char0011, uuid
   00002adb-0000-1000-8000-00805f9b34fb
   Found matching char: path
   /org/bluez/hci0/dev_FA_49_BD_D3_F5_81/service0010/char0013, uuid
   00002adc-0000-1000-8000-00805f9b34fb
   Start notification on
   /org/bluez/hci0/dev_FA_49_BD_D3_F5_81/service0010/char0013
   Characteristic property changed
   /org/bluez/hci0/dev_FA_49_BD_D3_F5_81/service0010/char0013
   AcquireNotify success: fd 7 MTU 69
   Notify for Mesh Provisioning Out Data started
   Open-Node: 0x55aca5ac1220
   Open-Prov: 0x55aca5abfb40
   Open-Prov: proxy 0x55aca5ac3d10
   Initiated provisioning
   Characteristic property changed
   /org/bluez/hci0/dev_FA_49_BD_D3_F5_81/service0010/char0011
   AcquireWrite success: fd 8 MTU 69
   GATT-TX:     03 00 10
   GATT-RX:     03 01 04 00 01 00 00 06 00 18 00 00 00
   Got provisioning data (12 bytes)
                01 04 00 01 00 00 06 00 18 00 00 00
   GATT-TX:     03 02 00 00 02 04 06
   GATT-TX:     03 03 76 4a b7 61 52 e1 72 9c b0 cc 95 ad 62 22
   GATT-TX:     8b 65 8f 2a dd 2c 79 a0 ec 5e 8e db a5 65 1b 76
   GATT-TX:     dd cf 63 4d 17 aa a0 a4 ea d4 5e 17 2e a6 18 8e
   GATT-TX:     19 83 56 97 cd c9 81 50 15 ff 47 37 de 92 3a 80
   GATT-TX:     30 64
   [Zephyr]#
  /********************************************/

-> Later we tried to remove the OOB security from the zephyr onoff code and tried to do provisioning again,linux-bluetooth@vger.kernel.org 
   but this time it completely fails to start provisioning.Please find the log as below
  /**********************************/
  meshctl]# provision 81f5d3bd49fa00000000000000000000
  Trying to connect Device FA:49:BD:D3:F5:81 Zephyr
  Adapter property changed
  [CHG] Controller 00:1B:DC:06:96:17 Discovering: no
  Connection successful
  Services resolved yes
  Found matching char: path
  /org/bluez/hci0/dev_FA_49_BD_D3_F5_81/service0010/char0011, uuid
  00002adb-0000-1000-8000-00805f9b34fb
  Found matching char: path
  /org/bluez/hci0/dev_FA_49_BD_D3_F5_81/service0010/char0013, uuid
  00002adc-0000-1000-8000-00805f9b34fb
  Start notification on
  /org/bluez/hci0/dev_FA_49_BD_D3_F5_81/service0010/char0013
  Characteristic property changed
  /org/bluez/hci0/dev_FA_49_BD_D3_F5_81/service0010/char0013
  AcquireNotify success: fd 7 MTU 69
  Notify for Mesh Provisioning Out Data started
  Failed to start provisioning
  Attempting to disconnect from FA:49:BD:D3:F5:81
  Characteristic property changed
  /org/bluez/hci0/dev_FA_49_BD_D3_F5_81/service0010/char0013
  Services resolved no
  [meshctl]#
  /**************************************/

Could you elaborate a little on the status of the current master of bluez in regards to BLE mesh, is it usable or should we look to older versions?

Do you know if there is a common issue while provisioning of the node with the current master and
is there anything that need to be configured before provisioning? 

-- 
Thanks and Regards
