Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Pavel Ruzicka <pavouk@pavouk.org>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] btsco - headset profile activated but no sco packets transmitted ???
References: <20050404194542.GA7640@lsweb.de> <200504042322.17493.pavouk@pavouk.org> <f54d86405041222381e9da934@mail.gmail.com>
In-Reply-To: <f54d86405041222381e9da934@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200504141632.49910.pavouk@pavouk.org>
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
Date: Thu, 14 Apr 2005 16:32:49 +0200

Hello,

> I have taken the latest CVS "btsco" files and compiled. Fedora 3(linux
> kernel 2.6.9-1.667) runs on my host PC. I have taken the latest Bluez
> libraries and utilities from the bluez site.

you can try latest kernel 2.6.11.x
This works for me.

> The SCO connection is opened
> only when I press "play" for the xmms and it closes when I stop the
> song. Whether I can test the mic functionality separately.

For me is SCO connection opened from xmms or from mic
"cat </dev/dsp1 >/dev/dsp0".
Both works simultaneously.

> But my target application is a chat application with the usage of
> Speaker and mic working simultaneosly.
>
> Please advice of the setting I need to make.

I don't know what other I can tell you. For me it's working.

Best regards,

Pavel Ruzicka


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
