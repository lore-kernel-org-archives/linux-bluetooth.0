Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF75C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jun 2022 18:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351605AbiFUS67 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jun 2022 14:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbiFUS66 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jun 2022 14:58:58 -0400
Received: from mail2.multitech.com (mail2.multitech.com [65.126.90.11])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id A9003115E
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 11:58:56 -0700 (PDT)
Received: from mail2.multitech.com (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id 347AD586D57_2B214F0B
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 18:58:56 +0000 (GMT)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by mail2.multitech.com (Sophos Email Appliance) with ESMTPS id 7A48F586CF5_2B214EFF
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 18:58:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsP8ihSZ0n0oz2zjck4AQisGz+89Fjktr6MHqFaR09QC3UOzrbmKfEzcdexKmVxHKWupJSQ0pkxPNE11RI0MlKLriPe9ZmeJSkQsd8mUoOzbe/WU7SHawX5jPXUS91gXRoZpO7mwOa6alF3yM6wzHQERSNBqFro1RPmo5uMwnH/rP6u8HIPf+CjRelzCy/mN1IylieDNKOEDH2ne2+z2iIb0hrXvcM5fmdUB9MzNY0cWq0hXN+3/lCnQZPUdhEyXW61raeK9ZIINQgeLIqWYW37p4GSzCsjxsocG0UmIccFkk74QRL9GT45tstDMkErK5CWWCjRqAvZS3/h78vbmeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJiYlrSquTn/B7+MAJltA4npq2TQgeR+zZ3ceISexIg=;
 b=O5L3D4Ju9PsKd77f2/3v9Zf0Lwzd5NWuTbLTuRenvMPkO5w88Zy7TC4pzt0dhRXat8u1/cC60uYjk3ZkWY089dZcrWw/hNnxxiodvhN2zanUnBxcbidW6AtR0jV02RaWSWzVS433SCMcdCkgfukHtLNBKGuoxr4GgqFJ+ARtZBFdoOAYWMEAu2+THkSkMYJzg1kCmSfYYKDYsnoffTXtdK2l91SEc5a1uLLqg9xqk+CESk4A+oXpIvXQ1/mHEJbN6gtERdD1bpk88P7wpXMhXUsSmK8KWMUKjlAuuFvBChwsV0LbN2ovTM/b7oc5w+nn2gDPBBLfCS5R3Ca7e2FNYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multitech.com; dmarc=pass action=none
 header.from=multitech.com; dkim=pass header.d=multitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=multitechsystems.onmicrosoft.com;
 s=selector1-multitechsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJiYlrSquTn/B7+MAJltA4npq2TQgeR+zZ3ceISexIg=;
 b=mAPiHOW78oBgN8Cakz2yCFtVYU/zQTGy6EAUm1c1ekheFpi6p1Vy/o9fSQUgXuX67Lqt08GQ4Du4joNq01+HsHp+mbFMM7kY0tfbq0dcY8Oiyt2jhzaKe6Xr3W3UKrKULQF9/ZKl0+dX862sTIRMSvqsFB0TnFY7UtH2HLqGYV0=
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com (2603:10b6:a03:40e::15)
 by BN6PR13MB1347.namprd13.prod.outlook.com (2603:10b6:404:6b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 21 Jun
 2022 18:58:52 +0000
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::980d:52c2:2f5d:f4b2]) by SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::980d:52c2:2f5d:f4b2%4]) with mapi id 15.20.5373.009; Tue, 21 Jun 2022
 18:58:52 +0000
From:   John Klug <John.Klug@multitech.com>
To:     "linux-bluetooth@vger.kernel.org Bluez Kernel" 
        <linux-bluetooth@vger.kernel.org>
Subject: [BUG] Use of gatttool causes scan to stop (permanently?)
Thread-Topic: [BUG] Use of gatttool causes scan to stop (permanently?)
Thread-Index: AQHYhaAmP1kRJIC1nEyd0lQ+AaX93w==
Date:   Tue, 21 Jun 2022 18:58:52 +0000
Message-ID: <SJ0PR13MB5755580E109362B165C9688FFEB39@SJ0PR13MB5755.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: e1f21ccf-732a-4ae1-be74-9a81c1dbbddc
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multitech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db4dc0db-530a-4c44-f506-08da53b8154b
x-ms-traffictypediagnostic: BN6PR13MB1347:EE_
x-microsoft-antispam-prvs: <BN6PR13MB13475873B3C9AE87DDB20174FEB39@BN6PR13MB1347.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wbdEUdpIsSz99qdGs8t5+CP9BApn/bhJqxmKIYjYV6E8D/NQh53oWB0BmvUksE918P4Ki2zvxto30PkmkdlQxHnv7rP41Mu3MK4/2M0F/K7fo7C9JjszibQofDGvCqcftbX4t/Dxr0/qoX9mRSnHUxfLUoF9iSoUPuaWGE+9IL2z+cVTDgqtBo8kfxq/VhBc5wIzQbI2rOgm9t+Ulz1rjibXrvAysYr+ZxxrothJCsCbP94+57k3F/e/1iy/iP4tj07J2ZzNLNtZhKsrG1lTjBFXQKuMHF+6RUe02XtUZNQ6WP1+1QEc0PALDQX4Bg3ZXMnDd5CbuieQcfCapNcFW2BIle7zVcXFGxkbzHkMyh2vfFcJNdCdRGINFhmYfOxyxU9PkSQm/NVAsP81FBaLj1IJbB5r7i1xU2bVscMDODn2ackO9DRHZAZcenMU8zhKUHeNLIHw3OXxAsi4saCS2KcfOaHf/5vRSYVtLUsYEMkqdqOpvy4kHz6EivScdyrp+9eaXd4MgGp6MMA2RkHeb4X+LznzLBe/bUHLq65FxhvlsgRH3qsyoP2Cm3DWIGuYcBnAafu2W/PC49gW5R2g0mFFVaI7qsRElZuRxPgQZq0zeV182tzpkrTN/SIqga4nPGdnfbH/GGMkG95QoXE6/d8Ek7cgdP0bk/iEb4WzlaGXwUwej+EwNwAdUuw+1cXBcv2EZK5NfiN7kYtnEG858T3XsTcbnjT0Z/wQVUc6eDgxUBxKjLL6WApK3mHDD0qZSp+f/rSMFK3QEYC5EKcb4iNZmxvPImAtv+f0oRCrCFI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR13MB5755.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39840400004)(346002)(136003)(366004)(396003)(186003)(71200400001)(9686003)(5660300002)(316002)(41300700001)(122000001)(86362001)(38100700002)(52536014)(8936002)(55016003)(66446008)(2906002)(66946007)(64756008)(66476007)(6916009)(66556008)(76116006)(6506007)(478600001)(7696005)(83380400001)(38070700005)(91956017)(8676002)(26005)(33656002)(49343001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Vwn8SdqymUDSnoZhPgPH/1Kom2tAc/NhxlJKVMX88iOq6fTCj0ovl5onbx?=
 =?iso-8859-1?Q?8nedzj6zhNOjcj/ncBuOTjyHLltvtok58cWWg5slR/2OV4Znf+slZcWUTp?=
 =?iso-8859-1?Q?4avNG+CWDEmAMY0gX5JfpmEVe9e0OF7wYCSsZ6SMbUVn5MtbqQ+7KxtztO?=
 =?iso-8859-1?Q?h0R++P9RAxTiwDBfVEbbkoi8oa+baGiTYXMziHPvJEjsE8t2jDPIPQS4XH?=
 =?iso-8859-1?Q?q+nTIfYmw5OHsLqLSUcLAdmaM5G/UEwIEuRG2Odb5RlURe3FN1Sx98PV6X?=
 =?iso-8859-1?Q?kCgG2S0tczAaJZycpji5DGdBp88zPnk/I7SaeTrvt3gBX0jnBde7iekDw3?=
 =?iso-8859-1?Q?LINSbhaBvZmv6ZNSULwbsLrJ35pkPeUy3xAMaxYAt05rTV+ilUIBQztI7W?=
 =?iso-8859-1?Q?/P3DNfCtzT7sw3NtXO+Amdo/YPNeGrTjxxA+BbdotBMODzoIZn1QSxU5oG?=
 =?iso-8859-1?Q?pdZIqqzmDb3geBQxYO4k6/Ot6dOsN6oX3tq6Y41fUJEKdonOeQf1AoJQQj?=
 =?iso-8859-1?Q?KSfRsQWE0Ajaats7LieqFIKdh4hD9g6zVcg9FZGDHkj/zUkge2pMWbLx5a?=
 =?iso-8859-1?Q?Aee+lKugKc9318SXlSI80nk3lm9YBwNsuI82XDCcllFaLBPPEVnKh1EWUn?=
 =?iso-8859-1?Q?WpnSGAP+WujjTrB7QWOHtSFTLDdeV/m+BO9c8WySFPdFAbrP9xcFSHgRiU?=
 =?iso-8859-1?Q?O6bE/RHQLDzYeWj0nb5NUTIxSvXw4/JZj0DaCuVS6pEyIyczMRc8MTr4fU?=
 =?iso-8859-1?Q?shHM8YM7UGSU5SwSkU5NhDJ2gSD4w6Df5cJ7jZK4++VmjqojP8rb+bNrto?=
 =?iso-8859-1?Q?MjxbiU90fzm9iEjwE531MicU5BggWSiHCdg5LFtfpqcw+LkjFVYcoaYOQ/?=
 =?iso-8859-1?Q?4yi9bNgwGLjDlMwRdyx9ZrSw3ybuQg3TBTxvQOf4sKWklhFEqjCrlBsXOd?=
 =?iso-8859-1?Q?b/ATiPKJWoxXIqb1W10t/4oSL9kJSZHoWsA0P1+eb9m0kwrPAWwtOApNMw?=
 =?iso-8859-1?Q?JgGL9hVv46mbQi0SPV/2e8+euuagK8/ZXYZOVJCjIQ43DHcHEYauE9tRnd?=
 =?iso-8859-1?Q?loEW1tmdhWPs6Oj0NhmusuAyu9GBOu/A8OfjBGAdX0rOetU8+nP0kB4Ncx?=
 =?iso-8859-1?Q?LChNGabaJe2kiuwNww18N80Zt9u7kiurNAxyneH/OjbX3lFSDtnClcYFw6?=
 =?iso-8859-1?Q?+0qZQD1DTOhgvIqPOLB3jg6q5qdjWy9GmS++0zb5zEPu7tXram8X2p8YCT?=
 =?iso-8859-1?Q?jKgmLRCju1KyFuagz9HhF2TVsiiGybmXFK23+U6Nxo2aMI1UJiPwdVaC9o?=
 =?iso-8859-1?Q?f/bfAOFbuUqPxSb9USaYl81D/Uk5nEcuGwulgzkwFQMlReMQc3cBOVT7M5?=
 =?iso-8859-1?Q?8g25NTREZNWrcfDAiNNCXl8fSG50r18raqsu/G708cnjYdEJa5FhhXZUzj?=
 =?iso-8859-1?Q?QYmsgxYpfUOCoX6bgcJJQsLSi1ezjzg7KLG3d3u/rqDpKbXIxsbqVUbBrE?=
 =?iso-8859-1?Q?YBTk/hsYQOBV1uL7Un3Tw7DcDSc6mFjRufwhRuQmHQ/jo4FOKI8Q7H6saZ?=
 =?iso-8859-1?Q?bPG2GuPTmG4zTKJUTQEuVrniYBrqZ4apKK++8R3tzUfslOtj9zJj3LTU3W?=
 =?iso-8859-1?Q?85rXCyPcX62gFrIjkcaG27vcNhGnKaTd84ZK5l0Sn07tLtE9uHipNhGfOd?=
 =?iso-8859-1?Q?WHl0zozJ43TsOWLFpuW1DQrEeaiW+6RLDSJL/RVRodSFYayLNGdgw3gB5g?=
 =?iso-8859-1?Q?R34SCa/8o/10faN0F4U7QVnLCKP+5m98ngDIqsQFzColVJAwdxMccooY9Z?=
 =?iso-8859-1?Q?KoNJAztKgQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: multitech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5755.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db4dc0db-530a-4c44-f506-08da53b8154b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 18:58:52.2108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f802e804-804f-4d1e-b625-870b4d57fd00
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p/6Mxp/vnUs01Xuxw0Bgo1Ln6TU5Z2MFfFmiu7p8/owBef5SdmoPEVH/ytW10RRqcX+aNKR8GyZkKN31BFOrFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR13MB1347
X-SASI-RCODE: 200
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I am using 5.4.199 currently with bluez 5.64 on an arm 32.  The same proble=
m occurs in earlier versions and kernels.=0A=
=0A=
In bluetoothctl after the issue occurs the "show" command always says:=0A=
=A0 =A0 Discovering: yes=0A=
=0A=
And no scan data follows, even though we have many devices.=0A=
=0A=
I have tried turning on duplicate data with bluetoothctl.=0A=
=0A=
I see (manually typed in):=0A=
=A0 [bluetooth]# scan on=0A=
=A0 SetDiscoveryFilter success=0A=
=A0 [bluetooth]# scan off=0A=
=A0 Failed to stop discovery: org.bluez.Error.InProgress=0A=
=A0 [bluetooth]# scan on=0A=
=A0 Failed to start discovery: org.bluez.Error.InProgress=0A=
=A0 [bluetooth]# scan off=0A=
=A0 Failed to stop discovery: org.bluez.Error.InProgress=0A=
=A0 [bluetooth]# scan on=0A=
=A0 Failed to start discovery: org.bluez.Error.InProgress=0A=
=A0 [bluetooth]# scan off=0A=
=A0 Failed to stop discovery: org.bluez.Error.InProgress=0A=
=A0 Failed to start discovery: org.freedesktop.DBus.Error.NoReply=0A=
=0A=
gatttool can still connect and retrieve data.=0A=
=0A=
btmon shows no activty except from gatttool, and none from scan=0A=
=0A=
Here is a snippet of debug from bluetoothd:=0A=
=0A=
=A0 =A0 Jun 21 13:33:30 ecc8 daemon.debug bluetoothd[32170]: ../bluez-5.64/=
src/=3D=0A=
agent.c:agent_disconnect() Agent :1.1113 disconnected=0A=
=A0 =A0 Jun 21 13:33:30 ecc8 daemon.debug bluetoothd[32170]: ../bluez-5.64/=
src/=3D=0A=
agent.c:remove_default_agent() Default agent cleared=0A=
=A0 =A0 Jun 21 13:33:30 ecc8 daemon.debug bluetoothd[32170]: ../bluez-5.64/=
src/=3D=0A=
adapter.c:set_mode() sending set mode command for index 0=0A=
=A0 =A0 Jun 21 13:33:30 ecc8 daemon.debug bluetoothd[32170]: ../bluez-5.64/=
src/=3D=0A=
agent.c:agent_destroy() agent :1.1113=0A=
=A0 =A0 Jun 21 13:33:30 ecc8 daemon.debug bluetoothd[32170]: ../bluez-5.64/=
src/=3D=0A=
agent.c:agent_unref() 0x13285c8: ref=3D3D0=0A=
=A0 =A0 Jun 21 13:33:30 ecc8 daemon.debug bluetoothd[32170]: ../bluez-5.64/=
src/=3D=0A=
adapter.c:discovery_disconnect() owner :1.1113=0A=
=A0 =A0 Jun 21 13:33:30 ecc8 daemon.debug bluetoothd[32170]: ../bluez-5.64/=
src/=3D=0A=
adapter.c:discovery_remove() owner :1.1113=0A=
=A0 =A0 Jun 21 13:33:30 ecc8 daemon.debug bluetoothd[32170]: ../bluez-5.64/=
src/=3D=0A=
adapter.c:discovery_free() 0x1321050=0A=
=A0 =A0 Jun 21 13:33:30 ecc8 daemon.debug bluetoothd[32170]: ../bluez-5.64/=
src/=3D=0A=
adapter.c:update_discovery_filter()=0A=
=A0 =A0 Jun 21 13:33:30 ecc8 daemon.debug bluetoothd[32170]: ../bluez-5.64/=
src/=3D=0A=
adapter.c:discovery_filter_to_mgmt_cp()=0A=
=A0 =A0 Jun 21 13:33:30 ecc8 daemon.debug bluetoothd[32170]: ../bluez-5.64/=
src/=3D=0A=
adapter.c:trigger_start_discovery()=0A=
=A0 =A0 Jun 21 13:33:30 ecc8 daemon.debug bluetoothd[32170]: ../bluez-5.64/=
src/=3D=0A=
adapter.c:cancel_passive_scanning()=0A=
=A0 =A0 Jun 21 13:33:30 ecc8 daemon.debug bluetoothd[32170]: ../bluez-5.64/=
src/=3D=0A=
adapter.c:start_discovery_timeout()=0A=
=A0 =A0 Jun 21 13:33:30 ecc8 daemon.debug bluetoothd[32170]: ../bluez-5.64/=
src/=3D=0A=
adapter.c:start_discovery_timeout() adapter->current_discovery_filter=0A=
=0A=
Do you have any suggestions for further research into this problem?=0A=
=0A=
John Klug=0A=
