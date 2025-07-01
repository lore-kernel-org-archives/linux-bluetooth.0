Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013063.outbound.protection.outlook.com [40.107.159.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4761885B8
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751387899; cv=fail; b=F1rayeU9mySZbhKPgR9W8E9xs+CRczq5jmCqrV7aSrUKfxiRyF+hN7bO6FHNpMez3JdGhOizVsedhd5Q/R4SAPYTOpaXPILRaF3BoWuFCx9st3vb8NvRgktZnwE6F0Tx5UPq9QAEGS1BMZqkcs22nbpRnLd+PkV97dUJ6zTOicM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751387899; c=relaxed/simple;
	bh=Tnd77Pn5cAvBodoWr1Cg+N2EIwXrkU9m6pyBsEibPG4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UrVjj/f2peAlFERoo6/fYWrnFkPE2oShY5xFJKdFfZiftfWOCFmo/53bwTTID83r2fCZoK8kjBxYivMaXlJG2ecmy9/YJFi+CV06SmkrHh4+tPL3SmU7L51EzneJHRNwMPC4kvj4j64V/xeNP6NQIpzbRsWuEGRY14eT+PYf40M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=NyEHbzLU; arc=fail smtp.client-ip=40.107.159.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="NyEHbzLU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMSojnMhklfmis1N+mnnA35KFMWq+MIhg45XA766pm6ZXAvRplRDJYNOl5z+Pe1EJIzi6gpADC+j5Tmle+GE2UQU32n06uoIYKxQrQ+abipkfSpu0FJUws3QqCDBARwYy5mDU09udb46QHamKfLykdK22v6yvq/nY/DraGOR62rQnQkOFj0WitCkQCk1XXK/7T6Dwg21Lnra20u4lnebEKrccWI+t7Ci7WGgKZYiQ42xQx8W6qRStc3dwiEXB3MOrs3p/fUpJlMV/3ngZHnAXIcqtHVyKfYciuHeFgwHqTYyQPvCWpG/2H5p4t0+M42jOlNjIdPHpGKjtDCCkDl6rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktdwJcbFa/fReAKzbuRIKGBaXWAiBEIy5F9cBWtFZus=;
 b=IB5qmR7y6Qwv0foPc9kw5GB4IInWAp2uJkIuROeiYCkQuRIX24MTyZSYDXYxIfoh5TH/kwt0qCxsSOSs3+9auxau5/f2vwwZcng/oCJ/SrhuqnEgNAifVHuBkN8s/qJCxcT0kD2PeDFkn0K4+G1kXP2oAN5v1G2G8jCjXgDCJWoz4X1x50KkcphwI1t6W6OV+dveQCRTguEeEMhPhCtPhp/1hEqT2HQ5ERchHldJJVrlswiuyaxMb37j2D22oCBvKB7fLN8GDqZif8+tTtWIMRm1zMsYUshLuUrwVPrKeJ1+J/UPs8KoPnn7z9+R47Y55scniN56L+N0kElI99ErQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktdwJcbFa/fReAKzbuRIKGBaXWAiBEIy5F9cBWtFZus=;
 b=NyEHbzLUdT5uswCv8F9j+fjihhGejDAG9wvUeVPjvySPjdX48JR++rmmufAVvboJ4uSRnEZQR1z7bjTHKfb5b1YDUjNHeUhyktPpUGeTZ/nGcKYVKVZdlvP+6PKGho4eC846AWnapnqK4QGyI1XnJqxsi276vmy8etCebOgDL2o=
Received: from AM0PR02CA0093.eurprd02.prod.outlook.com (2603:10a6:208:154::34)
 by PAVPR03MB10102.eurprd03.prod.outlook.com (2603:10a6:102:30d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Tue, 1 Jul
 2025 16:38:06 +0000
Received: from AM2PEPF0001C714.eurprd05.prod.outlook.com
 (2603:10a6:208:154:cafe::7a) by AM0PR02CA0093.outlook.office365.com
 (2603:10a6:208:154::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.32 via Frontend Transport; Tue,
 1 Jul 2025 16:38:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM2PEPF0001C714.mail.protection.outlook.com (10.167.16.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 16:38:06 +0000
Received: from n9w6sw14.localnet (192.168.54.20) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Tue, 1 Jul
 2025 18:38:06 +0200
From: Christian Eggers <ceggers@arri.de>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, Brian Gix <brian.gix@gmail.com>, Inga
 Stotland <inga.stotland@gmail.com>
Subject: Re: [RFC PATCH BlueZ 0/4] Initial support for GATT Proxy Service
Date: Tue, 1 Jul 2025 18:38:05 +0200
Message-ID: <2308158.vFx2qVVIhK@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <CABBYNZLUu3KnXBOeCkWHtpG_es+yF7vzXjd-fOsHv-S_UMWU2A@mail.gmail.com>
References: <20250701144647.19572-2-ceggers@arri.de>
 <CABBYNZLUu3KnXBOeCkWHtpG_es+yF7vzXjd-fOsHv-S_UMWU2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C714:EE_|PAVPR03MB10102:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c3a968-9aa7-4442-a10e-08ddb8bda815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OE1uYkY3TEVxNFhrb3NpT1VxTndDUmphL2VBRmUwc1V2bE50eERmbW9TbHlq?=
 =?utf-8?B?NkZNUU5GSVNvaXd6cUlWYVhya1FkT1BSOEx0dGlaKy9GcnVEaW1LU0lYQUcw?=
 =?utf-8?B?Q3ZWWnZUU05SYkhiVWNVZjFhMWpqTXN3dTZoUTBlcklwOHRDTUhsa0F0UDVj?=
 =?utf-8?B?UnI3bDFWLzVUUlFrOURtSzJxeXpjWkhKK3lPeWpkWFpDREFSY3VrN1ZPaFhD?=
 =?utf-8?B?anhXNG5kWlM0VGlGOFkwNlJwYytReHZPK0FId2VBS0xaaFJvSFlPaWFwbjV4?=
 =?utf-8?B?Y2RiMGJQNFdPaU5VeHBEZ0xiRG95endtZVF2VVJ2a3hnNk43ZEZTcXZNK1Za?=
 =?utf-8?B?MHFXUXZoWU1ldW5rL1d0NDNaVVdyZ0FHNDg5amZxWXM4bU5FUnRQcTF5STZk?=
 =?utf-8?B?VTJmRGFmckZBRWc2UWh1b3lrd25nK0pzSE1HNzA4c1czejNFajJRM1FvRXJo?=
 =?utf-8?B?YUNaTzY1M2RrZnlMTERvRUtQUEVIK3o4cDlzUWdMUnllWnJuS3Z3OWlPbjBs?=
 =?utf-8?B?eEFrVFRNSzVORmVUYmhNYXFRNjVQRTkwWVE3V3VXZW11dExIQ3QvNkdjQmJR?=
 =?utf-8?B?dUR3VDdleFFFUGR3VXZXR1RuWXkxMnVnM3I0bnFJVFBJeHpyRXVYaGNoMGZp?=
 =?utf-8?B?V21HZzhZUTFJUUVENHVKVW9wcklMdzFRYmhkRmxaQy9iUDkzS0Z6c2ZZOHV3?=
 =?utf-8?B?WkJOR2F2M0ExN0orVDJTb2N0MURXblFQUERXcGhvSURSbnRvcitBb0NnK0p2?=
 =?utf-8?B?RldvRDZkVmZLV0FjaXR4ZTdhakJyZE5NdkpjVlFyUXIvSEMwWnhPKyt2NjBO?=
 =?utf-8?B?eVFFR2VOQnRsSUEyUEl6eXEwN3RtZlpoaE1JYUhsUmJJdHJjaWR1RTRTVnZk?=
 =?utf-8?B?VDFqMVV3bHEvd1ZuV3VubUVVTW4rd2JYUzBUVVJqZFRwTEdrS2ZybC9YWDlY?=
 =?utf-8?B?K2pHRnVCWXczYk5EemhqMWRoK05Ta0Noc2dZcnEzM1AxNVU5YVRXSFp2TEJX?=
 =?utf-8?B?UnZ6K29MUG91OGlXaUpzS3ZBNnZBSXBjNFNBaTFkQk9LUGtlR01GU2doU3R4?=
 =?utf-8?B?a2VWTHloYkVwTHRvVU5Tdm5veEplb2JqRlJPY0RtdmJVNkJCMDVNUEtaUjBB?=
 =?utf-8?B?cVdMNTdTSUFXN3dDMzVvU00vQ2ZFTjJVL1Zzc3NBcjRFeGVZU0laZC84TkFZ?=
 =?utf-8?B?WWJYT0xsMlExQWxVdGlhR3MvYjVwbm9kcERmcFp4UzVpd0tCN1hKWDBFaFJI?=
 =?utf-8?B?VUt2SUcxZHExelllNlA2MmFXOE03UFNVOEsvckd6MzZYT09DUVVZRmR1SHBS?=
 =?utf-8?B?QjlodVdacXVIdWthbzhQOVp3eDRyZFg4UkNScTlMUEkycEZKRWZHaXdnV0dC?=
 =?utf-8?B?eGlWeUJoRTNmSzZ3RFdMM1EwZ2FCRkl0VVdXSWQxQ1d2QkczUzJlMGIxZjBJ?=
 =?utf-8?B?MVVMaW1YUEwwZnJNcWN3OFJLY21JditkTS8zMExkWi80SWNTQ0doalIvdGto?=
 =?utf-8?B?RWxKYmU3Z2wxOFFVU3MvU0hsZDJucXRKakZXMmEwSzRmVjd2cFdZNzFGWFo0?=
 =?utf-8?B?aXZ0ZDExN1I0bS84M1NIYi9wcThjd1dyblNCOEJuTnJDTU1KOHpiLzliUDVS?=
 =?utf-8?B?Y2NOVk5ZVlhINUFLNmsyUjRqZWpoVWtBa0tlUlc0UU1qbmpXVVE5ZXhZWlZZ?=
 =?utf-8?B?eUlyWkh2L0JNUW9LN0I2dDI3Wk95M2xhSzV1QWtKR1ZvVEoxUW5Od0NBYmFY?=
 =?utf-8?B?QkhIdVg0TDZTaUtPYy9hekFncEU0aER2b05MNHRLbXMvZzd4enFSa3AxdVhN?=
 =?utf-8?B?eStNTHE4cURNOVRvTC9xbm8yVnhtZlpxSDRXYWMxaU03RnF4SWNpQmd0NG5h?=
 =?utf-8?B?eGNiS3NPN1BkU0pVREsvL01GU3V1anB3Q1lFNXlJWjdmSzFNSHd0NVcvOWMz?=
 =?utf-8?B?RmlVNU5OYkUwbXEyc0tJSVJtbEluZ2xSbXkwVERGalNLV0hsZE5CUDA2TW5u?=
 =?utf-8?B?R1kyQXRQWUluaVpvMW55UW9qTnhydWJNZE5Qdk1uTDY4Smh3Zm5VT2Q3UjBR?=
 =?utf-8?Q?4FvqTa?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 16:38:06.4420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c3a968-9aa7-4442-a10e-08ddb8bda815
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C714.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB10102

Hi Luiz,

On Tuesday, 1 July 2025, 18:07:06 CEST, Luiz Augusto von Dentz wrote:
> Hi Christian,
>=20
> On Tue, Jul 1, 2025 at 10:47=E2=80=AFAM Christian Eggers <ceggers@arri.de=
> wrote:
> >
> > This series adds initial support for the GATT Proxy Service feature.
> > This allows provision and management of MESH devices from mobile phones.
> >
> > Before continuing, I would be happy to get some feedback about this ini=
tial
> > part (and about what has to be done in order to mainline it). Any help =
for
> > doing the missing features (e.g. relaying between GATT and ADV) would be
> > highly appreciated.
> >
> > What seems to work:
> > - Provisioning from another Linux computer via meshctl (sometimes I need
> >   to repeatedly enter 'discover-unprovisioned on' and 'provision <uuid>'
> >   if it doesn't work on the first try).
> > - Reading the composition (composition-get in meshctl). It looks like
> >   meshctl tries to connect to the GATT Proxy Service automatically after
> >   provisioning, but I have to enter 'connect' several times in order to
> >   get a connection. You also need to manually set the target unicast
> >   address ('target' command in 'config' menu).
> > - Adding extra network keys (Advertising for GATT Proxy Service cycles
> >   between different network ids every 3 seconds).
> > - Transferring and binding of application keys.
> > - Using the OnOff client in meshctl (you again have to set the unicast
> >   address in the 'onoff' menu).
> > - Provisioning and configuration of an OnOff device from iOS (using
> >   the SMART+ app from Ledvance). This app requires at least basic
> >   support for proxy configuration messages (patch 4/4).
>=20
> Meshctl is sort of considered deprecated by meshd, it was created
> because at the time bluetoothd and meshd couldn't operate in the same
> controller so we need the GATT client to be used against bluetoothd,
> which is why the whole tools/mesh-gatt is sort of duplicated from
> mesh/ portion, but now that there is possible to have both bluetoothd
> and meshd we should probably move meshctl to be a client of meshd
> directly and then remove the whole tools/mesh-gatt/ directory.

<Not sure whether I understand you correctly>

I am working on the GATT Proxy Server (in bluetooth-meshd), whilst meshctl
implements the GATT Proxy Client. Having a deprecated test program is much
better than having nothing :-).

Although I haven't checked for this, I guess that meshctl could become comp=
letely
obsolete if GATT Proxy Client support was added to bluetooth-meshd. In this
case, provision would be done by mesh-cfgclient regardless whether the
link established by bluetooth-meshd is using ADV or GATT.

My patch series mainly makes bluetooth-meshd a client of bluetoothd (which
normally operate independently). As bluetoothd is (exclusively?) responsible
for GATT and LE advertising, using these technologies in meshd requires it
to use the D-Bus interfaces provided by bluetoothd.

>=20
> > What maybe added later:
> > - Proper selection of the output interface (GATT vs. ADV) when sending
> >   messages.
> > - Relaying of network messages / beacons between GATT and ADV
> >   interfaces (in order to access further devices via the proxy).
>=20
> Afaik the tools/mesh-gatt does already relay messages, but since it
> has been a long time I don't deal with mesh perhaps I don't remember
> it correctly so please have a look.

I only had a short look, but I think that tools/mesh-gatt can only perform
configuration of the 'relay' feature on a GATT Proxy Server (switch
relaying on/off on a remote system). But probably I haven't got the big
picture yet.

>=20
> > Note: I don't use the test-join script, because python3-pygobject is
> > (currently) not available on my (embedded) system. Instead, I use a
> > custom C++ program for the 'Join' and 'Attach' D-Bus calls.
> >


