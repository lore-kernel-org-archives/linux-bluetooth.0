Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLE_xxoaPXZ=9LY2AwT-Pa_mqEYRD8v4_TgMTdo77j-Qw@mail.gmail.com>
References: <CAHrH25S3h=LjaXSFkJiz5X41JD9-1zNJiD1R7hQNfA3aSbO0sg@mail.gmail.com>
	<CABBYNZLE_xxoaPXZ=9LY2AwT-Pa_mqEYRD8v4_TgMTdo77j-Qw@mail.gmail.com>
Date: Thu, 23 Oct 2014 11:53:13 -0200
Message-ID: <CAM4ayVBiofZ78=ZG6Z5vVcAHEc3xkr=-4jOjcMA937mm4fR6EQ@mail.gmail.com>
Subject: Re: Attribute security permissions and CCC descriptors in shared/gatt-server.
From: =?UTF-8?Q?Vin=C3=ADcius_Costa_Gomes?= <vcgomes@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Arman Uguray <armansito@chromium.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>, Marcin Kraglak <marcin.kraglak@tieto.com>,
	Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Oct 23, 2014 at 5:51 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:

[...]

>>
>>
>> *** 2. Is shared/gatt-server responsible for keeping track of Client
>> Characteristic Configuration descriptor states for each bonded client?
>> ***
>>
>> Currently, the descriptor read/write operations need to be handled by
>> the upper layer via the read/write callbacks anyway, since the
>> side-effects of a writing to a particular CCC descriptor need to be
>> implemented by the related profile. In the bonding case, the
>> read/write callbacks could determine what value to return and how to
>> cache the value on a per-device basis without shared/gatt-db having a
>> notion of "per-client CCC descriptors".
>
> Well making gatt_db have the notion of CCC would make things a little
> bit simpler for storing and reloading but it would probably force us
> to rethink how the db access the values, perhaps the db could cache
> CCC values per client so it could detect changes and send
> notifications automatically whenever the profiles tell it values has
> changed or when a write succeeds.
>
>> Does this make sense? If so, is there a point of keeping the "bdaddr_t
>> *bdaddr" arguments of gatt_db_read_t, gatt_db_write_t, gatt_db_read,
>> and gatt_db_write? Note that I'm currently passing NULL to all of
>> these calls for this parameter in shared/gatt-server, since bt_att
>> doesn't have a notion of a BD_ADDR.
>
> I guess this was inspired by Android, I would agree that if you
> register a characteristic and set the permission properly then it does
> not matter who is attempting to read/write as long as they are fulfill
> the requirements it should be okay but perhaps Android have pushed the
> notion of CCC up in the stack which force it to expose the remote
> address. Anyway for unit test I will have to address it since that
> will be using a socket pair, perhaps passing NULL is fine if we have
> CCC caching but in case of Android I don't think we can do much about
> it.
>

Don't know if I am following correctly here. But I guess that even
that, we would
need to have a way for the profile to identify who is writing in the CCC.

For example, in a (imaginary) Temperature profile that the client may
choose the unit (degrees Celsius or Fahrenheit) that is used for
indications/notifications. Each client would receive a different
notification value depending on what's written on the CCC.

Another solution would be for the "view" of the database that the profile has
depends on the device "operating" (not a very good word, because a
operation may be something like receiving a notification) on it. Just thinking
out loud.

>
> --
> Luiz Augusto von Dentz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius
