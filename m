Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Two simultanous connections
From: Marcel Holtmann <marcel@holtmann.org>
To: Pierre N <pierren@mac.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1080993011.12261.12.camel@localhost>
References: <1080928843.9541.90.camel@localhost>
	 <1080929429.2836.101.camel@pegasus>  <1080993011.12261.12.camel@localhost>
Content-Type: text/plain
Message-Id: <1080994581.2839.26.camel@pegasus>
Mime-Version: 1.0
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
Date: Sat, 03 Apr 2004 14:16:21 +0200

Hi Pierre,

> hcitool -a shows "invalid option -- a".

who said that hcitool have an "-a" option.

> This is the bluetooth chip of an iPaq 3970. It's running Familiar
> stable, so it must be a pretty old bluez version. Don't know if it
> helps...

This uses HCI 11.2 firmware and this means that you are able to create
master of up to four slaves or slave of one master.

> Ok, I knew I had to give more details... I create links between 3 iPaqs.
> I tried using higher layer protocols to do so. Never worked. I'm just
> trying to do a TCP/IP network so I can run XML-RPC on top of it, ssh
> etc...
> 
> That's all I need. I tried to use pan, never worked, I tried to use dun
> over pan, never worked, I tried to use rfcomm never worked. Always the
> same problem:
> I could connect A to B and B to C, never B to A and C to A. 
> 
> Now I went the hcitool route. Created my own connections very very
> easily. I connected B to A and C to A (A master). Ran dund _after_
> hcitool connections and everything is running great.
> 
> hcitool con on A gives me two master connections. These connections have
> been initialised from B and C as slave. So I can have two master
> connections, but I can't create them from A. First one works, second one
> doesn't, nothing happen. It's just out of curiosity.

Actually I don't see your problem. Let one iPAQ be the master and the
other connect as slaves.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
