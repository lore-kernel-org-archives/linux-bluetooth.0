Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=LSB8k7ZCAT4U6toC4DG+3Dmp18KdSM35o2oMb@mail.gmail.com>
References: <AANLkTims_WHKQ4pNPZNgWS390ASeU8Kw1=w4LN2TOsR3@mail.gmail.com>
	<20110310153754.GA2190@joana>
	<AANLkTi=ckPmqtRZQvHq5Rkg0jKCuk7uvisM10r+o2hjF@mail.gmail.com>
	<20110310192941.GC2190@joana>
	<AANLkTim+dmSSYUJWF=Sd6raSUUurtsbih6YhjH89Q+9w@mail.gmail.com>
	<20110311023800.GA2191@joana>
	<AANLkTikgVGUHPF_jhBaETndgBDtbwpQ3WeN6TQBZDDRF@mail.gmail.com>
	<AANLkTimj8qN=z=g=DxLcQ6KNhdxvmUK9Ex=q2UFTWu5Q@mail.gmail.com>
	<AANLkTi=AQpgvDG_Ox5bhao3uTkFtTXAA54o8C9P-aZAA@mail.gmail.com>
	<AANLkTi=LSB8k7ZCAT4U6toC4DG+3Dmp18KdSM35o2oMb@mail.gmail.com>
Date: Tue, 15 Mar 2011 22:27:49 +0800
Message-ID: <AANLkTimqwMESW5z5efCB16nhT5_cx284n7TT9yXYZ=V9@mail.gmail.com>
Subject: Re: some questions about Bluez
From: loody <miloody@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: "Arun K. Singh" <arunkat@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi anderson:

2011/3/11 Anderson Lizardo <anderson.lizardo@openbossa.org>:
> Hi,
>
> On Fri, Mar 11, 2011 at 2:25 AM, loody <miloody@gmail.com> wrote:
>> I did so as below:
>> ./configure --host=mipsel-linux-gnu --disable-optimization
>> --disable-fortify --disable-pie --disable-network --disable-serial
>> --disable-input --disable-audio --disable-service
>>
>> But it still try to compile ALSA.
>
> Try adding --disable-alsa as well.
>
> Regards,
> --
It seems work.
but it try to link the wrong dbus and glib libs:

..................
  GEN    lib/bluetooth/hidp.h
  CC     lib/bluetooth.lo
cc1: warning: include location "/usr/include/dbus-1.0" is unsafe for
cross-compilation
cc1: warning: include location "/usr/include/glib-2.0" is unsafe for
cross-compilation
....


I have some questions:
1. "--disable-alsa" seems not in the configure --help list
    where I can see the whole list of features I can disable?
2. why bluez need glib?
    If I remember correctly, glib is use for GTK+ graphic lib.
    And I don't need it if I only try to use console commands, right?

Thanks a lot,
miloody
-- 
Regards,
