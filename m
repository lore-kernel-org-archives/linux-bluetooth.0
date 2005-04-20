Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] headerfile depencies
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <426649B8.1070203@gmx.ch>
References: <426649B8.1070203@gmx.ch>
Content-Type: text/plain
Message-Id: <1114000197.2469.159.camel@pegasus>
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
Date: Wed, 20 Apr 2005 14:29:57 +0200

Hi Marco,

>  From hluez-libs 2.15 to bluez-libs 2.16, bluetooth.h doesn't anymore 
> include the stdio.h (or changes where made and stdio.h went forgotten).
> 
> So the user has to include it in his own program, even if he doesn't need it.
> This might be more a c specific question, but aren't header files supposed 
> to handle their requirements themselve?
> Please note that I'm not a c expert. This is a question, not a accusation...

I already fixed it in the CVS. I always include stdio.h in my C files
and so this slipped through my eyes.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
