Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Thu, 2 Jun 2011 08:31:58 +0200
Subject: RE: [RFC] New API for attribute read/write callback registration
Message-ID: <7769C83744F2C34A841232EF77AEA20C01D374ED91@dnce01.ent.ti.com>
References: <BANLkTimqLNGow0wq2uWSqh5EVNp9Xsb0WQ@mail.gmail.com>
In-Reply-To: <BANLkTimqLNGow0wq2uWSqh5EVNp9Xsb0WQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,


> To allow to pass GAttrib to the read/write callbacks, we need to
> decouple the callback information from struct attribute. This also
> allows to easily extend with more operations other then read/write
> (e.g. notifications). Therefore we plan to have this new API (already
> implemented, and which we should send patches anytime soon):
> 
> struct attrib_cb *cb;
> struct attribute *a;
> 
> a = attrib_db_add(<handle>, <uuid>, <read_permissions>,
> <write_permissions>, <value>, <value_len>);
> cb = g_new0(struct attrib_cb, 1);
> /* event: ATTRIB_READ, ATTRIB_WRITE or ATTRIB_UPDATE */
> cb->event = <event>;
> /* cb->read, cb->write or cp->update, depending on the event type */
> cb->write = <write_callback>;
> attrib_add_callback(a, cb)
> 
> And the new signatures for callbacks:
> 
>              uint8_t (*read)(GAttrib *attrib, struct attribute *a);
>              uint8_t (*write)(GAttrib *attrib, struct attribute *a);
>              uint8_t (*update)(GAttrib *attrib, struct attribute
> *a);
> 
Can this be united into the same API ? Why do we need the cb->event 
if we have cb->write or cb->read ? For example :

cb = g_new0(struct attrib_cb, 1);
memset(cb,0,sizeof(cb);
cb->write = <write_callback>;
cb->read = <read_callback>;
a = attrib_db_add(<handle>, <uuid>, <read_permissions>,
 <write_permissions>, <value>, <value_len>,cb);

In addition - what is the ATTRIB_UPDATE event ? When is it called ?

Callbacks for read/write are meaningful only for characteristics values, 
and characteristics descriptors. What happens when someone provides a 
callback for the service UUID itself ? For example, from the 
plugins/gatt-example  :

    /* Battery state service: primary service definition */
    bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
    att_put_u16(BATTERY_STATE_SVC_UUID, &atval[0]);
    attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);

Is there any point in adding a callback here? 

Maybe a more GATT like approach should be used here - encapsulate the 
attrib_db_add functions with GATT defined service, descriptor, 
characteristic. All GATT characteristics, services and descriptors are
eventually ATT attributes. So For example :

service_handle gatt_add_prim_service(<uuid>,<svc_size>) 
{
    uint16_t h;
    const int svc_size = 4;
    uint32_t sdp_handle;
    uint8_t atval[256];
    bt_uuid_t uuid;

    /* Do some calculations to find out the real service size 
       (considering the number of characteristics and descriptors 
       for example)
    */
    h = attrib_db_find_avail(svc_size);

    if (h == 0) {
        error("Not enough free handles to register service");
        return 0;
    }

    bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);	
    att_put_u16(<uuid>, &atval[0]);
    /* For GATT Service, we do not allow reading/writing or any 
       other Handle permissions. If we do want to allow GATT user 
       to set these values, we can add them to the function 
       prototype later.
    */
    attrib_db_add(h, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
    return h;
}

gatt_add_primary_service(BATTERY_STATE_SVC_UUID, svc_size);

In this case, we do not allow setting a callback for the service handle. 
GATT does not define procedures for a client to read the service itself, 
just discover it, and then list it. I'm not sure if GATT permissions should 
apply here, for limiting find_by_type of find_by_uuid with authorization 
or authentication.

We also hide the handles from the GATT user, since GATT server user does 
not really need to care about the some of the handles. We just need to 
make sure here that when a service is added, no other service is allowed 
to be added before all of the first service characteristics and descriptors 
were added.

more examples :
handle gatt_add_characteristic(<uuid>,<svc_size>,<read_perm>,
<write_perm>,<value>,<len>,<write_cb>,<read_cb>);

handle gatt_add_characteristic_client_config(<read_perm>,
<write_perm>,<value>,<len>,<write_cb>,<read_cb>);

The handle returned by some of the functions may be used for adding 
included services, or identifying the attribute when a single callback is 
used for all characteristics.

Thanks,
Chen Ganir.

