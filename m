Received: from mail.ekdawn.com (mail.ekdawn.com [159.69.120.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F25524D7
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Sep 2024 22:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.120.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726093723; cv=none; b=sWlqKRwAfGOlu9nt56ejSAPBUP/PxcM+fQqBdhzGcykeH24wKgPBMmEDbp2kmUSRXlICez7kKFFBqnJyhXDX4/8cVICFnIRNEXCBpEB7SbZxjRDqEGn5gn1VD/JTDdMwt1A9YO+wE9F0niLWOuZ8T+IVhWHXaidIg9IV7hnyeac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726093723; c=relaxed/simple;
	bh=MZ9nt97KqtWrNhoAfsrfd1YQD87B5laeRmb+Ior9HFg=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=KRTI0/ck115gmixZtCmOkPgqf5v66qv593r5DVYXzf6oNP4fU3tStomu6rnKyuYUwqXKatRpUAJKTwianQr5VNbxJ5mmSnJB08r5yoDR3CN0pMuSxXc4QKn/wz0tnwqf0yGLuR5+Rvk0juE2welhEqvvEitkigyX3XrOT+ot5Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org; spf=none smtp.mailfrom=mail.ekdawn.com; arc=none smtp.client-ip=159.69.120.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mail.ekdawn.com
Received: from [10.42.0.106] (dynamic-176-003-128-097.176.3.pool.telefonica.de [176.3.128.97])
	by mail.ekdawn.com (Postfix) with ESMTPSA id B8991182A40
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Sep 2024 22:20:26 +0000 (UTC)
Message-ID: <f06506cb-c55f-4007-9df5-da7b6b268440@horse64.org>
Date: Thu, 12 Sep 2024 00:20:51 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Ellie <el@horse64.org>
To: linux-bluetooth@vger.kernel.org
Subject: Question: pairing code not showing anymore for device that was
 previously pairable
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi everyone,

My apologies if this is the wrong place to send this question to. But my 
question is, what do I do if a bluetooth keyboard no longer shows the 
pairing passkey code on pair? The model is a "Royal Kludge RK61-US" 
keyboard. It used to show the pairing code and then pair fine. I ested 
this with two different bluetooth controllers on two different Linux 
machines of mine.

But since I moved to a different distribution with different bluetooth 
tools and kernel versions, now kernel 6.10.8 with 
bluetoothctl/bluetoothd 5.77, it no longer shows the pairing code and 
bluetoothctl just thinks it pairs without showing a passkey. And during 
that, the keyboard itself keeps flashing in pairing mode and won't 
finish pairing like the Linux side seems to think it did, and I'm 
guessing it's waiting for the code which never seems to show up in 
bluetoothctl:

[bluetooth]# scan on
[bluetooth]# SetDiscoveryFilter success
[bluetooth]# Discovery started
[bluetooth]# [CHG] Controller 70:D8:C2:14:8B:23 Discovering: yes
[bluetooth]# [NEW] Device C5:F9:E9:90:F6:8A RK61-5.0
[bluetooth]# pair C5:F9:E9:90:F6:8A
[bluetooC5:F9:E9:90:F6:8A9:E9:90:F6:8A
Attempting to connect to C5:F9:E9:90:F6:8A
[bluetooth]# [CHG] Device C5:F9:E9:90:F6:8A WakeAllowed: yes
[blueC5:F9:E9:90:F6:8A9:E9:90:F6:8A
Attempting to pair with C5:F9:E9:90:F6:8A
[CHG] Device C5:F9:E9:90:F6:8A Connected: yes
[RK61-5.0]# Connection successful
[RK61-5.0]# [CHG] Device C5:F9:E9:90:F6:8A Bonded: yes
[RK61-5.0]# [NEW] Primary Service (Handle 0x0000)
	/org/bluez/hci0/dev_C5_F9_E9_90_F6_8A/service000a
	0000180a-0000-1000-8000-00805f9b34fb
	Device Information
[RK61-5.0]# [NEW] Characteristic (Handle 0x0000)
	/org/bluez/hci0/dev_C5_F9_E9_90_F6_8A/service000a/char000b
	00002a29-0000-1000-8000-00805f9b34fb
	Manufacturer Name String
[RK61-5.0]# [NEW] Characteristic (Handle 0x0000)
	/org/bluez/hci0/dev_C5_F9_E9_90_F6_8A/service000a/char000d
	00002a28-0000-1000-8000-00805f9b34fb
	Software Revision String
[RK61-5.0]# [NEW] Characteristic (Handle 0x0000)
	/org/bluez/hci0/dev_C5_F9_E9_90_F6_8A/service000a/char000f
	00002a50-0000-1000-8000-00805f9b34fb
	PnP ID
[RK61-5.0]# [NEW] Primary Service (Handle 0x0000)
	/org/bluez/hci0/dev_C5_F9_E9_90_F6_8A/service0011
	0000180f-0000-1000-8000-00805f9b34fb
	Battery Service
[RK61-5.0]# [NEW] Characteristic (Handle 0x0000)
	/org/bluez/hci0/dev_C5_F9_E9_90_F6_8A/service0011/char0012
	00002a19-0000-1000-8000-00805f9b34fb
	Battery Level
[RK61-5.0]# [NEW] Descriptor (Handle 0x0000)
	/org/bluez/hci0/dev_C5_F9_E9_90_F6_8A/service0011/char0012/desc0014
	00002902-0000-1000-8000-00805f9b34fb
	Client Characteristic Configuration
[RK61-5.0]# [CHG] Device C5:F9:E9:90:F6:8A UUIDs: 
00001800-0000-1000-8000-00805f9b34fb
[RK61-5.0]# [CHG] Device C5:F9:E9:90:F6:8A UUIDs: 
0000180a-0000-1000-8000-00805f9b34fb
[RK61-5.0]# [CHG] Device C5:F9:E9:90:F6:8A UUIDs: 
0000180f-0000-1000-8000-00805f9b34fb
[RK61-5.0]# [CHG] Device C5:F9:E9:90:F6:8A UUIDs: 
00001812-0000-1000-8000-00805f9b34fb
[RK61-5.0]# [CHG] Device C5:F9:E9:90:F6:8A ServicesResolved: yes
[RK61-5.0]# [CHG] Device C5:F9:E9:90:F6:8A Paired: yes
[RK61-5.0]# [CHG] Device C5:F9:E9:90:F6:8A Modalias: usb:v000Ep3412d6701

Is this some sort of regression maybe, or am I supposed to try some 
special option? Am I supposed to do something with some active probe 
command in bluetoothctl to get the passkey code to show? My apologies 
for these beginner questions, but from all I could find online it seems 
like the code is meant to show up during above process but it doesn't.

I already tried the different controller modes "dual", "bredr", "le", 
and it seems like it's an "le" type device since with "bredr" it doesn't 
show up. Other than that, the modes didn't seem to make a difference.

Sadly, I didn't write down the exact software versions of kernel etc. 
that I previously used when everything worked. :-|

Regards,

Ellie
