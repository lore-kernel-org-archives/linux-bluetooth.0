Return-Path: <jamesp@hisser.org>
Message-ID: <404E3793.3010204@hisser.org>
Date: Tue, 09 Mar 2004 21:30:59 +0000
From: James Pattinson <jamesp@hisser.org>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Obex / Palm TT
References: <Pine.LNX.4.44.0303121553230.9558-100000@greebo.hisser.org>	<1047488348.28415.117.camel@pegasus.local>	<Pine.LNX.4.58.0403092101240.24697@greebo> <1078867356.10671.70.camel@pegasus>
In-Reply-To: <1078867356.10671.70.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Marcel Holtmann wrote:

> why to you think you can use a Siemens custom transport to connect to a
> Palm Tungsten? Actually using the RFCOMM TTY emulation should not be
> necessary. Try to make a direct connection over the RFCOMM socket. I
> think obexftp supports it.

I didn't suggest that I thought the siemens transport was the right one, 
in fact this is why I was asking for advice - as is usual for this sort 
of thing, user documentation is sparse :)

I do not know how to do obex over rfcomm with obexftp - but perhaps I'll 
try ussp-push next...

James
