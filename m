Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Cannot start bluepin
From: Michael Neumeier <dennismail@gmx.net>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1075046122.5170.53.camel@baroque.rococosoft.com>
References: <1075019314.2741.5.camel@matos.local>
	 <1075046122.5170.53.camel@baroque.rococosoft.com>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1075047563.3142.6.camel@matos.local>
Mime-Version: 1.0
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
Date: Sun, 25 Jan 2004 17:19:23 +0100

Yes, I am running X. And I suppose that I have the right to use the
display, as I tried to start bluepin under a console running in KDE
(3.1.5). 
I already thought in the same direction, but I guess this must be a
special thing because I had never problems to use my display.

Am So, den 25.01.2004 schrieb Stephen Crane um 16:55:
> Are you running X? Does the user under which you are running bluepin
> have permission to use DISPLAY? (Test this by trying to start an xterm.
> If this fails, see xauth.)
> 
> On Sun, 2004-01-25 at 08:28, Michael Neumeier wrote:
> > When I try to start bluepin (only for testing purposes, no device
> > connected) I get follwoing message:
> > 
> >   File "/bin/bluepin", line 34, in ?
> >     from gtk import *
> >   File "/usr/lib/python2.3/site-packages/gtk-2.0/gtk/__init__.py", line
> > 43, in ?
> >     from _gtk import *
> > RuntimeError: could not open display
> > 
> > I tried to update the python.packages, but this didn´t solve the
> > problem. 
> > Any ideas?
> > 
> > 
> > 
> > 
> > -------------------------------------------------------
> > The SF.Net email is sponsored by EclipseCon 2004
> > Premiere Conference on Open Tools Development and Integration
> > See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> > http://www.eclipsecon.org/osdn
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
