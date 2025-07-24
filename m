Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A96A95C
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 19:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753385394; cv=none; b=j1ntyPi/60D7nmS1dy5u6hMtgoFj5W3b0c9kbYEDTYJAMUUFem/ha+/HP0yWH0gq9w/N35N6xFZL/m85uxLq4bSh6hH00q310WMlb1T8b+fusewFVMlwtIugav97bfj3V+s4GKLhEc7zqEbcYMpcL3yb6EcVTeBNf5Nlo1CWG00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753385394; c=relaxed/simple;
	bh=Adj7a3byHrVWAoiy3qkEgESHnyCQoafblyCro2YOCfE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q7yiCAH8GV93OcbF7/q6iPrAEaSw+WZHrLtEW/oeWh1KEnY8l3pdyR7dRXJfvKz/9+MRK1LuZM/IQ1m9ms3WvU+SCmuK38MkX/0f+FZ93bUEp15NUTlZ+BjNd89XiFAT9oFbglfyLx3bk6BxR6e/UjLwIHH80SYe3VkYXNVXppE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYCgCR2W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYCgCR2W"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93ABCC4CEF4
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 19:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753385393;
	bh=Adj7a3byHrVWAoiy3qkEgESHnyCQoafblyCro2YOCfE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bYCgCR2WWZ7gxXkaevfYuYwo457hqMKnpWKedMxKgkxMP9FTTD4wRYwz0j7S6Vplw
	 qX1PmYwIrrgKZdhOgePzDQE+NcGh7bkP/V4qAkVcgwLKOhuo5D8OzqJVsPg4TG0xUh
	 q9iBHgXflTVlWlWdJBt51qITU1SqcOVuYBR4Hzr2z5h7BjbClnEwFPZUZeb0syNyqG
	 Ijf2jONZIwdRzwJfUs58yiW3crk5/pGjeQw/akY9rnVVJeWgkAUr4bEtdsd1ddxJIC
	 wUCSw/8Ar3/FIm0gi2fM9S5Q5oSf+RgJjQuWRd8lIe8+WmUo0JBRF4vXRi7u7x22Uy
	 f1VbCMMxucRug==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 87A2BC41616; Thu, 24 Jul 2025 19:29:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220344] Intel AX211 bluetooth randomly disconnects and
 reconnects, started after kernel update
Date: Thu, 24 Jul 2025 19:29:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tal.lich@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220344-62941-z68kcMXFkT@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220344-62941@https.bugzilla.kernel.org/>
References: <bug-220344-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D220344

--- Comment #6 from Tal Licht (tal.lich@gmail.com) ---
I've also tried downgrading to the GA kernel (5.15).
When I boot this the Wifi driver (iwlwifi) doesn't even load and my
external USB-C monitor does not initialize at all.
So using this is not an option :-)


On Sun, 20 Jul 2025 at 14:30, Tal Lichtenstein <tal.lich@gmail.com> wrote:

> Update - unfortunately Bluetooth did start disconnecting, it only took a
> bit longer this time. So no improvement even after downgrading the firmwa=
re
> :(
>
> [ 4945.041226] Bluetooth: hci0: Hardware error 0x0c
> [ 4945.055323] Bluetooth: hci0: Retrieving Intel exception info failed
> (-16)
> [ 5413.818394] Bluetooth: hci0: Hardware error 0x0c
> [ 5413.832258] Bluetooth: hci0: Retrieving Intel exception info failed
> (-16)
> [ 6078.608374] Bluetooth: hci0: Hardware error 0x0c
> [ 6078.622543] Bluetooth: hci0: Retrieving Intel exception info failed
> (-16)
> [ 6154.472547] Bluetooth: hci0: Hardware error 0x0c
> [ 6154.486464] Bluetooth: hci0: Retrieving Intel exception info failed
> (-16)
> [ 6323.107517] Bluetooth: hci0: Hardware error 0x0c
> [ 6323.121611] Bluetooth: hci0: Retrieving Intel exception info failed
> (-16)
> [ 9253.552312] Bluetooth: hci0: Hardware error 0x0c
> [ 9253.566433] Bluetooth: hci0: Retrieving Intel exception info failed
> (-16)
> [10010.348140] Bluetooth: hci0: link tx timeout
> [10010.348160] Bluetooth: hci0: killing stalled connection
> 38:18:4c:be:34:1d
> [10371.646448] Bluetooth: hci0: Hardware error 0x0a
> [10371.660506] Bluetooth: hci0: Retrieving Intel exception info failed
> (-16)
> [10547.126313] Bluetooth: hci0: Hardware error 0x0c
> [10547.140440] Bluetooth: hci0: Retrieving Intel exception info failed
> (-16)
> [10602.005441] Bluetooth: hci0: Hardware error 0x0a
> [10602.019402] Bluetooth: hci0: Retrieving Intel exception info failed
> (-16)
> [11660.598378] Bluetooth: hci0: Hardware error 0x0a
> [11660.612383] Bluetooth: hci0: Retrieving Intel exception info failed
> (-16)
>
> On Sun, 20 Jul 2025 at 12:02, Tal Lichtenstein <tal.lich@gmail.com> wrote:
>
>> I've tried going back to the bluetooth firmware that was current at the
>> date the computer was originally installed - 9/Sep/2023.
>>
>> On this date, these firmware files were current:
>>
>> ibt-0040-0041.sfi - commit 555452997994b250477de4a03b322dc53513d05a dated
>> 2023-08-28
>> ibt-0040-0041.ddc - commit b7e0c80b00bb4e3d4c845f2270c5c0c8262154ca dated
>> 2021-09-15
>> iwlwifi-so-a0-gf-a0-86.ucode -
>> commit f27dec616e29e44cd90645926c1459639d112c3d dated 2023-11-16 - *this
>> is still the current version today*
>>
>> I switched the files in /lib/firmware to these versions and rebooted:
>>
>> root@licht-t14s:~# dmesg | grep -E '(hci0|iwlwifi)'
>> [   30.809390] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
>> [   30.830430] iwlwifi 0000:00:14.3: Detected crf-id 0x400410, cnv-id
>> 0x80400 wfpm id 0x80000020
>> [   30.830491] iwlwifi 0000:00:14.3: PCI dev 51f1/0090, rev=3D0x370,
>> rfid=3D0x2010d000
>> [   30.835929] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version:
>> 0.0.2.41
>> *[   30.836818] iwlwifi 0000:00:14.3: loaded firmware version
>> 86.fb5c9aeb.0 so-a0-gf-a0-86.ucode op_mode iwlmvm*
>> [   30.839236] Bluetooth: hci0: Device revision is 0
>> [   30.839241] Bluetooth: hci0: Secure boot is enabled
>> [   30.839242] Bluetooth: hci0: OTP lock is enabled
>> [   30.839243] Bluetooth: hci0: API lock is enabled
>> [   30.839244] Bluetooth: hci0: Debug lock is disabled
>> [   30.839245] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
>> [   30.839246] Bluetooth: hci0: Bootloader timestamp 2019.40 buildtype 1
>> build 38
>> [   30.840962] Bluetooth: hci0: DSM reset method type: 0x00
>> *[   30.844291] Bluetooth: hci0: Found device firmware:
>> intel/ibt-0040-0041.sfi*
>> [   30.844304] Bluetooth: hci0: Boot Address: 0x100800
>> *[   30.844305] Bluetooth: hci0: Firmware Version: 254-28.23*
>> [   30.982422] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6E AX211
>> 160MHz, REV=3D0x370
>> [   31.158040] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x20
>> [   31.158093] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
>> [   31.158101] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
>> [   31.158109] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x0
>> [   31.158396] iwlwifi 0000:00:14.3: loaded PNVM version e28bb9d7
>> [   31.159564] iwlwifi 0000:00:14.3: RFIm is deactivated, reason =3D 4
>> [   31.174653] iwlwifi 0000:00:14.3: Detected RF GF, rfid=3D0x2010d000
>> [   31.244329] iwlwifi 0000:00:14.3: base HW address: 10:f6:0a:05:ba:09
>> [   31.260051] iwlwifi 0000:00:14.3: iwlmvm doesn't allow to disable BT
>> Coex, check bt_coex_active module parameter
>> [   31.294784] iwlwifi 0000:00:14.3 wlp0s20f3: renamed from wlan0
>> [   31.793193] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x20
>> [   31.793252] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
>> [   31.793260] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
>> [   31.793269] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x0
>> [   31.794692] iwlwifi 0000:00:14.3: RFIm is deactivated, reason =3D 4
>> [   31.892352] iwlwifi 0000:00:14.3: Registered PHC clock: iwlwifi-PTP,
>> with index: 0
>> [   32.392539] Bluetooth: hci0: Waiting for firmware download to complete
>> [   32.393277] Bluetooth: hci0: Firmware loaded in 1512675 usecs
>> [   32.393369] Bluetooth: hci0: Waiting for device to boot
>> [   32.409352] Bluetooth: hci0: Device booted in 15680 usecs
>> *[   32.409513] Bluetooth: hci0: Found Intel DDC parameters:
>> intel/ibt-0040-0041.ddc*
>> [   32.412401] Bluetooth: hci0: Applying Intel DDC parameters completed
>> *[   32.415476] Bluetooth: hci0: Firmware timestamp 2023.28 buildtype 1
>> build 68350*
>> [   32.415482] Bluetooth: hci0: Firmware SHA1: 0xc64314a8
>> [   32.587297] Bluetooth: hci0: Bad flag given (0x1) vs supported (0x0)
>> [   32.587398] Bluetooth: hci0: Bad flag given (0x1) vs supported (0x0)
>> [   32.587484] Bluetooth: hci0: Bad flag given (0x1) vs supported (0x0)
>> [   32.587627] Bluetooth: hci0: Bad flag given (0x1) vs supported (0x0)
>>
>> Bluetooth keyboard, mouse and headphones connected automatically. I then
>> proceeded to play some music in Spotify which in my experience shortens =
the
>> time until the disconnection issue happens.
>>
>> Sure enough after less than 1 minute I started hearing bluetooth sound
>> hiccups which indicate a problem with the bluetooth connection. These
>> repeat occasionally.
>> ***However**, *the devices DID NOT disconnect even after 1 hour of
>> continuous use and I did not see the error message I did with the newer
>> firmware:
>>
>> kernel: Bluetooth: hci0: Hardware error 0x0c
>>
>> So this is already some improvement. What I can also try is to downgrade
>> the kernel from the HWE version (6.8) to the GA version (5.15) and see if
>> that helps. I'll try that later once I have a grip I know what I'm doing=
 :-)
>>
>>
>>
>>
>> On Sat, 19 Jul 2025 at 16:36, Tal Lichtenstein <tal.lich@gmail.com>
>> wrote:
>>
>>> I think this is not the same bug as 220341 - that bug reports the stack
>>> crashing and Bluetooth becoming disabled. This is not the case here - it
>>> just causes devices to disconnect periodically. I suspect the firmware =
is
>>> crashing and restarting but have no way to verify this. I will try howe=
ver
>>> to switch to some older firmware and see if this stops. Will report the
>>> results.
>>>
>>> On Sat, Jul 19, 2025, 15:06 <bugzilla-daemon@kernel.org> wrote:
>>>
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=3D220344
>>>>
>>>> --- Comment #2 from Paul Menzel (
>>>> pmenzel+bugzilla.kernel.org@molgen.mpg.de) ---
>>>> Was the Linux firmware updated on your system, so you actually need to
>>>> test an
>>>> *older* firmware version?
>>>>
>>>> --
>>>> You may reply to this email to add a comment.
>>>>
>>>> You are receiving this mail because:
>>>> You reported the bug.
>>>
>>>

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
