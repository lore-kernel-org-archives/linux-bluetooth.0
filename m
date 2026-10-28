Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793173727;
	b=WSgT91wryDgrCw7QvBhzYf8yPD3eEARHyJXOAZYH0Qb8hqfn7O6nMWPHl5QvigVWi9o/
	 GvqAt+yEtlzyiP4lXq/30GcsAyLKOiIz5Trxot+S4IJjAhqqPWDPWeZenzUjkdtWK+joR
	 rrBSFh7qbCFUlG+Nvz6axegUjzB5Ebv+g7C0Aw4zriO9N35aPMdKxhnp5GDqQ8Unn6dbK
	 PU9w18RzuMo6KgVGfA6/xtWia/Hau5xSauxK1FVP4pAP0ASe56SR2MnuXxarJj1/5xYeS
	 Xhq4a7KPrMWJFIbZGa/Uoi1ULXuPKwYXwTbgJztJJSnBIXtPgJu9qKG/EONNrghSphg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793173727;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=r2MsFwokq/cbIj3qTluPMLdb4YyQ1CMS/35IsyC5wMU=;
	b=FsJZua4SqwiDp+bhOfkt8LCEx8yKgq5ZWqQ6Yj7FImoVc6Jv+o0dtUlud86RCij2JKDK
	 Lrhg/nZwTaHs+1HJy2fX1HLPTvXHVegn9z0y9oP4Aw/HOLC/aRQTrc/QVroBmuKkC7eQF
	 eecah2vwYm3zQG8+bcnKS/6zEsFqmZb4KtAuu7nVpWRCVwhE6ZnXij8cL8+Ds5FgeZzkW
	 zX79Ll3JkrwTbT0reAjkUEvT3yuf17lbBpGllKy+8P4k+CPgK4Ts+huRJhThd336Kqhhl
	 VEkhXb/MbXFecwsN2z3ysyBSYvCa3e7UXJpgFTxedNN+c9vk1MNtQXlYhx87bCApc5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LeBzL56A;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ic8aIe0X;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6158606A31A
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 07:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6158606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LeBzL56A;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ic8aIe0X
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S4PVac655647
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 07:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r2MsFwokq/cbIj3qTluPMLdb4YyQ1CMS/35IsyC5wMU=; b=LeBzL56AAS+j6Zl9
	oQrCi/gh7ILkSo2eIba7dOmUOhxxiBZasCy1bOMN6kVIhJx8j2yQZGmYZ5f9Ww4S
	78UOnNXRBRGhDFtbGdTvqOHP61zipfpJVJ7zq0bjIXo12qiS1gT8vnAqZF4TvyJN
	f2icbTk6qgitL7lcLXdyfI+DwhA5tg59IUPNIB1Ci2bKM7kmqxvmlbKNOspgEAEI
	KcQyJI54ZpJk65kXMw+9/yPplOjJIhOw+CuRzOJmRFn/kH5XTHaeR13eAGURNU7L
	UbB0XE6e1F8Emx8w++3/22kOyo3Fsktbmf4qC3ekp6b5OriWimBIBFzgxfYmV+tz
	7Pdz9g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk7g7h5b9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 07:48:45 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e969b16118so1378345ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 00:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793173720; x=1793778520; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r2MsFwokq/cbIj3qTluPMLdb4YyQ1CMS/35IsyC5wMU=;
        b=ic8aIe0XVhG2tg8nyB2BkdyfDE5OZpNAp1PjAjwSIQp47HEDCiPXPqocno2Qy0E2cB
         a++3Oq3z6ps7hHhiLTtDETwQzBfvxLFevx+IMGP5nPI4LIdBvnWMSIeZXAUGN6fCLnRt
         +3Tr6Lr3gNTcM7C84LcM99BhIx60KfGNTEk4/hDDWLgIPWWkD7yDMMYcD2GYLbx9JlmZ
         Wu7dcnCOxj0Y7tWvhtrynam9MYs7YiLkfAnX5+f2UTOiVH+HmuQ2mdPUUyHc5NUNsUIj
         isdn4Mz4pwUlRbnZosbwCuk/B/xtOcrpkfK+E2VJQj1QD3fHOUCSvqFlOe3Iv52UoxLB
         g8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793173720; x=1793778520;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r2MsFwokq/cbIj3qTluPMLdb4YyQ1CMS/35IsyC5wMU=;
        b=ZcWA+4T5+Ctqtu8ia2uTTZj0oREh93OeDRtt1xbpFal53wCWF+1FFhe0inGO9YTrUm
         p5DGLQ/mDT2wR0WxmvQCSzucIig6YDOKcmVGM0e4CfBpq0dg1GQLpzEG1s5myOwxKa9Y
         U/9xBPNEL7Slcrw1nhbpnj5ryDLuE9ouOJzMqIoXuUaDvovAc3ph6KUfJxWAdzevmhrd
         8ur1dpekKT01Jf33Rax4QAE/4UAWLpinvwkaXtUNCBvq1ML086cG3Y+NFN4mW1iwNClg
         RM/glPRvx7X+LvzpnT5YLI8hrA6zt+LMU2G8jhkbA0JolDiKJPgS4DQhySGzzQcnDlWj
         HC9A==
X-Forwarded-Encrypted: i=1; AKwUvBy7napHfNc4ipcgVUjsRVaojDB6WWkbgDEf8YsIjmINN9QWkUIDESnKJzb48hxEz8Dkdrz3UuB5zgrqXXv1NBw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLX5cIBIuVhKaTGMz5dB4gDfAOppgTyYf2OPND+NLsNjSibz54e
	HMvMEVp1hmFsJUxYudVy5lg4NPE98OqgucPtrDsMc5cVxvkRUzU4iJWQo/23z+j0yaUejSG0qMp
	k7rFN8jROll5gLMqwWeZhxErLTpgvf5lgU7vhRvjb/PSGJc+PinKOcZDGV5BInBbrWpxx9SM=
X-Gm-Gg: AYBFou1PqdQTuBB8uqgRvYtRBNNuZgg+MxkHNJN3fbKuGPpQxqdW2Oscf9n5BNq6XyK
	lUA6fZESs0/+HcuwNdBIQkz8w6w888kNwJJf5yXJUt9zgv8/wHzlSYu2DVEN+fHckeepiUgNG6l
	IYX4ZWYFuAyOcqE77uG4V1BqebWDVAeJ4KTRamwlgEMQ1LwNUalVs3CWOuhpDlYFTyIfCSY6zwe
	1oEpPRiGkgcmmXgxpHSEGEAArfpsZyBiK48xHmOPdRHCTUqfXB6Iz7mGAFNj/sJ/5qT+am1K/H9
	7YcYKE2KdCIIGGHQ2KpmHPQtbxZFpg56W8Wc7JCoLXGspu+QdNBRNNKMXnfPLcX8xAnFzujRvFF
	sVZSWbEWXDBZZdWWrSCXzoTig4BFycwu07IgcRNVWVMboHsbT1pctj+UbQVAacx4+Wh088F1zyl
	zqj9fLhzr8+/1JF5viS/FieeuHOKQ1VxLXYt0FMTk=
X-Received: by 2002:a17:90b:4b89:b0:3a6:e61f:749d with SMTP id 98e67ed59e1d1-3ae57e07cf9mr2152014a91.1.1793173719276;
        Wed, 28 Oct 2026 00:48:39 -0700 (PDT)
X-Received: by 2002:a17:90b:4b89:b0:3a6:e61f:749d with SMTP id 98e67ed59e1d1-3ae57e07cf9mr2151978a91.1.1793173718743;
        Wed, 28 Oct 2026 00:48:38 -0700 (PDT)
Received: from [10.249.11.179] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a9a5e73sm1787304a91.10.2026.10.28.00.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 00:48:38 -0700 (PDT)
Message-ID: <ab9638ae-a837-4e51-aef8-c14211705320@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 15:48:35 +0800
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bluez 1/2] obexd/bluetooth: Register profiles added after
 org.bluez appeared
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261027-fix_obex-v1-0-3d91aed181b6@oss.qualcomm.com>
 <20261027-fix_obex-v1-1-3d91aed181b6@oss.qualcomm.com>
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <20261027-fix_obex-v1-1-3d91aed181b6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAzMCBTYWx0ZWRfX2g0PBt0LvrLR
 okHcBX7czv7xaSyZtilekkon5jE/xGK5T51L8OPiRDO8oQNRmiMEgL3AA9ZVXOKSmtovxPToz/L
 73tJQd/l6rWs406aJxXPP2xghFgZBeg=
X-Authority-Analysis: v=2.4 cv=SoIFe/O0 c=1 sm=1 tr=0 ts=6ae1a8dd cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=w8w5-2FSXT724l25UYcA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 5oyf0okUudyUkAGd-qSUmcq3FAsQQBtF
X-Proofpoint-ORIG-GUID: 5oyf0okUudyUkAGd-qSUmcq3FAsQQBtF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAzMCBTYWx0ZWRfX+lDQMPp7XzQr
 TleOUN1Ss8K0Dm3vp5yORfL/hZRfLDhPMhr+WC07XBHLq3vPdYZwbfz5xzHV9EjlvYn9mHrC14V
 8MyQQ5lJMdF9F7FL6++hfImP191vaQ3HosXTgXpWxGWACe87e6npdCPkR1tSPI9fxj9yz0rrEXU
 dmWWn+1YOWHHX2i9P/bsvYuzLh32M7LtY+7JDxiZeM6E+WPJFsl8D9iojPRTsLZ5PANfDLPI/9a
 VTdU0+Lm/kGHj+AcQIdEYgHmNQLgA3UmxwXc1+Inq1+gxO/lKoxA6Qd8d0Uz97GewlPQabZ8Hf8
 fFq/4FIWDQfYJlLYIYtAzNDtkS5wHvcGX/vuyb2se3WWDej+sGEiShZ8QyvYdn+q02EKr+UaIWH
 OSRgaC4onnzkBls6N9W/RBHv18q6uUqAm3hSoS8PSqzOqAyZQZFyNW1bai/qbzolwm9Lgirvli3
 100GE9+ArfVLjYZNC8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280030

On 10/28/2026 2:45 PM, Zijun Hu wrote:
> Issue:
> After boot on Debian, bluetoothd and obexd are both running but none of
> the obexd server profiles (OPP, FTP, PBAP, ...) is registered.
> 
> Why:
> A race between name_acquired() and bluetooth_start(). The profiles are
> only registered if org.bluez appears after bluetooth_start() has added
> them:
> 	plugin_init()
> 	  1. bluetooth_init()           start watching org.bluez
> 	  2. pbap_init(), irmc_init()
> 	       e_source_registry_new_sync()
> 	                                sync call, fails on Debian
> 	  3. name_acquired()            fired, but the profiles list is
> 	                                empty, so nothing is registered
> 	obex_server_init()
> 	  4. bluetooth_start()          adds the profiles to the list,
> 	                                but nothing registers them

Log segment:

Oct 27 08:38:17 debian obexd[1456]: OBEX daemon 5.82
Oct 27 08:38:17 debian obexd[1456]: obexd/src/main.c:main() Entering main loop
Oct 27 08:38:17 debian obexd[1456]: obexd/src/manager.c:manager_init()
Oct 27 08:38:17 debian dbus-daemon[1207]: [session uid=1000 pid=1207 pidfd=5] Successfully activated service 'org.bluez.obex'
Oct 27 08:38:17 debian obexd[1456]: obexd/src/plugin.c:plugin_init() Loading builtin plugins
Oct 27 08:38:17 debian obexd[1456]: obexd/src/mimetype.c:obex_mime_type_driver_register() driver 0xaaaaac0b6508 mimetype x-obex/folder-listing registered
Oct 27 08:38:17 debian obexd[1456]: obexd/src/mimetype.c:obex_mime_type_driver_register() driver 0xaaaaac0b6498 mimetype x-obex/capability registered
Oct 27 08:38:17 debian systemd[1188]: Started obex.service - Bluetooth OBEX service.
Oct 27 08:38:17 debian obexd[1456]: obexd/src/mimetype.c:obex_mime_type_driver_register() driver 0xaaaaac0b6428 mimetype x-obex/folder-listing registered
Oct 27 08:38:17 debian obexd[1456]: obexd/src/mimetype.c:obex_mime_type_driver_register() driver 0xaaaaac0bef18 mimetype (null) registered
Oct 27 08:38:17 debian obexd[1456]: obexd/src/plugin.c:add_plugin() Plugin filesystem loaded
Oct 27 08:38:17 debian obexd[1456]: obexd/src/transport.c:obex_transport_driver_register() driver 0xaaaaac0b6330 transport bluetooth registered
Oct 27 08:38:17 debian obexd[1456]: obexd/src/plugin.c:add_plugin() Plugin bluetooth loaded
Oct 27 08:38:17 debian obexd[1456]: obexd/src/service.c:obex_service_driver_register() driver 0xaaaaac0b62a8 service Nokia OBEX PC Suite Services registered
Oct 27 08:38:17 debian obexd[1456]: obexd/src/mimetype.c:obex_mime_type_driver_register() driver 0xaaaaac0b6238 mimetype application/vnd.nokia-backup registered
Oct 27 08:38:17 debian obexd[1456]: obexd/src/plugin.c:add_plugin() Plugin pcsuite loaded
Oct 27 08:38:17 debian obexd[1456]: obexd/src/service.c:obex_service_driver_register() driver 0xaaaaac0b61b0 service Object Push server registered
Oct 27 08:38:17 debian obexd[1456]: obexd/src/plugin.c:add_plugin() Plugin opp loaded
Oct 27 08:38:17 debian obexd[1456]: obexd/src/service.c:obex_service_driver_register() driver 0xaaaaac0bee90 service File Transfer server registered
Oct 27 08:38:17 debian obexd[1456]: obexd/src/plugin.c:add_plugin() Plugin ftp loaded
Oct 27 08:38:17 debian obexd[1456]: obexd/plugins/irmc.c:irmc_init()
Oct 27 08:38:17 debian dbus-daemon[1207]: [session uid=1000 pid=1207 pidfd=5] Activating via systemd: service name='org.gnome.evolution.dataserver.Sources5' 
unit='evolution-source-registry.service' requested by ':1.33' (uid=1000 pid=1456 comm="/usr/libexec/bluetooth/obexd -d")
Oct 27 08:38:17 debian dbus-daemon[1207]: [session uid=1000 pid=1207 pidfd=5] Activation via systemd failed for unit 'evolution-source-registry.service': Unit 
evolution-source-registry.service not found.
Oct 27 08:38:17 debian obexd[1456]: obexd/plugins/bluetooth.c:name_acquired() org.bluez appeared
Oct 27 08:38:17 debian obexd[1456]: Unable to acquire registry: Error calling StartServiceByName for org.gnome.evolution.dataserver.Sources5: Unit evolution-source-registry.service not 
found.
Oct 27 08:38:17 debian dbus-daemon[1207]: [session uid=1000 pid=1207 pidfd=5] Activating via systemd: service name='org.gnome.evolution.dataserver.Sources5' 
unit='evolution-source-registry.service' requested by ':1.33' (uid=1000 pid=1456 comm="/usr/libexec/bluetooth/obexd -d")
Oct 27 08:38:17 debian dbus-daemon[1207]: [session uid=1000 pid=1207 pidfd=5] Activation via systemd failed for unit 'evolution-source-registry.service': Unit 
evolution-source-registry.service not found.
Oct 27 08:38:17 debian obexd[1456]: Unable to acquire registry: Error calling StartServiceByName for org.gnome.evolution.dataserver.Sources5: Unit evolution-source-registry.service not 
found.
Oct 27 08:38:17 debian obexd[1456]: obexd/src/mimetype.c:obex_mime_type_driver_register() driver 0xaaaaac0b69a0 mimetype (null) registered
Oct 27 08:38:17 debian obexd[1456]: obexd/src/mimetype.c:obex_mime_type_driver_register() driver 0xaaaaac0b6930 mimetype x-bt/message registered
Oct 27 08:38:17 debian obexd[1456]: obexd/src/mimetype.c:obex_mime_type_driver_register() driver 0xaaaaac0b68c0 mimetype x-obex/folder-listing registered
Oct 27 08:38:17 debian obexd[1456]: obexd/src/mimetype.c:obex_mime_type_driver_register() driver 0xaaaaac0b6850 mimetype x-bt/MAP-msg-listing registered
Oct 27 08:38:17 debian obexd[1456]: obexd/src/mimetype.c:obex_mime_type_driver_register() driver 0xaaaaac0b67e0 mimetype x-bt/MAP-NotificationRegistration registered
Oct 27 08:38:17 debian obexd[1456]: obexd/src/mimetype.c:obex_mime_type_driver_register() driver 0xaaaaac0b6770 mimetype x-bt/messageStatus registered
Oct 27 08:38:17 debian obexd[1456]: obexd/src/mimetype.c:obex_mime_type_driver_register() driver 0xaaaaac0b6700 mimetype x-bt/MAP-messageUpdate registered
Oct 27 08:38:17 debian obexd[1456]: obexd/src/mimetype.c:obex_mime_type_driver_register() driver 0xaaaaac0c0090 mimetype x-bt/MASInstanceInformation registered
Oct 27 08:38:17 debian obexd[1456]: obexd/src/mimetype.c:obex_mime_type_driver_register() driver 0xaaaaac0c0020 mimetype x-bt/MAP-notification-filter registered
Oct 27 08:38:17 debian obexd[1456]: obexd/src/service.c:obex_service_driver_register() driver 0xaaaaac0b7540 service Message Access server registered
Oct 27 08:38:17 debian obexd[1456]: obexd/src/plugin.c:add_plugin() Plugin mas loaded
Oct 27 08:38:17 debian obexd[1456]: obexd/src/mimetype.c:obex_mime_type_driver_register() driver 0xaaaaac0b7388 mimetype x-bt/MAP-event-report registered
Oct 27 08:38:17 debian obexd[1456]: obexd/src/service.c:obex_service_driver_register() driver 0xaaaaac0b7300 service Message Notification server registered
Oct 27 08:38:17 debian obexd[1456]: obexd/src/plugin.c:add_plugin() Plugin mns loaded
Oct 27 08:38:17 debian obexd[1456]: obexd/client/bluetooth.c:bluetooth_init()
Oct 27 08:38:17 debian obexd[1456]: obexd/client/transport.c:obc_transport_register() transport 0xaaaaac0c0328 name Bluetooth registered
Oct 27 08:38:17 debian obexd[1456]: obexd/client/manager.c:client_manager_init() Module bluetooth loaded
Oct 27 08:38:17 debian obexd[1456]: obexd/client/opp.c:opp_init()
Oct 27 08:38:17 debian systemd[1]: Started upower.service - Daemon for power management.
Oct 27 08:38:17 debian obexd[1456]: obexd/client/driver.c:obc_driver_register() driver 0xaaaaac0c0210 service OPP registered
Oct 27 08:38:17 debian obexd[1456]: obexd/client/manager.c:client_manager_init() Module opp loaded
Oct 27 08:38:17 debian obexd[1456]: obexd/client/ftp.c:ftp_init()
Oct 27 08:38:17 debian obexd[1456]: obexd/client/driver.c:obc_driver_register() driver 0xaaaaac0c0280 service FTP registered
Oct 27 08:38:17 debian obexd[1456]: obexd/client/driver.c:obc_driver_register() driver 0xaaaaac0c0248 service PCSUITE registered
Oct 27 08:38:17 debian obexd[1456]: obexd/client/manager.c:client_manager_init() Module ftp loaded
Oct 27 08:38:17 debian obexd[1456]: obexd/client/pbap.c:pbap_init()
Oct 27 08:38:17 debian dbus-daemon[897]: [system] Successfully activated service 'org.freedesktop.UPower'
Oct 27 08:38:17 debian obexd[1456]: obexd/client/driver.c:obc_driver_register() driver 0xaaaaac0c02b8 service PBAP registered
Oct 27 08:38:17 debian obexd[1456]: obexd/client/manager.c:client_manager_init() Module pbap loaded
Oct 27 08:38:17 debian obexd[1456]: obexd/client/sync.c:sync_init()
Oct 27 08:38:17 debian obexd[1456]: obexd/client/driver.c:obc_driver_register() driver 0xaaaaac0c02f0 service SYNC registered
Oct 27 08:38:17 debian obexd[1456]: obexd/client/manager.c:client_manager_init() Module sync loaded
Oct 27 08:38:17 debian obexd[1456]: obexd/client/map.c:map_init()
Oct 27 08:38:17 debian obexd[1456]: obexd/client/driver.c:obc_driver_register() driver 0xaaaaac0c01d8 service MAP registered
Oct 27 08:38:17 debian obexd[1456]: obexd/client/manager.c:client_manager_init() Module map loaded
Oct 27 08:38:17 debian obexd[1456]: obexd/client/bip.c:bip_init()
Oct 27 08:38:17 debian obexd[1456]: obexd/client/driver.c:obc_driver_register() driver 0xaaaaac0c0130 service BIP-AVRCP registered
Oct 27 08:38:17 debian obexd[1456]: obexd/client/manager.c:client_manager_init() Module bip loaded
Oct 27 08:38:17 debian obexd[1456]: obexd/client/pbap.c:name_acquired() org.bluez appeared
Oct 27 08:38:17 debian obexd[1456]: obexd/client/pbap.c:register_profile_reply() Profile /org/bluez/obex/0000112e_0000_1000_8000_00805f9b34fb registered
Oct 27 08:38:17 debian obexd[1456]: obexd/src/manager.c:register_agent() Agent registered
Oct 27 08:38:17 debian urm[859]: [RESTUNE_SIGNAL_REGISTRY] [ERROR] getSignalConfigByIdAndType: Signal with: ID [0x00020001] and Type [0x00000000] not found in the registry. 
Dropping Request.
Oct 27 08:38:17 debian urm[859]: [RESTUNE_SIGNAL_REGISTRY] [ERROR] getSignalConfigByIdAndType: Signal with: ID [0x00020001] and Type [0x00000000] not found in the registry. 
Dropping Request.
Oct 27 08:38:17 debian urm[859]: [RESTUNE_SIGNAL_REGISTRY] [ERROR] getSignalConfigByIdAndType: Signal with: ID [0x00020001] and Type [0x00000000] not found in the registry. 
Dropping Request.
Oct 27 08:38:17 debian pkexec[1481]: pam_unix(polkit-1:session): session opened for user root(uid=0) by debian(uid=1000)
