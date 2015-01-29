Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] Bluetooth: Fix sending Read Remote Exttended Features command
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1422482398-8425-1-git-send-email-szymon.janc@tieto.com>
Date: Wed, 28 Jan 2015 19:11:15 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B677BF19-76BD-445C-98D4-E802B1B1FB22@holtmann.org>
References: <1422482398-8425-1-git-send-email-szymon.janc@tieto.com>
To: Szymon Janc <szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> This command should only be used if remote device reports that it
> supports extended features. Otherwise command will fail and connection
> will be dropped.
> 
> Some devices support SSP but don't support extended features so
> current check for SSP support is not enough.
> 
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>        Address: D0:9C:30:00:19:6F (Foster Electric Company, Limited)
>        Packet type: 0xcc18
>          DM1 may be used
>          DH1 may be used
>          DM3 may be used
>          DH3 may be used
>          DM5 may be used
>          DH5 may be used
>        Page scan repetition mode: R1 (0x01)
>        Page scan mode: Mandatory (0x00)
>        Clock offset: 0x94c8
>        Role switch: Allow slave (0x01)
>> HCI Event: Command Status (0x0f) plen 4
>      Create Connection (0x01|0x0005) ncmd 1
>        Status: Success (0x00)
>> HCI Event: Connect Complete (0x03) plen 11
>        Status: Success (0x00)
>        Handle: 5
>        Address: D0:9C:30:00:19:6F (Foster Electric Company, Limited)
>        Link type: ACL (0x01)
>        Encryption: Disabled (0x00)
> < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
>        Handle: 5
>> HCI Event: Command Status (0x0f) plen 4
>      Read Remote Supported Features (0x01|0x001b) ncmd 1
>        Status: Success (0x00)
>> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
>        Address: D0:9C:30:00:19:6F (Foster Electric Company, Limited)
>        Page scan repetition mode: R1 (0x01)
>> HCI Event: Read Remote Supported Features (0x0b) plen 11
>        Status: Success (0x00)
>        Handle: 5
>        Features: 0xff 0xff 0x8f 0xfe 0xdb 0xff 0x5b 0x07
>          3 slot packets
>          5 slot packets
>          Encryption
>          Slot offset
>          Timing accuracy
>          Role switch
>          Hold mode
>          Sniff mode
>          Park state
>          Power control requests
>          Channel quality driven data rate (CQDDR)
>          SCO link
>          HV2 packets
>          HV3 packets
>          u-law log synchronous data
>          A-law log synchronous data
>          CVSD synchronous data
>          Paging parameter negotiation
>          Power control
>          Transparent synchronous data
>          Broadcast Encryption
>          Enhanced Data Rate ACL 2 Mbps mode
>          Enhanced Data Rate ACL 3 Mbps mode
>          Enhanced inquiry scan
>          Interlaced inquiry scan
>          Interlaced page scan
>          RSSI with inquiry results
>          Extended SCO link (EV3 packets)
>          EV4 packets
>          EV5 packets
>          AFH capable slave
>          AFH classification slave
>          LE Supported (Controller)
>          3-slot Enhanced Data Rate ACL packets
>          5-slot Enhanced Data Rate ACL packets
>          Sniff subrating
>          Pause encryption
>          AFH capable master
>          AFH classification master
>          Enhanced Data Rate eSCO 2 Mbps mode
>          Enhanced Data Rate eSCO 3 Mbps mode
>          3-slot Enhanced Data Rate eSCO packets
>          Extended Inquiry Response
>          Simultaneous LE and BR/EDR (Controller)
>          Secure Simple Pairing
>          Encapsulated PDU
>          Non-flushable Packet Boundary Flag
>          Link Supervision Timeout Changed Event
>          Inquiry TX Power Level
>          Enhanced Power Control
> < HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
>        Handle: 5
>        Page: 1
>> HCI Event: Command Status (0x0f) plen 4
>      Read Remote Extended Features (0x01|0x001c) ncmd 1
>        Status: Command Disallowed (0x0c)

what kind of screwed up remote controller is this. This year is 2015 and this has been around for a very long time. If you support SSP you need to support extended features. Can you get the remote version information and also call "hcitool name" and check the trace for that.

Someone should tell these people to fix their controller.

Also Extended Inquiry Response is not allowed if SSP is disabled. And without features page 1, we can not even tell if SSP enabled in the host or not. This is really bad.

> < HCI Command: Read Clock Offset (0x01|0x001f) plen 2
>        Handle: 5
>> HCI Event: Command Status (0x0f) plen 4
>      Read Clock Offset (0x01|0x001f) ncmd 1
>        Status: Success (0x00)
> < HCI Command: Disconnect (0x01|0x0006) plen 3
>        Handle: 5
>        Reason: Remote User Terminated Connection (0x13)
> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
> net/bluetooth/hci_event.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index e2b81ad..5a16a23 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2667,7 +2667,8 @@ static void hci_remote_features_evt(struct hci_dev *hdev,
> 	if (conn->state != BT_CONFIG)
> 		goto unlock;
> 
> -	if (!ev->status && lmp_ssp_capable(hdev) && lmp_ssp_capable(conn)) {
> +	if (!ev->status && lmp_ssp_capable(hdev) && lmp_ssp_capable(conn) &&
> +	    lmp_ext_feat_capable(conn)) {
> 		struct hci_cp_read_remote_ext_features cp;
> 		cp.handle = ev->handle;
> 		cp.page = 0x01;

Since we have BR/EDR secure connections using page 2 for its features, we might actually just want to switch to check for lmp_exit_feat_capable from hdev and conn and remove the lmp_ssp_capable check. In the end that is what we are doing anyway.

Regards

Marcel

