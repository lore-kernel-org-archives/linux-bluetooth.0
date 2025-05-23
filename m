Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680A8183CC3
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 11:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747999064; cv=pass; b=GtMa4Gvyln+1aeeiCKZ5HcwefNSlDmQcF2/hsn0A5Ib2996nFkuRgMvGZOcdK9BBSRwIYN3Lc/Rd8MTkKV2qERi4vj4sGYXCFUNXeDnfog8fVuS0WTqlfceNx62gpkiozTAb7c/UvCuJQ+0DA3KFtKceWRDO1puX506AkIvybX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747999064; c=relaxed/simple;
	bh=SdCh6dTj/rc76IYFdmfhLUoAtmllbmXX5i001hHBSuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZcIdiv4gMNpm6AGelzng8hoFMTjbizJrsYytJ5vhkJwX8RCr6NkjQiRWM2+CzG/rIIoYTbs9jLfolLGZLM7YH7JQJuSOqfXsJk4BmgK7RF0Fd+9UY2dQQjjIVuQX4bHujnvZ5OnEA5G15HslprZtERZgNfGsaCetRdgow3ao4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b=bDu0wn5d; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b="bDu0wn5d"
ARC-Seal: i=1; a=rsa-sha256; t=1747999046; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kNbI5Y1vd00tdFf+VpwL6Eqcds+9P1dnqulGYjB8LiFL01UT7eN59yzwS0CreVkNuqxhjAqfk+dbskhZfef8iC1MaeP8oW4EEBDNOf7Mj3/FzYmn4pmmbkXWMM5U4h9N8Q6ubIXyiEMhqf9bggY68nT9+Gt0uWBehOe8i1htbwk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1747999046; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zVB4eR148n6NVRXhWNlTePEhaTb2Dn3Zj8Ka50eM2Ow=; 
	b=i+aUFlFiP6WCWR6Jhzc3QQpkZ4GXyJlKUHmhXi2LTm/B6e4Zs7i5UYsFxhXCB0+SLbbAIe3afBWvbxCiL6KLPkX2M2gFwgw4+tcg5GKNWJpCWIcatgwXiqoQy7StJ6SayMA70VG/OB/prw6s6HIFQpgjhmzr67Tx8bi6fAAArOg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=frederic.danis@collabora.com;
	dmarc=pass header.from=<frederic.danis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747999046;
	s=zohomail; d=collabora.com; i=frederic.danis@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=zVB4eR148n6NVRXhWNlTePEhaTb2Dn3Zj8Ka50eM2Ow=;
	b=bDu0wn5dL+gNH3LtMTw8d+KKwiphZhlShLIiKN5O/COKDPmqCu9wZs6RpnLSL2fm
	J7H61/2tdmyXSprhEyV51f0+BJZCPwiFjQI6gg5r21yux9v9xfTJ6qYZeZiIPDcwYjW
	pXy1Z/1qhzcwrau8vg4hPsFD5Wp2lqgZ/u03Lnp4=
Received: by mx.zohomail.com with SMTPS id 1747999044455835.3832590839226;
	Fri, 23 May 2025 04:17:24 -0700 (PDT)
Message-ID: <8b4ed19b-0042-426a-83ea-04947edd8f0b@collabora.com>
Date: Fri, 23 May 2025 13:17:22 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v6 1/3] obexd: Unregister profiles when the user is
 inactive
To: Andrew Sayers <kernel.org@pileofstuff.org>
Cc: luiz.dentz@gmail.com, pav@iki.fi, linux-bluetooth@vger.kernel.org
References: <20250430131648.1291354-1-kernel.org@pileofstuff.org>
 <20250430131648.1291354-2-kernel.org@pileofstuff.org>
 <333ad76e-0aba-4f93-b141-8e69fb47535f@collabora.com>
 <aDBPCM8f0dpkJ7ob@andrews-2024-laptop.sayers>
Content-Language: en-US
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
In-Reply-To: <aDBPCM8f0dpkJ7ob@andrews-2024-laptop.sayers>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Andrew,

On 23/05/2025 12:33, Andrew Sayers wrote:

> On Thu, May 22, 2025 at 04:55:22PM +0200, Frédéric Danis wrote:
>> Hi Andrew,
>>
>> On 30/04/2025 15:14, Andrew Sayers wrote:
>>
>>> Obexd is usually run as a user service, and can exhibit surprising
>>> behaviour if two users are logged in at the same time.
>>>
>>> Unregister profiles when the user is detected to be off-seat.
>>>
>>> It may be impossible to detect whether a user is on-seat in some cases.
>>> For example, a version of obexd compiled with systemd support might be
>>> run outside of a systemd environment.  Warn and leave services
>>> registered if that happens.
>>>
>>> Obexd can be run as a system service, in which case this check makes no
>>> sense.  Disable this check when called with `--system-bus`.
>>>
>>> Obexd can also be run by a user that does not have an active session.
>>> For example, someone could use `ssh` to access the system.  There might
>>> be a use case where someone needs Bluetooth access but can't log in with
>>> a keyboard, or there might be a security issue with doing so.  This isn't
>>> handled explicitly by this patch, but a future patch could add support
>>> by calling `logind_set(FALSE)` in the same way as is currently done
>>> with `--system-bus`.
>>>
>>> Unregister profiles by closing private connections instead of sending
>>> UnregisterProfile on the shared connection.  Pipewire has apparently
>>> found the latter to cause long shutdown delays, because bluetoothd
>>> may be shutting down and unable to handle this message.
>>>
>>> Based in large part on the wireplumber code mentioned by Pauli Virtanen:
>>> https://gitlab.freedesktop.org/pipewire/wireplumber/-/blob/master/modules/module-logind.c#L52
>>>
>>> Other services are likely to need similar functionality,
>>> so I have created a gist to demonstrate the basic technique:
>>> https://gist.github.com/andrew-sayers/1c4a24f86a9a4c1b1e38d109f1bd1d1e
>>>
>>> Suggested-by: Pauli Virtanen <pav@iki.fi>
>>> Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
>> I have a problem to connect PBAP profile using obexctl, using upstream
>> bluetoothd and obexd built on Ubuntu 24.04, the org.bluez.obex.PhonebookAccess1
>> interface doesn't appear.
>>
>> After bisecting I found that this commit cause this issue.
> Hmm, my guess is that seat detection isn't working properly.
> Could you try this gist?  You should get "Active: 1" when it starts,
> "Active: 0" when you switch away from your current screen, and "Active: 1"
> when you switch back.
>
> https://gist.github.com/andrew-sayers/1c4a24f86a9a4c1b1e38d109f1bd1d1e
>
It seems to work:
$ ./user-on-seat
Active: 1
Active: 0
Active: 1

But the problem occurred while I didn't try any "seat" change.
I just started bluetoothd, obexd and obexctl, then tried to connect to my phone and got:

     connect 24:24:B7:11:82:6C pbap
     Attempting to connect to 24:24:B7:11:82:6C
     [NEW] Session /org/bluez/obex/client/session0 [default]
     [24:24:B7:11:82:6C]# Connection successful

While I'm expecting:

     connect 24:24:B7:11:82:6C pbap
     Attempting to connect to 24:24:B7:11:82:6C
     [NEW] Session /org/bluez/obex/client/session0 [default]
     [24:24:B7:11:82:6C]# [NEW] PhonebookAccess /org/bluez/obex/client/session0
     [24:24:B7:11:82:6C]# Connection successful

-- 
Frédéric Danis
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
Registered in England & Wales, no. 5513718

