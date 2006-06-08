Return-Path: <philipl@mail.utexas.edu>
Message-ID: <4487B00F.7070204@mail.utexas.edu>
Date: Wed, 07 Jun 2006 22:05:19 -0700
From: Philip Langdale <philipl@mail.utexas.edu>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: bluez-devel@lists.sourceforge.net
Subject: Re: Latest 2.6.16-mh1 patch.
References: <44867199.2000409@mail.utexas.edu>	 <1149664531.22472.4.camel@localhost>  <4486EE2D.3010507@mail.utexas.edu> <1149714318.22472.59.camel@localhost>
In-Reply-To: <1149714318.22472.59.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
> 
> I will look at it, but you might wanna try to disable the automatic
> sniff mode and see if this helps at all. Simply call:
> 
> 	echo 0 > /sys/class/bluetooth/hci0/idle_timeout

I just tried this, and unfortunately it doesn't help.

Thanks,

--phil
