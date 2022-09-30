Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7C0C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Sep 2022 19:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiI3TKi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Sep 2022 15:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiI3TKh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Sep 2022 15:10:37 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2139.outbound.protection.outlook.com [40.107.20.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC2B4D242
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 12:10:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHA/tEQHtKSn5iCKi5vKpM8sCX2aSsOpw7QzASi1eCeeTcuxRB8sHCWG+/BgbcqrfOBKHE8gj1Kv48I+W38jdkkye5k1Ia87AUQB0lDjtQxatIMEn1us/QPjk9iN6X1/6GndfmfuPN20HdrHaK5u5tnV7y6fVOWzXc94g/GenmcL57UYiBKF4rGfHS4SacF2GEZ5ZQwMAJH2mcg8lTYE79jeDLv7Zw7JbnvAYvF/zr9KiDLj7Iw6BJwdXzNrP3UEwtX1e1BIPW7aH1VrnCzlfhdUWlcehFVtI1VE875rMWX9egpSfyWJa8CtoJjELLjIK3A/5LLJTpGmtHF86xwZ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALJfyLaMBZ8H3gHKfvqo6T3TOuXC6rsG/MBUiL28T0E=;
 b=Nkre7MRu7MKw8I4zmfWkQhCbbvFppLf1kqhWQXTnCBuKrK1WFR6QI4Y6v0SAeifdFEVDUAMsWqtWs93W2vRICJl0RfveGDJUuSJkbIUnYAcB9l3kTIFSQ6hMcA+DtSO2DVVC1hFPEpMrHUMo8fAeJzA0f30Ic7+o1rsugFmP1Ki8jry9S4wnmmSMz/VzAGn5K1YlMDTlkyNBDrD1bZEwiT3eSVFS+9SfgPaBhZD9Pdc7/+VfjA4iHe7GQV2sQpkX52aDc6vt9wafjx7auNOqfAPbaHn3CMeOUIb3BsRo/OemTDZKGZasz2Ivwdgsel0xepdhFDNkB2f4XajS3gfUaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALJfyLaMBZ8H3gHKfvqo6T3TOuXC6rsG/MBUiL28T0E=;
 b=aI/SyG/hth0/7hbDjDGmhBSlPh/+bWP2IvIBCqr2DCti4ATX0PtQDKs8lS3+ACUvTlrK4ArxKHJb/JPvTyxNBk+fd7Ddd7KQqLWtICCDT7Imp9K34YeHNCDmNZdKHRnJtAN3zijrwcF30a2IdgxD48uJTzJMPHYJbJAKJBIbBoM=
Received: from GVX0EPF000013DB.SWEP280.PROD.OUTLOOK.COM (2603:10a6:144:1::14)
 by DB8PR07MB6347.eurprd07.prod.outlook.com (2603:10a6:10:134::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Fri, 30 Sep
 2022 19:10:30 +0000
Received: from HE1EUR02FT101.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e05::202) by GVX0EPF000013DB.outlook.office365.com
 (2603:1026:900:2::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.22 via Frontend
 Transport; Fri, 30 Sep 2022 19:10:30 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 HE1EUR02FT101.mail.protection.outlook.com (10.152.11.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Fri, 30 Sep 2022 19:10:29 +0000
Received: from n95hx1g2.localnet (192.168.54.45) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 30 Sep
 2022 21:10:29 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-bluetooth@vger.kernel.org>
Subject: bluetoothctl: Connecting to a GATT service using BR/EDR
Date:   Fri, 30 Sep 2022 21:10:28 +0200
Message-ID: <1906152.PYKUYFuaPT@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.45]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR02FT101:EE_|DB8PR07MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: 070d5804-8e41-4e6b-1b20-08daa31770db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2WhTy7Tij6PHVzXDc6/lfN1pSG+ZF6iHKvZ9se5f5bUInJm8RVFF+bsmf2QNqjewX9RazAX1o3hKKIQNOlZdPjA2ZXV1Wcx9i99Ueb49tUPta1YeXc31VRQYdx+21MsL71J+Fp29TxEsh1dBdn4KT9XDOP8uFPrvO76/mgf61ihCnPMXL5sKkC2e3101UErdt4tpGYgQvlHEakWCSfaPlxtSxIVrQiGNjvjnAjD7fQXsdAb2NM/LelAbP4fV2iCkb9nKAJv916BlazyCvdC16PU6KhHh2N/bSC4gWPtzEeqiFziNJn/MMloW3Th/449nj+i86NUvTBLY57hzkra+WO0vRTEdpruxZEYLvAPi8xht7IntCETOwfY0ujWUKZS872HJ14yeZzh6oSnwOA0v18GIxFo8CVKaxtyYUx3/vhP31ClyKZV4JZ1v5WgbObK/0p0HytjEbB9ZI0g6uOf0+4YvJxcSUuBIVgPhjatbhvFvK61eQ3VfyonKJXeH6LEB0DM/6I2Ao5ob3MfctLP7as0QFDfffQ/3M7kJOdHFriE1YRX1xZr2/wqQmU4oFtBTpTVI56HLBi191MFgSYYvufdkoOkWVhfj1cKRXCqSDjiGX97xR5H4Oia1WZa1wNFygfEk6BH0OpgLPtpWp/8VgS8beY4YnfsmZQFMigCwTtzbRTWEf1abvlPdJaoj67XIeugdBJRSUVNviF88yPrxNNGlUFtQUX7ebDiAp+peANDeXi91i7mvE4w6QxH3flQJWQAspZXVmx5qw7780xKhgA==
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199015)(36840700001)(46966006)(316002)(478600001)(6916009)(36916002)(41300700001)(8676002)(336012)(9686003)(86362001)(70206006)(70586007)(5660300002)(26005)(2906002)(47076005)(82740400003)(16526019)(186003)(40480700001)(426003)(8936002)(36860700001)(81166007)(82310400005)(356005)(33716001)(9576002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 19:10:29.8548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 070d5804-8e41-4e6b-1b20-08daa31770db
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT101.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6347
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I am trying to connect to a GATT server using bluetoothctl.

HW: dual mode adapters (server+client)
SW: bluez-5.65


1st try: "simply connect" (BR/EDR + LE enabled)
-------------------------------------
[bluetooth]# connect 5C:F3:70:A3:94:E7
Attempting to connect to 5C:F3:70:A3:94:E7
[CHG] Device 5C:F3:70:A3:94:E7 TxPower: 0
[CHG] Device 5C:F3:70:A3:94:E7 Modalias: usb:v1D6Bp0246d0541
[CHG] Device 5C:F3:70:A3:94:E7 UUIDs: 00001823-0000-1000-8000-00805f9b34fb  <-- HTTP Proxy Service
[CHG] Device 5C:F3:70:A3:94:E7 UUIDs: 00001800-0000-1000-8000-00805f9b34fb
[CHG] Device 5C:F3:70:A3:94:E7 UUIDs: 00001801-0000-1000-8000-00805f9b34fb
[CHG] Device 5C:F3:70:A3:94:E7 UUIDs: 0000180a-0000-1000-8000-00805f9b34fb
[CHG] Device 72:DF:6C:03:4A:6A RSSI: -81
[CHG] Device 5C:F3:70:A3:94:E7 ServicesResolved: yes
Failed to connect: org.bluez.Error.NotAvailable br-connection-profile-unavailable
[CHG] Device 5C:F3:70:A3:94:E7 ServicesResolved: no
[CHG] Device 5C:F3:70:A3:94:E7 Connected: no

ok, it looks I need a profile for making a BR/EDR connection ...


2nd try: register profile beforehand (BR/EDR + LE enabled)
-------------------------------------
[bluetooth]# menu gatt
[bluetooth]# register-application 00001823-0000-1000-8000-00805f9b34fb
Application registered
[bluetooth]# menu back
[bluetooth]# connect 5C:F3:70:A3:94:E7
Attempting to connect to 5C:F3:70:A3:94:E7
[CHG] Device 5C:F3:70:A3:94:E7 Connected: yes
[CHG] Device 5C:F3:70:A3:94:E7 UUIDs: 00001200-0000-1000-8000-00805f9b34fb
[CHG] Device 5C:F3:70:A3:94:E7 UUIDs: 00001800-0000-1000-8000-00805f9b34fb
[CHG] Device 5C:F3:70:A3:94:E7 UUIDs: 00001801-0000-1000-8000-00805f9b34fb
[CHG] Device 5C:F3:70:A3:94:E7 UUIDs: 0000180a-0000-1000-8000-00805f9b34fb
[CHG] Device 5C:F3:70:A3:94:E7 UUIDs: 00001823-0000-1000-8000-00805f9b34fb
[CHG] Device 5C:F3:70:A3:94:E7 ServicesResolved: yes
Failed to connect: org.bluez.Error.Failed br-connection-not-supported
[CHG] Device 5C:F3:70:A3:94:E7 ServicesResolved: no
[CHG] Device 5C:F3:70:A3:94:E7 Connected: no

Unfortunately the created GATT profile doesn't provide a connect() method ...


What is the intended procedure for connecting to a GATT server over
a BR/EDR link? The "connect" command works fine after disabling BR/EDR
using btmgmt, but this is not what I wanted.

regards,
Christian



