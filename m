Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] lmx9814
From: Marcel Holtmann <marcel@holtmann.org>
To: Philip Blundell <pb@nexus.co.uk>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076864335.23437.70.camel@dixie.nexus.co.uk>
References: <1076864335.23437.70.camel@dixie.nexus.co.uk>
Content-Type: text/plain
Message-Id: <1076865499.2840.8.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 15 Feb 2004 18:18:19 +0100

Hi Philip,

> I've been trying to use BlueZ on an HP iPAQ H5500, which uses a National
> LMX9814 chip interfaced via UART.  Connecting with "hciattach /dev/tts/1
> any 921600" seems to work ok, and hcitool dev shows the device as hci0,
> but a subsequent hcitool scan fails with "connection timed out".  dmesg
> shows:
> 
> hci_cmd_task: hci0 command tx timeout
> hci_cmd_task: hci0 command tx timeout
> h4_recv: Unknown HCI packet type 70
> h4_recv: Unknown HCI packet type f8
> h4_recv: Unknown HCI packet type f0
> 
> Is anybody successfully using one of these devices, or does anybody have
> a suggestion as to what might be going wrong here?

are you sure that this iPAQ contains a National chip? I thought they are
using a CSR chip and only the never 2xxx series contain a Zeevo chip.

Regards

Marcel





-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
