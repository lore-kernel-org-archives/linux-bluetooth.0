Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Microsoft bluetooth mouse - wheel support
References: <BAY101-F1422133B054DDDB019EEE9A78C0@phx.gbl>
In-Reply-To: <BAY101-F1422133B054DDDB019EEE9A78C0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200501151121.40506.cijoml@volny.cz>
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
Date: Sat, 15 Jan 2005 11:21:40 +0100

Section "InputDevice"
        Identifier      "Bluetooth Mouse"
        Driver          "mouse"
        Option          "SendCoreEvents"        "true"
        Option          "Device"                "/dev/input/mice"
        Option          "Protocol"              "ExplorerPS/2"
        Option          "ZAxisMapping"          "4 5"
        Option          "Buttons"               "5"
        Option          "Emulate3Buttons"       "false"
        Option          "Name"                  "AutoDetected"
        Option          "Vendor"                "AutoDetected"
EndSection

Michal

Dne so 15. ledna 2005 09:07 Russell Turner napsal(a):
> Hi Everyone,
>   I have successfully upgraded my Debian kernel to 2.6.10 (including the
> patch-2.6.10-mh1) and connected my mouse by
>
> modprobe hidp
> hidd --server
>
> But no scroll wheel support! If I type "hidd --show" I get
> 00:50:F2:E8:5E:FA HID Boot Device [045e:0098] connected [boot-protocol]
>
> So it seems that I get only a boot-mode connection. If I run xev it shows
> no activity when I use the scroll-wheel.
>
> Can anyone please help me about how I can get scroll-wheel support for my
> lovely blue mouse!
>
> Thanks.
>
> Russell.
>
>
>
>
> -------------------------------------------------------
> The SF.Net email is sponsored by: Beat the post-holiday blues
> Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
