Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Fri, 7 Dec 2007 15:40:49 +0100 (CET)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20071207092240.jtm1je3tcc4cwo40@www.nexusmail.uwaterloo.ca>
Message-ID: <Pine.LNX.4.63.0712071526020.24788@redbean.intranet.gw-instruments.de>
References: <20071207092240.jtm1je3tcc4cwo40@www.nexusmail.uwaterloo.ca>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] BlueZ protocol stack on microcontroller
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


Jorge,

> Hello,
> 
> I'm new to using Bluetooth modules and would appreciate some guidance.  
> I'm connecting a Bluetooth module that has a UART interface to a  
> microcontroller, and I wish to use the BlueZ protocol stack to talk to  
> the module but I know nothing about how the protocol works. Can it be  
> configured to talk via UART to the module? Also, what is the minimal  
> set of functions one would need for simple data transfer between two  
> Bluetooth modules, no stereo audio, or other fancy stuff? My questions  
> will get more specific as I start understanding how this all works.
> 
> Thank you,
> Jorge

when your micro runs linux, then you should use Bluez. But from your mail
I suggest it doesn't. Than BlueZ won't be an real option because it
heavily depends on the operating system.
 
In the latter case you may
a) buy a commercial BT stack which is not OS dependend.
b) write your own stack (I don't think to use BlueZ as a base would be a  
good idea)
c) use a BT chip / modul with build in stack

Ciao, 

Peter 




|       Peter Wippich                   Voice: +49 30 46776411          |
|       G&W Instruments GmbH            fax:   +49 30 46776419          |
|       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
|       D-13355 Berlin  / Germany                                       |


-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
