Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2052.outbound.protection.outlook.com [40.107.247.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFF11DEFE5;
	Fri, 28 Mar 2025 19:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743188950; cv=fail; b=plU7zgTTHLCKQt+bhp2AmJsz9/RQ2KUCIMwCxOT6iv1duajRVeAZMDx78Wctv8vUiufEPylk2e9Darm+gjTtycCfUbWyLdMTS8uss0HevcIfAs8ydOdPtVnwiKtSRDREGGZxo3Xl2KCGyuaOphBGORf6oScb+BO9d4f+PeSprNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743188950; c=relaxed/simple;
	bh=WcRDNkBVuK6TUgsF3GgBTmAXBG5bxhkXjefGaYdq1DI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sV443wypB7Rygs1LD9yhmbGjB4mT+urlQauFNqRuOGtEKsF+HoCPdKSGj+OjsiZkZ6fDygUMtXCXA4FPccLshua2qhbbWKTn54j5cqH6tkFahyMzNijRAFsvQ+z6dVIlDWS+Yvvd68ARntAoyJjb80fiGa1zRLA9jo8GlhL4oLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RvOQ8VnD; arc=fail smtp.client-ip=40.107.247.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RvOQ8VnD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eITf3XiMLk0djzDcXhpiAjnZ8ERuzuLBMLb5ip4jf+u9dy5oDJK0uGcSYSUMp2G+YJRek/1w8U5GFglVUr/d2KKsTpCtG7Wvrg/Avw1/+xgxA1gB03ovubhZ4ir8zWBTogB6J8uk/whxUDSkPFzYFP4LVmjyL9eJSVCMuMX7nGnR2Ji8KvvZhlj0ZO0OJVirdH40VF1tEw+a8K4AJAsy1kbGEQy8OaPVfwXb6j6U2hKqR5Or4Taih8TEVxm3xqGdu0vpxD/a9FiPNdBwFLMVlV9XZiAvDGOHD+pNStXHPl9qEh9Ec64qVdDq20ijeA3KKsDB4DWN5rHQVFlFcpTKVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcRDNkBVuK6TUgsF3GgBTmAXBG5bxhkXjefGaYdq1DI=;
 b=BybPXGqdgjQGpm0iocwCMXakE/UYD6nm+SVW5vQFoq9MGJTY0UT3i1aVHjWIdeZN9YGWeFFHVWhhzKs8gQYQdeKxc1RVkjGY+IKkd3VUH9PZSZk4TUwXS+C2sZBc9SHJM8Rv13oiozkZ9aU9uXGY6vnIA2oTuK3vc9Kskjcv5R2Eoak1wgLKj8vxWJgc4bGx8IZySr7FpKIicNjQSEg2uN/F2h5sU9Dtn7gH9ZYlFE0dCiqmuUeQDhjnqV6VAJz+hjtSKN12TVwYs3cs8y1RS9mReMkBoM2YYrpvSFkrYQYZWUhQYdOS2u1/WWC9IRgBVNxxUneNVEbXAYP8vZ07IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcRDNkBVuK6TUgsF3GgBTmAXBG5bxhkXjefGaYdq1DI=;
 b=RvOQ8VnDPJHZYCglc0ZTdDGx4Ts08hp9/BwYL+hWjMWEF46bdfg9YAZHMOmfq9skxWgg/xneRsdvCeA8XROFeFlss7daabW1wdqKZrQJAiMsBCgP9Grh4z2m0eKp6dfsJkrPuuqYIdth7p1GEYz0zpIZ9028vp9z6q0vpVpa57Hl1QF2Ut/VHeFjiiTmoNFcduJ0+zVDngoZWcmwql1kJRMkWM44zPsr857CsZ5pBf/Y9+r4wKbHoHf/0sR+w/enOj0CWFG6/tlOaZcu4UwbQ17lwAdo9WsLswkGzTUV+JHSgF9Ae1oKQB6NBs9keJ0QG2hBywnY/rzxcg2vc1Fvdg==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PR3PR04MB7338.eurprd04.prod.outlook.com (2603:10a6:102:80::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.46; Fri, 28 Mar
 2025 19:09:04 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 19:09:04 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Sherry Sun <sherry.sun@nxp.com>
Subject: Re: [PATCH v1 1/2] Bluetooth: btnxpuart: Add msleep() after changing
 the baudrate
Thread-Topic: [PATCH v1 1/2] Bluetooth: btnxpuart: Add msleep() after changing
 the baudrate
Thread-Index: AQHboBTfABZLpfgs+kKUkF4tvloD8A==
Date: Fri, 28 Mar 2025 19:09:04 +0000
Message-ID:
 <AS4PR04MB969271F0FDA32329E60E5711E7A02@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20250327182523.524534-1-neeraj.sanjaykale@nxp.com>
 <87092878-9296-4609-b744-a6e914316e52@molgen.mpg.de>
In-Reply-To: <87092878-9296-4609-b744-a6e914316e52@molgen.mpg.de>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|PR3PR04MB7338:EE_
x-ms-office365-filtering-correlation-id: dbb2bf59-d52d-4ba5-cecd-08dd6e2c01b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?amsxV1EybHYvMHMyTDBzMmlLbFZLWWVGZGRPdFhiS2x1YzBGcmYzSjBUcmFr?=
 =?utf-8?B?NTBsWnAyVFFsZzhkNjRJcHZRSGxCYStNbFpNTEJhQ3V2NFBFVjV2WjJNQmJ3?=
 =?utf-8?B?Q2NPdG4zVkxyVlJWVUNxVTAvTERrbU9YeGk4THBoNGxtTTFEbkRYNmFYUzRv?=
 =?utf-8?B?V3BMcnhNSXFiRmp3Y3dITFhaVHVlWGxXTXZRL2h4SzRSUTBRNWtsR0NtRmtV?=
 =?utf-8?B?a2k4dC9xMVQwOGZpVU9CaUxFUGNmakUrR0hWaU1LejRNb25ESkVyb1pjSGF4?=
 =?utf-8?B?bjlRL2JxMFc3WkdSS1BzOTlXcFlvOXUxRjBuUUJSeUZxNzB0YTFUM2dGUlJx?=
 =?utf-8?B?dzZsZzdnaFpGY1lYaWdONmFwTytjQ3hrd2NvSllkV1hWZXcxS0E2T0xaVEJl?=
 =?utf-8?B?elRKQnBWQjFibFIrZW9ISXhHaGZCdkRYY3dCUVBpWU1sMTdJa2JFa3V1NzFP?=
 =?utf-8?B?U2l2QXBYZVlOemxYN0xOWm41dWNoVDZrMUJjTW8rc25qZlFwN2R3ZkpCUkJv?=
 =?utf-8?B?Qnk4OVYwWTRsc3lyWXJyU0FhNzhTTUo3anNqTGE0alRhYTBEbFJGOUs5b3Vq?=
 =?utf-8?B?V2pHOXNrMHVaNTlkSXlHMm1JLy9ZNE45TnJBZEVNaWx2am0rMUc3R3pteGhK?=
 =?utf-8?B?TCt5cUVsMkpld3pLWU1tMzR3RXpjdFlpZDFrQ3J6cHZNUWozSXlrWGhjSi9Y?=
 =?utf-8?B?Q1ZoQXU5dm1WT2svNk9oNUNrNXV3NTQ2WGR1cVpxZDdCbC9hSjE5WnZVVm4r?=
 =?utf-8?B?QWlzMDhFUnliVkIzcFVmbk5PMkk3UkVsVkpRYUhNQXBnbFNITmxJaFBMaWdI?=
 =?utf-8?B?WjZIYVdJYTdiOWpYSTZpRzNTVDR0YUxhTTNCYjY5VDhsQlFGV3JLL3ZPNk00?=
 =?utf-8?B?WlBkdkZUVHJLYWtvaVRWdzl4UUpZMHpJbC9MemJVeDVGbFZIVGVWdC93aSt2?=
 =?utf-8?B?TkFRNWRnSHFWekFFS0tGQStyam42eEZTK2R3RjQxNkc5clFkMnBxS3hBb3Mr?=
 =?utf-8?B?N0NEbU5OQm9nTzNqanduMVprVWJmdUlEb0I4U2ZsU2FneFRRZEhJeERkaFhu?=
 =?utf-8?B?MEhQUVpxWEp0T0dKL2F0NU1NbjdQazdZWVpURFdQOUFPRC9OTWY2TWNmcktC?=
 =?utf-8?B?U2MwRFBDeTROb3VrSHYrWUVtczdESnZYZTdIZTV3V2lDbjhJazF4SmpNTTVi?=
 =?utf-8?B?VHFwNmpCRUJVU1JPNW91Y0JmQUVTb1FueWVhWGlwUjA5TG11R2ZwN3NLbWM2?=
 =?utf-8?B?dG51U0FCVVZhcEVSK3ViWkpUSmpjWUFBOXNnekFreVZLbVlacU93TzlCTmVo?=
 =?utf-8?B?UGN0azEvZ3RlRlJ4cnJwTmhBR0JTbVEvY3FJY0JVaFZWMDkxMWJRanAxM3A0?=
 =?utf-8?B?UVdwVjRaV2tOcnE0TG5LWmE3WFQvOUdPSjlKUEZFcjFYeWp1aW51Vys5a3Ux?=
 =?utf-8?B?aWdHQVBzc1VFb2hhdS8raDJHcFAwOVAxUUJDNEdrbHNqZmhSbVBFTzhLMFZF?=
 =?utf-8?B?UE1MSkMvbnlxNTNTdVVUTXpkWUdBZlNPN3VTZ0txVUNRNkZ5eWZReFhIeWts?=
 =?utf-8?B?YWIwc1d5ZHpuOUExT3ArQWhsaEVNaGFLVm5VMzIyaHI1RE40am5NVm5MVHNv?=
 =?utf-8?B?bTJ5ZVN1dE5RSzgzOWFmUkRiTnBWR3ordEluMTJPMzIwWmdBWkhUYzNvZmhX?=
 =?utf-8?B?UFQ1c0g0U2tiSVN5VHFFdFhiQnlxbkZhV29LNFRNKzc0SVEzS0hNUTI2czNh?=
 =?utf-8?B?c0JVSmQ5aURWVGRGbG4wanM4WHMxSTc2UHljWHlIMFVZUUY3cjdoNVg3dzIr?=
 =?utf-8?B?Q1N6S2N4aGtYYU16ZFV4N1JhNWwySHYxSWdYN0xaWTFWbHk3aUZuNGxielQ4?=
 =?utf-8?B?NDZxQWRaQ0k2Ym5ubFhPbEtwdVRaMWV6SGNHNGlmQnJvdzRNRVN2UnhYK2xF?=
 =?utf-8?B?VXNZT3pzZlJsY1ZwY1dqODQyNCt5cmJhSy9vblRTc0drR3A0cGR4ZEJZeVRK?=
 =?utf-8?Q?lBTI95Q1MpwhdKPKENB2dpRhn1Py4Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MkFic1VQZmN4TXZuVWVTMGp5OTNIemNyNXRja0dlT1FTdnZjSHNoWUpiaHFj?=
 =?utf-8?B?V2JVek02aENrMVUwemdnTXJZamdVRmtUalJuWXZFYm9VT2FjbUJrVlpURlk3?=
 =?utf-8?B?dGd5c1RSc2RNNXExcmlRaEVGRmRGVmI5SmltYVVOcXFIWGxZVDlLaWEzeEhr?=
 =?utf-8?B?UVluenNTcDFxdFp6ck5OTWtVWDFaQmIwa0loak9EMnY1cHBwcld3VTcvVHJT?=
 =?utf-8?B?TVNKdHJiaWN0cTVQVlM5MlVsRksrRW84VzRhbFNqVzVCMjAxT1I2bWhWVWIz?=
 =?utf-8?B?VHhXYjB3Ylo3bk9xZUY4dFF2empuMGJseklHdHJzcVZPd3lka0FZdWt1M2ZP?=
 =?utf-8?B?OWdlR09WRGFNdW5ZNXU2UUFFVjg1MEk0YW5MQUs3aVZSMXZiWXc3WmtKdFRW?=
 =?utf-8?B?UXBLL1M5NC85dlJyY3lNSGlCR3VLSTdCOVdQYkhWQlROM1pPMFMzSmRzVEtS?=
 =?utf-8?B?RFkydWdsK0RVYTJqOXZaZFp0ejFVUGFpeGYwSmdEeVRvMll3TXFyVHRRQUtq?=
 =?utf-8?B?VVlaSndPbGpqd09DSlJkQmFpKzY1bytFN0xucFAzc0hSUXQzZ01naTVIVFRa?=
 =?utf-8?B?ZjIveDZPZUh2cGUybFpsMTk0WGVBKzhBSHB1dE85MEM2VDcycFdxc0ZTSjVZ?=
 =?utf-8?B?aStRSkgzd3gyVXczenZwdGlYNVhBSzJmeHR4b0IxZXlvRk9uL3N3RzJ6NFFa?=
 =?utf-8?B?MkJyVEN6c3hHdVJ5Q3A0RVBLSm5nek10TU1FS0Yrb2NNTXYwVTE4dmVpQklm?=
 =?utf-8?B?NTFUYndrTXZ4cmFiU0FkYnJlak9mTklFOStGQTR2TkQ4TzZMUGJ6Y29iUVl4?=
 =?utf-8?B?aytseWc0T0dUcXFQS2RFMFpzdGIzVm5zTEZ0czdDeFp5TDBqc29ZZGd0WjVO?=
 =?utf-8?B?NVkvY2JLRjZ4OW40L3RXUDJ2M28zUFJ5RkpDVzBOM2hBUDEwZkFNMXpnUHBR?=
 =?utf-8?B?NVZKSGF5ajcxUlkxNGFReTJpVWtUUUhERGN6dXhrT25pQXJLWElNMlpXTEV2?=
 =?utf-8?B?TlZ2OXNnaWhzQU83SXprTldyQXZ0K3dyK2ZUTDcxU2w5U2JFWnhJMkVCdXpY?=
 =?utf-8?B?TVJmSkhFam5uVU9rTXF3cGQvSDJWOWhja3EyeTcrczJCdE8xZ1Z3clZVQjNo?=
 =?utf-8?B?SElVVUQ2R2NpUTN1dzJCVzcreWl1Mi9nSFRPMklWbjJlaDdFWVZhZDZOeE1m?=
 =?utf-8?B?b2h1WlZjS3RjZ09vdStwWUoyVm9lTXVIT1g1WkcwcDRhSDV6em5lRSs1WTNt?=
 =?utf-8?B?V2ZOaDZpUmRCU3pQK0RpMGFvUVI0UUgrRnNwNHpVaU1mQUJMc01XQUlyN0ow?=
 =?utf-8?B?UFZhdUVTRGZiVDhKNG1jUXFPVlJwMkE5UFlaUE1KYmIrWEFZeHFCWFlUYWtp?=
 =?utf-8?B?Y0dkRWlhbWlvSW9YOXQ1RktYalBnOFBPQytsRkJlYXlUTms4UUVWTFZNdXlx?=
 =?utf-8?B?d3MybDQ2RXRHckJWOHVrNmxsK3ExUEtzSCtvcERTeFU2T1ZNNHh5aC9Jb3Qz?=
 =?utf-8?B?algxbExpczNBbjZKMW41aUZIV2RsYUtLc0lLQTFlQ3Z5V1BNSFovalZjYllt?=
 =?utf-8?B?amc0eTl0TGgxMEZVNFdUMzRZWlBSbmdKcU9qcTEvWmpxUGJzWXJsQkphNUdp?=
 =?utf-8?B?a0QvelRmaFU5MDJ6UWRMSTFncFYyT1ZuRWYyWVRkbVEvWU9oOGlxWFlBQ2hj?=
 =?utf-8?B?ajBHcWNVTnNtNlFoQWVPNFVZMDFJUnAwc3FIcnE5Q0tqUTQrNExxclQ0ZEox?=
 =?utf-8?B?RVN0UmVid3ZkNURxcVFJaTJhRWpFQVhaTmwzZloxaGFETzd0Tzgya2IvZm9D?=
 =?utf-8?B?VHptQnVNN2hzSG9tWmhXamhQN3NLVmJxSHgzdzloSWNQTy9GamtxL3dlSmVB?=
 =?utf-8?B?anhFY2hERXQ5SW1PYldnQmFCZk1tMStwWDVYWkFFaSt6cVg4MHZYOS9CS2RL?=
 =?utf-8?B?SkZjVGtzclc4VjVINUx2bkUyaG85ejBnc2JXTEdLeDNrMmJ0d1NwTnNPRFN0?=
 =?utf-8?B?VFFaOGFxUmdGaVlRWmMzR0JoZG1LczhFY3k0ZkxoNzJwVFN4Y1R3Z2pRM3Qw?=
 =?utf-8?B?NnJ3bHhZRGlUL3U5a2FkbUlBcmlqVk1sS3czYnoyVXd6aUV3M0R3UVBlbDVN?=
 =?utf-8?Q?kmNYKPFn9J3WCr9pg53H5m9rD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb2bf59-d52d-4ba5-cecd-08dd6e2c01b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 19:09:04.2918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dIL6eTApCRiILtL8e5LP1rRQmQZUDHx3vxx8Fg83Z3zqGxFTJDybV3O8dj2f/QLgkT++WP3oQEUTZaBCWUWP8EIQT6E1czV6h69jQGPIhak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7338

SGkgUGF1bCwNCg0KVGhhbmsgeW91IGZvciByZXZpZXdpbmcgdGhlIHBhdGNoLg0KDQo+IA0KPiBE
ZWFyIE5lZXJhaiwNCj4gDQo+IA0KPiBUaGFuayB5b3UgZm9yIHlvdXIgcGF0Y2guIEZvciB0aGUg
c3VtbWFyeS90aXRsZSwgSSBzdWdnZXN0Og0KPiANCj4gU2xlZXAgMTAwIG1zIGFmdGVyIGJhdWQg
cmF0ZSBjaGFuZ2UNCkkgd2lsbCB1cGRhdGUgdGhpcyBpbiBWMiBwYXRjaC4NCg0KPiANCj4gQW0g
MjcuMDMuMjUgdW0gMTk6MjUgc2NocmllYiBOZWVyYWogU2FuamF5IEthbGU6DQo+ID4gVGhpcyBh
ZGRzIGEgMTAwIG1pbGxpc2VjIHNsZWVwIGFmdGVyIGNoYW5nZSBiYXVkcmF0ZSB2ZW5kb3IgY29t
bWFuZC4NCj4gPg0KPiA+IEl0IGlzIG9ic2VydmVkIHRoYXQgd2hlbiB0aGUgYmF1ZHJhdGUgY2hh
bmdlIGNvbW1hbmQgY2hhbmdlcyB0aGUNCj4gPiBiYXVkcmF0ZSBmcm9tIDMwMDAwMDAgdG8gMTE1
MjAwLCBhbnkgaW1tZWRpYXRlIEhDSSBjb21tYW5kIHJldHVybnMgYW4NCj4gPiBlcnJvciAtMjIg
KERldmljZSBCdXN5KS4NCkNvcnJlY3Rpb24uIEl0IHJldHVybnMgZXJyb3IgLTExMCAoQ29tbWFu
ZCBUaW1lb3V0KQ0KDQo+IA0KPiBSZWFsbHkgMyBtaWxsaW9uPw0KTlhQIGNoaXBzIG1haW5seSB1
c2UgdGhlc2UgMiBiYXVkcmF0ZXM6DQojZGVmaW5lIEhDSV9OWFBfUFJJX0JBVURSQVRFICAgIDEx
NTIwMA0KI2RlZmluZSBIQ0lfTlhQX1NFQ19CQVVEUkFURSAgICAzMDAwMDAwDQoNCj4gDQo+IElz
IHRoaXMgaGFwcGVuaW5nIHdpdGggZXZlcnkgY2hhbmdlLCBvciBvbmx5IGRlY3JlYXNpbmcgdGhl
IGJhdWQgcmF0ZSB3aXRoDQo+IHRoZSB2YWx1ZXMgeW91IGxpc3RlZD8NCg0KTGV0IG1lIHNoYXJl
IHNvbWUgYmFja2dyb3VuZCBmaXJzdDoNCkFmdGVyIEZXIGRvd25sb2FkLCB0aGUgRlcgaW5pdGlh
bGl6ZXMgYXQgMTE1MjAwIGJhdWRyYXRlLg0KDQpJbml0aWFsIGltcGxlbWVudGF0aW9uIG9mIEJU
TlhQVUFSVCBjaGFuZ2VkIHRoZSBiYXVkcmF0ZSBmcm9tIDExNTIwMCB0byAzMDAwMDAwIGluIG54
cF9zZXR1cCgpIGFmdGVyIG1vZHByb2JlLg0KRHVyaW5nIHJtbW9kLCBkcml2ZXIgcmV2ZXJ0ZWQg
dGhlIGJhdWRyYXRlIGJhY2sgdG8gMTE1MjAwLg0KDQpIb3dldmVyLCBzaW5jZSBhZnRlciBtb2Rw
cm9iZSBoY2kwIGlzIERPV04sIHRoZSBjaGFuZ2UgYmF1ZHJhdGUgY29tbWFuZCBmYWlsZWQgZHVy
aW5nIHJtbW9kLg0KSXQgc3VjY2VlZGVkIGlmIGhjaTAgaXMgYWxyZWFkeSBVUCBhbmQgUlVOTklO
RywgdGh1cyBuZXh0IG1vZHByb2JlIGNvbW1hbmQgd291bGQgYWxzbyBzdWNjZWVkLg0KDQpUaGlz
IGxvZ2ljIG1hZGUgc3VyZSBCVE5YUFVBUlQgYW5kIGNvbnRyb2xsZXIgYXJlIGluIHN5bmMgZXZl
biBpZiBGVyBpcyBhbHJlYWR5IHByZXNlbnQgaW4gdGhlIGNvbnRyb2xsZXIsIGJ1dCBybW1vZCB3
aGVuIGhjaTAgaXMgZG93biBmYWlsZWQsIGxlYXZpbmcgdGhlIGNvbnRyb2xsZXIgcnVubmluZyBh
dCAzMDAwMDAwIGJhdWRyYXRlLiBJbiBuZXh0IGl0ZXJhdGlvbiBtb2Rwcm9iZSBjb21tYW5kIHdv
dWxkIGV2ZW50dWFsbHkgZmFpbC4NCg0KVGhpcyBwcm9ibGVtIHdhcyBmaXhlZCBpbjoNCmh0dHBz
Oi8vZ2l0aHViLmNvbS9ibHVlei9ibHVldG9vdGgtbmV4dC9jb21taXQvNmZjYTY3ODFkMTlkZmFk
YmMzZDk2YjNjMTBkYWYxZjJlMTIzOTA5MiAoTWVyZ2VkKQ0KV2hpY2ggaGFkIGEgY2hhbmdlIGlu
IG54cF9zaHV0ZG93bigpIGZ1bmN0aW9uIHBpY2tlZCB1cCBmcm9tOg0KaHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9wYXRjaC8yMDI1MDIyNjE1MTM0MC4xMDE3
NzkwLTEtbG9pYy5wb3VsYWluQGxpbmFyby5vcmcvIChOb3QgbWVyZ2VkLCBkcm9wcGVkKQ0KDQpX
aXRoIHRoaXMgY2hhbmdlLCB0aGUgZHJpdmVyIGNoYW5nZWQgdGhlIGJhdWRyYXRlIGZyb20gMTE1
MjAwIHRvIDMwMDAwMDAgb24gbW9kcHJvYmUgaW4gbnhwX3Bvc3RfaW5pdCgpLg0KDQpBZnRlciB0
aGUgaW5pdGlhbGl6YXRpb24sIHdoZW4gaGNpMCBiZWNhbWUgRE9XTiwgbnhwX3NodXRkb3duKCkg
Y2hhbmdlZCB0aGUgYmF1ZHJhdGUgYmFjayB0byAxMTUyMDAuDQoNCkxhdGVyLCB3aGVuIGhjaTAg
YmVjb21lcyBVUCwgbnhwX3Bvc3RfaW5pdCgpIGNoYW5nZWQgaXQgYmFjayB0byAzMDAwMDAwLiBJ
dCBmaXhlZCB0aGUgcm1tb2QgcHJvYmxlbSB3aGVuIGhjaTAgaXMgRE9XTi4NCg0KSG93ZXZlciwg
dGhpcyBsb2dpYyBpbnRyb2R1Y2VkIGEgbmV3IGlzc3VlIHdpdGggImhjaWNvbmZpZyBoY2kwIHJl
c2V0IiBjb21tYW5kLCB3aGljaCBtYWtlcyBoY2kwIERPV04gYW5kIFVQIGltbWVkaWF0ZWx5Lg0K
DQpTbywNCjEpIG1vZHByb2JlIGJ0bnhwdWFydCAoRlcgZG93bmxvYWQsIGNoYW5nZSBiYXVkcmF0
ZSBmcm9tIDExNTIwMCB0byAzMDAwMDAwKQ0KMikgQWZ0ZXIgSENJIGluaXQgZG9uZSwgaGNpMCBp
bnRlcmZhY2UgaXMgZG93biAoQmF1ZHJhdGUgc3dpdGNoZXMgYmFjayB0byAxMTUyMDApDQozKSBo
Y2ljb25maWcgaGNpMCB1cCAoQmF1ZHJhdGUgc3dpdGNoZXMgYmFjayB0byAzMDAwMDAwKQ0KNCkg
aGNpY29uZmlnIGhjaTAgcmVzZXQgKGhjaTAgZG93biBzZXRzIGJhdWRyYXRlIHRvIDExNTIwMCwg
Zmlyc3QgcmVzZXQgY29tbWFuZCBpbiBoY2kwIFVQIHRpbWVzIG91dCkNCg0KT24gTG9naWMgQW5h
bHl6ZXIsIHdlIHNlZSAzIG1pbGxpc2VjIGdhcCBiZXR3ZWVuIHRoZSAqY2hhbmdlIGJhdWRyYXRl
IGNvbW1hbmQgY29tcGxldGUgZXZlbnQqIGZyb20gY29udHJvbGxlciwgYW5kICpIQ0lfUkVTRVQq
IGNvbW1hbmQgZnJvbSBob3N0IGF0IDExNTIwMCBiYXVkcmF0ZS4NClRoaXMgSENJX1JFU0VUIGNv
bW1hbmQgaXMgbWlzc2VkIGJ5IHRoZSBjb250cm9sbGVyIGFzIGl0IGlzIG5vdCBjb21wbGV0ZWx5
IHN3aXRjaGVkIHRvIDExNTIwMCBiYXVkcmF0ZS4NCg0KVGhpcyBpcyBhIGNvbXBsZXRlbHkgbmV3
IHNjZW5hcmlvLCB3aGljaCBuZXZlciBvY2N1cnJlZCBiZWZvcmUgYWJvdmUtbWVudGlvbmVkIGNv
bW1pdCB3YXMgbWVyZ2VkLg0KV2l0aCBzb21lIHRyaWFsIGFuZCBlcnJvciwgSSB3YXMgYWJsZSB0
byBnZXQgdGhlIGhjaWNvbmZpZyByZXNldCBjb21tYW5kIHdvcmtpbmcgaWYgdGhlIGdhcCBiZXR3
ZWVuICpjaGFuZ2UgYmF1ZHJhdGUgY29tbWFuZCBjb21wbGV0ZSBldmVudCogYW5kIGZpcnN0ICpI
Q0lfUkVTRVQqIGNvbW1hbmQgd2FzIGluY3JlYXNlZCB0byA1MCBtaWxsaXNlYy4NCg0KVGhlIHJl
YXNvbiBmb3IgY2hvb3NpbmcgMTAwIG1pbGxpc2VjIHdhcyB0byBwcm92aWRlIHN1ZmZpY2llbnQg
YnVmZmVyIHRpbWUuIE5vdyB0aGF0IEknbSB0aGlua2luZywgeWVzIGl0IHNlZW1zIHJlYXNvbmFi
bHkgaGlnaC4gDQpBbmQgeWVzLCB0aGUgY2hpcCBzaG91bGQgbm90IHRha2Ugc3VjaCBhIGxvbmcg
dGltZSB0byBjaGFuZ2UgYmF1ZHJhdGUuDQoNCkFsc28sIHRoaXMgaXNzdWUgaXMgbm90IG9ic2Vy
dmVkIHdpdGggImhjaWNvbmZpZyBoY2kwIHVwIiBvciAiYmx1ZXRvb3RoY3RsIHBvd2VyIG9uIiBj
b21tYW5kcy4NCg0KPiANCj4gPiBBZGRpbmcgYSBzbWFsbCBkZWxheSBhZnRlciB0aGUgY2hhbmdl
IGJhdWRyYXRlIGNvbW1hbmQgY29tcGxldGUgZXZlbnQNCj4gPiBpcyByZWNlaXZlZCBoZWxwcyBm
aXggdGhlIGlzc3VlLg0KPiANCj4gMTAwIG1zIGlzIG5vdCBzbWFsbCB0byBtZS4gSXMgdGhpcyBp
c3N1ZSBkb2N1bWVudGVkIGluIHRoZSBoYXJkd2FyZQ0KPiBkb2N1bWVudGF0aW9uPyBBcmUgdGhl
cmUgb3RoZXIgd2F5cyBsaWtlIHBvbGxpbmcsIGlmIHRoZSBjb21tYW5kDQo+IHN1Y2NlZWRlZD8N
CkkgY291bGQgbm90IGZpbmQgc3VjaCBhIHJlZmVyZW5jZSBidXQgbG9va3MgbGlrZSB0aGlzIGlz
c3VlIGlzIHNwZWNpZmljIHRvICpoY2ljb25maWcgaGNpMCByZXNldCogY29tbWFuZCBvbmx5Lg0K
VG9kYXkgSSByYW4gdGhlc2UgMiBjb21tYW5kcyBpbiBhIGxvb3Agd2l0aG91dCBkZWxheSwgYW5k
IGRpZCBub3Qgc2VlIGFueSB0aW1lb3V0IGVycm9yczoNCjEpIGhjaXRvb2wgLWkgaGNpMCBjbWQg
M2YgMDkgMDAgYzIgMDEgMDAJCS8vIHdoZXJlIDB4MDAwMTJjMDAgPT4gMTE1MjAwDQoyKSBoY2l0
b29sIC1pIGhjaTAgY21kIDNmIDA5IGMwIGM2IDJkIDAwCQkvLyB3aGVyZSAweDAwMmRjNmMwID0+
IDMwMDAwMDANCg0KQWx0aG91Z2ggaGNpY29uZmlnIGFuZCBoY2l0b29sIGNvbW1hbmRzIGFyZSBk
ZXByZWNhdGVkLCB3ZSdkIHdhbnQgdGhlc2UgY29tbWFuZHMgdG8gd29yayBmaW5lLg0KDQpUaGFu
ayB5b3UgZm9yIGJlYXJpbmcgd2l0aCBteSBleHRlbnNpdmUgcmVzcG9uc2UuIEFueSBhbHRlcm5h
dGl2ZXMvc3VnZ2VzdGlvbiBhcmUgd2VsY29tZS4NCg0KUmVnYXJkcywNCk5lZXJhag0K
