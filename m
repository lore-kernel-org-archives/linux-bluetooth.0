Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100123191419.GA19717@jh-x301>
References: <a69c0aba1001230519v3a197d9cq7942599e3a371168@mail.gmail.com>
	<20100123172550.GA18667@jh-x301> <a69c0aba1001231101i3d093edfh94ebd007e6713692@mail.gmail.com>
	<20100123191419.GA19717@jh-x301>
From: papukaija <papukaija@skynet.be>
Date: Mon, 25 Jan 2010 14:52:47 +0100
Message-ID: <a69c0aba1001250552t22bcd736q8d7cf9e466e2b994@mail.gmail.com>
Subject: Re: Feature request: remember bluetooth on/off setting
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> Hi,
>
> On Sat, Jan 23, 2010, papukaija wrote:
>> > On Sat, Jan 23, 2010, papukaija wrote:
>> >> I rarely use bluetooth devices, so I turn bluetooth off until I need
>> >> it. Every time I start my system (netbook; Samsung nc10) up again and
>> >> log in again, I manually turn bluetooth off again.  I'd like
>> >> bluetoothd to remember whether I last had bluetooth off or on, and use
>> >> that same setting the next time.
>> >
>> > bluetoothd already has this feature. You just need to make sure that
>> > RememberPowered=true in /etc/bluetooth/main.conf
>> >
>> > Johan
>> >
>> >
>>
>> In that case this feature doesn't work. I'm using Ubuntu Netbook Remix
>> v. 9.10 (Karmic) and I have "RememberPowered=true in
>> /etc/bluetooth/main.conf".
>
> I'm running latest git here and works fine for me. Could it be that you
> have some other component in your system that's always powering on
> Bluetooth?
>
> Johan
>
>

Maybe gnome's bluetooth applet doesn't read this setting or maybe it's
ignoring the setting completely.
