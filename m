Received: from alln-iport-2.cisco.com (alln-iport-2.cisco.com [173.37.142.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E886023C4E3
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 19:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.142.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757620608; cv=fail; b=bNS8mAYoe+10XxdqVY2EFUKgHvUrFUdVg3uyRWnXo32g5q3ethxR6wVCGWMYHO/05aXaaBpSOtp+Xd5CjENxUI/aQpocFt7hicQ0H61u3yYagunw9EU60l1v8Xt7Rhj8k3LK1+e7bgbq27HCS3UOcUSHGCzgRWbd56Egerpnp7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757620608; c=relaxed/simple;
	bh=EKo2+hXqJnYcuaFGJhBSJ7aJ756t4VBMSCKqrzFi4jU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W3YAOTX7szZMZ0iGk4YSNA67t6v+KnRZVkIDdclVCD6VYOfNuYeVEJSZjpXvNweyn6xQdZWncNJlE3ruV54b/fHBVlsqtDuqwdw0eCfb5P6ySJ1Ke3uyWYYWrU4JdQ25IIx9VFEPaySnx2a0nrRO4Sn97zcT6nZ3WX6fckrI8YI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=CFbgDmEI; arc=fail smtp.client-ip=173.37.142.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="CFbgDmEI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=4738; q=dns/txt;
  s=iport01; t=1757620606; x=1758830206;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EKo2+hXqJnYcuaFGJhBSJ7aJ756t4VBMSCKqrzFi4jU=;
  b=CFbgDmEI0CmkNuZpUhK//RjXb6RTusLcqb6CHEOBXIHR69wsa8fK0c8t
   SXrN9PZQu5ZNK18XM5uVs0JcBxQUV9YB+ekgA2m1J9/DqaxjFLj1efw8o
   dk+pvA7wJpQ6uxswO1I4sl+PEv7bINBwWCxYe6mp367cUNRXe6D1a0FwN
   1NQ9NRPcKih/N/94QadKz9f8AbOmZITmVXQMcB8uhhdbGNGrSecYqQOGF
   /FmbxyQ/lbjFMJJhmRXMYUIf8vu+IB/57vH5HfX+6hIvq+jz5sc5av94U
   RU0j4i2EKzaOJ62HqCDcWIQiXSD22K+3gPafb9Eb/+Ye5p+IWoOXTVhRC
   w==;
X-CSE-ConnectionGUID: YtppZvHNQXSy5pYjijqHag==
X-CSE-MsgGUID: JLObLqZPQ76oU8kQUsuYjQ==
X-IPAS-Result: =?us-ascii?q?A0AFAAAeKcNo/4oQJK1aGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAJYEbAwEBAQEBCwGBbVIHeQKBHEmEVINMA4UsiHYDi?=
 =?us-ascii?q?2SSNoF/DwEBAQ0CRA0EAQGFBwIWjBkCJjUIDgECBAEBAQEDAgMBAQEBAQEBA?=
 =?us-ascii?q?QEBAQsBAQUBAQECAQcFgQ4Thk8NhloBAQEBAxIREUUFCwIBCBEEAQEBAgImA?=
 =?us-ascii?q?gICHhEVCAgCBA4FCBqCYYI6AzUDARClEQGBQAKKK3qBMoEB3T4NglUGgRsuA?=
 =?us-ascii?q?YgxHgGBboN+hHcnG4FJRIEVQoI3MT6CH0IBAxiBSBWDRDqCLwSDOIYkgXODa?=
 =?us-ascii?q?YQwgUWKDwlJeBwDWSwBVRMXCwcFXkJDA4EPIw88BS0dgSd5hBSEHStPghxyg?=
 =?us-ascii?q?Q8BZFdAg1MSDAZrDwaBFRlJAgICBQJDPoFrBhwGHxICAwECAjpXEIF9AgIEe?=
 =?us-ascii?q?kADC209NxQbBQQ6ewWVBoMoBi5OPQKBIEgERwqXG65lcQqEHJtbhjIXhASUF?=
 =?us-ascii?q?ZJSmQaCWI85lwUCBAIEBQIQAQEGgWoCOIFZcBWDIhM/GQ+OLRYcg0K5eXgCA?=
 =?us-ascii?q?TkCBwEKAQEDCZNnAQE?=
IronPort-PHdr: A9a23:N8+UchF3WJz/XspITqBiU51GfhMY04WdBeZdwoAsh7QLdbys4NG7e
 kfe/v5qylTOWNaT5/FFjr/Ourv7ESwb4JmHuWwfapEESRIfiMsXkgBhSM6IAEH2NrjrOgQxH
 d9JUxlu+HTTDA==
IronPort-Data: A9a23:05r2R63cLdgYPUg0ufbD5YRwkn2cJEfYwER7XKvMYLTBsI5bp2AEx
 2seXDrUa/jfamX0ed5/PY6xox4AusPTx943SVNo3Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ5yFjmG4E70aNANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXU6
 bsen+WFYAX4g28tazpPg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ajs7XAMEhhXJ/0F1lqTzeJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUekFPLzOTWXcG7lyX7n3XQL/pGPV0uJb8G2sBOMVpfq
 OQpKjEPdzCKiLfjqF67YrEEasULJc3vOsYb/3pn1zycVa9gSpHYSKKM7thdtNsyrpkRRrCFO
 YxAN3w2N0Sojx5nYj/7DLomg+6hiX7XeDxDo1XTrq0yi4TW5FEtjei9YISKJrRmQ+13umGSg
 nv0x12mXBYnZN+m9CGYw3CV07qncSTTHdh6+KeD3vprhkCDg2YXFRAKUlynodGnhUOkHdFSM
 UoZ/mwpt6dayaCwZtD5Wxv9pDuPuQQRHoIJVeY78wqKjKHT5m51G1Q5c9KIU/R/3OceTj0x3
 VjPlNTsbQGDepXOIZ5B3t94dQ+PBBU=
IronPort-HdrOrdr: A9a23:PxPk2qs3XYAJ2XZ4Nr5lRSv37skCMIAji2hC6mlwRA09TyXGrb
 HMoB1L73/JYWgqOU3IwerwRpVoIUmxyXZ0ibNhW4tKLzOWyVdAS7sSo7cKogeQVBEWmdQtr5
 uIH5IObOEYSGIK8voSgzPIUurIouP3jZxA7N22pxwCPGMaDp2IrT0JdjpzeXcGPTWucKBJb6
 Z0kfA33wZIF05nCfiTNz0uZcSGjdvNk57tfB4BADAayCTmt1mVwY+/OSK1mjMFXR1y4ZpKyw
 X4egrCiZmLgrWe8FvxxmXT55NZlJ/K0d1YHvGBjcATN3HFlhuoTJ4JYczAgBkF5MWUrHo6mt
 jFpBkte+5p7WnKQ22zqRzxnyH9zTcV7WP4w1PwuwqgnSW5fkN+NyNyv/MfTvLr0TtngDi66t
 MT44utjesSMfoHplWk2zGHbWAwqqP+mwtTrQdatQ0tbWJZUs4QkWTal3klTavp20nBmdoa+O
 UCNrCv2N9GNVyddHzXpW9p3ZilWWkyBA6PRgwYttWSyCU+pgEy86I0/r1Wop47zuN3d7BUo+
 Dfdqh4nrBHScEbKap7GecaWMOyTmjAWwjFPm6eKUnuUPhvAQOAl7fnpLEuoO26cp0By5U/3J
 zHTVNDrGY3P0bjE9eH0pFH+g3EBG+9QTPuwMdD4IURgMyweJP7dSmYDFw+mcqppPsSRsXdRv
 aoIZpTR+TuKGP/cLw5ljEWm6MiX0X2fPdlzerTAWj+1/4jAreawtDmTA==
X-Talos-CUID: 9a23:U0neN2z5kBITSmAimqbEBgUlBtg9QGP96k7gGF7lEVdrSb+MaVafrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AP/xkZA2OFPLS4bjd/zxkuVv3qzUjwYCJAmQUo60?=
 =?us-ascii?q?/5JeDCHxzAgqGkQW1e9py?=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-01.cisco.com ([173.36.16.138])
  by alln-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 11 Sep 2025 19:56:40 +0000
Received: from rcdn-opgw-1.cisco.com (rcdn-opgw-1.cisco.com [72.163.7.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-01.cisco.com (Postfix) with ESMTPS id 18A4B180001BD
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 19:56:40 +0000 (GMT)
X-CSE-ConnectionGUID: D6N8FBfDQlyowSIiA2iSEw==
X-CSE-MsgGUID: TRbMXW1jRimEYTF8Z52WKw==
Authentication-Results: rcdn-opgw-1.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.18,258,1751241600"; 
   d="scan'208";a="35088811"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by rcdn-opgw-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 11 Sep 2025 19:56:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdbcpSzxsxZkwTr8nZT51u6wUIXc7/SzbnkpV1GaFTCFps/j3iS8zj7ZfniwqmRLXUMaE4c1aGtv62RE83S6yhZRvaZnB3y89nNK9GF3sZ7PwwhNF5tTpo+ZSNYZnFiHL7iABgZ/8kOa8cCuQ0YlkuKu9bcoYBjWJA0GBd70BWru4CEgkFaGCHgo1IN2wlIx4TxOxLUr3jmX+kQ0wWJA1ZZy0RleHcKnLeZJNImXSsvhrGkleyYZ5+SUNbGq8t/Lf+pWcDkekKBV4ueqNu1w1IR2hfmtYq4DIHLdGC7C0GnaeyYmM15kwwoAnba4N4wLumH4X77CDOkUBdHshWI5UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKo2+hXqJnYcuaFGJhBSJ7aJ756t4VBMSCKqrzFi4jU=;
 b=D+Zvlc45Z5IiZeewHCB1/1+61xK8YfPqdqeEB04+MCOvdG4Ch3U6Fd1PwRonbEjG3ISQSEoeoPenvVDnSoy7lU38JwaNA0aFwU/0vXQjrncBIjPRQJ5GA8txg6lKfSSuYt0CHQgNo/OOY48yNzRSWXzqcwt4OnfbykrEGlOVXtQS/aZriR3TCdMJZaiN2W77Ct/QclSZiz6c18vYuztPcnnM1vuGphgCooYECUbd/9rwLpd475K0NW5FBhcrHYM94Q91BFo1BvNIRP94DrieckvDz0TVAb7ewPu1NXAb0h2A+iHwOVLSmrPpORQwJmdBYVTjF2TQ0imK1nWBMRQteQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from PH0PR11MB5596.namprd11.prod.outlook.com (2603:10b6:510:eb::23)
 by SJ1PR11MB6203.namprd11.prod.outlook.com (2603:10b6:a03:45a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 19:56:37 +0000
Received: from PH0PR11MB5596.namprd11.prod.outlook.com
 ([fe80::5576:1e5d:a1fc:fd50]) by PH0PR11MB5596.namprd11.prod.outlook.com
 ([fe80::5576:1e5d:a1fc:fd50%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 19:56:37 +0000
From: "Per Waago (pwaago)" <pwaago@cisco.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Pauli Virtanen <pav@iki.fi>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] audio: Add support for specific error codes for
 A2DP configuration
Thread-Topic: [PATCH BlueZ] audio: Add support for specific error codes for
 A2DP configuration
Thread-Index: AQHcIyNse09Q26QPykCsFwy/ITn3obSODnyAgAACvCaAABCQgIAAPoNp
Date: Thu, 11 Sep 2025 19:56:37 +0000
Message-ID:
 <PH0PR11MB5596133842B1D4C387EB2486CF09A@PH0PR11MB5596.namprd11.prod.outlook.com>
References: <20250911135301.1538126-1-pwaago@cisco.com>
 <CABBYNZLBJ_Q6S+OGam-Q92Agbe0HK5dX4WxFrFpnntcDhu1gow@mail.gmail.com>
 <PH0PR11MB5596318A1EFBC5DF72C41D5CCF09A@PH0PR11MB5596.namprd11.prod.outlook.com>
 <CABBYNZ+==BYte8=C5jLwDrMs-GJkvOOxAXRMPO2Zv=2zxk8C2Q@mail.gmail.com>
In-Reply-To:
 <CABBYNZ+==BYte8=C5jLwDrMs-GJkvOOxAXRMPO2Zv=2zxk8C2Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5596:EE_|SJ1PR11MB6203:EE_
x-ms-office365-filtering-correlation-id: 3341aeb2-8086-4ce8-276e-08ddf16d5188
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|13003099007;
x-microsoft-antispam-message-info:
 =?utf-8?B?YTZoVjgzelhYM2cvR0JocXA4dGFwRloyU01SZkp4eVFFM1lRREMyMkFUVThQ?=
 =?utf-8?B?WTNHZThCcGJrNWhnOEx5YUtudHdJelJRTWtSa2ptNEo5dkowaEdNakZ6QmhT?=
 =?utf-8?B?eTk5OGxJMEQ2TnRwWTVENFprZG82U3R0YzVmUTk5cmhzMnN6eSt0eERodVNN?=
 =?utf-8?B?RGxxNEJkY2U5QVlVNm9QQmZ3d1kybkptbERHQ3ZzdmlmVitrRVZSYnI0MDVz?=
 =?utf-8?B?RmtMYnZRTkdjeE41TFcvVGpaRnlkbXBqWndWMEYwYVZ2YitCdVArcmdVdE1o?=
 =?utf-8?B?OURXdWMzNDF5ZFV4UTBpcUt0emlzdGFrZG5XWklCS2RTUFZDSTBnRFloc2dT?=
 =?utf-8?B?VTcxeEw1dGxOT1VsTERDWTlvRWk3ZWhTcDEvK1VxOHVZWC9Nb1BoZXBOcFVD?=
 =?utf-8?B?cVphemxQSFp6RFdBSEY3Y0J1M1pwQjM5UmhubldlcFJtUWhmMnNQa0l5SW9K?=
 =?utf-8?B?Ym5jbk14UEpZQ0gyQlljcVF5eVk3YVZOdVJ3WWRldjVKN1E2OGl3VzRUQ0RW?=
 =?utf-8?B?WmxBMjRFSVBLaXE1MVJ2UDAzRXI5UXRMRVd4aTNvS1N4Z2VIaDBFYjN4MEFK?=
 =?utf-8?B?L3huUytDUHBkU1hnR0t6c2ZoeEZ1Rzh5cHVIK0FwWVdPdklQRlZZSGNjN3Ru?=
 =?utf-8?B?NzFRRHNEVFU1ZkZib3EyK1RXdFVISHQ0ZWVyUlVUUk12NkFqUzByemZyOXcw?=
 =?utf-8?B?c2NFVDVQdjlIWThObzRoOTR5TEJMWDU4VTR1NGZ4OFVDdXZsYldVTzBJbWpo?=
 =?utf-8?B?NjVBdGZhb3FxMlVXZk1ESnNXWjNJSDVrcVZ1L3lLMS8rNUxyNmpzUDg2VnRk?=
 =?utf-8?B?cTF1U1hGL0prU3hZOUJYSlhCTmdoMTJWclJIQVhkQkJ6RC91UnQ3bnoyMkNa?=
 =?utf-8?B?OVo0cGlFTkZJd3hQYnBlWVk4OXBFTXlZT2tGNXdxdmF1NXVxbDVUNTZvM3Mw?=
 =?utf-8?B?Y0liQ3VFTDN1eFAzdm1LVGlUWFRiSjJEcVprKytkQ1E0ejJ4OHlIZGZpc3p4?=
 =?utf-8?B?VEZtY1FXcEd0MUJwenU4d2FYK0tqOXdrSDR6SGV4ZDI3b0NRdk5Hc0lIUWxh?=
 =?utf-8?B?eUdjSThvMmNiRkNVZGRCc3RKN1dIVzFFc29KbW8xWGFObis1K0RQNUFOR1Q3?=
 =?utf-8?B?Mnh2VU0rVEtwdVVRWkFJem9hZGExdldtaFdDUlZxVWZkQzlHZkFNeStncG9t?=
 =?utf-8?B?YVp0SkhDOFRXSjExWVM5WjY1U2lPUFR1U1FIMVNxcTZVeGM5Y3J1UlIvajRD?=
 =?utf-8?B?OFV0bnZscTBacFJudGtOSlVlRXlsRlZVajROREE4OXk2azN6bFpFbGE5ejla?=
 =?utf-8?B?ZG1oc1VjUGN1aDk4SGNxSTRCTzl4azNzNmhoUHI5c3RxQk15OEpxeDJ6b1pj?=
 =?utf-8?B?ZVBsdGpTWmRVSzdPc0ZyL1VKV2FSS3ZpSERDcmJWazdEbVM1MEdyalZoMFZz?=
 =?utf-8?B?TkNFay9tcHR4aDdWVXd2R1c5SjFUZTVUdE83WjJXQTFnRFNxRmFYK3NxNVhS?=
 =?utf-8?B?UEtnSUprZmFwQThUWTZacEphbTlxMTV3a3lEYWpDdUIyUWVCaG9VQTYzUnNB?=
 =?utf-8?B?QUNkeUpQV0p2T3hSWlpPNWJoc0x0YmVHbzFmdlVwcGNYMnZVRm9sd3Y1SmRY?=
 =?utf-8?B?UXpUcDZ4OUt4Wkh6Nm0rVUtWamlZd2JJTTZkUFZRc2lFaElXRGJxTkJIQWR3?=
 =?utf-8?B?QmVML2dBMmVNcENNVDh4T0hxRmN5Q3BMYnhxSVBTeXlYZVRKb0pRUmxJQmwy?=
 =?utf-8?B?SFgrQzUxWkZwZHcvNWtuNUxXalVaM2g1YXZIN1k5eWZrMWJWdGVoMkRoa2RS?=
 =?utf-8?B?eWRNSHBOcm1EOTNRdmYrYi9MTTJNZEJKU1FMenBCbHJsNmhQV3VtVTg5d0kx?=
 =?utf-8?B?K1RpQUg1N25JUkxVS0dMcis3eGhjaHl5cWtnVWVMeVlFZStYNDFIVVB2d0lt?=
 =?utf-8?B?VVpCMGUrVjZZZFRsNVQzWFJWbmh2R3AraFBPVHY1TVpTYVZkTlM5V1R6VUp4?=
 =?utf-8?B?MFd5cllSNXRnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5596.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TWRaQnJVL1A4am5WRHcrVE0rdURTTlhCNU44K01UTHJuNDlLT0w4ZjBTODlp?=
 =?utf-8?B?cHNsUWNQcHAyNVVnUkRYdDFMZ0NWNGNFVUV0TTJZQXZucUFaZFVOZzkvUVFI?=
 =?utf-8?B?b0h2bXZQTDcyWTEwTklNeDlDVVRvRGR3STJlVDZoODJHajFwc1JuQkxyV2h2?=
 =?utf-8?B?L1BxTXFCWXFENi9BV3J3b2hiWXkwQlNkMmtsWjJtSDdPMkk5aXhock0rV1FX?=
 =?utf-8?B?dU9OL1Fjbk1CbGhrMmE4RkJTTXRNUW9PcTRLZ09pbUJrTmZHS0J3eGFtWDNr?=
 =?utf-8?B?T2RJRkY5WndOaVhSMWxpTkVndFlFVy82TFpRYk13U0k5dmRnVzdXc1dBVGtL?=
 =?utf-8?B?WUNvWWowL290cTZudW5manFiT2xpMlFuc0NwWEFjeEYzVzFuKys2N3JFbFF5?=
 =?utf-8?B?QkMvR1Y4L1hxMUE4cmNRMTc0azdQUVM0cElNdFhGVE9UdWsydEVkZ0FTK0dP?=
 =?utf-8?B?aWFnUGlzMWFMV1pYbUlkZFFCbjJBalNDR0hnUDhNMHFrT20xM3N1bFdiWjhV?=
 =?utf-8?B?cytGbWI5ek5rUWRnSnVoZzhFcyt4YWUvT3VlZ0NaaTJXcTZUMy9EejFKNXhP?=
 =?utf-8?B?bTFJU291V0g1cXdJcUc5UGVZWldlZlZBMFA4Mmg0UXdVUUZCNUN0bVc2aERF?=
 =?utf-8?B?T0RvSlJRMVVPc2drV1AzQ0VNSWtFSVVsTUZ2OVY3Nm0xTWhjQXJaSGYveTV1?=
 =?utf-8?B?OCsrdkxibitBbC9LWmlwOEJhcnh3enNxL25YRjhSZjJpZTBNeTE0RVQ5ZUdT?=
 =?utf-8?B?WlFySEdnZWFNR2Q0dXRiQlZtUWp1cnRFajNYWW15cytidkVhVndyNFR4anhs?=
 =?utf-8?B?c25CdzNpdzYyWHMvVnduV0xsRHBQSnFWaTVCdm9JM2N6STNHVzhRMEVIWFZR?=
 =?utf-8?B?VlMzYzBCVXlYZ2tiRnhrclAvMVNsbm41WTVuRkpDNXFERWFseUtiRit2c2Zm?=
 =?utf-8?B?bU44VVBKc2h2QnJoSVo0SmhQUUVFbkZwSGRMNkNManpjK3VYT280RVdOREJ4?=
 =?utf-8?B?ZldIajdEZG5YaGRsNEg1dU9GY3ZVdDBpY3V4cHVNa2xtcCtCRnVNVG0xUVBI?=
 =?utf-8?B?MTNOazBHTEFYYnJ2UVdaYWtaU3FlUmlIQ2VFTUsvSlljK0JYZG1mNmdQTkFi?=
 =?utf-8?B?RkhoSzl6L3FBelRSdmhyYmJXYlNpZWFRTW45cWNqU0o4SGtHSlhySWVrQ2Ri?=
 =?utf-8?B?ZzV3SE54ODBwOFRkN0FwUG44a0xmUXVhaHNBUmFsTGhPRFpiMVZCd2xwT2RQ?=
 =?utf-8?B?clg5azRkNmU1SUNrUENLeFp5Z2NudWV5MGtEY0lxZW5kSXYyTWEzWExYbHFy?=
 =?utf-8?B?V1FlSDgwNWFRd1VhaGhoTUk4NzJXdlVrb2tsVFJVVDFMWTNLZDNIbVRHQkk4?=
 =?utf-8?B?Z0VDTzBhMXh6c3N1WE1YVkdTTGpvbVd5UFgrUWJPMkc3UkJQcHlYZU5zY09r?=
 =?utf-8?B?eWdtWUgyVTBmUU1JSldQNHRwRnVCZ2V6S2hlMXZyRVVJSkNvM0ViTVdJVlFY?=
 =?utf-8?B?VXhoa2VrakVlRU0yYXVoNXhsbzJNNElFWGIvQTFabEh6akdLazFWdmFaeG5C?=
 =?utf-8?B?UHA0bks3YjZudUx3UlFEUTI2R29Uc0Q1L0ViZmNTNFRnemhLZXhMa3lDUlZF?=
 =?utf-8?B?OGg3UVJjMVUzYkxySmNjNHpNSUEyMVdCTFY4bEtVTG9aTnFHTlM2ZVpDNnRj?=
 =?utf-8?B?WnNZWTNEU0JxSTUzK2dyaFdFbTRCSmVtcDljL2hNMzVUVnRyeVJJSXZUbVJY?=
 =?utf-8?B?Zk5hRS9tb2FMMWprSWdxTTV2K1N2UThPK0lQT1M2Wm90VlNCanFZZFlNZnVR?=
 =?utf-8?B?OVdWY0swZDZ3VmdVeU9EK1JPeHFQWEVISm5nUStwdDhYa3Aya1RPaWNqaElI?=
 =?utf-8?B?WmRtejgwYUllc0I2SmFSOWFyRXhJQ1NBTUpjMjNpMlk3d2h0M0VXUUlLL1Y0?=
 =?utf-8?B?VlVQQ1NtSStCdjlrVCtjVWRFc0ZTL3JmZHdKWUx3Uk5uQWthRlROZXVrdnNt?=
 =?utf-8?B?d1dsbGY1NVZibXE3M3BuekpTZHczVmt1RGMreXVoYzZJR3RxNkNSNGx4UUpx?=
 =?utf-8?B?WDVVSWZYSCtUNzhwOGdhMEVremlHdTkzdmZ6a0pSdjlBbDhhSmFQVjZLbHB1?=
 =?utf-8?Q?mdLo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5596.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3341aeb2-8086-4ce8-276e-08ddf16d5188
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 19:56:37.7921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MLqhrFW7N/sI4ZHxmGw6397Q5/F/SDvzCEIe9gXVa98C7nYBvCZiYB0jrgQjT6k9SjERS+VwhHFgd3H0MiMx7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6203
X-Outbound-SMTP-Client: 72.163.7.162, rcdn-opgw-1.cisco.com
X-Outbound-Node: alln-l-core-01.cisco.com

CgoKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gRnJvbTogTHVp
eiBBdWd1c3RvIHZvbiBEZW50eiA8bHVpei5kZW50ekBnbWFpbC5jb20+Cj4gU2VudDogVGh1cnNk
YXksIFNlcHRlbWJlciAxMSwgMjAyNSAxNzo1Mgo+IFRvOiBQZXIgV2FhZ28gKHB3YWFnbykKPiBD
YzogUGF1bGkgVmlydGFuZW47IGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmcKPiBTdWJq
ZWN0OiBSZTogW1BBVENIIEJsdWVaXSBhdWRpbzogQWRkIHN1cHBvcnQgZm9yIHNwZWNpZmljIGVy
cm9yIGNvZGVzIGZvciBBMkRQIGNvbmZpZ3VyYXRpb24KPiAKPiBIaSBQZXIsCj4gCj4gT24gVGh1
LCBTZXAgMTEsIDIwMjUgYXQgMTE6MTLigK9BTSBQZXIgV2FhZ28gKHB3YWFnbykgPHB3YWFnb0Bj
aXNjby5jb20+IHdyb3RlOgo+ID4KPiA+IEhpIEx1aXosIHRoYW5rcyBmb3IgcmV2aWV3aW5nLgo+
ID4KPiA+ID4gRnJvbTogTHVpeiBBdWd1c3RvIHZvbiBEZW50eiA8bHVpei5kZW50ekBnbWFpbC5j
b20+Cj4gPiA+IFNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgMTEsIDIwMjUgMTY6NDMKPiA+ID4g
VG86IFBlciBXYWFnbyAocHdhYWdvKTsgUGF1bGkgVmlydGFuZW4KPiA+ID4gQ2M6IGxpbnV4LWJs
dWV0b290aEB2Z2VyLmtlcm5lbC5vcmcKPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCBCbHVlWl0g
YXVkaW86IEFkZCBzdXBwb3J0IGZvciBzcGVjaWZpYyBlcnJvciBjb2RlcyBmb3IgQTJEUCA+IGNv
bmZpZ3VyYXRpb24KPiA+ID4KPiA+ID4gSGkgUGVyLAo+ID4gPgo+ID4gPiBPbiBUaHUsIFNlcCAx
MSwgMjAyNSBhdCA5OjU24oCvQU0gUGVyIFdhYWfDuCA8cHdhYWdvQGNpc2NvLmNvbT4gd3JvdGU6
Cj4gPiA+ID4KPiA+ID4gPiBUaGUgQTJEUCBzcGVjaWZpY2F0aW9uIGRlZmluZXMgZXJyb3IgY29k
ZXMgdGhhdCBzaGFsbCBiZSB1c2VkIGlmCj4gPiA+ID4gdGhlIGNvZGVjIGNhcGFiaWxpdGllcyBj
b250YWluIGltcHJvcGVyIHNldHRpbmdzLiBUaGlzIGNoYW5nZSBhbGxvd3MKPiA+ID4gPiBjbGll
bnRzIHRvIHRyaWdnZXIgdGhlIHNlbmRpbmcgb2YgdGhlc2Ugc3BlY2lmaWMgZXJyb3IgY29kZXMg
YnkKPiA+ID4gPiByZXR1cm5pbmcgdGhlIGNvcnJlc3BvbmRpbmcgZXJyb3IgbWVzc2FnZXMgZnJv
bQo+ID4gPiA+IE1lZGlhRW5kcG9pbnQxLlNldENvbmZpZ3VyYXRpb24uCj4gPiA+ID4KPiA+ID4g
PiBUaGlzIHVwZGF0ZSBpcyBmdWxseSBiYWNrd2FyZHMgY29tcGF0aWJsZTogY2xpZW50cyBwYXNz
aW5nIG90aGVyIGVycm9yCj4gPiA+ID4gbWVzc2FnZXMgd2lsbCBjb250aW51ZSB0byByZWNlaXZl
IHRoZSBkZWZhdWx0IGVycm9yIGNvZGUgYXMgYmVmb3JlLiBPbgo+ID4gPiA+IG9sZGVyIEJsdWVa
IHZlcnNpb25zLCB0aGVzZSBuZXcgZXJyb3JzIHdpbGwgYWxzbyByZXN1bHQgaW4gdGhlIGRlZmF1
bHQKPiA+ID4gPiBlcnJvciBjb2RlLCBlbmFibGluZyBjbGllbnRzIHRvIGltcGxlbWVudCBzdXBw
b3J0IGZvciB0aGUgbmV3IGVycm9ycwo+ID4gPiA+IHdpdGhvdXQgYnJlYWtpbmcgY29tcGF0aWJp
bGl0eS4KPiA+ID4KPiA+ID4gV2hpbGUgSSBjYW4gc2VlIHRoZSB2YWx1ZSBmb3IgZGVidWdnaW5n
IEkgZG91YnQgd2UgY291bGQgZG8gYW55Cj4gPiA+IGhhbmRsaW5nIG9mIHRoZXNlIGVycm9ycywg
c28gdGhlIHJlc3VsdCB3b3VsZCBiZSB0aGUgc2FtZSByZWdhcmRsZXNzCj4gPiA+IG9mIHdoYXQg
ZXJyb3IgaXMgc2VudCBiYWNrIGl0IGlzIG5vdCByZWNvdmVyYWJsZS4KPiA+ID4KPiA+Cj4gPiBU
aGUgbWFpbiBtb3RpdmF0aW9uIGZvciBhZGRpbmcgdGhlbSBpcyB0byBiZSBhYmxlIHRvIHBhc3Mg
dGhlCj4gPiBtYW5kYXRvcnkgcXVhbGlmaWNhdGlvbiB0ZXN0cywgd2hpY2ggbm93IGNoZWNrcyB0
aGUgZXJyb3JzIGNvZGVzCj4gPiByZXR1cm5lZCBmcm9tIFNldENvbmZpZ3VyYXRpb24gaW4gZGV0
YWlsLiBJIGRvbid0IHRoaW5rIHRoZXkgYXJlIHZlcnkKPiA+IHVzZWZ1bCBvdGhlcndpc2UuCj4g
Pgo+ID4gVGhlIGVycm9ycyBhcmUgc3BlY2lmaWVkIGluIHRhYmxlIDUuNSBpbiB0aGUgQTJEUCBz
cGVjOgo+ID4gPiBodHRwczovL3d3dy5ibHVldG9vdGguY29tL3NwZWNpZmljYXRpb25zL3NwZWNz
L2h0bWwvP3NyYz1hMmRwX3YxLTQtMV8xNzUyNTEzNjQ4L0EyRFBfdjEuNC4xL28+IHV0L2VuL2lu
ZGV4LWVuLmh0bWwjVVVJRC0wYmExOWVlOS03Mjc3LTEwNjgtZDJkYy1iOWU2MzhjY2E1NjhfVGFi
bGVfNS41Cj4gPgo+ID4gSSBpbmNsdWRlZCBhbGwgb2YgdGhlbSBmb3IgY29tcGxldGVuZXNzLiBJ
biB0aGF0IHRhYmxlLCBpdCBpcyBhbHNvIHN0YXRlZAo+ID4gd2hpY2ggY29kZWNzIHRoZXkgYXBw
bHkgdG8uIFNvbWUgYXJlIFNCQy1zcGVjaWZpYywgc29tZSBhcHBseSB0byBhbGwgY29kZWNzIG9y
Cj4gPiBvdGhlciBjb2RlY3MuCj4gCj4gT2sgdGhpcyBpcyB2ZXJ5IGFubm95aW5nIGlmIFBUUyBz
dWRkZW5seSBhZGRzIGEgbmV3IHRlc3QgY2FzZSB0aGF0Cj4gY2hlY2tzIGVycm9yIGNvZGVzIHRo
YXQgb3RoZXJ3aXNlIGFyZSBvbmx5IHVzZWZ1bCBmb3IgZGVidWdnaW5nLiBJJ2QKPiBzYXkgdGhh
dCBpdCBwcm9iYWJseSBuZWVkcyBhIGNvbmZpZ3VyYXRpb24gZW50cnkgdG8gc2tpcCB0aGVzZSB0
ZXN0cywKPiBidHcgdGhpcyBzZWVtcyB0byBiZSBpbnRyb2R1Y2VkIGluIDEuNC4xOgo+IAo+IGh0
dHBzOi8vd3d3LmJsdWV0b290aC5jb20vc3BlY2lmaWNhdGlvbnMvc3BlY3MvaHRtbC8/c3JjPWEy
ZHBfdjEtNC0xXzE3NTI1MTM2NDgvQTJEUF92MS40LjEvbz4gdXQvZW4vaW5kZXgtZW4uaHRtbCNV
VUlELTA1YTFjOTI0LTIwNzAtZWIzOC1jMmNjLWE5ZmZhMTc4YmRiOQo+IAo+IEJsdWVaIFNEUCBy
ZWNvcmQgaXMgc3RpbGwgMS40IChhMmRwX3ZlciA9IDB4MDEwNCksIGl0IHNlZW1zIDEuNC4xIGlz
Cj4gYW4gZXJyYXRhIG9ubHkgY2hhbmdlIGJ1dCB0aGF0IGludHJvZHVjZXMgbmV3IGVycm9yIGNv
ZGVzIHdoaWNoIGlzCj4gcmVhbGx5IGludHJ1c2l2ZSB0byBzYXkgdGhlIGxlYXN0LnJlYWxseSBp
bnRydXNpdmUgdG8gc2F5IHRoZSBsZWFzdC4KCkkgaGF2ZSB0cmllZCB0byByZWFkIHRoZSBzcGVj
cyBpbiBzb21lIG1vcmUgZGV0YWlsIG5vdy4gSXQgc2VlbXMgdGhlIGVycm9yCmNvZGVzIHRoZW1z
ZWx2ZXMgaGF2ZSBiZWVuIHRoZXJlIGFsbCB0aGUgdGltZS4gVGhlIGVycmF0YSB0aGF0IHdhcyBp
bmNvcnBvcmF0ZWQKaW4gMS40LjEgYWN0dWFsbHkgZWFzZXMgdGhlIHJlcXVpcmVtZW50cyBhIGJp
dCwgc28gdGhlIHNwZWMgbm93IHNheXMKdGhhdCB0aGVzZSBlcnJvciBjb2RlcyBzaGFsbCBiZSBy
ZXR1cm5lZCBpZiBlcnJvciBjb2RlcyBmcm9tIEdBVkRQIG9yIEFWRFRQCmFyZW4ndCB1c2VkLiBT
byB0aGUgd2F5IEkgaW50ZXJwcmV0IGl0LCByZXR1cm5pbmcgQVZEVFBfVU5TVVBQT1JURURfQ09O
RklHVVJBSU9OCmNvdWxkIGJlIG9rIGFjY29yZGluZyB0byAxLjQuMS4K
