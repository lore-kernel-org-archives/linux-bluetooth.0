Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Fri, 15 Sep 2006 13:37:29 +0200 (CEST)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <450A7871.2060608@infitsrl.com>
Message-ID: <Pine.LNX.4.63.0609151332060.28713@redbean.intranet.gw-instruments.de>
References: <3f5a9ba20609132122ue951876kcdfaacae30110f66@mail.gmail.com>
	<Pine.LNX.4.63.0609141101160.22339@redbean.intranet.gw-instruments.de>
	<450940DC.5080809@infitsrl.com>
	<Pine.LNX.4.63.0609141354070.22339@redbean.intranet.gw-instruments.de>
	<45094871.7010003@infitsrl.com>
	<Pine.LNX.4.63.0609141423350.22339@redbean.intranet.gw-instruments.de>
	<1158313465.5233.3.camel@localhost> <450A7871.2060608@infitsrl.com>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] About concurrency sdp_connect
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


Hi  Fabrizio,

On Fri, 15 Sep 2006, Fabrizio Guglielmino wrote:

> Hi,
> in my attempt to understand how the microsoft stack make this possible I 
> have tried to find hcidump an equivalent
> on windows to visualize hci command issued to the device. I've found 
> only commercial (and not cheap ) software, is
> there a software can I use to dump hci commands on windows?
> 
> many thanks
> 
I'm not aware of any. As far as I know the Microsoft Stack only supports 
USB devices, so you need some sort of USB Monitor (e.g. snoopy) to trace 
the HCI traffic. Have not tried it, but snoopy is GPL and it may be 
possible to hack it in a way that it gives you something usefull.  

Ciao, 

Peter

|       Peter Wippich                   Voice: +49 30 46776411          |
|       G&W Instruments GmbH            fax:   +49 30 46776419          |
|       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
|       D-13355 Berlin  / Germany                                       |


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
