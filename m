Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45072378.6010609@xmission.com>
Date: Tue, 12 Sep 2006 15:15:36 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <20060912201104.76329.qmail@web51409.mail.yahoo.com>
In-Reply-To: <20060912201104.76329.qmail@web51409.mail.yahoo.com>
Subject: Re: [Bluez-users] Poor audio quality with DBT120 and HS850
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

manojt

> I am trying to capture audio speech through throgh Motorola HS850
> headset  and DLink DBT120 dongle using Bluez 3.1 stack. I am able to
> capture audio through SCO channel using program similar to scotest. I am
> using . But the audio quality is not very good and voice is choppy. I
> am running sco audio capture program with high priority.
> Has anyone experienced this before?
> Pls let me know if there is any way to improve audio quality. Is there
> any other Dongle or headset that would work better.

there were some sco flow control patches to the kernel floating around
the list about a month ago. I'm not sure if they got incorporated. they
could help with quality problems resulting from incorrect pacing.

if you have the patch you'll have to do an ioctl to turn on flow control
in your app iirc.

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
