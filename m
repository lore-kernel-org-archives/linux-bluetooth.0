Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH v10 09/10] Bluetooth: Handle specific error for SCO connection fallback
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1376499814-11386-10-git-send-email-frederic.dalleau@linux.intel.com>
Date: Fri, 16 Aug 2013 11:48:47 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A153E75B-61C9-4358-B37A-7B8770D39C17@holtmann.org>
References: <1376499814-11386-1-git-send-email-frederic.dalleau@linux.intel.com> <1376499814-11386-10-git-send-email-frederic.dalleau@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Synchronous Connection Complete event can return error "Connection
> Rejected due to Limited resources (0x10)".
> Handling this error is required for SCO connection fallback. This error
> happens when the server tried to accept the connection but failed to
> negotiate settings.
> This error code has been verified experimentally by sending a T2 request
> to a T1 only SCO listener.
> 
> Client dump follows :
> 
> < HCI Command (0x01|0x0028) plen 17 [hci0] 3.696064
>        Handle: 12
>        Transmit bandwidth: 8000
>        Receive bandwidth: 8000
>        Max latency: 13
>        Setting: 0x0003
>        Retransmission effort: Optimize for link quality (0x02)
>        Packet type: 0x0380
>> HCI Event (0x0f) plen 4 [hci0] 3.697034
>      Setup Synchronous Connection (0x01|0x0028) ncmd 1
>        Status: Success (0x00)
>> HCI Event (0x2c) plen 17 [hci0] 3.736059
>        Status: Connection Rejected due to Limited Resources (0x0d)
>        Handle: 0
>        Address: xx:xx:xx:xx:xx:AB (OUI 70-F3-95)
>        Link type: eSCO (0x02)
>        Transmission interval: 0x0c
>        Retransmission window: 0x06
>        RX packet length: 60
>        TX packet length: 60
>        Air mode: Transparent (0x03)
> 
> Server dump follows :
> 
>> HCI Event (0x04) plen 10 [hci0] 4.741513
>        Address: xx:xx:xx:xx:xx:D9 (OUI 20-68-9D)
>        Class: 0x620100
>          Major class: Computer (desktop, notebook, PDA, organizers)
>          Minor class: Uncategorized, code for device not assigned
>          Networking (LAN, Ad hoc)
>          Audio (Speaker, Microphone, Headset)
>          Telephony (Cordless telephony, Modem, Headset)
>        Link type: eSCO (0x02)
> < HCI Command (0x01|0x0029) plen 21 [hci0] 4.743269
>        Address: xx:xx:xx:xx:xx:D9 (OUI 20-68-9D)
>        Transmit bandwidth: 8000
>        Receive bandwidth: 8000
>        Max latency: 13
>        Setting: 0x0003
>        Retransmission effort: Optimize for link quality (0x02)
>        Packet type: 0x03c1
>> HCI Event (0x0f) plen 4 [hci0] 4.745517
>      Accept Synchronous Connection (0x01|0x0029) ncmd 1
>        Status: Success (0x00)
>> HCI Event (0x2c) plen 17 [hci0] 4.749508
>        Status: Connection Rejected due to Limited Resources (0x0d)
>        Handle: 0
>        Address: xx:xx:xx:xx:xx:D9 (OUI 20-68-9D)
>        Link type: eSCO (0x02)
>        Transmission interval: 0x0c
>        Retransmission window: 0x06
>        RX packet length: 60
>        TX packet length: 60
>        Air mode: Transparent (0x03)
> 
> Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
> ---
> net/bluetooth/hci_event.c |    1 +
> 1 file changed, 1 insertion(+)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

