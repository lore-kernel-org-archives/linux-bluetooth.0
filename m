Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20041026160627.93404.qmail@web41101.mail.yahoo.com>
From: Sean Loh <blaze_wk@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Unstable acl throughputs
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
Date: Tue, 26 Oct 2004 09:06:27 -0700 (PDT)

Hi

I have set up a pan between 2 computers with bluetooth
usb adapters. From the mailing lists, I understand
that to get assymetric data throughputs, we modify the
hciconfig hci0 ptype to whatever we want. For example,
the best assymmetric throughput would involve running
hciconfig hci0 ptype DH5 on one computer and hciconfig
hci0 ptype DH1 on the other computer. Am I right?

When I do this and I measure the udp packet
throughputs, the throughputs I get are all over the
place. For an assymetric connection of DH3/DH1. I can
get throughputs from the DH3 link computer to the DH1
computer of 650000 bits per second. Remember, this is
in the pan profile, sending udp packets. Should I be
getting this throughputs?or is there something amiss?

The DH1 computer is not sending any information out,
so does that really matter. Could it be because of
that I'm getting such high throughputs on the DH5
computer?

Any help greatly APPRECIATED!!!


		
__________________________________
Do you Yahoo!?
Yahoo! Mail Address AutoComplete - You start. We finish.
http://promotions.yahoo.com/new_mail 


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
