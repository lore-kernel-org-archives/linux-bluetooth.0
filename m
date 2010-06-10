Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100610125848.GA28631@botech.co.uk>
References: <20100610125848.GA28631@botech.co.uk>
Date: Thu, 10 Jun 2010 16:48:58 +0300
Message-ID: <AANLkTinlsskks35CHsSlDueAGCi4HeicWjHLUTQcfzYC@mail.gmail.com>
Subject: Re: bug and possible patch for dbus DiscoverServices
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Tim Renouf <tpr.vger@botech.co.uk>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jun 10, 2010 at 3:58 PM, Tim Renouf <tpr.vger@botech.co.uk> wrote:
> Hi Bluetooth people
>
> I am investigating a bug where dbus DiscoverServices incorrectly returns
> an empty array in some circumstances (see below).
>
> Here is my suggested patch, against BlueZ 4.47 (I don't think there are
> any more recent changes in this area):
>
> ====
> diff -ur ../eclair.old/external/bluetooth/bluez/src/device.c external/bluetooth/bluez/src/device.c
> --- ../eclair.old/external/bluetooth/bluez/src/device.c 2009-12-15 13:15:44.000000000 +0000
> +++ external/bluetooth/bluez/src/device.c       2010-06-10 11:31:04.000000000 +0100
> @@ -1380,6 +1380,7 @@
>  {
>        struct browse_req *req = user_data;
>        struct btd_device *device = req->device;
> +       sdp_list_t      *records = 0;
>        DBusMessage *reply;
>
>        if (err < 0) {
> @@ -1389,6 +1390,7 @@
>        }
>
>        update_services(req, recs);
> +       records = req->records;
>
>        if (device->tmp_records && req->records) {
>                sdp_list_free(device->tmp_records,
> @@ -1422,7 +1424,7 @@
>
>        if (dbus_message_is_method_call(req->msg, DEVICE_INTERFACE,
>                                        "DiscoverServices")) {
> -               discover_services_reply(req, err, req->records);
> +               discover_services_reply(req, err, records);
>                goto cleanup;
>        }
>
> ====
>
> The problem seems to arise in this bit of search_cb() at device.c:1395:
>
>    if (device->tmp_records && req->records) {
>        sdp_list_free(device->tmp_records,
>                    (sdp_free_func_t) sdp_record_free);
>        device->tmp_records = req->records;
>        req->records = NULL;
>    }
>
> In the case that device->tmp_records was already set, this zeroes
> req->records and so causes the empty array to be returned via dbus a bit
> lower down in the function.

Good catch, I've seems this sometimes but I was never really able to
reproduce it consistently but this seems definably the source of the
problem.

> I'm not really sure what tmp_records does, and whether it should be
> non-zero at this point. So it could be either
>
> 1. tmp_records could be non-zero, so search_cb should return the results
> even if the above code kicks in and zeroes req->records (that's what my
> patch assumes); or
>
> 2. tmp_records is supposed to be zero there, so there is a bug
> elsewhere. In particular, I have only seen the bug on Android phones,
> not on my PC, and a bit of investigation showed that it is some Android
> specific code (the new dbus method GetServiceAttributeValue; see the
> device.c here:
> http://android.git.kernel.org/?p=platform/external/bluez.git;a=blob;f=src/device.c;h=67a77318ad136c12cad96f0e537f8ceac8ae62f0;hb=refs/heads/eclair-bluez
> line 789) that sets tmp_records and does not clear it again.
>
> Also, the bug does not appear when the device I am trying to discover
> services on is my PC rather than a phone. I suspect the Android
> Bluetooth startup sequence only uses this GetServiceAttributeValue on a
> remote device with some phone-specific service, so the
> device->tmp_records for my PC remains at 0.
>
> I would be grateful for any hints on what tmp_records does, and whether
> my patch is correct or whether I should be looking elsewhere.

I would just rework it a bit to make the tmp_records to always store
the last search, something like the following:

-       if (device->tmp_records && req->records) {
+       if (device->tmp_records)
                sdp_list_free(device->tmp_records,
                                        (sdp_free_func_t) sdp_record_free);
-               device->tmp_records = req->records;
-               req->records = NULL;
-       }
+
+       device->tmp_records = req->records;
+       req->records = NULL;

        if (!req->profiles_added && !req->profiles_removed) {
                DBG("%s: No service update", device->path);
@@ -1522,7 +1522,7 @@ send_reply:

        if (dbus_message_is_method_call(req->msg, DEVICE_INTERFACE,
                                        "DiscoverServices"))
-               discover_services_reply(req, err, req->records);
+               discover_services_reply(req, err, device->tmp_records);
        else if (dbus_message_is_method_call(req->msg, ADAPTER_INTERFACE,
                                                "CreatePairedDevice"))
                create_device_reply(device, req);

What do you think?
The point of tmp_records is to avoid having to access the storage when
the records are still in memory (we just discovered them).

Regards,

-- 
Luiz Augusto von Dentz
Computer Engineer
