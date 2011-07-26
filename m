Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAE-CKuhXwsUnQta4VjBvRxmXobC__=hutJre7y_uNDxjpQmthQ@mail.gmail.com>
References: <1309547558-9617-1-git-send-email-vinicius.gomes@openbossa.org>
	<1309547558-9617-2-git-send-email-vinicius.gomes@openbossa.org>
	<CAE-CKuhXwsUnQta4VjBvRxmXobC__=hutJre7y_uNDxjpQmthQ@mail.gmail.com>
Date: Mon, 25 Jul 2011 21:18:05 -0300
Message-ID: <CAE6HaM=kY8r_smasLE7jK4cjXL9bpwksBhysHAmp_5QSM1ei9A@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/8] Add stubs for storing SMP keys
From: Vinicius Gomes <vinicius.gomes@openbossa.org>
To: mike tsai <mikeyhtsai@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,

On Mon, Jul 25, 2011 at 8:40 PM, mike tsai <mikeyhtsai@gmail.com> wrote:
> Hi Vinicius,
>
> <cut>
>> diff --git a/src/event.c b/src/event.c
>> index 86a413e..3f0f454 100644
>> --- a/src/event.c
>> +++ b/src/event.c
>> @@ -395,9 +395,8 @@ proceed:
>>        adapter_set_state(adapter, STATE_IDLE);
>>  }
>>
>> -int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer,
>> -                               uint8_t *key, uint8_t key_type,
>> -                               uint8_t pin_length)
>> +int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer, uint8_t *key,
>> +               uint8_t key_type, uint8_t pin_length, int dlen, uint8_t *data)
>>  {
>>        struct btd_adapter *adapter;
>>        struct btd_device *device;
>> @@ -408,7 +407,10 @@ int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer,
>>
>>        DBG("storing link key of type 0x%02x", key_type);
>>
>> -       ret = write_link_key(local, peer, key, key_type, pin_length);
>> +       if (key_type < 0x10)
>> +               ret = write_link_key(local, peer, key, key_type, pin_length);
>> +       else
>> +               ret = write_longtermkeys(local, peer, NULL);
>>
>>        if (ret == 0 && device_is_temporary(device))
>>                device_set_temporary(device, FALSE);
> [MT] The event.c in the mainline is different from this, It is currently as
>        if (ret == 0) {
>                device_set_bonded(device, TRUE);
>
>                if (device_is_temporary(device))
>                        device_set_temporary(device, FALSE);
>        }
> this causes applying patches failed.
>

Yeah, the code should have moved on after I sent this.

> I am also wandering why these patches are not up-streamed yet. It
> would seem to me that the kernel SMP patches will need these to
> support full capability.
>

After I sent these patches, I received some comments from Johan that
there could be some simplifications if
I used different messages for the SMP keys. I still didn't get to
implement them, but I will make those changes soon.

Don't know if it will be of any help, but in my personal repository[1]
(in the branch for-upstream) there is a version that
applies cleanly on top of the mainline HEAD. Just a warning, that it
was just compile-tested ;-)

> Regards,
>
> Mike
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


Cheers,
-- 
Vinicius

[1] http://git.infradead.org/users/vcgomes/bluez.git
