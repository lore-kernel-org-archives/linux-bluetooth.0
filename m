Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 2 May 2013 17:15:35 -0300
Message-ID: <CAE6HaM=ogwUXRFM1+Pv-O9Cg0W3ueOpATMtU8kW2=D4Ghb93JA@mail.gmail.com>
Subject: GATT Clients and Servers in the kernel (was Re:[PATCH BlueZ v3 06/16] attrib...)
From: Vinicius Gomes <vinicius.gomes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	Jefferson Delfes <jefferson.delfes@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

[ moving to a new thread ]

On Thu, May 2, 2013 at 1:05 PM, Marcel Holtmann <marcel@holtmann.org> wrote=
:
> Hi Johan,
>
>>> -gboolean g_attrib_set_destroy_function(GAttrib *attrib,
>>> -            GDestroyNotify destroy, gpointer user_data)
>>> +bool g_attrib_set_destroy_function(GAttrib *attrib, GDestroyNotify des=
troy,
>>> +                                                    gpointer user_data=
)
>>
>> I've applied patches 1-5 but stopped there since I'm still not sure that
>> we want to change this for an API which tries to follow GLib conventions
>> (after all that's why the GAttrib API has G and g_ prefixes). Marcel, do
>> you have any opinion about this one way or another?
>
> the long term plan is to use standard types like bool, char, uint8_t and =
also void * here. However we might want to also see how to get rid of g_ pr=
efix as well. Especially g_attrib seems to be a good candidate to get rid o=
f.
>
> I also like to see ATT and GATT being implemented as src/shared/ under LG=
PL so we can be easily share it in the future. I already have some (unpubli=
shed) code for src/shared/att.[ch] and src/shared/gatt.[ch] already, but I =
think what we first need to do is to figure out how we handle clients and s=
ervers from the kernel side. Especially with the background of the kernel a=
uto-connecting LE channels in the future.

I am assuming you were talking about the connection establishment. If
not, I am not following.

I can only think of an evolutionary approach of what we are already doing:

-  when we are the initiating side, the kernel will only auto-connect
devices that have an associated socket blocking on connect(); the
kernel may even use the white list if it seems appropriate (no
resolvable addresses in the list of "to be connected" sockets for
example).

- accepting side, we only send connectable advertising events when
there's a listen() active, it would be nice to have a way to only
appear connectable to a set of devices, i.e. use the white list in
this case.


>
> Regards
>
> Marcel
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
--
Vinicius
