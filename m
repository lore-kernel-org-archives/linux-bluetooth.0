Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <200406140949.i5E9n0rE002726@news01.csr.com>
To: list bluez <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluepin 
In-reply-to: "Gene Imes"'s message of "Sat, 12 Jun 2004 17:56:21 CDT."
             <1087080981.21738.3.camel@tr1a.ozob.net>
From: Peter Stephenson <pws@csr.com>
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
Date: Mon, 14 Jun 2004 10:49:00 +0100

Gene Imes wrote:
> Anyone know how to fix this:
> 
> gene@tr1a:~> bluepin
> Xlib: connection to ":0.0" refused by server
> Xlib: No protocol specified

It's probably some kind of authorization problem.  Are you able
to

xauth merge ~/.Xauthority

?

-- 
Peter Stephenson <pws@csr.com>                  Software Engineer
CSR Ltd., Science Park, Milton Road,
Cambridge, CB4 0WH, UK                          Tel: +44 (0)1223 692070


**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept by
MIMEsweeper for the presence of computer viruses.

www.mimesweeper.com
**********************************************************************



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
