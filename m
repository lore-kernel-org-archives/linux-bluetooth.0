Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [RFC v1 0/1] doc/gatt-api: New API properties and methods for the GATT D-Bus API.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25RpdMCS=eizPUa5S-y0qBHyWQk6co1sJcwAQO9iC0xL=Q@mail.gmail.com>
Date: Wed, 23 Jul 2014 18:32:56 +0200
Cc: "Gu, Chao Jie" <chao.jie.gu@intel.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <D03CCCE3-51B5-4B3F-AB2D-AA9D766DCCCC@holtmann.org>
References: <1405986034-29122-1-git-send-email-armansito@chromium.org> <20140722085507.GA29664@t440s.lan> <CAHrH25SR83cXq-xGQz4x7axjcW=CUL_VCcAfhny_RyZ+t0oZ-g@mail.gmail.com> <3D02B219753AD44CBDDDE484323B1774112D121F@SHSMSX104.ccr.corp.intel.com> <CAHrH25RpdMCS=eizPUa5S-y0qBHyWQk6co1sJcwAQO9iC0xL=Q@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

>> Of course if DBus has these array object of characteristic property, there is more clear and easy for client to get. However, in my opinion, bluez just put out least but enough information in DBus Hierarchy for application to use. Just you said, to add array object property , this could even be a simple boolean property such as "DiscoveryComplete". That would be add more property in DBus, so on the contrary it would not let DBus Hierarchy look simple and clear.
>> Through the objectAdded and InterfaceAdded Signal, application can acquire this subset of object in fact.
> 
> Explain to me how, using only the InterfacesAdded signal, an
> application can know that all characteristic objects under a service
> hierarchy have been added? The only way is if the external application
> already knows about service it's interacting with, which is not the
> case if you're building a generic application API on top of
> bluetoothd. Without what I'm proposing, you can't build a generic GATT
> application API without requiring cumbersome event handling for each
> service, characteristic, and descriptor object as they get added and
> have only partial access to these objects in the handlers as the
> objects are getting processed. This might be fine for low-level
> applications that interact with D-Bus directly, but for higher level
> app developers this is a real issue that we want to handle properly
> and make their lives easier.

since InterfacesAdded is per object path, the extra Characteristics array makes sense. However that really only applies to application passively monitoring the bus objects and properties. The initiator of service discovery should only return from that method call when all other object signals have been send out. Similar to what we are doing with pairing or other potential long run asynchronous method calls.

Regards

Marcel

