Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110310111408.GA18256@jh-x301>
References: <1299058614-8904-1-git-send-email-lkslawek@gmail.com>
	<1299058614-8904-3-git-send-email-lkslawek@gmail.com>
	<20110310111408.GA18256@jh-x301>
Date: Thu, 10 Mar 2011 12:28:23 +0100
Message-ID: <AANLkTi=3PwFWLUAVXNGjrA-9dBRD=58F_yq5w84rVpXV@mail.gmail.com>
Subject: Re: [PATCH 2/4] Add actual service for Message Access Profile
From: Slawomir Bochenski <lkslawek@gmail.com>
To: lkslawek@gmail.com, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Mar 10, 2011 at 12:14 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Slawek,
>
> On Wed, Mar 02, 2011, lkslawek@gmail.com wrote:
>> +     ret = obex_get_stream_start(os, name);
>> +     if (ret < 0)
>> +             goto fail;
>> +
>> +     return 0;
>> +fail:
>> +     return ret;
>> +}
>
> How about just "return obex_get_stream_start(os, name);"?
>
>> +     ret = obex_put_stream_start(os, name);
>> +     if (ret < 0)
>> +             goto fail;
>> +
>> +     return 0;
>> +fail:
>> +     return ret;
>> +}
>
> Same here.
>
This is ready for upcoming change, where there is also applications
parameter parsing that can fail and return it's own error code.
>> +     }
>> +
>> +     return 0;
>> +}
>> +static struct obex_service_driver mas = {
>
> Missing empty line before "statis struct ...".
>
I will fix it.
>>  static int mas_init(void)
>>  {
>> +     int err;
>> +
>> +     err = obex_service_driver_register(&mas);
>> +     if (err < 0)
>> +             goto fail_mas_reg;
>> +
>>       return 0;
>> +
>> +fail_mas_reg:
>> +     return err;
>>  }
>
> Just "return obex_service_driver_register(&mas);" should be enough.
This one makes more sense when you look at all patches in this set as a whole.

-- 
Slawomir Bochenski
