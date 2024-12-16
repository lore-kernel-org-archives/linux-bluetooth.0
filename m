Received: from mail.ekdawn.com (mail.ekdawn.com [159.69.120.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0CA143723
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Dec 2024 22:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.120.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734389874; cv=none; b=ox5h39LgK7v+R0HE8wpnBdEoEMPcStvxKqkqCD1vFVHXOUb0SKJERrzaCIw5YM310J+RKdE7JbtdSRqOysxZPeIaMmDnq6dutMTUjozRO2OBsWCfFngfLVxN9lrOt+JyWnrLAoSxp8EuxR9RPWJWtedjL5SRtIZHNcOI2nVx1j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734389874; c=relaxed/simple;
	bh=Xbw0glBeALdGGU0jVH0LHlyTI3brqkuZxgolJoa4014=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ne1J4yErGp+IzrZBdIZwudChL0oOqNpSETt2OrIdHPW6SILZNhC21CNTPVWo2lANgXhAaQzFMrooGvmp4lg0ywoDfMtL6MLOAxNqMce7tfP84QxnLaCrTuHFsFYctrQ+hDekqYL0pf2Y2/dQ5oNLOElvcduuojyRlQtpOhl/66w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org; spf=pass smtp.mailfrom=mail.ekdawn.com; dkim=pass (4096-bit key) header.d=horse64.org header.i=@horse64.org header.b=juYTTLj3; arc=none smtp.client-ip=159.69.120.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ekdawn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=horse64.org header.i=@horse64.org header.b="juYTTLj3"
Received: from [10.42.0.229] (dynamic-176-003-154-216.176.3.pool.telefonica.de [176.3.154.216])
	by mail.ekdawn.com (Postfix) with ESMTPSA id 79D55183021;
	Mon, 16 Dec 2024 22:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=horse64.org; s=dkim1;
	t=1734389343; bh=Xbw0glBeALdGGU0jVH0LHlyTI3brqkuZxgolJoa4014=;
	h=Message-ID:Date:Subject:To:Cc:From:From:Sender:To:CC:Subject:
	 Message-Id:Date;
	b=juYTTLj3PsquVS3Ca2UikTpD3l8WJuLsCDi25bwswBBCA7h+5IY14Zmym9tcf9TZ7
	 qXk1r+s5LUkSDM7uSzmA8p6KmtYMnRcUtauL1bvHNtlnfDH5gBo8PwlghKgwmL1lfK
	 HbKKngp3I4L5pPqnY1Bg1jJLJhO9VoFxdWDqErU2v1RL/ZG2OlBjdQOC7e/9z88lpE
	 7t+jx0Sl1rf0jvIWHu+ZPUpc6vDrte0XqIiMtDohzdEMRn6WITZdX3YZmOcTmySbD2
	 UISo9R9kKMUJfiAt8kSXpTn7nyyH3vUIRPYZBkf3Eek0wR2c3zxBBbEGvQ3kD/iaLx
	 Jugbldxd/YdNz2zAn/iXBAhFhAbfPb+Nd+dGRdPkhW6xVGZFCxu3cycyLejrHUuE3q
	 K3ordsycShH2S31tU0Efnh1Mjtirw9jc5rYlqQF/9g1A2z0jtw0NCWSdBuqskQ2dbZ
	 Jzv5zpjmf3AJst6fOk4Rz6t9yLlfClGxhkta3G2farD8diDdZoZcpyU/62Nzxia1tZ
	 nHheOv0nypy8kx7hmx3E9K1eSxAMXQk9AzlJRub41zuKwLuov19wkX8GrRVxYDE3y5
	 ZYRPkRp4kseJQvFKzQLPhgwi4X32weqMjFOTzDjbKAqeV6t5ZFjRJRMKh+J1j+Ydnz
	 EzT8iWcEhWqJYXi9mZIlUJF8=
Message-ID: <9313a649-3fa9-4a41-8ac2-26bb1a5fd529@horse64.org>
Date: Mon, 16 Dec 2024 23:48:48 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question: pairing code not showing anymore for device that was
 previously pairable
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <f06506cb-c55f-4007-9df5-da7b6b268440@horse64.org>
 <CABBYNZJhFEi5x1a36EuCqpqGewLMxmOiOA73NmoPaX=BqdooWw@mail.gmail.com>
Content-Language: en-US
From: Ellie <el@horse64.org>
In-Reply-To: <CABBYNZJhFEi5x1a36EuCqpqGewLMxmOiOA73NmoPaX=BqdooWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

For what it's worth, the issue is still present in kernel 6.12.4. All my 
machines that updated their kernels can now no longer pair this 
keyboard. The keyboard shows up as "Paired Yes" but "Trusted No", and no 
pass key is prompted and it can't be used.

I haven't gotten around to some bluetooth debug log yet since I'm often 
in sensitive environments where I'm not comfortable logging surrounding 
devices.

Regards,

Ellie

On 9/12/24 3:23 AM, Luiz Augusto von Dentz wrote:
> Hi Ellie,
> 
> On Wed, Sep 11, 2024 at 6:28 PM Ellie <el@horse64.org> wrote:
>>
>> Hi everyone,
>>
>> My apologies if this is the wrong place to send this question to. But my
>> question is, what do I do if a bluetooth keyboard no longer shows the
>> pairing passkey code on pair? The model is a "Royal Kludge RK61-US"
>> keyboard. It used to show the pairing code and then pair fine. I ested
>> this with two different bluetooth controllers on two different Linux
>> machines of mine.
> 
> It used to show a passkey and now it doesn't?
> 
>> But since I moved to a different distribution with different bluetooth
>> tools and kernel versions, now kernel 6.10.8 with
>> bluetoothctl/bluetoothd 5.77, it no longer shows the pairing code and
>> bluetoothctl just thinks it pairs without showing a passkey. And during
>> that, the keyboard itself keeps flashing in pairing mode and won't
>> finish pairing like the Linux side seems to think it did, and I'm
>> guessing it's waiting for the code which never seems to show up in
>> bluetoothctl:
>>
>> [bluetooth]# scan on
>> [bluetooth]# SetDiscoveryFilter success
>> [bluetooth]# Discovery started
>> [bluetooth]# [CHG] Controller 70:D8:C2:14:8B:23 Discovering: yes
>> [bluetooth]# [NEW] Device C5:F9:E9:90:F6:8A RK61-5.0
>> [bluetooth]# pair C5:F9:E9:90:F6:8A
>> [bluetooC5:F9:E9:90:F6:8A9:E9:90:F6:8A
>> Attempting to connect to C5:F9:E9:90:F6:8A
>> [bluetooth]# [CHG] Device C5:F9:E9:90:F6:8A WakeAllowed: yes
>> [blueC5:F9:E9:90:F6:8A9:E9:90:F6:8A
>> Attempting to pair with C5:F9:E9:90:F6:8A
>> [CHG] Device C5:F9:E9:90:F6:8A Connected: yes
>> [RK61-5.0]# Connection successful
>> [RK61-5.0]# [CHG] Device C5:F9:E9:90:F6:8A Bonded: yes
>> [RK61-5.0]# [NEW] Primary Service (Handle 0x0000)
>>          /org/bluez/hci0/dev_C5_F9_E9_90_F6_8A/service000a
>>          0000180a-0000-1000-8000-00805f9b34fb
>>          Device Information
>> [RK61-5.0]# [NEW] Characteristic (Handle 0x0000)
>>          /org/bluez/hci0/dev_C5_F9_E9_90_F6_8A/service000a/char000b
>>          00002a29-0000-1000-8000-00805f9b34fb
>>          Manufacturer Name String
>> [RK61-5.0]# [NEW] Characteristic (Handle 0x0000)
>>          /org/bluez/hci0/dev_C5_F9_E9_90_F6_8A/service000a/char000d
>>          00002a28-0000-1000-8000-00805f9b34fb
>>          Software Revision String
>> [RK61-5.0]# [NEW] Characteristic (Handle 0x0000)
>>          /org/bluez/hci0/dev_C5_F9_E9_90_F6_8A/service000a/char000f
>>          00002a50-0000-1000-8000-00805f9b34fb
>>          PnP ID
>> [RK61-5.0]# [NEW] Primary Service (Handle 0x0000)
>>          /org/bluez/hci0/dev_C5_F9_E9_90_F6_8A/service0011
>>          0000180f-0000-1000-8000-00805f9b34fb
>>          Battery Service
>> [RK61-5.0]# [NEW] Characteristic (Handle 0x0000)
>>          /org/bluez/hci0/dev_C5_F9_E9_90_F6_8A/service0011/char0012
>>          00002a19-0000-1000-8000-00805f9b34fb
>>          Battery Level
>> [RK61-5.0]# [NEW] Descriptor (Handle 0x0000)
>>          /org/bluez/hci0/dev_C5_F9_E9_90_F6_8A/service0011/char0012/desc0014
>>          00002902-0000-1000-8000-00805f9b34fb
>>          Client Characteristic Configuration
>> [RK61-5.0]# [CHG] Device C5:F9:E9:90:F6:8A UUIDs:
>> 00001800-0000-1000-8000-00805f9b34fb
>> [RK61-5.0]# [CHG] Device C5:F9:E9:90:F6:8A UUIDs:
>> 0000180a-0000-1000-8000-00805f9b34fb
>> [RK61-5.0]# [CHG] Device C5:F9:E9:90:F6:8A UUIDs:
>> 0000180f-0000-1000-8000-00805f9b34fb
>> [RK61-5.0]# [CHG] Device C5:F9:E9:90:F6:8A UUIDs:
>> 00001812-0000-1000-8000-00805f9b34fb
>> [RK61-5.0]# [CHG] Device C5:F9:E9:90:F6:8A ServicesResolved: yes
>> [RK61-5.0]# [CHG] Device C5:F9:E9:90:F6:8A Paired: yes
>> [RK61-5.0]# [CHG] Device C5:F9:E9:90:F6:8A Modalias: usb:v000Ep3412d6701
> 
> It shows as paired above, I wonder if it is using JustWork pairing
> method but it sounds really weird if before it used a passkey.
> 
>> Is this some sort of regression maybe, or am I supposed to try some
>> special option? Am I supposed to do something with some active probe
>> command in bluetoothctl to get the passkey code to show? My apologies
>> for these beginner questions, but from all I could find online it seems
>> like the code is meant to show up during above process but it doesn't.
> 
> We probably need the btmon traces to check if the passkey method is
> really being used, maybe something else is at play like some other
> pairing agent with different IO capabilities.
> 
>> I already tried the different controller modes "dual", "bredr", "le",
>> and it seems like it's an "le" type device since with "bredr" it doesn't
>> show up. Other than that, the modes didn't seem to make a difference.
>>
>> Sadly, I didn't write down the exact software versions of kernel etc.
>> that I previously used when everything worked. :-|
>>
>> Regards,
>>
>> Ellie
>>
> 
> 

