Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20040926113702.53408.qmail@web53210.mail.yahoo.com>
From: Massimiliano Cuccia <massimiliano_cuccia@yahoo.com>
Subject: Re: [Bluez-users] obexFTP ... does it works?
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1096149821.7719.7.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 26 Sep 2004 04:37:02 -0700 (PDT)


Hi Marcel
thanks for your help

> It is the Bluetooth
> RFCOMM channel number of the FTP service.
clear, thanks ... I have to study a bit more.
In the man pages I read that it is the channel number,
but I don't know that 10 is the ftp channel number.

> There is a tool call btobex in the BlueZ obex
> CVS repository that might work.

i downloaded the sources from the cvs repository
(module "alls")
the INSTALL document says to execute ./configure, but
the file is not included.
It says that the file can be generated using autoconf,
my output for "autoconf ./configure.in" is this:

configure.in:8: error: possibly undefined macro:
AM_INIT_AUTOMAKE
      If this token and others are legitimate, please
use m4_pattern_allow.
      See the Autoconf documentation.
configure.in:9: error: possibly undefined macro:
AM_CONFIG_HEADER
configure.in:11: error: possibly undefined macro:
AM_MAINTAINER_MODE
configure.in:13: error: possibly undefined macro:
AC_PREFIX_BLUEZ
configure.in:23: error: possibly undefined macro:
AC_PATH_BLUEZ

a file named configure is created even that error
messages ... so i executed it
this is the output:
./configure: line 1245: syntax error near unexpected
token `bluez-obex,'
./configure: line 1245: `AM_INIT_AUTOMAKE(bluez-obex,
0.1)'


the last tempt was to execute the configure.in file,
the output was:
./configure.in: line 1: dnl
: command not found
./configure.in: line 2: dnl: command not found
./configure.in: line 3: dnl
: command not found
./configure.in: line 4: 
: command not found
./configure.in: line 5: syntax error near unexpected
token `2.50'
./configure.in: line 5: `AC_PREREQ(2.50)
'
but I'm not surprised about this.


then I hed found a kde tool to use configuration
files: kconfigure
but the output was the same ...

How do I install? Where am I wrong?

----
autoconf 2.59
kconfigure 1.1 (kde 3.2.1, Qt 3.3.1)


		
__________________________________
Do you Yahoo!?
Y! Messenger - Communicate in real time. Download now. 
http://messenger.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
