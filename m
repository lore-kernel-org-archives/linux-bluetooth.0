Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] ttyS0 problem
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1128909236.2417.20.camel@localhost.localdomain>
References: <1128906830.2417.1.camel@localhost.localdomain>
	 <1128909236.2417.20.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1128914355.19569.33.camel@blade>
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
Date: Mon, 10 Oct 2005 05:19:15 +0200

Hi David,

> > What commands do you wanna send?
> The command is HCI_GO_TO_SLEEP_IND(0x30) which is only one byte. It is a
> vendor specific command used to ask the BT device to go to sleep. If BT
> device receives the command, maybe it would response
> HCILL_GO_TO_SLEEP_ACK(0x31) command to the host.

do you have the specification of these vendor commands? Is this command
according to the HCI specification or is it an extension of the H:4
transport protocol?

> > after step 1, you  must use the HCI raw socket to send commands
> 
> Is this means we cannot write command to ttyS0 directly through write()
> function?

After calling hciattach the kernel takes over the serial port via the
line discipline and the reads and writes are useless.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
