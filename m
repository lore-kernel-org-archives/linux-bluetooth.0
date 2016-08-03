Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <04a3d2af-f55a-da57-776d-3cdc28cbeb16@dsr-company.com>
References: <20160802154059.24472-1-andrey.zheregelya@dsr-company.com>
 <20160802154059.24472-2-andrey.zheregelya@dsr-company.com>
 <1470153463.21877.24.camel@hadess.net> <04a3d2af-f55a-da57-776d-3cdc28cbeb16@dsr-company.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 3 Aug 2016 12:48:37 +0300
Message-ID: <CABBYNZKkAGN0sM=nEpYXsQCX60mg14HjGM32KpjOVigc6N5seA@mail.gmail.com>
Subject: Re: [PATCH 2/2] doc/device-api.txt Information about D-Bus LastSeen property
To: Andrey Zheregelya <andrey.zheregelya@dsr-company.com>
Cc: Bastien Nocera <hadess@hadess.net>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrey,

On Tue, Aug 2, 2016 at 7:55 PM, Andrey Zheregelya
<andrey.zheregelya@dsr-company.com> wrote:
>
>
> On 02.08.2016 18:57, Bastien Nocera wrote:
>
>> It's doesn't, really, until you apply heuristics to it. How do you plan
>> to use this?
>
>
> Initially, there is a requirement for application to detect if a list of
> device are available for connection or not. Before connection and after.
>
> As far as I understood, d-bus interface doesn't provide any way to detect if
> device is advertising or not.
>
> le_seen and bredr_seen provides the last time when device's advertisement
> packet was detected (Of course if my understanding is correct)
>
> Application can read LastSeen time, read current time and compare with
> application-defined timeout to make a decision if device is alive.
>
> Yes, this property doesn't answer to direct question "Alive or not". But in
> this way user can apply any heuristic algorithm he wants.
>
> And this approach doesn't require any BLE connections to device.

But can't you use the last time you received a RSSI from the device?
Just timestamp it in the application side, in the other hand if
duplicate filtering is active this won't update in every packet
received since the controller can omit them.

-- 
Luiz Augusto von Dentz
