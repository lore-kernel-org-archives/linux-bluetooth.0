Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <7769C83744F2C34A841232EF77AEA20C01D374ED91@dnce01.ent.ti.com>
References: <BANLkTimqLNGow0wq2uWSqh5EVNp9Xsb0WQ@mail.gmail.com>
	<7769C83744F2C34A841232EF77AEA20C01D374ED91@dnce01.ent.ti.com>
Date: Thu, 2 Jun 2011 08:52:26 -0400
Message-ID: <BANLkTi=TK+jrSjt61qn9mCnS-udWfHAv3w@mail.gmail.com>
Subject: Re: [RFC] New API for attribute read/write callback registration
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Ganir, Chen" <chen.ganir@ti.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Thu, Jun 2, 2011 at 2:31 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
>> And the new signatures for callbacks:
>>
>>              uint8_t (*read)(GAttrib *attrib, struct attribute *a);
>>              uint8_t (*write)(GAttrib *attrib, struct attribute *a);
>>              uint8_t (*update)(GAttrib *attrib, struct attribute
>> *a);
>>
> Can this be united into the same API ? Why do we need the cb->event
> if we have cb->write or cb->read ? For example :

Note that they are part of a C union, so a single callback can be
used. Think of it as each struct cb corresponding to a single "event"
(read, write or update), not multiple callbacks on the same struct.
This way you can attach multiple struct cb's to the same struct
attribute.

>
> cb = g_new0(struct attrib_cb, 1);
> memset(cb,0,sizeof(cb);
> cb->write = <write_callback>;
> cb->read = <read_callback>;
> a = attrib_db_add(<handle>, <uuid>, <read_permissions>,
>  <write_permissions>, <value>, <value_len>,cb);
>
> In addition - what is the ATTRIB_UPDATE event ? When is it called ?

There is a attrib_db_update(). It is used by profiles which need to
update the value stored on the struct attribute. It also triggers
indications/notifications as necessary.

> Callbacks for read/write are meaningful only for characteristics values,
> and characteristics descriptors. What happens when someone provides a
> callback for the service UUID itself ? For example, from the
> plugins/gatt-example  :
>
>    /* Battery state service: primary service definition */
>    bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
>    att_put_u16(BATTERY_STATE_SVC_UUID, &atval[0]);
>    attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
>
> Is there any point in adding a callback here?

Callbacks are to be registered when the profile sees necessary. If for
some reason it wants to be notified when the primary service
definition is read , it can do so. We don't want to make the API too
rigid to allowing callbacks only on certain GATT structures. This is
an attribute level callback, not GATT.

> Maybe a more GATT like approach should be used here - encapsulate the
> attrib_db_add functions with GATT defined service, descriptor,
> characteristic. All GATT characteristics, services and descriptors are
> eventually ATT attributes. So For example :
> [snip]

This was an idea I proposed long time ago (December last year), but we
didn't have time to implement/design it. Feel free to propose APIs and
patches :). Sending it to the list is the best way to get feedback.

> In this case, we do not allow setting a callback for the service handle.
> GATT does not define procedures for a client to read the service itself,
> just discover it, and then list it. I'm not sure if GATT permissions should
> apply here, for limiting find_by_type of find_by_uuid with authorization
> or authentication.

As I said before, I personally would prefer to not have the callback
mechanism to rigid. Leaving it on the attribute level allows many
usages, such as custom permission mechanisms (which are allowed but
the GATT denition when they leave it "implementation or profile
specific").

Besides, which benefits do you see on allowing callbacks only per
characteristic values and descriptors?

> We also hide the handles from the GATT user, since GATT server user does
> not really need to care about the some of the handles. We just need to
> make sure here that when a service is added, no other service is allowed
> to be added before all of the first service characteristics and descriptors
> were added.

Yes, a GATT level API would be much welcome. It would need to support
service includes as well, which needs start/end handles of the
included service.

> more examples :
> handle gatt_add_characteristic(<uuid>,<svc_size>,<read_perm>,
> <write_perm>,<value>,<len>,<write_cb>,<read_cb>);
>
> handle gatt_add_characteristic_client_config(<read_perm>,
> <write_perm>,<value>,<len>,<write_cb>,<read_cb>);
>
> The handle returned by some of the functions may be used for adding
> included services, or identifying the attribute when a single callback is
> used for all characteristics.

Note that on your proposal above you restrict callbacks to only
read/write. If we want to add callbacks/hooks for other "events"
later, we would need to change every caller of this function. This is
the main point why we are creating a pluggable "struct callback" which
can be easily extended for future use without needing to change every
current user.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
