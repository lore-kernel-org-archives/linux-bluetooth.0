Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 Jan 2013 19:10:32 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v1] Bluetooth: Fix authentication if acl data comes
 before remote feature evt
Message-ID: <20130109211032.GD30225@joana>
References: <1357543751-12204-1-git-send-email-jaganath.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1357543751-12204-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

* Jaganath Kanakkassery <jaganath.k@samsung.com> [2013-01-07 12:59:11 +0530]:

> If remote device sends l2cap info request before read_remote_ext_feature
> completes then mgmt_connected will be sent in hci_acldata_packet() and
> remote name request wont be sent and eventually authentication wont happen
> 
> Hcidump log of the issue
> 
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>     bdaddr BC:85:1F:74:7F:29 ptype 0xcc18 rswitch 0x01 clkoffset 0x4bf7 (valid)
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > HCI Event: Command Status (0x0f) plen 4
>     Create Connection (0x01|0x0005) status 0x00 ncmd 1
> > HCI Event: Connect Complete (0x03) plen 11
>     status 0x00 handle 12 bdaddr BC:85:1F:74:7F:29 type ACL encrypt 0x00
> < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
>     handle 12
> > HCI Event: Command Status (0x0f) plen 4
>     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> > HCI Event: Read Remote Supported Features (0x0b) plen 11
>     status 0x00 handle 12
>     Features: 0xbf 0xfe 0xcf 0xfe 0xdb 0xff 0x7b 0x87
> > HCI Event: Max Slots Change (0x1b) plen 3
>     handle 12 slots 5
> < HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
>     handle 12 page 1
> > HCI Event: Command Status (0x0f) plen 4
>     Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
> > ACL data: handle 12 flags 0x02 dlen 10
>     L2CAP(s): Info req: type 2
> < ACL data: handle 12 flags 0x00 dlen 16
>     L2CAP(s): Info rsp: type 2 result 0
>       Extended feature mask 0x00b8
>         Enhanced Retransmission mode
>         Streaming mode
>         FCS Option
>         Fixed Channels
> > HCI Event: Read Remote Extended Features (0x23) plen 13
>     status 0x00 handle 12 page 1 max 1
>     Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> > ACL data: handle 12 flags 0x02 dlen 10
>     L2CAP(s): Info req: type 3
> < ACL data: handle 12 flags 0x00 dlen 20
>     L2CAP(s): Info rsp: type 3 result 0
>       Fixed channel list 0x00000002
>         L2CAP Signalling Channel
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 12 packets 2
> 
> This patch moves sending mgmt_connected from hci_acldata_packet() to
> l2cap_connect_req() since this code is to handle the scenario remote
> device sends l2cap connect req too fast
> ---
> v1 ---> Incorporated Johan's comments - Instead of fixing in hci_acldata_packet(),
> move sending mgmt_connected to l2cap_connect_req since this code is mainly to
> handle the scenario if remote device sends l2cap connection too fast
> 
>  net/bluetooth/hci_core.c   |    8 --------
>  net/bluetooth/l2cap_core.c |   11 +++++++++++
>  2 files changed, 11 insertions(+), 8 deletions(-)

Could you please add your Signed-off-by line to the patch?

	Gustavo
