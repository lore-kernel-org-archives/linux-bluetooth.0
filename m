Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: "Aveek Adhya" <aveek@rebaca.com>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Wed, 6 Jun 2007 18:46:17 +0530
MIME-Version: 1.0
In-Reply-To: <1180706166.25009.46.camel@cookie.hadess.net>
Message-ID: <E1HvvNZ-0000Kh-BO@mail.sourceforge.net>
Subject: Re: [Bluez-devel] connect fail : Operation now in progress
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

I didn't find any major difference between my application and 'manager.c' in
bluez-utils. The way it calls socket(), bind(), connect() etc are same as
what I am doing. Do you think it can be a baudrate problem as RFCOMM is a
serial communication after all? ... 

-----Original Message-----
From: Bastien Nocera [mailto:hadess@hadess.net] 
Sent: Friday, June 01, 2007 7:26 PM
To: BlueZ development
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-devel] connect fail : Operation now in progress

On Fri, 2007-06-01 at 19:18 +0530, Aveek Audhya wrote:
> Hi Nocera,
> 
>       Thanks for your reply. What I have seen is that my socket's fd
> is by default blocking, every time it returns -1 after waiting for
> sometime. If I set it as non-blocking then it returns -1 immediately.
>  
> 
>       I have set up a watcher with select() and getsockopt() call. 
> 
> It's like that ....
<snip>
> Unfortunately I couldn't find 'manager.c' in
> 'bluez-utils-3.9/serial/'. The folder doesn't contain any .c file
> except Makefile, Makefile.am and Makefile.in. 'manager.c' is present
> only in 'bluez-utils-3.9/daemon' folder, but there is no
> 'rfcomm_connect()' implementation. Probably we are using different
> utils version.

See in CVS, or in bluez-utils 3.11.




-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
