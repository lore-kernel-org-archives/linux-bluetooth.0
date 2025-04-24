Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE692DF68
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745505475; cv=pass; b=VLrITRk0/hBSHk5Xrqr22Te8TqadHUjbRb+SMmb/oGk5NJJGWB+GH5ZG+Y4gAr2mfVBjYbmpm/cU3NEI0lpeyNHQbNfcV55x7GQ1SWJimgN0Cr6A2mPWPcqSLIUjggGUywdkuJ4/I5n6S7eKBQXAJseH3FX8/CMuC/XoYMfGNSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745505475; c=relaxed/simple;
	bh=H3lcnLBk3YNz/T0KwMdXUMS7/Sch/YG0yAXoCrFeLbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cTeQzFxxcvD9mXYQ3kEuVO1E+TG3Z2i9ZsVNLJyMiT24xKL+rs6wYvYf9Ba1fjMBeu5DKpBasDtfzKxnE3BByCGbbnJjpn4vUM1qsRWaRraWjkgl0PxBhvWCIOufVbFlsAFGduv2U8iNiZFZ6c2PaFin0LO9puh51nTgXprzCfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ludovico.denittis@collabora.com header.b=WMz9t/bi; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ludovico.denittis@collabora.com header.b="WMz9t/bi"
ARC-Seal: i=1; a=rsa-sha256; t=1745505469; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GjhXoZkvA3Ep9tZHnGrdE41IXuxPv6I68qa4VsQNEU+NQbtwtDniT4YUggPWXjwRXvREEWUsSX8m187a48m9KWahf8j6gozt3EJvgrQHkA78I8tr18JhKMzkIPD56Db4s6ZTJOR71dD0Ruqbu3sJlgVtDC3UTv2uFRSzGTFFVMM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745505469; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zZo9naSC3X/75tHaVf3zumwp6LPhAabawEFaIOvHzg4=; 
	b=YVzPex3MJxEq4swph/UZOtWldaOumKvNqLjsnNcyKNATBnn2Y9hy45kAHGAFDE6LJp/T5UkDezf36hiaC3+T2ge2AwtiCNzEIZVCKjMJQn7ZW8VZyyUmQQ9YXL6Ywkduq17BIfOkZCOk/yViFCC/QEx61TIVge4TcOYNw20+TCw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ludovico.denittis@collabora.com;
	dmarc=pass header.from=<ludovico.denittis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745505469;
	s=zohomail; d=collabora.com; i=ludovico.denittis@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=zZo9naSC3X/75tHaVf3zumwp6LPhAabawEFaIOvHzg4=;
	b=WMz9t/bieBvmtVoP4jKvbhHBsomZP+yTG7FS8MOqCxPxMv1eGjIlojagCQ84eaJM
	DvdWHEsercHoYK/AfHE13qq34FI6pNvhtI3IOsTibUKWkNXTJ6Caxf7vfSOj737taTz
	KPI2PzSoy+rpE6EJvwuYH3qSG+S9jdOsHS/EVOyQ=
Received: by mx.zohomail.com with SMTPS id 174550546682263.03066480900691;
	Thu, 24 Apr 2025 07:37:46 -0700 (PDT)
Message-ID: <62ec9d1f-b3ff-4f3d-8e10-e43c50e9920f@collabora.com>
Date: Thu, 24 Apr 2025 16:37:44 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v2 8/8] input: Validate the Sixaxis HID report
 descriptor
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20250423144020.358828-1-ludovico.denittis@collabora.com>
 <20250423144020.358828-9-ludovico.denittis@collabora.com>
 <CABBYNZJ4+=zmArfh6bckzH-9z0HwV9besE1xM3OcjZbSh+b=1A@mail.gmail.com>
Content-Language: en-US
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
In-Reply-To: <CABBYNZJ4+=zmArfh6bckzH-9z0HwV9besE1xM3OcjZbSh+b=1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Luiz,

On 4/23/25 4:56 PM, Luiz Augusto von Dentz wrote:
> Hi Ludovico,
>
> On Wed, Apr 23, 2025 at 10:41 AM Ludovico de Nittis
> <ludovico.denittis@collabora.com> wrote:
>> Given that the Sixaxis devices can't work with encryption, i.e. they
>> only work with BT_IO_SEC_LOW, this makes it harder to notice if the
>> device we are talking to is the expected Sixaxis gamepad or an impostor.
>>
>> To reduce the possible attack surface, we ensure that the report
>> descriptor that the device provided resembles what a real Sixaxis
>> gamepad should have. E.g. it should only have Usages for `Joystick`,
>> `Pointer` etc... and nothing unexpected like `Keyboard`.
>> ---
>>   profiles/input/device.c | 71 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 71 insertions(+)
>>
>> diff --git a/profiles/input/device.c b/profiles/input/device.c
>> index 9f05757a6..6f538759b 100644
>> --- a/profiles/input/device.c
>> +++ b/profiles/input/device.c
>> @@ -1062,9 +1062,72 @@ static gboolean encrypt_notify(GIOChannel *io, GIOCondition condition,
>>          return FALSE;
>>   }
>>
>> +static bool validate_sixaxis_rd_data(const uint8_t *rd_data, uint16_t rd_size)
>> +{
>> +       uint16_t i;
>> +       size_t data_size = 0;
>> +
>> +       for (i = 0; i < rd_size; i += 1 + data_size) {
>> +               uint8_t b = rd_data[i];
>> +
>> +               /* Long items are reserved for future use, HID 1.11 Section 6.2.2.3 */
>> +               if (b == 0xFE) {
>> +                       DBG("The sixaxis HID report descriptor has an unexpected long item");
>> +                       return false;
>> +               }
>> +
>> +               /* Extract data following the HID 1.11 Section 6.2.2.2 */
>> +               uint8_t bSize = b & 0x03;
>> +               uint8_t bType = (b >> 2) & 0x03;
>> +               uint8_t bTag = (b >> 4) & 0x0F;
>> +               data_size = bSize == 3 ? 4 : bSize;
>> +
>> +               if ((i + 1 + data_size) > rd_size)
>> +                       break;
>> +
>> +               const uint8_t *data = &rd_data[i + 1];
>> +
>> +               if (bType == 1 && bTag == 0x0 && data_size >= 1) {
>> +                       /* Usage Page (Generic Desktop) */
>> +                       if (data_size == 1 && data[0] == 0x01)
>> +                               continue;
>> +
>> +                       /* Usage Page (Button) */
>> +                       if (data_size == 1 && data[0] == 0x09)
>> +                               continue;
>> +
>> +                       /* Usage Page (Vendor Defined Page 1) */
>> +                       if (data_size == 2 && data[0] == 0x00 && data[1] == 0xFF)
>> +                               continue;
>> +
>> +                       DBG("The sixaxis HID report descriptor has an unexpected Usage Page: 0x%02X", data[0]);
>> +                       return false;
>> +               }
>> +
>> +               if (bType == 2 && bTag == 0x0 && data_size >= 1) {
>> +                       /* Usage (Joystick) */
>> +                       if (data_size == 1 && data[0] == 0x04)
>> +                               continue;
>> +
>> +                       /* Usage (Pointer) */
>> +                       if (data_size == 1 && data[0] == 0x01)
>> +                               continue;
>> +
>> +                       /* Axis usages, e.g. Usage (X) */
>> +                       if (data_size == 1 && data[0] >= 0x30 && data[0] <= 0x35)
>> +                               continue;
>> +
>> +                       DBG("The sixaxis HID report descriptor has an unexpected Usage: 0x%02X", data[0]);
>> +                       return false;
>> +               }
>> +       }
>> +       return true;
>> +}
> The code above shall probably be placed in the sixaxis plugin, so it
> checks if all the reports is proper and only then set cable pairing is
> complete, so we don't have to check on every connection.

I was under the wrong impression that a device could update its report 
at every connection.
If this only happens at pairing time, then doing the check there is 
definitely better.

And actually, in that case, it shouldn't be needed at all for the 
sixaxis because apparently
we manually replace it already with `btd_device_set_record()` if we are 
in the
`CABLE_PAIRING_SIXAXIS` situation.

I'm gonna follow up with a v3 in a few minutes.

>>   static int hidp_add_connection(struct input_device *idev)
>>   {
>>          struct hidp_connadd_req *req;
>> +       bool sixaxis_cable_pairing;
>>          GError *gerr = NULL;
>>          int err;
>>
>> @@ -1090,6 +1153,14 @@ static int hidp_add_connection(struct input_device *idev)
>>
>>          sixaxis_cable_pairing = device_is_sixaxis_cable_pairing(idev->device);
>>
>> +       /* The Sixaxis devices must use the security level BT_IO_SEC_LOW to work. */
>> +       /* We reduce the attack surface by ensuring that the report descriptor only */
>> +       /* contains the expected Usages that a real Sixaxis gamepad has */
>> +       if (sixaxis_cable_pairing && !validate_sixaxis_rd_data(req->rd_data, req->rd_size)) {
>> +               error("The sixaxis HID SDP record has unexpected entries, rejecting the connection to %s", idev->path);
>> +               goto cleanup;
>> +       }
>> +
>>          /* Make sure the device is bonded if required */
>>          if (!sixaxis_cable_pairing && classic_bonded_only && !input_device_bonded(idev)) {
>>                  error("Rejected connection from !bonded device %s", idev->path);
>> --
>> 2.49.0
>>
>>
>

