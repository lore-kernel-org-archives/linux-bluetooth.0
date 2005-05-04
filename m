Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] connection timeout problems
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <42789AD7.9090507@deis.unibo.it>
References: <42789AD7.9090507@deis.unibo.it>
Content-Type: text/plain
Message-Id: <1115200542.8496.82.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 04 May 2005 11:55:42 +0200

Hi,

> I looked at the hcitool.c source and I have noticed that the "to" 
> parameter in hci_create_connection is set on 25000.
> 
> hci_create_connection(dd, &(info+i)->bdaddr,
> htobs(di.pkt_type & ACL_PTYPE_MASK),
> (info+i)->clock_offset | 0x8000,
> 0x01, &handle, 25000);
> 
> /** from hci.h **/
> hci_create_connection(int dd, const bdaddr_t *bdaddr, uint16_t ptype, 
> uint16_t clkoffset, uint8_t rswitch, uint16_t *handle, int to)
> 
> 
> Is this parameter a timeout in msec?
> Is it possible to reduce this value?
> I need to perform the connection before 10 sec, and I prefer to kill the 
> connection instead waiting for more time.
> 
> I have tryed to reduce this parameter, but after the return of the 
> connection, It seems that no other connections are possible.
> 
> I get :    Can't create connection: Input/output error
> 
> and no more connections are possible (also to other devices).
> I get a similar behaviour also if I kill the connecting process before 
> the timeout.

this is not the page timeout and you have to reduce the page timeout to
get the desired effect.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
