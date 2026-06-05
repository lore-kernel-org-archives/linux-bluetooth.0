Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2701A262D;
	Fri,  5 Jun 2026 16:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676811; cv=fail; b=WM1qz3rc986MzV0e1tKh2rSXhE2pEtW3YrGN07GUSiDp4JKwDPZyh/Yfpmy3XnMMLYTiwkCdV8gLwZHwU6GRyguBRyxeT0oJsjVd8eNotrALGxH3DeOhtM3oqn/Vj/iXIDE4soTNS3inmXEoqGUp4p45Vcb/LUPW2lE2aqJ3DAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676811; c=relaxed/simple;
	bh=4S4B/kzqyOa6+T5sGyik9s+AKxCc8l1HMYkwLL3+3p8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=InSQ/QPCUtrw7I+YrJQ7ARDcd1Hxz0rGGO/FDLfKRUPZrEEMFUmBWsxMLHbemRG8exEVVtw4udG4WTzOBQbDZ+prxpG5CbWCn2TdvNulKmi9OEiY2Z/6dU0UfxhH+NMeZn0tA3geRFaCZkzZ/xi3kh7bxLL4lBjO1E3+aHy8AxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=sgZL+uLu; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="sgZL+uLu"
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 655FTFrt2186824;
	Fri, 5 Jun 2026 16:26:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=p1; bh=4S4B/kz
	qyOa6+T5sGyik9s+AKxCc8l1HMYkwLL3+3p8=; b=sgZL+uLuukCei+XEyzDOvNK
	Y8Ha4Ydj1h8UYDHunLOfHgs+PLjvZ2z9B4/nVQEJxo1/eJjV9o4LbLahbIxnH4jX
	wSZeexqZDOH1MZCEyFmhbjvxfsXC9rEboHgDmyWg3lguHyxn90KZp9zoAjt5pe8R
	BUa6K4v05Kg+nOjOxa6gc/9k2YQsvXclLYwkroTHKDiZ5m6+L+O9BixWst8PinBD
	X57ab5N/7ovT9Tm2Ke0Uk7SMSZ305CksVKCuoMoeOueKoSrDKRYIQO3dCVPUbNgp
	vCR85WgpwB1leEUIVNDOe0t3eXsbNGhv9fF3/htcTtgNa+hSCwRTqgFNIfHZDBg=
	=
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010012.outbound.protection.outlook.com [40.93.198.12])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4efn22r04d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 05 Jun 2026 16:26:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3CbbEe52YVvRNCMMabTL88TP+Kgedxi3HKHUr2PGlv92pGteCfkjZJiTEkWRgfUbZJ343I6ITZ0yiGM1SsnsskthGWIAzhOJZQmuMh1BFqxJCU+YhDVzsV1ClTAfQ666QQsEkQWfbyUC6hGHfaPNYZbweQsy0qFE69uZVCqISo9/5vkKkgilvS7QAOm1IJCourLMrOwBDdWKcwnp2YIOIbnm72NJKtOaMMtozXjLmdulqr3Uog9qKTjvuXIgmnFfEALvH/r24j317YQ9A3wt+48+cZmlb/feDtdYEOVZI1jCPoFwoPkpqr+EJGcb834n6t0+gLRRFIBba1/9zQF9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4S4B/kzqyOa6+T5sGyik9s+AKxCc8l1HMYkwLL3+3p8=;
 b=uicocn0DwxAtt0WKPYKExAsmHk+Y6OBlitOJkF+13FDgMHUp05suSwHth2wCSIkrSx5Paf686uK9fQBMeeUZHEIu5BD3DWjjwyrfW0HJTrMOFZ0bv8VUk7RvNl/wh3QKFoNMNZf4ZDcbsYjiAySdQ+U2qoQ7FrX191yyxfOLaLX35912ps9GiJHsNsDr5GBjh9xsgXwGmJKb2w9/SvE1FJytk9vPa9SbixkYKYC2htILc+qdv+32YnbJbVxR0sMrnWZPsJKh0VRWiid/YMPc3Q9iYMLeeqFh1/rampqyFj0Vz0XmdeaOp2gZ1VdquOUyo/op+1VxS373ZzI006v9OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from MW5PR13MB5632.namprd13.prod.outlook.com (2603:10b6:303:197::16)
 by DS5PR13MB7680.namprd13.prod.outlook.com (2603:10b6:8:340::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.2; Fri, 5 Jun 2026
 16:25:59 +0000
Received: from MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::29e9:b355:cabf:66f1]) by MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::29e9:b355:cabf:66f1%3]) with mapi id 15.21.0113.002; Fri, 5 Jun 2026
 16:25:59 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "marcel@holtmann.org" <marcel@holtmann.org>,
        "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "kiran.k@intel.com" <kiran.k@intel.com>,
        "chharry@chromium.org" <chharry@chromium.org>,
        "gustavo@padovan.org"
	<gustavo@padovan.org>,
        "prameela.j04cs@gmail.com" <prameela.j04cs@gmail.com>,
        "maxk@qualcomm.com" <maxk@qualcomm.com>,
        "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>,
        "linux-spdx@vger.kernel.org"
	<linux-spdx@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] Bluetooth: Add SPDX id lines to some source files
Thread-Topic: [PATCH v3] Bluetooth: Add SPDX id lines to some source files
Thread-Index: AQHc9ESNHh0SujiONEGbqTwMLYPLuLYvwaCAgABix/A=
Date: Fri, 5 Jun 2026 16:25:58 +0000
Message-ID:
 <MW5PR13MB5632F713AE9A9C87F131E28DFD112@MW5PR13MB5632.namprd13.prod.outlook.com>
References: <20260604170633.730139-1-tim.bird@sony.com>
 <8def22a9-85bb-493c-bd37-a299285a8f79@molgen.mpg.de>
In-Reply-To: <8def22a9-85bb-493c-bd37-a299285a8f79@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR13MB5632:EE_|DS5PR13MB7680:EE_
x-ms-office365-filtering-correlation-id: 2c886a24-58b9-4fc6-5506-08dec31f2091
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|11063799006|18002099003|22082099003|38070700021|6133799003|4143699003|56012099006;
x-microsoft-antispam-message-info:
 IqFUDVMdmayA3M1XjYYEWuEbrvlsrGQA31j/HiokETlqCDcpA5Tg2U5We/zuQUEO6h0pBiGBgWvIscW/5c03qxZk7sq7vb556MKFh7FF5Z8sQkJvXTOJ0aPn5praCCoQa5zbD9WVzi6IcfrbK8MhnXRzxgG86VyjA8nN7HrDLdRhiRHxIhnCwyPo37XMeOBqwewhSUs5lbll+q61fkTnB2Ype4sp8KmoNzR5zi4UF+AmZyp5xkGBHWbEE0nJPi894uCY2QXPFJH7D8NakHpNUP6L8VBmNliB+AMiwSOUuG/MR125gMvQEWvHTl4mtAPgOY7855S1iyjhhXGylgrFa+zboTSpSDDF2Toh8vqBnplZtb+8X7yT8qgnGRDdH5rGV0SnENzmtk2tZ4pFwG1tUWFLDH54I0+wpG69iOBnrvpGdqEOAUhBWw3MInPC9yukszbVuCy5wfEzoiLjadTLgcjKpZexI9Leo+UrWpjZINxgmbKiijksmA9kIRAvILlukpA070pnz/F0DwFm6wdGwbOPB7qkwMy9YLciiaJs6YSYG3VOAY1+uy9CltnQFkX4YxYXTklb0Pben0Ao0gxi5As8PFshAW14aqBzxvBuwj6V7F167mt2dIzewz67NKaisdpWEJ3VtU7nhxly0PZTDQKmk8oukx9xVZcRsCtGQsS3MBZSVXbfm1ZoORJ5UPGy4dONwPNN7SuZwZuidvPjWAfLpAFtghzYznAlCkGM5bWSfSNqLQ854IMtZUdRnvww
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR13MB5632.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(11063799006)(18002099003)(22082099003)(38070700021)(6133799003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TzRtdWUraDBvaDF0WFhxdUhWb0JFVzRGT0xRTmszdUZ4dHd6aGVYT2phcWFm?=
 =?utf-8?B?cXM1K2Q1UWJqRUdkNEQ2anREUFIraWlYY1lRRjNhU1ppM081WmhqVEUwRWhN?=
 =?utf-8?B?b280UExsNnpNdXlMaUZVNHNWNzZtRkk0cUZOSjF3UTRTN2ZBSUM5c01vdm1p?=
 =?utf-8?B?aVkvYUFXT28zUkN1Z3pZcWZ2U2JmZGZvV0NkdG94eHc2L0J1YlRTcGNSRVBC?=
 =?utf-8?B?RU8xVnlpR05tTVZIL3h2U01tSW5WbVRSMkppb3lyMjBmMjRwNzN2N3oydVQw?=
 =?utf-8?B?Q1h6amIyaFFjSmF1Mi9wUnZMQy8zSUJvUDE5NGZGK2VMVGc1MHYxYW1ZZ3p3?=
 =?utf-8?B?Tzh4YnVqQzQyUWtlMmFsc3VPaUdiYUpYTzBqc2NKc1VhNVlRYVNKdkZBZnBv?=
 =?utf-8?B?UjZLZVBjVERyQVB0MUJ6Q0xpK2pOWUcrYnVIVEMvZldYWGM5UWtkbzZMRHFT?=
 =?utf-8?B?OFBsTGFvOExmeFo5ejZvZWFlcVJiZFFxcjJpTTRYU3pCWEpWdEZNMUhZVW5W?=
 =?utf-8?B?c05RZFpwbjVLdjM5d3ZJUU1JdmcrRmsxR2U2c29ZTVRhQjcwVGNraFduemRT?=
 =?utf-8?B?Mk1BbW8xM2YxMmVEVk5NbThiOXFJdTV3WVVsN3FXUXZIK3J1TVczbnNJOEJE?=
 =?utf-8?B?azByUGJ0K0FRU2NobjFLUjVwNDdZSlpaN1JCQkwxRWVnWXQyUVpvNFNvQzVM?=
 =?utf-8?B?RGVCa1VPQkpJUnpkamdXeUxnUmt1ek1neS9uYmJUam52TlUxR3VhMUNNV1Ex?=
 =?utf-8?B?QmYyNDFMTmtEOGVtbW92Zk4xYXpaOEhmUFpuQlBESFI5YUlTTkpOVUpQSVJV?=
 =?utf-8?B?Q3RRaThhTDF3RHA5TWRiZitocnpIOWt1cjdzRjYrdU12SktnNW9uNzM0d0Zn?=
 =?utf-8?B?WElpUU12bi9uSkdDVFlyU1JoMVNHc2FMbVZjYUVNY3d2ZW9iWWlTQ2l5b3B5?=
 =?utf-8?B?NlYrZ0JDdXFkaUErdVR5Ymd2WGVkbjcxejk0bWNaUVg2WXQyQmdaZUc3QlYr?=
 =?utf-8?B?OXJvOEFKRXd0S0oyY0hmalAyaXl1ZlBnUlNkelhDQ3VXdUNBZWZzWi9FRGJZ?=
 =?utf-8?B?R0xBSXBQZFgxaGlPNXZ6c0tuN01WN2cwaFpORTdWNTNXcUNTU0sreDhhajdQ?=
 =?utf-8?B?dWIvRDd2dFJ1NEZBVVNUMm1jUVFOU1dBVERCUWxXUC8vRHZuVzk3d25qdklo?=
 =?utf-8?B?eDJvY2FvdTVUclV5Z1ArWlhpOU9LbkdwS0FvQ3pkU1dPWmJJY3dTdmo4d1J0?=
 =?utf-8?B?aDBlUXB3d3pha2p1M3ozeGQwK1BjbGh0c3FQQVBXV1p5VlZRdGRDNzVOZzlP?=
 =?utf-8?B?SjFzS3JUMGZFdFBEZFhzMWdISzRXcktNbnovRTVqL2RmdVNGU0FrTG5HMlc3?=
 =?utf-8?B?YzJsQmlGWmFzUnpXWERqNzh4ZHpwMHgwanpIZHBtbHNUUzBIRmRCcm1NL1g0?=
 =?utf-8?B?TmIyV0VJQU04SEhEYWZRWXU2d0hjWnpFeTFzclNQeU1IcFV3RCt4cHlHWlR4?=
 =?utf-8?B?NnI0eVJzNDVIbW9zWjhnV1JLR2hRU1VsMHBESWZzK21CU3BpaExjcWVMN2pY?=
 =?utf-8?B?NzFDSWdCbC8xZGZpcnhacTlVYUQxMFlYQXJSQ1BYV00rVlgxR1dvN0Z5ZDhI?=
 =?utf-8?B?NndCYlQ2M3B0QnNreUliL2dvMk5mVytFdXp6bCtscTN4TXRyNkJma1B3WVhC?=
 =?utf-8?B?WDJDdmRpR3ZDc2VnRmdBSDhhSFJmVEVhVlladkl4RzEvTFVsWStsYkNWcHRY?=
 =?utf-8?B?UkhDS3FNd083ZitXYmlzUVFtc0ltQmxrZXErTmkzTDAvbkgzRlZ2TGZCUWt6?=
 =?utf-8?B?alZsakJaT3lncjFVNkJUSUJWbEduRjhXRzNUcHIzbkRjYVpZV0FTSkI0Nmpt?=
 =?utf-8?B?SXdWY0tydC8wd1UvK084Y0tOUlY4dkRIQ0l1UG82aFZTenV2cVNSRVVPZG5m?=
 =?utf-8?B?c3FXRVJmcFJUUmtERklmcnJZTFNSY3hNRFpHQ2N6cnQ5Ym9wUmhYM1BNYkVO?=
 =?utf-8?B?YjBVMUJuWllnNXhzM2ZYRzBGYzlGdThjNi82TXRpV3gzUkk5UlBTQnhIL0V6?=
 =?utf-8?B?MHgyam5hUUNWM3RHY0NldVZ4elhDMHFnVit2emtpYWNPNmtpOHBNUXJXZlV2?=
 =?utf-8?B?OXlpVnQ4OEwxcFZJSHBtdjgwdW5KV3o4UHF4dkdJVWlSSFYwVnFvUmpxKzJH?=
 =?utf-8?B?R0tGbEhib0pLV3Niay9DSEpCUGdXbzFyYVB0bWtONUxySk9nT3AyL2I5WVZI?=
 =?utf-8?B?MFBpY2xQaXJFNktSZnU3Nm45Ym1Ud2JLRm0vRk9MRHFWZTUzSFhUbGZCRk0r?=
 =?utf-8?B?V2VuTzhSNjdzeHRLNDBiSFdUYVFHMG5ONmJQRGlLZUY2dCt0ZVRkRVovbmJw?=
 =?utf-8?Q?6cDX3zgHw9w1kl2u7RbLYomP0rqH3VCQcsHvx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ol/a6kYKeXc7RKcyA8h2AA9jsQ6qXfcY/xh0eVqWGidMtf6lJwuOsH+9dvM/Tcms/mDnl5HRGbcHcNYY4K+GsQXiwk6OTed4AcfGgOIdiA60icwOvwaaZyU30umRubQkfCQiSxQAQll6TQukrm4xwwTJUX2VyMC9aiKHg36GXYlAOr1BUEo3Nf1i54UfR/LEvA9UbxVIaSM2n9yGjqyoRUgeiyz6sGH38uNb4mgliMu9+tZHzsK+C/l7D1GEjmN+FR2tz134y56V7b6y2LNVt+Bc9MHpMj1L4eJKTYg1W+K1R5ijrDih8afZpgW1fEsBqeCUf+vvIk/yBXK8Gsg5Mw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xxHbHqqnrv9bjZW2m2c348H7VUmrlka2KTZZJZewU5TZcGM2sGeY8WOKPg9VvQJ6uxF/CZLbMYuAowM29tJ1at6O05GM73q/iXmm0oyeHScx983U3Z6SnyoxCE599i3OSX6lKzv8jethmbi9oFTltj+3c0xPq8XX0U1ugap7Vh136K6AE1UHbwMCdZ9YjSINEve4JAKGazXczuz0WtzRMD9h66CaEkUu9IYhCSIRZac17pPhieBC7rReMkM5WXWpsCTg5MCGFQcBi/R8fwxYKXM9M8Hfr5vAmZYGSQxlqpcHs/wPzUKRXF56PHVowmkSsySNpXBUwOCVAzZaQD9LrhqPeEh8MvYpHWgq91uRwKt58qvP6Pmlk2ij3RZfUV7cLtST517XfL7JcwN6bw30LDCZ5NL6oSbffhoNPGE2wmQKdACprwdI73puieQstoMJGzn7GC5BBw8mXvfIn8Osm3XTXFOhA/h/VO0MN/P1hPltWPcu0E7Xz3Cl2fJFaXYsTaknr8IoSLsQyS+ElTmIpuoxOtyJ6AEPJptJwCHuGlr3+GiNjcFIpUkWFFBKpPZTEsBG8V3smC0apdi3q3QqgIucvvSA4N3ebkx40Jlhfj/urkHHI5zMNIZcXaHq1B/t
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR13MB5632.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c886a24-58b9-4fc6-5506-08dec31f2091
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 16:25:59.0603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UOdMYx6vAkh4BtJL2n8ziqdkVCxOaeh7BPtTKHiwbX+i1s2ZN73tl+6bJA1VUiI3IsZgMnaB1m4aRezI7V4giA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PR13MB7680
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDE2MiBTYWx0ZWRfX1R/5+iEXF9Fv
 oSsQWm8x8k2NoaPs9jyfPQmxqV6Ox6eMzyutgyQB4h5GVJ03qfaqW2D9f32pgu2PiN67DP9rYqs
 Nm6I5NASNseLrhRQd0JBqUd1clVF2eLIrpsb9S60X9Pi9ORwDyLTVFgUxJurLMZ6gRINyb+MIxW
 YocvbHOMASjJ/Yc51w9KoAiQvWtldqILWmj5O56wVL/+rTwcoJ4BLujsjStGqC/4F+Mazeejbyv
 PNeOsRlPT06KR9J462LmZvRfFyaNOWCeD1q+lAq6Y2fVm53jaQLGxy9DQy7A1PnbfeUtnX3479j
 kJSKKbWEZU529xQyDuRUqxYZnEpCsbBIthoOvEg95bD25GDWkV5MdZ3e31yFcF4Ca4HCd9RFZYB
 An0QjniKjsdMJtoh1I+NqMEHXSo2a9ep2rcGJLFg8iXXABqt2bXLr1nU6jmLCaBFWYlOBA5Y5wJ
 OqMFiNsOac8ZD9wzknQ==
X-Proofpoint-GUID: Fp4N19qYAsKs4vPn-z0BWIMSD9KPPAvb
X-Authority-Analysis: v=2.4 cv=EN42FVZC c=1 sm=1 tr=0 ts=6a22f89d cx=c_pps
 a=Ho/Krdd5x/ljPkV1+9yTnA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=xR56lInIT_wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KAb5x4SsHD3PzxGk7EmX:22 a=I_Y4LlEPCAdqsIK1J1Zo:22 a=z6gsHLkEAAAA:8
 a=hbFrjmCTSgUGz7BvLhoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Fp4N19qYAsKs4vPn-z0BWIMSD9KPPAvb
X-Sony-Outbound-GUID: Fp4N19qYAsKs4vPn-z0BWIMSD9KPPAvb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_03,2026-06-05_02,2025-10-01_01

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF1bCBNZW56ZWwgPHBt
ZW56ZWxAbW9sZ2VuLm1wZy5kZT4NCj4gRGVhciBUaW0sDQo+IA0KPiBUaGFuayB5b3UgZm9yIHlv
dXIgcGF0Y2guDQo+IA0KPiBBbSAwNC4wNi4yNiB1bSAxOTowNiBzY2hyaWViIFRpbSBCaXJkOg0K
PiA+IE1hbnkgYmx1ZXRvb3RoIHNvdXJjZSBmaWxlcyBhcmUgbWlzc2luZyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcg0KPiA+IGxpbmVzLiBBZGQgYXBwcm9wcmlhdGUgSURzIHRvIHRoZXNlIGZpbGVz
LCBhbmQgcmVtb3ZlIG90aGVyDQo+ID4gbGljZW5zZSBsaW5lcyBmcm9tIHRoZSBoZWFkZXJzLg0K
PiA+DQo+ID4gTGVhdmUgdGhlIHdhcnJhbnR5IGRpc2NsYWltZXIgaW4gZmlsZXMgd2hlcmUgdGhl
IGxpY2Vuc2UgSUQgaXMNCj4gPiBHUEwtMi4wIGJ1dCB0aGUgd29yZGluZyBvZiB0aGUgZGlzY2xh
aW1lciBpcyBzbGlnaHRseSBkaWZmZXJlbnQNCj4gPiBmcm9tIHRoYXQgb2YgdGhlIEdQTCB2MiBk
aXNjbGFpbWVyLg0KPiA+DQo+ID4gSXQgaXMgbm90IGRpZmZlcmVudCBlbm91Z2ggdG8gY2F1c2Ug
bGljZW5zaW5nIGNvbmZsaWN0cywgYnV0IGlzDQo+ID4ga2VwdCB0byBob25vciB0aGUgb3JpZ2lu
YWwgY29udHJpYnV0b3JzJyBsZWdhbCBpbnRlbnQuDQo+IA0KPiBDb3VsZCB5b3UgcGxlYXNlIGFk
ZCBhIG5vdGUsIHdoeSB5b3UgdXNlIC8qICovIGluIGhlYWRlciBmaWxlcyAoc3VmZml4DQo+IGAu
aGApIGFuZCAvLyBpbiBmaWxlcyBlbmRpbmcgd2l0aCBgLmNgPw0KDQpUaGlzIGlzIGRvY3VtZW50
ZWQgaW4gdGhlIGtlcm5lbCBwb2xpY2llcyBmb3IgYXBwbHlpbmcgU1BEWCBsaWNlbnNlIGlkZW50
aWZpZXINCmxpbmVzLiAgU2VlIERvY3VtZW50YXRpb24vcHJvY2Vzcy9saWNlbnNlLXJ1bGVzLnJz
dCwgU2VjdGlvbiAyLg0KDQpUaGUgcmVhc29uIGlzIHRoYXQgc29tZSBvbGQgdG9vbHMgdGhhdCBw
YXJzZSAuaCBmaWxlcyBkbyBub3QgKG9yIGF0IGxlYXN0IGRpZA0Kbm90IGF0IG9uZSB0aW1lKSBj
b3JyZWN0bHkgaGFuZGxlIHRoZSAnLy8nIHN0eWxlIGNvbW1lbnRzLg0KDQpEaWQgeW91IHdhbnQg
bWUgdG8gcmVwZWF0IHRoaXMgcG9saWN5IGluIHRoZSBjb21taXQgbWVzc2FnZT8gIEknbSBub3QN
CmZhbWlsaWFyIHdpdGggYW55IG90aGVyIHBsYWNlcyB3aGVyZSB0aGUgb2ZmaWNpYWwgY29kaW5n
IHN0eWxlIGlzIGV4cGxpY2l0bHkgbWVudGlvbmVkDQppbiB0aGUgY29tbWl0IG1lc3NhZ2UsIHdo
ZW4gdGhlIHN0eWxlIGlzIHVzZWQgaW4gYSBjb250cmlidXRpb24uDQogLS0gVGltDQoNCj4gPiBT
aWduZWQtb2ZmLWJ5OiBUaW0gQmlyZCA8dGltLmJpcmRAc29ueS5jb20+DQo+ID4gLS0tDQo+ID4g
VjIgLT4gVjM6DQo+ID4gICAtIG1vdmUgU2lnbmVkLW9mZi1ieSBhYm92ZSBjaGFuZ2xvZw0KPiA+
IFYxIC0+IFYyOg0KPiA+ICAgLSBMZWF2ZSBkaWZmZXJlbnQgd2FycmFudHkgZGlzY2xhaW1lcnMg
KHdoaWNoIGlzIG1vc3QgdGhlbSkNCj4gPiAgIC0gUmVtb3ZlIGZpbGVzIHJlY2VudGx5IHJlbW92
ZWQgZnJvbSBkcml2ZXJzL2JsdWV0b290aCBmcm9tIHRoZSBwYXRjaA0KPiA+IC0tLQ0KPiA+ICAg
ZHJpdmVycy9ibHVldG9vdGgvYnRyc2kuYyAgICAgICAgIHwgMTIgKy0tLS0tLS0tLS0tDQo+ID4g
ICBpbmNsdWRlL25ldC9ibHVldG9vdGgvYmx1ZXRvb3RoLmggfCAgNSArLS0tLQ0KPiA+ICAgaW5j
bHVkZS9uZXQvYmx1ZXRvb3RoL2hjaS5oICAgICAgIHwgIDUgKy0tLS0NCj4gPiAgIGluY2x1ZGUv
bmV0L2JsdWV0b290aC9oY2lfY29yZS5oICB8ICA1ICstLS0tDQo+ID4gICBpbmNsdWRlL25ldC9i
bHVldG9vdGgvaGNpX21vbi5oICAgfCAgNSArLS0tLQ0KPiA+ICAgaW5jbHVkZS9uZXQvYmx1ZXRv
b3RoL2hjaV9zb2NrLmggIHwgIDUgKy0tLS0NCj4gPiAgIGluY2x1ZGUvbmV0L2JsdWV0b290aC9s
MmNhcC5oICAgICB8ICA1ICstLS0tDQo+ID4gICBpbmNsdWRlL25ldC9ibHVldG9vdGgvbWdtdC5o
ICAgICAgfCAgNSArLS0tLQ0KPiA+ICAgaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL3JmY29tbS5oICAg
IHwgIDUgKy0tLS0NCj4gPiAgIGluY2x1ZGUvbmV0L2JsdWV0b290aC9zY28uaCAgICAgICB8ICA1
ICstLS0tDQo+ID4gICBuZXQvYmx1ZXRvb3RoL2FmX2JsdWV0b290aC5jICAgICAgfCAgNSArLS0t
LQ0KPiA+ICAgbmV0L2JsdWV0b290aC9ibmVwL2NvcmUuYyAgICAgICAgIHwgIDUgKy0tLS0NCj4g
PiAgIG5ldC9ibHVldG9vdGgvYm5lcC9uZXRkZXYuYyAgICAgICB8ICA1ICstLS0tDQo+ID4gICBu
ZXQvYmx1ZXRvb3RoL2JuZXAvc29jay5jICAgICAgICAgfCAgNSArLS0tLQ0KPiA+ICAgbmV0L2Js
dWV0b290aC9lY2RoX2hlbHBlci5jICAgICAgIHwgIDUgKy0tLS0NCj4gPiAgIG5ldC9ibHVldG9v
dGgvZWNkaF9oZWxwZXIuaCAgICAgICB8ICA1ICstLS0tDQo+ID4gICBuZXQvYmx1ZXRvb3RoL2hj
aV9jb25uLmMgICAgICAgICAgfCAgNSArLS0tLQ0KPiA+ICAgbmV0L2JsdWV0b290aC9oY2lfY29y
ZS5jICAgICAgICAgIHwgIDUgKy0tLS0NCj4gPiAgIG5ldC9ibHVldG9vdGgvaGNpX2RlYnVnZnMu
YyAgICAgICB8ICA1ICstLS0tDQo+ID4gICBuZXQvYmx1ZXRvb3RoL2hjaV9kZWJ1Z2ZzLmggICAg
ICAgfCAgNSArLS0tLQ0KPiA+ICAgbmV0L2JsdWV0b290aC9oY2lfZXZlbnQuYyAgICAgICAgIHwg
IDUgKy0tLS0NCj4gPiAgIG5ldC9ibHVldG9vdGgvaGNpX3NvY2suYyAgICAgICAgICB8ICA1ICst
LS0tDQo+ID4gICBuZXQvYmx1ZXRvb3RoL2hpZHAvY29yZS5jICAgICAgICAgfCAgNSArLS0tLQ0K
PiA+ICAgbmV0L2JsdWV0b290aC9oaWRwL2hpZHAuaCAgICAgICAgIHwgIDUgKy0tLS0NCj4gPiAg
IG5ldC9ibHVldG9vdGgvaGlkcC9zb2NrLmMgICAgICAgICB8ICA1ICstLS0tDQo+ID4gICBuZXQv
Ymx1ZXRvb3RoL2wyY2FwX2NvcmUuYyAgICAgICAgfCAgNSArLS0tLQ0KPiA+ICAgbmV0L2JsdWV0
b290aC9sMmNhcF9zb2NrLmMgICAgICAgIHwgIDUgKy0tLS0NCj4gPiAgIG5ldC9ibHVldG9vdGgv
bGliLmMgICAgICAgICAgICAgICB8ICA1ICstLS0tDQo+ID4gICBuZXQvYmx1ZXRvb3RoL21nbXQu
YyAgICAgICAgICAgICAgfCAgNSArLS0tLQ0KPiA+ICAgbmV0L2JsdWV0b290aC9tZ210X3V0aWwu
YyAgICAgICAgIHwgIDUgKy0tLS0NCj4gPiAgIG5ldC9ibHVldG9vdGgvbWdtdF91dGlsLmggICAg
ICAgICB8ICA1ICstLS0tDQo+ID4gICBuZXQvYmx1ZXRvb3RoL3JmY29tbS9jb3JlLmMgICAgICAg
fCAgNSArLS0tLQ0KPiA+ICAgbmV0L2JsdWV0b290aC9yZmNvbW0vc29jay5jICAgICAgIHwgIDUg
Ky0tLS0NCj4gPiAgIG5ldC9ibHVldG9vdGgvcmZjb21tL3R0eS5jICAgICAgICB8ICA1ICstLS0t
DQo+ID4gICBuZXQvYmx1ZXRvb3RoL3Njby5jICAgICAgICAgICAgICAgfCAgNSArLS0tLQ0KPiA+
ICAgbmV0L2JsdWV0b290aC9zZWxmdGVzdC5jICAgICAgICAgIHwgIDUgKy0tLS0NCj4gPiAgIG5l
dC9ibHVldG9vdGgvc2VsZnRlc3QuaCAgICAgICAgICB8ICA1ICstLS0tDQo+ID4gICBuZXQvYmx1
ZXRvb3RoL3NtcC5jICAgICAgICAgICAgICAgfCAgNSArLS0tLQ0KPiA+ICAgbmV0L2JsdWV0b290
aC9zbXAuaCAgICAgICAgICAgICAgIHwgIDUgKy0tLS0NCj4gPiAgIDM5IGZpbGVzIGNoYW5nZWQs
IDM5IGluc2VydGlvbnMoKyksIDE2MyBkZWxldGlvbnMoLSkNCj4gDQo+IFvigKZdDQo+IA0KPiAN
Cj4gS2luZCByZWdhcmRzLA0KPiANCj4gUGF1bA0K
