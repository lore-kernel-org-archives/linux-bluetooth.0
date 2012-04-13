Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Fri, 13 Apr 2012 14:24:26 +0200
From: aep <aep@exys.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
 <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Lenovo W510 Bluetooth Controller stopped working in 3.4-rc1
In-Reply-To: <CAJdJm_PE-_3OZoDCXRf6wne_myQDCSV9wcvA9RnGt_W6uH5BRQ@mail.gmail.com>
References: <abfb31f0565ebacddd25efec883e31dc@exys.org>
 <20120413093400.GC10780@x220.ger.corp.intel.com>
 <d62a71fa204a8a9e8568309b9c1d2f6b@exys.org>
 <CAJdJm_PE-_3OZoDCXRf6wne_myQDCSV9wcvA9RnGt_W6uH5BRQ@mail.gmail.com>
Message-ID: <262096715f0861dba5cbe24a0edb7014@exys.org>
List-ID: <linux-bluetooth.vger.kernel.org>

heya,

On Fri, 13 Apr 2012 06:42:07 -0400, Anderson Lizardo wrote:

> What Johan is suggesting is to disable the mgmtops plugin so that
> hciops is used instead. If this works, it is due to a known 
> regression

Ah, sorry, i didn't realize the difference between -p and -P.

I confirm it works again without the bluetooth.enable_hs=1 but with -P 
mgmtops.

thanks!
