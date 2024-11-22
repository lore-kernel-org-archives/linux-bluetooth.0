Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFC716F85E
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Nov 2024 09:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732267727; cv=fail; b=O9fMR1VO37tSR3C4Z7sX3iOhikfDSuErJhUJwF8eR1KK+zIo/CgAauAXhsSGByBdz4nE/0PS6vdPg+fD88cN7fKK+9yuaUeTnrihukKOkJn3wT8aSdeFWtXGwvJ6hMnIUK0ef3o0rT0n+wqkFbA+V5MEFZnVhvkczCoEqkAs+Qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732267727; c=relaxed/simple;
	bh=W+JWZwdga1mEvqxDTqardKh+I40n7FxeMcDPBcFUNTY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Om9RjfgJ5Qnvw5+ld42/HX1QZsFxH5Fi5dUa7lqAGfrowmh806V3FYoUk+8cTLuezalP17bRTKzpqrneN+QZH+c0o0srlqh1r3JM+I3loXmB1qOrDeUWhIdkaezRVHatny7qAzCfuzfKcWzE/z8Fwx1fe41Bb/+mIDADWeaN2dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LVYWnckw; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LVYWnckw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732267726; x=1763803726;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=W+JWZwdga1mEvqxDTqardKh+I40n7FxeMcDPBcFUNTY=;
  b=LVYWnckwocyO5CJNFLWv5F9V7iJna6zHM522kL3BvmfRq3aQtqtrjpuX
   rvAmJI/9M+CcVrsS64+9G1JhcMEKSKYukfzDtNWWuqik6tds3YTjJiUm8
   N9UeG1YkOLTqyWNljydQMFmyak2q/nGhetimxMmETw0wYyPaGMzKk6U9e
   Uvk5oZ/t/iy4nfSnm43kRAE51xOROHhowRgHvpmJvtlThF6kvc6b1ytGl
   jujeyNmWZ+RXuo2iay6iGi/JAWY406eE7XtiLBYJGvdSXD1Fj87svjZ5a
   o+H0d5CDh/SMstI1hqOtm67j+ro/TEYXEon6Ovk80MmrEjHWAf5sJSP8O
   g==;
X-CSE-ConnectionGUID: 6aQbfl9PTUCQpjwyCgTO/A==
X-CSE-MsgGUID: /SI96hmWRTGM9u9VajwfSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="43065424"
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="43065424"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 01:28:45 -0800
X-CSE-ConnectionGUID: MavUMl1RRIOWljg/0NTP/A==
X-CSE-MsgGUID: svw+hJxiS9KFRkrAN592SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="94968398"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2024 01:28:45 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 22 Nov 2024 01:28:44 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 22 Nov 2024 01:28:44 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 22 Nov 2024 01:28:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ycCQvJjkzRo6LZmzkupLnBvmJSNTlTojQx7oyAp1aD8G6lgvnwZXtU8T8cE7EjTGa0LZVtREhN3RRaKqS0beO8O7+YXn8Xp4mTNERYCwrOYGOQF9rI6/OYOskjBbVBB3iKJJzdkVbLevbuWsGgYzZNEOhUhaCAik2iadmiVGlsNwxcxUux97m5/8NABo3mpHOi2a+HtXHkQ7/cWmEIQgwenY8zj23CkrW3ypBZ61JJ28JgAtExOjvu16oL3SY1m4rozV2zNXqKQOnjraBkhmx6hiYan1f35Se14b9s4p1l4+xqF0neHxfvBQUO7alvOt9XjtX/ptfGLWUnacHO1AAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWqc8j0NDQH/ZelohP0thYazZyzq80zwQOYhM2ZkW+k=;
 b=o/gqBMBXjQ7WryblUL82DaOM4IFDAGvhGdZWliNfcNrj2Q8P19RZRJmxqN5WVb/JpkPNn5FXcALDjDvxlfiv+qGD6ThC3t+DgTsgPUBJBQG+e6KolLwtLofDp03se7l/jy7dLX7kqyRItk2NevCJkCax5fa9fi1jfjjPV5toOEooWV/uxr4gtMVn8NNo2Q3KzsBO88+nGfe21tf+ZgC02yUCz9oo1pBra3vvJNR3j88+ZD5ZZiFKz8XmW8eCj40RtElbrPv0SGSxxJ6bV4hEd6IWDr4Chr1aVJOjlxSWUi8Y8IKrI3XDSaWvzW/TGCyIYdqIzdzqzIFkTbRv5lkxsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Fri, 22 Nov
 2024 09:28:41 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%3]) with mapi id 15.20.8158.019; Fri, 22 Nov 2024
 09:28:40 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v1] Bluetooth: MGMT: Fix possible deadlocks
Thread-Topic: [PATCH v1] Bluetooth: MGMT: Fix possible deadlocks
Thread-Index: AQHbPDSmrvXJfPl0u0ahaFkNCUekSLLDCRJw
Date: Fri, 22 Nov 2024 09:28:40 +0000
Message-ID: <PH0PR11MB758531B1E5559E95158081E5F5232@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20241121164335.3848135-1-luiz.dentz@gmail.com>
In-Reply-To: <20241121164335.3848135-1-luiz.dentz@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|BN9PR11MB5276:EE_
x-ms-office365-filtering-correlation-id: 49e16f2f-bf9a-45d6-ac07-08dd0ad80d48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?dULogTTLCCCALoPv46KHH5N8ijJ7W37XvCimDsn5vI+Fc8Kv92mfRu5ZDuEZ?=
 =?us-ascii?Q?RBWVeGAkQ6gmnlupxFUEWrIAKh4X4scEoEwRLSKTcqEcJPo7r+W7QvF3Fxds?=
 =?us-ascii?Q?TkaFrT7p/i6LqhNqVmVMDjjHTKXeyMKxup0+6oRsUHMCaFrKsVej1CJQ3oIX?=
 =?us-ascii?Q?3VinBmTeiqD3dSgC8OY9kApFTp3X7GUUc/0yjXH6Z9xlJxBmAH4ulhG9y1z3?=
 =?us-ascii?Q?2jdfXL9ZYG18jrCFf9s6FXm3pl5xYXFAetqnxFSBpQjsY3QD9a4J+rW+uzJF?=
 =?us-ascii?Q?ZQHwkXf9N+YeMXXFyn5u8CNz73pTCxv6FcFF2AvjKarBkEjEzrkk5ZRN+5bd?=
 =?us-ascii?Q?9ZKWZb/r9BFLnIL9Ea4ZN0gvYT5CrH1bdhLT/HGxYUEWgnrqz727tqt7Nbd/?=
 =?us-ascii?Q?HeiHlBIcC8dk9JZ6ZyiJ5Zhe36z+LwIK6Ex93XUVhDeFKLv92gRIjMsI+ORc?=
 =?us-ascii?Q?ne1GnPu/f+C1+3/l9SfyhBuBRMaaQB/YEJXXas9IYci4hfJSU+qjYL5RfIE7?=
 =?us-ascii?Q?L/B28S3GkxVgxbMCMNPTEKphCZPCOpgjSFW1F3JRxPBDs4UQcx8w1/XJzAnD?=
 =?us-ascii?Q?sOjCwkKJ0PoEjeweCi0a1DKHpUK3IFLQbGIjdJfuXOe6oDMn9kcJkhWH0k8F?=
 =?us-ascii?Q?ExA30hB4wDhacKkdi+Cw+2rapy2ZsfRC9toZPgkj2gbEU3NXdqK81EbBspm7?=
 =?us-ascii?Q?nmDG0DzMBkUVW0+opEHJc2yqhXsKFX9J9pYoJ5Xavk+ISFq8af09aqnyVhg+?=
 =?us-ascii?Q?cduLfnfOWw6OvrbDHucPLSlVQIVOT/dDvCs/xGoR1vVyT1D+f7AO89kBDmn9?=
 =?us-ascii?Q?Wtg3Dq334bGCSsBJlDsbTEr1oQsnBZahJXgClU1lw3XJmg9qTx7lusYQlN+r?=
 =?us-ascii?Q?xI6Ku8nRXu6DkBgmqRTzg2vbCZWJAGsOqA87QycRnMsX7VUyX/3XIPP5p04U?=
 =?us-ascii?Q?az90xxJZIkkH+GvLLzKr36IGDCxAHMcsjbdP2D3y0XQWvBv0yBqHiJWVpWGa?=
 =?us-ascii?Q?oshmeX+aPzTqFsoV1Ecnu5SAe0pS/DeuWTWb5ZaRPghjMfmSmN5Q6O1LQ2VJ?=
 =?us-ascii?Q?dwMJHAUwY+lqtuOsWISs4DT/8uCTQSMmKugXBMPuhR7LxUv/sJhSlAbO1aTK?=
 =?us-ascii?Q?LZBp4OMVvDG6uGCQ6i3P3XxNYOoYibMKNMWIbeBmsbNkkNrQ72yFsXJ9AQ2O?=
 =?us-ascii?Q?BbibJqe5uRR2b6wNjTJEJBhXmJtzwYv8KXiFe8Lk/tnWfTlfGtEsuRy1Mjhw?=
 =?us-ascii?Q?ACtYSZJIIbwW2+JLLV3XYolHlMiGRN+7Nv2AEj+IGgJRm3ytDh15ecbLnu9/?=
 =?us-ascii?Q?we5qpY9YqSPJGk+pUAhO7kq+cOW0tszzHH0OJA0GMsQHqTRCPVjVyASb3J20?=
 =?us-ascii?Q?MTMjoYo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?viGNzxaUMwtSC5fyodyvLeJ5bwYG6Tqc72ToNMPlrkTTx82/Mihe04t9ft6L?=
 =?us-ascii?Q?+hCZKHlZ963v1hVNGdAaPUOcG0gxPw9cGhn6irMtN8nMKisVyftdCytICSDA?=
 =?us-ascii?Q?k634fM31Sh36JxF1ZszeXeNCFMM/QGQMfOOLrdZAvKuz5zvY4Iv1+JEiFQ15?=
 =?us-ascii?Q?0ZAD9qLKWcdhDkUaXkxx/+2IDuwnNT6if5SucGVCNUkvzsfUAWT/A4U2XcDL?=
 =?us-ascii?Q?9WwbHVYmeAKtbcneku9X7Eo0ANcSu8t461Pjzr2kANS34VcJxIJr0UClEyVN?=
 =?us-ascii?Q?GVfJvB7l8bEOEdR0B5Ldl0gg6d+Rnom4Imlh9agukZCoXiioozHMNgbZKL2w?=
 =?us-ascii?Q?nTrWXI4xk60hJUovaNPBKjgnImSl+U6T3MRuIOOn1QWXCoAAaF+ZtJJ5gZ1T?=
 =?us-ascii?Q?07JGe35exsJOpsi2aEL4ghe2v9JUxdy2Y/RiedYmfcuc/f0CIhfkV7c6ls/a?=
 =?us-ascii?Q?02oA8MOXXO5Dw6wduCR3mt8K3aCwLIE8FivV9u5/81ZISQWYxm5MG0EHq57n?=
 =?us-ascii?Q?VX2TxVFwEdJ3RWX7wJZb5n0ZwYF17bHJy48CurW/HuR62wXMkqC43wd7eoyE?=
 =?us-ascii?Q?yTgOK/mmtN4NsYzweICQ8ArU+11LT6PbcoY00Qgbk+Maw2xdGxh+ut4uODmF?=
 =?us-ascii?Q?4cRK00jhgKW3/uDYKxhtZ0ztcD1vy6tu+uP2fXSta39Q/2xh6gGYUdsFDA+V?=
 =?us-ascii?Q?pa3GszhxmjKMsw/tR4JbcBblS70qncibDJg11XE3HvSYb9zeQbb7qM8uF4Ex?=
 =?us-ascii?Q?KFC+oiXYJ5YQKokQGME7ii0LsdH1/F427CQKQL+9qVuAyr87zgnX+9f6xDdW?=
 =?us-ascii?Q?h4t3G/+aoKB46TJagR/xcjbDa21Vrr5AhZ2mbzxhSDz1EGqpjQzMN03va3B4?=
 =?us-ascii?Q?45xlyNqNuabHdzzgcZIVX7JdnjcezpZBnM3CNMRNClAHlI9OV9x/GM1P7c8x?=
 =?us-ascii?Q?Xp8t526hxxzBU+E5MmuHiegggPeiitcqkX+ofCwL2jvSyzs00NL1fDQSgSjs?=
 =?us-ascii?Q?rMDIzgsSNwGIsmQLAZ3tXv4OeVkzJPs1qvc0G6DAtOhIczcCPmj+nlmjJjos?=
 =?us-ascii?Q?+dI4rr3eIiMMsobRruovb9z22cqkmCcpQ5ezeOczEjPfW5TCu7dY4kawjpPR?=
 =?us-ascii?Q?DzHgOevQySdud0QOp2dGBepKV715RrBcBtTAF4h7BszVPwkW65835QVSW1rj?=
 =?us-ascii?Q?K5BWtVyOktm7udGd96SqZCTwzoAF4yXfS3sZDTD0i8TYA/K5UcSBFGVaJqJ+?=
 =?us-ascii?Q?/4ss1DmML3nbim9Zr/7geckE8MQsX028tIF2EZBkScpKcvjnAgPulD/+VCvn?=
 =?us-ascii?Q?CI5trPxU8l05buIYYfOoBDXaqzSJZEw5SbwBONvlOd/qM5vFHRDBlhjTuYkJ?=
 =?us-ascii?Q?rpORPtOdiP69N9WYHKxNiDeMtoaAcND87WAqYPxBIQtJOtMJysf296SpCIF3?=
 =?us-ascii?Q?yapBkH9giPozzxoxUuSu4XlPfh+9HUi1rPAMRvR7z5fWfWVXPJ98s2A6KmTt?=
 =?us-ascii?Q?Y5KmQlaQql9dgZSyOVtlXYEy0SRp2Rhtm6LBGZQKWuN/GFzoDT6KJG1l3yN4?=
 =?us-ascii?Q?nUvCuxrTUNGvC474VBk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e16f2f-bf9a-45d6-ac07-08dd0ad80d48
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2024 09:28:40.8225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BuPH2Zj61npqV3e9qQp0AtdUOy8u4n5wlfxazYU3gNLmpUPMTEWI18OlAfHiMQMg7AngQKHF8hTqxDYZ6BILAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5276
X-OriginatorOrg: intel.com

Hi Luiz,

>-----Original Message-----
>From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
>Sent: Thursday, November 21, 2024 10:14 PM
>To: linux-bluetooth@vger.kernel.org
>Subject: [PATCH v1] Bluetooth: MGMT: Fix possible deadlocks
>
>From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
>This fixes possible deadlocks like the following caused by
>hci_cmd_sync_dequeue causing the destroy function to run:
>
> INFO: task kworker/u19:0:143 blocked for more than 120 seconds.
>       Tainted: G        W  O        6.8.0-2024-03-19-intel-next-iLS-24ww1=
4 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/u19:0   state:D stack:0     pid:143   tgid:143   ppid:2
>flags:0x00004000
> Workqueue: hci0 hci_cmd_sync_work [bluetooth]  Call Trace:
>  <TASK>
>  __schedule+0x374/0xaf0
>  schedule+0x3c/0xf0
>  schedule_preempt_disabled+0x1c/0x30
>  __mutex_lock.constprop.0+0x3ef/0x7a0
>  __mutex_lock_slowpath+0x13/0x20
>  mutex_lock+0x3c/0x50
>  mgmt_set_connectable_complete+0xa4/0x150 [bluetooth]
>  ? kfree+0x211/0x2a0
>  hci_cmd_sync_dequeue+0xae/0x130 [bluetooth]
>  ? __pfx_cmd_complete_rsp+0x10/0x10 [bluetooth]
>  cmd_complete_rsp+0x26/0x80 [bluetooth]
>  mgmt_pending_foreach+0x4d/0x70 [bluetooth]
>  __mgmt_power_off+0x8d/0x180 [bluetooth]
>  ? _raw_spin_unlock_irq+0x23/0x40
>  hci_dev_close_sync+0x445/0x5b0 [bluetooth]
>  hci_set_powered_sync+0x149/0x250 [bluetooth]
>  set_powered_sync+0x24/0x60 [bluetooth]
>  hci_cmd_sync_work+0x90/0x150 [bluetooth]
>  process_one_work+0x13e/0x300
>  worker_thread+0x2f7/0x420
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0x107/0x140
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x3d/0x60
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1b/0x30
>  </TASK>
>
>Fixes: f53e1c9c726d ("Bluetooth: MGMT: Fix possible crash on
>mgmt_index_removed")
>Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Tested-by: Kiran K <kiran.k@intel.com>

>---
> net/bluetooth/mgmt.c | 27 ++++++++++++++++++---------
> 1 file changed, 18 insertions(+), 9 deletions(-)
>
>diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c index
>e406eb8e4327..b31192d473d0 100644
>--- a/net/bluetooth/mgmt.c
>+++ b/net/bluetooth/mgmt.c
>@@ -1518,7 +1518,8 @@ static void mgmt_set_discoverable_complete(struct
>hci_dev *hdev, void *data,
> 	bt_dev_dbg(hdev, "err %d", err);
>
> 	/* Make sure cmd still outstanding. */
>-	if (cmd !=3D pending_find(MGMT_OP_SET_DISCOVERABLE, hdev))
>+	if (err =3D=3D -ECANCELED ||
>+	    cmd !=3D pending_find(MGMT_OP_SET_DISCOVERABLE, hdev))
> 		return;
>
> 	hci_dev_lock(hdev);
>@@ -1692,7 +1693,8 @@ static void mgmt_set_connectable_complete(struct
>hci_dev *hdev, void *data,
> 	bt_dev_dbg(hdev, "err %d", err);
>
> 	/* Make sure cmd still outstanding. */
>-	if (cmd !=3D pending_find(MGMT_OP_SET_CONNECTABLE, hdev))
>+	if (err =3D=3D -ECANCELED ||
>+	    cmd !=3D pending_find(MGMT_OP_SET_CONNECTABLE, hdev))
> 		return;
>
> 	hci_dev_lock(hdev);
>@@ -1924,7 +1926,7 @@ static void set_ssp_complete(struct hci_dev *hdev,
>void *data, int err)
> 	bool changed;
>
> 	/* Make sure cmd still outstanding. */
>-	if (cmd !=3D pending_find(MGMT_OP_SET_SSP, hdev))
>+	if (err =3D=3D -ECANCELED || cmd !=3D pending_find(MGMT_OP_SET_SSP,
>hdev))
> 		return;
>
> 	if (err) {
>@@ -3848,7 +3850,8 @@ static void set_name_complete(struct hci_dev
>*hdev, void *data, int err)
>
> 	bt_dev_dbg(hdev, "err %d", err);
>
>-	if (cmd !=3D pending_find(MGMT_OP_SET_LOCAL_NAME, hdev))
>+	if (err =3D=3D -ECANCELED ||
>+	    cmd !=3D pending_find(MGMT_OP_SET_LOCAL_NAME, hdev))
> 		return;
>
> 	if (status) {
>@@ -4023,7 +4026,8 @@ static void set_default_phy_complete(struct hci_dev
>*hdev, void *data, int err)
> 	struct sk_buff *skb =3D cmd->skb;
> 	u8 status =3D mgmt_status(err);
>
>-	if (cmd !=3D pending_find(MGMT_OP_SET_PHY_CONFIGURATION, hdev))
>+	if (err =3D=3D -ECANCELED ||
>+	    cmd !=3D pending_find(MGMT_OP_SET_PHY_CONFIGURATION, hdev))
> 		return;
>
> 	if (!status) {
>@@ -5914,13 +5918,16 @@ static void start_discovery_complete(struct
>hci_dev *hdev, void *data, int err)  {
> 	struct mgmt_pending_cmd *cmd =3D data;
>
>+	bt_dev_dbg(hdev, "err %d", err);
>+
>+	if (err =3D=3D -ECANCELED)
>+		return;
>+
> 	if (cmd !=3D pending_find(MGMT_OP_START_DISCOVERY, hdev) &&
> 	    cmd !=3D pending_find(MGMT_OP_START_LIMITED_DISCOVERY, hdev)
>&&
> 	    cmd !=3D pending_find(MGMT_OP_START_SERVICE_DISCOVERY,
>hdev))
> 		return;
>
>-	bt_dev_dbg(hdev, "err %d", err);
>-
> 	mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode,
>mgmt_status(err),
> 			  cmd->param, 1);
> 	mgmt_pending_remove(cmd);
>@@ -6153,7 +6160,8 @@ static void stop_discovery_complete(struct hci_dev
>*hdev, void *data, int err)  {
> 	struct mgmt_pending_cmd *cmd =3D data;
>
>-	if (cmd !=3D pending_find(MGMT_OP_STOP_DISCOVERY, hdev))
>+	if (err =3D=3D -ECANCELED ||
>+	    cmd !=3D pending_find(MGMT_OP_STOP_DISCOVERY, hdev))
> 		return;
>
> 	bt_dev_dbg(hdev, "err %d", err);
>@@ -8144,7 +8152,8 @@ static void
>read_local_oob_ext_data_complete(struct hci_dev *hdev, void *data,
> 	u8 status =3D mgmt_status(err);
> 	u16 eir_len;
>
>-	if (cmd !=3D pending_find(MGMT_OP_READ_LOCAL_OOB_EXT_DATA,
>hdev))
>+	if (err =3D=3D -ECANCELED ||
>+	    cmd !=3D pending_find(MGMT_OP_READ_LOCAL_OOB_EXT_DATA,
>hdev))
> 		return;
>
> 	if (!status) {
>--
>2.47.0
>

Thanks,
Kiran


