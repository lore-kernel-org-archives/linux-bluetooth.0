Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050324051223.69025.qmail@web8508.mail.in.yahoo.com>
From: mahabaleshwara k <mahabaleshwara_k@yahoo.co.in>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] Re: Re:cross compilation of BlueZ for MIPS
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 24 Mar 2005 05:12:23 +0000 (GMT)

Hi Marcel,
>this actually means that your kernel contains another
>backport that is not mainline. The -mh patches are
only >tested with mainline. In your case replacing
that line >with "set_user_nice(current, -15);" may
helps.
It worked. Now i have both BNEP and HIDP support
embedded into kernel. To test it, as i mentioned i am
struggling in cross compiling bluez-utilis. I have
seen postings in bluez-devel archives. But there is no
solution mentioned about successful bluz-utilis cross
compilation. I haven't  created any other config or
makefile. I am using same configure file which is
their in the bluez-utils. 
If Stephen has got solution can you share with me?
Regards,
Maha.

 


________________________________________________________________________
Yahoo! India Matrimony: Find your life partner online
Go to: http://yahoo.shaadi.com/india-matrimony


-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
