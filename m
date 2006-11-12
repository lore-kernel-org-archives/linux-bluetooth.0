Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45578488.3080802@xmission.com>
Date: Sun, 12 Nov 2006 13:31:04 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <200611091102.54282.marcel@hilzinger.hu>	<200611101046.02426.mhilzinger@linuxnewmedia.de>	<1163233279.7400.58.camel@grappa>
	<200611121938.39415.marcel@hilzinger.hu>
In-Reply-To: <200611121938.39415.marcel@hilzinger.hu>
Subject: Re: [Bluez-devel] RE :  Quality of a2dp sound
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

Marcel

> Btw. is there a possibitily to  use the micro under Linux or is a2dpd a 
> one-way-connection?

All the combo sco/a2dp headphones I've seen only use the microphone for
plain sco--they disable the microphone when a2dp audio is streaming.

The a2dp spec leaves it open for implementors to work in the mic by
doing both a2dp source and sink, but the latency in practice for a2dp is
around 250ms. It would be pretty awful for voip to add that in both
directions.

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
