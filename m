Received: from alln-iport-2.cisco.com (alln-iport-2.cisco.com [173.37.142.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4133A2D6E67
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 07:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.142.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757921039; cv=fail; b=dL/3DQiWz6vCeU1A6HRlz8T84jcypdExl8X3D3T+jWYyNJSNBAu95kFJkjbmPjkw3MxNidDhOAvpaM0T/BVxuXzHedyahgT6zefkoTAUMCH5mrr4qgYBBhFajaNurqlc6qnHEFBvxYcYMnYScAXacao1NwkjILpOApL0pCf61wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757921039; c=relaxed/simple;
	bh=MBNJoVf2PXFgHE0HmmrwdFlbHHfsiZv8THr+Qg4qy98=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Se/kjp/A/5SIxeFBWRf1/1iRjzu27xo+Isn7RJNSgqHXKfsLc6/DHpw07DIY1F7c9B19p5TV/jHJ0MnCCisiyYDlSMCyfuSruCTUsfWkpH6TLYGpYa88RNM4yOpnb2tgYk8huLiPCgJCf259ThbY1gNlv8MBNXmhxgcaGIXPjJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=LSGlRTrZ; arc=fail smtp.client-ip=173.37.142.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="LSGlRTrZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=512; q=dns/txt;
  s=iport01; t=1757921037; x=1759130637;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MBNJoVf2PXFgHE0HmmrwdFlbHHfsiZv8THr+Qg4qy98=;
  b=LSGlRTrZWuY62WL7Em3vTxeUPZbZfoaeyvDgaw6nGDqNzwYjX2KZSEO7
   ViAn9/pWjusSDbXadjHv7uU/3aT/iLs5ra2NwE+m8IZlwCMQGnxYmCD26
   215l7qZ3k2MAAughOr29TBSNiLnBENy52d4/k7wigY5eoTFYtsT8RfEEO
   1EjIlClNXAI98knewEIQoGXP+CRnzeXh4fcpiPY3buDPaxLkhlUIoZFo8
   uN/Use2Vq+0QwIXx31Fwn22ADkBbO9B6eAh8se7oN6HCZt0XKza1v//OK
   OUr++EpmcQN7JsjKmvGUpTU16AKkHRdQ02NlM3Gmku1UBhBI9rWh5V64z
   g==;
X-CSE-ConnectionGUID: dzRi7/vSTuyRHtpr15RJmA==
X-CSE-MsgGUID: avTHaMzfQFO7/LQ9SNEPIw==
X-IPAS-Result: =?us-ascii?q?A0AeAABHvsdo/48QJK1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQCWBHQIBAQEBCwGBbVIHeYEMEkmIIAOFLIh5i2SUNQ8BAQENA?=
 =?us-ascii?q?lEEAQGFBwKMLwImNwYOAQIEAQEBAQMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBB?=
 =?us-ascii?q?wWBDhOGXIZaAQEBAQMSKD8QAgEIEQQBAR8QIBEdCAIEDgUIGoUbAzUDAaRbA?=
 =?us-ascii?q?YFAAooreIE0gQHdPg2CW4FJAYEVhxweAYVshHcnG4FJRIFXgmg+gh+CJAKEE?=
 =?us-ascii?q?4INIgSCDRWBFoNYNoIohUqEMItWUngcA1ksAVUTFwsHBYEgQwOBDyNLBS0dg?=
 =?us-ascii?q?ScWYoQUhB0rT4IccoF0V0GDUxIMBmsPBoEVGUkCAgIFAkM+gWsGHAYfEgIDA?=
 =?us-ascii?q?QICOlcQgXwCAgR/QAMLbT03FBsFBIE1BZUIhBMYVqVooj5xCoQcm1uGMheDc?=
 =?us-ascii?q?aZ6mQaSEZcFAgQCBAUCEAEBBoF+JoFZcBWDIlIZD8tbeDwCBwsBAQMJk2cBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23:kSbvnBNNx3WmN9oFjhcl6nc2WUAX0o4cdiYc7p4hzrVWfbvmpdLpP
 VfU4rNmi1qaFYnY6vcRk+PNqOigQm0P55+drWoPOIJBTR4LiMga3kQgDceJBFe9LavCZC0hF
 8MEX1hgl0w=
IronPort-Data: A9a23:h8+clKvFWONg6tDmH4CSjmeqF+fnVAFfMUV32f8akzHdYApBsoF/q
 tZmKTrVP6uPYzOkKY8gPNzj8kgO7JOExt9lQAJtrSA8FysUgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0nrav676yAlj8lkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuGaDdJ5xYuajhJs/Pa9Es01BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 47r0LGj82rFyAwmA9Wjn6yTWhVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0NS+7vw60c+VZk
 72hg3AfpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn3bEm51T4E8K0YIw9vRNAD4J6
 8ckNSE3Tgybnbvr+pC+Y7w57igjBJGD0II3s3Vky3TdSP0hW52GG/uM7t5D1zB2jcdLdRrcT
 5NGMnw0MlKZPVsWZgx/5JEWxI9EglHnbDRRp1W9rqss6G+Vxwt0uFToGIeJKoTUHZ4EwC50o
 ErP4VjZCzQIOuWx7mXC1kv9vcnipQLkDdd6+LqQs6QCbEeo7mgSDgAGEFG/vPSljUmiW/pBJ
 EEOvCkjt64/8AqsVNaVYvGjiHeAuhhZX59bFPc3rVnTjKHV+A2eQGMDS1atdeAbiSP/fhRzv
 nehlNLyDjspu7qQIU9xPJ/Oxd9uEUD59VM/WBI=
IronPort-HdrOrdr: A9a23:w9glbaMZG5pGqsBcT4f255DYdb4zR+YMi2TDiHoBKiC9I/b5qy
 nxppUmPEfP+UgssREb9expOMG7MBXhHO1OkPgs1NCZLUfbUQqTXc5fBOTZskfd8kHFh4pgPO
 JbAtdD4b7LfBlHZKTBkXSF+r8bqbHtntHL9ILjJjVWPH1Xgspbnn5E43OgYzZLrX59dOIE/f
 Snl616jgvlU046Ku68AX4IVfXCodrkqLLKCCRtOzcXrCO1oXeN8rDVLzi0ty1yb9pI+9gf2F
 mAtza8yrSosvm9xBOZ/XTU9Y5qlNzozcYGLNCQi+AOQw+cyTqAVcBEYfmvrTo1qOag5BIBi9
 /XuSotOMx19jf4Yny1mx3wwAPtuQxeqUMKiGXoxEcLk/aJAw7SOPAxw76xtSGpsnbIiesMlJ
 6jGVjp76a/QymwxxgVrOK4Jy2C3nDE0kbK19Rjz0C2leAlGeJsRUt1xjIOLH8NcRiKmrwPAa
 1gCtrR6+1Rdk7fZ3fFvnN3yNjpRXgrGAyaK3Jy8PB9/gIm1EyR9XFoj/A3jzMF7tYwWpNE7+
 PLPuBhk6xPVNYfaeZ4CP0aScW6B2TRSVaUWVjibWjPBeUCITbAupT36LI66KWjf4EJ1oI7nN
 DEXElDvWA/dkryAYmF3YFN8BrKXGKhNA6dh/129tx8oPnxVbDrOSqMRBQnlNahuewWBonBV/
 O6KPttcrbexKvVaPB0NiHFKu5vwCMlIbgoU/4AKiaznv4=
X-Talos-CUID: 9a23:DMYUXmM96dtNWO5DVDtd9RFTBPsZb2zn7GvIORblM0RsYejA
X-Talos-MUID: =?us-ascii?q?9a23=3AAwHZRQ4IaCCXoJK1coo4+L0Hxoxh/ZiOAWUfn6w?=
 =?us-ascii?q?onJbDERUhABGwtBWoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-06.cisco.com ([173.36.16.143])
  by alln-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 15 Sep 2025 07:23:49 +0000
Received: from alln-opgw-2.cisco.com (alln-opgw-2.cisco.com [173.37.147.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-06.cisco.com (Postfix) with ESMTPS id 7A9F718000136
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 07:23:49 +0000 (GMT)
X-CSE-ConnectionGUID: jS6zKsriSxu5SFhHuNhIEw==
X-CSE-MsgGUID: 46XXxi9uRE2i3BzekifQcw==
Authentication-Results: alln-opgw-2.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.18,265,1751241600"; 
   d="scan'208";a="29758880"
Received: from mail-mw2nam04lp2175.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.175])
  by alln-opgw-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 15 Sep 2025 07:23:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IW32eFyHfToT6y0z0+PJWvWhHnrrH1Z6CdDqUo3A6ntk6xwd7GlbO+9PaLtcJK4cPZJaJ8mMB5H0ERPPXh+xkCJB7LgYjrb4QhqSrHrnJIuli4nrbHk/ALUwwtWbCn3iKdD/JWA1Oy78J23BHpMcKfH/vmI8OP2GnKZlhPSaE+nXf3xOGUzmuYubenXotgMrlupKfuNaReoWjW7nnkmho1XyvbjsEdJiU6DFJ3wYqQCbRi7utCFyjKiRFkONjUc6PTomP8FLPE1WRPS/jqPXzn71WPm+bp5dqxc/PvxRWQbWhqutxo/ZgO+VdDSC0zxByR+onW53X+C0MSRY2LfntA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBNJoVf2PXFgHE0HmmrwdFlbHHfsiZv8THr+Qg4qy98=;
 b=hymmpUrP+EdBUNP0VHV6INEkSbA259gHEGjQr8VoS7y8I69gB0EdfwxyVITTa9xsDzc/HgXXs8gC5OY/AytdDs/rQ0rpjpE1braYmy7SSIgiF+pIZNcYVCzEMzqnK0ZuXX7ipSLFrABaLABQfmettL2cXOfA1zjcawr4ZR3FSWCDRy/DAckhYqscHMk+InnVKV9MieFTDrheuB7usxcWrqQIC+ZjPASrMlc75bkrefs2k6ck1DLg1Qbf4NLJdXSHgVTrEbEPHqwd+jB5VUTKWjnPT2NGWbtYUFneTSQsP3B5iOB3cd9pKu9MkQzt6a/gcB073T2a+Dg/5Kf1G8H8+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from PH0PR11MB5596.namprd11.prod.outlook.com (2603:10b6:510:eb::23)
 by PH7PR11MB7449.namprd11.prod.outlook.com (2603:10b6:510:27a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 15 Sep
 2025 07:23:46 +0000
Received: from PH0PR11MB5596.namprd11.prod.outlook.com
 ([fe80::5576:1e5d:a1fc:fd50]) by PH0PR11MB5596.namprd11.prod.outlook.com
 ([fe80::5576:1e5d:a1fc:fd50%5]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 07:23:46 +0000
From: "Per Waago (pwaago)" <pwaago@cisco.com>
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ v2 2/2] doc: Document error codes for A2DP
 MediaEndpoints
Thread-Topic: [PATCH BlueZ v2 2/2] doc: Document error codes for A2DP
 MediaEndpoints
Thread-Index: AQHcIy+PPA8bHRFopEmM6kLy660Ig7STPtuAgACd0io=
Date: Mon, 15 Sep 2025 07:23:46 +0000
Message-ID:
 <PH0PR11MB55966A48755927CE8C67B152CF15A@PH0PR11MB5596.namprd11.prod.outlook.com>
References: <20250911151930.1632922-2-pwaago@cisco.com>
 <20250914215751.73206-1-arkadiusz.bokowy@gmail.com>
In-Reply-To: <20250914215751.73206-1-arkadiusz.bokowy@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5596:EE_|PH7PR11MB7449:EE_
x-ms-office365-filtering-correlation-id: 55e9dceb-fa55-4a86-3e5b-08ddf428cf0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dNZNbVbME//cQJrYwuzFEKVov1Q61ReZliaKdEmBQI9bHCP8tMVUZy70RkH5?=
 =?us-ascii?Q?0DZiBgjgEZRCp3uBFzkQRRHH39LQEAo5Jx8VGENm8qW/9TFQqyN30uMN04VB?=
 =?us-ascii?Q?MsblmTuIBs8sMyXGk8YecpgPFqmubU8vlUfNCyMmhfVCVGd6mF6jSbdK25dN?=
 =?us-ascii?Q?iQzJZ8vYdP3aOfRjhVKujZTRkqMKDGunF8RUgSB6z7SyFIvM0pnnzCJtTjJA?=
 =?us-ascii?Q?BQi5UkjoHhqY6qkK4E1aWiOEHOSdWQ3Ze6+wf1UiyOSIO3zL4hCh3r3bXY65?=
 =?us-ascii?Q?TXKpfhEzcNq02R8khm0BOY5cZjd46zhGjYXcMrCQyLKRRzSGBMj8sZk/2a9k?=
 =?us-ascii?Q?8vmfUoN7jQKv2AmV+7DfVN0wum6ODs9rGaV7kAgTGj4xlXJYCadKGOWy9cqq?=
 =?us-ascii?Q?NpB4aXy1Be5JT0NhYgwnswSO4BJEmKlonXC24UUoWj51dIlTdBcA7ieGbFPv?=
 =?us-ascii?Q?QbYXpiAXbpgcKYTa2p4AQ45fo5ea4Z4aRvU67/0TrjJ/iPFBcEoKV1qS4BPQ?=
 =?us-ascii?Q?pTyRrh8WZoBdr/K1QjdFdZNUbtk7XANCWaZNlbc4tUb0NqciEXDhjsHUDLvO?=
 =?us-ascii?Q?c7cJ6QUw/pblvHnTCne3Y+U6CdkUwSPuxgNSQWAq3JiJOVcM9Q0vSDAlRWFP?=
 =?us-ascii?Q?ZF8awH35MdMgEhW61hBjDG36l0TuNKEiHLmy2JRm/5Q+Gp/AZkDNL1RcIZak?=
 =?us-ascii?Q?oPhL5nKwUr0I7xB8eLfmHc0FvNvZ0rXVirmAGXIOD88AYiq992+2pL4VKrg/?=
 =?us-ascii?Q?EgIcoWOc0CxuUlC8ocsErt97tDALZFt/nzOH1r2IKP+44uyLeINsc98KbeBD?=
 =?us-ascii?Q?HtaTRfzHoYak9TGA6/NqT90A1crF2Y3gJr46EuRtCFxOhnPKN+pqxZ5P+nwA?=
 =?us-ascii?Q?YciOv2KK4n9c285Ffghw9eRvfaKksd2+Sat+r03MccvXAIXXanKXgdjM45Fn?=
 =?us-ascii?Q?TfRW0cEWKO4aJCXZBnB6e7pYxL2gkxZ4CHil8uY9rEMJqv9QT6pTlhDwgf0s?=
 =?us-ascii?Q?4ElCkPg6Y9iYTcQl9OmyzDrj0HiGLAmoIckjRsR+zfb8g0C1J/ySgG9N/RJS?=
 =?us-ascii?Q?uThr+7G8OlutAtmXMybWk8fz/tD/EzZjJG8TQRe16sAzCPilIhzdmGdEhUdV?=
 =?us-ascii?Q?lL/XuyOUBHEv5NfkmNCTNTZ/VynhQgFfKk9nL4EHbtOkf6ZELD1jRe8akp4J?=
 =?us-ascii?Q?Yr/MwHh18fyrTfAuZv1dbmInDW0I4nx02ruNesprppFYatSg07wcWxpTcUu8?=
 =?us-ascii?Q?rlGjlEZgvASKWSS+MKW8XXpEsJHs0o573pvJ/LHA+qL7RYYcurnfWQMBHq7B?=
 =?us-ascii?Q?PmqZ1bn7VBp/vEE+KxOofg3ok3p+xQQi9VnQk4m5gvjhEzIdqsxeiAyixJmo?=
 =?us-ascii?Q?lAiDgNMs41OWWeuw3RxFivSYaHWwfmAifA91n3H4rwggGG0GN+QFF8Sr3JD+?=
 =?us-ascii?Q?2+lG2UpQABoe23B0OHMeVECht059ZNmYsSoMgAJ4QQY7qCqlTauHSg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5596.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OHkh8Lw8jaVxmsvOP4usaI+xUWOSlBVwU5Aiv5JUfz4bNtNs6TkjtIrKLsnu?=
 =?us-ascii?Q?O3HXIi2xbbSnw0UwGOgqg/kq/DlFVmIqgXTdtRamuUz26aGSsvnJc1M61WBi?=
 =?us-ascii?Q?mxbYRGU7ZqemN4Duokito0XWbol3SaGRPjt7Em8CfxkgnMaV30OmbQKYzh4a?=
 =?us-ascii?Q?+23aftUX/pGpmtjrPSOWngU/MlFDfybNqG6FtubkDEupjW1sjH+R1/70z2SE?=
 =?us-ascii?Q?2u+BJSitvIZn7P6Kwsya4JJJ6krymtYlwSQEe9qVs12g3tXwDSkD1KH+C/H0?=
 =?us-ascii?Q?RIM7S93Fv4T6C6FDaruTFcwWH9tk5Ws8Yo88ozOezCR4C6z0FFGtGHxig/1i?=
 =?us-ascii?Q?NWEIagn7uLB9wgiut6DbZWL1lG07eN3UMXBK3vIj76V+PYbjNAh5svKhwi6E?=
 =?us-ascii?Q?CQRnGuk1ykhnj/3kTTUKhj4vyNCmrEtgAzVRutgqBzZa1j6dbYNWsY4fAGfO?=
 =?us-ascii?Q?v1H50DbkK6w/LUp0zuMgHDP6J4Bf9bhZYJzOruTV9mQHnS8Az+JMUTw72Di5?=
 =?us-ascii?Q?zXESB9pHBW9mjG/+/zvuOsBrI9Gh9KGLQoRq/XP14TG0tVSwHTAdHuZz+v9P?=
 =?us-ascii?Q?KnOk2zHetuETSP6O1KgOcA1QNOE2/noZO6qIyKRqFmwkX+5ejoKLzhgugVEZ?=
 =?us-ascii?Q?75QU4NHg+7tiuKCPAO/8N8LlpyfUSbctMSNN2XXmGmJhQDaAgofziBMhnGk+?=
 =?us-ascii?Q?OSMafe03kIp9EoqZ9FgeNxuDRkjy3Z/Hh+gbi//GNMNz/HJKEhStnnp+tADO?=
 =?us-ascii?Q?BKAFKNwagnXnBajUF4nGw10/SGJ1K5jS1isOQ7YlniAG5cstV0xH03kBTivQ?=
 =?us-ascii?Q?0htOloVHpa40Jh9ZtqD3YA3er2vRTUDNwQQGaYQIE/N6LBM8kDRzMgfxJdJu?=
 =?us-ascii?Q?iRBLrOQEz884OgKBF0BBIa9iEQiphYYhw/ac6oklKKccoO4ticLa0DtA08sk?=
 =?us-ascii?Q?l2/aKHkpHmr/y+e2PGsvax8BxAf3ZL+jk+sH16xVMHYevK+x2pfHQuUJpM7o?=
 =?us-ascii?Q?V6Sm23s8VHY3VSBE1eRzkNcdy7ISGm98SL0e6Cz0Y0d+vA09Wlut9oI0+h7E?=
 =?us-ascii?Q?vX4hxeTQbUdrlSK24oHyWHWXtcICxFi+NIKHTms7rbfpYIUcv/yFHj6l0jAC?=
 =?us-ascii?Q?ToObzLbEgIDKgrjAMHO3gES5aFgDNXmOtUMFP+HI2lBOO4mJVZFbPinSVMPT?=
 =?us-ascii?Q?h7OvNPOAgEhZSDprbuWL+IKESZy2ipR8XL8bBcSXx74JN2ZVq+kRZq/O2S0Y?=
 =?us-ascii?Q?RfW6JsHir51Fd+gBsElLo9M9WU1lCWMGgj3m6IEHIFoAtCqMAoMPA9geRO1W?=
 =?us-ascii?Q?7i4AjnGAj4R80yhd7B5R/KNUz2xBYakyDu7/gUygHa6xMAjYTPOHxtWnzx7q?=
 =?us-ascii?Q?uuL9xh0cxvhoME4cEcyls4moY+RvjgbSbi8AUAkvEeIZDlMseMQDWH+7CL9X?=
 =?us-ascii?Q?sar9OXVDorSmyDxzSbtFsuRjHlQTzpvLgqtnD8/03Y/NZAMnSQZzu5UTLmXl?=
 =?us-ascii?Q?O460Mrih/W+Sin3rRD4LxMBrHW0Ti6OLf1I7GaI9g25Sq7/K4MXrVGsz8C3n?=
 =?us-ascii?Q?efHkURlQfydtwy1+1mSfzzcjzWWzEuA1nzvbQkZO83kIhdT2EUtebFFcDFNb?=
 =?us-ascii?Q?P5LFAaFe6nXPwMfI5jCA8zk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5596.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e9dceb-fa55-4a86-3e5b-08ddf428cf0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 07:23:46.5649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FuM7hwtvtEfy3jjVwm+yzlXv9oJRGzgVTBHBNKMQStjArZCWpu/A1yZSg6Q2KX1DAmUXlB7zToRqFQ+/nbfo5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7449
X-Outbound-SMTP-Client: 173.37.147.250, alln-opgw-2.cisco.com
X-Outbound-Node: alln-l-core-06.cisco.com

You are right, thanks. I will submit a patch to fix.

Regards,
Per

________________________________________
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Sent: Sunday, September 14, 2025 23:57
To: Per Waago (pwaago)
Cc: linux-bluetooth@vger.kernel.org; Arkadiusz Bokowy
Subject: [PATCH BlueZ v2 2/2] doc: Document error codes for A2DP MediaEndpo=
ints

> :org.bluez.Error.A2DP.InvalidInvalidLayer:

It seems that there is a typo (duplicated "Invalid") in the error name.

Regards,
Arek
