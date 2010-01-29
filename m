Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100125140609.GA6616@jh-x301>
References: <a69c0aba1001230519v3a197d9cq7942599e3a371168@mail.gmail.com>
	<20100123172550.GA18667@jh-x301> <a69c0aba1001231101i3d093edfh94ebd007e6713692@mail.gmail.com>
	<20100123191419.GA19717@jh-x301> <a69c0aba1001250552t22bcd736q8d7cf9e466e2b994@mail.gmail.com>
	<20100125140609.GA6616@jh-x301>
From: papukaija <papukaija@skynet.be>
Date: Fri, 29 Jan 2010 15:07:27 +0100
Message-ID: <a69c0aba1001290607j6035621fy5a473022579ae1ee@mail.gmail.com>
Subject: Re: Feature request: remember bluetooth on/off setting
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> Hi,
>
> On Mon, Jan 25, 2010, papukaija wrote:
>> > I'm running latest git here and works fine for me. Could it be that you
>> > have some other component in your system that's always powering on
>> > Bluetooth?
>>
>> Maybe gnome's bluetooth applet doesn't read this setting or maybe it's
>> ignoring the setting completely.
>
> The applet is not supposed to know about the setting. It's just supposed
> to toggle the Powered property for an adapter through the SetProperty
> D-Bus method that bluetoothd exports.
>
> Johan
>
>

Is there a way to debug this bug?
