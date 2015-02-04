Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH] monitor: Fix minimum size for variable length events
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1858164.g9f32Se7Qq@leonov>
Date: Wed, 4 Feb 2015 14:19:45 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4BF8883E-0BE4-4C63-8209-C88A68A9B038@holtmann.org>
References: <1423080848-7611-1-git-send-email-szymon.janc@tieto.com> <AEA5CFDB-68FD-41C0-9960-6EA1433DD4A5@holtmann.org> <1858164.g9f32Se7Qq@leonov>
To: Szymon Janc <szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

>>> Those could lead to reading invalid memory if frames were corrupted.
>>> ---
>>> monitor/packet.c | 10 +++++-----
>>> 1 file changed, 5 insertions(+), 5 deletions(-)
>>> 
>>> diff --git a/monitor/packet.c b/monitor/packet.c
>>> index ba58d84..56a315b 100644
>>> --- a/monitor/packet.c
>>> +++ b/monitor/packet.c
>>> @@ -8204,7 +8204,7 @@ static const struct event_data event_table[] = {
>>> 
>>> 	{ 0x01, "Inquiry Complete",
>>> 	
>>> 				inquiry_complete_evt, 1, true },
>>> 	
>>> 	{ 0x02, "Inquiry Result",
>>> 
>>> -				inquiry_result_evt, 1, false },
>>> +				inquiry_result_evt, 8, false },
>> 
>> these are wrong. That is why fixed size is set to false here. It means that
>> the callback function needs to ensure we do the right checks. If we don't,
>> please with the callback functions.
> 
> If fixed==false then passed size is minimum required size and all callbacks 
> are expecting those.
> 
> From packet_hci_event()
> 
> 	if (event_data->fixed) {
> 		if (hdr->plen != event_data->size) {
> 			print_text(COLOR_ERROR, "invalid packet size");
> 			packet_hexdump(data, size);
> 			return;
> 		}
> 	} else {
> 		if (hdr->plen < event_data->size) {
> 			print_text(COLOR_ERROR, "too short packet");
> 			packet_hexdump(data, size);
> 			return;
> 		}
> 	}
> 
> 	event_data->func(data, hdr->plen);

yes exactly. And the minimum size for inquiry results is 1 octet. The num can be actually 0.

Regards

Marcel

