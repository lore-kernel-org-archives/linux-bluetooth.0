Return-Path: <cyrus@holtmann.org>
Message-ID: <50B71FCA.5050009@invoxia.com>
Date: Thu, 29 Nov 2012 09:41:46 +0100
From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
MIME-Version: 1.0
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYWxsZWF1?=
	<frederic.dalleau@linux.intel.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 0/4] sco: Another SCO socket option :)
References: <1354127316-17431-1-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1354127316-17431-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Frédéric,

my natural feeling is to be generic as much as possible, and to not try 
to implement directly a particular profile in the kernel:
ex:
- I'm a hobbyist or academic and I want to use SCO socket for something 
else than standard profiles like an asymmetric synchronous connection (?)
- tomorrow, a new X or Y codec will be selected by the SIG and some new 
settings will be required (may be OPUS, now we have a high quality 
patent free, royalty-free and standardized codec available. 
http://opus-codec.org/)
- I've a BT module doesn't behave correctly when using exactly the 
parameters specified by the HFP specs (I think I have already seen one 
but don't remember which)

also, BT specs provided a generic API (HCI_Setup_Synchronous_Connection 
command & co). why try to remove the flexibility ?

Except this "codec only vs. every parameter" question, I like the 
implementation.

regards,
arnaud


On 11/28/2012 07:28 PM, Frédéric Dalleau wrote:
> Hi,
>
> This patch implements codec socket option on SCO sockets.
> Currently it proposes T2 codec settins (see HFP 1.6 p.102)
>
>
> How to test:
> $ scotest -W 1 -C 1
>
> on another machine with same patches run:
> $ scotest -n $ADDR -C 1
>
> Check result with btmon.
>
> This took more time than I expected for I met the following issues :
> * bluetooth-next branch crashed in apparmor after login.
> * At some point, unplugging my usb dongle would also crash the kernel. It is
> possible this one was a mix between different versions of kernel modules.
> * if the connection request is not accepted, the initiator gets in timeout, and
> there is a crash. I think this one will need be fixed.
>
> Next step is to implement fallback between T2 and T1. I'm thinking about using
> another bit in hconn->flags to store current settings selection.
>
> Let me know what you think.
> Best regards,
> Frédéric
>
>
> Frédéric Dalleau (4):
>    Bluetooth: Add option for SCO socket codec
>    Bluetooth: Add option for SCO socket socket
>    Bluetooth: Use codec to create SCO connection
>    Bluetooth: Set link parameters for outgoing connections
>
>   include/net/bluetooth/hci_core.h |    6 +++--
>   include/net/bluetooth/sco.h      |    2 ++
>   net/bluetooth/hci_conn.c         |   24 ++++++++++++++----
>   net/bluetooth/hci_event.c        |   23 ++++++++++++++---
>   net/bluetooth/l2cap_core.c       |    4 +--
>   net/bluetooth/mgmt.c             |    4 +--
>   net/bluetooth/sco.c              |   51 ++++++++++++++++++++++++++++++++++++--
>   7 files changed, 97 insertions(+), 17 deletions(-)
>

