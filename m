Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <2774A89A-B2EE-4346-BAD1-DBA0E3014661@holtmann.org>
References: <1405718037-15401-1-git-send-email-armansito@chromium.org>
	<1405718037-15401-2-git-send-email-armansito@chromium.org>
	<2774A89A-B2EE-4346-BAD1-DBA0E3014661@holtmann.org>
Date: Tue, 22 Jul 2014 18:22:25 -0700
Message-ID: <CAHrH25TprAhCBBOUJZrwDPpttuxXE=+QMBnKL9WpsR_h3g70QQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] shared/gatt: Introduce gatt-helpers.h skeleton.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>> + * The callbacks below encode the operation status in a 16-bit unsigned integer,
>> + * where 0-255 are allocated for ATT protocol errors.
>> + *
>> + *  - 0x0000: Success
>> + *  - 0x0001: Invalid handle (ATT protocol error)
>> + *  - 0x0100: Unknown failure (bluetoothd defined)
>
> do we really need this? I am feeling a bit uneasy about these kind of error splits where we are overloading wire protocol errors with internal errors.
>

I think they are useful. I think it ends up being cleaner than
returning two separate arguments in callbacks, one for ATT protocol
errors and one for application-specific errors and we clearly document
above that the LSB is for ATT protocol errors only.


>> +#define BT_GATT_ERROR_UNKNOWN                0x0100
>> +#define BT_GATT_ERROR_INVALID_RSP    0x0101
>
> Especially with the background of invalid response as listed here, I think the only real result is a disconnect anyway, so we might better introduce a disconnect reason with the disconnect callback. Just an idea.
>

Well with some errors you want to disconnect but not with all errors.
For example, in the case of verified writes, if the response PDU
didn't match the blob that we sent, we would report that the
verification failed in an error like this but this wouldn't warrant a
disconnect.

In general, though, I agree with having a disconnect callback. In this
case though, I feel that, from a layering perspective, these helpers
should just return an error in the result callback and have the upper
layer interpret that as a requirement for disconnect. After all,
reporting these helper-defined errors in a result callback is not all
that different from what you're suggesting.

We can then go and add that exact "disconnect required" callback to
src/shared/gatt.h when we add it later. I'd like to leave these as
just GATT procedure helper functions without doing any big state
keeping here.


>> +
>> +typedef void (*bt_gatt_destroy_func_t)(void *user_data);
>> +
>> +typedef void (*bt_gatt_result_callback_t)(uint16_t status, void *user_data);
>> +typedef void (*bt_gatt_discovery_callback_t)(uint16_t status,
>> +                                     struct queue *results, void *user_data);
>
> Can we please avoid internal data structures exposed here. I would say this needs to provide its own GATT specific data structure for the result. Most likely an allocated array or pointer array with a dedicated free function.

Interesting, I was under the impression that struct queue was to be
used like GSList or other list structures used elsewhere and it was ok
to use it here since this is all going into src/shared. Are you
suggesting something like:

 typedef void (*bt_gatt_services_callback_t)(uint16_t status, struct
bt_gatt_service *services, size_t len, ...);
 typedef void (*bt_gatt_characteristics_callback_t)(uint16_t status,
struct bt_gatt_characteristic *chrcs, ...);

...etc?


>> +bool bt_gatt_read_value(struct bt_att *att, uint16_t value_handle,
>> +                                     bt_gatt_read_callback_t callback,
>> +                                     void *user_data,
>> +                                     bt_gatt_destroy_func_t destroy);
>> +bool bt_gatt_read_long_value(struct bt_att *att,
>> +                                     uint16_t value_handle, uint16_t offset,
>> +                                     bt_gatt_read_callback_t callback,
>> +                                     void *user_data,
>> +                                     bt_gatt_destroy_func_t destroy);
>
> Does this need an explicit function? Wouldn't it make more sense to handle the long reads (and writes for that matter) internally.
>

I think so. I like to keep these procedures more or less inline with
what is defined in the core spec. The distinction between these is
simple enough that the upper layer can correctly determine which one
to use as needed.

Cheers,
Arman
