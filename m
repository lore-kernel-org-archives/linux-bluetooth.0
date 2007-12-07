Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Andrew Kohlsmith <aklists@mixdown.ca>
To: bluez-devel@lists.sourceforge.net
Date: Fri, 7 Dec 2007 09:37:20 -0500
References: <20071207092240.jtm1je3tcc4cwo40@www.nexusmail.uwaterloo.ca>
In-Reply-To: <20071207092240.jtm1je3tcc4cwo40@www.nexusmail.uwaterloo.ca>
MIME-Version: 1.0
Message-Id: <200712070937.20497.aklists@mixdown.ca>
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

On Friday 07 December 2007 09:22:40 gpolack@engmail.uwaterloo.ca wrote:
> I'm new to using Bluetooth modules and would appreciate some guidance.
> I'm connecting a Bluetooth module that has a UART interface to a
> microcontroller, and I wish to use the BlueZ protocol stack to talk to
> the module but I know nothing about how the protocol works. Can it be
> configured to talk via UART to the module? Also, what is the minimal
> set of functions one would need for simple data transfer between two
> Bluetooth modules, no stereo audio, or other fancy stuff? My questions
> will get more specific as I start understanding how this all works.

You want to use the hciattach.  I have used this on one of my MCF5282 designs 
when talking to A7eng's bluetooth modules.

hciattach creates an hci device and brokers all requests over the UART to the 
bluetooth module.  From that point on you use everyday standard utilities to 
manipulate the hci device that was created.

-A.

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
