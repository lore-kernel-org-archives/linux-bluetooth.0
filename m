Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] yet another Barton Keyboard problem
From: Marcel Holtmann <marcel@holtmann.org>
To: Soenke von Stamm <bluez0406@elmo.dyn.lindenarea.net>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200406281843.14536.bluez0406@elmo.dyn.lindenarea.net>
References: <200406281843.14536.bluez0406@elmo.dyn.lindenarea.net>
Content-Type: text/plain
Message-Id: <1088442071.6030.14.camel@pegasus>
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
Date: Mon, 28 Jun 2004 19:01:11 +0200

Hi Soenke,

> I'm new to the list but I've read about another guy's problem with this kb in 
> the archive. My problem might be a little different as I assume my shiny 
> lilly Barton is jast broken.
> 
> I have purchased it just a few days back, plugged it into the next computer 
> (the originally supplied dongle that is) and wondered a bit why I couldn't 
> access the BIOS. I had jus read in c't that this should work... (and it works 
> with my Logitech Cordless Desktop via USB)
> 
> Further on under Linux (debian sid, 2.6.[67]-mh1/custom) after some trouble I 
> was able to attach the mouse which then also ran in hidproxy mode, but the kb 
> still refuses every connection attempt. On one machine I was able to see it 
> via 

<snip>

> As I've read the other thread I've tried each and every option described there 
> but nothing helps.
> 
> Now I'm wondering if I should just return the whole package because of the 
> non-operational hidproxy mode. Or I could bite the bullet and try with a 
> win98se install only for testing my hardware :-(

this is easy to answer, but it seems that actually nobodoy knows it. The
original HID proxy software needs the link key of the keyboard. At the
moment the Linux HID code don't asks for a PIN code when connectiong a
keyboard the first time. I worked on it, but I ran into troubles with
some non CSR chips. Once you connected your keyboard you only have to
request an authentication with "hcitool auth ..." and everything should
work afterwards.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
