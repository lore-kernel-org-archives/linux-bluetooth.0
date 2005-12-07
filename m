Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Cannot continue Bluetooth transaction
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20051205091936.8389.qmail@web32402.mail.mud.yahoo.com>
References: <20051205091936.8389.qmail@web32402.mail.mud.yahoo.com>
Content-Type: text/plain
Message-Id: <1133946941.11247.16.camel@blade>
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
Date: Wed, 07 Dec 2005 10:15:41 +0100

Hi Arch,

> I would like to ask if it is okay for a slave device to be the first
> to issue a disconnect command in the RFCOMM layer rather than the
> master device. Usually, after the OBEX Disconnect request of the
> master device and the corresponding response of the slave device, the
> master issues a disconnect command in the RFCOMM layer. However, the
> slave device (running on BlueZ) is the first one to issue a disconnect
> command in the RFCOMM layer, and the master device issues a disconnect
> command (RFCOMM) after that of the slave device. Is this okay?

I don't see a problem here, besides that the other side is not reacting
on the DISC command.

> Also, a client device issues an OBEX Connect request to a server
> device (running on BlueZ) and thereafter sends an SDP service request.
> Is this flow (1. OBEX Connect --- 2. SDP service request) okay with
> BlueZ? This is how the Sony Ericsson S700i and the Samsung D600 goes
> about their Bluetooth transactions. After the SDP service request, the
> mobile phones did not issue an OBEX Disconnect request.

I think that I already told you that. SDP transactions can happen at
every time.
 
> The trace for this kind of transaction is attached with this email:

You are kidding me. Sending a Microsoft Word document is kinda rude.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
