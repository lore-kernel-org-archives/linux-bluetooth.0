Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Mar 2014 20:58:13 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix removing Long Term Key
Message-ID: <20140305185813.GA10094@localhost.P-661HNU-F1>
References: <1374776057-2618-1-git-send-email-claudio.takahasi@openbossa.org>
 <1374780864-8529-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1374780864-8529-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Jul 25, 2013, Claudio Takahasi wrote:
> This patch fixes authentication failure on LE link re-connection when
> BlueZ acts as slave (peripheral). LTK is removed from the internal list
> after its first use causing PIN or Key missing reply when re-connecting
> the link. The LE Long Term Key Request event indicates that the master
> is attempting to encrypt or re-encrypt the link.
> 
> Pre-condition: BlueZ host paired and running as slave.
> How to reproduce(master):
>   1) Establish an ACL LE encrypted link
>   2) Disconnect the link
>   3) Try to re-establish the ACL LE encrypted link (fails)
> 
> > HCI Event: LE Meta Event (0x3e) plen 19
>       LE Connection Complete (0x01)
>         Status: Success (0x00)
>         Handle: 64
>         Role: Slave (0x01)
> ...
> @ Device Connected: 00:02:72:DC:29:C9 (1) flags 0x0000
> > HCI Event: LE Meta Event (0x3e) plen 13
>       LE Long Term Key Request (0x05)
>         Handle: 64
>         Random number: 875be18439d9aa37
>         Encryption diversifier: 0x76ed
> < HCI Command: LE Long Term Key Request Reply (0x08|0x001a) plen 18
>         Handle: 64
>         Long term key: 2aa531db2fce9f00a0569c7d23d17409
> > HCI Event: Command Complete (0x0e) plen 6
>       LE Long Term Key Request Reply (0x08|0x001a) ncmd 1
>         Status: Success (0x00)
>         Handle: 64
> > HCI Event: Encryption Change (0x08) plen 4
>         Status: Success (0x00)
>         Handle: 64
>         Encryption: Enabled with AES-CCM (0x01)
> ...
> @ Device Disconnected: 00:02:72:DC:29:C9 (1) reason 3
> < HCI Command: LE Set Advertise Enable (0x08|0x000a) plen 1
>         Advertising: Enabled (0x01)
> > HCI Event: Command Complete (0x0e) plen 4
>       LE Set Advertise Enable (0x08|0x000a) ncmd 1
>         Status: Success (0x00)
> > HCI Event: LE Meta Event (0x3e) plen 19
>       LE Connection Complete (0x01)
>         Status: Success (0x00)
>         Handle: 64
>         Role: Slave (0x01)
> ...
> @ Device Connected: 00:02:72:DC:29:C9 (1) flags 0x0000
> > HCI Event: LE Meta Event (0x3e) plen 13
>       LE Long Term Key Request (0x05)
>         Handle: 64
>         Random number: 875be18439d9aa37
>         Encryption diversifier: 0x76ed
> < HCI Command: LE Long Term Key Request Neg Reply (0x08|0x001b) plen 2
>         Handle: 64
> > HCI Event: Command Complete (0x0e) plen 6
>       LE Long Term Key Request Neg Reply (0x08|0x001b) ncmd 1
>         Status: Success (0x00)
>         Handle: 64
> > HCI Event: Disconnect Complete (0x05) plen 4
>         Status: Success (0x00)
>         Handle: 64
>         Reason: Authentication Failure (0x05)
> @ Device Disconnected: 00:02:72:DC:29:C9 (1) reason 0
> 
> Signed-off-by: Claudio Takahasi <claudio.takahasi@openbossa.org>
> ---
>  net/bluetooth/hci_event.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

The patch has now (finally) been applied to the bluetooth-next tree.
I also added a Cc: stable flag to it since this is a fairly severe issue
at least for any kernel with the advertising mgmt setting.

Johan
