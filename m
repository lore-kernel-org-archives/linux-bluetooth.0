Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACD04949F0;
	Thu,  4 Jun 2026 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780592712; cv=fail; b=D8uHPd1DKh2pXh4zrKcDur+lCZSF9sAlicmgR5kxiW6w+ohPjN8/ViGC4iUMxWtlV5je8KqwxZ64M57dTCjx+b0eJrT63yTMekmHgElhbm4rbl5Bakf25aP1G/X3zD4l0rTfST1lV7kUTDsL28T2OorxAUqTKbJB4p4gnbTxU6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780592712; c=relaxed/simple;
	bh=7pq9P4YKfUaNxm3++xTGTRqHu82i6WZ5PclSNCMwH1k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E1sYjFSuv6WIkIBbQ4z9lNYUN+KV8Hq6p7OsNSKjuw+xX1bTzlzHMRimY0/Q4B4GP1C4ZIa8r/oye3en3bHJ1FA7Q8/UT8uP2Y4u/DdFUabcJiFZ5y6Lu32BtzgOs28InOpjc/68U1rAlgVqH7a08eVuOY1GA98lEP6BGXGPcms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=r+c1i0o4; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="r+c1i0o4"
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654Gj9CH1740074;
	Thu, 4 Jun 2026 17:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=p1; bh=7pq9P4Y
	KfUaNxm3++xTGTRqHu82i6WZ5PclSNCMwH1k=; b=r+c1i0o4lea7aRF8nnYNv3C
	9c1COb/tPWEpOJ5trvGV9b67W/hNRZerjGAjRziyX2+3MW/J1claG9tGPCrHUE1f
	Z960HGdsP0uzR/cLC/f6A8dL1lXLio81NqMHGuqYpTT29vwkWjQFu3n06GYeBNwt
	mndy1LArXwItmnVhBdY6ZRzAkMY1GHsEo/bOSp7h3jLeRLn+Wvc1CdvUt4E7cZ+Q
	rMG4g1K/da6ugCPT+0i6SkoRfjtLqrBWvybojntJxl3HO5eYm29Mm+GcqjbJ8YYE
	pTV/7ukJiRDKgK/aMPFGnBJZRL+dvESoBErj4WvtM3yR9BKvzQtodJeBNKohP1A=
	=
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010004.outbound.protection.outlook.com [52.101.46.4])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4efna1x5x2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 04 Jun 2026 17:03:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCacMaEEYklAdbcXUQchSrO5UOdf2rKVmknrjvbdAPHQbuvk/4dXEYdeRwZb6h4pTGz0/1Vtqau29her36WKq92OVSp/TbI2N+MgI63hEWEyKiDZx1VJNFu60ZNT0tDYmD4V1O1+wMyDuV1tfgN1u/h0NlpK1B8MtOzGLUiuGjon0YU3DCqIwictKXe98uWIUcDidstaKqYPGvi4hvITHJbWatEzHlxe338lThpCnPq2jgSF195d2BGpxCwSySGrZSl9Hzce+Kl2ZahxOlT+lk8Ff/vX+0z0cxsltOGko/PAPQpkOAreRHPXM824zNNCjSjHGKQIo5WbkMYnCX5rTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pq9P4YKfUaNxm3++xTGTRqHu82i6WZ5PclSNCMwH1k=;
 b=J0/BddCmHqhWge1z4Ax7bruLUWNsfJfBrnY802q3H6c7vkwEiWlGrpiBqDC9FZaa6+YHWxm3Hu8+jtXDkh2blx/OkDRxTEf5Wv2O/wSzbGrc+ZricCRkF3serTZhisFxZmfHRnEvmWIHGP8NZogLQrwCadowEWRZd2vddrnZv7kohGe5Ygr54sLAO3hya9o5V7VdrXZ+H10ZeJ5q5rRnPMaRQ5+jQRqyu5bvW0SUai/7xpOKujLrNtlCTm3LE2HzSAFY1xUqprvxBAioG+pxrn/jvQ68YiNH1AoSxhJZtrC+Kz1meR5tW2W2E14AulK5DgdLpLpiXk66v8VZPrQj9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from MW5PR13MB5632.namprd13.prod.outlook.com (2603:10b6:303:197::16)
 by BN0PR13MB5200.namprd13.prod.outlook.com (2603:10b6:408:157::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.4; Thu, 4 Jun 2026
 17:03:45 +0000
Received: from MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::29e9:b355:cabf:66f1]) by MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::29e9:b355:cabf:66f1%3]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 17:03:45 +0000
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
        "maxk@qualcomm.com" <maxk@qualcomm.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] Bluetooth: Add SPDX id lines to some source files
Thread-Topic: [PATCH v2] Bluetooth: Add SPDX id lines to some source files
Thread-Index: AQHc87rtD8cMQsYTXkuJqTxLtVmCnbYuhjqAgAATvjCAAAP7gIAAAD8Q
Date: Thu, 4 Jun 2026 17:03:45 +0000
Message-ID:
 <MW5PR13MB56324299801FB1C68D37BC45FD102@MW5PR13MB5632.namprd13.prod.outlook.com>
References: <20260604004125.715884-1-tim.bird@sony.com>
 <CABBYNZ+j8M4LrG1V0ESrtG3sWR4vgstHGjQQauekBFf3B7DD6w@mail.gmail.com>
 <MW5PR13MB56328C7D133CCC8C584CAE27FD102@MW5PR13MB5632.namprd13.prod.outlook.com>
 <CABBYNZKv=+atEF6Ko6Zs=uc+KtK+4xq2Ak_Re4H8jA45gkwtdA@mail.gmail.com>
In-Reply-To:
 <CABBYNZKv=+atEF6Ko6Zs=uc+KtK+4xq2Ak_Re4H8jA45gkwtdA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR13MB5632:EE_|BN0PR13MB5200:EE_
x-ms-office365-filtering-correlation-id: 5bcdc8e4-e4c5-4820-4132-08dec25b3d31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|22082099003|18002099003|38070700021|11063799006|56012099006|4143699003;
x-microsoft-antispam-message-info:
 u1XgjHT1cM2hLeTru9Bt77XVNPZCV7s5dgxdaQfzldEk+zDFZqZdnAI0iq/G8FqAT+st2C66+hBp82+XioMq21FUIz7L9xjYGdo81JpZUXzE4XsZjCOnyoyUaht0cybNEDXCdnCykHrJ/HPiBU4aaXGlLEgWyK1cHjNSIz5nipwqqEj1HHe4m4i0AH6Ls+x4HBiLqmLTOsyHeaZEbR6+aO8KxvCcL8RUj/lg9N/KQbREiu3/9IXtIuFXEQIM23vENTjyaRexmfP+RDhQ0TjIwCme2L52ozXrFkjaGMI3IQubHGPXkb8PHYNsbe5UAH584k6JcjWe9Ciwh2XsuKh43SEL9GiIKHFdBQIE3rVWEZcNHNXKcdFI5n8OFyEhoJc00jV6ZHJ+zIqcx3qomqms/fS9lksgFhQ/RzX+H2i41QweuE3ngTm4PtCAzC3qRTeZRJ+hW9giiziexgeV1sU5p8TM2ghlmWCeFZVghATONSgocCPXf5kLfAU4hdCdZSp9gxqt3pHH2BD1hb3COrNS5jEmQBBBKm3m++dJo7Q3arHUrJyWHJ29iLQuoLP9+8JeslxWv+b1QsT5i/YNnU9reGwFWvbNjJZdOfZaOG+BsEQL/Tw3G5yxTSAax97sgT+QPaa7PAzziq+CAlQCpP4e25griQhuv4Jn2jFWBCQKDm1OJmn2H/IXopv1E6hnHWOIHodHDqMYQOxObYJC7xwB1P+DGSTs+kQPL8nEFxCr+K28PTpg+b3F9jTM04OEg0hb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR13MB5632.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(22082099003)(18002099003)(38070700021)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V244anY5Z0tJM1VvSU1TeEJGSmpTUy8zRW9KYjNvbkhYelJ0Wlo2VGlqZ1B1?=
 =?utf-8?B?bnczZ0hvakxYektnZUFacGJwRzJOQjY3cGVEaVd5ak5Rd3dvZzhORnR2VFNH?=
 =?utf-8?B?TXBIb3hQaTZRU2dIeXhZMk5tWWplbFREakovQ2ZjN2FRTjU0N2QrSElzOFJZ?=
 =?utf-8?B?em85WXpPSjAyL2tzNEtNUnJ1bk05V2FzSERZdHhTSkNuVElabDBkSnM4RENL?=
 =?utf-8?B?ZWh3SCtTZ1NHcnR0K2tpMEhnQjNBMFowQ1RsUHVCNDBoN3kweTRLcGl2Q2U4?=
 =?utf-8?B?czFhNE51N0Q4eHl1d2kyR2tTNmhMdTdVNXRVN1Jic1JXNjJSbnJieS95ZU1V?=
 =?utf-8?B?NDFsL25OaE9xWFpndnJ0TVpDcEpDYiszTGxUSlNEUlZkdE94WEZyTGJnOC9H?=
 =?utf-8?B?YmVIcmNodmY1WmlxckNaQ2t2dTFIb1RpWG5tNEVHTG9VVUQvUEJ1b0hqNzF5?=
 =?utf-8?B?SW44UHNVcTRjZDV2ZjVzbm9mTWg5aFhYOTgvVnRnaWRHeE9IbnRwTDBjU3Zj?=
 =?utf-8?B?Rmc2d0tySHpmc2I5SjhRUmFJYzNhVXhLRXZjUFRHM2JmbjV5b2d0ck9jNjR3?=
 =?utf-8?B?YmRxazU0cEYvNVBYREpoeXZ5R3M4Y1MvTmtFZFdvWTRZYUU0WWEvVWVEelA1?=
 =?utf-8?B?WHBMekROZGVacE5XbnBhWk5vZ3VwQ1YwbzVucjdlVFFVeW1QTmpQeHZYQWVE?=
 =?utf-8?B?b3pqVC8vUnplOFNtbEtTandtZkwyOEkzb09QWGNNdVZNczNGbTNJY1RhcVRz?=
 =?utf-8?B?K2pqczNQQ1RhT3E0K0Fnc2FDQWxEN1hkWUJJTms2Mk4yVEgxR211cDB3cXRC?=
 =?utf-8?B?QjllQ0tIWVlTZEIxek84Ritlc3IxTmQvNlVreFFoakhacGFEeTc1cFlISWhy?=
 =?utf-8?B?bXFwVjYvUjgweFdtM0k5akx2T3hzNlpXL0xnZGc0TmxESGVlV1FpcHIySk5F?=
 =?utf-8?B?UWlvNjJKM3dqSzdpK21TUlV6QyttZGtVU3Q1RjVFMzY0RWVIcTc3SWhGdjhl?=
 =?utf-8?B?MGtzZHUwSkNyWUJWbHlTYTVLRmJIZEYxTFRWYXEwVXRueW9hWHdIeEs3MEhu?=
 =?utf-8?B?bTVoTHlmSlIwWkpmanFjTDJqQmltdFRxaXF2OWo4UGsySG1nbFVnYkpCNkgx?=
 =?utf-8?B?am5aLzZIQnNVYkkxVWZJNXRWMnM4VFhaV2tmVStwQ2ZFa3VLbUlFSkZVUmhv?=
 =?utf-8?B?dXJXSUpKNGpFdytKYnBBdHFyS0htd1RoTkxsbmx6TFA2aHpCV1hSZ0QvYllZ?=
 =?utf-8?B?TE93eGxCVDdJRFp4ODcveWRFZU5oMWQ2cEVMZ2ZTeVM5TUQrM1R2aU9ad3BI?=
 =?utf-8?B?UjF4WVpRZFB4T0tYUkJEN0p6S3BTWDZGNFJJdHd6S2NOaWZycUpUOUw1WnE4?=
 =?utf-8?B?bWc0VE9Rc2dtZmgxYm9mY0ExTFFvKy9vdkFFNHRnY0tCN2QvaXptUmlDcU9H?=
 =?utf-8?B?L1RncFpnY3ZZb3VGSTlaWGxqRXFLTFZSeWRZbDdsbm5ET3dPekNsa0thaG8x?=
 =?utf-8?B?WVA4Yi96UG9Uakptb01OSnR1TzJ0dTBjaGVXdEUxbkpvVzRKZU1iRGw4ZWlo?=
 =?utf-8?B?UzVPWDZIU29vSUNtb1JYbkd1L0tjZHAzYVl3NWFjVnhiYlZOUmQ3dTBzaGdL?=
 =?utf-8?B?enJZUGM0U0h3cjNVS21hN1JkYzZSZWhUWHJHd2I0RVRaV3ZnaS9QeE9lTmdj?=
 =?utf-8?B?VTFNVmd5d1o4OHM2Z0hmc1UwWGkvcHJhT1JVSXlleC9ielFwamFGTEtsUy8v?=
 =?utf-8?B?ZGdEemJFelRQemJRdjJSMmkvOUZGa29kTFlHNEtBZ0dwRGE0R1JJSVhwNCsv?=
 =?utf-8?B?MkZVb3B0YkVtTE43WHFBcTZOUEpnYmE4TUVqUXBMNkxtSWxJMmxIcGtUOWli?=
 =?utf-8?B?aHBjYUZYdU5GaHZQcmdyWXVialErWC9mNmZGTThyOEN5L1hxNWdFYUtETnM1?=
 =?utf-8?B?a3JuMHkycU9rQUxWSjNMOGxhaTlHeTE4Z25Tb2pSeFJMQmZtODNQbmg5YmIy?=
 =?utf-8?B?aUEvczBzMXBEQ0FrdjFEL29WVmo0ZkxTQmpxSkhCQm55azJ0eEZUL2E1QUFx?=
 =?utf-8?B?Y245MSt5OWhmc29DTVZxSThaczcrSXJpUGw2QmtGTjd3aTdVTzZxVnFNKzND?=
 =?utf-8?B?aXZISWMwclhnNjJMcFFKOHYvTlpta2pJa3NEVTU0ckUrMWtlUU9LRjVxazJX?=
 =?utf-8?B?enpBSm9VWGhONVdrNklTbTVDTVUydGk3R3A4VXNZYm5EdUgybFRNRDZZSTFv?=
 =?utf-8?B?TUx0aFN0VVpCZlFxdVBnclQrbmx4WTE5L0h5MndIUXN6UEtpeGdXbFY5aGhO?=
 =?utf-8?B?Y1dYcVZvWlg1cVZzaFpMVjRGdDhVZFhneEdTVjB3TEJ4VHpOaSsxelZPRktY?=
 =?utf-8?Q?vSYSL/VdzegmO91asRg5zz96cBUZBXrNc8iUL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	lHJn6D7ILLmu++5GTjMQrTVPJOZYUx/oa+dbNBsVqFcGbXMYXGrAXniUoNBn4gSZ6ZfU80A8w986C59bf1HrBBZy7qXKLWhSb1hGbM0r1lBca88486S9KCKhUUC7WkqcGQb6mVJTEknuW0v0+M7lC24yFWNe6t/wI4ujEiPFDwjXIakgckh5YUZXTZlBWkUPwGULbWHamHrTLsACCK8En4wXszxKPR+FB9xfuyh+D4oChLVXkJaKE18qX6xZVodPeRwNUCzvzStvX26rZs6w2M+rHCSOF138tSub03Y4HfLQtkG43jpIgTYLlyeNkrHQ+cICOqq5hWcugSIsDBUA4Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Gtjk2jO1m4wfobZF9DIAZ89gpCKQFXWODVUeNCuyg8CWgqomC9/udt7F5zojCQioPMzysSRUwrR3CyV/NvY4oSo3A2D/fHNGP0THWFNUYob3VbJqRBYinzdatcZx04Xq94gLl8Zfn4Wy78NwBXUg7USNk6IFWEqb8hB3dfcK3XIctCY5gpy9pLqg8kq0oXB2bp3n+TRtW/aXnpXuGbQcrmzAJqNLRlm7yPnPDPUaE8WITGVAHvNcYKjmRpRGVdAhxlvyL/7YDW7kck9Ty9j5rmk3gSP/22BD0Z1gT42zPpCaBFccZQb8MSZTW7Hxw9uG6YJjujIV91U7ey7o9q3dIMA/OzC/zj0cmaMDI1tlYkxp/Owd6NFa5hARmAfRZKB55aeAIJJI9Iuccc9AF0StY7+/GdvQxIn6SaE3Fu8l6Y4WDV7jmgUGw+2fjLkNt+/cYxgCnQqh65R2OldSL0ftMyZF5xzMDHbqecrP2h0Q9LrI/kHMHUcmzXkal1rZxbJnG7FdO6VaRUR8tt5BHaMtZCg3/MYwBirWeSPglkhpwZih2OeAqb/sXSvj63uxbvMrdcPhd0IRhTYnZg5w1FdQl2j2g53Tzf38iYAdgn+m4JUnkKvD+vDf29704o4lAIRM
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR13MB5632.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bcdc8e4-e4c5-4820-4132-08dec25b3d31
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 17:03:45.7068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o6NJlL7fzv4USy2EvegFHTC4XEieCC6Bec9Ia1JwK+mY8ZVl/lfgzgmtLQqO02Uw6XLs6KLk8Dh+9bbZPBwsnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB5200
X-Proofpoint-GUID: OInaQexDGFu6Wfl21ewmRGqMDPzYB5OK
X-Proofpoint-ORIG-GUID: OInaQexDGFu6Wfl21ewmRGqMDPzYB5OK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE2NyBTYWx0ZWRfX1lBvoQE0OjP4
 wtaIaDAYBdIwwtXX/LSGnH36nlGlHoETLfaltSr2naoMGIBnZwoFgQSgSaMqJ87jT0r7UYZ3Oh/
 9jLGNJlSa9Oi9LZESEroX1ZJ8nN7R9Wc0jGW+yHvXbrxZFb/gOuHDeHlU9xTgmzhIbNZWNe+98Z
 1L0THUH318O2lFKnA4eMZAaSbyoBkJkwT+KkPUj1yXNyKQC4PwUWZOAY0iaF+V06LpbXfRSeCeS
 5DQ5ogxyDaMXrpD1M7LkE5Pei/tYrTP1mB05WNF5D0RXHJ97UJQ5fq6oE3/+1xHhH3I6dMsZbB+
 fjQyjqI8+itvCcGeRcfZk8rLe8QJvrghe0jd/nEdCxRW+AqT3syqW3cJHEz5FHwnQ+dP2tulaiJ
 hpQaZymUkMsBn65b2qezA0ThC7PDx4TF2Utjs2QGS5Q40tZsdBauKijpCRgA1/h13qAFFY1K7B9
 7mG9RN1WFMf0eECaHvg==
X-Authority-Analysis: v=2.4 cv=D9p37PRj c=1 sm=1 tr=0 ts=6a21aff7 cx=c_pps
 a=Yjro67SWnLjgwqeg4v/dNw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=xR56lInIT_wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KAb5x4SsHD3PzxGk7EmX:22 a=M2bq-ooH9SiLYa4vvubY:22 a=pGLkceISAAAA:8
 a=z6gsHLkEAAAA:8 a=JPngYNF9u15WedokeUgA:9 a=QEXdDO2ut3YA:10
X-Sony-Outbound-GUID: OInaQexDGFu6Wfl21ewmRGqMDPzYB5OK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_05,2026-05-28_03,2025-10-01_01

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTHVpeiBBdWd1c3RvIHZv
biBEZW50eiA8bHVpei5kZW50ekBnbWFpbC5jb20+DQo+IEhpIFRpbSwNCj4gDQo+IE9uIFRodSwg
SnVuIDQsIDIwMjYgYXQgMTI6NDHigK9QTSBCaXJkLCBUaW0gPFRpbS5CaXJkQHNvbnkuY29tPiB3
cm90ZToNCj4gPg0KPiA+DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4gPiBGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LmRlbnR6QGdtYWlsLmNvbT4N
Cj4gPiA+IEhpIFRpbSwNCj4gPiA+DQo+ID4gPiBPbiBXZWQsIEp1biAzLCAyMDI2IGF0IDg6NDTi
gK9QTSBUaW0gQmlyZCA8dGltLmJpcmRAc29ueS5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4g
PiBNYW55IGJsdWV0b290aCBzb3VyY2UgZmlsZXMgYXJlIG1pc3NpbmcgU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXINCj4gPiA+ID4gbGluZXMuIEFkZCBhcHByb3ByaWF0ZSBJRHMgdG8gdGhlc2UgZmls
ZXMsIGFuZCByZW1vdmUgb3RoZXINCj4gPiA+ID4gbGljZW5zZSBsaW5lcyBmcm9tIHRoZSBoZWFk
ZXJzLg0KPiA+ID4gPg0KPiA+ID4gPiBMZWF2ZSB0aGUgd2FycmFudHkgZGlzY2xhaW1lciBpbiBm
aWxlcyB3aGVyZSB0aGUgbGljZW5zZSBJRCBpcw0KPiA+ID4gPiBHUEwtMi4wIGJ1dCB0aGUgd29y
ZGluZyBvZiB0aGUgZGlzY2xhaW1lciBpcyBzbGlnaHRseSBkaWZmZXJlbnQNCj4gPiA+ID4gZnJv
bSB0aGF0IG9mIHRoZSBHUEwgdjIgZGlzY2xhaW1lci4NCj4gPiA+ID4NCj4gPiA+ID4gSXQgaXMg
bm90IGRpZmZlcmVudCBlbm91Z2ggdG8gY2F1c2UgbGljZW5zaW5nIGNvbmZsaWN0cywgYnV0IGlz
DQo+ID4gPiA+IGtlcHQgdG8gaG9ub3IgdGhlIG9yaWdpbmFsIGNvbnRyaWJ1dG9ycycgbGVnYWwg
aW50ZW50Lg0KPiA+ID4gPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gVjEgLT4gVjI6DQo+ID4gPiA+
ICAtIExlYXZlIGRpZmZlcmVudCB3YXJyYW50eSBkaXNjbGFpbWVycyAod2hpY2ggaXMgbW9zdCB0
aGVtKQ0KPiA+ID4gPiAgLSBSZW1vdmUgZmlsZXMgcmVjZW50bHkgcmVtb3ZlZCBmcm9tIGRyaXZl
cnMvYmx1ZXRvb3RoIGZyb20gdGhlIHBhdGNoDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYt
Ynk6IFRpbSBCaXJkIDx0aW0uYmlyZEBzb255LmNvbT4NCj4gPiA+DQo+ID4gPiBgZ2l0IGFtYCBk
b2Vzbid0IHBpY2sgdXAgeW91ciBTaWduZWQtb2ZmLWJ5IGJlY2F1c2UgaXQgaXMgYWZ0ZXIgLS0t
YCwNCj4gPiA+IGl0IHNlZW1zIHRvIGJlIGNvbnNpZGVyZWQgYSBjb21tZW50Lg0KPiA+DQo+ID4g
QWggY3J1ZCEhICBXaGF0IGEgZHVtYiBtaXN0YWtlIG9uIG15IHBhcnQuDQo+ID4gVGhhbmtzIGZv
ciB0aGUgaGVhZHMgdXAuDQo+ID4NCj4gPiBTaG91bGQgSSBzZW5kIGEgdjMgdG8gZml4IHRoaXM/
DQo+IA0KPiBJIGNhbiByZWFkZCBpdCBtYW51YWxseSBpZiB5b3UgYXJlIG5vdCBwbGFubmluZyBh
IHYzIHRvIGFkZHJlc3Mgb3RoZXIgY29tbWVudHMuDQoNCkkndmUgZ290IGEgdjMgd2l0aCB0aGlz
IGZpeCBhbHJlYWR5IG1hZGUsIGFuZCByZWFkeSB0byBzZW5kLCBidXQgSSB3YXMgaG9sZGluZyBv
ZmYgdG8NCnNlZSBpZiBhbnkgb3RoZXIgY29tbWVudHMgc2hvd2VkIHVwLiAgSSBoYWQgcGxhbm5l
ZCB0byB3YWl0IHVudGlsIHRvbW9ycm93IHRvIHNlbmQNCml0LiAgSSdtIGZpbmUgd2l0aCBlaXRo
ZXIgb3B0aW9uOiBzZW5kaW5nIGFnYWluLCBvciBoYXZpbmcgeW91IG1hbnVhbGx5IGZpeCBpdC4N
Cg0KLi4uDQoNCkFoLCB3aGF0IHRoZSBoZWNrLCBvdXQgb2YgYW4gYWJ1bmRhbmNlIG9mIG92ZXJj
b25maWRlbmNlLCBJJ2xsIHNlbmQgYSB2MyBhbmQNCnBlb3BsZSBjYW4gbG9vayBhdCB0aGF0Li4u
DQoNCkxvb2sgZm9yIG9uZSBzaG9ydGx5Lg0KIC0tIFRpbQ0KDQpQLlMuIEkgcmVtb3ZlZCB0aGUg
J1RvOicgZm9yIFNhbHZhdG9yZSBCZW5lZGV0dG8gc2luY2UgSSB3YXMgZ2V0dGluZyBib3VuY2Vz
Lg0K
