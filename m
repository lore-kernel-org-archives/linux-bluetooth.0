Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Aaron Klish <aklish1@urbana.css.mot.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.GSO.4.20.0402231031470.11242-100000@wombat.urbana.css.mot.com>
References: 
	 <Pine.GSO.4.20.0402231031470.11242-100000@wombat.urbana.css.mot.com>
Content-Type: text/plain
Message-Id: <1077556750.2791.48.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: libs2 and utils2
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 23 Feb 2004 18:19:10 +0100

Hi Aaron,

>   What are your plans for officially releasing the code in libs2 and utils2 
> currently in CVS?  Do you have a target date sometime in the future?

the libs2 should already been released, but it wasn't. The new code must
be tested on a big endian platform and I lost my Sun Ultra60.

The core part is finished and the HCI layer needs only a small number of
corrections. But the SDP client part is a full rewrite and need much
more testing.

> At what point will you stop supporting the current libraries and utilities?

As long as people send me patches for the current version I will apply
them. Actually I only want to put bugfixes into libs, but for utils I'll
accept new features.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
