Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20141013080138.GA5588@t440s.lan>
References: <1412954626-30226-1-git-send-email-fons@spotify.com>
 <1412954626-30226-3-git-send-email-fons@spotify.com> <20141013080138.GA5588@t440s.lan>
From: Alfonso Acosta <fons@spotify.com>
Date: Mon, 13 Oct 2014 13:45:40 +0200
Message-ID: <CAHF=Y4qvU96-XxaPf42u9fp_Onw0TebQcwQ9Ken5ixAC63=nmg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] core: Add subscription API for Manufacturer
 Specific Data
To: Alfonso Acosta <fons@spotify.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,


> On Fri, Oct 10, 2014, Alfonso Acosta wrote:
>> --- a/src/adapter.h
>> +++ b/src/adapter.h
>> @@ -30,6 +30,8 @@
>>  #include <glib.h>
>>  #include <stdbool.h>
>>
>> +#include "eir.h"
>> +
>>  #define MAX_NAME_LENGTH              248
>>
>>  /* Invalid SSP passkey value used to indicate negative replies */
>> @@ -138,6 +140,14 @@ struct btd_adapter_pin_cb_iter *btd_adapter_pin_cb_iter_new(
>>  void btd_adapter_pin_cb_iter_free(struct btd_adapter_pin_cb_iter *iter);
>>  bool btd_adapter_pin_cb_iter_end(struct btd_adapter_pin_cb_iter *iter);
>>
>> +typedef void (*btd_msd_cb_t) (struct btd_adapter *adapter,
>> +                             struct btd_device *dev,
>> +                             const struct eir_msd *msd);
>> +void btd_adapter_register_msd_cb(struct btd_adapter *adapter,
>> +                                     btd_msd_cb_t cb);
>
> In our user space code we try to follow the following principles for
> internal header files:
>
> 1) The c-file that includes them should also include the prerequisites
> 2) We don't use multi-include guards
>
> The general idea is that we don't want hidden and implicit dependencies
> but prefer having them explicitly spelled out. This practice also helps
> detect circular dependencies. For public header files or those of
> library-like modules we don't follow this practice (e.g. gdbus/gdbus.h).
>
> As for your patch, I'd suggest to spell out each of the three variables
> in your bt_msd_cb_t instead of using the "struct eir_msd" in adapter.h.
> That way you don't have a dependency to eir.h from adapter.h.

Thanks for the explanation. v3 corrects this.

-- 
Alfonso Acosta

Embedded Systems Engineer at Spotify
Birger Jarlsgatan 61, Stockholm, Sweden
http://www.spotify.com
