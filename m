Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 29 Aug 2006 20:01:24 +0200
From: Stefan Seyfried <seife@suse.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20060829180123.GD12634@suse.de>
References: <20060822181532.6fea4851@localhost>
	<20060829110613.49f2a9a4@localhost>
Mime-Version: 1.0
In-Reply-To: <20060829110613.49f2a9a4@localhost>
Subject: Re: [Bluez-users] rfcomm hell
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Tue, Aug 29, 2006 at 11:06:13AM +0200, The Peach wrote:
> On Tue, 22 Aug 2006 18:15:32 +0200
> The Peach <smartart@tiscali.it> wrote:
> =

> > Objective: connect to the mobile (a nokia 6680) and to the GPS reciver
> =

> I found what was wrong, and it was udev.
> After following a tutorial I added the following rule to change the permi=
ssions upon dev creation:
> =

> # cat /etc/udev/rules.d/10-udev.rules =

> KERNEL=3D"rfcomm[0-9]*", NAME=3D"bluetooth/%k", GROUP=3D"users", MODE=3D"=
0660"
> =

> after commenting it rfcomm started connecting :-D

i have
root@susi:/tmp# cat /etc/udev/rules.d/47-rfcomm.rules
# udev-rules for rfcomm devices
KERNEL=3D=3D"rfcomm*", NAME=3D"%k" GROUP=3D"uucp" MODE=3D"0660" OPTIONS=3D"=
resmgr"

The OPTIONS=3Dresmgr is probably SUSE specific, but the rest should be gene=
ric
and works just fine for me.
-- =

Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, N=FCrnberg \                    -- Leonard Cohen

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
