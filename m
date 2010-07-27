Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v3] Bluetooth: Defer SCO setup if mode change is pending
From: Marcel Holtmann <marcel@holtmann.org>
To: Ron Shaffer <rshaffer@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com
In-Reply-To: <1280153160-7166-1-git-send-email-rshaffer@codeaurora.org>
References: <1280083316.2621.24.camel@localhost.localdomain>
	 <1280153160-7166-1-git-send-email-rshaffer@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Jul 2010 12:40:29 -0700
Message-ID: <1280259629.2621.93.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ron,

> Certain headsets such as the Motorola H350 will reject SCO and eSCO
> connection requests while the ACL is transitioning from sniff mode
> to active mode. Add synchronization so that SCO and eSCO connection
> requests will wait until the ACL has fully transitioned to active mode.
> 
> < HCI Command: Exit Sniff Mode (0x02|0x0004) plen 2
>     handle 12
> > HCI Event: Command Status (0x0f) plen 4
>     Exit Sniff Mode (0x02|0x0004) status 0x00 ncmd 1
> < HCI Command:  Setup Synchronous Connection (0x01|0x0028) plen 17
>     handle 12 voice setting 0x0040
> > HCI Event: Command Status (0x0f) plen 4
>     Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 12 packets 1
> > HCI Event: Mode Change (0x14) plen 6
>     status 0x00 handle 12 mode 0x00 interval 0
>     Mode: Active
> > HCI Event: Synchronous Connect Complete (0x2c) plen 17
>     status 0x10 handle 14 bdaddr 00:1A:0E:50:28:A4 type SCO
>     Error: Connection Accept Timeout Exceeded
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> Signed-off-by: Ron Shaffer <rshaffer@codeaurora.org>
> ---
>  include/net/bluetooth/hci_core.h |    2 ++
>  net/bluetooth/hci_conn.c         |   32 ++++++++++++++++++++++++++++----
>  net/bluetooth/hci_event.c        |   33 +++++++++++++++++----------------
>  3 files changed, 47 insertions(+), 20 deletions(-)

I did a small cleanup, but patch has been applied now.

Regards

Marcel


