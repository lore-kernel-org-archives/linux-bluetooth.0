Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Makefile.am dependency problem
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <435FFD9B.1030904@xmission.com>
References: <435FFD9B.1030904@xmission.com>
Content-Type: text/plain
Message-Id: <1130364791.32634.1.camel@blade>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 27 Oct 2005 00:13:11 +0200

Hi Brad,

> I noticed a strange dependency problem... it's common in bluez where a
> library is used. Header file changes don't force a recompile:
> 
> bmidgley@jag:/usr/src/bluez/utils/common$ make
> make: Nothing to be done for `all'.
> bmidgley@jag:/usr/src/bluez/utils/common$ touch textfile.h
> bmidgley@jag:/usr/src/bluez/utils/common$ make
> make: Nothing to be done for `all'.
> bmidgley@jag:/usr/src/bluez/utils/common$ touch textfile.c
> bmidgley@jag:/usr/src/bluez/utils/common$ make
> gcc -DHAVE_CONFIG_H -I. -I. -I..     -Wall -O2 -c textfile.c
> rm -f libtextfile.a
> ar cru libtextfile.a textfile.o
> ranlib libtextfile.a
> /bin/sh ../libtool --tag=CC --mode=link gcc  -Wall -O2   -o
> test_textfile  test_textfile.o libtextfile.a
> gcc -Wall -O2 -o test_textfile test_textfile.o  libtextfile.a
> 
> Makefile.am has a line that mentions textfile.h:
> 
> libtextfile_a_SOURCES = textfile.h textfile.c
> 
> but that doesn't seem to be enough.

look at the bootstrap file. I forced this behavior.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
