Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Lutz Pressler <Lutz.Pressler@SerNet.DE>
To: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <E1BTQag-0001L7-00@intern.SerNet.DE>
Subject: [Bluez-users] packet types / speed (USB dongles)?
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
Date: Thu, 27 May 2004 21:30:58 +0200 (CEST)

Hallo,

I've got CSR based USB dongles, for which hciconfig -a
gives "Packet type: DM1 DH1 HV1". Whatever HV1 is,
for DH1 http://www.holtmann.org/lecture/bluetooth/bt_primer.pdf
reports payload rates of around 180 kbit/s.
Now when querying the phone (Nokia 6230) I get as feature
<HV3 packets>.
Does this mean, that I could use e.g. DH3 with that phone
(390 kbit/s symmetric or 586 / 86 asymmetric)?
Which USB dongles would support that?

Lutz

-- 
  _              |  Lutz Pressler          |  Tel: ++49-551-3700002
 |_     |\ |     |  Service Network GmbH   |  FAX: ++49-551-3700009
 ._|ER  | \|ET   |  Bahnhofsallee 1b       |   mailto:lp@SerNet.DE
Service Network  |  D-37081 Goettingen     |  http://www.SerNet.DE/



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
