Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9892C43217
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Oct 2022 14:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiJSOPR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Oct 2022 10:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbiJSOOJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Oct 2022 10:14:09 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20624.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::624])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F081BE40E
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Oct 2022 06:56:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKIvM9To/jjY4MVsLwYbM/looMPBVnF6ss/gxMSm6ezlxVU4c+qsIHIrVwLTRtfTbC8rxC9cMpuicVX/QOZM+fMJ3kpjZSNWd2kDA5I8rsYqr6R21zRk/PLIby704JinPLaT70MeCU5Yks+79Wd8dYK0NQy6Pp5L55axykPCc9lz8uMzYbo7qv9TYkUegFAuyPInEuPTh5zQCL2R40HEZfV/j3FqZVrTkz7CYzRe49kNI80lUv37Jwk9SfVCHHKlcH7mlcVUjTVDH+8KLJcJ+WpHBVnsfQhp2oLzGRygMpiokR2S4D3Zg4bb+Rou0Cht/q5v5yn71nl5GRbCcJ8kag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Reg91Qe2BZHinKUosYBXTl+gAxvfmRFo3d7YsUmsEY=;
 b=JnOZNkM0WiaIhMJq2MZXxXA23AlAecxX2yXNbSbSiCfnBf1v0RXrzLrUAbflBZ7u49CuNWm9gptHrnnGONjU1AgreEthaZjhQ6FDcYW0r1X28yMsDYhCxh36eXLF3h3qYskwQcso9Dx12sYv9zOlyb79LnVXW/HHSvAoUupO/UkBgSsQDH4RMXVZN/L6FlyNA5D/o5MtGYYllJPZdxGZ2xiDUDxqxDB2AfDCykFJRqvJaZxye+WvrHcQG6NmdoTk37p8TPU29mk2VrwULDP3gRBUcPhvhg7gSWC5L7nAaHvecX5Pa2Nogh4GiVUQpzLkplHNpOsKQzMXs2TB1tVOBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verifone.com; dmarc=pass action=none header.from=verifone.com;
 dkim=pass header.d=verifone.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verifone.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Reg91Qe2BZHinKUosYBXTl+gAxvfmRFo3d7YsUmsEY=;
 b=UtTqJnCFtN0/1jJvZMwzGPO9BB8+WG0TCVpri+aXg38RgZLVeMMJqT2PZsDXMHwk6SQfV70hgpJHEYcAcJgZH1WdlKlAt0VZfR9cHbgG9OwXZqeOcO1z/T8di0YA97CZU5aUpuKwOhGW6tXSWo7TTB9+clYNgisZavXt/yeo1ls=
Received: from BYAPR03MB3701.namprd03.prod.outlook.com (2603:10b6:a02:ab::24)
 by DM4PR03MB6999.namprd03.prod.outlook.com (2603:10b6:8:45::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Wed, 19 Oct
 2022 13:55:09 +0000
Received: from BYAPR03MB3701.namprd03.prod.outlook.com
 ([fe80::2eea:e0aa:59b6:21cc]) by BYAPR03MB3701.namprd03.prod.outlook.com
 ([fe80::2eea:e0aa:59b6:21cc%6]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 13:55:09 +0000
From:   Tom Unbehau <Tom.Unbehau@VERIFONE.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Forcing MITM protection
Thread-Topic: Forcing MITM protection
Thread-Index: AQHY48C+Uuz3YmFOBU6rTotRJ41vEA==
Date:   Wed, 19 Oct 2022 13:55:09 +0000
Message-ID: <BYAPR03MB3701856C7F525A261D9F3D14872B9@BYAPR03MB3701.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=VERIFONE.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3701:EE_|DM4PR03MB6999:EE_
x-ms-office365-filtering-correlation-id: 9baf5c7f-0006-483c-dcdc-08dab1d9891f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /VDLPi4gOfpG2M2Mx18L2PDamB5BtrYYVeH/e9Zu/0sNR6tOOalBH40pb74hdgXThvXU6OG4S4puUqH2502ck3rO+Ia2krpbEuyTW7eRKfrrCHqa+UO97KkQGcGv6ejdHER1xAnbXYCoMqOLEaOszrjuh+0fqh+WgpusMDUsGIfVr2LcP2J4EpBSXaSDlCXrJBfIm2KpJ52p0R5T+CxqYXanDPoOtll7KstDkRoImmA1Js9dyLmc86t+9FxPMoB+OGXdbaOS5HVWdUpw7mHgXuUJDFInzOuYYLqhGI60vZoDzwgvLGnPBWGZRpyPilyfS81BtSEuROlCciFOIvrqz4y3Ff/6LWg23IOoXZY84kKWAjTTKSZx/ZXY7FZAmQYbiA53u4masu4YTWbivjpGmAHorHefeVXMPHWFene7fqmidTzHHDC6GCyiEk7X+N+J1x+5Tzbjo3lu3SWHvTWqlk+vOl+LlyP/6Ap/2k2MY9Y/1YTDP46W8pRJM+056mtsAx18VS/awTJ+n/0ZNoCjLm/lk21nUG+dSPPy6XYzq87WdhP3N1Sz8PS3GMrl0nX7MXDY1Zh845dJGP0kJm8Ept9MtQ+E1arlVBUdsRprjVEq6rVznKaOEdD8f7YuvyElVydKaA8o4X/R9CIPj1qdPuuVVHGRZ39aqk2sJWsc8ENTYGB657RTLwWPJJ1TCMwTRnCpnN38BvgcQVpmaLaNUgwWjFqbM/N47jAxRyE1ilEv9kDNe/LbsJNhrNj+RXwJhxWGA5RRjSxHXjMzVej8+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3701.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199015)(38070700005)(186003)(2906002)(66946007)(6916009)(316002)(7696005)(76116006)(38100700002)(478600001)(83380400001)(5660300002)(26005)(41300700001)(55016003)(122000001)(86362001)(3480700007)(71200400001)(91956017)(6506007)(8676002)(64756008)(8936002)(33656002)(52536014)(66446008)(9686003)(66556008)(66476007)(7116003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tSm8DIVPsnBOhH6W1r+c0rB9dATyHepfPjxi6glv4+lSRbVcAU5Bpoblbp?=
 =?iso-8859-1?Q?KgyhBrcDxWLSzezwoAYju1+ZatEKp+Ejj6VI8kx0raCtzEGuKzSP1elD2p?=
 =?iso-8859-1?Q?/X9a2/foIrs6fAFbGg8PMCtdBBqjEyNZe/ko0txxoRPOAHxLKsZ0WrFjJF?=
 =?iso-8859-1?Q?j5BS3tr0a1OyCAvKEXBAwp39exgx0D3Alnb91ofsYFqpqv+8u9zFUQjDAh?=
 =?iso-8859-1?Q?OUZSxVjt24E+Z0NkVqrl/fEQal/lqX7AHCbTvR2TNUZMOD9fYYfpCLDzBp?=
 =?iso-8859-1?Q?xb7pZgcNqHXnlFc4wGHfSKGlI+7Xt96MppGaS72OYzjhwbMUrBL4zHml+n?=
 =?iso-8859-1?Q?K1Sl0VDKY7VreYcWxNC0DGEMrN9OLAslrnCqWYDnHnmoaVzHkVJzKbbj0Z?=
 =?iso-8859-1?Q?pB4PWdmgk/tWd3MtJx0/alK0on9zceJvgnoIcZkkBSnvnuxZzGSqvN1zb8?=
 =?iso-8859-1?Q?hhiL1+Z7XHVkE5kGNXiCE51EsEekuLHdbgPoOlZbl1a49S97PAT79BEOUH?=
 =?iso-8859-1?Q?aGmcdc3fgz1m0XyvxuoK81srtGoJfjaKZp36fvXuMv0v1tsZ/LO20TdEeO?=
 =?iso-8859-1?Q?zEkD9oEXfiecYjIgkXFlntZL5FD6B3G1FMOwIrMBoG0b1UHwi9zqCnNPB6?=
 =?iso-8859-1?Q?ZAOtL0jeEGs8E7St9b4mX3PUkI6nFTMYJvxN95SmxrfYolXtQwWVRkF0uk?=
 =?iso-8859-1?Q?JP57YCN0V4AMerWyUkEAPQ3HNNcFwN6IRMDAxF+wW/fdXdjklLEXuNGMni?=
 =?iso-8859-1?Q?QpiHbc6tpxKZjwSjhH/oVNmAqUIR3jBsE7WUZaYtbIiPd26P2hfn5/IxnM?=
 =?iso-8859-1?Q?1WzE1dkFFf5UXfqpZ3rMauvE78KFGPrc0mDtTXxRF63QbSOB1PQsYEvlrZ?=
 =?iso-8859-1?Q?/clNWhc5KFWNJ5nkbKqFWh8LOs3UMwCAH4bnCRxjl0BqViK0jzIaoggLa4?=
 =?iso-8859-1?Q?rstvoHYLuvhsoQITlJ83oG6AGQWPkCshT0eiEIS+9VEjWt2KLU8fCmo8YP?=
 =?iso-8859-1?Q?3KNiqxfHdzh+6tPVKkPvbY/i4Qx1f3Q1Y5AlPoTh5F4XxdmQ1+MaJm7TbV?=
 =?iso-8859-1?Q?VqiX8CKQZmeSRDl0DQbakNfyoR07rvBD07z16lSt1ED57ryfIMqxg/Egtg?=
 =?iso-8859-1?Q?9+xiu4sMVWMUO4j1Gt1L+BVODKWvTRRsHWXn8cCMnEArreo0WTaKCpk+lR?=
 =?iso-8859-1?Q?qS6iQz/DiYxEg/RHYwVM6Jxp04yrkb+foBmkavl58uQB4NfFrOLTDlA5c3?=
 =?iso-8859-1?Q?pnRyewVrikra9N91FgZY7J5CXyKj54DZT7atNlLfSJ5DW236mnLqkd+dPK?=
 =?iso-8859-1?Q?aCya0VdX/QBMH8VqtuD1OwsZuUW3jkteH1DPVCETzQFH9LDyvSjZ7sROyW?=
 =?iso-8859-1?Q?HzUfL0yRRNOCVACzbr/bZodWiCm4K41t0BQaQ/Vd5jzWfczdQYfDKNdCY2?=
 =?iso-8859-1?Q?BGz/VYAepomN1EjX5FgfogsTyyPle/0a7qOLYtH4Xh89eTAenA3RSikg0p?=
 =?iso-8859-1?Q?W9a6W4BsP9aZIb5Rs0MUDuw51ueEwAwrh9DuOOBSYayVqVVXniOkTQWkSv?=
 =?iso-8859-1?Q?zAs+6Ndt9lhXROjF/toPSSYLRJHuwi+hXGOCXO++Lor3LzxMA5nx0Ed1Ul?=
 =?iso-8859-1?Q?3VCE+vd9KJHaLcpH+W/hvRRoDy7OwNfUZ1?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: verifone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3701.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9baf5c7f-0006-483c-dcdc-08dab1d9891f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 13:55:09.2464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 611a22d6-8c40-4958-84e3-ce47d8205d98
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2wsmkOJGZ5UYA7Y21YBZQw10u9djo4QJ2SEy9g+zUhf2xL6FKJdll60sJ6A/R4TkaAX//+aOkkVxoKx8IK9Jsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6999
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi everyone,=0A=
=0A=
could anyone give me advice on how to disable SSP "Just Works" pairing=0A=
via userspace? Due to regulatory requirements I am not allowed to=0A=
support BT pairing without MITM protection.=0A=
However when I pair (outgoing -- i am the initiator) with a device=0A=
which has IOCaps set to NoKeyboardNoDisplay and mitm to 0,=0A=
the "automatic" pairing is triggered in the kernel, without me=0A=
having the chance to cancel this.=0A=
=0A=
The automatic accepting happens in event.c:=0A=
=0A=
-------------------=0A=
static void hci_user_confirm_request_evt(struct hci_dev *hdev, void *data,=
=0A=
					 struct sk_buff *skb)=0A=
=0A=
[...]=0A=
=0A=
/* If we require MITM but the remote device can't provide that=0A=
	 * (it has NoInputNoOutput) then reject the confirmation=0A=
	 * request. We check the security level here since it doesn't=0A=
	 * necessarily match conn->auth_type.=0A=
	 */=0A=
	if (conn->pending_sec_level > BT_SECURITY_MEDIUM &&=0A=
		conn->remote_cap =3D=3D HCI_IO_NO_INPUT_OUTPUT) {=0A=
		bt_dev_dbg(hdev, "Rejecting request: remote device can't provide MITM");=
=0A=
		hci_send_cmd(hdev, HCI_OP_USER_CONFIRM_NEG_REPLY,=0A=
			     sizeof(ev->bdaddr), &ev->bdaddr);=0A=
		goto unlock;=0A=
	}=0A=
=0A=
	/* If no side requires MITM protection; auto-accept */=0A=
	if ((!loc_mitm || conn->remote_cap =3D=3D HCI_IO_NO_INPUT_OUTPUT) &&=0A=
		(!rem_mitm || conn->io_capability =3D=3D HCI_IO_NO_INPUT_OUTPUT)) {=0A=
-------------------=0A=
=0A=
In my scenario the following happens:=0A=
=0A=
-------------------=0A=
if ((!loc_mitm || conn->remote_cap =3D=3D HCI_IO_NO_INPUT_OUTPUT) &&=0A=
-------------------=0A=
=0A=
conn->remote_cap is HCI_IO_NO_INPUT_OUTPUT, loc_mitm is 1,=0A=
the check passes (right side of the logical OR).=0A=
=0A=
-------------------=0A=
(!rem_mitm || conn->io_capability =3D=3D HCI_IO_NO_INPUT_OUTPUT)) {=0A=
-------------------=0A=
=0A=
rem_mitm is not on,=0A=
the check passes as well (left side of the logical OR).=0A=
=0A=
However, in the example here even the check before on conn could prevent=0A=
this, however conn seems to be the ACL connection,=0A=
which is set hard to BT_SECURITY_MEDIUM when doing outgoing pairing:=0A=
=0A=
mgmt.c:=0A=
=0A=
------------------=0A=
static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,=
=0A=
		       u16 len)=0A=
=0A=
[...]=0A=
	sec_level =3D BT_SECURITY_MEDIUM;=0A=
	auth_type =3D HCI_AT_DEDICATED_BONDING;=0A=
=0A=
	if (cp->addr.type =3D=3D BDADDR_BREDR) {=0A=
		conn =3D hci_connect_acl(hdev, &cp->addr.bdaddr, sec_level,=0A=
				       auth_type, CONN_REASON_PAIR_DEVICE);=0A=
------------------=0A=
=0A=
After some modifications to the kernel source I can get it to cancel,=0A=
but I really do not want to modify the kernel in order to do disable =0A=
"Just Works" handling.=0A=
Is there a way to force MITM protection in all cases (via IOCTL, or HCI=0A=
user socket or whatever). I would be very appreciative of anyone=0A=
who could point me in the right direction.=0A=
=0A=
Thank you for your time.=0A=
=0A=
Best regards,=0A=
Tom Unbehau=0A=
