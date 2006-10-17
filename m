Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: 17 Oct 2006 18:21:00 +0200
From: Dietmar Segbert <trebges@web.de>
To: <bluez-users@lists.sourceforge.net>
Message-ID: <A32i87f9SyB@trebges.web.de>
In-Reply-To: <1160984127.5498.0.camel@localhost>
References: <1160984127.5498.0.camel@localhost>
Subject: Re: [Bluez-users] PIN Authentication Problems on MDV 2007
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello Marcel,

> marcel@holtmann.org schrieb am 17.10.06:
>>>> starting with bluez-utils-3.x the PIN helper concept has been
>>>> replaced with a passkey agent interface. You need to run a
>>>> passkey agent to get you PIN request dialog. One example would
>>>> be bt-applet from the bluez-gnome package
i have compiled bluez-utils-3.7 and copied the passkey-agent from the
hcid/ to /usr/local/bin manually.

I have googled and i find a line

passkey-agent --default /usr/bin/bluepin

to start the agent.

but where i can find "blupin".

I have not installed gnome on my system and so i can't compile bluez-
gnome. I only use a textbased slackware 10.2 with speakup and brltty for
speech and braille.

Must i install an other key-agent?

Thanks for your help.

Dietmar

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
