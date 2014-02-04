Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140203183606.GA12511@molly>
References: <CACMtdhhCecEWiK33A6uNSQr-=iRJSehfbJCqb0Maxpq-8WjkPA@mail.gmail.com>
	<20140203183606.GA12511@molly>
Date: Tue, 4 Feb 2014 08:28:53 +0100
Message-ID: <CACMtdhhnvG_PopNn185npxi2nSqzFSLXthoh6PPPTh4SGj_uiA@mail.gmail.com>
Subject: Re: How do you install bluez for development?
From: Alejandro Exojo <aexojo@modpow.es>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2014-02-03 Vinicius Costa Gomes <vcgomes@gmail.com>:
>> Feb 03 17:14:38 PC-MW03 systemd[1]: Starting Bluetooth service...
>> Feb 03 17:14:38 PC-MW03 bluetoothd[22571]: Bluetooth daemon 5.14
>> Feb 03 17:14:38 PC-MW03 systemd[1]: Started Bluetooth service.
>> Feb 03 17:14:38 PC-MW03 systemd[1]: Starting Bluetooth.
>> Feb 03 17:14:38 PC-MW03 systemd[1]: Reached target Bluetooth.
>> Feb 03 17:14:38 PC-MW03 bluetoothd[22571]: Failed to access management interface
>
> Two probable causes, your kernel is older than 3.4, or the user that is running
> bluetoothd doesn't have the CAP_NET_ADMIN capability.

True! I was running 3.2. I've installed a more recent one, and I got
it working. Thank you very much, I would not have thought of the
kernel at all.

How come that at least 3.4 is needed?

Thank you again.

Cheers.
-- 
Alejandro Exojo Piqueras

ModpoW, S.L.
Technova LaSalle | Sant Joan de la Salle 42 | 08022 Barcelona | www.modpow.es
