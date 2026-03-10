Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6085D38D6AB
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 14:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773151466; cv=none; b=RpakbCfimZTITxnQpBkpxPXMnq9u2S2WF4vHjo3LjWowHDCFDXz2WDVzYKqNAd+XcbyEESMHOQJnROKsYzUyFF1fb0Mj6hzkIw9R5ihi0/m0POTqcTVgW8TxaUIvGrdW79CYg7HrWQPfSCd6FGcEdOQLKZvMgVr2qLe5Ii31vLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773151466; c=relaxed/simple;
	bh=lsGEuUQxalW8Djhqqxx7ng0yD2ezrsGQkru2T7jfURs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tm3+wLWzMHF23OrnzlizaSzolNUPeD7VrLYnUO9Hc7V0V4ar1Mp6BVQ8dWHUIj6AW2wFMZVB7E0yGBi3Gk9r0lNMq4BhioW4hsoeDMmJEmYwaf5tQvDCUE1GygRGEGkdsh9eMslP3jukAi46qukrunnt6ORnmdptKOCeu0oHYhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.13.172] (g427.RadioFreeInternet.molgen.mpg.de [141.14.13.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id C06D34C4431ED8;
	Tue, 10 Mar 2026 15:04:17 +0100 (CET)
Message-ID: <72946edd-fad1-4201-8c23-f36cfe925cb7@molgen.mpg.de>
Date: Tue, 10 Mar 2026 15:04:17 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Bluetooth: Increase LE connection timeout for
 industrial sensors
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Dajid Morel <dajidp.morel@gmail.com>, Dajid Morel
 <dajid.morel@volvo.com>, linux-bluetooth@vger.kernel.org
References: <20260302233756.910702-1-dajid.morel@volvo.com>
 <CABBYNZKaNmSPbCpJ-GKu2eSrgd_GcOOWkekHW0OMK8WMLESYWQ@mail.gmail.com>
 <CAM8DPm20Sm1t_NMoWQFZtkmdaiL1ALs8SFMqxe-QtT5wjbp6xA@mail.gmail.com>
 <CABBYNZKmu3b2h2NyhhV7CwmB=h1R9uAe0HXDCP73iAvqzy7AYA@mail.gmail.com>
 <CAM8DPm2z-6xUm3SyFJ9umn4=o9bBov6PhKV0TEDCBc14eMFSew@mail.gmail.com>
 <CABBYNZJZWkEy2D4WW8ODMoU-ZmsT1aN0LccOzdsCxuKnFZHnuA@mail.gmail.com>
 <CAM8DPm1fWn7jovVPgcBrApy_czP0TbnBi=oUZmhjMqDkORv2bw@mail.gmail.com>
 <CABBYNZJ6NNL26BOxV2E6HBA6D3vgOauRQ=75vRcBMA0D-vSEHw@mail.gmail.com>
 <CAM8DPm0rgZEY+aNj8-RJv7JwvMOBQuRu7qt7G+z_OpVL+zk3Gw@mail.gmail.com>
 <ea9528bd-ccde-4da3-b85b-793e370b4da1@molgen.mpg.de>
 <CAM8DPm20ECFZF6v19SrLwA8o92YXY_dsWvOyFDOuym5S7P2kCg@mail.gmail.com>
 <CABBYNZ+ePfwbc2NS-hG5g98trXOvUqRtp-ZiXD2crrvx-Lygzg@mail.gmail.com>
 <CAM8DPm1Ca6CDx3nOeJhEvTiD0510RteKd5Mw=Fg8hkZuA4oRKg@mail.gmail.com>
 <CABBYNZKtAkftUyyo4B5D7ADN80as3rE5dHHQcKoWa7tmUfBzgw@mail.gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CABBYNZKtAkftUyyo4B5D7ADN80as3rE5dHHQcKoWa7tmUfBzgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Dajid, dear Luiz,


Am 10.03.26 um 14:47 schrieb Luiz Augusto von Dentz:

>> Trace Analysis (failure_with_firmware.log attached): Here is the
>> relevant excerpt showing the host aborting the sequence on the 5.15
>> kernel:
>>
>> < HCI Command: LE Create Connection (0x08|0x000d) plen 25 #65 [hci0]
>> 13.006556 > HCI Event: Command Status (0x0f) plen 4 #66 [hci0] 13.009473
>> LE Create Connection (0x08|0x000d) ncmd 1 Status: Success (0x00) […] <
>> HCI Command: LE Create Connectio.. (0x08|0x000e) plen 0 #88 [hci0]
>> 17.048391 > HCI Event: Command Complete (0x0e) plen 4 #89 [hci0]
>> 17.052037 LE Create Connection Cancel (0x08|0x000e) ncmd 1 Status:
>> Success (0x00) > HCI Event: LE Meta Event (0x3e) plen 19 #90 [hci0]
>> 17.054039 LE Connection Complete (0x01) Status: Unknown Connection
>> Identifier (0x02)
> 
> Ok, so it is actually cancelling after 4 seconds, not 2 seconds as you
> repeatedly blabbed about so in the end it doesn't correspond to
> HCI_CMD_TIMEOUT but probably something else that sets 4 seconds.
> 
>> The host systematically aborts the connection attempt after exactly 4.04
>> seconds (17.048s - 13.006s).
>>
>> You mentioned: “On the recent kernels the timeout is configurable.”
>>
>> Could you point me to the specific commit/patchset or API that
>> introduced this configurable timeout?
> 
> It is the third time already:
> 
> https://github.com/bluez/bluetooth-next/commit/a56a1138cbd85e4d565356199d60e1cb94e5a77a

This entered v5.17-rc7.

> But you may also need the following:
> 
> https://github.com/bluez/bluetooth-next/commit/bf98feea5b65ced367a871cf35fc044dedbcfb85

This entered v6.10-rc1.

Luiz, would it make sense to backport both commits to the longterm 
stable support (LTS) series?


Kind regards,

Paul
