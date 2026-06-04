Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894A639281E;
	Thu,  4 Jun 2026 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780591388; cv=fail; b=bxLQuDM3vw7PnM9U0OiuuUomR595NWpjgDozB81Lsw3ES/6OX5s6PftNI2VS5v8dONiNnTsA3yTU3LRdN58GwtDnZevIxuY+EGFKK9+hMmX7Z/RpsauBmrJZ8O1e9VZSKKWjnjro99Yy3xG47QUlBapnOxDmWQEU8laIrNlsrEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780591388; c=relaxed/simple;
	bh=1B7YVsUip0KEFajeO0u9ZJH/BSIODzorD4BprA45QbM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SREzEm25q19GL4VWHbVxjdZuuaGbH7dC3pCl7dNSdC4VvjQ3iGG5tDO4eHVJROCXBf0jxJs1oXkRU+rbQuCNLNSZcmW900zDyvOnWYkkZuA4Hd5xMX9PGz/zi5QbQBUH4T/XuBv9xjP/2gP0vHcqY3QrgeoUag+2SrjAICcQaZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=hTBQIVAs; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="hTBQIVAs"
Received: from pps.filterd (m0209323.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654GN1I41681308;
	Thu, 4 Jun 2026 16:41:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=p1; bh=1B7YVsU
	ip0KEFajeO0u9ZJH/BSIODzorD4BprA45QbM=; b=hTBQIVAshHSOXiGz3anufSm
	94GDhIW3QMRZldzdiwXt4O4O0XC/HPM9l2099/SbJiXFyO/Qgu1+tdjDZEvrkTnS
	8JK+7Nggvr7rwo97i7WHxtZJyWGdS5ki/oSGsmfr4O7PlBoOnwfE5dHoHHYlpFKi
	D6GO6uqkhuK7Uzc1LI4faQwACxjinDYxbLh012dUY/LJ2YwfOroSBbTNET+G8wFn
	ekzBUTa1J9VRMyPV4iJTYQj1MDFcruhr9Ce4L715+sxRYjB0+NK222hrXerGq2pF
	SvsyiB10ZK5O1H8+/6OVBv9+IqQhgb7T8oSFjpUNRR+b8kibUgMarkQGi73bqBw=
	=
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013041.outbound.protection.outlook.com [40.107.201.41])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4efq7wp28s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 04 Jun 2026 16:41:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOjwUlafILJU3rGSGN/QrE/Tl/EjiijTdOyGuE5JEtZafa7nsdfo3JUee0AqNa4THGdn3Qr79yL0eZGfytiDGI0G3JvUtZvePF5vwxnYrrWCNQboGXziWqdGmN8UvxXdtnXnJi8sE9al4UwjOQzqafKQyeo6J/4K4ABVNYPJgbtHXAJv8j50LXHLB/upe802y1rEvmhqlCnbXqvrATRo7f8NbVFWfyrbBBmQZccabydx3U/Oh7FzDmqKeOShwSEcFsjviRD/A7IrDJFEr/AGydqWkx6HgOnw8RR34QHPmW+nw2piD0rhxvOH6LpefGAdgBGVrpAIJkD0Tv+G23+mEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1B7YVsUip0KEFajeO0u9ZJH/BSIODzorD4BprA45QbM=;
 b=GaqJFhbL1lXlnLQEJ3ZMbOyTyfcQHAJNANVFYQHJWc1oYXUxIi41oNxbYZR68aI0ANMJoDtyRjGdipdVKScOSDgZ8rezSksP0eTcDP+mR+RuBPMcKsP7A9hUhbC3zcxCPLgswbL533AdHUzPtOnvL9H9xQaLEvAhDWtHaF2pmd2O6o3xRh4Xd15BqU3U0xNldZamd/iLOFrvnzd5jo9TnPh3nKJTXwwCe/eMcougQguplPB7bi5p+g6DMxUQUSvNDzgmGAtxJVYldbzLzXn5iV4A2FCF8B6V9KWkXZXdzD3c4JjBQylWv1E40WoeAm5NbOPrP1uHZLiY5qfHsNL6mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from MW5PR13MB5632.namprd13.prod.outlook.com (2603:10b6:303:197::16)
 by MN0PR13MB6695.namprd13.prod.outlook.com (2603:10b6:208:4c6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 16:41:21 +0000
Received: from MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::29e9:b355:cabf:66f1]) by MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::29e9:b355:cabf:66f1%3]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 16:41:21 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "marcel@holtmann.org" <marcel@holtmann.org>,
        "jannh@google.com"
	<jannh@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "kiran.k@intel.com"
	<kiran.k@intel.com>,
        "chharry@chromium.org" <chharry@chromium.org>,
        "gustavo@padovan.org" <gustavo@padovan.org>,
        "prameela.j04cs@gmail.com"
	<prameela.j04cs@gmail.com>,
        "salvatore.benedetto@intel.com"
	<salvatore.benedetto@intel.com>,
        "maxk@qualcomm.com" <maxk@qualcomm.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] Bluetooth: Add SPDX id lines to some source files
Thread-Topic: [PATCH v2] Bluetooth: Add SPDX id lines to some source files
Thread-Index: AQHc87rtD8cMQsYTXkuJqTxLtVmCnbYuhjqAgAATvjA=
Date: Thu, 4 Jun 2026 16:41:21 +0000
Message-ID:
 <MW5PR13MB56328C7D133CCC8C584CAE27FD102@MW5PR13MB5632.namprd13.prod.outlook.com>
References: <20260604004125.715884-1-tim.bird@sony.com>
 <CABBYNZ+j8M4LrG1V0ESrtG3sWR4vgstHGjQQauekBFf3B7DD6w@mail.gmail.com>
In-Reply-To:
 <CABBYNZ+j8M4LrG1V0ESrtG3sWR4vgstHGjQQauekBFf3B7DD6w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR13MB5632:EE_|MN0PR13MB6695:EE_
x-ms-office365-filtering-correlation-id: 6e00a8fb-eadb-4f9a-307f-08dec2581c11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|10070799003|38070700021|18002099003|22082099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info:
 cpuSYxiziPfokqFfUOiLXMrLYVyho88f9tWYzac4dvPjS1v3JNGUzEZwz84L+/u6yWvMlgHWSujOqPXBWtvu+GyD0SBE7KVJK8Nj3a2hF7+0UKGQL8Wi+vdrxU4a3vKcsd+sixR3cd3x+YlkzRwOEsv5JiJCdkrEcsbfHnv8niVkG48bPK0Rw1kA1XqUGvIk41htb1PXI9eHw6U8p/RI1H19oBZ6redLiyLJvKcY0ub2Nv3zcWTunTJaw3oPL72ZacB5ocQ1ZAEN2X6q3ZXeTDMhECOzat7wUDRzvrzgbWhbViYq49r6wQRF4yek5NVOThqclmiV47/sLecEohHeAynvfq/J9TgGotOSasKOR76CaTTpaqhU0vJMzZtrK1LAvPQajW8BlPu8N0eVIfTSszMA45dUFeGI/hBVhVWHapedZhvBRT8nnweiez9d8p/LCORGOzCNLHIoK7v5u13MFJn4FhY7m8SH/xxpoxIHaDkFkdF7POYgWhwB8hcDdLwNiV/RsVOA9WNHs/66PN34Y640fGUwK/b6cRkrnFArUMTcyB5nFTP+9zQR4vCPrneY+gEv+20I9AyiLS+/NN93ThdPoL3sHc986vyxcX4ApEpCrH/t4gY3aLy3SUhJ02GU3jJaR+GYy9s42T6Q5cxZIGB3Ir20yoVGY7G/IGF8KedUnmuGUx+KTjGAm7Dx6oR/Ib8GEa9eabZoGHlPKcM4zTbDTp2/hIDJDmSiTTXat0kKj3aDWS7le7TqNeAdOLy1
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR13MB5632.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(10070799003)(38070700021)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ty9kdWhpeEdKTXZKVTJzTUZ4OTZtR0xwQmNWZ3pNbXhKNGx6R0VEbHlHTURp?=
 =?utf-8?B?ODdGcUZTVlpsSGtJcnpQbGN1dmQ4Uy83c1hlY2dHU3JwbUJ2eVJ0VHgxUzBY?=
 =?utf-8?B?a2lzNDdMdVp5RlhiU29GOXZRMkFiS1VwVkxuWnJBdVhDcmxFUGY4dVUyL3pT?=
 =?utf-8?B?RDV2c0hZWnh6SFYzL054bTBUd2lnalZ4dlA4VFd1djFZRWoyYzdUNE9ZS1pN?=
 =?utf-8?B?MDZ1UGNKbElDNzJRd3lKVWdmWW9oOGdEWFU2TnJRMWNYYkVwRXQ0aDlqUTdC?=
 =?utf-8?B?VnFhN09tK0tUVFgxalJtWGJLQ2JkL2c3TVU5S1d3QTlCYyt1bUNkdVNYR1FN?=
 =?utf-8?B?a2VGZUlPdmRHNXJlR3FROWpsVnVnR2R6bFZSY09Td0xiN0Fkc25nQWtPaFQ0?=
 =?utf-8?B?ai9WQjRPVjZUNkpUb2VDL1dvNkhQWjFWd3Vlc2RCTElRKzAyUUxnUmUvL29h?=
 =?utf-8?B?eHpqV212MVR5dGhwQ2JuWlE1WEY3R2lJY0R4L1ZXKzlrVnpxRGJGKzA4NWhx?=
 =?utf-8?B?SGNzQ1REa3dqc1YzMWVnSkx6ZTZZMDR0aXc0c2NoSDdjNmh5cHRRYzNDT2Fz?=
 =?utf-8?B?VUVLc2d4M3VLeHM5VE9ITU56ZTZpT0cwSHpTNEVxWWxYQmFTZ1BNTDVtNnJ5?=
 =?utf-8?B?dXlPOGtSRk5WWkhnTmdWdEZxdWM0TmhMbllVdEhRT3hNWGtlU2lxcU8wazBJ?=
 =?utf-8?B?b2lnUVVJaE1UcmZtbFRGL01KQ0dEYTFUbUZTSHZOSnhrYXFDTW5FN3MwMWdk?=
 =?utf-8?B?TlJMTWM3dGkwUG02Z1drbTZ0MEdXUGpGSGwycHBtd2JtWmVCcWdQaFNCQjNr?=
 =?utf-8?B?QWNzNS92Z1hoMzNiNDVSam5QVkh2WDl4Q2xpNVVUK3J2cGo4Rk5OSnZmZWpQ?=
 =?utf-8?B?YWlLcU93QmtnNC9RbzloVFFKNE1tNVdHdTc1S1NaT1puTTV1emQyd2ZVNGpR?=
 =?utf-8?B?WTVEWXpmRmNGUVJiMXl1YTlKbWZmZk4wcGFmMnVIWGdFVS9KWVRjQ0JPZ0hm?=
 =?utf-8?B?eWNrMXkvUjErYmYrOEtFSGYrQ1RmTlVXZnQwUm5ETWRmOHlKTTF2OGlmK09R?=
 =?utf-8?B?WVBNbWJFOTVuVzYzM3RYcVNGTVkvMWVsUmpEQUNhM2hIYWRvZkljOWVzanVL?=
 =?utf-8?B?Zy8ydTRxOEFZRUY2TkFrWWpqNmwwcVFzS3BYcC9DcXRhNzBmZW4rT2U2UTRH?=
 =?utf-8?B?dGYyOStWU0IySTVvbU0wYTFzeE1sOUpEL2RsK0x4bDF4MkZXRUVhakRoK3gx?=
 =?utf-8?B?RjZjSTlZS09sWFJVWnlXOVNUS1l2bEdkS1o3Z1B3NENmQi90R0tzbkR4YXhu?=
 =?utf-8?B?RDFMTGVESWNmbk0vdStxUEZsMnlkNmhiWEFsbGQyUXRrZGF4QnR5Z29sbDl6?=
 =?utf-8?B?SW5FL2NweDhRK0VrTndQd2paTmgzaDh2U1hVZUtZNSt6KzIxdkJIRFhPVHps?=
 =?utf-8?B?a3NMMDlkOEdOeHFVOFdPZzFaVE1DNWFvN3ovWFRsZXpCbkRGWDQ1SFg3Wm8x?=
 =?utf-8?B?VGdSYXllbG9uWFQ5RTBSbUtBK1lMSm8yR2pHS3NGb04ydU9yM3dEaXlZMlpt?=
 =?utf-8?B?cnFCZ0orU3ZMRHBWSVpoNm9hSkJwV2JLSWVGSEVGYkFvaXU1V25IUjBMdWYv?=
 =?utf-8?B?Vnh5NXBDQVpRbzk2VStlRVpLYUdCYlZSV2pxR3RTOFVqYlRVcDFWTENJVm9s?=
 =?utf-8?B?WFExR2Nsb1pSMDB5em1ocEg1ZlZhVDRnYmZmMDlucm9wYUxabER0OXY4dWkz?=
 =?utf-8?B?R2hvc0R0eHRaS1JGOEpRREQwVmU5d3lackRHemZmK2dMQ0l5dHJTZ0VPSEZF?=
 =?utf-8?B?bzlFYnRoV28wb2FPeDVjaHc1VDRFcDJzU09FSlIyWVUrSEhwSEwweTgxRUNP?=
 =?utf-8?B?QjRPdWNUTGlIS1VYMFdxZk55OXVSYUJtNE1Sb011Wk1UaE5QOFdaZ05TNDFJ?=
 =?utf-8?B?cFZKY1ByM0NZcGxleHFPQnppbGRjMDF5NUo1MFhPRk9sZDJESUdNVEplclEr?=
 =?utf-8?B?QTZGQ1pXUXVEY0g4ZUlEd0U3N2NGTDhNbk00c3NyNExHSXo4b2JxL2tYb29H?=
 =?utf-8?B?MHhQVWJ2aEs3eG51OXdFZW1MUStXTVdmVWxGUTBNUDAxcHkxNVFyVEtaOTdr?=
 =?utf-8?B?ZzIxa013Z2dGdEN3cW5EbW8zcXkyOFZ1YldENUNLSmErQXROZEdXVWExNWR2?=
 =?utf-8?B?aUN4QVliaEpBSm1XcnFvWC9PUFZwOU9XazVkbkFFNDdhblY5Wm1LT3V6ZVhh?=
 =?utf-8?B?WHZ2ODNoUmd5QlhWM0VQK3N6aTJzM2w3MXp2Tk5tZ1VwRDNkTnFWRlF1WjlO?=
 =?utf-8?B?YXg2M0lVSkJzZW5rd1I0d1Q4b2kraFJWSzhISWR3T0xxdEQwMUlZd2REcW10?=
 =?utf-8?Q?6w710X4EICwIvpxM/CTb7jNEE78+T/jniHwzo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	kwR9LfYsM7rjywhnFF22CoLw1iLAkO5j867lwfoCiCblu2vLbcuPr+41n0DnlOnBnClG+19pflV8JAW8HvmFDnc59FEZ6Aixt19LElMH1YYO2oRrlVoW0vSZb0kFwV+rgBx1I6LlTdFTYEnLl2vHWlJqzqwIwZS8hkQqsIyD6S6sun2cee317WcbhpCzOkLqG7Xvv0Vg9C8gC20MMu7LS7fkBXfzFXADtmJ7vxW047M2yvFFzJG38ubvsBr2z/gWTsnhjGYfShbUBKIXD6TD+vDFDloNMkZwChHklgqgJdXSxgZMrLHl/IIRO2eWqEeuvIH+PQuum2B9Ab7OzXrU/A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SNsfhk7BlppAyzPvok8MUq+7JjgAAbq2LQWBgSq5NBs7iwDI8qMV+yVZDF5OYa5hKFH/AjCLN+6oNzbTv0fvnYLel8jjvIjZmHvZkp6V40+qC9ovJjkk9/CyOa9gpQ4CV26S2Lwz6ljMBRKDvXDkqvvpgOAgSNAbi9HnUJVClYr1W93NQv4PEZRI7Q121vXJxWZUx9+Jx4nMMol2x8mJWVjdIiFVkypzY6+OMFWkFwEuIfzmbA/ze/kRBJTlbMWpzFr1pO/iWk18wZUdObmITEErIlfH/V9V7vUpW2Z3JE397q0tK4mSX57ODA13hulWlGy6Jr2tFhMhd1+yxuul0WjpDka/EvoBKjUIg9jfPP6s18aT3vpet6476+W8S+/9eWL5+eWNVUrYbgH87nEagnnLVR1abWE8cC+re/AvXfr//mz3ETOpxHPn3798kVZpZs7lAo2hLTTlC2cfdrw/29FqntL8MIE2ZP68yRvKLMW0sKv9T3KGlpz7qQJg2szyuTObBt0JnV6dD/Z7rAxTgyKSnkCVP9QVdcBh0WnkcoymjC2TGdrQd8/er3Msg7Ze2tfi1QVTigqtKr1qISjHsvPeOMa6ltx2KaRSy9I0Whh1cCil4ae7ZwTo54V2B7RM
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR13MB5632.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e00a8fb-eadb-4f9a-307f-08dec2581c11
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 16:41:21.6890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t8ltl98958ZAcL2dRjf4lQIkkWiPsIcoZtf86P4qfo7dYUE/pVzxQSGNtTPUWPuNulADabDTzFBIK+pl7lm5AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR13MB6695
X-Authority-Analysis: v=2.4 cv=eeENubEH c=1 sm=1 tr=0 ts=6a21aabd cx=c_pps
 a=r8U4PY7g8F27BymEuqiK4A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=xR56lInIT_wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KAb5x4SsHD3PzxGk7EmX:22 a=dNm3KQjjYUbhztXjLiFs:22 a=pGLkceISAAAA:8
 a=z6gsHLkEAAAA:8 a=lqMQFpNTi7y1MLsVZRMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9331pZjoCKbIMY9YIOjrX3dPBKjWoQef
X-Proofpoint-GUID: 9331pZjoCKbIMY9YIOjrX3dPBKjWoQef
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE2MyBTYWx0ZWRfX0LXSUkg1t488
 SGIBXFcXBLj+n/dWsqbjimrL1cxKFy6VsGMCkOf1iBNZNOjKR9+JVp+2ds1WSf2Zh4Vh0S9KynJ
 bJ+lYwAbgHDG5BqJvptuPVEuA4z5p70zTUnizUbyutAjz1/bBrKshyr/RpJ2FFvt3sj+gOTZavJ
 n8oQcd85gvVfY/c8DNlyp8y5fwWf1DtH0FmCUiyiomRaR8vwJxWknPXKL2oC6y4lm4NW1lTQSe0
 ACnkSsU6yXdRwskWziLCerMa6a0v6IgCcpP5qc4cOwOZH7MsR/7ou24VR9ibr30Sqct/oEEvnR6
 3LDQVep4AUijUHbhkvWe8TguR/Er14Tys9PH7N51phSxAruaJ4qcBtKBnJz4egLbM85qTtdSaDJ
 WWjHcHTc3J763LDIoiFV9il+w+/iP03iFD2+6CkKd9Ms5O89YwRnWRbkqj3NdX2acSda0ljoHvV
 sT8VYF/4XM6WeXuaGlg==
X-Sony-Outbound-GUID: 9331pZjoCKbIMY9YIOjrX3dPBKjWoQef
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTHVpeiBBdWd1c3RvIHZv
biBEZW50eiA8bHVpei5kZW50ekBnbWFpbC5jb20+DQo+IEhpIFRpbSwNCj4gDQo+IE9uIFdlZCwg
SnVuIDMsIDIwMjYgYXQgODo0NOKAr1BNIFRpbSBCaXJkIDx0aW0uYmlyZEBzb255LmNvbT4gd3Jv
dGU6DQo+ID4NCj4gPiBNYW55IGJsdWV0b290aCBzb3VyY2UgZmlsZXMgYXJlIG1pc3NpbmcgU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXINCj4gPiBsaW5lcy4gQWRkIGFwcHJvcHJpYXRlIElEcyB0byB0
aGVzZSBmaWxlcywgYW5kIHJlbW92ZSBvdGhlcg0KPiA+IGxpY2Vuc2UgbGluZXMgZnJvbSB0aGUg
aGVhZGVycy4NCj4gPg0KPiA+IExlYXZlIHRoZSB3YXJyYW50eSBkaXNjbGFpbWVyIGluIGZpbGVz
IHdoZXJlIHRoZSBsaWNlbnNlIElEIGlzDQo+ID4gR1BMLTIuMCBidXQgdGhlIHdvcmRpbmcgb2Yg
dGhlIGRpc2NsYWltZXIgaXMgc2xpZ2h0bHkgZGlmZmVyZW50DQo+ID4gZnJvbSB0aGF0IG9mIHRo
ZSBHUEwgdjIgZGlzY2xhaW1lci4NCj4gPg0KPiA+IEl0IGlzIG5vdCBkaWZmZXJlbnQgZW5vdWdo
IHRvIGNhdXNlIGxpY2Vuc2luZyBjb25mbGljdHMsIGJ1dCBpcw0KPiA+IGtlcHQgdG8gaG9ub3Ig
dGhlIG9yaWdpbmFsIGNvbnRyaWJ1dG9ycycgbGVnYWwgaW50ZW50Lg0KPiA+DQo+ID4gLS0tDQo+
ID4gVjEgLT4gVjI6DQo+ID4gIC0gTGVhdmUgZGlmZmVyZW50IHdhcnJhbnR5IGRpc2NsYWltZXJz
ICh3aGljaCBpcyBtb3N0IHRoZW0pDQo+ID4gIC0gUmVtb3ZlIGZpbGVzIHJlY2VudGx5IHJlbW92
ZWQgZnJvbSBkcml2ZXJzL2JsdWV0b290aCBmcm9tIHRoZSBwYXRjaA0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogVGltIEJpcmQgPHRpbS5iaXJkQHNvbnkuY29tPg0KPiANCj4gYGdpdCBhbWAgZG9l
c24ndCBwaWNrIHVwIHlvdXIgU2lnbmVkLW9mZi1ieSBiZWNhdXNlIGl0IGlzIGFmdGVyIC0tLWAs
DQo+IGl0IHNlZW1zIHRvIGJlIGNvbnNpZGVyZWQgYSBjb21tZW50Lg0KDQpBaCBjcnVkISEgIFdo
YXQgYSBkdW1iIG1pc3Rha2Ugb24gbXkgcGFydC4NClRoYW5rcyBmb3IgdGhlIGhlYWRzIHVwLg0K
DQpTaG91bGQgSSBzZW5kIGEgdjMgdG8gZml4IHRoaXM/DQoNCiAtLSBUaW0NCg0K
