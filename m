Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Jouni.Lohikoski@iki.fi" <jlohikos@cc.hut.fi>
To: bluez-users@lists.sourceforge.net
Message-ID: <20041017125132.GA274769@kosh.hut.fi>
Reply-To: Jouni.Lohikoski@iki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] HID mouse doesnt reconnect after sleep if bemused-bemusedlinuxserver connection is open
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
Date: Sun, 17 Oct 2004 15:51:33 +0300


Hi all,
 
I have Epox BT-dongle, Epox CP-BT-MS02B HID mouse, Nokia S60-phone (v6.1),
Bemused v1.71, bemusedlinuxserver v1.7, Linux kernel 2.6.8, bluez-libs v2.8,
bluez-utils v2.8
 
hcid is in security mode 3, auth+encryption turned on.
 
When previously paired HID-mouse is in sleep mode and there is a open but
yet idle BT connection between Bemused and bemusedlinuxserver, the mouse
cannot reconnect to the hidd daemon. When mouse button 1 is pressed, mouse
turns itself on and I assume it tries to connect, but hcid never gets or
understands to authenticate as the usual lines in the /var/log/messages do
not appear.
 
The usual lines which should appear when reconnection is made:
"
Oct 17 14:52:22 localhost hcid[2237]: link_key_request (sba=00:04:61:80:5D:88, dba=00:04:61:82:00:88)
Oct 17 14:52:23 localhost hidd[1135]: New HID device 00:04:61:82:00:88 (CSR HIDEngine Three Button Mouse)
Oct 17 14:52:24 localhost udev[5715]: creating device node '/udev/input/mouse0'
"
 
After the Bemused-application is closed in the S60-phone, the HID mouse can
reconnect again as normal.
 
Is this a known limitation of the current bluez-implementation or in other
resource? And no, I haven't tested yet if the problem is there also when in
security mode 0 without authentication and encryption.
 
// jouni



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
