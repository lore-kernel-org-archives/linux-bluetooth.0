Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] [PATCH] New keytab storage
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1075511922.3594.49.camel@pegasus>
References: <1075506991.14644.114.camel@akka.yeti.nocrew.org>
	 <1075509170.3594.36.camel@pegasus>
	 <1075510549.14644.135.camel@akka.yeti.nocrew.org>
	 <1075511922.3594.49.camel@pegasus>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1075541234.14644.149.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Date: Sat, 31 Jan 2004 10:27:14 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel

lör 2004-01-31 klockan 02.18 skrev Marcel Holtmann:
> However you should talk a look at libs2 and utils2 from CVS.

I haven't looked closely at libs2 but the hcid parts in utils2 appears
to be a copy of the original utils, except the files are renamed and put
in a "compat" directory with lots of other utilities. Why is that?

A "hcid" directory (as in the old "libs") would be better I think.

> Generate the diffs againt the CVS sources.

Maybe this a FAQ but I only get this:

   $ cvs -d:pserver:anonymous@cvs.bluez.org:/cvsroot/bluez login
   Logging in to :pserver:anonymous@cvs.bluez.org:2401/cvsroot/bluez
   CVS password:
   cvs [login aborted]: end of file from server (consult above messages if any)
   $

Any hints, please?

> Hope you get my point.

Yes, thanks.

Fredrik
