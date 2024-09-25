Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71961AACB
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Sep 2024 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727282546; cv=fail; b=KQcZSy9Rkm6M37cFWp2kEJvUNSMUhJ+UVg2q5QKKz28AEmvWRh2EBwmOQzpwnD5rWRytc5o7Ev27Iiy7pLFJlbg5R4GfM33nuCKrcYkN23RdrChSOvOMuACcyLE2xufTRgDjB2pswi+VHDq0zaJ7thPFrox78fgaobpOK/U0iI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727282546; c=relaxed/simple;
	bh=L8Zmp4d+JvoI1zEhuRx0ORwgMMVlqnmnUav6yP/LGhk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mq/vcMTnkUG33SM7t2L4g4yYlPt1mnkmuvtg2tQQp2s6YAZQvrZG3A/LXEXNP9A7zX6noFcZF9+S7myhGG/jvfslZnvYLxd22gl/KKObQNUK7CfKjmOjrq+j+PKnKz20cA4iOOMuoj04xm67lSeWp55nAlatGH+OM+Y5iugn0t8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aAxMI+Il; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aAxMI+Il"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727282545; x=1758818545;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=L8Zmp4d+JvoI1zEhuRx0ORwgMMVlqnmnUav6yP/LGhk=;
  b=aAxMI+IlUzzFNPO2T0zSR9EAvAWFS/fPQFEEy+mlPDDu1VHt0t250O1Z
   YKgrSPmKTWpfzPxsK11cfDUIEEknxg5tVinYnC5pK62UkNmaC9VJQDuOm
   x44lAy1B2yh24a13EGVvcgLtpokq7vl790aFnEHiycLaqCQF/DsXXsOVx
   ZTmaLULNvYuZezmqBttFVSvI7nFqCcqHs/6VfzRXFh/gIyzXCaY5NhAUl
   mIM8vsb/RnY6qGjh9K+ynikv6TDZufY8215CqZgl05bjoYoL+kjaicIeP
   VUTf4NBFYfI91cb3RnTXFNe2MxwEQP4oY7whJ4olI5ppwdgYMwWAShE9o
   g==;
X-CSE-ConnectionGUID: locHB+0JTIOhsnHNj+LJUQ==
X-CSE-MsgGUID: ezOtVfSwQTqTnqjTYqBI/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26156195"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="26156195"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 09:42:24 -0700
X-CSE-ConnectionGUID: EQ9DHQLGRs6hX3oQxqpFZg==
X-CSE-MsgGUID: schBheWCTgeWeYuBF041uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="71719924"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2024 09:42:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 09:42:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 25 Sep 2024 09:42:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 09:42:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sv905rTGoJwGqjFgaDN4kvq38xLKGNs8NHqcdQQBksX2obHflW7nd7NlwJmm+TaLQfgOffBjDQC0yXKpTrrpkiDGxiJwZlu5NbBw1NwnL3NYe8mBKN0ebmONaV+NOcfXkKGNrwuP1DdIklFZoTzqLT1XRX7IfIwXL9UJurGf8HzesZ6BsFFyJI1MQzudw6KBrw7PlE1FF6OfLb3VWnQS1HYN+HUKAQObfORLbjmaA2vMqs9HwHxGUvTzaA6dH2oSqnCYoEUeFptSgmodSUOB5ICE22I9lDMQjGQmfIB0o5SRasAHUwAofLET9XV1s7bN3e+z9Yvvg8Q4Qi4GTsAbcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxBa91OppmTtHBGgsww5PG2x2egD70Zmmg9rjJRG5WA=;
 b=ijos5Trl2X97UQlkGldvwzTiISD8wLxVnawkEUw787lK8JN+799DT2UbSj6Ut9tw/tSGjDvc6XxAkV4YMo3QgjlNNQEklqw/FISjmtR19MSm3PybSqEOeGp4Yt3I4+1jc5RlnlnenTVJWl+9fn1s2lzYUVEuXCF+g2Tf++oYXMyQp2TL5Nvm+J+QQTYMdNPnncq6OZGazX3uIgExWbqnIIKaSHGbz+gBbsiHg2EGNEih6KWjtmx7O6nIDDNYsTUHpj6A3NtHzIIbu/qPo7EEmQL4I8/vuhZHfli4FyKmUvXGekLYC0lGyoK44cK4QyTV6Qmlby6koaB4RqpCCRYogg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by CH3PR11MB8465.namprd11.prod.outlook.com (2603:10b6:610:1bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 25 Sep
 2024 16:42:16 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%3]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 16:42:16 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v2] Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring
 with LE
Thread-Topic: [PATCH v2] Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring
 with LE
Thread-Index: AQHbBS9hOTPxPZsYP0iuSDxZ4e6kcbJoyI9g
Date: Wed, 25 Sep 2024 16:42:16 +0000
Message-ID: <PH0PR11MB7585F711DE7F2B9BFE041A19F5692@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20240912161700.2976337-1-luiz.dentz@gmail.com>
In-Reply-To: <20240912161700.2976337-1-luiz.dentz@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|CH3PR11MB8465:EE_
x-ms-office365-filtering-correlation-id: 40bd61d8-2f0a-40cf-6e18-08dcdd8103b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?n/VwpiS4r9nig2+y1eX6qOFGTU78741oILP10afIF2sbYEj6C7X4bg2HaLxk?=
 =?us-ascii?Q?VCMpUYsADwcmPoL1e2EU1BW5EMBnDFt05jmIQAtHZgyzZKdfCutOao5kgtOf?=
 =?us-ascii?Q?wDMSGsGLpQp+pZyhUp4WprU6jdOKGm5gfX6tIGNtNPFVw41IJNlKQr0xAbxa?=
 =?us-ascii?Q?hgQbPgjeoPG6nRuZMgvkSr1/Jr0ZVK9hB9Ulnk3Q0SFTyzup0ezD5PP5laQO?=
 =?us-ascii?Q?Zm3ZQGSM66svk+8BG/QV6b6VFX7Hcoj8IJsBSPCaQCTmwUnCbcNU8OyJnmOL?=
 =?us-ascii?Q?8DLvOfsDhAlQAylWw+IZiRjWyHrNk0g5IEIynNp313ZZanoUhCdbZpo/xbJ4?=
 =?us-ascii?Q?QsmN6iG87DoNbHoeTr6R05A8gp2eT9NM6Kjks0PQd5nQynTtsFpeyiPUCpcN?=
 =?us-ascii?Q?bswayX0PRuJmghrw1drrTMk8xDRPjWGYVLdfKiwm99zumtj1VN4VLIGnI2YY?=
 =?us-ascii?Q?q+ln/NnWtny1kcuok5pMy9KR3glnPI2rvok+oCk6zf0jzJOI6MYxDa+0+1uS?=
 =?us-ascii?Q?5w1MAmkRd78iAAl7gjJsJ6pYf34w8pYsBNr/ANRXttNOX/E62L1llgrNpgKE?=
 =?us-ascii?Q?4pnW4lLqsEod3rLLEEAvpJ9+cyCseYEaG4l3SPxBWRUCFnz0qXb6T1DLIdNX?=
 =?us-ascii?Q?acMGyDZ1e0+3BvQIb0YCSEdIffsgbPUqk8NDcGA/r2YCicKcs7e+r9xcw2Or?=
 =?us-ascii?Q?1k+jInQDnCB9hCklpFJxvER2tLZFoup5BcopV97ZC4XaObqbriqagnTqKgfo?=
 =?us-ascii?Q?4mEgp78IlxTkqk8jMGMelHBPVISfCpKpnA5G021fZOWQF951IapleRXQ4gCh?=
 =?us-ascii?Q?3dpO6XiZgTaSywuyzKMK/yX3VnVwOSL0+ksuGM1aS0yEfHqGXZgqI19wJW97?=
 =?us-ascii?Q?/U+NL9HR184osBdGCrzhGcu7mjpuheWI7GBZyD6pCsbgGea70SNOfVRSfwyw?=
 =?us-ascii?Q?xuQy3xYYT+dNeBArhTNHLJthyGA42mQFMuUgpZaXKhsM79p6rYkbGTWX/ELl?=
 =?us-ascii?Q?MvNYxj++8fkAfFmaHuD7w6ZmtX5u0HIaPuUdDGUFMsihDoUj9PjhY456WQkn?=
 =?us-ascii?Q?6YF4PEN7MkDKk0g51f5xta9EYVSyMArgmhVxgPBm53MVY3ZSnNMrsORmCppn?=
 =?us-ascii?Q?/MTkWxaO00HTnDyOEvY6kTxhborqvSznzaB1/oODJ2IYS2e0NaIaiPgcgE94?=
 =?us-ascii?Q?OLxyMrV+rhHY2elo4D3d5aUv+O0UG3mEwj63+d4Zx8Ndm7WFUdNEu4n4M6py?=
 =?us-ascii?Q?xq3jboB4xR4E9Mf6yPJYAo+rxvsyveOLLNzYUxbsXfNxVwDpnMLZXcHVFd/r?=
 =?us-ascii?Q?Ui01h88BQM8gDfNLqiGgY/6nBhh8lvxiGEB4Q5b9qBYrTzZIpSVwp2oDxaNP?=
 =?us-ascii?Q?ZhaA9DzcVqfYq11wHbizEMzZGof93ReyiqKsSPMkDH//hHdZuA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SFYfzF8Ed2Hjo/9A+S58JMZRA3pH9k6Gfs2GZ+CkoCmyOXoAnJ93vkoiadAz?=
 =?us-ascii?Q?2dRJdulC1HWffTJ9kKXWb9SrYMNVQQGzerJmNygENJySUN/nQhmkUyApjXDK?=
 =?us-ascii?Q?40ZlScehpe73RisvmK3lq4tT58b7y4HgRDZlACWS2HWp+4b8DdyuQGPVhkXE?=
 =?us-ascii?Q?llk9+XvjdyKgHx+szgtm2WNhMsR9X6w0sttjNLpHXKoK2BVzFkdyRkCWaMxY?=
 =?us-ascii?Q?eVGjZtYA6pCUrq9bvFmU2sMdCVXdcJmMkxoSYG8AHidRAu8Ob9mmj+QfOCvq?=
 =?us-ascii?Q?1HKcNOX+oo66DAMzyq0172QTDTWDDaFaOyaNsupUGCrTNImC6LmLNYEY28ak?=
 =?us-ascii?Q?N0KGIZyg1GndFDc+7Db+N5mTSHzV92vyulBIpzPAaQUUTFCQrNm2AwJ2RzO4?=
 =?us-ascii?Q?kMdbmrlshZczcDOvJRxb8sZvbHwgxWpk+vA3bGf3oJlBityvfiHapubjHrjM?=
 =?us-ascii?Q?JQvkBWNgOw3jLgzhOur/m05EmXvG3i0UehlbaItq8B0tBj4fhLX4OJvfVXYD?=
 =?us-ascii?Q?cO/RBgrIRmWRPDswR1A+heBEqP5eFQBxD+qLUbmMbh4/1hdxBjjW/p6slSxg?=
 =?us-ascii?Q?rRXlljBazSa3OyDa95hd31Z46VJl27El84Tz8uO2wd9KnHou2B3diHQqPoi5?=
 =?us-ascii?Q?avQGBLXY5YLO5fB69LTLVygw3wcmMfYW5JaDH7qvHnfd1L5mu8bUUp60g+8j?=
 =?us-ascii?Q?z3HdO69P200wJPEYaNfTsonPAnAOmAx+QVDvHDZEuY3DTaBT/exy7MQZ1br4?=
 =?us-ascii?Q?sAiDHvLuu1jt6i7hBc7QbLFWlK6A4CEi+IbkDzA5zBp4WLa4SQWtMMu5w/Y1?=
 =?us-ascii?Q?xlszWr8XkkMY1VVTXUIfntblbLaMVRkV4mDyRku88oMft7Bu7cGrY2wl4Dgq?=
 =?us-ascii?Q?65RWg4/K/Ejb12RYMYH4f1/uqR4nehbqnSzDq4yK2Z9geoWrGiTlLtWpZu4n?=
 =?us-ascii?Q?5s4zSiMWXC3VkSMC+MGcUMrrz3QWjzhXkitW4pagMbDNc+U+rBripWHoWdDf?=
 =?us-ascii?Q?orZYUtvdVEuKKnY1rD7bBzWkxKy8EV6KIdJyzxW8ksvLYkC+GK/Mc4b6X60Y?=
 =?us-ascii?Q?b7p1fdCHRxmDcBtY/7xFUTJslH6+WSC1gtpWIoxd5ZKmV4V7SydKeBRes58a?=
 =?us-ascii?Q?eDXotE3FFHBIzAncrmxXYKXsW8XelU7TgN7n9NXHG8iX6eyefN7AHRKvgDEU?=
 =?us-ascii?Q?Ope0dPl+rloVMihUGwPXlbTdI4MFzwD0jWxlzO3JqjNk8u7aINryit1We//m?=
 =?us-ascii?Q?bUg8+aGKC90JArJudOvKiT/zsrNZoCPrLprH7TqQyT4CEIJitmxzyirYZK8M?=
 =?us-ascii?Q?l5gQMQ3jLQcM4pa492L4t3LVOcU+oNXf1MHb2SwasDbXAYe276dT0nSqOox1?=
 =?us-ascii?Q?7OV2qWYkUxQBGq0PqCXuc/m664eE5pwxfybub+dgjLpZaxwCA3abdTeAYzfm?=
 =?us-ascii?Q?GLdeizv5nZOABHejo0OMqM8SirT8ikVCcmJk0Ntw3eN+5QTBV2tBX11wHpdh?=
 =?us-ascii?Q?WykVHLzfrRX0xuX3m14yZfiEOLWoPBvCxO9xDt0VNf2brz5aYl/KPEmFVVSP?=
 =?us-ascii?Q?bRoh0YQsgmod1R6fgrw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7585.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40bd61d8-2f0a-40cf-6e18-08dcdd8103b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 16:42:16.2096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SSFc7L7h6hlzxfW464QytAUHhsDTWIKdcQZqIp+sIP57N6SkMUbcLNaXZ94MWiJYD++LaQ5iBpuzeP0UX1x7Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8465
X-OriginatorOrg: intel.com

Hi Luiz,

>-----Original Message-----
>From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
>Sent: Thursday, September 12, 2024 9:47 PM
>To: linux-bluetooth@vger.kernel.org
>Subject: [PATCH v2] Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring
>with LE
>
>From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
>This aligned BR/EDR JUST_WORKS method with LE which since 92516cd97fd4
>("Bluetooth: Always request for user confirmation for Just Works") always
>request user confirmation with confirm_hint set since the likes of bluetoo=
thd
>have dedicated policy around JUST_WORKS method (e.g.
>main.conf:JustWorksRepairing).
>
>Cc: stable@vger.kernel.org
>Fixes: ba15a58b179e ("Bluetooth: Fix SSP acceptor just-works confirmation
>without MITM")
>Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Tested-by: Kiran K <kiran.k@intel.com>

>---
> net/bluetooth/hci_event.c | 13 +++++--------
> 1 file changed, 5 insertions(+), 8 deletions(-)
>
>diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c index
>1c82dcdf6e8f..c93c76d455f7 100644
>--- a/net/bluetooth/hci_event.c
>+++ b/net/bluetooth/hci_event.c
>@@ -5324,19 +5324,16 @@ static void hci_user_confirm_request_evt(struct
>hci_dev *hdev, void *data,
> 		goto unlock;
> 	}
>
>-	/* If no side requires MITM protection; auto-accept */
>+	/* If no side requires MITM protection; use JUST_CFM method */
> 	if ((!loc_mitm || conn->remote_cap =3D=3D HCI_IO_NO_INPUT_OUTPUT)
>&&
> 	    (!rem_mitm || conn->io_capability =3D=3D HCI_IO_NO_INPUT_OUTPUT))
>{
>
>-		/* If we're not the initiators request authorization to
>-		 * proceed from user space (mgmt_user_confirm with
>-		 * confirm_hint set to 1). The exception is if neither
>-		 * side had MITM or if the local IO capability is
>-		 * NoInputNoOutput, in which case we do auto-accept
>+		/* If we're not the initiator of request authorization and the
>+		 * local IO capability is not NoInputNoOutput, use
>JUST_WORKS
>+		 * method (mgmt_user_confirm with confirm_hint set to 1).
> 		 */
> 		if (!test_bit(HCI_CONN_AUTH_PEND, &conn->flags) &&
>-		    conn->io_capability !=3D HCI_IO_NO_INPUT_OUTPUT &&
>-		    (loc_mitm || rem_mitm)) {
>+		    conn->io_capability !=3D HCI_IO_NO_INPUT_OUTPUT) {
> 			bt_dev_dbg(hdev, "Confirming auto-accept as
>acceptor");
> 			confirm_hint =3D 1;
> 			goto confirm;
>--
>2.46.0
>

Thanks,
Kiran


