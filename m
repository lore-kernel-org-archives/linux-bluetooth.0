Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A1C23BD03;
	Mon, 24 Feb 2025 13:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403968; cv=none; b=VP+8YfA/b+PG1pZ7fXVul3lzvisBvYb0U8NbxynN+1NPxZ737lO/u1I+3bZGofy3yhVzN3KvjoStTaH9/EsIfDPSUUWtpUibY3Jx2t7CW/Khj5DBaIBrW+ByxLE3qmJFGEwZ+UrWxxRoXibi3LM553id50hcJbbZFGR+Odb8K2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403968; c=relaxed/simple;
	bh=ucvswt2RfKlyENyYHbtBjH3zk3+zhRZ6Z1OFUYp+Ibk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZlexDvHcZ04mc5r0VdPD+JEPodB40gKBHw47E+BaQzLn+1F3nwNtczZ22FLNsksWN0zGDIUsKgvD0fzSnugrd+I1rb/JMDlw7QeBsmQ9XpcCeElIGzrnn+WRG0bk8aqi4J4515rG2nPVb4EsiabDOKIbImw4b0yAHuesMkt2OCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 10B2361E64847;
	Mon, 24 Feb 2025 14:32:31 +0100 (CET)
Message-ID: <925dc4ea-f244-4758-9cab-f3d0439f0b7b@molgen.mpg.de>
Date: Mon, 24 Feb 2025 14:32:30 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: Configure altsetting for USER_CHANNEL
To: Hsin-chen Chuang <chharry@google.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 gregkh@linuxfoundation.org, chromeos-bluetooth-upstreaming@chromium.org,
 Hsin-chen Chuang <chharry@chromium.org>,
 Marcel Holtmann <marcel@holtmann.org>, Ying Hsu <yinghsu@chromium.org>,
 linux-kernel@vger.kernel.org
References: <20250224022447.1141413-1-chharry@google.com>
 <2ab0d1c5-1bfe-4ef3-b23d-fee0ae1d7ad6@molgen.mpg.de>
 <CADg1FFfBNSZSAV6Ygudmr959X2VsfThZaTMAj_OZ24B0TisDog@mail.gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CADg1FFfBNSZSAV6Ygudmr959X2VsfThZaTMAj_OZ24B0TisDog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Hsin-chen,


Am 24.02.25 um 14:06 schrieb Hsin-chen Chuang:

> On Mon, Feb 24, 2025 at 4:42 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:

>> Am 24.02.25 um 03:24 schrieb Hsin-chen Chuang:
>>> From: Hsin-chen Chuang <chharry@chromium.org>
>>>
>>> Automatically configure the altsetting for USER_CHANNEL when a SCO is
>>> connected or disconnected. This adds support for the USER_CHANNEL to
>>> transfer SCO data over USB transport.
>>
>> Should you re-spin, it’d be great if you elaborated a little more.
>> Especially for the motivation. It’d be also great, if you added how to
>> test this.
> 
> Sure and I'll update this to the commit message in the next patch version.
> 
> The motivation is to enable the HCI_USER_CHANNEL user to send out SCO
> data through USB Bluetooth chips, which is mainly used for
> bidirectional audio transfer (voice call).
> This was not capable because
> - Per Bluetooth Core Spec v5, Vol 4, Part B, 2.1, the corresponding
>    alternate setting should be set based on the air mode in order to
>    transfer SCO data.
> - The Linux Bluetooth HCI_USER_CHANNEL exposes the Bluetooth Host
>    Controller Interface to the user space, which is something above the
>    USB layer. The user space is not able to configure the USB alt while
>    keeping the channel open.
> 
> This patch intercepts the specific packets that indicate the air mode
> change, and configure the alt setting transparently in btusb.
> I tested this patch on ChromeOS devices which are now using the
> Android Bluetooth stack built on top of the HCI_USER_CHANNEL. The USB
> Bluetooth models could work without a customized kernel.

Awesome. Great explanation. It’d be great to have in the commit message. 
I am looking forward to the next iteration.

>>> Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control USB alt setting")
>>> Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
>>> ---
>>>
>>>    drivers/bluetooth/btusb.c | 224 +++++++++++++++++++++++++++++++-------
>>>    1 file changed, 186 insertions(+), 38 deletions(-)
>>
>> […]

> --
> Best Regards,
> Hsin-chen

Unrelated, and only if you care: Your signature delimiter is missing a 
space at the end [1].


Kind regards,

Paul


[1]: https://en.wikipedia.org/wiki/Signature_block#Standard_delimiter
