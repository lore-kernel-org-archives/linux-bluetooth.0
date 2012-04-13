Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Fri, 13 Apr 2012 11:49:19 +0200
From: aep <aep@exys.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Lenovo W510 Bluetooth Controller stopped working in 3.4-rc1
In-Reply-To: <20120413093400.GC10780@x220.ger.corp.intel.com>
References: <abfb31f0565ebacddd25efec883e31dc@exys.org>
 <20120413093400.GC10780@x220.ger.corp.intel.com>
Message-ID: <d62a71fa204a8a9e8568309b9c1d2f6b@exys.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 13 Apr 2012 12:34:00 +0300, Johan Hedberg wrote:

> I don't think that commit or that module parameter has anything to do
> with this.

Actually, i didn't respond again due to the embarrassing fact that i 
added the parameter to the wrong module.
After adding bluetooth.enable_hs=1 to the kernel commandline (bluetooth 
is compiled in here), it worked again.

> What user space version are you using?

bluez version 4.98

> What do you mean by
> "vanished without any trace"? Does hciconfig -a or hciconfig hci0 not
> show anything?

no, and no, and neither anything in dmesg other then that the module 
was loaded.

> If this is related to mgmt being now enabled by default
> could you try running user space with "bluetoothd -P mgmtops"?


Not sure if that does any good, since adding the parameter did the job, 
and my /usr/lib/bluetooth/plugins/ is empty.
Let me know if you still think this helps debugging, then i'll try 
later.


thanks
