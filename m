Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44F9B8F8.3070902@xmission.com>
Date: Sat, 02 Sep 2006 11:01:44 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44EC8877.8050200@palmsource.com>
	<44F5A472.30003@xmission.com>	<44F7088F.6090606@palmsource.com>
	<44F9AC89.7060309@xmission.com>
In-Reply-To: <44F9AC89.7060309@xmission.com>
Subject: Re: [Bluez-devel] Big patch to a2dpd
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

hey

> argh... another problem...
> 
> when I just sent that last message via wifi while streaming with xmms,
> the audio turned choppy (works for 1s, silence for 1s, repeat) and it
> never started working again even after no wifi activity :(

whoops... not sure if this is better or worse.

what actually happened is my wifi stopped working during the a2dp
streaming. so the computer demand-dialed using my cellphone over
bluetooth and that's when the trouble started. so maybe it would have
recovered once the dun connection was closed.

my r35 is a combo hfp/hsp so it does like to be master and doesn't like
scatternetting. funny if you think about it... the network was a
fully-connected triangle between the three devices when the audio was
breaking up.

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
