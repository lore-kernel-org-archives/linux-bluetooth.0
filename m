Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25RVKCL9RQCeFBJAsUsNV1umOR92VWV1JQgkwy-RNh-GAg@mail.gmail.com>
References: <54F752D8.1000605@ubnt.com>
	<CAHrH25RVKCL9RQCeFBJAsUsNV1umOR92VWV1JQgkwy-RNh-GAg@mail.gmail.com>
Date: Wed, 4 Mar 2015 23:21:01 +0100
Message-ID: <CAN_7+Yagp-R+H+nhCtmdqWyAJm4jO_VsB5c343A=39zurwqpPw@mail.gmail.com>
Subject: Re: Non-consecutive handle values in GATT
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: Andrejs Hanins <andrejs.hanins@ubnt.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Marcin Kraglak <marcin.kraglak@tieto.com>,
	Szymon Janc <szymon.janc@tieto.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrejs,

On Wed, Mar 4, 2015 at 10:39 PM, Arman Uguray <armansito@chromium.org> wrote:
> Hi Andrejs,
>
>> On Wed, Mar 4, 2015 at 10:45 AM, Andrejs Hanins <andrejs.hanins@ubnt.com> wrote:
>> Hello,
>>
>>     I'm experimenting with an LE peripheral device which provides GATT
>> services described by attributes with non-consecutive handle values, i.e.
>> there are "gaps" between handle values. According to the Bluetooth Core
>> specification 4.0 (Volume 3, Part G, "2.5.1 Overview") it is allowed:
>>
>>      Although the Attribute Handle values are in increasing order, following
>> Attribute Handle values may differ by more than one.
>>
>>     Based on my experiments, BlueZ 5.28 and also git-master as of today does
>> not support non-consecutive handle values GATT table. As a result, I can't
>> connect to my device because gatt-client fails to initialize properly. The
>> failing place is in discover_descs():
>>
>>       if (gatt_db_attribute_get_handle(attr) !=
>>                             chrc_data->value_handle)
>>             goto failed;
>>
>>     The value of chrc_data->value_handle is correct and matches GATT table
>> one the device, but the attr->handle has the value of previous attribute
>> (Primary Service UUID in my case) +2. This handle value calculation happens
>> in gatt_db_service_add_characteristic() which has strange code:
>>
>>     /* We set handle of characteristic value, which will be added next */
>>     put_le16(get_handle_at_index(service, i - 1) + 2, &value[1]);
>>
>>     Before trying to fix the problem by myself it would be great to hear
>> some comments about this issue. Does it seem like a bug or I missed
>> something?
>>
>>     As a note, I can successfully connect to my LE peripheral from an iPhone
>> LightBlue app, which does not posses any issues during GATT discovery and
>> can read/write the characteristic on the device.

Can you share what device are you using? Is it on the market already?
I'm just curious as I haven't seen any device doing it on last couple UPFs

But indeed, it looks like this is something we need to fix.

\Lukasz
>>
>
> This is interesting. The gatt-db was initially designed for the
> server-role, with the assumption being that the handles of a service
> will be contiguous. So, it allows gaps between separate service ranges
> but not between individual attributes between the handles of a
> service. This assumption is OK for server-role but now that we also
> use gatt-db for the client role, then maybe this assumption is
> incorrect in some cases.
>
> So I guess we need a way to enter individual attributes with arbitrary
> handles directly into the database, since it currently creates a
> contiguous array to store the attributes of a service. I remember Luiz
> was talking about changing the way the gatt-db addition/removal works
> on IRC so maybe he can provide more input here. Fwiw, we never
> encountered this issue because in practice I've never seen a database
> implementation that skips attribute handles within a service.
>
>>
>> BR, Andrey
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> Cheers,
> Arman
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
