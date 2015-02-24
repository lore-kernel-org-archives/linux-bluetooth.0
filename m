Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25T5zMc-ncxrhojL7-fQak1TAwZhktAXCncTd5-B9SO_zA@mail.gmail.com>
References: <1424483824-27374-1-git-send-email-armansito@chromium.org>
	<1424483824-27374-7-git-send-email-armansito@chromium.org>
	<CABBYNZ+mD5QRvGHCo+Ugr7P2_M0-thTr_DHpyndTyRRn-ZmNEw@mail.gmail.com>
	<CABBYNZ+ERC-uiurkUKRVjxF_d5jrihpjRQKxFGop3E8BDMb3kw@mail.gmail.com>
	<CAHrH25T5zMc-ncxrhojL7-fQak1TAwZhktAXCncTd5-B9SO_zA@mail.gmail.com>
Date: Tue, 24 Feb 2015 11:01:08 +0200
Message-ID: <CABBYNZ+J2VMPp-vjDW+Dj-hB-W3=ocrCgFBOt3HrFMARa_GARA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 06/18] core: gatt: Implement GattManager1.RegisterService
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Mon, Feb 23, 2015 at 11:24 PM, Arman Uguray <armansito@chromium.org> wrote:
>>> Here is the tricky part of ObjectManager, we should avoid creating
>>> different client instance for it since it caches the whole object
>>> hierarchy it becomes really expensive as the process adds more
>>> services. So we have to detect if we already a client instance for the
>>> sender, if we do then we proceed with g_dbus_client_ref,
>>> g_dbus_proxy_new, etc. Also this needs to match the sender not only
>>> path, so this needs fixing anyway.
>>
>> Another thing we could perhaps do is to change this to be
>> RegisterServices, so the application just need to register itself and
>> bluetoothd will keep track of services, then perhaps we can have an
>> optional property to GattService to indicate if the service is active
>> or not in addition to InterfacesRemoved if we want to give the
>> application the ability to dynamically activate/deactivate its
>> services.
>>
>
> I've been thinking about how we can do this cleanly. A
> RegisterServices method could make sense, though I can't really see a
> clear use case for SetActive, and even with RegisterServices we would
> have to handle what would happen if the same application called
> RegisterServices multiple times. Or are you suggesting that
> RegisterServices wouldn't accept an object path at all, basically we
> would just do everything through an initial GetManagedObjects call and
> then keep track of things based on InterfacesAdded|Removed? I think
> InterfacesAdded gets tricky, because new objects might get added but
> we wouldn't know when all objects of a service have been added
> completely and we would end up with something complicated. A
> RegisterService method is nice and explicit as it implies that all
> objects have been exported and are ready to be fetched.

I guess depending on InterfaceAdded/Removed is not that bad, the
client should group the interfaces anyway. The gatt_db perhaps is
causing us to assume we need to know the exact number of attributes
before hand, but that can be changed if we allow initial number of
handles but reallocate if there are more, provided we don't step in
another service range but this is unlikely since we are single
threaded and the proxies/objects should be in the right sequence.

> I've also been considering the other extreme, which is to ditch
> ObjectManager entirely and make calls to Properties.GetAll on each
> object. I don't think either approach has a clear advantage over the
> other, since without ObjectManager we have to call GetAll on each
> object but we only deal with object paths that we know are relevant
> during RegisterService, while with ObjectManager we get all objects at
> once and can track property changes and object addition/removal using
> signals but then we end up having to filter through many potentially
> irrelevant proxies every time there is a call to RegisterService.

Yep, it is inconvenient to use ObjectManager with the idea of register
service by service, Id say it is all or nothing, but Im afraid
Properties.GetAll will be costly depending on how name objects it
needs to fetch so I lean towards ObjectManager.

> I guess I have to fix the GDBusClient behavior anyway, as right now I
> create a new GDBusClient for each RegisterService call, so we should
> at least cache the GDBusClient per-sender and reuse it if we're going
> to stick with ObjectManager but I'm now starting to lean more towards
> using Properties.GetAll directly, since at least we wouldn't need the
> requirement that the application manage all of its objects through
> ObjectManager.

If we were to use that Id prefer to have a reverse form of
GetManagedObjects, so RegisterServices(a{oa{sa{sv}}} objects,
options) and then application provides the list of
objects/interfaces/properties all at once so there is no need to
expend time doing reverse lookup with GetAll.



-- 
Luiz Augusto von Dentz
