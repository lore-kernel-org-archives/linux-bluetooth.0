Return-Path: <cyrus@holtmann.org>
Subject: Re: 'cat /dev/rfcomm0' yields strange data
From: Marcel Holtmann <marcel@holtmann.org>
To: Ramagudi Naziir <naziirr@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <dfb262380911140245v20973542v61cc82ba1071064d@mail.gmail.com>
References: <dfb262380911140245v20973542v61cc82ba1071064d@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 15 Nov 2009 12:58:01 +0100
Message-ID: <1258286281.3299.28.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ramagudi,

> # rfcomm watch /dev/rfcomm0 1 muahahahah
> Waiting for connection on channel 1
> Connection from xxx to /dev/rfcomm0
> Press CTRL-C for hangup
> 
> 
> on another terminal:
> 
> 
> # cat /dev/rfcomm0
> 
> ^J^J^J
> ^J^J^J
> 
> 
> 
> ^J
> 
> 
> 
> ^J
> 
> 
> 
> ^J^J
> 
> 
> 
> ^^J
> ...
> ...
> 
> and these character output goes on and on for a minute or so until it stops.
> 
> Any idea what is it ? is it supposed to be here ?
> I was expecting the 'cat' command to show me only data that was sent
> from the remote end
> (e.g. If I do on the remote peer 'echo bla > /dev/rfcomm0' I do see
> the bla here on the local 'cat').

you have to switch the device into raw mode before cat will work. The
rfcomm utility should have a --raw option.

Regards

Marcel


