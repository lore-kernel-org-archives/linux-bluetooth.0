Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF28D211A2A
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 09:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747733538; cv=pass; b=n41QE5JDEYOKY38yzjiVeWTVsZ657Q+qb3kjNC+iQB630o+KWvoAlEYWKZrfGm/0qHLMJj7yy0XANJsB7ELQJ8At8D/R+WFBomRPgH/AxWilBR8pEx87KEd3mnVsBqO/cq+L0DF2bMCHRAYNScewMDqjjrNYTEhZuY/ctvU/Xhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747733538; c=relaxed/simple;
	bh=g2as5erpncjO3Lju/tyQBD/GdTFXSlyMmJrl5iiB/wE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BwN/u93vdd/9WJZe4Pcp79WrXVe82lwiB+S6nfk/RHHb2P5+U6zQmzhO7vi2FofdJRzZURwUV3ptxQWFfb5byoB3Gt8ksA7biFnK0mIa98ArNtreATrrK8Nvfh7ky7rURdsG+jLZrkJ999GSoT1xaqN1OoixL9vTR8SzRyDGP2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b=RTh1dXZ6; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b="RTh1dXZ6"
ARC-Seal: i=1; a=rsa-sha256; t=1747733525; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LFQSuMvS9CUUXAVI5pFWUTrisKQdgIgxwETyG5cJzpP9QrnZ/6MGMD/zxBkX+RLAOovqykwANE25wEyQopYdke/7Tb4Z94JdWFvakpYee8saps6Lf6IZYRTktXpDhEIf351cH2j9ZKYQpPG1gjEsQhn/4V/QN0w/zsLxwUfZutY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1747733525; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rTsFDfR/amF7VakD77aMPYVcXg4ZwQHbIpGfXxRVYbE=; 
	b=SyaJoKlnVlbLKunzoxtYKXDpjwQZ7cRgOHtZuvUKj8ZUCh5hyo6C1/3n6EIagNSJP61AGQE/MktzBodd7TzE2FsYx7vtQJUDe0OaEWF8MCt+0CvIU27LQ1smK6+6e1TPl7IsSOmiEwjMlz8/07s4Ak30+LYyRUFebdl8K3AhJFA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=frederic.danis@collabora.com;
	dmarc=pass header.from=<frederic.danis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747733525;
	s=zohomail; d=collabora.com; i=frederic.danis@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=rTsFDfR/amF7VakD77aMPYVcXg4ZwQHbIpGfXxRVYbE=;
	b=RTh1dXZ6/65KBLeKEIgaAYyMZDn0el2zJ7wM2NZ6TDFZv4kN2WhLrhurARKekKKf
	eD49CQjEvIDe5t5CTfrcJud8MOc3Hi+O6p+gE1y/uVTuYDl4xSlAYqz6xLV5IjATWnJ
	J9ZYdxLCeRE9LGAQ5SlViwZAVomvflg7lAveUqOg=
Received: by mx.zohomail.com with SMTPS id 1747733523895982.4170350838187;
	Tue, 20 May 2025 02:32:03 -0700 (PDT)
Message-ID: <6acf1b43-77f6-4484-8af6-5fe492e6ec6e@collabora.com>
Date: Tue, 20 May 2025 11:32:02 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 2/3] doc/device: Add Disconnected signal
To: Bastien Nocera <hadess@hadess.net>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20250519161412.107904-1-frederic.danis@collabora.com>
 <20250519161412.107904-3-frederic.danis@collabora.com>
 <CABBYNZL2LBBSMvBDONLf6H8-re26YHKBxsnQwNbX8kNuiq8m_Q@mail.gmail.com>
 <d4c4cb4cc03b23f21ac9e9c5041937ccfc3f81f5.camel@hadess.net>
Content-Language: en-US
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
In-Reply-To: <d4c4cb4cc03b23f21ac9e9c5041937ccfc3f81f5.camel@hadess.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Bastien,

On 19/05/2025 21:22, Bastien Nocera wrote:
> On Mon, 2025-05-19 at 12:44 -0400, Luiz Augusto von Dentz wrote:
>> Hi Frédéric,
>>
>> On Mon, May 19, 2025 at 12:18 PM Frédéric Danis
>> <frederic.danis@collabora.com> wrote:
>>> ---
>>>   doc/org.bluez.Device.rst | 17 +++++++++++++++++
>>>   1 file changed, 17 insertions(+)
>>>
>>> diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
>>> index 80501eddd..6229f95ad 100644
>>> --- a/doc/org.bluez.Device.rst
>>> +++ b/doc/org.bluez.Device.rst
>>> @@ -155,6 +155,23 @@ array{array{byte}} GetServiceRecords()
>>> [experimental]
>>>          :org.bluez.Error.NotConnected:
>>>          :org.bluez.Error.DoesNotExist:
>>>
>>> +Signals
>>> +-------
>>> +
>>> +void Disconnected(string reason)
>>> +````````````````````````````````
>>> +
>>> +       This signal is launched when a device is disconnected with
>>> the reason of
>>> +       the disconnection.
>>> +
>>> +       Possible reasons:
>>> +
>>> +       :disconnection-unknown:
>>> +       :disconnection-timeout:
>>> +       :disconnection-local-host:
>>> +       :disconnection-remote:
>>> +       :disconnection-local-suspend:
>> Perhaps it would be better to use to the actual HCI code instead of
>> converting it to string, since I suspect application using this
>> signal
>> may want to recover the actual error to do some sort of reconnecting
>> policy, etc, or having them both in case the client just wants to
>> print it.
> If there are applications using those signals (I'm guessing, Bluetooth
> settings apps), whatever the format of the error, could we have an
> expected behaviour associated with individual error types?

This could be used by client apps like Bluetooth setting to try to
reconnect to the device in case of timeout or unknown disconnection,
or to try to connect to another device depending on internal policy.

-- 
Frédéric Danis
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
Registered in England & Wales, no. 5513718

