Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20090806225726.28631666@frodo.mittelerde>
References: <20090803202404.5d62b6a4@frodo.mittelerde>
	 <20090804054928.GC26953@titan.makhutov-it.de>
	 <20090804183208.31a857c4@frodo.mittelerde>
	 <20090806100546.GA20689@titan.makhutov-it.de>
	 <20090806225726.28631666@frodo.mittelerde>
Date: Thu, 6 Aug 2009 18:20:47 -0300
Message-ID: <5d223510908061420w6562f704r76027ba8ae670321@mail.gmail.com>
Subject: Re: Adressbook with bluez?
From: Rafael Seste <rseste@gmail.com>
To: Andreas Volz <lists@brachttal.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Aug 6, 2009 at 5:57 PM, Andreas Volz<lists@brachttal.net> wrote:
>
> I found some docs about Nokia (fitting for me) AT commands:
>
> http://www.activexperts.com/xmstoolkit/atcommands/nokia/
>
> I see that it's also possible to do stuff (e.g. initiate a call) that
> works also with HFP. I assume this is better to do with a defined
> protocol, not? (e.g. with HFP for Linux[1]).
>
> regards
> Andreas
>
> [1] http://nohands.sourceforge.net
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


This python scripts returns the first five contacts from the default
phonebook using handsfree profile it works for my nokia phone.

#!/usr/bin/python
import bluetooth

sock = bluetooth.BluetoothSocket(bluetooth.RFCOMM)
conn = sock.connect((<bluetooth device address>, <HF port>))

sock.send("AT+CPBR=1,5\r")
print sock.recv(1024)
print sock.recv(1024)
print sock.recv(1024)
print sock.recv(1024)
print sock.recv(1024)
print sock.recv(1024)

sock.close()


-- 
Rafael S. Seste
