Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D26298274
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 17:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748021291; cv=pass; b=UL7kDht+am3vReEprZiizp32Ca7Vsq9PU2pibmGrbGAr4u5GvxXa7q+udYOHfYmubMHg1zj0sbK2JcOMU09AqGc03QcRQI2J8jV9+TNWLYCPd9EqdUW15aLoWjc8FGDmlPDES3zkIc2Ri3FadKNCja7D/Th7OXBq7PpiyvnJzKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748021291; c=relaxed/simple;
	bh=eW8CpdjfrXpBWUf9oJC8SGKezCNw6lf5QJW/q80JJxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ehD2bTcCb1GkUFalbeIey0ulUl7sFJOy69wGcup4fHVl4qXT3fmTN0uFScj9yKJoH4cvHiE6NTEndn/8XFRdsryxYGbUfI9y0x4l6jhN8Zbt8oHvrjwA0Aq4A+7IM654Z7adIOBxQMcXXnFFUS4jdzEunm9O2FegJPI788v6Vdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b=IvkSKmfl; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b="IvkSKmfl"
ARC-Seal: i=1; a=rsa-sha256; t=1748021274; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Q4bmihwzCwUUTqJpx/4GlDg1tshGH6ULiylLBTY/ZB/TLirHG5K8MVH++NxXiihIveIxHhe2J43Bo/+6FTUuqqZSbyZbOqCpNgZuf/vVIKvQ6zwcbGy5NtBazrq2Qjh7jPTHLYo0eC05wY/rAExd3N6s3qO7W+L510SrFf7hB3U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1748021274; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Whp7/q2dyn2ceIUZ8h8pWWlj2N/r+0AqyKD1yxQL9jY=; 
	b=E3jgIA9Fhk5ftZtEbdWadPfGzso9tUF7eg5bFbAQyI55xY92VYG8aNljd8XynpCp1Bc8wbv0HLEqCm/y2OoKmuOL5EF7LdtAmKTGA7GBrjAcYBVkMUTRFFU0bloUSn/vJ6DGjFPsa23FwPFxKBDmCaK4n2/R41cDrHEW6OfhPDs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=frederic.danis@collabora.com;
	dmarc=pass header.from=<frederic.danis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1748021274;
	s=zohomail; d=collabora.com; i=frederic.danis@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Whp7/q2dyn2ceIUZ8h8pWWlj2N/r+0AqyKD1yxQL9jY=;
	b=IvkSKmflgu3ETgE49LayxNbsPONx0P1q8/5UrCMkEOUymTqP6qS/0GdNKOrk/lQN
	gkf/JQ0dLJzyXDpu0iZ71O/Ky06OvPGF+gN8o6qwinj/5eiAPv2R7582lG90Ii4di/j
	kOMK2En2QsjjRnCSu+08RmJHDfeIPJM+8MstjBhI=
Received: by mx.zohomail.com with SMTPS id 1748021273884905.8865949620886;
	Fri, 23 May 2025 10:27:53 -0700 (PDT)
Message-ID: <e33ed3c3-fc23-4318-94f2-7ade41f82258@collabora.com>
Date: Fri, 23 May 2025 19:27:51 +0200
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
 <8b4ed19b-0042-426a-83ea-04947edd8f0b@collabora.com>
 <aDCi5XGOajXmBDug@andrews-2024-laptop.sayers>
Content-Language: en-US
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
In-Reply-To: <aDCi5XGOajXmBDug@andrews-2024-laptop.sayers>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Andrew,

On 23/05/2025 18:31, Andrew Sayers wrote:

> On Fri, May 23, 2025 at 01:17:22PM +0200, Frédéric Danis wrote:
>> Hi Andrew,
>>
>> On 23/05/2025 12:33, Andrew Sayers wrote:
>>
>>> On Thu, May 22, 2025 at 04:55:22PM +0200, Frédéric Danis wrote:
>>>> Hi Andrew,
>>>>
>>>> On 30/04/2025 15:14, Andrew Sayers wrote:
>>>>
>>>>> Obexd is usually run as a user service, and can exhibit surprising
>>>>> behaviour if two users are logged in at the same time.
>>>>>
>>>>> Unregister profiles when the user is detected to be off-seat.
>>>>>
>>>>> It may be impossible to detect whether a user is on-seat in some cases.
>>>>> For example, a version of obexd compiled with systemd support might be
>>>>> run outside of a systemd environment.  Warn and leave services
>>>>> registered if that happens.
>>>>>
>>>>> Obexd can be run as a system service, in which case this check makes no
>>>>> sense.  Disable this check when called with `--system-bus`.
>>>>>
>>>>> Obexd can also be run by a user that does not have an active session.
>>>>> For example, someone could use `ssh` to access the system.  There might
>>>>> be a use case where someone needs Bluetooth access but can't log in with
>>>>> a keyboard, or there might be a security issue with doing so.  This isn't
>>>>> handled explicitly by this patch, but a future patch could add support
>>>>> by calling `logind_set(FALSE)` in the same way as is currently done
>>>>> with `--system-bus`.
>>>>>
>>>>> Unregister profiles by closing private connections instead of sending
>>>>> UnregisterProfile on the shared connection.  Pipewire has apparently
>>>>> found the latter to cause long shutdown delays, because bluetoothd
>>>>> may be shutting down and unable to handle this message.
>>>>>
>>>>> Based in large part on the wireplumber code mentioned by Pauli Virtanen:
>>>>> https://gitlab.freedesktop.org/pipewire/wireplumber/-/blob/master/modules/module-logind.c#L52
>>>>>
>>>>> Other services are likely to need similar functionality,
>>>>> so I have created a gist to demonstrate the basic technique:
>>>>> https://gist.github.com/andrew-sayers/1c4a24f86a9a4c1b1e38d109f1bd1d1e
>>>>>
>>>>> Suggested-by: Pauli Virtanen <pav@iki.fi>
>>>>> Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
>>>> I have a problem to connect PBAP profile using obexctl, using upstream
>>>> bluetoothd and obexd built on Ubuntu 24.04, the org.bluez.obex.PhonebookAccess1
>>>> interface doesn't appear.
>>>>
>>>> After bisecting I found that this commit cause this issue.
>>> Hmm, my guess is that seat detection isn't working properly.
>>> Could you try this gist?  You should get "Active: 1" when it starts,
>>> "Active: 0" when you switch away from your current screen, and "Active: 1"
>>> when you switch back.
>>>
>>> https://gist.github.com/andrew-sayers/1c4a24f86a9a4c1b1e38d109f1bd1d1e
>>>
>> It seems to work:
>> $ ./user-on-seat
>> Active: 1
>> Active: 0
>> Active: 1
>>
>> But the problem occurred while I didn't try any "seat" change.
> Yeah, I was hoping you'd get e.g. 0 / 0 / 1 as output, suggesting it was
> inactive at first but changing seats worked around the problem.
> Sorry, but this means it'll be harder to debug.  Can you...

I manually start bluetoothd and obexd, i.e. I stopped them from systemctl (disable and stop) and start them using cli:
$ src/bluetoothd -nd -E
$ obexd/src/obexd -nd

> 1. Check whether PBAP is registered with bluetoothctl:
>
>         bluetoothctl show | grep 0000112e-0000-1000-8000-00805f9b34fb
>
>     You should see one line, like:
>
>         UUID: Phonebook Access Client   (0000112e-0000-1000-8000-00805f9b34fb)

got:
$ client/bluetoothctl show | grep 0000112e-0000-1000-8000-00805f9b34fb
	UUID: Phonebook Access Client   (0000112e-0000-1000-8000-00805f9b34fb)

> 2. Tail the bluetooth and obex logs in another terminal:
>
>         sudo journalctl -f SYSLOG_IDENTIFIER=bluetoothd SYSLOG_IDENTIFIER=obexd
>
>     Steps below will ask you to "make a note" in the log
>     (e.g. append "about to do XYZ" to the file) - this will tell me
>     which messages were triggered by which events.
>
> 3. Make a note in the log, then stop the obex service:
>
>         systemctl --user stop obex.service
>
> 4. Check PBAP again:
>
>         bluetoothctl show | grep 0000112e-0000-1000-8000-00805f9b34fb
>
>     You should not see any output.

Yes, no output

> 5. Make another note in the log, then start the obex service:
>
>         systemctl --user start obex.service
>
> 6. Check PBAP again:
>
>         bluetoothctl show | grep 0000112e-0000-1000-8000-00805f9b34fb
>
>     You should see the same as in step 1.

Yes:
$ client/bluetoothctl show | grep 0000112e-0000-1000-8000-00805f9b34fb
	UUID: Phonebook Access Client   (0000112e-0000-1000-8000-00805f9b34fb)

> 8. Make a final note in the log, then try ctrl+alt+F{7,8}.
>
> 9. Send me the full log with notes, or at least anything that jumps out at you
>
> Note: the instructions above only print things that are likely to show
> problems, and unlikely to contain anything that can't go in an e-mail.  You're
> welcome to do `sudo journalctl -f` and or `bluetoothctl show` in another
> terminal and go looking for trouble :)

I added the logs for pbap connection.

You can find the log at https://gist.github.com/fdanis-oss/eb6fba440c6b07e9ed5a266672bdbcf3

-- 
Frédéric Danis
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
Registered in England & Wales, no. 5513718

