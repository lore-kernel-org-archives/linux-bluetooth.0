Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20041220180425.9191.qmail@web11601.mail.yahoo.com>
From: "Bhaskar S. Manda" <bhaskar_manda@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Socket version F not recognized on SL-6000
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
Date: Mon, 20 Dec 2004 10:04:25 -0800 (PST)

cardctl ident shows product info matching that in
/etc/pcmcia/bluetooth.conf, but doesn't load dtl1_cs.

# cardctl ident
Socket 0:
  product info: "Socket", "CF+ Personal Network Card"
  manfid: 0x0104, 0x009f
  function: 254 ((null))

And apparently because of this hciconfig has no output. The only other
postings I've seen related to this had at least the card's function
identified as "serial", but mine isn't getting even to that point, as
the driver dtl1_cs for this card isn't being associated with the
physical card being inserted.

All suggestions appreciated, thanks.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
