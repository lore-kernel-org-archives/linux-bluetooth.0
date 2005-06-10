Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050610055739.9622.qmail@web50703.mail.yahoo.com>
From: "John H." <mistamaila@yahoo.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050610050430.97627.qmail@web50703.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] hcid error on pair attempt
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
Date: Thu, 9 Jun 2005 22:57:39 -0700 (PDT)

When I try to pair my phone, despite changing pin in
/etc/bluetooth/pin to 0000 and typing that in the
phone when I try to pair, it says pairing failed, and
/var/log/messages says


Jun 10 00:56:33 home hcid[15309]: pin_code_request
(sba=00:02:72:81:AB:C4, dba=08:00:37:12:C4:B1)
Jun 10 00:56:33 home hcid[15309]: link_key_notify
(sba=00:02:72:81:AB:C4, dba=08:00:37:12:C4:B1)


?

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
