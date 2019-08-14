Return-Path: <SRS0=WtLI=WK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CC5C433FF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Aug 2019 08:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A8D2084F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Aug 2019 08:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zgrp.onmicrosoft.com header.i=@zgrp.onmicrosoft.com header.b="E9EAFaUG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfHNIOM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Aug 2019 04:14:12 -0400
Received: from mail-eopbgr140109.outbound.protection.outlook.com ([40.107.14.109]:59974
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726496AbfHNIOM (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Aug 2019 04:14:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLqE6srHmL4sayFmXpWpvin1Y92Q6Q4GoixRcVnwYNRvXuP9EXydB1+p2zWkznnNwOpjYzUlD0CtWcaiyk0PVU86eVoeFM5DLQNe7DzGX40XDQ/DlyQF0nBfGT2YniyA6aJeB1Maq/ZC53lSKIaZuRo+AW+WEWl5d0O9Wlvhp/Fpe0O08GeLvHjBUpALMMm5J6SpeZcOjjWW6rjZz4You7EBYWdv2MrG/elBwJ6zpKa5HmGifdDj44Rymw6P+WDCazI9E5UEp4E7xbBgHH+uoYGJf+Z88sNa8d41Hyj/WXAfOFESRvnSTMenECtWPfmU/MJDIxB8SLxo5gnEgWpYRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/zQkiTl456v8+RDEAFYVq3S6mS/VpibDZqkYUFGZSg=;
 b=TzG8+sPl7PyXx8JUQt5Gw+8z27MyWZ3NC1T9CGdo2g1tLsXAPr2hIu+G0ozTL+TTbNF/KOLOBKXDX9K5RzL2MN57LzZeGXJAzp4zQ2aVq133dwEdv0VhqApXwYBwi6xxOuUpswtt0PCOxfK+ZHQbUiv1qM+ZwI3OLQOWxQjZUkqQRgJt2f5AzqKvfD6byLG2DNMnmhvGRqa5geo7MDVNVPeRQBobcpX8uPFW4IeaY2kFzyP+nbkcXD40IJS1W1t9QlIn+nMzBTKd3cDPphjOkGXSYbeCCLCenUDkCtl4NQ3EN+uj3YPV2xz8fBqY8QVYRkHpOUA4ug0LhA10+WONmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tridonic.com; dmarc=pass action=none header.from=tridonic.com;
 dkim=pass header.d=tridonic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zgrp.onmicrosoft.com;
 s=selector1-zgrp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/zQkiTl456v8+RDEAFYVq3S6mS/VpibDZqkYUFGZSg=;
 b=E9EAFaUGmXAAN6fdEVUnIvyBpVMcDlcqXTE6GU8dM9JmOOe9pVUE3NKogCGlHa64ER/epLv1qLfkbXGn5iDYg4MlR6EIQYv831wzFfJVAqfZwpmoVKmQv+TOkYn5UsF2/EdEuQfGkMek+dr0kjb4rS2hC9QlVGYWGEur6M2Bp60=
Received: from VI1PR06MB4672.eurprd06.prod.outlook.com (20.178.12.161) by
 VI1PR06MB6079.eurprd06.prod.outlook.com (20.177.202.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Wed, 14 Aug 2019 08:14:06 +0000
Received: from VI1PR06MB4672.eurprd06.prod.outlook.com
 ([fe80::4422:b334:d350:f81]) by VI1PR06MB4672.eurprd06.prod.outlook.com
 ([fe80::4422:b334:d350:f81%5]) with mapi id 15.20.2157.022; Wed, 14 Aug 2019
 08:14:06 +0000
From:   Vallaster Stefan <Stefan.Vallaster@tridonic.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH BlueZ 1/1] doc: Add Pub/Private ECC shared secret to
 obscure sensitive data
Thread-Topic: [PATCH BlueZ 1/1] doc: Add Pub/Private ECC shared secret to
 obscure sensitive data
Thread-Index: AQHVUkHNwoTcC3yek0S5BRXum/3Ww6b6SrPw
Date:   Wed, 14 Aug 2019 08:14:06 +0000
Message-ID: <VI1PR06MB467234CEDF299A9BFAB04B18F6AD0@VI1PR06MB4672.eurprd06.prod.outlook.com>
References: <20190814014357.32453-1-brian.gix@intel.com>
 <20190814014357.32453-2-brian.gix@intel.com>
In-Reply-To: <20190814014357.32453-2-brian.gix@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Stefan.Vallaster@tridonic.com; 
x-originating-ip: [146.108.200.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c01b090-9b46-4035-9f2c-08d7208f6051
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR06MB6079;
x-ms-traffictypediagnostic: VI1PR06MB6079:
x-microsoft-antispam-prvs: <VI1PR06MB60796141FD0C10E52F349130F6AD0@VI1PR06MB6079.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01294F875B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(396003)(376002)(136003)(13464003)(189003)(199004)(2906002)(66066001)(6116002)(5640700003)(2351001)(7736002)(66446008)(64756008)(486006)(5660300002)(446003)(476003)(76116006)(2501003)(8936002)(66946007)(33656002)(81166006)(66556008)(66476007)(81156014)(11346002)(25786009)(6916009)(74316002)(305945005)(3846002)(55016002)(30864003)(256004)(6436002)(71200400001)(5024004)(8676002)(14444005)(71190400001)(316002)(102836004)(186003)(53936002)(52536014)(26005)(478600001)(99286004)(6506007)(53546011)(6246003)(7696005)(9686003)(229853002)(86362001)(76176011)(14454004)(14743001)(219293001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR06MB6079;H:VI1PR06MB4672.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: tridonic.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tQFNg5dI8d/TaqySgapHLNe+f3AGWo4HEErtA+vrLyDnnGCei308LRg6v2SCDdkrgCZMi+vFouUereeiBEriJRnd4057MM2xZk8WpBg68FbKNHQ6NNcIjYiDbY3jyIVVIMj9J2SpP2ffwlbWtrvCQwJ7p8xt2Sw1j4uI29Lp89GS1OoudvncdLARRdFCR9yEey2ArzxXmPE+ofELGRV2AgKS96Hj5D5AUnyXop9jEXjvzC1l2p2o6kMgOceYC3vRidSPUXtJ99/Tkux8vwDEZEyFm8f0AsB1bqbrdDqJnzYwSNEHQr9uWC7Hvrr6Jylr9TDpPIfdf5dNf42u7OxE7McID7usDJWImxj/s/UESIaeplzaKAJwIxrajVpgjTFZ8DhaJ9krxe7R0lWM7hIPTvyndi5ka38jZEYOtsRrZls=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tridonic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c01b090-9b46-4035-9f2c-08d7208f6051
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2019 08:14:06.3659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b206608-a593-4ace-a4b6-ef1fc83c9169
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k7quk0RzpNePPY+O4UcNE2MSGS3WnCzJH/agJt7WkbQrhCji6i8on5J67x2cxfjv1C0NvFUzRv6qNIWWn7x3mETMjNx3vNKarY3VmIceHFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6079
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I have a question concerning this change. AppKeys can also be sent using th=
e Node1.DevKeySend() method and a Config AppKey Add
 message. I assume that with a D-Bus sniffer an appKey could be extracted a=
s well that way, will this be considered in the future as well?

Best regards
Stefan

-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@v=
ger.kernel.org] On Behalf Of Brian Gix
Sent: Mittwoch, 14. August 2019 03:44
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org; johan.hedberg@gmail.com; brian.gix@intel.com; inga=
.stotland@intel.com; michal.lowas-rzechonek@silvair.com
Subject: [PATCH BlueZ 1/1] doc: Add Pub/Private ECC shared secret to obscur=
e sensitive data

Certain pieces of parameter data should be considered as sensitive when the=
y are sent over the D-Bus, as they will be vulnerable to D-Bus sniffers. Th=
ese data parameters can reveal which are assumed to be secrets shared betwe=
en the Daemon and the owning applications. The data that needs to be secure=
d over D-Bus includes:
- Tokens
- Dev Keys
- Net Keys
- App Keys

ECC Pubic/Private pairs were selected for security because ECC and ECDH sha=
red secret handling is native to Bluetooth Mesh.
---
 doc/mesh-api.txt | 102 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 91 insertions(+), 11 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt index 255104ab6..b6d40db4f=
 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -8,7 +8,8 @@ Interfaceorg.bluez.mesh.Network1
 Object path/org/bluez/mesh

 Methods:
-void Join(object app_defined_root, array{byte}[16] uuid)
+void Join(object app_defined_root, array{byte}[16] uuid,
+array{byte}[64] app_pub_key, uint32 diversity)

 This is the first method that an application has to call to
 become a provisioned node on a mesh network. The call will @@ -29,6 +30,15=
 @@ Methods:
 therefore attempting to call this function using already
 registered UUID results in an error.

+The app_pub_key parameter is the public part of an ECC
+Public/Private key pair that has been generated by the
+application, which will be used to generate a symetric
+encryption key to obscure the token.
+
+The diversity parameter is used as the nonce when encrypting
+the token. The same app_pub_key + diversity pair should never be
+used more than once.
+
 PossibleErrors:
 org.bluez.mesh.Error.InvalidArguments
 org.bluez.mesh.Error.AlreadyExists,
@@ -39,7 +49,8 @@ Methods:
 method.

 object node, array{byte, array{(uint16, dict)}} configuration
-Attach(object app_defined_root, uint64 token)
+Attach(object app_defined_root, array{byte}[8] token,
+array{byte}[64] app_pub_key)

 This is the first method that an application must call to get
 access to mesh node functionalities.
@@ -56,7 +67,15 @@ Methods:
 the application when it first got provisioned/joined mesh
 network, i.e. upon receiving JoinComplete() method. The daemon
 uses the token to verify whether the application is authorized
-to assume the mesh node identity.
+to assume the mesh node identity. The token is encrypted with
+the synchronous key of the ECDH shared secret.
+
+The app_pub_key parameter is the public part of an ECC
+Public/Private key pair that has been generated by the
+application, which will be used to generate a symetric
+encryption key to obscure the token. A diversity nonce of
+Zero is used for this call. For each Attach(), the app_pub_key
+should be newly generated.

 In case of success, the method call returns mesh node object
 (see Mesh Node Hierarchy section) and current configuration @@ -106,16 +12=
5,23 @@ Methods:
 org.bluez.mesh.Error.AlreadyExists,
 org.bluez.mesh.Error.Failed

-void Leave(uint64 token)
+void Leave(array{byte}[8] token, uint32 diversity)

 This removes the configuration information about the mesh node
 identified by the 64-bit token parameter. The token parameter
 has been obtained as a result of successful Join() method call.

+The diversity parameter is used as the nonce when encrypting
+the token. The same diversity values should never be used more
+than once and always increase, until a new App public key has
+been generated and attached with.
+
 PossibleErrors:
 org.bluez.mesh.Error.InvalidArguments

-uint64 token CreateNetwork(object app_root, array{byte}[16] uuid)
+array{byte}[8] token CreateNetwork(object app_root,
+array{byte}[16] uuid,
+array{byte}[64] app_pub_key, uint32 diversity)

 This is the first method that an application calls to become
 a Provisioner node, and a Configuration Client on a newly @@ -136,6 +162,1=
5 @@ Methods:
 therefore attempting to call this function using already
 registered UUID results in an error.

+The app_pub_key parameter is the public part of an ECC
+Public/Private key pair that has been generated by the
+application, which will be used to generate a symetric
+encryption key to obscure the token.
+
+The diversity parameter is used as the nonce when encrypting
+the token. The same app_pub_key + diversity pair should never be
+used more than once.
+
 The returned token must be preserved by the application in
 order to authenticate itself to the mesh daemon and attach to
 the network as a mesh node by calling Attach() method or @@ -151,7 +186,8 =
@@ Methods:
 org.bluez.mesh.Error.InvalidArguments
 org.bluez.mesh.Error.AlreadyExists,

-uint64 token Import(object app_root, array{byte}[16] uuid,
+array{byte}[8] token Import(object app_root, array{byte}[16] uuid,
+array{byte}[64] app_pub_key, uint32 diversity,
 array{byte}[16] dev_key,
 array{byte}[16] net_key, uint16 net_index,
 dict flags, uint32 iv_index, uint16 unicast) @@ -168,6 +204,15 @@ Methods:
 therefore attempting to call this function using already
 registered UUID results in an error.

+The app_pub_key parameter is the public part of an ECC
+Public/Private key pair that has been generated by the
+application, which will be used to generate a symetric
+encryption key to obscure the token.
+
+The diversity parameter is used as the nonce when encrypting
+the token. The same app_pub_key + diversity pair should never be
+used more than once.
+
 The dev_key parameter is the 16-byte value of the dev key of
 the imported mesh node.

@@ -208,6 +253,24 @@ Methods:
 org.bluez.mesh.Error.NotSupported,
 org.bluez.mesh.Error.Failed

+array{byte}[64] daemon_pub_key GetSessionPubKey()
+
+This method returns an ECC public key, created fresh each time
+bluetooth-meshd restarts. The public key is used to secure all
+privledged information from being sent in the clear over D-Bus.
+
+The returned daemon_pub_key may be combined with a the private
+member of a key pair to generate an ECDH Shared Secret, which is
+used to encrypt and decrypt the following data before sending
+over D-Bus:
+Tokens - Private Node identifier owned by the App
+Device keys
+Network/Subnet keys
+Application keys
+
+PossibleErrors:
+org.bluez.mesh.Error.Failed
+
 Mesh Node Hierarchy
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 Serviceorg.bluez.mesh
@@ -487,7 +550,8 @@ Methods:
 org.bluez.mesh.Error.InvalidArguments
 org.bluez.mesh.Error.AlreadyExists

-void ImportSubnet(uint16 net_index, array{byte}[16] net_key)
+void ImportSubnet(uint16 net_index, array{byte}[16] net_key,
+uint32 diversity)

 This method is used by the application to add a network subnet
 key, that was originally generated by a remote Config Client.
@@ -498,6 +562,10 @@ Methods:
 The net_key parameter is the 16-byte value of the net key being
 imported.

+The diversity parameter is used as the nonce when encrypting
+the net_key. The diversity values should increase by at least 1
+for each call to Import or Export any type of key.
+
 This call affects the local bluetooth-meshd key database only.

 PossibleErrors:
@@ -584,7 +652,7 @@ Methods:
 org.bluez.mesh.Error.DoesNotExist

 void ImportAppKey(uint16 net_index, uint16 app_index,
-array{byte}[16] app_key)
+array{byte}[16] app_key, uint32 diversity)

 This method is used by the application to add an application
 key, that was originally generated by a remote Config Client.
@@ -598,6 +666,10 @@ Methods:
 The app_key parameter is the 16-byte value of the key being
 imported.

+The diversity parameter is used as the nonce when encrypting
+the app_key. The diversity values should increase by at least 1
+for each call to Import or Export any type of key.
+
 This call affects the local bluetooth-meshd key database only.

 PossibleErrors:
@@ -626,7 +698,7 @@ Methods:
 void CompleteAppKeyUpdate(uint16 app_index)

 This method is used by the application at the completion of
-a Key Refresh Procedure.  This method should be called for each
+a Key Refresh Procedure. This method should be called for each
 app key being updated during the procedure, and must be
 performed prior to changing the phase of the bound net key
 to phase 3. (See SetKeyPhase() method).
@@ -656,7 +728,7 @@ Methods:
 org.bluez.mesh.Error.InvalidArguments

 void ImportRemoteNode(uint16 primary, uint8 count,
-array{byte}[16] device_key)
+array{byte}[16] device_key, uint32 diversity)

 This method is used by the application to import a remote node
 that has been provisioned by an external process.
@@ -670,6 +742,10 @@ Methods:
 The device_key parameter is the access layer key that will be
 will used to decrypt privledged messages from this remote node.

+The diversity parameter is used as the nonce when encrypting
+the device_key. The diversity values should increase by at
+least 1 for each call to Import or Export any type of key.
+
 This call affects the local bluetooth-meshd key database only.

 It is an error to call this with address range overlapping @@ -728,7 +804,=
7 @@ An example mesh application hierarchy may look like this:
 | |   - org.bluez.mesh.Element1

 Methods:
-void JoinComplete(uint64 token)
+void JoinComplete(array{byte}[8] token, uint32 diversity)

 This method is called when the node provisioning initiated
 by a Join() method call successfully completed.
@@ -740,6 +816,10 @@ Methods:
 permanently remove the identity of the mesh node by calling
 Leave() method.

+The diversity parameter is the nonce, saved from the Join()
+call, that is used with the ECDH shared secret to encrypt the
+token.
+
 void JoinFailed(string reason)

 This method is called when the node provisioning initiated by
--
2.21.0

________________________________
 The contents of this e-mail and any attachments are confidential to the in=
tended recipient. They may not be disclosed to or used by or copied in any =
way by anyone other than the intended recipient. If this e-mail is received=
 in error, please immediately notify the sender and delete the e-mail and a=
ttached documents. Please note that neither the sender nor the sender's com=
pany accept any responsibility for viruses and it is your responsibility to=
 scan or otherwise check this e-mail and any attachments.
