Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] L2CAP & HCI trace
From: zze-COLBUS Emmanuel RD-MAPS-GRE <emmanuel.colbus@rd.francetelecom.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050216155732.29721.qmail@web53201.mail.yahoo.com>
References: <20050216155732.29721.qmail@web53201.mail.yahoo.com>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1108570362.11909.35.camel@g-necml5-146.rd.francetelecom.fr>
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
Date: Wed, 16 Feb 2005 17:12:42 +0100

Le mercredi 16 février 2005 à 07:57 -0800, Filipa Duarte a écrit :
> Hi,
> 
> I suppose that this is a quite stupid question but I
> would like to know how can I have the same kind of
> trace as Victor had (in the end of the e-mail)? 
> 
> The reason why is that I would like to identify which
> are the functions (like l2cap_sock_sendmsg,
> l2cap_chan_send, hci_send_acl, etc) used to send data
> on the l2cap/hci layers. Could anyone give me any
> direction to find this?
> 
> Many thanks,
> 
> Filipa
> 

Hello, 

Try recompilating your kernel with the
CONFIG_BT_HCI_SOCK_DEBUG, CONFIG_BT_L2CAP_DEBUG, etc... (All the options
mentionned at the beginning of the files, in a block like : 

#ifndef CONFIG_BT_L2CAP_DEBUG
#undef  BT_DBG
#define BT_DBG(D...)
#endif

) enabled.

I've not tried it myself, but, reading to the code, I think it will
work.

Emmanuel Colbus

-- 
Please don't care about this useless mail signature:

M. Emmanuel Colbus de l'ENSIMAG intervenant à FTRD/MAPS/AMS du 01/02/05 
au 30/06/05 sous la responsabilité de M. Tahar Jarboui dans le cadre 
d'un stage de fin d'études.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
