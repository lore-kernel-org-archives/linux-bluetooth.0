Return-Path: <wim.delvaux@adaptiveplanet.com>
From: wim delvaux <wim.delvaux@adaptiveplanet.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: bnep module use count ...
Date: Sun, 7 Mar 2004 04:00:04 +0100
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
References: <200403070334.32315.wim.delvaux@adaptiveplanet.com> <1078627214.2807.31.camel@pegasus>
In-Reply-To: <1078627214.2807.31.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200403070400.04900.wim.delvaux@adaptiveplanet.com>
List-ID: <bluez-users.lists.sourceforge.net>

> this can be possible, but I can't tell you anything without more
> information. Last time I check the reference counting it was working
> perfect for all upper L2CAP modules. Maybe there is a problem in the
> BNEP module or in the network layer.

	Is there anything you want me to put in the bnep/bluetooth network module
	so that I can give you more info ?  E.g where is the reference counting 
mantained (dev->refcnt is apparently the field but I cannot seem to find the 
++ for it)

	I just did a normal connect/disconnect (not suspend) and then did a pand -l
	and all connections are gone ...

	I also added this line to the listen loop.  It reads the pids of children 
processes so you have no more ghost apps.

	while( waitpid( -1, 0, WNOHANG) > 0 ) ;

	W
