Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Simon Huggins <huggie@earth.li>
To: list bluez <bluez-users@lists.sf.net>
Subject: Re: [Bluez-users] bluepin
Message-ID: <20040613091328.GB27985@paranoidfreak.co.uk>
References: <1087080981.21738.3.camel@tr1a.ozob.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1087080981.21738.3.camel@tr1a.ozob.net>
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
Date: Sun, 13 Jun 2004 10:13:28 +0100

'ello list

On Sat, Jun 12, 2004 at 05:56:21PM -0500, Gene Imes wrote:
> Sorry about that. I inadvertantly tacked this to another thread. My
> apologies.

> Anyone know how to fix this:

> gene@tr1a:~> bluepin
> Xlib: connection to ":0.0" refused by server
> Xlib: No protocol specified

> Traceback (most recent call last):
>   File "/usr/bin/bluepin", line 39, in ?
>     import gtk
>   File "/usr/lib/python2.3/site-packages/gtk-2.0/gtk/__init__.py", line
> 43, in ?    from _gtk import *
> RuntimeError: could not open display

You're trying to run the python-gtk bluez pin helper.  Are you actually
in X?

You could change your pin helper to just be:
#!/bin/sh
echo "PIN:1234"

or whatever yours is and the corresponding pin_helper line in hcid.conf

I guess ultimately you might want the python-gtk helper to work though.

Simon.

-- 
        Black Cat Networks        -( "I'm gonna eat you, little fishy!"  )-
UK domain, email and web hosting  -(              - The Cat              )-
http://www.blackcatnetworks.co.uk -(                                     )-


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
