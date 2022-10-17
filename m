Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83832C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Oct 2022 14:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiJQO4K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Oct 2022 10:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiJQOy4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Oct 2022 10:54:56 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2095.outbound.protection.outlook.com [40.107.21.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727D249B69
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Oct 2022 07:54:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oo+7xYTjWUX8czZjcbMwF4s1lcLuDi3I5GJjwZzq3xFgl5GLs/zp2ZM2v7mCh+3fbM2L6fgvmN9zYlXCONcwIlVcf+/d6BdKacrLjk/vSyN8IVhOwXV5vFcbaY12fLhDDmHH9I/DDXVQWuuXVaHEdjCPv1VcfpcsW6p4dChFswSCkYnMt9jFrMwZ8mrv45r4yRZKZdBwsjynTMDnRZ63rvbY3WHFA1hhyukXtqe4sCbXgoUHh6WmhJ9eDNypYX800FnQJw2ZtgKUtk11oqV+QMSjWDdW0KctNE54tMSoBaEAfXwhSyj7NUyV6FXFAzW3G/KyvJS3g4CURxoBadgFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ygO2TWO7BGxRW8w4DoHOsvHuUdOSZbY4g7/Wdq+Hv0=;
 b=VTbSMfb0dsia1ZGDvR0T6ozOXRe1iYl5erFVZviJyzUjXCIgU/swaFOAG8YwmRcTxXEN/nSzcOvbJpHPm/LDTf5n2JS4QgWiLsQgfOS8q/4bBQbaR9z0IWVEwjcKR8nUIDORMCvDDqFxztxmoA16FPcWYFsx6TKoYwKe5IwpoV8hLKqqaqaitMObOZm5Q8Ng/8nOUXKW6IPYmxpUKQ3cT8y0nSCEI1zhqRdKCvc+olRBhfTTpJpIf8xS2Yd6xh4GWrKg31sp3LzpvOKPHSwPNBPDBx9vlzzK5MpfGN0lYUuVdYtUB1ECfvAkHQ9qnZhp1LRIJc1dWMbe4prdZ+xnDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ygO2TWO7BGxRW8w4DoHOsvHuUdOSZbY4g7/Wdq+Hv0=;
 b=eO5/3qr013mYDEBWYDyjGaLZojVJ5mTPdxWfs0iRmTiMq6ajb5DXtEaDezVy4aAQU6Gnb9LesPArpEQ1Cr0SrTinPu6vndvAwdMFMPiGUEeqGwtwwKgqqiqDKGt8lPs2AlT6Ud28op3dIh2H+JgaHorsLcnH25iE4v8clfhkyf0=
Received: from AS8P251CA0011.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:2f2::31)
 by AS8PR07MB8325.eurprd07.prod.outlook.com (2603:10a6:20b:440::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Mon, 17 Oct
 2022 14:54:05 +0000
Received: from AM0EUR02FT017.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:2f2:cafe::1c) by AS8P251CA0011.outlook.office365.com
 (2603:10a6:20b:2f2::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Mon, 17 Oct 2022 14:54:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM0EUR02FT017.mail.protection.outlook.com (10.13.54.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 14:54:05 +0000
Received: from n95hx1g2.localnet (192.168.54.96) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.32; Mon, 17 Oct
 2022 16:54:04 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-bluetooth@vger.kernel.org>
Subject: Support for Data Length Extension (DLE)?
Date:   Mon, 17 Oct 2022 16:54:04 +0200
Message-ID: <2264504.ElGaqSPkdT@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.96]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0EUR02FT017:EE_|AS8PR07MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b3d229d-ec17-4163-0a72-08dab04f6fe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hhxe/D3dC1h/gGos9urtcdcKHUK2pcZI33G4q62MW8dg2lQtgrNdJct8zMlUqSGAl2s7MHSFU4nrPr2YPp7/nBieEX3S0asJFqqJPURlbd9jHrexzsXFKkRRhMHrdCq0cXn6S6abTTqWiw3dUFjEyHggOmgX5Y4YnLSYJbelgaw/q/1yR9bWzVsxEacd2bREhPRoGn/8OI3sTCyHsGO0euzErv7DS2Ytp3ZMLwDszJX9XjmQL0AoufxJ0xD0nOwXMc+fCPn2/N20C4BJrCgaNrNqYgtFrXrqivbb0JJJ3KvUHcpO1UhNJ6nYit+uxMrVX7+gr7Gnee+hERy+ITpUHDu39mTjZag4BE+HXWowIWMCI7f/DFI+EkUDRG5lLF7WOAHu7ZPePesRWs0oNNXNo0FsP4tSCNKyJ47Jt/EDuZJa0OKrWcddZm5bQt9sPdFaZh1qXgxLs2g70sLZs5lazS9LMokXfUY0xAvhcoBd9ueiyDN6Be2i2uaY/24QcWq3jqu5xaPFNFEzVLk+PtraSi4XDCbi0dGLE8+y7A3FDnAsgzTgUFJPYZ/+sQSNooLZY97Iz23c2Zrl7xkNqFKu13vNQVdm3c0Q00+2SkNbB15FmCwLVBj6ldaZaurFbquXi/btvsJ5n46MvlaNkRJoSS8VK/DFtliaQYD5AGz4hb8IfKwgYbFpHyGq09RfdBP9H3R8k2wph/xXA50X9z5CI9BXlC2pm20c+iuYnlDLjxJeglURh7u6yOK/zis35MGOQlM1uFVUaPE/Vb1K+yOY5w==
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199015)(36840700001)(46966006)(186003)(40480700001)(26005)(36916002)(9686003)(82740400003)(336012)(2906002)(426003)(47076005)(16526019)(8676002)(8936002)(33716001)(41300700001)(70206006)(70586007)(86362001)(9576002)(356005)(81166007)(316002)(82310400005)(5660300002)(6916009)(478600001)(36860700001)(83380400001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 14:54:05.1736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3d229d-ec17-4163-0a72-08dab04f6fe0
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: AM0EUR02FT017.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8325
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When monitoring a Bluetooth connection between two Linux systems
(kernel 5.14 / 5.15 + bluez-5.65), I noticed the following:

> HCI Event: LE Meta Event (0x3e) plen 12                                                                                                                          #21108 [hci0] 1650.255887
      LE Read Remote Used Features (0x04)
        Status: Success (0x00)
        Handle: 25 Address: 00:1A:7D:F0:21:40 (OUI 00-1A-7D)
        Features: 0xbd 0x5f 0x66 0x00 0x00 0x00 0x00 0x00
...
          LE Data Packet Length Extension
...

> ACL Data RX: Handle 25 flags 0x02 dlen 18                                                                                                                        #21109 [hci0] 1650.300224
      LE L2CAP: LE Connection Request (0x14) ident 1 len 10
        PSM: 128 (0x0080)
        Source CID: 64
        MTU: 672
        MPS: 23
        Credits: 30
< ACL Data TX: Handle 25 flags 0x00 dlen 18                                                                                                                        #21110 [hci0] 1650.300431
      LE L2CAP: LE Connection Response (0x15) ident 1 len 10
        Destination CID: 64
        MTU: 672
        MPS: 23
        Credits: 30
        Result: Connection successful (0x0000)
...
> HCI Event: LE Meta Event (0x3e) plen 11                                                                                                                          #21113 [hci0] 1650.345822
      LE Data Length Change (0x07)
        Handle: 25 Address: 00:1A:7D:F0:21:40 (OUI 00-1A-7D)
        Max TX octets: 251
        Max TX time: 2120
        Max RX octets: 251
        Max RX time: 2120

I can't find that HCI_EV_LE_DATA_LEN_CHANGE is implemented anywhere in the kernel nor in bluez userspace.
So why do I get this event? Is it generated by controller firmware itself?

I think that both adapters support DLE. Is there there already support for using it with Linux?

regards
Christian



