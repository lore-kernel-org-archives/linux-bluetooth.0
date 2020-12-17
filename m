Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5EEC4361B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Dec 2020 08:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4791C2389B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Dec 2020 08:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgLQIwg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Dec 2020 03:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgLQIwf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Dec 2020 03:52:35 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8673C061794
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Dec 2020 00:51:55 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id d37so723052ybi.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Dec 2020 00:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6Vrns0VVwrd94Z4cDfE+WffnPJsWO9dRUavLWPyn1Y8=;
        b=CPqWRrItQ57gD9tBU9RdTzRY20IB9oWmlof5TGfZqKz60b5Y9aHY2Z3QJqdUJMYreg
         vK8YwNX8Ot4/hkbCGvRaS2X3tlrfPWhEoAE15rIzk2GKtZvyXmbRyDwIuU3SyrClJVKH
         9iTBHYjPwwtdnbtkVF52BnHozm8nVMZqTp0L2VqBnQmqFDokNwtwNNJVcgR38A5qqvtS
         My5rHaP6JylTQNdffhuKCJGBYIXFKSwqTuxZXnd3/lb80MC3wxQEosdLJgcUn0YR1rxQ
         VS5Re18VGUQszrUYpUevqgwFDWSrKew73oObcYjlBExdpnORrPsnOoiO5P2C/UGn194p
         O8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6Vrns0VVwrd94Z4cDfE+WffnPJsWO9dRUavLWPyn1Y8=;
        b=j07jIa9Kzw4UR9CkEGXna0X9XoDjroSBvPWM1qeUP4vSHZauEY6vPwSUTyufA3sPxd
         eWXvgaUGx0W0OWeC9920G1OhzciNyV41RRnJ/abqf+5KnNSED1SKNb4VtJowj/DYs0OQ
         hcAHeQ2IAMpgoqXV4/pRxnn/fbM7FK/LkST9taFu/6QBUAzMYxOhY6agpxWEl8y3aJPQ
         vod8pBE9dxnyZ9LOlA4IBNih5qT4mFyaY+EubHgO7T/q3rVIydDxwo19UoftG9uoAjeb
         OXO89ODEh81qVPrWUSljDskQLwXJlr3TNvBCBfwt0qGXwIPQmHCVVNfpMOCY36+jWTgx
         qV0A==
X-Gm-Message-State: AOAM5338/4TcSnwOlaPNCeVzNhFxCFBrMnPcXzpM9hEs2PbFOsd6PjeQ
        LHoQicWbScI4ngELHlPyBELFHGSbfKi4DoTALD1XFNXF/f8=
X-Google-Smtp-Source: ABdhPJzWgzArCWpXFDY5FYnoVQcpZgfZWg6GqmA6ii6kEUXUm/ekCG6XOsFs+eXYP02hv5s1rKE69WCvcsvF3RUW62s=
X-Received: by 2002:a25:d486:: with SMTP id m128mr55146584ybf.214.1608195114762;
 Thu, 17 Dec 2020 00:51:54 -0800 (PST)
MIME-Version: 1.0
References: <CAO9gXyRLOk75wdTWO_cAu1e=w82H1b_fWB=hLpHcJYcv2MHQDg@mail.gmail.com>
 <BYAPR14MB288775932E88E9B5CDF3A653E6F80@BYAPR14MB2887.namprd14.prod.outlook.com>
In-Reply-To: <BYAPR14MB288775932E88E9B5CDF3A653E6F80@BYAPR14MB2887.namprd14.prod.outlook.com>
From:   C K <choongbeom@gmail.com>
Date:   Thu, 17 Dec 2020 17:51:43 +0900
Message-ID: <CAO9gXyS_9aB+ka4xp=QRA0fQ-utVfakTsnXtBvfwhzDio+UE6Q@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_BlueZ_=E2=80=9CPin_or_Key_missing=E2=80=9D_occurred_even_tho?=
        =?UTF-8?Q?ugh_it_has_already_been_paired?=
To:     Jamie Mccrae <Jamie.Mccrae@lairdconnect.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jamie,
I'm very sorry for late reply. I was busy with other urgent works.

Could you check this log?
Why is "Removing temporary device..." happening?


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D first connection and pairing =
with my android test app
: connect -> bonded -> disconnect from app
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Dec 17 07:35:38  bluetoothd[368]:
../bluez-5.50/src/agent.c:agent_ref() 0xfd1000: ref=3D1
Dec 17 07:35:38  bluetoothd[368]:
../bluez-5.50/src/agent.c:register_agent() agent :1.49
Dec 17 07:35:38  bluetoothd[368]:
../bluez-5.50/src/agent.c:unregister_agent() agent :1.49
Dec 17 07:35:38  bluetoothd[368]:
../bluez-5.50/src/agent.c:agent_disconnect() Agent :1.49 disconnected
Dec 17 07:35:38  bluetoothd[368]:
../bluez-5.50/src/agent.c:agent_destroy() agent :1.49
Dec 17 07:35:38  bluetoothd[368]:
../bluez-5.50/src/agent.c:agent_unref() 0xfd1000: ref=3D0
Dec 17 07:35:38  bluetoothd[368]:
../bluez-5.50/src/agent.c:agent_ref() 0xfd1000: ref=3D1
Dec 17 07:35:38  bluetoothd[368]:
../bluez-5.50/src/agent.c:register_agent() agent :1.49
Dec 17 07:35:38  bluetoothd[368]:
../bluez-5.50/src/agent.c:add_default_agent() Default agent set to
:1.49 /org/bluez/agent
Dec 17 07:35:46  bluetoothd[368]:
../bluez-5.50/src/adapter.c:connected_callback() hci0 device
5C:CB:99:7F:77:02 connected eir_len 0
Dec 17 07:35:47  bluetoothd[368]:
../bluez-5.50/src/adapter.c:user_passkey_notify_callback() hci0
5C:CB:99:7F:77:02
Dec 17 07:35:47  bluetoothd[368]:
../bluez-5.50/src/adapter.c:user_passkey_notify_callback() passkey
859060 entered 0
Dec 17 07:35:47  bluetoothd[368]:
../bluez-5.50/src/device.c:new_auth() Requesting agent authentication
for 5C:CB:99:7F:77:02
Dec 17 07:35:47  bluetoothd[368]:
../bluez-5.50/src/agent.c:agent_ref() 0xfd1000: ref=3D2
Dec 17 07:35:56  bluetoothd[368]:
../bluez-5.50/src/adapter.c:new_irk_callback() hci0 new IRK for
5C:CB:99:7F:77:02 RPA 00:00:00:00:00:00
Dec 17 07:35:56  bluetoothd[368]:
../bluez-5.50/src/adapter.c:new_csrk_callback() hci0 new CSRK for
5C:CB:99:7F:77:02 type 3
Dec 17 07:35:56  bluetoothd[368]:
../bluez-5.50/src/adapter.c:new_csrk_callback() hci0 new CSRK for
5C:CB:99:7F:77:02 type 2
Dec 17 07:35:56  bluetoothd[368]:
../bluez-5.50/src/adapter.c:new_long_term_key_callback() hci0 new LTK
for 5C:CB:99:7F:77:02 type 1 enc_size 16
Dec 17 07:35:56  bluetoothd[368]: ../bluez-5.50/src/device.c:device_set_bon=
ded()
Dec 17 07:35:56  bluetoothd[368]:
../bluez-5.50/src/device.c:device_bonding_complete() bonding (nil)
status 0x00
Dec 17 07:35:56  bluetoothd[368]:
../bluez-5.50/src/agent.c:agent_unref() 0xfd1000: ref=3D1
Dec 17 07:35:56  bluetoothd[368]: ../bluez-5.50/src/adapter.c:resume_discov=
ery()
Dec 17 07:35:56  bluetoothd[368]:
../bluez-5.50/src/adapter.c:new_long_term_key_callback() hci0 new LTK
for 5C:CB:99:7F:77:02 type 1 enc_size 16
Dec 17 07:35:56  bluetoothd[368]: ../bluez-5.50/src/device.c:device_set_bon=
ded()
Dec 17 07:35:56  bluetoothd[368]:
../bluez-5.50/src/device.c:device_bonding_complete() bonding (nil)
status 0x00
Dec 17 07:35:56  bluetoothd[368]: ../bluez-5.50/src/adapter.c:resume_discov=
ery()
Dec 17 07:36:15  bluetoothd[368]:
../bluez-5.50/src/adapter.c:dev_disconnected() Device
5C:CB:99:7F:77:02 disconnected, reason 3
Dec 17 07:36:15  bluetoothd[368]:
../bluez-5.50/src/adapter.c:adapter_remove_connection()
Dec 17 07:36:15  bluetoothd[368]:
../bluez-5.50/plugins/policy.c:disconnect_cb() reason 3
Dec 17 07:36:15  bluetoothd[368]:
../bluez-5.50/src/adapter.c:bonding_attempt_complete() hci0 bdaddr
5C:CB:99:7F:77:02 type 1 status 0xe
Dec 17 07:36:15  bluetoothd[368]:
../bluez-5.50/src/device.c:device_bonding_complete() bonding (nil)
status 0x0e
Dec 17 07:36:15  bluetoothd[368]:
../bluez-5.50/src/device.c:device_bonding_failed() status 14
Dec 17 07:36:15  bluetoothd[368]: ../bluez-5.50/src/adapter.c:resume_discov=
ery()
Dec 17 07:36:36  bluetoothd[368]:
../bluez-5.50/src/agent.c:agent_disconnect() Agent :1.49 disconnected
Dec 17 07:36:36  bluetoothd[368]:
../bluez-5.50/src/agent.c:remove_default_agent() Default agent cleared
Dec 17 07:36:36  bluetoothd[368]:
../bluez-5.50/src/agent.c:agent_destroy() agent :1.49
Dec 17 07:36:36  bluetoothd[368]:
../bluez-5.50/src/agent.c:agent_unref() 0xfd1000: ref=3D0
Dec 17 07:36:37  bluetoothd[368]:
../bluez-5.50/src/agent.c:agent_ref() 0xfd2808: ref=3D1
Dec 17 07:36:37  bluetoothd[368]:
../bluez-5.50/src/agent.c:register_agent() agent :1.51
Dec 17 07:36:37  bluetoothd[368]:
../bluez-5.50/src/agent.c:unregister_agent() agent :1.51
Dec 17 07:36:37  bluetoothd[368]:
../bluez-5.50/src/agent.c:agent_disconnect() Agent :1.51 disconnected
Dec 17 07:36:37  bluetoothd[368]:
../bluez-5.50/src/agent.c:agent_destroy() agent :1.51
Dec 17 07:36:37  bluetoothd[368]:
../bluez-5.50/src/agent.c:agent_unref() 0xfd2808: ref=3D0

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D second connection : this device unp=
aired unintentionally
from the app system as soon as connected
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Dec 17 07:36:37  bluetoothd[368]:
../bluez-5.50/src/agent.c:agent_ref() 0xfd2808: ref=3D1
Dec 17 07:36:37  bluetoothd[368]:
../bluez-5.50/src/agent.c:register_agent() agent :1.51
Dec 17 07:36:37  bluetoothd[368]:
../bluez-5.50/src/agent.c:add_default_agent() Default agent set to
:1.51 /org/bluez/agent
Dec 17 07:36:42  bluetoothd[368]:
../bluez-5.50/src/adapter.c:connected_callback() hci0 device
4D:EE:4F:F1:6F:FD connected eir_len 0
Dec 17 07:36:42  bluetoothd[368]:
../bluez-5.50/src/device.c:device_create() dst 4D:EE:4F:F1:6F:FD
Dec 17 07:36:42  bluetoothd[368]:
../bluez-5.50/src/device.c:device_new() address 4D:EE:4F:F1:6F:FD
Dec 17 07:36:42  bluetoothd[368]:
../bluez-5.50/src/device.c:device_new() Creating device
/org/bluez/hci0/dev_4D_EE_4F_F1_6F_FD
Dec 17 07:36:43  bluetoothd[368]:
../bluez-5.50/src/adapter.c:dev_disconnected() Device
4D:EE:4F:F1:6F:FD disconnected, reason 3
Dec 17 07:36:43  bluetoothd[368]:
../bluez-5.50/src/adapter.c:adapter_remove_connection()
Dec 17 07:36:43  bluetoothd[368]:
../bluez-5.50/src/adapter.c:adapter_remove_connection() Removing
temporary device /org/bluez/hci0/dev_4D_EE_4F_F1_6F_FD
Dec 17 07:36:43  bluetoothd[368]:
../bluez-5.50/src/device.c:device_remove() Removing device
/org/bluez/hci0/dev_4D_EE_4F_F1_6F_FD
Dec 17 07:36:43  bluetoothd[368]:
../bluez-5.50/src/device.c:btd_device_unref() Freeing device
/org/bluez/hci0/dev_4D_EE_4F_F1_6F_FD
Dec 17 07:36:43  bluetoothd[368]:
../bluez-5.50/src/device.c:device_free() 0xff3058
Dec 17 07:36:43  bluetoothd[368]:
../bluez-5.50/plugins/policy.c:disconnect_cb() reason 3
Dec 17 07:36:43  bluetoothd[368]:
../bluez-5.50/src/adapter.c:bonding_attempt_complete() hci0 bdaddr
4D:EE:4F:F1:6F:FD type 2 status 0xe
Dec 17 07:36:43  bluetoothd[368]: ../bluez-5.50/src/adapter.c:resume_discov=
ery()



Thanks,
Calvin

2020=EB=85=84 11=EC=9B=94 27=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 5:43, =
Jamie Mccrae <Jamie.Mccrae@lairdconnect.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
>
> Hi Calvin,
> What type of address is it? If the device has a random resolvable address=
 then this means once the device has paired and exchanged IRK that regardle=
ss of what random resolvable address the device uses, the other device will=
 always know what the device's true address is and will use the correct enc=
ryption keys and details. If the device has a different random non-resolvab=
le address or random static address which changes then you cannot match the=
se against a pairing.
> Thanks,
> Jamie
>
> -----Original Message-----
> From: C K <choongbeom@gmail.com>
> Sent: 27 November 2020 06:46
> To: linux-bluetooth@vger.kernel.org
> Subject: BlueZ =E2=80=9CPin or Key missing=E2=80=9D occurred even though =
it has already been paired
>
> EXTERNAL EMAIL: Be careful with attachments and links.
>
> Hello,
> I have an issue with my bluez device.
> I explained it on stackover flow.
> Help me about this please.
>
> https://stackoverflow.com/questions/65001891/bluez-pin-or-key-missing-occ=
urred-even-though-it-has-already-been-paired
>
>
> Thanks,
> Calvin
> THIS MESSAGE, ANY ATTACHMENT(S), AND THE INFORMATION CONTAINED HEREIN MAY=
 BE PROPRIETARY TO LAIRD CONNECTIVITY, INC. AND/OR ANOTHER PARTY, AND MAY F=
URTHER BE INTENDED TO BE KEPT CONFIDENTIAL. IF YOU ARE NOT THE INTENDED REC=
IPIENT, PLEASE DELETE THE EMAIL AND ANY ATTACHMENTS, AND IMMEDIATELY NOTIFY=
 THE SENDER BY RETURN EMAIL. THIS MESSAGE AND ITS CONTENTS ARE THE PROPERTY=
 OF LAIRD CONNECTIVITY, INC. AND MAY NOT BE REPRODUCED OR USED WITHOUT THE =
EXPRESS WRITTEN CONSENT OF LAIRD CONNECTIVITY, INC.
