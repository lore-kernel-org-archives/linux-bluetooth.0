Return-Path: <paxtonrd@hotmail.com>
From: "Thor Egil Skaug" <paxtonrd@hotmail.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
Cc: "'BlueZ Mailing List'" <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] AUX1 packets
Date: Mon, 1 Mar 2004 07:44:34 -0800
Message-ID: <000001c3ffa4$181dee40$46a57e40@thores>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1078152924.1942.126.camel@pegasus>
List-ID: <bluez-users.lists.sourceforge.net>

>Hi Thor,
>
> Is there any way of having an ACL connection use AUX1 packets?
> 
> The packet type is not defined in the Bluetooth specification for the 
> HCI_create_connection command.
>
>you can't control this from the host stack side, because as you already
have seen it is not defined for the HCI_create_connection command. It is
the job of the link manager to choose the right packet types.
>
>Regards
>
>Marcel

Regarding DM and DH packets:
Am I correct in assuming the following?

If I use the HCI_change_connection_packet_type command, I can change the
packet type for the connection
as long as it is supported by both devices? It is then mostly my
decision what packet type is used for the
connection, although the link controller may use DM1 packets if
necessary.

I am trying to have my application select different packet types based
on the current BER.

Thor
