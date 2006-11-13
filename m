Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45589002.7060505@xmission.com>
Date: Mon, 13 Nov 2006 08:32:18 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <200611091102.54282.marcel@hilzinger.hu>	<20061109104245.GB7085@physik.fu-berlin.de>
	<1163066853.5983.24.camel@grappa>
In-Reply-To: <1163066853.5983.24.camel@grappa>
Subject: Re: [Bluez-devel] Quality of a2dp sound
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

Reiner

> What I did notice is that the volume could be higher and there is the
> occasional faint clicking which might be due to clipping.

I did try to hunt these down for a good while but didn't have a lot of 
luck. It came down to a balance of one problem or the other. :(

I was thinking recently both these could be solved by doing dynamic 
compression before encoding the audio. It would reduce the dynamic range 
however.

Brad

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
