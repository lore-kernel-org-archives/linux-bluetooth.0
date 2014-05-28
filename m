Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [RFC BlueZ 1/1] src/shared/gatt: Introduce bt_gatt skeleton.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25RYxG=qgaPc+j4zCwZ==0gpd9-zZqgPvfS9-OUu8tmAog@mail.gmail.com>
Date: Wed, 28 May 2014 10:53:36 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <B445A4D3-3ACB-48C5-90BE-6FFFEE4C6E53@holtmann.org>
References: <1400272636-31555-1-git-send-email-armansito@chromium.org> <1400272636-31555-2-git-send-email-armansito@chromium.org> <75980FDA-BF07-4EC7-A978-B3D41BA39610@holtmann.org> <CAHrH25RYxG=qgaPc+j4zCwZ==0gpd9-zZqgPvfS9-OUu8tmAog@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

>>> +bool bt_gatt_discover_primary_services(struct bt_gatt *gatt, bt_uuid_t *uuid,
>>> +                                     bt_gatt_discovery_callback_t callback,
>>> +                                     void *user_data);
>>> +
>>> +bool bt_gatt_discover_included_services(struct bt_gatt *gatt,
>>> +                                     struct bt_gatt_handle_range range,
>>> +                                     bt_uuid_t *uuid,
>>> +                                     bt_gatt_discovery_callback_t callback,
>>> +                                     void *user_data);
>>> +
>>> +bool bt_gatt_discover_characteristics(struct bt_gatt *gatt,
>>> +                                     struct bt_gatt_handle_range range,
>>> +                                     bt_uuid_t *uuid,
>>> +                                     bt_gatt_discovery_callback_t callback,
>>> +                                     void *user_data);
>>> +
>>> +bool bt_gatt_discover_descriptors(struct bt_gatt *gatt,
>>> +                                     struct bt_gatt_handle_range range,
>>> +                                     bt_gatt_discovery_callback_t callback,
>>> +                                     void *user_data);
>> 
>> Should we really expose these low-level operations? Why not just have one bt_gatt_discover() that does all the magic for us. At the end of the day, that is what most devices do when they connect to a remote device. They will update the services they either know or have to discover new ones.
> 
> I think we should have them. I pretty much see bt_gatt as an interface
> that translates GATT feature procedures to the underlying ATT protocol
> operations. I leave the magic to be the responsibility of the of the
> upper-layer, where we will have a client implementation that brings
> together src/shared/gatt and src/shared/gatt-db. I'm thinking
> something along the lines of a btd_gatt_client for bluetoothd, that
> discovers everything, caches all attributes, and makes them accessible
> to all the profiles/plugins (this is actually what I'm doing initially
> on Chrome OS using GAttrib, since we're against a deadline for
> Chrome). Eventually we could use this to remove the attio callbacks.

so in the long run I want to share as much code of BlueZ for Android with BlueZ upstream code. Meaning that we should just implement the actual procedures we are doing and not having to repeat the magic to make service discovery smart.

> So, to answer your question, I think having these functions at this
> level will be useful, especially for testing when we start writing PTS
> style tests for GATT.

Do you already happen to have a list of PTS test cases that would need special handling?

Regards

Marcel

