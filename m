Return-Path: <cyrus@holtmann.org>
Message-ID: <47D81428.4070605@verticon.com>
Date: Wed, 12 Mar 2008 12:34:32 -0500
From: "John E. Conlon" <jconlon@verticon.com>
MIME-Version: 1.0
To: Guillaume Bedot <littletux@zarb.org>,
	bluez-users@lists.sourceforge.net
References: <47D6F3BF.5060802@verticon.com>
	<1205321428.12305.9.camel@littletux>
In-Reply-To: <1205321428.12305.9.camel@littletux>
Subject: Re: [Bluez-users] make problem bluez-utils 3.28
Reply-To: jconlon@verticon.com,
	BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Guillaume,

Yes, I noticed the undeclared identifiers and did a google to see what I 
could find and like you found it was declared in the sockios.h file. 
I found a copy on the internet at
http://tomoyo.sourceforge.jp/cgi-bin/lxr/source/include/linux/sockios.h#L120
and did notice the referenced identifiers at lines 120-123.   But when I 
looked at my /usr/include/linux/sockios.h those lines are missing.
I guess that means I have an older version of these headers.

This file is supplied by:
$ rpm -qf /usr/include/linux/sockios.h
glibc-kernheaders-2.4-9.1.100.EL
(the latest glibc-kernheaders for my system)

and my Centos 4.6 kernel is
$ uname -r
2.6.9-67.0.4.ELsmp

Is there still a way to compile bluez-utils 3.28 with my configuration?

thanks for your help,
John


Guillaume Bedot wrote:
> Hello,
>
> On mar, 2008-03-11 at 16:03 -0500, John E. Conlon wrote:
>   
>> bridge.c:78: error: `SIOCBRADDBR' undeclared (first use in this function)
>>     
> These types of messages usually mean you lack some headers (*.h).
>
> Here, you need to install the kernel headers
> ( http://www.google.fr/search?q=SIOCBRADDBR shows it's declared in
> include/linux/sockios.h )
>
> On CentOS, it seems to be in the kernel-devel package : 
> http://lists.centos.org/pipermail/centos/2006-October/071307.html
>
> Regards,
>
> Guillaume B.
>
>
>
>   


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
