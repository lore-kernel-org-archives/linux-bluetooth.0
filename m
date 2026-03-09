Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE3C3E51DF
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2026 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773072161; cv=none; b=iQclC3N+0TFnfqXPfJEYFFXTVtQODTJQQ0GzWRMW2o8IHImAOsQnKz6aNT37MVbCAoFASG0Uw3P6MycK9AfI6pzq+Dohfzry95pakWYlrEsRbWqNmEKNSyFdOOvDF7EyAyIYEscOq98YV/TN08QUJ1SfCvu+RJxTjueIDluShKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773072161; c=relaxed/simple;
	bh=YkSOGdaiHZJagHp51LS/gqYLbYGBcaHvvmCdZNRYpPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LUqEljlnnYPKLOIDsMJC5ZwJtIcJ+Et2++w7GgYoyDt4RSWYOeDE3Bn/HZ63b6+J7I4beDQirmVQYs7v9anEln9/clxzHuVRpjxkAO84OpQZxjDgseVPoPJNxMKKBTtu8/iAbtMYBbrCUzWHrG/FgSMxnFaIpJR48yukJWMnxIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id B55D84C4431E83;
	Mon, 09 Mar 2026 17:02:24 +0100 (CET)
Message-ID: <ea9528bd-ccde-4da3-b85b-793e370b4da1@molgen.mpg.de>
Date: Mon, 9 Mar 2026 17:02:23 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Bluetooth: Increase LE connection timeout for
 industrial sensors
To: Dajid Morel <dajidp.morel@gmail.com>, Dajid Morel <dajid.morel@volvo.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org
References: <20260302233756.910702-1-dajid.morel@volvo.com>
 <CABBYNZJtZZ7mHJinJY9ZfhfHbYUC9aEmoRx9ACz5R4HSwepyFg@mail.gmail.com>
 <CAM8DPm26RVUJbgA+Lutqshu+ZqkVtNaVrKdG-k1WdE0rcSe0dQ@mail.gmail.com>
 <CABBYNZKxUJUtZTNe0+ot1JmNDyLzf3x-TyN+TqPz-o5xMmx=6A@mail.gmail.com>
 <CAM8DPm24s+2raquaofgPoroTMECGdKeba7pnDz5X64wN66yjiw@mail.gmail.com>
 <CABBYNZKaNmSPbCpJ-GKu2eSrgd_GcOOWkekHW0OMK8WMLESYWQ@mail.gmail.com>
 <CAM8DPm20Sm1t_NMoWQFZtkmdaiL1ALs8SFMqxe-QtT5wjbp6xA@mail.gmail.com>
 <CABBYNZKmu3b2h2NyhhV7CwmB=h1R9uAe0HXDCP73iAvqzy7AYA@mail.gmail.com>
 <CAM8DPm2z-6xUm3SyFJ9umn4=o9bBov6PhKV0TEDCBc14eMFSew@mail.gmail.com>
 <CABBYNZJZWkEy2D4WW8ODMoU-ZmsT1aN0LccOzdsCxuKnFZHnuA@mail.gmail.com>
 <CAM8DPm1fWn7jovVPgcBrApy_czP0TbnBi=oUZmhjMqDkORv2bw@mail.gmail.com>
 <CABBYNZJ6NNL26BOxV2E6HBA6D3vgOauRQ=75vRcBMA0D-vSEHw@mail.gmail.com>
 <CAM8DPm0rgZEY+aNj8-RJv7JwvMOBQuRu7qt7G+z_OpVL+zk3Gw@mail.gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CAM8DPm0rgZEY+aNj8-RJv7JwvMOBQuRu7qt7G+z_OpVL+zk3Gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Dajid,


Sorry for chiming in. Luiz is the most knowledgeable person in this.

Am 09.03.26 um 11:02 schrieb Dajid Morel:
>> Yeah, you really don't know what you are talking about, there is no
>> timeout on HCI_OP_LE_CREATE_CONN itself, the controller shall generate
>> a command complete immediately and the connection attempt is only
>> interrupted with HCI_OP_LE_CREATE_CONN_CANCEL, so lets say yo want to
>> increase HCI_CMD_TIMEOUT that means HCI_OP_LE_CREATE_CONN_CANCEL
>> cannot be send because it would be pending on HCI_EV_LE_CONN_COMPLETE,
>> anyway I fill like Im wasting my time here.
> 
> Hi Luiz,
> 
> I'll be brief and stick to the logs. Here is the output from a stock
> 5.15 kernel (2s timeout) on the Raspberry Pi 4:
> 
> [bluetooth]# connect E8:C0:B1:D4:A3:3C
> Attempting to connect to E8:C0:B1:D4:A3:3C
> Failed to connect: org.bluez.Error.Failed le-connection-abort-by-local
> 
> The "le-connection-abort-by-local" error is the smoking gun. It proves
> the Host is aborting the sequence, not the peer.
> 
> When I apply my patch (15s timeout) on the exact same hardware:
> 
> - The "abort-by-local" error disappears completely.
> - The connection succeeds 100% of the time.
> - We can read the pressure data.
> 
> I noticed in dmesg that the Broadcom controller is missing its firmware patch:
> [   16.357546] Bluetooth: hci0: BCM: chip id 63
> [   16.360628] Bluetooth: hci0: BCM: features 0x07
> [   16.378604] Bluetooth: hci0: BCM20702A
> [   16.378639] Bluetooth: hci0: BCM20702A1 (001.002.014) build 0000
> [   16.381695] Bluetooth: hci0: BCM: firmware Patch file not found, tried:
> [   16.388662] Bluetooth: hci0: BCM: 'brcm/BCM20702A1-0a5c-21e8.hcd'
> [   16.394969] Bluetooth: hci0: BCM: 'brcm/BCM-0a5c-21e8.hcd'
> 
> This likely makes the controller slower to process sync commands when
> high-latency sensors are advertising nearby. However, the system is
> 100% stable with the 15s timeout patch, even without that firmware.
> 
> If the timeout is truly decoupled, then "le-connection-abort-by-local"
> should not be triggered at exactly 2 seconds. The fact that it is
> proves that the hardcoded limit in hci_sync.c is the blocker.
> 
> Since this is for a Volvo production line, we need a way to support
> these sensors. If you refuse the global constant change, how can we
> avoid this "local abort" in the sync sequence for slow controllers?

As this is the upstream list, it’d really help if you could test with 
6.19, 7.0-rc3 or – best option – with the bluetooth-next tree, just to 
be sure.

It’s definitely great, that you are looking for an upstream solution, so 
please be patient, and I’d really be interested in your test results. 
Depending on these, a way forward can be derived.


Kind regards,

Paul
