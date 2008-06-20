Return-Path: <cyrus@holtmann.org>
Message-ID: <01ac01c8d2a1$3afebdc0$6e01a8c0@Raymondpc>
From: "colorant" <colorant@163.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
References: <a481fbf0806190642u6732d93ew7aec2f17d05dc4d8@mail.gmail.com>
	<016a01c8d27c$2c0a4f70$6e01a8c0@Raymondpc>
Date: Fri, 20 Jun 2008 14:45:29 +0800
MIME-Version: 1.0
Subject: Re: [Bluez-users] How to using security "Auto" in pairing ,
	I tried but not working ?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi

I found in some way , it works, as below:

> Hi
>
>    I do not have passkey-agent running , so I try to use auto for security
> and hope it can send back the passkey auto.
>
> My setting in hcid.conf is as below :
>
> options {
>        # Automatically initialize new devices
>        autoinit yes;
>        security auto;
>        pairing multi;
>        offmode devdown;
>        # Default PIN code for incoming connections
>        passkey "1234";
> }
>
> But this don't work :

I found the behavior is :

If I initiate a bonding through dbus, this won't working.
But if the bonding request is initiate from remote, this auto security 
setting can work , and will send the passkey as in the conf file.

If I using security user, and use passkey-agent --default <pin> as the 
agent.
Then , no matter the bonding is initiate from which side , it will always 
working.

Is the auto procedure designed to doing so  ?

Thanks.

Raymond









-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
