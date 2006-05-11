Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Peter Wippich <pewi@gw-instruments.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SCO for non-CSR based devices?
In-Reply-To: <44634846.3000006@xmission.com>
Message-ID: <Pine.LNX.4.63.0605111727560.7379@redbean.intranet.gw-instruments.de>
References: <4461A33F.1060702@killesreiter.de> <44634846.3000006@xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 11 May 2006 17:31:05 +0200 (CEST)


Hi Gerhard,

I'm sorry to tell you that with the Sphinx card SCO is not supported at 
all. It uses one of the first available Ericson BT Moduls and this modul 
does not support SCO over H4.

Ciao, 

Petr 

On Thu, 11 May 2006, Brad Midgley wrote:

> Gerhard
> 
> > I've recently purchased a bluetooth headset and discovered that my
> > bluetooth adapter (a pcmcia card,
> > http://www.sphinx-elektronik.de/deutsch/bluetooth/picocard.htm) isn't
> > supported by bluetooth-alsa as there is no SCO support for this type of
> > device.
> > 
> > During my searches on the web I noticed a kernel patch that was recently
> > posted to this list
> > (http://article.gmane.org/gmane.linux.bluez.devel/7579).
> 
> I think the patch you linked to is a quirk that is only employed if a
> specific adapter is found and currently that list only has one adapter
> in the list to watch.
> 
> The mtu fix will be applied regarless of the adapter if you use
> http://bluetooth-alsa.sourceforge.net/sco-mtu.patch
> 
> If Marcel accepts the first approach upstream and the mtu fix really
> works for you, we'll need to find out how to get the quirk to apply for
> your adapter.
> 
> Brad
> 
> 
> -------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
