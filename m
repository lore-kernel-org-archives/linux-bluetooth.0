Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hci.c  hacked
From: Erwin Authried <eauth@softsys.co.at>
To: "bluez-users@lists.sourceforge.net" <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY104-F16C20570F646F1FC09FE46C1990@phx.gbl>
References: <BAY104-F16C20570F646F1FC09FE46C1990@phx.gbl>
Content-Type: text/plain
Message-Id: <1104148357.20913.32.camel@justakiss>
Mime-Version: 1.0
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
Date: Mon, 27 Dec 2004 12:52:37 +0100

Am Mon, den 27.12.2004 schrieb blookk - um 12:36:
> Hello Marcel!
> 
> When I compiled the BlueZ for ARM7TDMI with uclibc 0.9.19  I detect a 
> problem in "hci.c" . In "poll" call because seems that my arquitecture 
> doesn't support this call. I modified the "hci.c" and use "select" instead 
> of "poll". The modification is this:
> 
The "poll" system call is unsupported in uClinux-2.0. With 2.4, it works
fine. If you are using 2.0, you can't use Bluez anyway.

Regards,
Erwin




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
