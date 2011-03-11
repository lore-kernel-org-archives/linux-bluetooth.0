Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTikgVGUHPF_jhBaETndgBDtbwpQ3WeN6TQBZDDRF@mail.gmail.com>
References: <AANLkTims_WHKQ4pNPZNgWS390ASeU8Kw1=w4LN2TOsR3@mail.gmail.com>
 <20110310153754.GA2190@joana> <AANLkTi=ckPmqtRZQvHq5Rkg0jKCuk7uvisM10r+o2hjF@mail.gmail.com>
 <20110310192941.GC2190@joana> <AANLkTim+dmSSYUJWF=Sd6raSUUurtsbih6YhjH89Q+9w@mail.gmail.com>
 <20110311023800.GA2191@joana> <AANLkTikgVGUHPF_jhBaETndgBDtbwpQ3WeN6TQBZDDRF@mail.gmail.com>
From: "Arun K. Singh" <arunkat@gmail.com>
Date: Fri, 11 Mar 2011 10:40:20 +0530
Message-ID: <AANLkTimj8qN=z=g=DxLcQ6KNhdxvmUK9Ex=q2UFTWu5Q@mail.gmail.com>
Subject: Re: some questions about Bluez
To: loody <miloody@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

>> That is a cross-compilation issue, there is no problem with BlueZ here.
>>
> I know the error comes from that it cannot find the libs and headers.
> Is it possible to turn off everything except basic bluetooth detecting
> feature such that I don't need to prepare the libs running over MIPS?
> If it is possible, how can I do that?

Try disabling audio plugin via --disable-audio in ./configure if that
is the only irritant library ..



>
> Thanks a lot,
> miloody

Thanks,
Arun
