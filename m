Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: CIJOML <cijoml@volny.cz>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Sat, 16 Sep 2006 17:27:43 +0200
References: <3ac7eec00608300143q7cb7a371n87179b310b6dfc80@mail.gmail.com>
In-Reply-To: <3ac7eec00608300143q7cb7a371n87179b310b6dfc80@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200609161727.44085.cijoml@volny.cz>
Subject: Re: [Bluez-users] Microsoft Intellimouse Explorer for Bluetooth
	Sidebuttons and scrollwheel
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-2"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

I own 1st generation (no tilt wheel) and in xorg everythink works for me wi=
th =

this setup:

Section "InputDevice"
       Identifier      "Bluetooth Mouse"
       Driver          "mouse"
       Option          "SendCoreEvents"        "true"
        Option          "Device"                "/dev/input/mice"
        Option          "Protocol"              "ExplorerPS/2"
        Option          "ZAxisMapping"          "4 5"
        Option          "Buttons"               "7"
        Option          "Emulate3Buttons"       "false"
        Option          "Name"                  "AutoDetected"
       Option          "Vendor"                "AutoDetected"
EndSection

I have hidd running with /usr/bin/hidd --master --server

Hope this will help you

Michal

Dne st=F8eda 30 srpen 2006 10:43 Maik Barz napsal(a):
> Hi everyone,
> for a long time I am trying to get my mouse completely working on my Suse
> 10.1 system.
> Three buttons do work, but scrollwheel and sidebuttons do not seem to fire
> events. I heard about patching my kernel will help out. Is this true or a=
re
> there some other solutions to this problem?
>
> Any hints?
>
> Greets Maik

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
