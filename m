Return-Path: <Andreas.Gaufer@blue-cell-networks.com>
Date: Thu, 10 Jun 2004 16:01:48 +0200
From: Andreas Gaufer <Andreas.Gaufer@blue-cell-networks.com>
To: Marcel Holtmann <marcel@holtmann.org>,
   Bluez Devel <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] HCI Event: Connect Complete with Status 09
Message-Id: <20040610160148.1ca400c4.Andreas.Gaufer@blue-cell-networks.com>
In-Reply-To: <1086862843.1607.33.camel@pegasus>
References: <20040609185348.65a9f382.Andreas.Gaufer@blue-cell-networks.com>
	<40C74EDD.6060903@csr.com>
	<20040609212529.6901de52.Andreas.Gaufer@blue-cell-networks.com>
	<1086862843.1607.33.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

Same behaviour w/o CONFIG_BT_HCIUSB_SCO. I disribe it again a bit more percise:

hcitool -i hci1 cc 00:0A:D9:37:11:29

< HCI Command: Create Connection(0x01|0x0005) plen 13
  29 11 37 D9 0A 00 18 CC 02 00 00 00 00 
> HCI Event: Command Status(0x0f) plen 4
  00 01 05 04 
> HCI Event: Connect Complete(0x03) plen 11
  00 29 00 29 11 37 D9 0A 00 01 00

hcitool con
Connections:
        < ACL 00:0A:D9:37:11:29 handle 41 state 1 lm MASTER 

hcitool -i hci1 cc 00:0A:D9:37:11:29
Can't create connection: Input/output error

< HCI Command: Create Connection(0x01|0x0005) plen 13
  29 11 37 D9 0A 00 18 CC 02 00 00 00 00 
> HCI Event: Command Status(0x0f) plen 4
  0B 01 05 04 

hcitool con
Connections:

hcitool -i hci1 dc 00:0A:D9:37:11:29
Get connection info failed: No such file or directory

hcitool -i hci1 cmd 0x01 0x0006 0x29 0x00 0x13
< HCI Command: ogf 0x01, ocf 0x0006, plen 3
  29 00 13 
> HCI Event: 0x0f plen 4
  00 01 06 04 


So the entry in the list that "hcitool con" prints gets lost when
the secound cc is issued and fails. The chip still has the handle
and it can be disconnected with hcitoom cmd.

Im wondering witch part of the bluez Stack is maintaining the
list and why the entry is dropped in case of a failed cc. I just
can imagine that all acl handles are dropped that belong to that mac.

IMHO it would be great if a handle could only be removed from the 
list if there is a successfull disconnect.

Greetings

Andreas Gaufer



On Thu, 10 Jun 2004 12:20:43 +0200
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Andreas,
> 
> > Yes, indeed thats close to what im doing. Not within one secoud but very 
> > frequently.
> 
> do you enabled CONFIG_BT_HCIUSB_SCO? If yes, disable it and try again.
> Our way of consuming USB bandwith with ISOC URB's wasn't liked by some
> of the BlueCore02 firmwares.
> 
> Regards
> 
> Marcel
> 
> 
