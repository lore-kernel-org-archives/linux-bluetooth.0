Return-Path: <SRS0=AfC+=MN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08350C43143
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Oct 2018 08:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA56C20652
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Oct 2018 08:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBp+RO/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA56C20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbeJAP30 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Oct 2018 11:29:26 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:42280 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbeJAP30 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Oct 2018 11:29:26 -0400
Received: by mail-oi1-f175.google.com with SMTP id w81-v6so8804754oiw.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Oct 2018 01:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=e5/Hy1JIw8vfVgBVRMgMms2nLos2/+eJu8CM1LXVmgk=;
        b=ZBp+RO/CcLiUiSp8fPnqJO4W0hUf0pQQJGePfRvxOcsiEdAW4TZgtrljmYLeCyA2u1
         vOP9kHtAtWTnSw4/OOHx2wYlSE6zkrILtO3aya7lW5CNx8EUuXYqDSMORE5EVir6VlY7
         zleZy/QIIu5ZxyoQ4JubpqDmiY01bkNFrNULgvxyKvgRJRDzkHD2wv0XLjLLhF/A1POr
         2M/Bck//TQT7ZuJwi4ExUcTT1BNV5KLnsvuDZgNV6beX+EbwfLVXYhH20KrIFjmTA+TL
         P1Ff1Sn3vVD5srtOldfgRdCeQFUtikpWr5jWBTDeBSIxA0GyG/y8XH4YG9h9lkljhZLV
         GfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=e5/Hy1JIw8vfVgBVRMgMms2nLos2/+eJu8CM1LXVmgk=;
        b=Uf1afsm8mEAxahfMYirUR93nIcy65m+A7shbn5GPQ6yfCqgd3S2/UCakqFfYPprZwq
         KbU6TkiEA25O/Jj9hevyBRvVev0gQUoH1dDzNicbXkYwy7gljpejcqrn/I8HlWHDaiOx
         ERHaXKEgJ/NVLbPQArHWxoAixCqrLGC//nU3hXs1JVyciHqU98uh0Pian3lttEvmxaMx
         rvJvok12rsa7ieCWuEJKM18aufLGVzvQ1mW4hl7hdOEMl9861g9ia6hwKGLWEKSN5s3Y
         sLm+OoER0f7F2amg9MYvzJQGT1BUYZCiQw/bfby+zwTYHxSofpJGtKi6W5R3b+NQQpRj
         HNzQ==
X-Gm-Message-State: ABuFfojUCtSNsiCqthY7cSibiknYXRClIBn31gtbIRtI77b49O7immhu
        hKMIgQ6gjFCW11kO4OcG8aAs5MBOjjisX3lf7BqISA==
X-Google-Smtp-Source: ACcGV62F71BTc50iKgwt4P+wWjsDy2CmgJ0ETst5DOdhTX+TlQqIi4zylCGUhJvJfiuLEZbw3zeKnImvajNZfxsKDTU=
X-Received: by 2002:aca:f409:: with SMTP id s9-v6mr4865539oih.102.1538383964505;
 Mon, 01 Oct 2018 01:52:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:550:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 01:52:43 -0700 (PDT)
In-Reply-To: <CALvjcs-vHT2XnXVbqVcpFATrXWUopMnHZwGG7aEoDE0Us51rXw@mail.gmail.com>
References: <CAE+ULpAgSuUp-TT-cM5vnBw-bh653KB_WkYP+XViesSn_Hhvpg@mail.gmail.com>
 <CALvjcs-vHT2XnXVbqVcpFATrXWUopMnHZwGG7aEoDE0Us51rXw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 1 Oct 2018 11:52:43 +0300
Message-ID: <CABBYNZ+o+ZW7FnKQ6qFDbUKsGuQjZgMf6_ZdMtOwo4Z0VAWu=w@mail.gmail.com>
Subject: Re: Gatt: Subscriptions are not cleared after disconnection from a
 temporary device
To:     Yunhan Wang <yunhanw@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Sukesh Srikakula <sukeshs@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, Oct 1, 2018 at 10:51 AM, Yunhan Wang <yunhanw@google.com> wrote:
> Hi, Luiz
>
> It seem bluez remove GATT, but does not trigger att layer disconnect
> and the corresponding att_disconnected_cb for private/random addressed
> devices, what is your idea here?

Hmm, so the device is removed locally or it does disconnect? Either
way we should cleanup properly so that is indeed a bug.


> Thanks
> Best wishes
> Yunhan
> On Thu, Sep 20, 2018 at 2:34 PM Sukesh Srikakula <sukeshs@google.com> wrote:
>>
>> Hi Luiz,
>>
>> It seems, you added the functionality to clear subscriptions for a
>> device which is no longer paired with below patch.
>> This patch is working fine for the devices which are using public addresses.
>> But, for private/random addressed devices (which are treated as
>> temporary devices in bluez code), this code is not getting called,
>> leaving the subscription state to persist even after disconnection.
>> This is leading to issues with subsequent connections. Can you please
>> help fix this issue?
>>
>> Relevant log snippet from private/random addressed central
>> disconnecting from peripheral running bluez stack
>>
>> daemon.debug bluetoothd[6284]:
>> src/adapter.c:adapter_remove_connection() Removing temporary device
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93
>> daemon.debug bluetoothd[6284]: src/device.c:device_remove() Removing
>> device /org/bluez/hci0/dev_4A_46_4F_6E_7B_93
>> daemon.debug bluetoothd[6284]: src/service.c:change_state() 0x87fda0:
>> device 4A:46:4F:6E:7B:93 profile gap-profile state changed: connected
>> -> disconnected (-103)
>> daemon.debug bluetoothd[6284]: src/service.c:change_state() 0x87fda0:
>> device 4A:46:4F:6E:7B:93 profile gap-profile state changed:
>> disconnected -> unavailable (0)
>> daemon.debug bluetoothd[6284]: profiles/gap/gas.c:gap_remove() GAP
>> profile remove (4A:46:4F:6E:7B:93)
>> daemon.debug bluetoothd[6284]: src/service.c:btd_service_unref() 0x87fda0: ref=0
>> daemon.debug bluetoothd[6284]: src/service.c:change_state() 0x880390:
>> device 4A:46:4F:6E:7B:93 profile deviceinfo state changed: connected
>> -> disconnected (-103)
>> daemon.debug bluetoothd[6284]: src/service.c:change_state() 0x880390:
>> device 4A:46:4F:6E:7B:93 profile deviceinfo state changed:
>> disconnected -> unavailable (0)
>> daemon.debug bluetoothd[6284]: src/service.c:btd_service_unref() 0x880390: ref=0
>> daemon.debug bluetoothd[6284]: src/device.c:btd_device_unref() Freeing
>> device /org/bluez/hci0/dev_4A_46_4F_6E_7B_93
>> daemon.debug bluetoothd[6284]: src/gatt-client.c:unregister_service()
>> Removing GATT service:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service0006
>> daemon.debug bluetoothd[6284]:
>> src/gatt-client.c:unregister_characteristic() Removing GATT
>> characteristic:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service0006/char0007
>> daemon.debug bluetoothd[6284]:
>> src/gatt-client.c:unregister_descriptor() Removing GATT descriptor:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service0006/char0007/desc0009
>> daemon.debug bluetoothd[6284]: src/gatt-client.c:unregister_service()
>> Removing GATT service:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service000a
>> daemon.debug bluetoothd[6284]:
>> src/gatt-client.c:unregister_characteristic() Removing GATT
>> characteristic:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service000a/char000b
>> daemon.debug bluetoothd[6284]:
>> src/gatt-client.c:unregister_descriptor() Removing GATT descriptor:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service000a/char000b/desc000d
>> daemon.debug bluetoothd[6284]:
>> src/gatt-client.c:unregister_descriptor() Removing GATT descriptor:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service000a/char000b/desc000e
>> daemon.debug bluetoothd[6284]: src/gatt-client.c:unregister_service()
>> Removing GATT service:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service000f
>> daemon.debug bluetoothd[6284]:
>> src/gatt-client.c:unregister_characteristic() Removing GATT
>> characteristic:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service000f/char0010
>> daemon.debug bluetoothd[6284]:
>> src/gatt-client.c:unregister_descriptor() Removing GATT descriptor:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service000f/char0010/desc0012
>> daemon.debug bluetoothd[6284]:
>> src/gatt-client.c:unregister_descriptor() Removing GATT descriptor:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service000f/char0010/desc0013
>> daemon.debug bluetoothd[6284]: src/gatt-client.c:unregister_service()
>> Removing GATT service:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service0014
>> daemon.debug bluetoothd[6284]:
>> src/gatt-client.c:unregister_characteristic() Removing GATT
>> characteristic:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service0014/char0015
>> daemon.debug bluetoothd[6284]:
>> src/gatt-client.c:unregister_descriptor() Removing GATT descriptor:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service0014/char0015/desc0017
>> daemon.debug bluetoothd[6284]: src/gatt-client.c:unregister_service()
>> Removing GATT service:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service0018
>> daemon.debug bluetoothd[6284]:
>> src/gatt-client.c:unregister_characteristic() Removing GATT
>> characteristic:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service0018/char0019
>> daemon.debug bluetoothd[6284]:
>> src/gatt-client.c:unregister_descriptor() Removing GATT descriptor:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service0018/char0019/desc001b
>> daemon.debug bluetoothd[6284]:
>> src/gatt-client.c:unregister_characteristic() Removing GATT
>> characteristic:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service0018/char001c
>> daemon.debug bluetoothd[6284]: src/gatt-client.c:unregister_service()
>> Removing GATT service:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service001e
>> daemon.debug bluetoothd[6284]:
>> src/gatt-client.c:unregister_characteristic() Removing GATT
>> characteristic:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service001e/char001f
>> daemon.debug bluetoothd[6284]:
>> src/gatt-client.c:unregister_characteristic() Removing GATT
>> characteristic:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service001e/char0021
>> daemon.debug bluetoothd[6284]: src/gatt-client.c:unregister_service()
>> Removing GATT service:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service0023
>> daemon.debug bluetoothd[6284]:
>> src/gatt-client.c:unregister_characteristic() Removing GATT
>> characteristic:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service0023/char0024
>> daemon.debug bluetoothd[6284]:
>> src/gatt-client.c:unregister_descriptor() Removing GATT descriptor:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service0023/char0024/desc0026
>> daemon.debug bluetoothd[6284]:
>> src/gatt-client.c:unregister_characteristic() Removing GATT
>> characteristic:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service0023/char0027
>> daemon.debug bluetoothd[6284]:
>> src/gatt-client.c:unregister_descriptor() Removing GATT descriptor:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service0023/char0027/desc0029
>> daemon.debug bluetoothd[6284]:
>> src/gatt-client.c:unregister_characteristic() Removing GATT
>> characteristic:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service0023/char002a
>> daemon.debug bluetoothd[6284]:
>> src/gatt-client.c:unregister_descriptor() Removing GATT descriptor:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service0023/char002a/desc002c
>> daemon.debug bluetoothd[6284]: src/gatt-client.c:unregister_service()
>> Removing GATT service:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service002d
>> daemon.debug bluetoothd[6284]:
>> src/gatt-client.c:unregister_characteristic() Removing GATT
>> characteristic:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service002d/char002e
>> daemon.debug bluetoothd[6284]:
>> src/gatt-client.c:unregister_descriptor() Removing GATT descriptor:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service002d/char002e/desc0030
>> daemon.debug bluetoothd[6284]:
>> src/gatt-client.c:unregister_descriptor() Removing GATT descriptor:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service002d/char002e/desc0031
>> daemon.debug bluetoothd[6284]:
>> src/gatt-client.c:unregister_characteristic() Removing GATT
>> characteristic:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service002d/char0032
>> daemon.debug bluetoothd[6284]:
>> src/gatt-client.c:unregister_descriptor() Removing GATT descriptor:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service002d/char0032/desc0034
>> daemon.debug bluetoothd[6284]:
>> src/gatt-client.c:unregister_descriptor() Removing GATT descriptor:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service002d/char0032/desc0035
>> daemon.debug bluetoothd[6284]:
>> src/gatt-client.c:unregister_characteristic() Removing GATT
>> characteristic:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service002d/char0036
>> daemon.debug bluetoothd[6284]:
>> src/gatt-client.c:unregister_descriptor() Removing GATT descriptor:
>> /org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service002d/char0036/desc0038
>> daemon.debug bluetoothd[6284]: attrib/gattrib.c:g_attrib_unref()
>> 0x875a88: g_attrib_unref=0
>> daemon.debug bluetoothd[6284]: src/device.c:device_free() 0x87c5c8
>> daemon.debug bluetoothd[6284]: plugins/policy.c:disconnect_cb() reason 3
>> daemon.debug bluetoothd[6284]:
>> src/adapter.c:bonding_attempt_complete() hci0 bdaddr 4A:46:4F:6E:7B:93
>> type 2 status 0xe
>> daemon.debug bluetoothd[6284]: src/adapter.c:resume_discovery()
>>
>>
>>
>>
>> Relevant log snippet from public addressed central disconnecting from
>> peripheral running bluez stack
>>
>> daemon.debug bluetoothd[4047]: src/adapter.c:dev_disconnected() Device
>> 98:01:A7:B1:40:2C disconnected, reason 3
>> daemon.debug bluetoothd[4047]: src/adapter.c:adapter_remove_connection()
>> daemon.debug bluetoothd[4047]: plugins/policy.c:disconnect_cb() reason 3
>> daemon.debug bluetoothd[4047]:
>> src/adapter.c:bonding_attempt_complete() hci0 bdaddr 98:01:A7:B1:40:2C
>> type 1 status 0xe
>> daemon.debug bluetoothd[4047]: src/device.c:device_bonding_complete()
>> bonding (nil) status 0x0e
>> daemon.debug bluetoothd[4047]: src/device.c:device_bonding_failed() status 14
>> daemon.debug bluetoothd[4047]: src/adapter.c:resume_discovery()
>> daemon.debug bluetoothd[4047]: src/gatt-database.c:conf_cb() GATT
>> server received confirmation
>> daemon.debug bluetoothd[4047]: src/device.c:att_disconnected_cb()
>> daemon.debug bluetoothd[4047]: src/device.c:att_disconnected_cb()
>> Connection reset by peer (104)
>> daemon.debug bluetoothd[4047]: src/service.c:change_state() 0x9e6978:
>> device 98:01:A7:B1:40:2C profile gap-profile state changed: connected
>> -> disconnecting (0)
>> daemon.debug bluetoothd[4047]: src/service.c:change_state() 0x9e6978:
>> device 98:01:A7:B1:40:2C profile gap-profile state changed:
>> disconnecting -> disconnected (0)
>> daemon.debug bluetoothd[4047]: src/service.c:change_state() 0x9e6d10:
>> device 98:01:A7:B1:40:2C profile deviceinfo state changed: connected
>> -> disconnecting (0)
>> daemon.debug bluetoothd[4047]: src/service.c:change_state() 0x9e6d10:
>> device 98:01:A7:B1:40:2C profile deviceinfo state changed:
>> disconnecting -> disconnected (0)
>> daemon.debug bluetoothd[4047]:
>> src/gatt-client.c:btd_gatt_client_disconnected() Device disconnected.
>> Cleaning up.
>> daemon.debug bluetoothd[4047]: src/device.c:att_disconnected_cb()
>> Automatic connection disabled
>> daemon.debug bluetoothd[4047]: attrib/gattrib.c:g_attrib_unref()
>> 0x9de000: g_attrib_unref=0
>> daemon.debug bluetoothd[4047]: src/gatt-database.c:att_disconnected()
>> daemon.debug bluetoothd[4047]: src/gatt-database.c:clear_ccc_state()
>> daemon.debug bluetoothd[4047]: src/gatt-database.c:clear_ccc_state()
>>
>> Regards,
>> Sukesh.
>>
>> > Begin forwarded message:
>> >
>> > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
>> > Subject: [PATCH BlueZ] gatt: Clear subscriptions for device not paired
>> > Date: October 20, 2017 at 5:21:14 AM PDT
>> > To: linux-bluetooth@vger.kernel.org
>> >
>> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>> >
>> > If the device is no longer valid or is not considered bonded anymore
>> > clear its CCC states before removing otherwise application may continue
>> > to notify when there are no devices listening.
>> > ---
>> > src/gatt-database.c | 22 +++++++++++++++++++++-
>> > 1 file changed, 21 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/src/gatt-database.c b/src/gatt-database.c
>> > index 47304704a..d6d1e4d13 100644
>> > --- a/src/gatt-database.c
>> > +++ b/src/gatt-database.c
>> > @@ -891,6 +891,23 @@ static void conf_cb(void *user_data)
>> > }
>> > }
>> >
>> > +static void clear_ccc_state(void *data, void *user_data)
>> > +{
>> > + struct ccc_state *ccc = data;
>> > + struct btd_gatt_database *db = user_data;
>> > + struct ccc_cb_data *ccc_cb;
>> > +
>> > + if (!ccc->value[0])
>> > + return;
>> > +
>> > + ccc_cb = queue_find(db->ccc_callbacks, ccc_cb_match_handle,
>> > + UINT_TO_PTR(ccc->handle));
>> > + if (!ccc_cb)
>> > + return;
>> > +
>> > + ccc_cb->callback(NULL, 0, ccc_cb->user_data);
>> > +}
>> > +
>> > static void send_notification_to_device(void *data, void *user_data)
>> > {
>> > struct device_state *device_state = data;
>> > @@ -940,8 +957,11 @@ static void send_notification_to_device(void *data,
>> > void *user_data)
>> >
>> > remove:
>> > /* Remove device state if device no longer exists or is not paired */
>> > - if (queue_remove(notify->database->device_states, device_state))
>> > + if (queue_remove(notify->database->device_states, device_state)) {
>> > + queue_foreach(device_state->ccc_states, clear_ccc_state,
>> > + notify->database);
>> > device_state_free(device_state);
>> > + }
>> > }
>> >
>> > static void send_notification_to_devices(struct btd_gatt_database *database,
>> > --
>> > 2.13.6
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
>> > in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >
>> >



-- 
Luiz Augusto von Dentz
