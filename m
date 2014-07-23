Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 01/11] shared/gatt: Introduce gatt-helpers.h skeleton.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25TprAhCBBOUJZrwDPpttuxXE=+QMBnKL9WpsR_h3g70QQ@mail.gmail.com>
Date: Wed, 23 Jul 2014 07:39:30 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <C4C119D8-6EEA-405E-A6DE-D88A7F471CD9@holtmann.org>
References: <1405718037-15401-1-git-send-email-armansito@chromium.org> <1405718037-15401-2-git-send-email-armansito@chromium.org> <2774A89A-B2EE-4346-BAD1-DBA0E3014661@holtmann.org> <CAHrH25TprAhCBBOUJZrwDPpttuxXE=+QMBnKL9WpsR_h3g70QQ@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

>>> + * The callbacks below encode the operation status in a 16-bit unsigned integer,
>>> + * where 0-255 are allocated for ATT protocol errors.
>>> + *
>>> + *  - 0x0000: Success
>>> + *  - 0x0001: Invalid handle (ATT protocol error)
>>> + *  - 0x0100: Unknown failure (bluetoothd defined)
>> 
>> do we really need this? I am feeling a bit uneasy about these kind of error splits where we are overloading wire protocol errors with internal errors.
>> 
> 
> I think they are useful. I think it ends up being cleaner than
> returning two separate arguments in callbacks, one for ATT protocol
> errors and one for application-specific errors and we clearly document
> above that the LSB is for ATT protocol errors only.

I am feeling uneasy about doing it this way. Can we try to start with just using a uint8 for the ATT error and see how far that gets us. I have bad experience with overloading values from standards and binary protocols with our own. And I know range wise this is safe (at least at the moment).

>>> +#define BT_GATT_ERROR_UNKNOWN                0x0100
>>> +#define BT_GATT_ERROR_INVALID_RSP    0x0101
>> 
>> Especially with the background of invalid response as listed here, I think the only real result is a disconnect anyway, so we might better introduce a disconnect reason with the disconnect callback. Just an idea.
>> 
> 
> Well with some errors you want to disconnect but not with all errors.
> For example, in the case of verified writes, if the response PDU
> didn't match the blob that we sent, we would report that the
> verification failed in an error like this but this wouldn't warrant a
> disconnect.

Or for that case we have an extra parameter indicating the success or failure of a verified write. It might be better to make it procedure specific instead of generalizing it.

> In general, though, I agree with having a disconnect callback. In this
> case though, I feel that, from a layering perspective, these helpers
> should just return an error in the result callback and have the upper
> layer interpret that as a requirement for disconnect. After all,
> reporting these helper-defined errors in a result callback is not all
> that different from what you're suggesting.
> 
> We can then go and add that exact "disconnect required" callback to
> src/shared/gatt.h when we add it later. I'd like to leave these as
> just GATT procedure helper functions without doing any big state
> keeping here.

We do not have to do it all at once. This is why I think we should start just reporting the ATT errors and see how far that gets us. So we learn which are the cases that will actually need special handling.

For the cases of protocol errors, there is not much point in telling the higher layers about the exact violation. If it happens, you are in trouble. Nothing you do will fix it.

>>> +
>>> +typedef void (*bt_gatt_destroy_func_t)(void *user_data);
>>> +
>>> +typedef void (*bt_gatt_result_callback_t)(uint16_t status, void *user_data);
>>> +typedef void (*bt_gatt_discovery_callback_t)(uint16_t status,
>>> +                                     struct queue *results, void *user_data);
>> 
>> Can we please avoid internal data structures exposed here. I would say this needs to provide its own GATT specific data structure for the result. Most likely an allocated array or pointer array with a dedicated free function.
> 
> Interesting, I was under the impression that struct queue was to be
> used like GSList or other list structures used elsewhere and it was ok
> to use it here since this is all going into src/shared. Are you
> suggesting something like:
> 
> typedef void (*bt_gatt_services_callback_t)(uint16_t status, struct
> bt_gatt_service *services, size_t len, ...);
> typedef void (*bt_gatt_characteristics_callback_t)(uint16_t status,
> struct bt_gatt_characteristic *chrcs, ...);
> 
> ...etc?

Yes. I am suggesting something along these lines. It depends on how much information you need to return. Maybe an array of uint16_t handle is enough in some cases. In others we might need a custom structure.

The background here is that long-term we want to get away from GLib dependencies and move over to using ELL. We are in the process of adding kdbus support to ELL and stabilize it. However that will not happen overnight and the internal data structures in src/shared/ are almost identical to ELL's data structures so that gives us a more easier way to port everything over. The less we expose in unit tested code, the easier this transition will be when it finally comes.

>>> +bool bt_gatt_read_value(struct bt_att *att, uint16_t value_handle,
>>> +                                     bt_gatt_read_callback_t callback,
>>> +                                     void *user_data,
>>> +                                     bt_gatt_destroy_func_t destroy);
>>> +bool bt_gatt_read_long_value(struct bt_att *att,
>>> +                                     uint16_t value_handle, uint16_t offset,
>>> +                                     bt_gatt_read_callback_t callback,
>>> +                                     void *user_data,
>>> +                                     bt_gatt_destroy_func_t destroy);
>> 
>> Does this need an explicit function? Wouldn't it make more sense to handle the long reads (and writes for that matter) internally.
>> 
> 
> I think so. I like to keep these procedures more or less inline with
> what is defined in the core spec. The distinction between these is
> simple enough that the upper layer can correctly determine which one
> to use as needed.

We can do that of course, but for me the questions is always if it gets really used that way. Will any code really make the distinction and care about it. If not, then this is just bloat that makes the higher layers work for something they should not.

Regards

Marcel

