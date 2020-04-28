Return-Path: <SRS0=u/yl=6M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F47FC83000
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Apr 2020 21:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26D9920731
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Apr 2020 21:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Njnf5muZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgD1VHs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726274AbgD1VHs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Apr 2020 17:07:48 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AD9C03C1AC
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2020 14:07:47 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id e26so35397144otr.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2020 14:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/gUQZIHD+k3WI82+sRa1/EBE1hnpwMzmqhFoAyagTyQ=;
        b=Njnf5muZnVbUTZcIiJIMHuxA622phNteq2XgThGVLHni/JZhY1NL6zqqHSLponPg7t
         UrRxs/d+CfVydSOXJiMPFdwtZ53/aaLHHXT1fQoTgndKXjy3F0mjJy9GLiiPhQUKhs74
         nbH+j7dyuftkfsDs8eZwCrxJ4yc/toOpOO4bH+6vyoEOlA0+4M/kR1j373DrhTiC+IpQ
         ZE1Dqn18hFj2R0m8boSEz5BpbIbwvmWPxeZLpwpvO5feopqGBiV55Jk5i2iVfUnKr692
         zy4oKSdO52eAyC0jqkgRzIV0bsqkH/5R7eLhRi3v5gDUXkHxb+Eia9Sc8aN9SNlmk73j
         BI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/gUQZIHD+k3WI82+sRa1/EBE1hnpwMzmqhFoAyagTyQ=;
        b=Oc0+RhviyHvAt3NeLfSvC5nkZ9K9y+q50Q33KnpaSmuy9Swybh4ibyNkXbD/xSe6GM
         UZElthMUwLhaI4Jc9AlK7alHYYnT0EbWOw9InndikuwpDr2+7fJUoPqv4uuy94+SSx4a
         6O717IfFgyDiXetYCmqM0cGPp4P7CDyvNiMQN0Qd3gfUYNJA6SmeyzrQW4uTiwQ+A/la
         kC7L6GrVGyATJEZ7lUi04pIfaf0vbawW1OeMpfZWbngytoUWq+Me7uodx/h1p9sSfXz4
         RYI2mubBwPHpLs4yT0zGPHwCCpeIw7r8t9kD22k9p7hcCzKnpA0Qyl/rhTHCklxbf1Cr
         vWRw==
X-Gm-Message-State: AGi0PuYCIy7FeiXenSPyXeo5jHHeuPImNsTngye3/nA+X8Y+SOhYXfeN
        OYiyZmR7GtFqTKiMOE1LUJBp293aO4ugcfTAJ+L+ViYW
X-Google-Smtp-Source: APiQypLxr5zHNPw8iifU2qoq5m6QMS3SXolyl284c5N0k2J9D4hfSrm/UgiNoRpluETUY63UQrof5aW3F3KvaVtcwrY=
X-Received: by 2002:a9d:7a98:: with SMTP id l24mr25057712otn.79.1588108066365;
 Tue, 28 Apr 2020 14:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200427150153.17055-1-david@lechnology.com> <CABBYNZKhVUqLortqL60CNtu0MZBdtW+qqdtn6zfacOVKDezYxQ@mail.gmail.com>
 <35f37936-e737-ac35-c538-9447a00d1cbc@lechnology.com> <CABBYNZKYXjKDb77988uFE6hQvW-R2es=Y4rZfNML9zFciOmuRg@mail.gmail.com>
 <685ddf1b-c824-9c45-298f-97b70cbf975f@lechnology.com>
In-Reply-To: <685ddf1b-c824-9c45-298f-97b70cbf975f@lechnology.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 28 Apr 2020 14:07:34 -0700
Message-ID: <CABBYNZJ_oLodrsZAftiaHfcM-CPsHvF4nw+Yzx+TeJPEvcUa+A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] src/gatt-client: always check properties in WriteValue
To:     David Lechner <david@lechnology.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi David,

On Tue, Apr 28, 2020 at 10:19 AM David Lechner <david@lechnology.com> wrote:
>
> On 4/28/20 12:03 PM, Luiz Augusto von Dentz wrote:
> > Hi David,
> >
> > On Tue, Apr 28, 2020 at 7:39 AM David Lechner <david@lechnology.com> wrote:
> >>
> >> On 4/27/20 11:28 AM, Luiz Augusto von Dentz wrote:
> >>> Hi David,
> >>>
> >>> On Mon, Apr 27, 2020 at 8:07 AM David Lechner <david@lechnology.com> wrote:
> >>>>
> >>>> This modifies the GATT client characteristic WriteValue D-Bus method to
> >>>> always check that the characteristic supports the requested type of
> >>>> write by checking for the corresponding property before attempting to
> >>>> write.
> >>>>
> >>>> Before this change, if the "type" option was used and it was set to
> >>>> "reliable" or "request", then BlueZ would attempt the write even if the
> >>>> characteristic does not support that write type. On the other hand, if
> >>>> "type" was set to "command" or was not specified, the method would
> >>>> return a org.bluez.Error.NotSupported error without attempting to write.
> >>>>
> >>>> After this change, the WriteValue method will consistently return
> >>>> org.bluez.Error.NotSupported if the corresponding property flag is not
> >>>> set for all types of writes.
> >>>> ---
> >>>>
> >>>> v2 changes:
> >>>> - remove extra check of test variable not NULL
> >>>> - fix one line over 80 chars
> >>>>
> >>>>    src/gatt-client.c | 8 ++++----
> >>>>    1 file changed, 4 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/src/gatt-client.c b/src/gatt-client.c
> >>>> index a9bfc2802..f80742fbb 100644
> >>>> --- a/src/gatt-client.c
> >>>> +++ b/src/gatt-client.c
> >>>> @@ -1016,8 +1016,8 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
> >>>>            *     - If value is larger than MTU - 3: long-write
> >>>>            *   * "write-without-response" property set -> write command.
> >>>>            */
> >>>> -       if ((!type && (chrc->ext_props & BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE))
> >>>> -                       || (type && !strcasecmp(type, "reliable"))) {
> >>>> +       if ((!type || !strcasecmp(type, "reliable")) && chrc->ext_props &
> >>>> +                               BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE) {
> >>>>                   supported = true;
> >>>>                   chrc->write_op = start_long_write(msg, chrc->value_handle, gatt,
> >>>>                                                   true, value, value_len, offset,
> >>>> @@ -1026,8 +1026,8 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
> >>>>                           return NULL;
> >>>>           }
> >>>>
> >>>> -       if ((!type && chrc->props & BT_GATT_CHRC_PROP_WRITE) ||
> >>>> -                       (type && !strcasecmp(type, "request"))) {
> >>>> +       if ((!type || !strcasecmp(type, "request")) && chrc->props &
> >>>> +                                               BT_GATT_CHRC_PROP_WRITE) {
> >>>>                   uint16_t mtu;
> >>>>
> >>>>                   supported = true;
> >>>> --
> >>>> 2.17.1
> >>>
> >>> As far I can remember this is on purpose so the application can
> >>> overwrite the type if it needs to disabling the checks on the client
> >>> side, though the kernel can still return not supported, so if we want
> >>> to change this it will now not be possible to overwrite it anymore.
> >>>
> >>
> >> If this is the case, does it make sense to make the following change
> >> instead so that write without response can also be forced?
> >>
> >> diff --git a/src/gatt-client.c b/src/gatt-client.c
> >> index f80742fbb..3153f571f 100644
> >> --- a/src/gatt-client.c
> >> +++ b/src/gatt-client.c
> >> @@ -1050,8 +1050,8 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
> >>                           return NULL;
> >>           }
> >>
> >> -       if ((type && strcasecmp(type, "command")) || offset ||
> >> -                       !(chrc->props & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP))
> >> +       if ((type && strcasecmp(type, "command")) || offset || (!type &&
> >> +                       !(chrc->props & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP)))
> >>                   goto fail;
> >>
> >>           supported = true;
> >
> > Yes, that is probably one of the use cases to use the type to force
> > sending a command if the client don't care about the response but the
> > server don't mark write without response as supported, is that what
> > you are after? That sounds like a bug since it appears the intention
> > was to allow commands all along.
> >
>
> I just noticed the inconsistency here while trying to implement
> writeValueWithResponse() and writeValueWithoutResponse() in the Web
> Bluetooth API for the Chromium browser and thought that it should
> probably all be one way or the other.
>
> FWIW, in the particular case I am working with, the device has both
> the WRITE and WRITE_WITHOUT_RESP properties set so I am using "type"
> to force writing without response since write with response would
> be selected otherwise.
>
> I will send a proper patch to fix the write without response case.

Great, that indeed shall be supported since both are allowed
bluetoothd will prefer Write since that gives a response, there is
also some means to mark the D-Bus message don't expect a reply as well
which might be another to solve this if you don't want to use type.

-- 
Luiz Augusto von Dentz
