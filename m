Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH 2/2] doc/device-api.txt Information about D-Bus LastSeen
 property
To: Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org
References: <20160802154059.24472-1-andrey.zheregelya@dsr-company.com>
 <20160802154059.24472-2-andrey.zheregelya@dsr-company.com>
 <1470153463.21877.24.camel@hadess.net>
From: Andrey Zheregelya <andrey.zheregelya@dsr-company.com>
Message-ID: <04a3d2af-f55a-da57-776d-3cdc28cbeb16@dsr-company.com>
Date: Tue, 2 Aug 2016 19:55:54 +0300
MIME-Version: 1.0
In-Reply-To: <1470153463.21877.24.camel@hadess.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



On 02.08.2016 18:57, Bastien Nocera wrote:

> It's doesn't, really, until you apply heuristics to it. How do you plan
> to use this?

Initially, there is a requirement for application to detect if a list of 
device are available for connection or not. Before connection and after.

As far as I understood, d-bus interface doesn't provide any way to 
detect if device is advertising or not.

le_seen and bredr_seen provides the last time when device's 
advertisement packet was detected (Of course if my understanding is correct)

Application can read LastSeen time, read current time and compare with 
application-defined timeout to make a decision if device is alive.

Yes, this property doesn't answer to direct question "Alive or not". But 
in this way user can apply any heuristic algorithm he wants.

And this approach doesn't require any BLE connections to device.

-- 
Best regards,
Andrey Zheregelya

