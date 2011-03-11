Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=AQpgvDG_Ox5bhao3uTkFtTXAA54o8C9P-aZAA@mail.gmail.com>
References: <AANLkTims_WHKQ4pNPZNgWS390ASeU8Kw1=w4LN2TOsR3@mail.gmail.com>
	<20110310153754.GA2190@joana>
	<AANLkTi=ckPmqtRZQvHq5Rkg0jKCuk7uvisM10r+o2hjF@mail.gmail.com>
	<20110310192941.GC2190@joana>
	<AANLkTim+dmSSYUJWF=Sd6raSUUurtsbih6YhjH89Q+9w@mail.gmail.com>
	<20110311023800.GA2191@joana>
	<AANLkTikgVGUHPF_jhBaETndgBDtbwpQ3WeN6TQBZDDRF@mail.gmail.com>
	<AANLkTimj8qN=z=g=DxLcQ6KNhdxvmUK9Ex=q2UFTWu5Q@mail.gmail.com>
	<AANLkTi=AQpgvDG_Ox5bhao3uTkFtTXAA54o8C9P-aZAA@mail.gmail.com>
Date: Fri, 11 Mar 2011 09:37:05 -0400
Message-ID: <AANLkTi=LSB8k7ZCAT4U6toC4DG+3Dmp18KdSM35o2oMb@mail.gmail.com>
Subject: Re: some questions about Bluez
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: loody <miloody@gmail.com>
Cc: "Arun K. Singh" <arunkat@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Mar 11, 2011 at 2:25 AM, loody <miloody@gmail.com> wrote:
> I did so as below:
> ./configure --host=mipsel-linux-gnu --disable-optimization
> --disable-fortify --disable-pie --disable-network --disable-serial
> --disable-input --disable-audio --disable-service
>
> But it still try to compile ALSA.

Try adding --disable-alsa as well.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
