Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] DBUS service support - poll patch
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb05060313345fb564a3@mail.gmail.com>
References: <1115901694.18499.32.camel@pegasus>
	 <1116844053.30044.59.camel@pegasus>
	 <e1effdeb050523080216e96744@mail.gmail.com>
	 <1116925644.30044.140.camel@pegasus>
	 <e1effdeb050525152067a5cbd3@mail.gmail.com>
	 <1117098491.12036.23.camel@pegasus>
	 <e1effdeb05052614222118e70c@mail.gmail.com>
	 <1117143615.12036.74.camel@pegasus>
	 <e1effdeb050530154229f338a2@mail.gmail.com>
	 <1117494345.7072.235.camel@pegasus>
	 <e1effdeb05060313345fb564a3@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1117836644.3656.100.camel@pegasus>
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
Date: Sat, 04 Jun 2005 00:10:44 +0200

Hi Claudio,

> A new patch is available using a main loop and poll to wait for some event 
> on a file descriptor list (D-Bus and Bluetooth).
> 
> All Glib and pthread dependencies were remove.

I just had some some time for a quick review. It is not fully what I had
in mind, but it is something from what we can work onwards. I think it
is a good idea to include it into release 2.18 and then start on
improving it.

Since I am away the next week you might wanna address the coding style
issues in that time. Read the paper from Greg KH from the OLS 2002. I
think it gives a very good understanding on it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
