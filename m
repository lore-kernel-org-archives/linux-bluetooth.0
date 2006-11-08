Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45526DAB.4090004@xmission.com>
Date: Wed, 08 Nov 2006 16:52:11 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <eeu5cm$25p$1@sea.gmane.org>
In-Reply-To: <eeu5cm$25p$1@sea.gmane.org>
Subject: Re: [Bluez-devel] btsco, udev and other issues
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Mark

> 1. I have seen several reports that indicate btsco can be run as a regular
>    user. But I have only been able to run it as root. When I run it as a
>    regular user I get:
>          btsco v0.42
>          Error: control open (hw:1): No such device
>          Error: Can't find device. Bail
> 
> 2. As a consequence of running btsco as root, the newly created sound device
>    cannot be seen by regular users. What udev rule should I set so that the
>    BT headset is seen by other users when btsco is run by root?

Maybe regular users can't initiate the kernel module load. In any case I 
am accepting patches for the btsco kernel mod stuff but I will be 
focusing on the pure userspace plugins myself.

> 3. While using btsco with Skype, a lot of message like the following appear
>    on syslog:
>       kernel: snd-bt-sco: Shift problem detected! Fixing to 1.
>       kernel: snd-bt-sco: Shift problem detected! Fixing to 0.
>    What do they mean? Should I be worried about them?

This is related to the sco flow control problem. If you are not getting 
static, you can ignore these messages. If you are getting static, see 
the kernel patches on the wiki page at 
https://help.ubuntu.com/community/BluetoothAudio

brad

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
