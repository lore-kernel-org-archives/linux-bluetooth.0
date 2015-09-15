Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAGGi21YCT3whoy43-ytOWARpCt_wgrKkjTBft1JabtnExHfSiw@mail.gmail.com>
References: <CAGGi21YVrRB06R8ahxRLBZ=xZkNKGnCsetL1xUQx9DPLeAGGXA@mail.gmail.com>
	<CABBYNZKi=TSWQxyN6j1=a++V5p-e8viB=qWxnX1pGQShz9A-YA@mail.gmail.com>
	<10452927.a6KM84WJTg@leonov>
	<CAGGi21ZDsS0__YnzWqWfcmk=jSAEZYQwUD8Dx2c8fi25bWn5SA@mail.gmail.com>
	<CAGGi21aF8ipUcH0wUWaJGGS4DmDtQJWOPqcyB0zyK3uF93JN4g@mail.gmail.com>
	<CABBYNZJTuvMemAS2TdBy9k2ix8=K7FexLCGKsRwWigguJboDEQ@mail.gmail.com>
	<CAGGi21YCT3whoy43-ytOWARpCt_wgrKkjTBft1JabtnExHfSiw@mail.gmail.com>
Date: Tue, 15 Sep 2015 11:00:55 +0300
Message-ID: <CABBYNZKKwky_2K-17nuBjxQ7DtR8tTa+ynfFME0j6MsDAPp7pg@mail.gmail.com>
Subject: Re: Understanding connecting to BLE keyboard
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Elliot Saba <staticfloat@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elliot,

On Tue, Sep 15, 2015 at 10:37 AM, Elliot Saba <staticfloat@gmail.com> wrote:
> I cannot seem to make it prompt me for a PIN anymore; the only thing
> it does is fail immediately with the error code given above.  I have
> successfully connected it and disconnected it from my OSX and Windows
> laptops, so I do not believe it is an issue of having another device
> paired with it; no matter what combination of agents or command
> sequences I use, I am always just getting AuthenticationCanceled
> errors immediately after my machine attempts to pair.  I'm not sure
> how I got the PIN entry code earlier, I'm guessing it was some kind of
> race condition, especially considering that even though I managed to
> get a PIN code entry prompt I got an authentication failure less than
> a second after that prompt came up.
>
> Is there any other kind of debugging that I could perform for you guys?
> -E

No top posting in the list please.

The error Connection Failed to be Established indicate that the
connection has never been completed, so perhaps there is something
wrong with your local adapter, have you tried plugging another
controller?

> On Mon, Sep 14, 2015 at 11:49 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi,
>>
>> On Tue, Sep 15, 2015 at 6:32 AM, Elliot Saba <staticfloat@gmail.com> wrote:
>>> Hello all, thank you for your responses so far.
>>>
>>> First off, I had not tried entering the PIN, because nothing had
>>> prompted me to do so.  I have intermittently managed to get a PIN
>>> prompt to show up in bluetoothctl now that I am using "agent
>>> KeyboardDisplay" instead of "agent KeyboardOnly", thanks to Szymon's
>>> advice.  However, although it now sometimes prompts me for a PIN code,
>>> other times it doesn't, and I still get "authentication canceled"
>>> errors extremely quickly (less than a second) after attempting to
>>> pair.  Here is an example session, with both bluetoothctl and btmon
>>> output: https://gist.github.com/staticfloat/bbc016376ba5a8ab4451
>>>
>>> Secondly, what manual do you refer to?  I am having a difficult time
>>> finding bluez documentation, so if there is a bluez manual somewhere,
>>> I'd love to read it.  If you refer to the manual for my keyboard,
>>> sadly its manual says nothing about Linux.  I can pair it on other
>>> operating systems such as OSX without difficulty (and yes, it requires
>>> entry of a PIN) so I am confident I know the proper method to pair it
>>> with a device.
>>
>>
>> Looks like the remote it disconnecting very early:
>>
>>> HCI Event: Disconnect Complete (0x05) plen 4                 [hci0] 30.737028
>>         Status: Success (0x00)
>>         Handle: 64
>>         Reason: Connection Failed to be Established (0x3e)
>>
>> Btw, make sure it is not connecting to any other system since it start
>> advertising perhaps you have to remove any existing link key from
>> other system you have been testing, also you said sometimes it does
>> prompt a pin code but by the logs this was not one of these.
>>
>>
>>
>> --
>> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
