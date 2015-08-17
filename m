Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAD0=r8xdPOiasvH6J8+M2k5gYoSWp6jbH2A8FZLvsV8KjdepYg@mail.gmail.com>
References: <1439404612-2346-1-git-send-email-jpawlowski@google.com>
	<CABBYNZKXOA3kNXQHbdJMah4JS1OGPE8Au9xNFg6V=W_2JP1SWQ@mail.gmail.com>
	<CAD0=r8xdPOiasvH6J8+M2k5gYoSWp6jbH2A8FZLvsV8KjdepYg@mail.gmail.com>
Date: Mon, 17 Aug 2015 23:47:36 +0300
Message-ID: <CABBYNZ+HsT7u0xQH5M4nqg_Mf+bxx3bvS+zioahOaZsGVTFARA@mail.gmail.com>
Subject: Re: [BlueZ RFC] src/device: gatt database persistence
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Mon, Aug 17, 2015 at 8:17 PM, Jakub Pawlowski <jpawlowski@google.com> wrote:
> On Thu, Aug 13, 2015 at 9:51 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Jakub,
>>
>> On Wed, Aug 12, 2015 at 9:36 PM, Jakub Pawlowski <jpawlowski@google.com> wrote:
>>> This patch changes how gatt database for paired devices is stored between
>>> restarts of bluetoothd. Right now only definition of services is stored.
>>> After applying this patch whole gatt database will be stored/restored.
>>>
>>> Storing whole database can have big impact on reconnection time for paired
>>> devices, because full discovery can take up to 10 seconds.
>>
>> There is a TODO for this but it seems that the documentation under
>> doc/settings-storage.txt outdated. I believe the preferred way to
>> store is a binary format under cache so the attributes can be
>> persisted even if the device info is not stored which is the same
>> design we use for SDP records,
>
> Current policy for LE devices is to store only Service definitions for
> ONLY paired devices.
> I think that storing GATT database for unpaired devices, especially
> ones that have rotating MAC address doesn't really benefit too much,
> it'll change every 15 minutes and have to be re-discovered leaving
> unnecessary mess in cache. Is keeping cache for paired devices only
> fine for you ?

That fine, I guess we can skip devices using RPA that are not paired
since anyway they shall never have the temporary flag cleared that
should prevent any of its attributes going to the cache.

> Also when it comes to format for storing data, I'd like to use
> functions from shared/gatt_db to restore GATT
> gatt_db_insert_service
> gatt_db_service_add_included
> gatt_db_service_insert_characteristic
> gatt_db_service_insert_descriptor
> just to make sure everything will get wired properly, and will work
> fine if implementation of those methods change (I also don't want to
> reimplement what they already do).  I'll change implementation to
> store properties and uuids in binary format, but I'd prefer not to
> implement serialization to make one line per attribute. Will that be
> fine?

I guess we could probably store using handle:uuid:value format, this
should not be a big deal in terms of serialization and save a little
space comparing using groups and entries for both uuid and value.

>
>> note that the code will perform a Read
>> By Group Type regardless if the database is empty or not to validate
>> the services on every connection so we need to update the cache every
>> time an attribute changes.
>
> Yes, I'm aware of that. That's actually good for devices that have
> "Service Changed" characteristic badly implemented, or when something
> just goes wrong.

Yep, apparently some device may have a bad habit to loose the
configuration of Service Changed when the battery has been removed,
anyway since we do have this in place it make sense to restore the
cache for device which had been cleared the temporary flag, which
essentially means they are persistent but not necessarily paired.


-- 
Luiz Augusto von Dentz
