Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA29262FF8
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747733204; cv=pass; b=s1skk9Qu7W4lUnw62fzX7ITzdtmBNFwqT1m3PSJZw/Sb0FHcJzKxXnpNAmIubAqala/46LqXWcAlDRzN+dwSOBBaJJIT7G2S8sL92OEnqb8wo2DAo0rFKUeqDJ7Fd/t9uzFfGkPfh330a8oluGKfZBqet9sVdDQbPGodpIq0c58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747733204; c=relaxed/simple;
	bh=6Zd9W5yZ52twaCByoKu7OQXwbuX2iDUIO55qKGf4fXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+Z8k6M/ZGuWypHw49if+7yxC7PkSHi5qsr9CZuYNE+6tnE2YRe204ZaXVXhp5nQ5CCVBpnuw5bTHf+p03uUISRL/XqQd8B3lDkxPXk8Mppep0AgGHDnkWSZ43S599Vpel/vv8pT1PLXwxX1DOXIseG5vvCiZUM82qYjkZCkCt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b=koFSFO+m; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b="koFSFO+m"
ARC-Seal: i=1; a=rsa-sha256; t=1747733199; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GwrjGkXVmd/ExDoNby6fGbYXMvEVKAzh4fzzSSJbf12nTBok4ehniXRRSsO2JK/LIWMXdMJMVk/9GM3iUJjjpkrY+mkNOQTw7ZuIJ3eHmvFX3J+hukx8CbLHXR8ghk05Fz97XKmJ0ZbHI6Vrjj4dM2fjh5zn3wiVsD6dZDO0BGo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1747733199; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Cwih+sax39Gtxf73pXttE4Gmks+c2MgNp7e2EozBbD8=; 
	b=R8oZtsvoBsWwoaMaVtIhV/f+qugQ3ZLGVHKTK8G6zfn0GZVHhfRe6WWtTu5S3bM9WvqjbZAN6iAksxkOwKenuYJImjMgGprdw+CZbvrizqQAesC7iPIL/u0pxxVI6k8ghs7q3o+Q5hE1Yx1lmZngInyj3aTpmPuoKTi5tLFsugQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=frederic.danis@collabora.com;
	dmarc=pass header.from=<frederic.danis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747733199;
	s=zohomail; d=collabora.com; i=frederic.danis@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Cwih+sax39Gtxf73pXttE4Gmks+c2MgNp7e2EozBbD8=;
	b=koFSFO+mkoyA74YmI5n9hOEtJah2DneTIqlUHfKHpvRriVhnSzUC29LkYzEHkDPF
	J96v4RAuqAvqsrsQ2rQ7nGI65IQk4iVlxQIHWNyxptjhgVfvYCW6BqTmaPJiGzoplop
	DryYSQ/fyq7mb5kuftkTMyc5YtuvbcoZF8QTp5sQ=
Received: by mx.zohomail.com with SMTPS id 1747733197452725.1006077921454;
	Tue, 20 May 2025 02:26:37 -0700 (PDT)
Message-ID: <2f5f021c-5e62-4af0-abcc-3c46ba898c53@collabora.com>
Date: Tue, 20 May 2025 11:26:35 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 2/3] doc/device: Add Disconnected signal
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20250519161412.107904-1-frederic.danis@collabora.com>
 <20250519161412.107904-3-frederic.danis@collabora.com>
 <CABBYNZL2LBBSMvBDONLf6H8-re26YHKBxsnQwNbX8kNuiq8m_Q@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
In-Reply-To: <CABBYNZL2LBBSMvBDONLf6H8-re26YHKBxsnQwNbX8kNuiq8m_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Luiz,

On 19/05/2025 18:44, Luiz Augusto von Dentz wrote:
> Hi Frédéric,
>
> On Mon, May 19, 2025 at 12:18 PM Frédéric Danis
> <frederic.danis@collabora.com> wrote:
>> ---
>>   doc/org.bluez.Device.rst | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
>> index 80501eddd..6229f95ad 100644
>> --- a/doc/org.bluez.Device.rst
>> +++ b/doc/org.bluez.Device.rst
>> @@ -155,6 +155,23 @@ array{array{byte}} GetServiceRecords() [experimental]
>>          :org.bluez.Error.NotConnected:
>>          :org.bluez.Error.DoesNotExist:
>>
>> +Signals
>> +-------
>> +
>> +void Disconnected(string reason)
>> +````````````````````````````````
>> +
>> +       This signal is launched when a device is disconnected with the reason of
>> +       the disconnection.
>> +
>> +       Possible reasons:
>> +
>> +       :disconnection-unknown:
>> +       :disconnection-timeout:
>> +       :disconnection-local-host:
>> +       :disconnection-remote:
>> +       :disconnection-local-suspend:
> Perhaps it would be better to use to the actual HCI code instead of
> converting it to string, since I suspect application using this signal
> may want to recover the actual error to do some sort of reconnecting
> policy, etc, or having them both in case the client just wants to
> print it.

I will update the patch to use the numerical value.

But, the reason provided by MGMT_EV_DEVICE_DISCONNECTED is not the
HCI code but a mgmt value translated in net/bluetooth/hci_event.c
(https://github.com/bluez/bluetooth-next/blob/master/net/bluetooth/hci_event.c#L3366)

-- 
Frédéric Danis
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
Registered in England & Wales, no. 5513718

