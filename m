Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <2d5a2c100710100631r4c9874abo93585098922fae36@mail.gmail.com>
References: <de4879e80710011431q3fa8c870m95a08dc46ea9a679@mail.gmail.com>
	<de4879e80710051236j243ff5c6mc6bd18e5c43640a6@mail.gmail.com>
	<2d5a2c100710081056m6391d8aao6fbc2d2b1aa34948@mail.gmail.com>
	<1191884194.12212.13.camel@aeonflux.holtmann.net>
	<d89ddf300710081832w1ac37dfana49571dc9306dbf2@mail.gmail.com>
	<470B356F.1050805@silicom.fr>
	<1191919440.31341.9.camel@aeonflux.holtmann.net>
	<470B5184.1070507@free.fr>
	<2d5a2c100710091417s1dc1adddh4e3020b81595fe24@mail.gmail.com>
	<1191977483.6128.13.camel@aeonflux.holtmann.net>
	<2d5a2c100710100631r4c9874abo93585098922fae36@mail.gmail.com>
Date: Wed, 10 Oct 2007 16:09:53 +0200
Message-Id: <1192025393.6537.9.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: Fabien Chevalier <fabchevalier@free.fr>,
        Johan Hedberg <johan.hedberg@nokia.com>,
        Brad Midgley <bmidgley@xmission.com>
Subject: Re: [Bluez-devel] Patch: inheritance problem in gsta2dpsink
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Luiz,

> > > My name suggestion is: libbtaudio
> >
> > no extra library. Period. I am serious about it. We simply link the
> > plain object file twice.
> 
> I confused, do you agreed or not to create the LGPL library?

we create an object file (like for any other *.c files) under LGPL and
then simply link them.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
