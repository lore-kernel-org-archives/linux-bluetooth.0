Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25RDryQ2h8iNuKnWQuC3qXiOtPriH5wFptTgFjv7ydw9pg@mail.gmail.com>
References: <1406326123-10564-1-git-send-email-armansito@chromium.org>
	<1406326123-10564-2-git-send-email-armansito@chromium.org>
	<30A4ADE6-330B-451B-AF32-A32A6F17F2BF@holtmann.org>
	<CAHrH25RDryQ2h8iNuKnWQuC3qXiOtPriH5wFptTgFjv7ydw9pg@mail.gmail.com>
Date: Fri, 25 Jul 2014 18:07:27 -0700
Message-ID: <CAHrH25S2nhfYAqM03QUBeQsoEKBVc=Ot=Ooy3XtdQ5eK1byPfw@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] shared/gatt: Introduce gatt-helpers.h skeleton.
From: Arman Uguray <armansito@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Arman Uguray <armansito@chromium.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

I gave some thought to the iterator approach (even if we do this in an
upcoming patch set, we might as well continue the discussion here). I
think there is benefit to at least some processing of the PDU, since
the format of its contents vary a lot between the different discovery
procedures (i.e. all primary services, primary services by UUID,
characteristics, and descriptors). This is what I have in mind:

struct bt_gatt_result;
struct bt_gatt_iter;

typedef enum {
        BT_GATT_RESULT_TYPE_SERVICE,
        BT_GATT_RESULT_TYPE_CHARACTERISTIC,
        BT_GATT_RESULT_TYPE_DESCRIPTOR,
} bt_gatt_result_type_t;

bt_gatt_result_type_t bt_gatt_result_get_type(struct bt_gatt_result *result);
void bt_gatt_result_destroy(struct bt_gatt_result *result);

bool bt_gatt_iter_init(struct bt_gatt_iter *iter, struct
bt_gatt_result *result);
bool bt_gatt_iter_next_service(struct bt_gatt_iter *iter,
                                        struct bt_gatt_service **service);
bool bt_gatt_iter_next_characteristic(struct bt_gatt_iter *iter,
                                struct bt_gatt_characteristic **characteristic);
bool bt_gatt_iter_next_descriptor(struct bt_gatt_iter *iter,
                                        struct bt_gatt_descriptor **descriptor);

We keep the initial bt_gatt_service, bt_gatt_characteristic,
bt_gatt_descriptor structures and allow iterating through a linked
list of arrays of these structures. I think the data contained in
those structures are essential and providing anything less isn't very
useful, though we can always add other iterator functions in the
future.

Any thoughts/suggestions?

Cheers,
Arman
