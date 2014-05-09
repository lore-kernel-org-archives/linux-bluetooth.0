Return-Path: <cyrus@holtmann.org>
MIME-version: 1.0
Content-type: text/plain; CHARSET=US-ASCII
Subject: Re: Bluez 5.18 on 3.12
From: David Eriksson <ftslc@me.com>
In-reply-to: <52C9C733-259A-427E-A857-9A291047620D@holtmann.org>
Date: Fri, 09 May 2014 17:02:04 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-id: <AE9E98E2-E507-43EC-9C1E-8464FB4F8F3C@me.com>
References: <BC611432-5B36-4EA5-8667-082F55020330@me.com>
 <52C9C733-259A-427E-A857-9A291047620D@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks for info Marcel,

Where can I read what's new/specific for the 1.4 release?  

I'm mainly after BLE, Hogp and passive scans.


best David

On 09 May 2014, at 13:06, Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi David,
> 
>> Anyone here that have a feeling on how hard it would be to get bluez 5.18+ with mgmt api running on 3.12?
> 
> that should just work. Linux kernel 3.4 and later should be supported. I recommend at least kernel 3.9 to get mgmt API 1.3 which contains a bunch of fixes that we otherwise have to work around.
> 
> Unless you need features from mgmt API 1.4, then you need at least Linux kernel 3.13.
> 
> Regards
> 
> Marcel
> 
