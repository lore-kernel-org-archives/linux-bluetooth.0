Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20041017151430.12721.qmail@web41129.mail.yahoo.com>
From: Sean Loh <blaze_wk@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] hcidump and l2cap questions
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
Date: Sun, 17 Oct 2004 08:14:30 -0700 (PDT)

Hi,

I'm streaming audio from one computer to another
computer  using the pan profile.

1. I would like to see bnep packets being filtered
through hcidump. But when i put the bnep filter on,
hcidump does not print out anything. It only seems to
print out acl and l2cap data. Why is that? How am I
able to see bnep packet info?

2. I notice that even if i send udp packets that have
55000 bytes. The maximum packet length that turns up
on hcidump is 1500 bytes. Shouldn't it be 55000 bytes
because the max mtu for an l2cap packet is 65535
bytes?

thanks

bluez rules



		
__________________________________
Do you Yahoo!?
Yahoo! Mail - Helps protect you from nasty viruses.
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
