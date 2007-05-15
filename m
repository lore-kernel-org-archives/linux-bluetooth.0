Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <464A011B.3070502@csr.com>
Date: Tue, 15 May 2007 19:51:07 +0100
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <d4060d560705150247g46030f61sa080f4485ab28d85@mail.gmail.com>	<1179223118.10069.2.camel@violet>	<d4060d560705150327g611491f1mbdad82b3f75699f7@mail.gmail.com>
	<1179225223.10069.6.camel@violet>
In-Reply-To: <1179225223.10069.6.camel@violet>
Subject: Re: [Bluez-devel] Can i get address of device who is doing
	discovery?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Marcel Holtmann wrote:
> ask the manufacturer of your Bluetooth chip.

If the question is "Can a device in inquiry scan determine the Bluetooth
address of the device performing the inquiry?" then the answer is no.

At the protocol level, the FHS packet goes from the device that's
in inquiry scan (that is, the device that is discoverable) to the device
that's inquiring (that is, the device performing discovery).

The only packet that goes from the inquiring device to the scanning
device is an ID packet using an inquiry access code. This contains no
information about the inquirer.

If the inquirer were to follow up with a remote name request then it
would send its address to the scanning device. This address is not
reported over the HCI interface although, in theory, a modified
controller could report it.

If the inquirer follows up with an SDP lookup then that makes a full
connection up to the host so the scanning device is aware of the
address of the device making the connection.

Rupesh Gujare wrote:
>                  Actually I want to generate some event from mobile device
> which will give me its address. So that i can start communication with it.
> (without having any software on mobile side).

Typically, the way you do this is to make the phone discoverable
through the usual user interface options. Then your device performs
the discovery and can find out the address of the phone.

	- Steven
-- 


To access the latest news from CSR copy this link into a web browser:  http://www.csr.com/email_sig.php

To get further information regarding CSR, please visit our Investor Relations page at http://ir.csr.com/csr/about/overview

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
