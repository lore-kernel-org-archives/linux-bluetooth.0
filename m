Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <49FB3C18.8030505@gmail.com>
References: <49FB0A07.2020200@gmail.com> <49FB3C18.8030505@gmail.com>
Date: Sat, 2 May 2009 19:20:55 -0300
Message-ID: <2d5a2c100905021520i374024a2u565626e4c7f00b87@mail.gmail.com>
Subject: Re: DeviceFound and DeviceDisappeared signals
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ilya Rubtsov <lusyaru@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, May 1, 2009 at 3:14 PM, Ilya Rubtsov <lusyaru@gmail.com> wrote:
> I just would add that with hardware scheduler DeviceDisappeared signal works
> fine if there two remote devices in the field, and doesn't work if there is
> only one remote device:
>
> ---
> # Now there only 00:16:B8:53:5F:17 is turned on
> Fri May  1 20:36:48 2009 Signal: DeviceFound 00:16:B8:53:5F:17
> # Now I turn off 00:16:B8:53:5F:17 and wait, but no signal being emitted...
> # So, I turn on 00:02:76:16:F6:8F
> Fri May  1 20:38:52 2009 Signal: DeviceFound 00:02:76:16:F6:8F
> Fri May  1 20:39:01 2009 Signal: DeviceDisappeared 00:16:B8:53:5F:17

You may just have to wait longer to get the DeviceDisappeared signal
the fact the you turned off the device doesn't mean it will instantly
disappear it may happen that bluetoothd is idle waiting for scheduler
to start another discovery round (use Discovering property to check
that.). I will double check if there is some logic problem while
emitting DeviceDisappeared but I remember fixing it myself last time
and have no complaining since then.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
