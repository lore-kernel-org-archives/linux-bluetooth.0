Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Test Mode
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <2de4657604113005524dc81879@mail.gmail.com>
References: <2de4657604113005524dc81879@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1101825813.9348.12.camel@notepaq>
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
Date: Tue, 30 Nov 2004 15:43:33 +0100

Hi Manjunath,

> I am trying to set my dongle for  a local loopback test. I try with a
> "Enable device  under test command"
> root]# hcitool cmd 0x06 0x0003
> 
> Hci dump output is
> 
> < HCI Command: Unknown (0x06|0x0003) plen 0
> > HCI Event: Command Complete (0x0e) plen 4
>  01 03 18 00

write a patch for hcidump so that these HCI commands are decoded
correctly.

> I am not getting an error.  I try to write the "write loopback method
> command" and enable local loopback.
> 
> root]# hcitool cmd 0x06 0x0002 0x01
> 
> Hci dump output is
> < HCI Command: Unknown (0x06|0x0002) plen 1
>  01
> > HCI Event: Command Complete (0x0e) plen 4
>  01 02 18 11
> 
> Status shows 11 which is "HCI unsupported feature". I am using  a
> version 1.1 anycom-120 usb dongle.

I don't think that this feature is mandatory to support. I never used or
needed it.

> Is this a problem with the firmware. Do i have to upgrade the
> firmware and Can i do it??

I don't know.

> I also have another doubt......how can i generate the LMP commands
> required for the test mode....as in LMP_test_activate PDU and several
> other LMP commands. The test methodology only speaks about the LMP
> PDU's. How can i generate these LMP commands for the test scenarios.

You can't generate any LMP messages from the HCI. Actually the HCI
command should result in a call to the appropiate LMP commands.

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
