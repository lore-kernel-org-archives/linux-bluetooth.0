Return-Path: <cyrus@holtmann.org>
Date: Fri, 7 Nov 2014 15:46:01 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Send mgmt_connected only if state is BT_CONFIG
Message-ID: <20141107134601.GA18068@t440s.lan>
References: <1415358549-28152-1-git-send-email-jaganath.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1415358549-28152-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Fri, Nov 07, 2014, Jaganath Kanakkassery wrote:
> If a remote name request is initiated while acl connection is going on,
> and if it fails then mgmt_connected will be sent. Evetually after acl
> connection, authentication will not be initiated and userspace will
> never get pairing reply.
> 
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>     bdaddr AA:BB:CC:DD:EE:FF ptype 0xcc18 rswitch 0x01 clkoffset 0x2306 (valid)
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > HCI Event: Command Status (0x0f) plen 4
>     Create Connection (0x01|0x0005) status 0x00 ncmd 1
> > HCI Event: Inquiry Complete (0x01) plen 1
>     status 0x00
> < HCI Command: Remote Name Request (0x01|0x0019) plen 10
>     bdaddr AA:BB:CC:DD:EE:FF mode 1 clkoffset 0x2306
> > HCI Event: Command Status (0x0f) plen 4
>     Remote Name Request (0x01|0x0019) status 0x0c ncmd 1
>     Error: Command Disallowed
> > HCI Event: Connect Complete (0x03) plen 11
>     status 0x00 handle 50 bdaddr 00:0D:FD:47:53:B2 type ACL encrypt 0x00
> < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
>     handle 50
> > HCI Event: Command Status (0x0f) plen 4
>     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> > HCI Event: Max Slots Change (0x1b) plen 3
>     handle 50 slots 5
> > HCI Event: Read Remote Supported Features (0x0b) plen 11
>     status 0x00 handle 50
>     Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x59 0x83
> < HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
>     handle 50 page 1
> > HCI Event: Command Status (0x0f) plen 4
>     Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
> > HCI Event: Read Remote Extended Features (0x23) plen 13
>     status 0x00 handle 50 page 1 max 1
>     Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> 
> This patch sends mgmt_connected in remote name command status only if conn->state
> is BT_CONFIG
> 
> Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
> ---
>  net/bluetooth/hci_event.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
