Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <BF6538CE-3F1E-4F73-8E9C-6BE256482E55@holtmann.org>
References: <1408565737-8187-1-git-send-email-armansito@chromium.org>
	<1408565737-8187-4-git-send-email-armansito@chromium.org>
	<41D7DE0B-C63B-4AD5-9C53-B323E787219A@holtmann.org>
	<CAHrH25QxTU7i+hq0Sd6htboQkA5Y8WGtkT7w7HSHCdmvOJYwtQ@mail.gmail.com>
	<BF6538CE-3F1E-4F73-8E9C-6BE256482E55@holtmann.org>
Date: Thu, 21 Aug 2014 15:17:49 -0700
Message-ID: <CAHrH25QjQPpxkSJ-we=bSwSDNjzSbtF30qbobwRc9oynTfT1Bw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 03/11] shared/gatt-client: Added initial skeleton
 and simple functions.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> I do not like the fact of _new() an object and have to call _init() to use. Actually calling _new() should trigger all needed transaction. We might want to just do this:
>
>         client = bt_gatt_client_new(att, mtu);
>
> And it will start the service discovery right away. As I said, it is fine to start the service discovery and set the ready handler later. Since we are main loop and single threaded this is totally fine.
>

Sounds good to me.


>> My idea here was that each profile/plugin can register its own handler
>> for the handles that they are interested in and get notified of a
>> changed service. We could also have a single service changed handler
>> here and the daemon code can then use that to go and probe each
>> plugin/profile based on that.
>
> I am not sure about this. The services changed should be handled centrally in the client itself. It might be better than allow to register a changed notifier on the bt_gatt_service that we get.
>

What I meant here is that the client, as you said, will handle the
change internally by rediscovering the involved services, updating its
cache, and so on. It's nice to then notify the upper layer about the
changes that occurred so that they can perform any necessary updates
in their state.


> Lets not bring handles into the game right here. It might be better to push this detail to later when the code is more complete.
>

I will add code for this handler when I add the service change
handling later then. For now, I'll go ahead and remove the
register/unregister functions that I introduced.

-Arman
