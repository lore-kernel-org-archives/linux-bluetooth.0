Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] epox-presenter
From: Marcel Holtmann <marcel@holtmann.org>
To: Rob Davis <rob.davis@virgin.net>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <401830B2.5070407@virgin.net>
References: <4017F953.1090108@virgin.net>
	 <1075314868.26729.34.camel@pegasus>  <401830B2.5070407@virgin.net>
Content-Type: text/plain
Message-Id: <1075355198.26729.58.camel@pegasus>
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
Date: Thu, 29 Jan 2004 06:46:38 +0100

Hi Rob,

> Okay, my first ever C hack...

no problem, because everyone has to start sometime :)

> Implemented three functions, back button triggers mouse button 4, next 
> button triggers mouse button 5, fn button triggers a keyboard alt + tab, 
> which changes window focus in kde, and probably gnome.
> 
> I have also reduced the speed of the pointer from 12 to 4, which I am 
> much happier with as I have a hope of landing on the correct window.

Can we get some command options to change this behaviour?

> Sorry, I'm not sure how to do patch, but the file is small...

take a look at "man diff" and do "diff -urN <orig> <modified>". It is
much more easier for me to look at a patch, because in most cases only
the changes matters.

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
