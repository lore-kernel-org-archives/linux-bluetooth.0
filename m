Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Nicholas A. Preyss" <nalp@gmx.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] packet types / speed (USB dongles)?
Message-ID: <20040527204855.GB3114@gmx.net>
References: <E1BTQag-0001L7-00@intern.SerNet.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1BTQag-0001L7-00@intern.SerNet.DE>
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
Date: Thu, 27 May 2004 22:48:55 +0200

On  0, Lutz Pressler <Lutz.Pressler@SerNet.DE> wrote:
> I've got CSR based USB dongles, for which hciconfig -a
> gives "Packet type: DM1 DH1 HV1". Whatever HV1 is,
> for DH1 http://www.holtmann.org/lecture/bluetooth/bt_primer.pdf
> reports payload rates of around 180 kbit/s.
> Now when querying the phone (Nokia 6230) I get as feature
> <HV3 packets>.
> Does this mean, that I could use e.g. DH3 with that phone
> (390 kbit/s symmetric or 586 / 86 asymmetric)?
> Which USB dongles would support that?

HV* are packets of an SCO connection. My understanding of the
specification ist that the speed of an SCO connection is always 
64kb/s. You need only larger HV Packets if you have several SCO
Connections which have to share bandwidth. 
Why SCO isn't usable for data transfer is explained several times in
mailinglist archive.

nicholas


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
