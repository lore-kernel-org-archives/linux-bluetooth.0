Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8142DC433DB
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Feb 2021 18:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43BD864ED2
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Feb 2021 18:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBTS35 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 20 Feb 2021 13:29:57 -0500
Received: from sender4-op-o13.zoho.com ([136.143.188.13]:17366 "EHLO
        sender4-op-o13.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhBTS34 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 20 Feb 2021 13:29:56 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1613845752; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=ZLsQLj54eKD9wyIWUQlb+L1zmdi9mZDHa2oWNYh+Il5YzxIcOsC3RkhAfgZ3cw0SLwjByKoX0+42Kyk29MHj5Ss0ssiQ0HajFif9eIWwsIegjFZewHBMfaggX+frHLDjEGUEq2J3pjFYbcyacEkiEEWXhUO9N0iYQKNpCfspSaQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1613845752; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=rRhQtiWk51jpuy35q3+uzYRQLr7ZHkarY/NyMX8/K+Q=; 
        b=GyjGEyA3IjlQNmuKNTEN0XLu7bIQiEFzn8XAPKyDgvrAOGvAzvgqvnOpXqR5Wb9HVyTPUA4Xbh7T/qf+T/2QxBJqPdMHklgvdJPjptPKbMjpevQk3ZBz8UTiX8P8a7klfnJg9+c/1T23nProkZQFKnXZ0fc/iNANx632kamXMBg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=maves.io;
        spf=pass  smtp.mailfrom=curtis@maves.io;
        dmarc=pass header.from=<curtis@maves.io> header.from=<curtis@maves.io>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1613845752;
        s=dkim; d=maves.io; i=curtis@maves.io;
        h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=rRhQtiWk51jpuy35q3+uzYRQLr7ZHkarY/NyMX8/K+Q=;
        b=JReoVEULD0Z+y5IJZbEwx/ELfz280zEhEJr4xkE0dx1BfiHKTluPKQ4ehAqNBUiU
        EPnhHjlPaVwTNagvb2TRlJZ4UeYfe1OkTDpSzdaZISWRRQ2qQG1ISzLFs7khRs78z62
        KdaTGVMIt7bNIH32dK6Ah2d/HOvfKv0306qd3ETU=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1613845750588639.8066717646923; Sat, 20 Feb 2021 10:29:10 -0800 (PST)
Date:   Sat, 20 Feb 2021 13:29:10 -0500
From:   Curtis Maves <curtis@maves.io>
To:     "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-ID: <177c0b3e32a.c0b69e35170119.443115256308628377@maves.io>
In-Reply-To: <CABBYNZJJiXJJqtRMXKEvpwN-mj=eht9wdTgrK1p_Fo_36gK4Zw@mail.gmail.com>
References: <20210219174946.599144-1-curtis@maves.io> <CABBYNZKakfpzTOdZaoa0tZ5Umqu9MKMmkMfNN51XY5owC_KWwQ@mail.gmail.com>
 <177bd04559f.d1a7c05c116102.319856870975137121@maves.io> <CABBYNZJJiXJJqtRMXKEvpwN-mj=eht9wdTgrK1p_Fo_36gK4Zw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gatt-database: Fix notifying on indicatable attr
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,
---- On Sat, 20 Feb 2021 01:07:57 -0500 Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote ----

 > Hi Curtis, 
 >  
 > On Fri, Feb 19, 2021 at 5:18 PM Curtis Maves <curtis@maves.io> wrote: 
 > > 
 > > Hi Luiz, 
 > > ---- On Fri, 19 Feb 2021 19:55:06 -0500 Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote ---- 
 > > 
 > >  > Hi Curtis, 
 > >  > 
 > >  > On Fri, Feb 19, 2021 at 10:11 AM Curtis <curtis@maves.io> wrote: 
 > >  > > 
 > >  > > When a local GATT characteristic has both the indicate and notify 
 > >  > > properties, notifications will not be send to clients requesting them. 
 > >  > > This change fixes this, allowing for notifications to be sent. 
 > >  > > 
 > >  > > Also simplifies logic about when notifications/indications should 
 > >  > > be sent. 
 > >  > > --- 
 > >  > >  src/gatt-database.c | 15 ++++++--------- 
 > >  > >  1 file changed, 6 insertions(+), 9 deletions(-) 
 > >  > > 
 > >  > > diff --git a/src/gatt-database.c b/src/gatt-database.c 
 > >  > > index d635c3214..bd5864bcd 100644 
 > >  > > --- a/src/gatt-database.c 
 > >  > > +++ b/src/gatt-database.c 
 > >  > > @@ -1344,10 +1344,7 @@ static void send_notification_to_device(void *data, void *user_data) 
 > >  > >         } 
 > >  > > 
 > >  > >         ccc = find_ccc_state(device_state, notify->ccc_handle); 
 > >  > > -       if (!ccc) 
 > >  > > -               return; 
 > >  > > - 
 > >  > > -       if (!ccc->value || (notify->conf && !(ccc->value & 0x0002))) 
 > >  > > +       if (!ccc || !(ccc->value & 0x0003)) 
 > >  > >                 return; 
 > >  > > 
 > >  > >         device = btd_adapter_find_device(notify->database->adapter, 
 > >  > > @@ -1374,7 +1371,7 @@ static void send_notification_to_device(void *data, void *user_data) 
 > >  > >          * TODO: If the device is not connected but bonded, send the 
 > >  > >          * notification/indication when it becomes connected. 
 > >  > >          */ 
 > >  > > -       if (!notify->conf) { 
 > >  > > +       if (!(ccc->value & 0x0002)) { 
 > >  > >                 DBG("GATT server sending notification"); 
 > >  > >                 bt_gatt_server_send_notification(server, 
 > >  > >                                         notify->handle, notify->value, 
 > >  > > @@ -2415,8 +2412,8 @@ static bool sock_io_read(struct io *io, void *user_data) 
 > >  > >                                 gatt_db_attribute_get_handle(chrc->attrib), 
 > >  > >                                 buf, bytes_read, 
 > >  > >                                 gatt_db_attribute_get_handle(chrc->ccc), 
 > >  > > -                               chrc->props & BT_GATT_CHRC_PROP_INDICATE ? 
 > >  > > -                               conf_cb : NULL, chrc->proxy); 
 > >  > > +                               conf_cb, 
 > >  > > +                               chrc->proxy); 
 > >  > 
 > >  > Not why are you changing this code to always set the conf_cb? This 
 > >  > would then always send indication rather then notifications: 
 > >  > 
 > >  > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-database.c#n1387 
 > >  > 
 > >  > We might need to check what value it stored in the ccc state if both 
 > >  > indication and notification is supported. 
 > >  > 
 > >  > > 
 > >  > >         return true; 
 > >  > >  } 
 > >  > > @@ -2725,8 +2722,8 @@ static void property_changed_cb(GDBusProxy *proxy, const char *name, 
 > >  > >                                 gatt_db_attribute_get_handle(chrc->attrib), 
 > >  > >                                 value, len, 
 > >  > >                                 gatt_db_attribute_get_handle(chrc->ccc), 
 > >  > > -                               chrc->props & BT_GATT_CHRC_PROP_INDICATE ? 
 > >  > > -                               conf_cb : NULL, proxy); 
 > >  > > +                               conf_cb, 
 > >  > > +                               proxy); 
 > >  > >  } 
 > >  > > 
 > >  > >  static bool database_add_ccc(struct external_service *service, 
 > >  > > -- 
 > >  > > 2.30.1 
 > >  > > 
 > >  > > 
 > >  > 
 > >  > 
 > >  > -- 
 > >  > Luiz Augusto von Dentz 
 > >  > 
 > > 
 > > This patch changes the if-statement around sending notifications to check that the 
 > > ccc->value is not indicating rather than checking if conf_cb (notify->conf) is null. 
 > > This change makes unnecessary to conditionally pass the conf_cb. It's now simpler to always pass it. 
 >  
 > What Im saying is that we can't do this: 
 >  
 > if (!notify->conf) { 
 > DBG("GATT server sending notification"); 
 >  
 > conf callback will always be set so instead we need to change that to: 
 >  
 > if (ccc->value != 0x02) 
 >  
 >  
 >  
 > > -- 
 > > Curtis Maves 
 >  
 >  
 >  
 > -- 
 > Luiz Augusto von Dentz 
 > 
I agree that we can no longer do the following on line 1377:
 > if (!notify->conf) { 
 > DBG("GATT server sending notification"); 

As you said the ccc value needs to be tested instead. 
This part of the patch  already makes a change similar to what you suggested:
 > >  > > @@ -1374,7 +1371,7 @@ static void send_notification_to_device(void *data, void *user_data) 
 > >  > >          * TODO: If the device is not connected but bonded, send the 
 > >  > >          * notification/indication when it becomes connected. 
 > >  > >          */ 
 > >  > > -       if (!notify->conf) { 
 > >  > > +       if (!(ccc->value & 0x0002)) { 
Is there anywhere else where notify->conf is checked?
I looked around but did not find any on my own.
--
Curtis Maves

