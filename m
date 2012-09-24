Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <506044CD.7070209@ti.com>
References: <1348485571-17397-1-git-send-email-mikel.astiz.oss@gmail.com>
	<506044CD.7070209@ti.com>
Date: Mon, 24 Sep 2012 23:10:12 +0300
Message-ID: <CABBYNZ+W9g6ZWfe5t-BAZgDxW4K9JSswNXjx7d-x-d=g5D0NeQ@mail.gmail.com>
Subject: Re: [RFC v0] device: Add DiscoveryComplete signal
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Chen Ganir <chen.ganir@ti.com>
Cc: Mikel Astiz <mikel.astiz.oss@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel, Chen,

On Mon, Sep 24, 2012 at 2:32 PM, Chen Ganir <chen.ganir@ti.com> wrote:
> Mikel,
>
>
> On 09/24/2012 01:19 PM, Mikel Astiz wrote:
>>
>> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>>
>> The D-Bus API has to report when the UUID property has been fully
>> populated, once the service discovery has been finished as part of the
>> pairing process. This allows UIs to show the device only after its
>> services are known, avoiding transitional states.
>> ---
>
> We have the PropertyChanged signal, which is triggered wach time the
> search_cb is called (device.c). Why do you need to create a new signal,
> instead of using this already existing event, and send PropertyChanged on
> UUIDS with the peer device list of UUID's only when the list is complete and
> not on every SDP record found ? This way, you can keep the existing
> implementations working, and you can also add new functionality based on the
> fact that you only receive one instance of this event ?

The Properties interfaces will have grouping support:
http://dbus.freedesktop.org/doc/dbus-specification.html#standard-interfaces-properties

Not only that, but the UI will also be able to listen for the device
object interfaces once we have the ObjectManager integrated, which
should also support grouping the interfaces which is probably a more
correct way to determine what are supported.

-- 
Luiz Augusto von Dentz
