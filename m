Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <d62a71fa204a8a9e8568309b9c1d2f6b@exys.org>
References: <abfb31f0565ebacddd25efec883e31dc@exys.org>
	<20120413093400.GC10780@x220.ger.corp.intel.com>
	<d62a71fa204a8a9e8568309b9c1d2f6b@exys.org>
Date: Fri, 13 Apr 2012 06:42:07 -0400
Message-ID: <CAJdJm_PE-_3OZoDCXRf6wne_myQDCSV9wcvA9RnGt_W6uH5BRQ@mail.gmail.com>
Subject: Re: Lenovo W510 Bluetooth Controller stopped working in 3.4-rc1
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: aep <aep@exys.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi aep,

On Fri, Apr 13, 2012 at 5:49 AM, aep <aep@exys.org> wrote:
>> If this is related to mgmt being now enabled by default
>> could you try running user space with "bluetoothd -P mgmtops"?
>
> Not sure if that does any good, since adding the parameter did the job, and
> my /usr/lib/bluetooth/plugins/ is empty.
> Let me know if you still think this helps debugging, then i'll try later.

BlueZ plugins by default are "built-in", i.e. they are linked inside
the bluetoothd binary. But even built-in plugins can be disabled with
-P.

What Johan is suggesting is to disable the mgmtops plugin so that
hciops is used instead. If this works, it is due to a known regression
which happens with incompatible userspace tools and kernel versions.

Fortunately, a proper fix is on the way for the next upstream release.
So you can use this workaround for now.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
