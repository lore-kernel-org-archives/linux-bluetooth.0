Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Pairing a keyboard
Message-ID: <20041125075755.GC2505@frostnet.net>
References: <20041125064110.GA2505@frostnet.net> <1101367010.7538.78.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1101367010.7538.78.camel@pegasus>
From: Chris Frost <chris@frostnet.net>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 24 Nov 2004 23:57:55 -0800

On Thu, Nov 25, 2004 at 08:16:49AM +0100, Marcel Holtmann wrote:
> who said that pairing works by calling "hcitool cc ..."? You should use
> the "hidd --connect ..." command instead.

No one did; I had tried hidd --connect but got the same errors. Sorry about
this mistake, thanks for the correction.


> The bluepin script must echo "PIN:0000".

Aha, that gets it. Thank you.

Do you know if I should I read about/look into putting the keyboard to
sleep after inactivity? I have read in a couple places on the web that apple's
devices do not go to sleep themselves, but perhaps what I read was old and
bluez does this automatically now?

-- 
Chris Frost  |  <http://www.frostnet.net/chris/>
-------------+----------------------------------
Public PGP Key:
   Email chris@frostnet.net with the subject "retrieve pgp key"
   or visit <http://www.frostnet.net/chris/about/pgp_key.phtml>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
