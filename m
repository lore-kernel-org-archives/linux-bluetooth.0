Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] link quality values at rx and tx
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <2de4657604120823457166eeea@mail.gmail.com>
References: <2de4657604120823457166eeea@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1102578833.9988.96.camel@pegasus>
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
Date: Thu, 09 Dec 2004 08:53:53 +0100

Hi Manjunath,

> With DBT-120, I am getting different LQ values at the transmitter and
> receiver for different packet types.
> I am communicating with DH5 packets, at the Tx i get LQ=200, at Rx i
> get LQ=195....around the same.
> I am communicating with DM5 packets, at the Tx i get LQ=190, at Rx i
> get LQ=80 or 90 . How is this possible?
> 
> How does the LQ vary with packet type??

didn't I explained this in a previous thread? The link quality value is
manufacturer specific? They can use whatever value they want. In the
case of CSR chips it is related to the BER from packets with FEC.

	http://www.holtmann.org/linux/bluetooth/csr.html

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
