Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <201001171637.22263.denkenz@gmail.com>
References: <fbf08281001110908s2c3412m456b3aa980b8ca10@mail.gmail.com>
	 <fbf08281001131539l342a3062w70883c197dc52983@mail.gmail.com>
	 <2d5a2c101001180338n2a37f0e9y76942650b755166@mail.gmail.com>
	 <201001171637.22263.denkenz@gmail.com>
Date: Tue, 19 Jan 2010 11:30:03 +0200
Message-ID: <2d5a2c101001190130u3b73737cl2589ba04ec5abd45@mail.gmail.com>
Subject: Re: [RFC] HFP support into oFono and BlueZ
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>, ofono@ofono.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Denis,

On Mon, Jan 18, 2010 at 12:37 AM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Luiz,
>
>> having it as a MediaEndpoint I guess it is probably a good idea to
>> have a similar design as we will have in endpoints, so the
>> registration actually happen in adapter path rather than device path,
>> which probably should avoid the having to resolve the device path
>> while probing if we just send the device path as a parameter of
>> NewConnection so we can do while in DEFER_SETUP stage so we don't risk
>> missing or getting timeouts while transferring the the fd to ofono.
>
> Personally I like this to be a per-device agent rather than per-adapter as it
> will make agent code inside oFono a bit easier to write.  Marcel / Johan, care
> to weigh in?

>From Gustavo's patch it seems that it became more difficult rather
than easier, since we only have the device address but not the path
there is always 2 extras calls to bluetoothd in order to resolve the
device path, it looks quite bad since this is being done for every
single device and no result is being cached in memory. I don't know
why this is the case, what is being used to enumerate the devices?

Also the problem with this being in the device path is that ofono may
not be registered as an agent on connect (both ways) which will cause
the connection to drop and the round trips to resolve device path only
makes it worse, if this happen to be on adapter path this would not be
a problem since we know before hand who to call.


-- 
Luiz Augusto von Dentz
Engenheiro de Computação
