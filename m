Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Problem with link keys
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050806050145.GA11152@as.arizona.edu>
References: <20050806030119.GA10008@as.arizona.edu>
	 <1123301455.26693.4.camel@pegasus>  <20050806050145.GA11152@as.arizona.edu>
Content-Type: text/plain
Message-Id: <1123304874.7296.3.camel@pegasus>
Mime-Version: 1.0
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
Date: Sat, 06 Aug 2005 07:07:53 +0200

Hi John,

> >> I do not see any "reply negative" messages in any of the hcidump output yet it
> >> doesn't work until I make a new key.
> >
> >use "hcidump -X -V".
> 
> The -V helps a lot.  I have attached a short hcidump listing from when I power
> on the headset and it attempts to make a connection and fails.
> 
> >> Am I doing something wrong or in the wrong order?  This is with the current
> >> bluez packages from Debian unstable (amd64 port).
> >
> >Is the link key valid if you don't power cycle your headset, but
> >disconnect and then reconnect? If yes, then your headset is maybe
> >broken.
> 
> Yes.  I was able to do the following:
> 
> hcitool cc bdaddr
> hcitool dc bdaddr
> hcitool cc bdaddr
> hcitool info bdaddr
> 
> And it is working just fine.  It only seems to misbehave when I power it off.
> Are any other people on this list using a Plantronics M2500 headset and, if
> so, are you experiencing anything similar?

I see always a authentication failure in your log. This means you never
succeeded with your command or you send the wrong log. However the usage
of "hcitool cc ..." doesn't qualifies for a correct headset/handsfree
profile setup and thus your headset may forget your link key. Use tools
like hstest of btsco and try again.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
