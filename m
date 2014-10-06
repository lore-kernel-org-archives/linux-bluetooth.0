Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJRX6vorDhW6_XecwKjEmvz3D6g97f9X_DjJRL=5dV5Ag@mail.gmail.com>
References: <1412375951-13940-1-git-send-email-armansito@chromium.org>
	<1412375951-13940-3-git-send-email-armansito@chromium.org>
	<CABBYNZLj2gGoCW-5hmkG2dA0i6Ss9RVJjjQhPzv=vk1ARephmQ@mail.gmail.com>
	<CAHrH25R28cLmLQH25TsTxXA=BRVMdbTec3atg5t6fMUEd_oSgw@mail.gmail.com>
	<CABBYNZJRX6vorDhW6_XecwKjEmvz3D6g97f9X_DjJRL=5dV5Ag@mail.gmail.com>
Date: Mon, 6 Oct 2014 14:03:56 -0400
Message-ID: <CAHrH25T+PiZtcNcR_Z+LcyO=mFyLWKRQie0fBHBCwVPU3zGzYQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/3] shared/gatt-server: Introduce shared/gatt-server.
From: Arman Uguray <armansito@google.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Arman Uguray <armansito@chromium.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>>> I think it is better to be able to attach/detach and existing db
>>> object because otherwise we will need to reconstruct it on every
>>> connection, furthermore the db might exist anyway since we need to be
>>> able to register services even when we are not connected.
>>>
>>
>> Yeah, I did it this way for the reasons I explained in the cover
>> letter: I basically want to keep the layering related to ATT protocol
>> within bt_gatt_server, however the way gatt-db is currently structured
>> makes it difficult. This particularly arises from the generic
>> read/write handlers, where an attribute value is stored outside of the
>> database and fetched via a callback.
>>
>> When bt_gatt_server receives a request, say Read By Group Type, it
>> calls gatt_db_read_by_group_type and then calls gatt_db_read for each
>> attribute handle returned. If there's no value stored in the database
>> and the value should be obtained elsewhere, then gatt-db invokes the
>> registered read callback. That read callback needs to eventually make
>> the value known to bt_gatt_server.
>
> Yep, I realize this is a bit messed up because even though
> gatt_db_read can be asynchronous it does not take a callback, worse it
> takes a bdaddr (most likely inspired by Android HAL)?
>

Yeah, it looks like it optionally takes in a bdaddr so that it can
determine the security level of the connection for attribute
permission checks. This doesn't work very well in the shared/ case,
since the transport is generic.


>> So my initial thought was to add an extra layer of callbacks between
>> bt_gatt_server and make bt_gatt_server the global server database that
>> can handle multiple bt_att instances that can be attached/detached on
>> demand. I think I could go back to the way I had it before, have
>> bt_gatt_server accept a gatt-db in its constructor, and perhaps handle
>> a special function for the read handling, such as a
>> bt_gatt_server_set_read_value_for_handle of sorts that can get called
>> from the read handler and that helps bt_gatt_server construct the ATT
>> protocol response, but still there are problems such as how the
>> generic gatt-db read handler will know which bt_gatt_server instance
>> to call this function on (as there can be several bt_gatt_server
>> instances for each device that acts simultaneously as a client and a
>> server). The way things currently are, you can't reliably pass this
>> information as user_data in the read callback, i.e. there is currently
>> no way to say which bt_gatt_server the request originated from. If
>> gatt-db is internal to bt_gatt_server and there are wrappers for
>> functions such as gatt_db_add_characteristic in the bt_gatt_server_*
>> namespace, then we can hook callbacks up in a way that handles this.
>
> Id say we need to pass a callback along with a userdata,
> gatt_db_read_t can probably take a the callback and another user_data
> associated with it so when it is completed it should be called.
>

Yep, this is exactly what I had in mind. The problem though is that
somebody still needs to pass in that callback. So maybe we could
change gatt_db_read to accept an additional callback/user_data which
would then get forwarded to the registered gatt_db_read_t. That would
definitely fix the problem here. It would also not break the android
code, since it can already work without invoking the callback. I'll
experiment with this.


>> So maybe it's better to have a single bt_gatt_server that exists for
>> the lifetime of the application and for each new connection we create
>> a bt_att and attach it to bt_gatt_server. Or, we go back to what we
>> originally had in mind, i.e. one gatt-db and multiple per-connection
>> bt_gatt_server instances but we will have to rework gatt-db a little
>> for this. Note that this hasn't been a problem for the android code,
>> since everything is implemented in one android/gatt layer, hence
>> gatt-db is inherently internal to the transport handling.
>
> Not sure how having bt_gatt_server not per connection would help here,
> the problem seems much more related to asynchronous calls, be it
> gatt_db or bt_gatt_server it does not seem to change anything you
> would still have to create a context that tracks the originating
> bt_att to send the response to, Android code seem to be building the
> response itself which I think it is to be in someplace else.

Exactly, if we had a single bt_gatt_server, that bt_gatt_server would
internally have to manage many instances of bt_att. For now I'll steer
away from this idea and see how I can make the asynchronous calls work
via an additional callback.

Cheers,
Arman
