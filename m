Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010044.outbound.protection.outlook.com [52.101.69.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1F02D837C
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 17:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772041748; cv=fail; b=p+XdssIyrDvsnLAiDGAFKnacck5SpwZp7jV7kIDPMlf5HIUNh322rB7qFbUbAjfgRVNsS67GjIebiNkCQJ+cWlJ7N3HO0lI/736FPoFy4KtpHIIaIO4vMLDdHhPoZe1YnNU+4oTbfijizU0JyyS5swTYaUgvAtFfldEagjY+jDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772041748; c=relaxed/simple;
	bh=JldyOn8jhVvRDV8FarizxWycKKsXiqqfdUQ2XGqkqH4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WxuCgDdc7PiEbwMYJBjUygyKRodJjZzDENWmBEjN9wfohBcfUI5WFsssZntv+OYbeGZUuxyhYe+Jz4c+l3oFW0uM2rKd2YxgivYqBwC54IpfZ7fCUU/ZMR0nIG3W10V2qY70Hsf2dGbAZ4+snX2QbgYp3oPWmmcrRYXX+rWv0ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=volvo.com; spf=fail smtp.mailfrom=volvo.com; dkim=pass (1024-bit key) header.d=volvo.com header.i=@volvo.com header.b=drsxZaHQ; arc=fail smtp.client-ip=52.101.69.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=volvo.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=volvo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=volvo.com header.i=@volvo.com header.b="drsxZaHQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4G54jKiWAo1cqedLiTt6D997P5pL5eGOn4HvrGB9X4R2Xxzk5BuLUFklxIvg9nVwmKF6O2HnLoo4DA9aOt3DfAUKMyMhtDGR+BfEQ5a0UOJNQaTueWxNAecIR1tRmvvFt5LkxFiVoTwlmJBkVUh3EMPyf97LBoiJo0FskkmWuj6oYLSlvgt6L1BmabWYiCtj7E8btbxnRvCYMdRIpu/VLw09ABh6HkYwa4nw+W+ZYPA86MPL4rpgl7LvpEJyN+IkfhkOrCS2bV+jcaNp9xah+Y65K1gQeRDGOa0PM8C40NdzwBVzOVmhF0VJC2xXqWZKQM4POc4GVB9KtgzkKIMQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Ad05RRl/joSr+eJdzoPwKhmTFiVkbh1GI1aRo7JXJw=;
 b=Ql4OsaJc9E5a24YyZcR7P82UlVWiPKpLLoLgSLsNONL/+w1VvvnTmjWqPBnCbOC1eZ3auME2BfNBLCIMCI4vgGmiznOBoGGy3cbEp73OsUVJiRmRB7kkymmB6bjuo5UJ8c+mPxk0HsI7/YphmW1pl0RR4UzNOItXhNWClmHYVTpnonGArbvGKfRwHnqWPLjlF94+zkhTUv2wmOd2fioy86Eyl+jB5BjABqj3qNHwHpLB91ssOb1r0/zaQmu9X5y9GbWb8lYV74FgeRQbWcdrgVO8/e2BmBUAo3Z6YKcn3UGrNLW0d9ji0ExoTELjOR0rKU/ms/HV11AV8/KCGycKqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volvo.com; dmarc=pass action=none header.from=volvo.com;
 dkim=pass header.d=volvo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=volvo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ad05RRl/joSr+eJdzoPwKhmTFiVkbh1GI1aRo7JXJw=;
 b=drsxZaHQJLBu0dW+sNE7WVqWqgpMUi30jZVfpNx+pDCytY2GJqiGTl7/BZmuxaR1QASQfTv8BRl4nMcYKJswspPmoEaSMaQorNTjphVnfxdcu159RL4ShU3g+BLaKjvD04F5ES4svAk3msg2Yf1X8hAqcc9wBzpyMmImQEwBh+E=
Received: from AM7PR05MB6790.eurprd05.prod.outlook.com (2603:10a6:20b:13f::20)
 by PAVPR05MB10331.eurprd05.prod.outlook.com (2603:10a6:102:2fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 17:49:02 +0000
Received: from AM7PR05MB6790.eurprd05.prod.outlook.com
 ([fe80::37f7:d824:94d1:cdf2]) by AM7PR05MB6790.eurprd05.prod.outlook.com
 ([fe80::37f7:d824:94d1:cdf2%2]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 17:49:01 +0000
From: Dajid Morel <dajid.morel@volvo.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH v2] Bluetooth: Increase LE connection timeout for industrial
 sensors
Thread-Topic: [PATCH v2] Bluetooth: Increase LE connection timeout for
 industrial sensors
Thread-Index: AQHcpn5EHxDMkbPdNECHUo2YD90JYA==
Date: Wed, 25 Feb 2026 17:49:01 +0000
Message-ID:
 <AM7PR05MB6790817B215F2B9B88B8C4EBEC75A@AM7PR05MB6790.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_bd2ff15f-6ce8-47f3-93ce-f81f88196d24_Enabled=True;MSIP_Label_bd2ff15f-6ce8-47f3-93ce-f81f88196d24_SiteId=f25493ae-1c98-41d7-8a33-0be75f5fe603;MSIP_Label_bd2ff15f-6ce8-47f3-93ce-f81f88196d24_SetDate=2026-02-25T17:49:01.517Z;MSIP_Label_bd2ff15f-6ce8-47f3-93ce-f81f88196d24_Name=Open;MSIP_Label_bd2ff15f-6ce8-47f3-93ce-f81f88196d24_ContentBits=1;MSIP_Label_bd2ff15f-6ce8-47f3-93ce-f81f88196d24_Method=Privileged;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volvo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR05MB6790:EE_|PAVPR05MB10331:EE_
x-ms-office365-filtering-correlation-id: bbffc074-bd4b-4770-c8d9-08de74962940
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 tzkzULrLzUQQD+vBRopVn85h8man/5zBLJ80D4yQLIQhmGgn9O9UERY/lN6JIqgfv3WcXuqQKGXxkpgpgC1yDqT8v8pP2V/YmXQ2MeVEtwWDV9A96Z7OLMn2fjjPRVbidxcx93dID3YaV31f/3xrTzeWdTdIAVH6kZMDnp5TbxI7/qolVmD4jAj0IdgKVwFZbP4Rn49zddkN7WEYEqGFf654mVes1P3GuUZ+w8vhLuZPXkW22XuaRkNVHQ9JsqLhETV8sREWgLxiFkN19eICNoBNWmdgq1fQ1N8AEp2/ZJywAMBLza5T+sMwpFb5qYjNpcHxeOmOn1qpgMJcCRT+JkUKFythhIHcSQsrdJL5weMU3hnVckn1JwPS9SCwMl+BAu8fNAD8DnUAfWjXXkEhbV1OTjqHLme+ULAk5KWuvvDPuqrjYrswteGwgcMIOu2nvH0L5L4YUX1+5yFG6z4+yYEMYY9zA22EKyx+km4OT+PFRfSLxn9WgXLH107UAGwSG4C5+Xw5N9An1oa1v9K4G0UXsm9X/SmIRqqsNJi30mpRRtRd/Pzdza7oMc+766i3+zSs2eMS8mIBJi0IH4x0TwKV7L9B50CijXDGni/QQ3EyyTReTG3Xa+e6Rdor4R0NXzPbiXZqYTxgne3Yvi2LpdaNcRz8t3XSAOt0gGeZlBKsuUdsss9OAvkxLa7ad9TzKGNTVU8P2Xo150nyUlS5/JEinop+Em1japksmwS7djrxk9ppzZydADk54AxnsL4TjR/73jmoDG1/NG4t1DsanVqSggbtrtfCq84nbRqp0LY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR05MB6790.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?5R9gn1Hd2/I+XPwrAdbspl7IDqeAE54iraEPMjjzLp7v2BqCNkD9guocFZ?=
 =?iso-8859-1?Q?boJkReYgghj4R5ZhYU+62I8L5/HwtPnKg15T2q73iUCMFLKs9pcCd/0/6B?=
 =?iso-8859-1?Q?vUD9R8xQkwFFvQgumEH4/wrJyC7kgKifpNEc3UbWI01K98kIJl6dQcfT9B?=
 =?iso-8859-1?Q?GCQPtIZGF5ZnYGjfIZsrjJFO8WoAfekx8LcNNGsPbTSw/G8PIcAZYZk3im?=
 =?iso-8859-1?Q?6zPLDavteVhWAwz6Eco6evtEEexZwD2gaU8nYwxE5cG23F7ZE56zWIlBnR?=
 =?iso-8859-1?Q?ZPi4ZWS3IO4E04YQGC0k8CrN+3/DF2FcFS3WaACVn5k0vOVc63dWzOKqL/?=
 =?iso-8859-1?Q?eEUc6C+DwXFPgyc9kpNGjkEilSaaXU1FTI+tGEXhoRB2ba6ZMMBkR/VWvR?=
 =?iso-8859-1?Q?0w27r8JoVbCosWJSLJxuA61aSGAj41OERidjEYDY8Nsri5AuJhghttchAt?=
 =?iso-8859-1?Q?QgDDzJCmCOAIPx1FOXVNfK6FMB7l313o5SzMP0hYZecj6lmvM+4aDM3XT1?=
 =?iso-8859-1?Q?ZMgVNPhDB3a4ne0Pii0h0Fph6RP8I2m0ygbHoor5lxE/7EitZ+TgsHPzlz?=
 =?iso-8859-1?Q?Tao3vM/cxVLjcXqMXc4ThYy9iRjmTThvw+CPOj6cugV4WG5vH5pPPIFD4L?=
 =?iso-8859-1?Q?MPHt1AwPFgXUOmHSkHuklcYfjVWbIyZBB40X9oSxJDdI9kRP4JaTFJPbhw?=
 =?iso-8859-1?Q?jHXdHcS6WS1kHfv87hGug4A6okzP0VP7/b5m07a/diJByzM38bLaNISqbe?=
 =?iso-8859-1?Q?4beTb0tU2xWNnFCl9fmXDwFZGX55wucdUU1CbUOItGdzfuXFvBMV0vgIQ+?=
 =?iso-8859-1?Q?1nJj6yT1Ue+miqYGZDLxxbKgRF940QlwlYIUazkf83jJL1IBw5g5V+VrxK?=
 =?iso-8859-1?Q?mN8QGE5sPcb3gEYK7tXRkrV96pNBMImqHz0WZDf2dwgKfJTDJ7rUyfgU8h?=
 =?iso-8859-1?Q?yzvs8vJrYESFP5fTIaB/zT4Sk9jLstkpWPNxUEL5vxJ31eSTBUZjggH2fY?=
 =?iso-8859-1?Q?BMKxlnJMRtm62VM5GCvte2pRmTgSjJLVeC6z2oiWRPyfWmKkTR18QXkrny?=
 =?iso-8859-1?Q?R5bShi03elQTNnzFHK3hjmjq+m946L5EtXHHw4O44w58GVRhtkfGB7zhtk?=
 =?iso-8859-1?Q?sA+N1OK6BE22CBC7SO+gx4wi7ew9DpfsRKjJGyRTFmxguKMItWoKsNQ7mb?=
 =?iso-8859-1?Q?AwBa0dwbcdE1w5eMGTB7IbR3qQ+xmgzjSX+gHhd3rz08DytyKhGKSPMibp?=
 =?iso-8859-1?Q?pN/5covXATamEPzkE5X3VcJmALbA3qULuxJjsYMvUkDWwzREM7StfElKy1?=
 =?iso-8859-1?Q?2kE4cbAO8zdltraSMjJF9LBXQr9EXbUx3JT8dIphteoXJPjHsct4ZICJxX?=
 =?iso-8859-1?Q?sWGoj1TDLot56QUJ1j49X4pzFkhGC/DYSOS6rlYC4rJv9lqHNnbQ8DMjIu?=
 =?iso-8859-1?Q?Mv068qOOhqQddsxxVfAbZUhNnYyyFnRGVIeKMZiXWJr3s//st+dG1kMwo2?=
 =?iso-8859-1?Q?NTkA/3Lufopxup8q0O+Z1UtW4396D8MMdvemfaD0tNpO5LMJQY3e2gODmL?=
 =?iso-8859-1?Q?d9FBQCwJtlPmrXti0+T0k5Dfvtej0ZwWwkRuNKegJ4dz61CeBDfNmu/1/M?=
 =?iso-8859-1?Q?yCu60rSNdwKb/BRARFOa8zVeGKPh1QVoWCUfnEW3xe1BiITh0eKPlP8rZQ?=
 =?iso-8859-1?Q?OslbfFz8G4zT1O8fmTWsXIIpgYU1ZluwzlKK8lwD24C462A8TRwlOexCVe?=
 =?iso-8859-1?Q?cZ7XbQJBdJSQCMj5ATxKXHRRdY755F55lTnT+++NWE2UI9?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: volvo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR05MB6790.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbffc074-bd4b-4770-c8d9-08de74962940
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 17:49:01.9082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f25493ae-1c98-41d7-8a33-0be75f5fe603
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PITuJ13iyJOwZax61C2tNWDosQlwp7WQUfrYMDoQEg+uJcIVV+Qqh144Br9CtZ2JL3Nssl5iP9j+b9Dwwh6BdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR05MB10331

From f3b8a3b01db23e9adc59ba5dbf99b1a83741e32b Mon Sep 17 00:00:00 2001

From: Dajid Morel <dajid.morel@volvo.com>

Date: Tue, 24 Feb 2026 22:10:35 +0100

Subject: [PATCH v2] Bluetooth: Increase LE connection timeout for industria=
l

 sensors



Signed-off-by: Dajid Morel <dajid.morel@volvo.com>



Bluetooth: Increase LE connection timeout for industrial sensors



The hardcoded 2-second timeout in hci_conn.c is insufficient for certain

industrial BLE sensors, specifically all the TE Connectivity sensors.



These devices often exhibit high latency during the initial connection

handshake in electrically noisy industrial environments. Testing showed

that a 2-second window leads to a 100% failure rate, whereas increasing

this to 20 seconds ensures reliable connectivity without negatively

impacting the rest of the Bluetooth stack for these specific use cases.



This value was chosen to provide a comfortable margin for handshake

retries in degraded RF environments typical of manufacturing plants.


A more scalable solution might be to introduce a variable whose value can b=
e defined by the user ?



Signed-off-by: Dajid Morel <dajid.morel@volvo.com>

---

 net/bluetooth/hci_conn.c | 4 ++--

 1 file changed, 2 insertions(+), 2 deletions(-)



diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c

index d177b7f49..8aeed0962 100644

--- a/net/bluetooth/hci_conn.c

+++ b/net/bluetooth/hci_conn.c

@@ -1131,7 +1131,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev,=
 bdaddr_t *dst,



  conn->dst_type =3D dst_type;

  conn->sec_level =3D BT_SECURITY_LOW;

- conn->conn_timeout =3D conn_timeout;

+ conn->conn_timeout =3D msecs_to_jiffies(20000);



  hci_req_init(&req, hdev);



@@ -1301,7 +1301,7 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *=
hdev, bdaddr_t *dst,

  conn->dst_type =3D dst_type;

  conn->sec_level =3D BT_SECURITY_LOW;

  conn->pending_sec_level =3D sec_level;

- conn->conn_timeout =3D conn_timeout;

+ conn->conn_timeout =3D msecs_to_jiffies(20000);

  conn->conn_reason =3D conn_reason;



  hci_update_background_scan(hdev);

--

2.34.1

This email message (including its attachments) is confidential and may cont=
ain privileged information and is intended solely for the use of the indivi=
dual and/or entity to whom it is addressed. If you are not the intended rec=
ipient of this e-mail you may not disseminate, distribute or copy this e-ma=
il (including its attachments), or any part thereof. If this e-mail is rece=
ived in error, please notify the sender immediately by return e-mail and ma=
ke sure that this e-mail (including its attachments), and all copies thereo=
f, are immediately deleted from your system. Please further note that when =
you communicate with us via email or visit our website we process your pers=
onal data. See our privacy policy for more information about how we process=
 it: https://www.volvogroup.com/en-en/privacy.html
