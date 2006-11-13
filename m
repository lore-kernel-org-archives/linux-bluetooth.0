Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Reiner Klenk <pdq808@t-online.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200611121938.39415.marcel@hilzinger.hu>
References: <200611091102.54282.marcel@hilzinger.hu>
	<200611101046.02426.mhilzinger@linuxnewmedia.de>
	<1163233279.7400.58.camel@grappa>
	<200611121938.39415.marcel@hilzinger.hu>
Date: Mon, 13 Nov 2006 19:37:02 +0100
Message-Id: <1163443022.7965.30.camel@grappa>
Mime-Version: 1.0
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

On Sun, 2006-11-12 at 19:38 +0100, Marcel Hilzinger wrote:

> 
> Thanks a lot for these explanations. I knew, that sco and a2dp are different 
> profiles, but I didn not know, that the kernel module handles "only" sco, 
> because the command to play is called a2play...
> 
?? 
snd-bt-sco and running btsco => SCO (bi-directional)

a2play, a2dp alsa plugin, a2dpd => three different possibilities for
a2dp (one-way)

> Btw. is there a possibitily to  use the micro under Linux or is a2dpd a 
> one-way-connection?
> 
It can be used in SCO connections, for example with ekiga.
 
> > To use "old-style" a2dp with amarok:
> > .asoundrc like this:
> >
> > pcm.headphone {
> >         type a2dp
> >         bdaddr "00:13:17:71:58:F6"
> > }
> >
> > Note the a2dp in the second line (not a2dpd). Replace the address with
> > the one of your headset. Do _not_ run the a2dpd daemon.
> But load the kernel module?
> 
Can be loaded, but is not required for a2dp. 


-- 
debb1046 (gmail.com, gtalk, jabber.org, ekiga.net, last.fm, skype)


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
