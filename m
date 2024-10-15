Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D8B757FC
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 08:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728981964; cv=none; b=MFPfPbVTpubzWLlQBC5zOCnELY1Q4OWnOi6h3YMITC3voqvkYVSDmExKCWh0cWxU+XVE64XH+/vjHtTdCmoZf4AkcOXuDKAjCKISrXj+ueYJCDNo/EtyKQeIn3XTOrWINua6+jhh7LLtdxRzyzLtYfCAT0+izKhRAhgJuKR85JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728981964; c=relaxed/simple;
	bh=7vHIM87eNaX3ejUjqfIM2HsQR797Aj6VtuCHdl+ICYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nsYL/wnuY9Cw+YgWIgA5pP8afEM4GZ5/XAHy8Ec01uVws2IWDZ1NjTBHPdPxso+Jnbxi0WpmJ1RqZZ2h+d4KLAdfURAa/h6iiHLRnZCwOq5IANirzxeG+i19vB+eKrEsIy0p9umLY25faube0U8T6jxztgn3FVlP3mlWLy1BSZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eS1gMytK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eS1gMytK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728981961;
	bh=7vHIM87eNaX3ejUjqfIM2HsQR797Aj6VtuCHdl+ICYE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eS1gMytK/UkljJJVHSCeaQIbsyRBquDiJfBUWJ/am1MjvKN4hx42JaWncX4mjQcV8
	 Xr1JOmxl/FerSNfczs1nQXoAsV3I+2/mWYw2fqffgyTNrVtTnVG0xye0jtlv7FS9u7
	 x5DT7MEtXOoJVM0kFOCppXXGVrMqf4MJYNUR6OjzF8scFdcQRLRM18KoUgdz7sCLJn
	 +HLj727BEmeg6sYkH/1mkQvRwD0GJUATssOcooQ9MJ2JF13h4OfQ8kgYAA6maan0Ln
	 IA2ZZMjkZsIgv9AcB9AMOjAjd8Zz/LE/GghuiGItvNPZcu0Cipc0ErANr7hzwxBNUI
	 1RHvRfgyPMoHA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2AB9417E1167;
	Tue, 15 Oct 2024 10:46:01 +0200 (CEST)
Message-ID: <f0b77d1a-b2b6-46a3-a6a1-44dc601e8584@collabora.com>
Date: Tue, 15 Oct 2024 10:46:00 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] Bluetooth: btmtksdio: Lookup device node only as
 fallback
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Chen-Yu Tsai <wenst@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Sean Wang <sean.wang@kernel.org>,
 linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20241008082721.4004100-1-wenst@chromium.org>
 <CABBYNZ+UGx8TtW+aXZer_j=L79NYEP28+FcSeRqT3BKN7L+CGw@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CABBYNZ+UGx8TtW+aXZer_j=L79NYEP28+FcSeRqT3BKN7L+CGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 08/10/24 15:39, Luiz Augusto von Dentz ha scritto:
> Hi,
> 
> On Tue, Oct 8, 2024 at 4:27 AM Chen-Yu Tsai <wenst@chromium.org> wrote:
>>
>> If the device tree is properly written, the SDIO function device node
>> should be correctly defined, and the mmc core in Linux should correctly
>> tie it to the device being probed.
>>
>> Only fall back to searching for the device node by compatible if the
>> original device node tied to the device is incorrect, as seen in older
>> device trees.
>>
>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> 
> I was hoping to see some Reviewed-by/Tested-by here, were the mediatek
> made aware of these changes?
> 

Sorry I didn't see this patch in my .. rather big .. stack of patches :-D

I can confirm

Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> # 
MT8186 Corsola

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers,
Angelo

>> ---
>> Resending after three and a half months.
>>
>> This follows up on the MT7921S bluetooth binding and DT fixup patches [1].
>> This should not be backported.
>>
>> [1] https://lore.kernel.org/linux-bluetooth/20240412073046.1192744-1-wenst@chromium.org/
>>
>>   drivers/bluetooth/btmtksdio.c | 17 +++++++++++++++--
>>   1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
>> index cc097aedc1e1..a1dfcfe43d3a 100644
>> --- a/drivers/bluetooth/btmtksdio.c
>> +++ b/drivers/bluetooth/btmtksdio.c
>> @@ -1328,6 +1328,8 @@ static int btmtksdio_probe(struct sdio_func *func,
>>   {
>>          struct btmtksdio_dev *bdev;
>>          struct hci_dev *hdev;
>> +       struct device_node *old_node;
>> +       bool restore_node;
>>          int err;
>>
>>          bdev = devm_kzalloc(&func->dev, sizeof(*bdev), GFP_KERNEL);
>> @@ -1411,13 +1413,24 @@ static int btmtksdio_probe(struct sdio_func *func,
>>          if (err)
>>                  bt_dev_err(hdev, "failed to initialize device wakeup");
>>
>> -       bdev->dev->of_node = of_find_compatible_node(NULL, NULL,
>> -                                                    "mediatek,mt7921s-bluetooth");
>> +       restore_node = false;
>> +       if (!of_device_is_compatible(bdev->dev->of_node, "mediatek,mt7921s-bluetooth")) {
>> +               restore_node = true;
>> +               old_node = bdev->dev->of_node;
>> +               bdev->dev->of_node = of_find_compatible_node(NULL, NULL,
>> +                                                            "mediatek,mt7921s-bluetooth");
>> +       }
>> +
>>          bdev->reset = devm_gpiod_get_optional(bdev->dev, "reset",
>>                                                GPIOD_OUT_LOW);
>>          if (IS_ERR(bdev->reset))
>>                  err = PTR_ERR(bdev->reset);
>>
>> +       if (restore_node) {
>> +               of_node_put(bdev->dev->of_node);
>> +               bdev->dev->of_node = old_node;
>> +       }
>> +
>>          return err;
>>   }
>>
>> --
>> 2.47.0.rc0.187.ge670bccf7e-goog
>>
> 
> 

