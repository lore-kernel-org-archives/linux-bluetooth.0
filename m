Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <453AC28A.4010106@xmission.com>
Date: Sat, 21 Oct 2006 18:59:54 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <453AC0F8.4010207@sympatico.ca>
In-Reply-To: <453AC0F8.4010207@sympatico.ca>
Subject: Re: [Bluez-users] random blasts of noise when recording over btsco
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

Jonathan

> I have a logitech mobile freedom headest and an MSI BToes usb bluetooth
> dongle. They're working great on Ubuntu Edgy as far as playback goes,
> but audio recorded off the headset's microphone is interspersed with
> brief blasts of white noise.

Yes--it's a known problem. You should try Fabien's flow control patch
posted on -devel on 10/12.

Brad

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
