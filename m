Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: O Plameras <oscarp@acay.com.au>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4167DB4C.6000504@acay.com.au>
References: <41629C2B.4040201@3wt.com.br>
	 <1096991861.20349.73.camel@pegasus>  <4162D886.8010406@3wt.com.br>
	 <1097055892.4937.3.camel@pegasus>  <4167DB4C.6000504@acay.com.au>
Content-Type: text/plain
Message-Id: <1097329902.12972.1.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-users] Re: rfcommX and ppp
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 09 Oct 2004 15:51:43 +0200

Hi,

> > try to use 10.0.0.1: or other way around. Or you can define multiple
> > options.rfcommX files in /etc/ppp/ and use a bridge. There are some ways
> > to get this working.
> 
> I learned from PPP lists that ppp0 interface bridging is not supported
> nor is their a patch under 2.6.x or pppd.
> 
> When I do this,
> brctl addif br0 ppp0
> 
> it returns,
> br_add_interface: Invalid argument
> 
> Nobody is doing work on these at the moment is my understanding.

this is a question for the bridge people. Using PPP over RFCOMM is
deprecated by the Bluetooth SIG and using PAN is much more straight
forward how things should be.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
