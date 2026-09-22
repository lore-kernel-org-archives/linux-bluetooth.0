Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBB3542EE8
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081026; cv=fail; b=Q2WCG9HcOrh7Nxis4opbjz1TLV76cC0mNqaE9yhm4w0dyhQLWcO3qVbM7vRy7QHudAUoaKzWh4Coy/ukNzug59ndTxMxC7wNAVYcMCxBDW5m23JNlFICkAX/yhUNi9Z5eh3F1L7mk9V1nL/EAcl8WIrXMMrnmcWKEEB+yXcfias=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081026; c=relaxed/simple;
	bh=rDFMHSvCWjgCA/prf/icv4YpVKPmhngfcwU0Qwx+IiQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T7558SDjBPHxoMkpd95OP/fAr9SXR6zjCq5+4ReRFdImy2zvqYAKei5nhTOIswDtketeDOVDZq1W6iqYY1db/xDWTcJFns1wvpqdiWVSgYS3c1lHYrw4FLX7PB4eos8Ubde93EmAHR5x/Efy49dRgoLvL+H0rx0MbF/5ges+d60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EupRYBTb; arc=fail smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EupRYBTb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790081025; x=1821617025;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rDFMHSvCWjgCA/prf/icv4YpVKPmhngfcwU0Qwx+IiQ=;
  b=EupRYBTblgwdG4CARrTcEL1T2hz2GxVn0rNpq3l0yJtxs8WATo5l9JMN
   XdHidIeFG2eBMEJm8kvcVsM5wrTVFQ+fgmV00/6dQfJm0RNZW9NSP9FUM
   t1Xk+Gz8hsYPGh5RxgGHCysKFHCIDvPCktaHxEeJmNTzXc09VIIUif95i
   zI8xWeP2BDH8NmiQIPckNX1fwDFNRgyaozMsTi7s+lEUSxtSzwYtm8YdL
   H0ffgYiX8E+KpfbYmOOSg59FlHb8y3ZIeUhKjNN6Zfy0BS0VCdZa6Gc5M
   8d/ymTWBc5KFdZB5RHvJ752MHNIYPQI8R7X53ciMr86YlqFchkJnOd+2X
   Q==;
X-CSE-ConnectionGUID: rWaCfAKuT0i1bhjNoZ6PnQ==
X-CSE-MsgGUID: exawYWQESz+A++BnfbgysA==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="1187196"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="1187196"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 05:43:44 -0700
X-CSE-ConnectionGUID: KGwVU8+5Sayyyolax81pLw==
X-CSE-MsgGUID: tw4nD85aQxiEnuWeXKIWUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="4108838"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 05:43:44 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 05:43:43 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 05:43:43 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.21) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 05:43:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vl6u6sV0iJFhQLk6F75ar2Wl7ry9Eytyk6DtVgC1W/LIVPXXMoEbPYXWDXh04BOdwMm/Abcr7chuX5etOschJUxcB/xU7QJGFdcuV9iQu/JQ2agl4muNTlevpOR/IwL0yD4ozCLEwK7yyl9EkYySdbPW07/r3pxy5P/FFAxHhgNCgvZzfl/hR5Xss8EijyXeXmVX3f4m/bphT5lJ+8A502bUU3imIMPYAKrOo/Uzefl3v04bRus/2w1N87AHRduCWKiCW5F8YaHcHI3NZZfMH74XwMF+ybyWLriJL5bkEruZBs559Qkpcvywdlq3L6fpM1PyPkb6nv6kEEVH10e5YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QEGROYC2JSx6cIIS/2dKya7E3o4JgHtqmpBh56ANDw=;
 b=tkHxfSiakskI3dgB8MJktTjpfSZCnC4+WAXW/Ra0a0ypzHs572aXbsWiIUF6b1Ak0UxJXcODGR197yGO0qLBJ/Vr8X9xjwrdywBfJUJWtnnOd4i1GnF6DYkjeLEEzShtTnTM0eZL8pLSI76Mkn0yp2622m8OD/Ge50y4gyySlU+md3eDehBmPoaQOllmOL8u3Ioaic0ZDrPMW3zjfJBw9LIXk7vUZgwDVTTFQv3knownBnuVsNf8jE8ynsPT4KIucg28LT55EHZyP5Y9LNn16ZogYIVTKYSFAcQixNXG4XkwUGsb5iD7MQXfKq8XG45wr/LujW7SxtYTuuYaCK8JGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by DS0PR11MB7286.namprd11.prod.outlook.com (2603:10b6:8:13c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 12:43:41 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6828:7da2:8d9f:3283]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6828:7da2:8d9f:3283%3]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 12:43:41 +0000
From: Aluvala Sai Teja <aluvala.sai.teja@intel.com>
To: Jeremy Dean <deaner92@yahoo.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
CC: "K, Kiran" <kiran.k@intel.com>
Subject: RE: [PATCH v1] Bluetooth: btintel: validate DDC record lengths
Thread-Topic: [PATCH v1] Bluetooth: btintel: validate DDC record lengths
Thread-Index: AQHdSjvT1/mV+tFXUUeWMhajs+PxZbbaKd1A
Date: Tue, 22 Sep 2026 12:43:41 +0000
Message-ID: <MW5PR11MB5881C7B240C7AB3285E25C5DCC832@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20260918083838.23676-1-aluvala.sai.teja@intel.com>
 <20260922024034.2186-1-deaner92@yahoo.com>
In-Reply-To: <20260922024034.2186-1-deaner92@yahoo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|DS0PR11MB7286:EE_
x-ms-office365-filtering-correlation-id: 3584b130-0889-48a7-55ae-08df18a721b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|38070700021|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: VYN3QJPhK78c+3zgLHTkKCw7QD0SvkvQaFjptzeAot2HNlMBBFf1cTzf5Ojh+NJK4iSoQ4QhNRrTg/wWyRjWBPhxgwtSybkOfzS7yFgndwTbhQBnlPXyYU55QSUNhkDSLF1gDXJoxWl5qvvZTk4x4Gycr+XyEvVWvRebArv8otSNDckVpocWu/c+zxIUo3oLHjVZN18PLsGkhhbNMfDfb2yD1wg4AhLOBA3Fv7aEYcLK3MNOtBXDtnrqZ64eWP1bgr92A/DJwZKIF32J+E0CFOmL5HZSAXIOkLzk3EyedctHaxs6Hjz+eZrYf9X3Wf44D5RfVpsY+TcA8c1/TT2Z+sN7wiJejdFQefF4Mv19ScGpWhwkQJ6956foFRJkNjEFCujs5SZ4idVOnmF4/EqmUh4eL4HKOEQ+XwvaOn6DSBPbVoIFPFNRfLV/UqjL+aEPzrUfa8TFuK6PuU1UpdRnoO19FwGDi5QIev62O67NcGnOIfhLc03eSfYI6aDdjt5ED8V+FNmknZFroUyO1GFZkNtfgOksMJrSMaX5758RZEi8eqLol7QjEpnHV0TnKFXoDF1hXTvqzsM8paPmbnnjcq1LcKqND49hmvW7iuydoghvEHaIObOER8yuQxLDlJKOzoLtD//zcNLyAMWL5w/7sVr2jr0XWTq1R6N7MEp1II2Lhqr6q/pRS4MqRwlIbEYhUBIzVVqea2mMLI4Q8gtKIG0nQqGNOpOSJnOHayTqJ4I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UG6rnFNka154h4mRagsac/onWeTxx2L3iGPWfuuKbWeHf6BGdfcQdsMgjPRc?=
 =?us-ascii?Q?eZfl4EbbEAhsozA3GiTAV3/LjgKUATvGWC/RBynlxMimYKSGoNVGswY9hhTp?=
 =?us-ascii?Q?+Y1VL3ttoWnIabkAUCpaiQS4hp4BMf/Jw8tNKG/H5qtEPuBbYauvprylr6Ie?=
 =?us-ascii?Q?1UZz4+pSrebaQV8dNy310p0PQhVzfLg/R5UjxetIqg057+4Gtcg32sPRsFFq?=
 =?us-ascii?Q?jvphqCAmCxOWspr0zb4uexii823qBeW3IceosIXI3ttw/qgsFHa8whQa18rt?=
 =?us-ascii?Q?Tn+YDbB+KE3U3maKbwwJiv5ncBtvb/4kvfcRwIA2Kv3FnCpQBQcC5SU8N9CS?=
 =?us-ascii?Q?RA/M1DLzZoieCwRYW2covGQ9fF0cdqvcK+WQmd+hNMR+2mObY3EAO3ryHkir?=
 =?us-ascii?Q?aywnofpJkPYEaYkeHkXYX7mYxoc1FxYPM2x4vqF1+0oSTFUXLU2i+y8TQNuJ?=
 =?us-ascii?Q?5Vw/zUDI7hCD3xTRT1MAUrXeVNup8ekY0tXmy3zDBd2AgfsPT3QRvFZjcgjK?=
 =?us-ascii?Q?bKPCEqF8iSYk5EFM6QxqzCe5zTcUIQcYA0qIzeMqbsVB01z77mR3tw5Pvl6j?=
 =?us-ascii?Q?K/WiBUfMl+MTIZPa89MbJXHy8hISCYmYtvcISPrzkhVM1fRlaAhFo/SbKBRa?=
 =?us-ascii?Q?AAt1gPK+Gq+Pmyy4nDDCecpxgTcr3oKCXl+5oqmn0hYzsvzpE8vNFCk6sOvo?=
 =?us-ascii?Q?iAjL1CuA83E9/AgUskpLrUoDOwqBdn36TyajRwMdaIGz1XRJgP0s/HQHl6Xe?=
 =?us-ascii?Q?4VgbzY7xkPVsMNQoEmowjeN56nAG1pn3YnVFean/2CAndb+e0EqzLkiR3dHQ?=
 =?us-ascii?Q?Wmsrr5jPze1OYKRwy94ySP2P+WV2OG8IYn1X32Dschu0bzOZHmxlY5JzIZsA?=
 =?us-ascii?Q?uW7OKFQNhbW5pO9UmJvBhmlwWCwqC8b0ySuDmMMi3VkaFTKu1NxKICM+7mbV?=
 =?us-ascii?Q?Jf2ty+VZXhrp+k/QSNbLuFYsehRTGL31NMlKLS77N4/hat0XA+coJuiaBjn1?=
 =?us-ascii?Q?XHU7RqAELWMILsqy0DZurSsAfZXKZHClK4rOfufiDvlHJFCKWCCwYnIDYmb4?=
 =?us-ascii?Q?4fWSCEvUM/dizzDjorUC0gLoPm5xq08vZGhSuVi6oQB+YghAGLolPqgjUqgH?=
 =?us-ascii?Q?whSvAGpz2XONfHQDHT9W6BaiGSgeI7KVIi2mRrJdGxbjgqvS6ZXyQvCwMc11?=
 =?us-ascii?Q?K5g5nJfzblbRh221uRT8PpCwmaKO4XV7rxm+la0qL3uuklFJj6G/yuK07OT/?=
 =?us-ascii?Q?CTNtpDhgnRK4H6UemVEyucz9eT8phPLrO3FUzlFX4GwFBx37/6YMMXdOSSmN?=
 =?us-ascii?Q?vR2BZSJ0hi0GIiSL90ZY6UCtEKjOxYAkQo2eyKuyUQeVDv7Am1m1MYleVOFb?=
 =?us-ascii?Q?RnlMUCUot/X/BDqRzyWD8sMo0UjSVDYf9FkPxb96ng87NuSh9DAMJKFlH8R6?=
 =?us-ascii?Q?WC5V/KI3uSsWYCYzXQ5IEwKjEpbhM0HpD4IwK+mkEDNc1eUdCxM4xCnLBMFk?=
 =?us-ascii?Q?vmweR7LjOMm/D7oRlGw+wCGDUuoeCfaoCW7yC3M3FNCMW4jRYm/f6OlqfFlP?=
 =?us-ascii?Q?5MaO+XeTqj362kj9KTG+4xNzlmCeaE1bmU5UcIYZCEhMr03Z9ihpCfxxxA9y?=
 =?us-ascii?Q?AaPSqBfqYsQYke8OUTAapXiQgc6+8Q7Ui2pYMfpMBrNKY6hon38JoHj9yhRY?=
 =?us-ascii?Q?iuWxGcOHWUB8XxVQOVZJuFmYq9iHLk4ntnqd7fze3vSA8M7xf4MYTImD1NFP?=
 =?us-ascii?Q?aTUXuI53kQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FDigUTxdo82owIn0Cd8Hb3s3KOkFHhEx++oG5i8bpKEpbHXLoNSU6NkY2hN46AIfHW+fBdTxdvndecuafmzMVSpbKWr9iJ6NBqWVAAhq+JqN5RmRRMLpuINg/xPATrKyXhzAXOsdLx9DUUZfkA6hzt/tgyb0J+FyO9SNbhcz37Fxw/ayvu/9xNxoee1bEa7ZLLLfSvcXqCmW0xgwiPQvpQDII3STKLfIoKknfZZEYS+0gh5wI4XYRzep3P1IX6HqzNbXxhJmh58nyrpbLSBDIs3NXxdJvpVOAKfqlRwxYOY/p78210OzFs/P2nORm0xIkw+GOWunWJ/Ntj76sni0lg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3584b130-0889-48a7-55ae-08df18a721b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 12:43:41.3561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eq92bA6KubynrA6rcKsgzqIGwoiq2TkW6EJGi4BMGX34HgUEYvJkLn2d3rR4b8JhMTlK9zinZdDjDLOB4z9qLrqETgmsnOoCy4bbhSowTMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7286
X-OriginatorOrg: intel.com

Sai,

A couple of things could be worth a second look here.

cmd_plen is still declared as u8:

   u8 cmd_plen =3D fw_ptr[0] + 1U;

The addition itself happens in a wider type due to integer promotion, but t=
he result is truncated back down the moment it's stored in cmd_plen.=20

So if fw_ptr[0] is 0xFF, cmd_plen still wraps to 0, the same as before this=
 patch. The commit message says this parses the length "in unsigned storage=
 so 0xFF does not wrap". It will wrap as soon as it is placed back into the=
 u8 cmd_plen variable.
[Sai] : Agreed .will change cmd_plen declaration to unsigned int in v2 patc=
h

It happens to get caught afterward by the cmd_plen < 3 check, since a wrapp=
ed value of 0 is less than 3. Is that the intended fix?
[Sai] : Yes. DDC format is Length (1 byte), DDC ID (2 bytes), and DDC value=
 . length and ddc id of 2 bytes are minimum expected bytes.
The commit message seems to mismatch what is diffed.

Also, the cmd_plen > U8_MAX check can never be true. Since cmd_plen is a u8=
, its value is bounded by U8_MAX by definition.
There's no input that will make this branch fire.
[Sai] : Agreed. This check will become valid once cmd_plen is declared as u=
nsigned int

Regards,
Jeremy Dean
~            =20
