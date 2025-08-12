Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D89B2F659F
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014283; cv=pass; b=LKrR3ggvYz3g+xKn1KojyUdkSUwO3CGUb/9/CQUwEtH9+vhLWglxpYP7Ht6SESqAeEBmAT6PZEu6pOrrkwA3IcVs1eJTP8l+rASFsEITntDXU2IG+IyM8CYoXxEtmzohn+D2e9reR8ehXMZJ9bffeDKHxnnxg3x2z4KTc2tE5JE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014283; c=relaxed/simple;
	bh=a7grJUL7cteUsEp5oNL/ZRBFk6G+Iu6j8KVULLhrzrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b7nEzG5uX1173m6ihM58zukL1aFy/WV9cKjpIc0h5VvgymJSCFYYiPD4DgVxf3rqNQIm4u++7Noc9q7BCeC8UdZYqOg0bM/Y0fXzZgHocTaXoEExBL5uYZtWcuDeW1qW5R6+a8tgAqdt5s1XW+iA6bJ9sveUuFu7ceqXm17T9pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ludovico.denittis@collabora.com header.b=BkmLQ7c2; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ludovico.denittis@collabora.com header.b="BkmLQ7c2"
ARC-Seal: i=1; a=rsa-sha256; t=1755014267; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PvZpk9h/C9PA1Fm8iPMqtR6dykNdUdv7hCPEGwoowiAQqO1lX55+jMrvJy2PNO8wlAxC/hEhRaaRr6Xt5xLgoYEWFQtpon+XbFrLko7z7nRVglgEcHs26Rly7PpiaDNHvX9CksTCV8VoZUIE0WsscfbkSh2v9Q+zTwrZZcqZPtc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755014267; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IjXs0/cxuHY6A8AlpkUXOJgcPg+tL/UinlfbFdg8w/I=; 
	b=gYOD1jdjmhAOhsvGqlB2t/7wxda7o0GGDHMgGXggbUMGz6uPbD6cB6CvyO4puGHpI/0u1Kja6dogd8dEpwfsCoHcK3GGgjCpDzwiiH6nFkkL5tH0ncAeWRPsSSaRVghzEdFv3eyobjKQh6c7phFWcYpBJ6PPL2xMHEwkLFPrEFc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ludovico.denittis@collabora.com;
	dmarc=pass header.from=<ludovico.denittis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755014267;
	s=zohomail; d=collabora.com; i=ludovico.denittis@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=IjXs0/cxuHY6A8AlpkUXOJgcPg+tL/UinlfbFdg8w/I=;
	b=BkmLQ7c2d22bHhs2RlO3F3n7xZM1EQZTtyHLQ5fCMF1JotrU/t1sU3S3BKkuX8vj
	TLE95VzHZ4Otv7T+r131h/xAYqQGSfQgkW6JKhr4VeiWKDz6qZEwWzBVSEaEx8JC9wm
	c3aTDqvO++EFdyPBwJopdpkTMibpEhSK9v/bEEQo=
Received: by mx.zohomail.com with SMTPS id 1755014263903615.3113471073292;
	Tue, 12 Aug 2025 08:57:43 -0700 (PDT)
Message-ID: <461a8ede-e22e-4843-97ed-79ccf2a3630e@collabora.com>
Date: Tue, 12 Aug 2025 17:57:41 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Bluetooth: hci_event: Treat UNKNOWN_CONN_ID on
 disconnect as success
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org
References: <20250812141028.509783-1-ludovico.denittis@collabora.com>
 <20250812141028.509783-2-ludovico.denittis@collabora.com>
 <13a10b21-63ae-4606-ad5d-e5d48870da22@molgen.mpg.de>
Content-Language: en-US
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
In-Reply-To: <13a10b21-63ae-4606-ad5d-e5d48870da22@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Paul,

On 8/12/25 5:20 PM, Paul Menzel wrote:
> Dear Ludovico,
>
>
> Thank you for your patch.
>
> Am 12.08.25 um 16:10 schrieb Ludovico de Nittis:
>> When the host sends an HCI_OP_DISCONNECT command, the controller may
>> respond with the status HCI_ERROR_UNKNOWN_CONN_ID. E.g. this can happen
>> on resume from suspend, if the link was terminated by the remote device
>> before the event mask was correctly set.
>>
>> Currently, the hci_cs_disconnect function treats any non-zero status
>> as a command failure. This can be misleading because the connection is
>> indeed being terminated and the controller is confirming that is has no
>> knowledge of that connection handle. Meaning that the initial request of
>> disconnecting a device should be treated as done.
>>
>> With this change we allow the function to proceed, following the success
>> path, which correctly calls `mgmt_device_disconnected` and ensures a
>> consistent state.
>
> Although part of your issue referenced below, I’d love to see the 
> reproducer in the commit message, should you resend.

Sure, in the v2 I added the btmon snippet in the commit message.

>> Link: https://github.com/bluez/bluez/issues/1226
>> Signed-off-by: Ludovico de Nittis <ludovico.denittis@collabora.com>
>> ---
>>   net/bluetooth/hci_event.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index fe7cdd67a..6c67dfa13 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -2703,7 +2703,7 @@ static void hci_cs_disconnect(struct hci_dev 
>> *hdev, u8 status)
>>       if (!conn)
>>           goto unlock;
>>   -    if (status) {
>> +    if (status && status != HCI_ERROR_UNKNOWN_CONN_ID) {
>>           mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
>>                          conn->dst_type, status);
>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
>
> Kind regards,
>
> Paul

