Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTimj8qN=z=g=DxLcQ6KNhdxvmUK9Ex=q2UFTWu5Q@mail.gmail.com>
References: <AANLkTims_WHKQ4pNPZNgWS390ASeU8Kw1=w4LN2TOsR3@mail.gmail.com>
	<20110310153754.GA2190@joana>
	<AANLkTi=ckPmqtRZQvHq5Rkg0jKCuk7uvisM10r+o2hjF@mail.gmail.com>
	<20110310192941.GC2190@joana>
	<AANLkTim+dmSSYUJWF=Sd6raSUUurtsbih6YhjH89Q+9w@mail.gmail.com>
	<20110311023800.GA2191@joana>
	<AANLkTikgVGUHPF_jhBaETndgBDtbwpQ3WeN6TQBZDDRF@mail.gmail.com>
	<AANLkTimj8qN=z=g=DxLcQ6KNhdxvmUK9Ex=q2UFTWu5Q@mail.gmail.com>
Date: Fri, 11 Mar 2011 14:25:17 +0800
Message-ID: <AANLkTi=AQpgvDG_Ox5bhao3uTkFtTXAA54o8C9P-aZAA@mail.gmail.com>
Subject: Re: some questions about Bluez
From: loody <miloody@gmail.com>
To: "Arun K. Singh" <arunkat@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi

2011/3/11 Arun K. Singh <arunkat@gmail.com>:
> Hi,
>
>>> That is a cross-compilation issue, there is no problem with BlueZ here.
>>>
>> I know the error comes from that it cannot find the libs and headers.
>> Is it possible to turn off everything except basic bluetooth detecting
>> feature such that I don't need to prepare the libs running over MIPS?
>> If it is possible, how can I do that?
>
> Try disabling audio plugin via --disable-audio in ./configure if that
> is the only irritant library ..
>
I did so as below:
./configure --host=mipsel-linux-gnu --disable-optimization
--disable-fortify --disable-pie --disable-network --disable-serial
--disable-input --disable-audio --disable-service

But it still try to compile ALSA.
thanks a lot,
miloody
