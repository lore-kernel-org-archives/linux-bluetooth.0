Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Daniel =?iso-8859-2?Q?Ko=F1czyk?= <drmartens@gnu.univ.gda.pl>
To: Michael Neumeier <dennismail@gmx.net>
Cc: bluez-users@lists.sourceforge.net
Message-ID: <20040125184702.GA31963@konczyk.net>
References: <1075019314.2741.5.camel@matos.local> <1075046122.5170.53.camel@baroque.rococosoft.com> <1075047563.3142.6.camel@matos.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <1075047563.3142.6.camel@matos.local>
Subject: [Bluez-users] Re: Cannot start bluepin
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
Date: Sun, 25 Jan 2004 19:47:02 +0100

Hi

On 25/01/04 17:19 +0100, Michael Neumeier wrote:
> Yes, I am running X. And I suppose that I have the right to use the
> display, as I tried to start bluepin under a console running in KDE
> (3.1.5). 
> I already thought in the same direction, but I guess this must be a
> special thing because I had never problems to use my display.

This script does not work..This was mentioned many times on the
list.
I use something much more simple, my pin file consists only of:
#!/bin/sh
echo "PIN:123456"

of course, you can change '123456' to whatever pin you like
works for me without any problems

-- 
Daniel Koñczyk
http://konczyk.net


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
