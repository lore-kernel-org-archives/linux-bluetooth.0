Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm shouldn't fail silently
From: Marcel Holtmann <marcel@holtmann.org>
To: Edd Dumbill <edd@usefulinc.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1075135629.12874.339.camel@saag>
References: <1075133668.12874.328.camel@saag>
	 <1075135361.25442.57.camel@pegasus>  <1075135629.12874.339.camel@saag>
Content-Type: text/plain
Message-Id: <1075136125.25442.77.camel@pegasus>
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
Date: Mon, 26 Jan 2004 17:55:25 +0100

Hi Edd,

> > > rfcomm shouldn't fail silently if an invalid command is given to ie.
> > 
> > it does not fail silently. It show the the list of bonded devices.
> 
> If none are bonded, it is silent :)
> 
> The point was there should be a usage error output.

actually the problem is an unknown command with no extra parameters. Try
these two and see what happens:

	rfcomm test
	rfcomm test abc

I don't care so much about it, but I will accept patches for this
problem. Should not be so hard to fix, but at the moment I have to deal
with some other stuff.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
