Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860B9C636CC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Feb 2023 11:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjBTLgc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Feb 2023 06:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjBTLgb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Feb 2023 06:36:31 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A0D1BF8
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Feb 2023 03:36:29 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id 76so370109iou.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Feb 2023 03:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBTfJ/W6M8PLXz5xHdliFX5VcI66SHxg7uaSSpL/xws=;
        b=bLfOH2UNnSeg+Wx96P8YiTkJGYOJEo71vTBxR9qhDAML+jvxuSko1zx+IAu0c3w8v8
         lKyfqPkzIF3LiXbuPPQQDGIjNC+R6Xj5VukGYf1bCE5o+Hw8hE4bYcxU+jG3A/V7VgMX
         +NcqUsQCvFkQjjHVUi9+6CP+GcOqTc7eOZTN/f8NBQseCLKKr4VA0xpTmFo9Nyc5gjJV
         La03PUb0mMi0t04v2x31khk0lvcM1c4E17vst7OJe6DpCsga2KgfMRSNj2odZnk1UK8d
         o0tLb1h2rlMCB+wJ4oocDAw8ZN+Bl/RozgrvpYLmXc0hIHXfkrN+4ei7O2WRi1eKheHk
         oFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBTfJ/W6M8PLXz5xHdliFX5VcI66SHxg7uaSSpL/xws=;
        b=Ah6Vi+Aqv2YrNbh6lZiSbmkR56pTii4VDlcOsLCuu+UkFblYdOgYhim/VB42oUpzsN
         hI9RHg0g7nkI+jJ24xnhCeocaP80BkoA8t3v13KXFIvOS8tBEpJbYd0/4BBlviluWo/B
         AA5tLwDb/Kn8Y2t3UWkp8f/3q+RGCpjGB3QFuUVLiuX7RmQQELJWGJfhm4rJbdQA2Qfj
         smlVoIXsBm68kUoH8QCJiajn1tcGyeukvE6tA5kSz/g1NBoaincBAETpOYqW8C8nWV/M
         U40hW0w7HNwPbpPAOESiBdb4lroRxo+FHHB6/Lb3Sw5MNYmDtV/2kux0dITP4zk2KceI
         twJQ==
X-Gm-Message-State: AO0yUKUT3JBQDXjfpu7cBEkk8Lc0lI0ZzvBGIlZljF2QUEEaQosalQA8
        +1NqZn0CX81bJydEDXOt0aR5bebyXI6nM5bdrowSY+1mf1c=
X-Google-Smtp-Source: AK7set+bEbrpASztSCtVTYk83VsojC/td+vDJOS0K9urr0syBDDFc3CFj70ku6HpZK+PIxSCnRsXME0tKqxH45K1BeY=
X-Received: by 2002:a6b:6a02:0:b0:734:11db:e655 with SMTP id
 x2-20020a6b6a02000000b0073411dbe655mr2024583iog.45.1676892989017; Mon, 20 Feb
 2023 03:36:29 -0800 (PST)
MIME-Version: 1.0
References: <CADBWZmVixR1u979idTDKr0_Hi6Xaj-B5JKwjHwEJLF+p6=Q=Pw@mail.gmail.com>
 <CAAu3APZwVwP1mataf4aL9z4YUBj0tJRX0uqir3EL61vsw5aQLg@mail.gmail.com>
In-Reply-To: <CAAu3APZwVwP1mataf4aL9z4YUBj0tJRX0uqir3EL61vsw5aQLg@mail.gmail.com>
From:   Neacsu Cristian <neacsu.cristianstefan@gmail.com>
Date:   Mon, 20 Feb 2023 13:36:18 +0200
Message-ID: <CADBWZmU+o-2AJ_d-spRuai8tdOpXdO72mnZZKFn1hTP-w_U1Rw@mail.gmail.com>
Subject: Re: GATT ReadValue in c
To:     Barry Byford <31baz66@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello mr Barry,

I succeeded to find out what was the problem. Actually I needed to
iterate on the list.
This is the working code:

        GVariantBuilder *builder =3D g_variant_builder_new(
G_VARIANT_TYPE("a{sv}") );
        GVariant *options =3D g_variant_new ("a{sv}", builder);
        g_variant_builder_unref (builder);

        GVariant *args =3D g_variant_new("(@a{sv})", options);

        GVariant *result =3D
bluez_adapter_call_method_sync(rx_path.c_str(), "ReadValue",
"org.bluez.GattCharacteristic1", args);
        if (result) {
                GVariant *received_data =3D g_variant_get_child_value(resul=
t, 0);

                GVariantIter i;
                g_variant_iter_init(&i, received_data);
                GVariant* dataByte;
                while (g_variant_iter_next(&i, "@y", &dataByte)) {
                        cout << g_variant_get_byte(dataByte) << endl;
                }
        }

Right now I'm able to send data easily, but still I am not able to read dat=
a...
Question, do you know in gdbus command line if I introspect the path:
/org/bluez/hci1/dev_C7_5E_38_E7_67_25/service000b/char000e
(C7:5E:38:E7:67:25), if it has the UUID
6e400003-b5a3-f393-e0a9-e50e24dcca9e (the regular receive UUID) and I
send the next command:
gdbus call --system --dest org.bluez  --object-path
/org/bluez/hci1/dev_C7_5E_38_E7_67_25/service000b/char000c --method
org.bluez.GattCharacteristic1.ReadValue "{}"
Why is never give me proper results?

If I write with call --system --dest org.bluez  --object-path
/org/bluez/hci1/dev_C7_5E_38_E7_67_25/service000b/char000e --method
org.bluez.GattCharacteristic1.WriteValue "(['test'], {})", the send
service with UUID 6e400002-b5a3-f393-e0a9-e50e24dcca9e, the data will
be sent properly, and if I ReadValue from the send service gdbus call
--system --dest org.bluez  --object-path
/org/bluez/hci1/dev_C7_5E_38_E7_67_25/service000b/char000e --method
org.bluez.GattCharacteristic1.ReadValue "{}", it will echo back what
it sent (string "test").

Am I doing something wrong? Shouldn't I just simply call ReadValue
from the service that has proper receiving UUID, and than that's it?
Do I need to call any NotifyAcquire or so?
Thank you and looking forward for your reply.

Cristian-Stefan

Cristian-Stefan




On Mon, Feb 20, 2023 at 9:14 AM Barry Byford <31baz66@gmail.com> wrote:
>
> Hi Cristian-Stefan,
>
> As I said, I'm not overly familiar with C so I'm not sure what the issue =
is with your code (or even if it is wrong). I can point a couple of areas t=
hat don't look as I would expect but I can't do more than that.
>
> The BlueZ documentation https://git.kernel.org/pub/scm/bluetooth/bluez.gi=
t/tree/doc/gatt-api.txt#n72 says that ReadValue returns array{byte} which i=
s "ay" as a D-Bus signature. I believe that is byte[] as a C type.
>
> You seem to be using "g_variant_get_bytestring" on the result. "bytestrin=
gs" are a special concept in D-Bus as they must always end with a null term=
ination.
>
> To simplify such use glib has helper functions like g_variant_get_bytestr=
ing() that ensures that the array is null terminated (it returns the empty =
string otherwise) and g_variant_new_bytestring() (creates an array of bytes=
 including the terminating 0 from a "C string"). However, these are just a =
helper functions, and not something you'd use for non-bytestring byte array=
s.
> https://developer-old.gnome.org/glib/stable/glib-GVariant.html#g-variant-=
get-bytestring
>
> As you are getting a byte array then you need to do the conversion yourse=
lf.
>
> Hope that helps.
>
> Regards,
> Barry
>
>
>
> On Sun, 19 Feb 2023 at 22:28, Neacsu Cristian <neacsu.cristianstefan@gmai=
l.com> wrote:
>>
>> Hello,
>>
>> I am trying to develop my GATT client using DBUS
>> I have the next code in order to read some data using ReadValue, but
>> i'm not sure that I convert properly the results into string.
>>
>> If I'm using the next gdbus command:
>> gdbus call --system --dest org.bluez  --object-path
>> /org/bluez/hci1/dev_C7_5E_38_E7_67_25/service000b/char000c --method
>> org.bluez.GattCharacteristic1.ReadValue "{}"
>> ([byte 0x48, 0x45, 0x4c, 0x4c, 0x4f, 0x21],) // it means HELLO!
>>
>> If I use my code, is giving me nothing:
>>
>>         GVariantBuilder *builder =3D g_variant_builder_new(
>> G_VARIANT_TYPE("a{sv}") );
>>         GVariant *options =3D g_variant_new ("a{sv}", builder);
>>         g_variant_builder_unref (builder);
>>
>>         GVariant *args =3D g_variant_new("(@a{sv})", options);
>>
>>         GVariant *result =3D
>> bluez_adapter_call_method_sync(tx_path.c_str(), "ReadValue",
>> "org.bluez.GattCharacteristic1", args);
>>         if (result) {
>>                 GVariant *received_data =3D g_variant_get_child_value(re=
sult, 0);
>>                 cout << g_variant_get_bytestring(received_data) << endl;
>>         }
>>
>> tx_path is initialized with
>> /org/bluez/hci1/dev_C7_5E_38_E7_67_25/service000b/char000c
>>
>> Do you have any idea what I'm doing wrong?
>> Thank you in advance
>>
>> Cristian-Stefan
