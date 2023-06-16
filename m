Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B491EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Jun 2023 13:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbjFPN6S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Jun 2023 09:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245688AbjFPN6Q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Jun 2023 09:58:16 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2102.outbound.protection.outlook.com [40.107.21.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51BC3C30
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jun 2023 06:57:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDteuqZA7leVOdijAqzFkcP2tURPwaNJa6LKh2EBJ+8h5ePgaxbGVd1qQ8BVMBm1o3ncglf4NGWT3QILMH9v9NL4onq02ULfMImGkLAlCsMsD6HdSNrP//QDbglS7HsbsDBQ6YYRB0hvJNQf6Irs2ApT+kUuXiz8z+m7RrHHS1R9LHVmA51bf2lAi9K25ZMYCce5mqLbSGwwvqXWbuOnc8IdwEdrY8q/hnHb4FhsmYXl5g1HPEn98qQmMxASAVNCcl4q37C1KSgloSnYm0eFigtL+j81/cBSlHxWFlxlYfb4fofFmj2Hi6Vi1zq/PglSl/49BWqu1VGfjkt2ijj1IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwxb12+ut08Pms7ZJcqqLyhXdz87OwfAzPf9BWvehno=;
 b=R5Ierf1poMSANsFnBR0ijf47VHeubCP0C52Usr+ACzFnY0ek1ypcwhlpHDClrmxjZazTTtJvVbPHw+g18DGuSdwhA6NPo5GFzxZxrlB8fcwduuhxprZOfvgzmE7JY2+WQPIOS/qSAdRSeRnIgt68tlxhUzOD3iHRBF7MfQ74BKhJL8MLzh6G9E3/BHIJj2eq2PGUOX1Do9R4hUeNaBTP3UI1qrtYgEn+esaMIaPzwX5O1oHQ86FbQNDa6EuC3+qPKUIt0xkDRcl7iINZl6C3WfheCZM7DgEr/bAxudUAB8puNmnCckvP9f86H40yW5LjwtmNwVtVRXYT3lBvQFZlVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwxb12+ut08Pms7ZJcqqLyhXdz87OwfAzPf9BWvehno=;
 b=GV70NztusZ746VnEs/8ajDKfaSf34z8W9uP8ZQs34EF3kLCVE6sMp2jGatnlqr2yO4rRKM/2TluKX9UnAkkjxss0c/u24inqe+ZhZcQDkVRNe0aEnLxZix9mdU7M/O5yrzaYPmmJLJLWoJzKBVx/eBlvM1b55LaiHPBmlNstNq8=
Received: from DUZPR01CA0346.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::29) by DB9PR07MB9127.eurprd07.prod.outlook.com
 (2603:10a6:10:3d5::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 13:57:18 +0000
Received: from DB5EUR02FT042.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:10:4b8:cafe::8a) by DUZPR01CA0346.outlook.office365.com
 (2603:10a6:10:4b8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29 via Frontend
 Transport; Fri, 16 Jun 2023 13:57:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB5EUR02FT042.mail.protection.outlook.com (10.13.58.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.16 via Frontend Transport; Fri, 16 Jun 2023 13:57:18 +0000
Received: from n95hx1g2.localnet (192.168.54.51) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 16 Jun
 2023 15:57:17 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Matias Karhumaa <matias.karhumaa@gmail.com>,
        Ari Timonen <ari.timonen@synopsys.com>
Subject: Just-Works re-pairing doesn't work
Date:   Fri, 16 Jun 2023 15:57:16 +0200
Message-ID: <8240386.T7Z3S40VBb@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.51]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR02FT042:EE_|DB9PR07MB9127:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bd68ea4-af9d-4c17-c558-08db6e719948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +S4dPle/21WzkV2IIgjfxS22T/STJPKPrZkzcfy+ryKLySkExdsFRWwo7zV6pmqTtCGJmIKVvVD8hy2iZFK9tpvhl96nZIVNCb736TMWhrB1Tl7CxGrPsd0jd2QIGMvr72istjCLDhYYMFx5EfXY1nSeMTvI1HknKlidtTOQ0gyqTmdT39B+pNiIKt56ALULv5ChuNgxuM6JpS9PP6yuGt3mv+Lo0FOwxoq96LKa6NqTRgOaX8Avt8vtbpeiqq4qjBbRQLE8FkdkphDkyuymIc7OxR5Cme7m0MRo5s0AXQ8fe/DCD9H/x444F7v0woDzzy4f3HPAEkdA2b3sfsFtceRsQc34Duzw7Aau/qcnN6LB9fXmHWgjQV11Wo6jJAO3GKZdVoy+3Vz8oM1ha7CjqDxpavxYXc/Qn5UiE+Tf+N+10bZoNA6KHz6E4VLuiE5c7KWZP+ZyabRIgzHM+t2yRlshK7gNvzCmjIaBPXYAu9Jb5nDjzf64E7ACt1mtOc4MrjPiDtejCLGVaClS2Nk4iDPKP4Icwicjcksil1HdvFfBAPYxy5OZFe9pKJoO98u6yv+oQLhSvh1qh9bCWjwCqLMDKAKehdNtm16AzpaYmZivGedCdA+vkiy7HGLvZ6Ddzp5EqB3BesZk4FW2l57b7PxN6pjA0EDrpP7qi1InxjdJtW6HoYgImIOHW6qPYwnIZf4z65sCxMZgl8UI8A0/RkpDhZh0xlNHQ3/8tHxEbHnsZT+xr653l0sNa8JjLKBuWtVqtrHNcdRSWgIX+ikUAQ==
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(46966006)(36840700001)(2906002)(41300700001)(5660300002)(8676002)(8936002)(9576002)(316002)(4326008)(70586007)(70206006)(6916009)(82310400005)(40480700001)(33716001)(336012)(426003)(36860700001)(47076005)(83380400001)(107886003)(26005)(186003)(9686003)(16526019)(82740400003)(3480700007)(81166007)(356005)(86362001)(478600001)(54906003)(966005)(36916002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 13:57:18.4475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd68ea4-af9d-4c17-c558-08db6e719948
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR02FT042.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9127
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Kernel: 5.15.113
Bluez: 5.65
Peer: iPad with i.OS 15.7
Application: 
- Embedded L2CAP application with own agent. 
- Agent has been registered with "NoInputNoOutput".
- BT_SECURITY for L2CAP socket has been set to 2.

Problem:
Re-pairing (pairing again after "removing"/"ignoring" the Linux device in the system
settings of the iOS device) doesn't work. In order to successfully pair
again, I first have also to "remove" the iOS device on the Linux system using
bluetoothctl.

See also (looks equal to my problem):
https://stackoverflow.com/questions/75362887/linuxbluezbluetooth-failed-to-re-connect-after-forgetting-while-using-noin

I tried the following patch:
https://patches.linaro.org/project/linux-bluetooth/patch/20210208220531.3471-2-matias.karhumaa@gmail.com/

After applying this patch, re-pairing works fine on my system.

I don't have the oversight to tell whether the patch above is correct.
Additionally I am unsure whether the "JustWorksRepairing" setting has
any meaning on my system (as I have implemented an own agent within my application).


regards,
Christian



/etc/bluetooth/main.conf:
------------------------8<------------------------
AlwaysPairable = true
JustWorksRepairing = always
------------------------>8------------------------


Log:
> ACL Data RX: Handle 25 flags 0x02 dlen 11                                                                                                                              #16 [hci0] 2.807328
      SMP: Pairing Request (0x01) len 6
        IO capability: KeyboardDisplay (0x04)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, MITM, SC, No Keypresses, CT2 (0x2d)
        Max encryption key size: 16
        Initiator key distribution: EncKey IdKey LinkKey (0x0b)
        Responder key distribution: EncKey IdKey LinkKey (0x0b)
> ACL Data RX: Handle 25 flags 0x02 dlen 11                                                                                                                              #17 [hci0] 2.807436
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Primary Service (0x2800)
< ACL Data TX: Handle 25 flags 0x00 dlen 11                                                                                                                              #18 [hci0] 2.807514
      SMP: Pairing Response (0x02) len 6
        IO capability: NoInputNoOutput (0x03)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, MITM, SC, No Keypresses, CT2 (0x2d)
        Max encryption key size: 16
        Initiator key distribution: EncKey IdKey (0x03)
        Responder key distribution: EncKey (0x01)
...

> ACL Data RX: Handle 25 flags 0x02 dlen 69                                                                                                                              #46 [hci0] 8.507352
      SMP: Pairing Public Key (0x0c) len 64
        X: 8b6f72774ab48d0246be000d4555e2f99f9799518be4bccc3e3e509a31b2ae03
        Y: bf3f03e9f08c67b1e843be1ca7a0522686216828becefa40f6622e3322e4db5e
< ACL Data TX: Handle 25 flags 0x00 dlen 69                                                                                                                              #47 [hci0] 8.545335
      SMP: Pairing Public Key (0x0c) len 64
        X: 1975cc04c4ef4444a202898c0ad006e01d1ff5fb64b6648fdb585004987c6c28
        Y: fbe9d105bd2d0c134618e87ad850443021d3c30d03e452c9be3a67bc071b548e
< ACL Data TX: Handle 25 flags 0x00 dlen 21                                                                                                                              #48 [hci0] 8.545395
      SMP: Pairing Confirm (0x03) len 16
        Confim value: 89353a66cb49c378698c73bbb91ed203
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                                                                   #49 [hci0] 8.568106
        Num handles: 1
        Handle: 25 Address: 7F:C0:E4:47:71:5A (Resolvable)
        Count: 1
> ACL Data RX: Handle 25 flags 0x02 dlen 21                                                                                                                              #50 [hci0] 8.597228
      SMP: Pairing Random (0x04) len 16
        Random value: e31d5e3904a034178b59ee6215691095
@ MGMT Event: User Confirmation Request (0x000f) plen 12                                                                                                            {0x0001} [hci0] 8.597365
        LE Address: 54:62:E2:37:6A:A9 (OUI 54-62-E2)
        Confirm hint: 0x01
        Value: 0x00000000
< ACL Data TX: Handle 25 flags 0x00 dlen 21                                                                                                                              #51 [hci0] 8.597400
      SMP: Pairing Random (0x04) len 16
        Random value: 484ff14d26537f86dfbefd924fbd8eb9
@ MGMT Command: User Confirmation Reply (0x001c) plen 7                                                                                                             {0x0001} [hci0] 8.597845
        LE Address: 54:62:E2:37:6A:A9 (OUI 54-62-E2)
@ MGMT Event: Command Complete (0x0001) plen 10                                                                                                                     {0x0001} [hci0] 8.597876
      User Confirmation Reply (0x001c) plen 7
        Status: Success (0x00)
        LE Address: 54:62:E2:37:6A:A9 (OUI 54-62-E2)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                                                                   #52 [hci0] 8.598099
        Num handles: 1
        Handle: 25 Address: 7F:C0:E4:47:71:5A (Resolvable)
        Count: 1
> ACL Data RX: Handle 25 flags 0x02 dlen 21                                                                                                                              #53 [hci0] 8.657238
      SMP: Pairing DHKey Check (0x0d) len 16
        E: 1ffb663bb5033f7127b4fb43fb0e5c00
@ MGMT Event: Authentication Failed (0x0011) plen 8                                                                                                                 {0x0001} [hci0] 8.657418
        LE Address: 54:62:E2:37:6A:A9 (OUI 54-62-E2)
        Status: Authentication Failed (0x05)
< ACL Data TX: Handle 25 flags 0x00 dlen 6                                                                                                                               #54 [hci0] 8.657466
      SMP: Pairing Failed (0x05) len 1
        Reason: DHKey check failed (0x0b)



