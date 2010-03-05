Return-Path: <cyrus@holtmann.org>
Subject: Re: bluez installs alsa related stuff under /etc/alsa instead of
 /usr/share/alsa
From: Marcel Holtmann <marcel@holtmann.org>
To: pacho@condmat1.ciencias.uniovi.es
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1267691859.10782.14.camel@localhost.localdomain>
References: <1267691859.10782.14.camel@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 04 Mar 2010 17:42:47 -0800
Message-ID: <1267753367.29510.26.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pacho,

> bluez installs stuff into /etc/alsa and it seems wrong since default
> location for alsa stuff seems to be /usr/share/alsa instead. You can
> also see that this is been workarounded in ubuntu, gentoo (and probably
> debian also).
> 
> Any reason why using /etc/alsa instead?

I thought that is the default location. If that is wrong, then please
quote the ALSA documentation and send a patch to fix it.

Regards

Marcel


