Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Cannot start bluepin
From: Stephen Crane <steve.crane@rococosoft.com>
To: Michael Neumeier <dennismail@gmx.net>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <1075019314.2741.5.camel@matos.local>
References: <1075019314.2741.5.camel@matos.local>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1075046122.5170.53.camel@baroque.rococosoft.com>
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
Date: Sun, 25 Jan 2004 15:55:25 +0000

Are you running X? Does the user under which you are running bluepin
have permission to use DISPLAY? (Test this by trying to start an xterm.
If this fails, see xauth.)

On Sun, 2004-01-25 at 08:28, Michael Neumeier wrote:
> When I try to start bluepin (only for testing purposes, no device
> connected) I get follwoing message:
>=20
>   File "/bin/bluepin", line 34, in ?
>     from gtk import *
>   File "/usr/lib/python2.3/site-packages/gtk-2.0/gtk/__init__.py", line
> 43, in ?
>     from _gtk import *
> RuntimeError: could not open display
>=20
> I tried to update the python.packages, but this didn=B4t solve the
> problem.=20
> Any ideas?
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> The SF.Net email is sponsored by EclipseCon 2004
> Premiere Conference on Open Tools Development and Integration
> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> http://www.eclipsecon.org/osdn
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
--=20
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
