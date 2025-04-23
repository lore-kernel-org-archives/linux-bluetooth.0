Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440CB7081C
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 14:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419488; cv=pass; b=CowwZCYMWDL4PfVIGCgBhYpVCLxuMepAtWcIwxP33mDK+qP+DlyHri9IZYhkFBAtqtR0gAHg3CD9HPKawVyFiD69SOX/VSaskTSGJvK2/PnKBgzv8Sl8EpBFonRzmgj1yzEJNGBdc8Ndvd8XmaB5UFm9pa+YlHnTRl9jETXEQ4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419488; c=relaxed/simple;
	bh=quMQB1FYlOA1dgpOce0zYWbiCgzKjK/K1nWf/oilk0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BkNxc7ulTtFPSJ7FtQT9pTP18fjeuNB3fH4DjmPugnVATFDun2pxG6oegicRsEsgto6Z/ExRsa5sve2i+px0CyaYIp29MVd2dbmGel+rKyiQKQCk9qVtj0rI2wWh4+9KfM77PLQ/PSqqfJaa4Akq4D/zDBQ7xszMV3CecauiC1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ludovico.denittis@collabora.com header.b=CVR8UI8B; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ludovico.denittis@collabora.com header.b="CVR8UI8B"
ARC-Seal: i=1; a=rsa-sha256; t=1745419482; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=P6g1E+C4pTZ05rfPiXyzez7ZHosziYA5sIRKKmMAPfJedPoTZV78Q4PMFQITT67LhXBdJRLiMt54m28nBgjI/bucnQB1BksROpzkUmfpOoUKftu15j+i3KSEkAarTX7E0IjysiRMI4EALkleQxE2nXm1gT0jMWqLI+poxtmwprI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745419482; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9Oh29bdF9umjprrvMTO2HuGVbsyIbeVKrtqcXLKBdQg=; 
	b=Oid/7jC7kEDfFrfjoRZA+ab9x0w1nVuarRFN6/vj4/OqblIBhTKMFT5u5BQfX5lBp1omZfd/V09AfpsF5XKKf/DNzxYDbQfXbDuuGtCZqs4p71uLw0Ultt37ED48MuEYQJX6NsSTTIzbIdK+OE65eH1Bx9cZJFEidK4S2AovruE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ludovico.denittis@collabora.com;
	dmarc=pass header.from=<ludovico.denittis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745419482;
	s=zohomail; d=collabora.com; i=ludovico.denittis@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=9Oh29bdF9umjprrvMTO2HuGVbsyIbeVKrtqcXLKBdQg=;
	b=CVR8UI8BpS/rART+T5Vtt/72RFkG9U5pt+RypzNk+KrbCyoG2wytPz6756aTSqm6
	rLlhVypOKsKsiqCSMPqANZ0t/jenEQBxMLbjEg5FnwhsdukTfF5RxCaC15u3X0dEA5r
	xe5uTle2HQEJyzpGFtDkOimSrMYXDVJwtk0l+pas=
Received: by mx.zohomail.com with SMTPS id 1745419481447922.1413768738677;
	Wed, 23 Apr 2025 07:44:41 -0700 (PDT)
Message-ID: <7261a5b7-1c01-40aa-b30b-cb5eaf5bf21f@collabora.com>
Date: Wed, 23 Apr 2025 16:44:38 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 4/5] input: Start the server with sec low and bump
 it when making the connection
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20250421111251.108943-1-ludovico.denittis@collabora.com>
 <20250421111251.108943-5-ludovico.denittis@collabora.com>
 <CABBYNZ+QwX8r_8vU=piJ2AF6i_Us9opDNOe4r+9hM=9Jv0N0Bg@mail.gmail.com>
Content-Language: en-US
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
In-Reply-To: <CABBYNZ+QwX8r_8vU=piJ2AF6i_Us9opDNOe4r+9hM=9Jv0N0Bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Luiz,

On 4/21/25 4:18 PM, Luiz Augusto von Dentz wrote:
> Hi Ludovico,
>
> On Mon, Apr 21, 2025 at 7:14 AM Ludovico de Nittis
> <ludovico.denittis@collabora.com> wrote:
>> BT_IO_SEC_LOW is the only way to allow Sixaxis devices to establish
>> a connection.
>>
>> When BlueZ has been compiled with Sixaxis support enabled, we start the
>> listening input server with BT_IO_SEC_LOW to avoid breaking the Sixaxis
>> support.
>> Then, in `hidp_add_connection()`, we check if either
>> `classic_bonded_only` was disabled or if this device is a Sixaxis. If
>> neither are true, we bump the security back to BT_IO_SEC_MEDIUM, i.e.
>> enforcing encryption.
>>
>> This allows supporting the Sixaxis gamepad without having to change the
>> classic bonded only option.
>> ---
>>   profiles/input/device.c | 6 ++++--
>>   profiles/input/server.c | 7 +++++++
>>   2 files changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/profiles/input/device.c b/profiles/input/device.c
>> index 3627573e7..eb2fb5c8e 100644
>> --- a/profiles/input/device.c
>> +++ b/profiles/input/device.c
>> @@ -1088,8 +1088,10 @@ static int hidp_add_connection(struct input_device *idev)
>>          if (device_name_known(idev->device))
>>                  device_get_name(idev->device, req->name, sizeof(req->name));
>>
>> +       sixaxis_cable_pairing = device_is_sixaxis_cable_pairing(idev->device);
>> +
>>          /* Make sure the device is bonded if required */
>> -       if (classic_bonded_only && !input_device_bonded(idev)) {
>> +       if (classic_bonded_only && !sixaxis_cable_pairing && !input_device_bonded(idev)) {
>>                  error("Rejected connection from !bonded device %s", idev->path);
>>                  goto cleanup;
>>          }
>> @@ -1098,7 +1100,7 @@ static int hidp_add_connection(struct input_device *idev)
>>          /* Some platforms may choose to require encryption for all devices */
>>          /* Note that this only matters for pre 2.1 devices as otherwise the */
>>          /* device is encrypted by default by the lower layers */
>> -       if (classic_bonded_only || idev->type == BT_UHID_KEYBOARD) {
>> +       if (!sixaxis_cable_pairing && (classic_bonded_only || idev->type == BT_UHID_KEYBOARD)) {
>>                  if (!bt_io_set(idev->intr_io, &gerr,
>>                                          BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
>>                                          BT_IO_OPT_INVALID)) {
>> diff --git a/profiles/input/server.c b/profiles/input/server.c
>> index 79cf08a66..73caeb076 100644
>> --- a/profiles/input/server.c
>> +++ b/profiles/input/server.c
>> @@ -273,6 +273,13 @@ int server_start(const bdaddr_t *src)
>>          BtIOSecLevel sec_level = input_get_classic_bonded_only() ?
>>                                          BT_IO_SEC_MEDIUM : BT_IO_SEC_LOW;
>>
>> +#ifdef HAVE_SIXAXIS
>> +       /* Lower security to allow the Sixaxis gamepad to connect. */
>> +       /* Unless classic bonded only mode is disabled, the security level */
>> +       /* will be bumped again for non sixaxis devices in hidp_add_connection() */
>> +       sec_level = BT_IO_SEC_LOW;
>> +#endif
> This is not that great, even if we increase the level at a later stage
> there is no reason to use low security while there are no input
> devices that require such logic, so I'd keep medium and downgrade the
> security only when required (which will probably need to restart the
> listening socket.)

Yeah, makes sense. I just sent a v2 to address this.
Instead of restarting the listening socket I saw that running `bt_io_set()`
was enough to do the trick and re-set the desired security level.


>> +
>>          server = g_new0(struct input_server, 1);
>>          bacpy(&server->src, src);
>>
>> --
>> 2.49.0
>>
>>
>

