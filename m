Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] new sobexsrv v1.0.0
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1132913814.2055.3.camel@panic>
References: <1132390096.32715.4.camel@panic>
	 <1132658105.28644.16.camel@blade>  <1132913814.2055.3.camel@panic>
Content-Type: text/plain; charset=utf-8
Message-Id: <1132941689.5577.16.camel@blade>
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
Date: Fri, 25 Nov 2005 19:01:29 +0100

Hi Collin,

> > the stuff is really cool, but please use a GCC 4.0 compiler and get r=
id
> > of the warnings.
>=20
> I fixed the warnings and used gcc4 to compile it (this is not fixed in
> the makefile, so you need to have gcc4 as your default compiler).

my default compiler is a GCC 4.0 and you still see this on a 64-Bit
machine:

obexsrv.c: In function =E2=80=98security=E2=80=99:
obexsrv.c:85: warning: cast to pointer from integer of different size
obexsrv.c: In function =E2=80=98internal_handler=E2=80=99:
obexsrv.c:329: warning: cast to pointer from integer of different size
obexsrv.c: In function =E2=80=98scripting_handler=E2=80=99:
obexsrv.c:583: warning: cast to pointer from integer of different size
obexsrv.c:586: warning: cast to pointer from integer of different size
obexsrv.c:612: warning: cast to pointer from integer of different size
obexsrv.c: In function =E2=80=98cmd_connect=E2=80=99:
obexsrv.c:670: warning: cast to pointer from integer of different size
obexsrv.c:681: warning: cast to pointer from integer of different size
obexsrv.c:694: warning: cast to pointer from integer of different size
obexsrv.c:709: warning: cast to pointer from integer of different size
obexsrv.c: In function =E2=80=98cmd_setpath=E2=80=99:
obexsrv.c:828: warning: cast to pointer from integer of different size
obexsrv.c: In function =E2=80=98cmd_get=E2=80=99:
obexsrv.c:902: warning: cast to pointer from integer of different size
obexsrv.c:905: warning: cast to pointer from integer of different size
obexsrv.c: In function =E2=80=98cmd_put=E2=80=99:
obexsrv.c:961: warning: cast to pointer from integer of different size
obexsrv.c:992: warning: cast to pointer from integer of different size
obexsrv.c:992: warning: cast to pointer from integer of different size
obexsrv.c:995: warning: cast to pointer from integer of different size
obexsrv.c:998: warning: cast to pointer from integer of different size
obexsrv.c:1013: warning: cast to pointer from integer of different size
obexsrv.c:1016: warning: cast to pointer from integer of different size
obexsrv.c:1025: warning: cast to pointer from integer of different size
obexsrv.c: In function =E2=80=98main=E2=80=99:
obexsrv.c:1312: warning: cast to pointer from integer of different size

fs.c: In function =E2=80=98lsdir=E2=80=99:
fs.c:88: warning: cast from pointer to integer of different size
fs.c:89: warning: cast from pointer to integer of different size
fs.c:90: warning: cast from pointer to integer of different size
fs.c:91: warning: cast from pointer to integer of different size
fs.c:92: warning: cast from pointer to integer of different size

Please don't mix pointers and integers. This will kick back some day.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
