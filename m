Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20050503130909.22723.qmail@web8302.mail.in.yahoo.com>
From: Mayank Batra <mayankbatra@yahoo.co.in>
To: BLUEZ DEVELOPERS LIST <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-devel] A small query
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
Date: Tue, 3 May 2005 14:09:09 +0100 (BST)

Guys,

Does it matter whether I declare packet_type before or
after message_type. I am not sure, but if I declare it
before somehow, the hcidump on the a2recv side is not
correct. 
I mean, there is something wrong in the hcidump. It
considers the commands as 'Cont' command and this is
when the source sends me a disconnect without
hesitation.
What I want to say is that if I declare packet_type
after message_type, then both the source's and sink's
dump are ok.


struct avdtp_header {
	uint8_t packet_type:2;
	uint8_t message_type:2;
	uint8_t transaction_label:4;
	uint8_t signal_id:6;
	uint8_t rfa0:2;
} __attribute__ ((packed));



Mayank

________________________________________________________________________
Yahoo! India Matrimony: Find your life partner online
Go to: http://yahoo.shaadi.com/india-matrimony


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
