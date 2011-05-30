Return-Path: <cyrus@holtmann.org>
Subject: Re: Another pass at adapter naming
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Mon, 30 May 2011 15:50:12 +0100
In-Reply-To: <BANLkTi=rVQ+vi+nN_DH+LuyBe4L6xk=hBg@mail.gmail.com>
References: <1306419070.2010.244.camel@novo.hadess.net>
	 <1306421410.2669.0.camel@novo.hadess.net>
	 <BANLkTikvWsxgN2C7yFyr8z3bmwvD9-h=1g@mail.gmail.com>
	 <1306426375.2669.1.camel@novo.hadess.net>
	 <BANLkTikexf4ED_wRwVd68e_pjRUA=LFJTw@mail.gmail.com>
	 <1306428972.2669.4.camel@novo.hadess.net>
	 <BANLkTi=rVQ+vi+nN_DH+LuyBe4L6xk=hBg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Message-ID: <1306767013.2669.61.camel@novo.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2011-05-30 at 15:05 +0300, Luiz Augusto von Dentz wrote:
<snip>
> Perhaps you are not seeing this problem because at least on gnome3 the
> bluetooths settings do not have any option to change the adapter name
> anymore, but iirc older gnome versions, KDE and others may still use
> adapter.SetProperty.
> 
> Im not against it, actually I like the idea of using the pretty
> hostname but since there is the possibility to set the Name using
> adapter.SetProperty it has to be consistent thus the suggestion to
> return an error when the user application attempt to change it using
> SetProperty, could you do that?

Right, I see your point. By the way, the GNOME 3 Bluetooth settings
don't have the ability to change the adapter name just because of that
feature, we wanted to do things properly the first time around.

I'll try to get this fixed for the next patch version.

Cheers


