Return-Path: <cyrus@holtmann.org>
Message-Id: <201205041732.q44HWi2m019553@imr-da03.mx.aol.com>
Date: Fri, 4 May 2012 13:32:02 -0400
From: Kal Torak <chronognosis@aim.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: main.conf issues
In-Reply-To: <CABBYNZLLCj_cA__ZQazR81OUScbtAKJrbCfV70O3BgTC05=ueg@mail.gmail.com>
References: <201204271541.q3RFfVd5006035@imr-da04.mx.aol.com>
	<4F9B0108.2000007@tu-ilmenau.de>
	<CABBYNZJ2ygZ42r==cDbBFmtzmOFTA-HnDCWk_XM669pHYtfs5Q@mail.gmail.com>
	<201205011821.q41ILXXx011867@imr-ma03.mx.aol.com>
	<CABBYNZLLCj_cA__ZQazR81OUScbtAKJrbCfV70O3BgTC05=ueg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Wed, 2 May 2012 11:08:34 +0300
Luiz Augusto von Dentz <luiz.dentz@gmail.com> escribió:

> It seems some security policy is blocking PulseAudio to send messages
> to bluetoothd, check your /etc/dbus-1/system.d/bluetooth.conf, there
> is a sample configuration file in the repository src/bluetooth.conf
> which should work with PulseAudio.
> 
> 

Thank you Luiz, I solve that, rigth now I can call the methods
from dbus-send. But now I'm trying to complete mi initial purpose
Stream from the device, but I can't do that, when I try to do
org.bluez.AudioSource.Connect, the method return a error, Unable to
setup the stream, and bluetoohd logs Unable to select SEP
at /var/log/messages... What mean that ? SEP ?
Regards
