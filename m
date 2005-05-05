Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Regarding a2recv
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050505124512.53335.qmail@web8306.mail.in.yahoo.com>
References: <20050505124512.53335.qmail@web8306.mail.in.yahoo.com>
Content-Type: text/plain
Message-Id: <1115298846.8496.155.camel@pegasus>
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
Date: Thu, 05 May 2005 15:14:06 +0200

Hi Mayank,

> Did you try what I suggested you in my mail titled 'A
> small Query' ?
> 
> That is, swap the message_type and packet_type fields
> of the structure
> 
> struct avdtp_header {
> 	uint8_t packet_type:2;
> 	uint8_t message_type:2;
> 	uint8_t transaction_label:4;
> 	uint8_t signal_id:6;
> 	uint8_t rfa0:2;
> } __attribute__ ((packed));
> 
> in the file a2dp.h
> 
> i.e. make it look like the following:
> struct avdtp_header {
> 	uint8_t message_type:2;
> 	uint8_t packet_type:2;
> 	uint8_t transaction_label:4;
> 	uint8_t signal_id:6;
> 	uint8_t rfa0:2;
> } __attribute__ ((packed));
> 
> 
> Once you swap them, I feel that a2recv will work for
> you.

this is correct. After checking the specs, the message_type are the
first two bits and then packet_type follows.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
