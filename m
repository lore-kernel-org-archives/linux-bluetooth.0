Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2136.outbound.protection.outlook.com [40.107.243.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E72E573;
	Tue, 30 Jul 2024 19:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722367874; cv=fail; b=m/hxq82zXkvXXtd8UThq2l6aV0924l84+Rt6N6oIk1il/M6WGUwwRZHaEQgWxV7emNLbwWz7goi8XlA5wxqbTSZo1tDXEWAk67peZ5ilo/3ETqqiol7mT0D6HHP4sZ7YCmSMrNa66L3nSSYtF9IoqOKYzNES1EH41eulGamRkqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722367874; c=relaxed/simple;
	bh=YKqewLhLG0dvvmJ1j6rfzVPTpKjqF7DEf+pGmc+7eys=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e/S7mGBuf2fyY4BVUMv0nP54hick3h3vAXu4loWwtGU7yx3tIgKBX+7lsbTubH+qjmzoXxvRUnVG4XYhaVhuq5S/LF+4jZZomgIJeELvoWQD8HBlAv1xj5m+DR0eQz0GlxUWbpLdj0yZLbAAs/JSKm+Bf5OwUXNb5E4QwdGf/tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=purdue.edu; spf=fail smtp.mailfrom=purdue.edu; dkim=pass (1024-bit key) header.d=purdue.edu header.i=@purdue.edu header.b=MnjA9RsD; arc=fail smtp.client-ip=40.107.243.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=purdue.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purdue.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=purdue.edu header.i=@purdue.edu header.b="MnjA9RsD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JfDe8HEvC5nX0tOSzf+kBLhFRkCPbpGL2o0q/jWaokzzlh0Gbq4GoSo9osq9uQRf5Baui055XKkE2pLLuoUDKO6e7mToIRYAPoNVXabH2jTivvGA0XgF3kCtQfq6C6Gn1BdtGGyVmqDKL87ohodUxMidDCS78ovsQ/OVUQfthg6UxjnJEq7JApFtkUQG40C6+5Hh0Yw2IocQXLjgdhhTEMEtmz4MJwkFlddzzyLGLppkmAO3NmcBT//K+CRjRgAmLoZmqm2vM7RmWTu8Cc2aejgjRcm6JH9q8U8EBZpPPDoxiP51sTWDX+YwLQ4iDI+QWHAvLgUpRFFAE+sVEh8s5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/KV4BwX1MD1KY+wviJtHKZ2pxDehnIGpR98XAYH2fY=;
 b=KkztHaolbMYZt0EzcPFTCK+aRIunGL7Wux/uJyKmb6ZLzprVa+tThHnio40SbLQFdS6XctHm7dWGfhyAtHp9h7jQ3eNpYu/1cRdv+Pr3ESbQkKTfY5K1nnojvCzNrBwyWajJRYtd6Dv6RrJbPH7mzS0xWYD6dLjTxa58sk8SEF4C+W1+QuhnledKfgrHFI5ZZtcz6iH18uFbd3Zdw1r9BplWY+ot9N3mKyWSE1AZ34SsDEK9bt27imdA84HDO8nFow/HOrWkTPlruQHo/x/UbF2HbO6PbLP+MdLYrqp1ql9hTp66qSuoHnpGCuYFwVnU+rcWy2HoWg7sHfcQ4ljunw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purdue.edu; dmarc=pass action=none header.from=purdue.edu;
 dkim=pass header.d=purdue.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=purdue.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/KV4BwX1MD1KY+wviJtHKZ2pxDehnIGpR98XAYH2fY=;
 b=MnjA9RsDED7end0mh7TakoIEtWTg0ZQ+BM80hxgMUviuOBLTBly/GR+dR2g1E8Aa2zcRX4dwJfFZ3rVTowiS8Snmwk97PtkaaVYu7v/CtYJHRWlLzcgJnCD10uRZ+uW+SkfH9GfoPQYBnOFWm5I9kIhQhRafek2ZH8qJUs0JO5g=
Received: from SA2PR22MB2697.namprd22.prod.outlook.com (2603:10b6:806:144::9)
 by SA1PR22MB4320.namprd22.prod.outlook.com (2603:10b6:806:38e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 19:31:09 +0000
Received: from SA2PR22MB2697.namprd22.prod.outlook.com
 ([fe80::3b4b:6b83:c392:39ff]) by SA2PR22MB2697.namprd22.prod.outlook.com
 ([fe80::3b4b:6b83:c392:39ff%3]) with mapi id 15.20.7784.017; Tue, 30 Jul 2024
 19:31:09 +0000
From: "Zhang, Yiwei" <zhan4630@purdue.edu>
To: "marcel@holtmann.org" <marcel@holtmann.org>, "johan.hedberg@gmail.com"
	<johan.hedberg@gmail.com>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Karim,
 Imtiaz" <karim7@purdue.edu>
Subject: Potential Null Pointer Dereference in pair_device() in mgmt.c
Thread-Topic: Potential Null Pointer Dereference in pair_device() in mgmt.c
Thread-Index: AQHa4rQMFuQUg/kDG0CzhlBWRxYHQbIPpv6s
Date: Tue, 30 Jul 2024 19:31:09 +0000
Message-ID:
 <SA2PR22MB2697E3286F69BADCE0B70A4CBFB02@SA2PR22MB2697.namprd22.prod.outlook.com>
References:
 <SA2PR22MB269778F2D988179243165558BFB02@SA2PR22MB2697.namprd22.prod.outlook.com>
In-Reply-To:
 <SA2PR22MB269778F2D988179243165558BFB02@SA2PR22MB2697.namprd22.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=purdue.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR22MB2697:EE_|SA1PR22MB4320:EE_
x-ms-office365-filtering-correlation-id: 4129ac22-20dc-4262-6a18-08dcb0ce2a29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?e6Dej/FAGx245Jp+n3Ee45aKOJXr/sp1NLpA4UZX4/yBE3opaOnZPS/mIL?=
 =?iso-8859-1?Q?yLGe/i2ErL3uQgbjHku99aOOu8C42x4wnIo97hOpeRKNRVGOGhU8Fb9ntP?=
 =?iso-8859-1?Q?iQW/SFBg6PFIqHYCoeZQukRUaQj6FjK+jgrEQLQwvcRTCZqnWg4TamXSqx?=
 =?iso-8859-1?Q?ETTiFVE1b+me4zvZ18O98795HqV/6etO/y/+KcWpX/kg++hEw+pMXYl4qR?=
 =?iso-8859-1?Q?HsBo+6mJzbqAvJORcdMc3rZdBiCkIwznZt0INnFjRfh6e5oq48F4qOru3d?=
 =?iso-8859-1?Q?8F4wrW01OM6sqScXeiytFOtGRAlj2rq1EfyL2pffIfBTQeFvuigLjs9rzH?=
 =?iso-8859-1?Q?DmJDrwyrtiKv7YOaXmwYjsoY8clOjLYkeLfXf2gU2HHnbe1VwD1RtdD2Y3?=
 =?iso-8859-1?Q?u5TiuqZw8JtcrH/++m3jTUjYS+HSaYOOOH18d/R/fNqmRlInc9TiDnnX7t?=
 =?iso-8859-1?Q?9y+yATQzEfF4C5AD75RsSSIJMCrZbG4Y7sTAlBJjVPEYtox0AdO4WeLu30?=
 =?iso-8859-1?Q?mJvcbz9M/PD4C0e83jtPJjvIsnDAs/3x9esC91GlyVZjTZQvIRJas3x4GP?=
 =?iso-8859-1?Q?9N0DuFqhxCWY3lYQHd6tNdOF73nKjKhkRHe0uWEaqvASSZ6lM/d9DzAfON?=
 =?iso-8859-1?Q?D0o1RLOmct6ulj58a2lOb7hL6qiTl76EuO5yrRwyQx+gYvr97OC9Cgfx/2?=
 =?iso-8859-1?Q?o0Y07r61XEbKeNCi6NofWpz19Ti3TdQ/KlpAn7ACSlySSb1TqKMUbqxR4z?=
 =?iso-8859-1?Q?zRrrGTg17SP9dWDrw2kitqwLAGhqZj9tYP02E8NqDwp6hQfiIkLubOsdZN?=
 =?iso-8859-1?Q?vq023yMOsgMXZOtyQ77JrWgvKOlCDL1XQ05iD2Cxb6Hm3m0qeyUFzZ8fzR?=
 =?iso-8859-1?Q?jDoeX2R6bnx1w7qb4JEx53wFDbyKGqpTeon9w71rZwCotB8/scH7ohdZNl?=
 =?iso-8859-1?Q?metoaC8SbAGec+wynq9XHNqPmXLuwX1aq3xsuB5CknC/Z7xEo5her7Tul+?=
 =?iso-8859-1?Q?gDNhnJE/OGAXw5FXZdL/O1heQxl9Hlwhlqvb3u6EOur8Y1vEZzLVrHLI1h?=
 =?iso-8859-1?Q?MbZn0+6N7UktAuERqNDflGJpRe0lHIXemN0ee2qxCGgtBJq9Q3ZPcvxurq?=
 =?iso-8859-1?Q?JomukxlaXIO5n1/ialKVkWdgKecvaCAFUB85LFe38iKktTpLF7IOS49wRu?=
 =?iso-8859-1?Q?XQ7sAGVEC1YYR/zpdUyPWY5NumaH7jxIi92+jSHz1xtkaPmaCy5aon9Jic?=
 =?iso-8859-1?Q?QTXGXkdB9YyjoJ5B0CDVzA+j3Vd/6S1BIymhQxJ1+w2oak7xIU47vbohs7?=
 =?iso-8859-1?Q?bnzsCQIyd2loaRL21Is0AqjPD02SvteR3qNVut/ky8RzC9+THGimfZ1OOR?=
 =?iso-8859-1?Q?7P6zl8D6iFNABlfjHGadZWl+DTlHD9jJLg/Ajjgjs7cCbGFkkr6GQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR22MB2697.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vS38CA117ftUIDOo/vY74emx7h2Zvyd4WxmOmFAU9179Cu+GgbeAKpu2LJ?=
 =?iso-8859-1?Q?hm8W0cFdYpcONqy6CWyhTJG8Lj+9lFKsyMK/UgHr8mTzP9PpuAd3b4hQJ7?=
 =?iso-8859-1?Q?fV+pWLThY3zU/iDmRfBSyP8J+lLc0ijq7RikAIqS6ItWXS6Bua5fWkx+rz?=
 =?iso-8859-1?Q?AdBpRC8MjIETDsjzpTIc4AwDq4ObmNlUFElR0akApZUh5veLwGfsGggxkI?=
 =?iso-8859-1?Q?czx8o0QmmOqjhHDqcpUY1F4KhQg5VdVWTMTW15IY9cmtvS50oj9bWV2C9p?=
 =?iso-8859-1?Q?2TO2YtBTahQVWcN87dTjuIxz7KvPD7FpX8l0t3uKsKjNxo+igUbcdoE3bj?=
 =?iso-8859-1?Q?YUzuvOzJ8+OKwZLAQu3BpWQnTI/HnpSeKZQE4X2wRPMLAABBn/N+lYxKB9?=
 =?iso-8859-1?Q?vYAh95wfUp87bw46KWVpC5nnIYgogQ2qdFa4KzA4b4E+5XqtJKYi47FuSN?=
 =?iso-8859-1?Q?SWCMyd1xFFdmrPzx3FC/A0JYYp322ytxjW/M3HNAiYdbMIdcpcNagb5F5m?=
 =?iso-8859-1?Q?qwB9Ws6BV2tdt+xTStuZ3QsL4HWWt1KK4aeLsqXkopIie/VwYgEwsVnb43?=
 =?iso-8859-1?Q?8IxtvGNLP9vescKoQRdw3rvdH80H/W7G0bzUtiPBEG+++e7+7uxUW5sIuP?=
 =?iso-8859-1?Q?1p3Nmpu1dzRfa1AlQkpXyTkp/2Q7+hUyWjD0DeVkorqeS1xBYVFn0900q2?=
 =?iso-8859-1?Q?kjeCtakX8y+fj/YpqJXvYAUUFMPBn2C4jmOY2nyoJsDzoQ7QFW+AmYpX2g?=
 =?iso-8859-1?Q?TKtPGK65G32c9bpNpuwco0MvLLk4uExMRDNwWk8JH1sZf2ZxfglXtajF2C?=
 =?iso-8859-1?Q?mgiUxjoQwXJ+qNtjVESmMnNaB3QhPfubFJD/1277iKw/ykh+Z/c3lHHyJh?=
 =?iso-8859-1?Q?dskGdd9K7mb8N3qbI6RXfYSGY4DfCTWFNFSY7ZODsuH4SqoPzL3jihF9D9?=
 =?iso-8859-1?Q?UC9AY0ai6aWbmQZkFGW33OEjal026nT9M81ln9yviydbV73amWGFfKSoXA?=
 =?iso-8859-1?Q?1buFnoNgRPv+fltpLAQrfYFF+H/s+ZbLgMb7jsNHZ1s7Pf+Ox3JkC1VYAF?=
 =?iso-8859-1?Q?aUO7HFUEqkX9BZh07Zd7GWb7VZJCapwG1hu3bnLfPnEa7GV2/xQCHEi7tG?=
 =?iso-8859-1?Q?7htchjLLSdWVW5vxdRvMiAJK8HzKnKgREDqh2hXJkJ7uVMjRUIYC58lOYZ?=
 =?iso-8859-1?Q?GvcLavnqjCsCRvvP0WkK1HTCUDecCNFxCDMZuO/P3A9YrPdolrIN1oByk6?=
 =?iso-8859-1?Q?XVqCczQfRkcqDvHRj0GxcdKHgX1Z3YdKbPSlPaoDFDqvsqJTesSbIe0Ms1?=
 =?iso-8859-1?Q?jskzSu0WKm5TxZkbF7gQ5z+7Y8WINgJJHy/Hm9yCrgtGO3vb/pZVZbSezr?=
 =?iso-8859-1?Q?38tBNazpYk2KM+r6Ueg+5Mq/OTHYmVHxninBPVygP/qLnJhvMjYThg8/xM?=
 =?iso-8859-1?Q?m1lnYueVBbuMWHgAoL8ynNEHz0sT/3ksNs1+VuCm3TtN8CzW5RLujtajOn?=
 =?iso-8859-1?Q?WYAxNDhUT+CnpJKDrkQDeKFRUXO9CApOE/GxfwEBZQfFafNWWjAsVvAwu7?=
 =?iso-8859-1?Q?lPgNqxNlHvz7vM6mz3UHeP6Sp2te4fsnqVoHyAkDHOSyYlXRvg2sVNw1jF?=
 =?iso-8859-1?Q?X+KK4wh3fWDL/BCRfaaiSyr7U6vYPEpViH?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: purdue.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR22MB2697.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4129ac22-20dc-4262-6a18-08dcb0ce2a29
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 19:31:09.6613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4130bd39-7c53-419c-b1e5-8758d6d63f21
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T2OjisWocLAyoF3m3xzoOVupZeRbVsFMFFYFWArCF2mK1MxmkE20TWKHi4T/i6R8nJwYHpcohIPmkAgV+CK+gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR22MB4320

Please disregard the previous email. I have modified the email to plain tex=
t format. I apologize for any inconvenience this may have caused.=0A=
=0A=
=0A=
To whom it may concern,=0A=
=0A=
I am writing to report a potential security vulnerability in a Bluetooth st=
ack implementation, specifically in the hci_conn_params_add=A0and pair_devi=
ce=A0functions. The issue identified is a potential null pointer dereferenc=
e, which can lead to a system crash or other unintended behaviors.=0A=
=0A=
The details of the bug are as follows:=0A=
=0A=
=0A=
1.=A0Affected Components=0A=
Function:=A0linux/net/bluetooth/hci_core.c hci_conn_params_add=0A=
Function:=A0linux/net/bluetooth/mgmt.c pair_device=0A=
Module: Bluetooth connection parameter management=0A=
Code: https://github.com/torvalds/linux/tree/master=0A=
Version: the newest version v6.11-rc1=0A=
=0A=
2. Description=0A=
The hci_conn_params_add=A0function is responsible for adding connection par=
ameters for a Bluetooth device. It first attempts to look up existing param=
eters using hci_conn_params_lookup. If no existing parameters are found, it=
 allocates a new structure using kzalloc, which will return NULL if the all=
ocation fails.=A0=0A=
However, the pair_device=A0function, which calls hci_conn_params_add, does =
not properly handle the case where hci_conn_params_add=A0returns NULL, indi=
cating a failure to allocate memory. The immediate dereference of the retur=
ned pointer p=A0without checking for NULL=A0can lead to a null pointer dere=
ference, causing the program to crash.=0A=
=0A=
3. Technical Details=0A=
struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,=0A=
					 =A0 =A0bdaddr_t *addr, u8 addr_type)=0A=
{=0A=
	struct hci_conn_params *params;=0A=
=0A=
	params =3D hci_conn_params_lookup(hdev, addr, addr_type);=0A=
	if (params)=0A=
		return params;=0A=
=0A=
	params =3D kzalloc(sizeof(*params), GFP_KERNEL);=0A=
	if (!params) {=0A=
		bt_dev_err(hdev, "out of memory");=0A=
		return NULL; // [BUG] return here=0A=
	}=0A=
=0A=
	bacpy(&params->addr, addr);=0A=
	params->addr_type =3D addr_type;=0A=
=0A=
	list_add(&params->list, &hdev->le_conn_params);=0A=
	INIT_LIST_HEAD(&params->action);=0A=
=0A=
	params->conn_min_interval =3D hdev->le_conn_min_interval;=0A=
	params->conn_max_interval =3D hdev->le_conn_max_interval;=0A=
	params->conn_latency =3D hdev->le_conn_latency;=0A=
	params->supervision_timeout =3D hdev->le_supv_timeout;=0A=
	params->auto_connect =3D HCI_AUTO_CONN_DISABLED;=0A=
=0A=
	BT_DBG("addr %pMR (type %u)", addr, addr_type);=0A=
=0A=
	return params;=0A=
}=0A=
=0A=
static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,=
=0A=
		 =A0 =A0 =A0 u16 len)=0A=
{=0A=
...=0A=
 =A0 =A0 =A0 =A0p =3D hci_conn_params_add(hdev, &cp->addr.bdaddr, addr_type=
; // [BUG] P is NULL =0A=
 =A0 =A0 =A0 =A0if (p->auto_connect =3D=3D HCI_AUTO_CONN_EXPLICIT) // [BUG]=
 NULL POINTER DEREFERENCE=0A=
	 =A0 =A0 =A0 =A0p->auto_connect =3D HCI_AUTO_CONN_DISABLED;=0A=
...=0A=
}=0A=
=0A=
Vulnerable Code Stack:=0A=
pair_device=A0calls hci_conn_params_add=A0at line 3458 in linux/net/bluetoo=
th/mgmt.c=0A=
hci_conn_params_add=A0is called and may return NULL=A0if memory allocation =
fails at line 2280 in linux/net/bluetooth/hci_core.c=0A=
pair_device=A0does not check if p=A0is NULL=A0before accessing p->auto_conn=
ect. at line 3460 in linux/net/bluetooth/mgmt.c=0A=
=0A=
4. Potential Impact=0A=
Denial of Service (DoS):=A0If the system encounters this null pointer deref=
erence during runtime, it could crash, leading to a denial of service.=A0=
=0A=
Security Concerns:=A0While the primary issue appears to be a potential cras=
h, depending on the context and how the function is used, there may be othe=
r security implications such as unintended code execution or information le=
akage.=0A=
=0A=
5. Exploitation=0A=
For an attacker to exploit this vulnerability, they would need to:=0A=
Trigger a condition where hci_conn_params_add=A0returns NULL=A0(such as exh=
austing system memory).=0A=
Ensure that the pair_device=A0function is subsequently called with the NULL=
=A0pointer, causing the null pointer dereference.=0A=
=0A=
6. Mitigation and Recommendations=0A=
Null Pointer Check:=A0Add a null pointer check after the call to hci_conn_p=
arams_add=A0in the pair_devicefunction. Ensure that the function gracefully=
 handles the NULL=A0case, possibly by returning an error code or taking oth=
er corrective actions.=0A=
Example:=0A=
p =3D hci_conn_params_add(hdev, &cp->addr.bdaddr, addr_type);=0A=
if (!p) {=0A=
 =A0 =A0bt_dev_err(hdev, "Failed to add connection params");=0A=
 =A0 =A0return -ENOMEM;=0A=
}=0A=
=0A=
=0A=
I would appreciate your response to this report and any follow-up actions t=
hat will be taken. Please free to let me know if any problems.=0A=
Thank you for your attention to this matter. I look forward to your prompt =
response.=0A=
=0A=
Best regards,=0A=
Yiwei Zhang=0A=
Purdue University=0A=
