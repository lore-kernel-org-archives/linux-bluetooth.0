Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20061110213915.58e6cabf@nim.leo>
References: <20061110213915.58e6cabf@nim.leo>
Date: Mon, 13 Nov 2006 09:09:54 +0100
Message-Id: <1163405394.26272.31.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Disconnect errors on 2.6.18-mh7
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Paul,

> I've got a custom-built 2.6.18 patched with mh7 on my desktop machine,
> with a Logitech Cordless Elite Blutooth Keyboard and Mouse combo. Up
> until 2.6.16 these worked fine. 2.6.17 has unrelated-to-bluez issues with
> my graphics card. On 2.6.18, I can connect the keyboard/mouse on startup,
> but if I let them idle too long, they disconnect in an unrecoverable way,
> requiring me to ssh from another box and run "hidd --search" while
> simultaneously pressing the "connect" button on the keyboard or mouse.
> 
> I'm not sure quite when it happens, but it would seem to be related to
> lines of the following occuring in dmesg:
> 
> net/bluetooth/hidp/hid.c: event field not found
> 
> Is this a bug that's crept in to 2.6.18, or perhaps a hardware issue, or
> what? Anything I can attempt to debug it with?

run "hcidump -X -V" and show us the result for the disconnect phase and
the failed attempt to re-connect.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
