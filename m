Return-Path: <SRS0=cHq6=4H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3F4C34047
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Feb 2020 13:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90652465D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Feb 2020 13:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vKNN3YDe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgBSNxW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Feb 2020 08:53:22 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46792 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgBSNxW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Feb 2020 08:53:22 -0500
Received: by mail-io1-f65.google.com with SMTP id t26so577030ioi.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2020 05:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dWBM6hMtN3OxyWIje0A1AXoVlXn1ORCStBKjXv2qJr0=;
        b=vKNN3YDeyrO1HBGWAczgtuOd6f1qZ/+fQ0rL/ROUm+4iyQ9M/1qjOlnnuTmaT0QdKv
         kV8bc+Z0gxJOOhtbg5BXnm+bAAZUrICeCANbfyUdFnc0l7yQiAgJUasPnsbdN4jtRFIX
         6Jki8PAjd3vMg+H6zutAJ4TQ+GBk7GNjCIVMfMUzRg2xRnOLBW9Vq8HDWSWD5x20ANxN
         O/4nesCScpkni/ZCpHmGBzz+X2l9oeav162+0luAdgnE0B0ytfXDA131hFMKp8gRAOpU
         ejXyy92Snrcu5YyP58c2nIz7ADqZK4+PG7oFFyo+nPRmIgcLYxHZHqQZd0Kdznz+khwo
         U6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dWBM6hMtN3OxyWIje0A1AXoVlXn1ORCStBKjXv2qJr0=;
        b=hZi3tbVSeOicoh5Rtc06t+ZEs86m+CdADnpOMozZCCEUqaGuGehOLwyUW3LafKGBLn
         Sfe6f0Atnx1puqlSRqfUpkRihEbtJpCd7B8lSY2r0Pg92iI2C+9RpkF6tXiLnmqHJoVR
         PKBvP4fg+G2rTNGc13C6dPPTYCRQwrLzeicU5ypLTEZWVWgM9RX9J5r0577T8vyurXGZ
         1520YM/ShGrOvZxv5vDfUylqKpEJJM4GA7vREqb+Ys/HJzd53ZYWJPeOiNuqgrwiNURY
         SB3QsDSo7oaJBM7Cl5HYESmPPnf1dS+Y8lBy2DPfzwyWzlPtc5F/AYhKdbmjjDfixmmm
         cihg==
X-Gm-Message-State: APjAAAURSRa4jlCPVZo90y+/xJAI5IMZc6zLLAzv3cMdTa1qkUTV6ykv
        uKCJ0q7VefmoyZX7g4Db37M4k0n1QqofNeIv2Sk=
X-Google-Smtp-Source: APXvYqwZeaymoO7ArMcN4E3shoZ0gxTiFkrWMo7bXcwTjO4nvfiiMG2S26kzJegXGFnGlKkZFbyLyUUxfJ2ulqhygSk=
X-Received: by 2002:a6b:ec08:: with SMTP id c8mr19928418ioh.257.1582120401701;
 Wed, 19 Feb 2020 05:53:21 -0800 (PST)
MIME-Version: 1.0
References: <20200218123747.3006-1-sathish.narasimman@intel.com>
 <072E9094-BA5F-47CB-9740-B04A6DC5384D@holtmann.org> <CAOVXEJJ9NgkPocUmQS=f2204UEf2sfc8HrSmQ7ZvWYonKunRuQ@mail.gmail.com>
In-Reply-To: <CAOVXEJJ9NgkPocUmQS=f2204UEf2sfc8HrSmQ7ZvWYonKunRuQ@mail.gmail.com>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Wed, 19 Feb 2020 19:23:10 +0530
Message-ID: <CAOVXEJKFgCYSfACM-pqsvZaJF2JWzcWTkyRPw3vbXGZGjhwcyQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix - During le_conn_timeout disable EXT_ADV
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Sathish Narsimman <sathish.narasimman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel

On Tue, Feb 18, 2020 at 8:17 PM Sathish Narasimman <nsathish41@gmail.com> wrote:
>
> Hi Marcel
>
> On Tue, Feb 18, 2020 at 7:40 PM Marcel Holtmann <marcel@holtmann.org> wrote:
> >
> > Hi Sathish,
> >
> > > Disabling LE_LEGACY_ADV when LE_EXT_ADV is enabled causes 'command
> > > disallowed . This patch fixes that issue and disables EXT_ADV if
> > > enabled.
> > >
> > > Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
> > > ---
> > > net/bluetooth/hci_conn.c | 16 +++++++++++++---
> > > 1 file changed, 13 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > > index a582c676e584..a8d8a876363c 100644
> > > --- a/net/bluetooth/hci_conn.c
> > > +++ b/net/bluetooth/hci_conn.c
> > > @@ -481,9 +481,19 @@ static void le_conn_timeout(struct work_struct *work)
> > >        * (which doesn't have a timeout of its own).
> > >        */
> > >       if (conn->role == HCI_ROLE_SLAVE) {
> > > -             u8 enable = 0x00;
> > > -             hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable),
> > > -                          &enable);
> > > +             if (ext_adv_capable(hdev)) {
> > > +                     struct hci_cp_le_set_ext_adv_enable cp;
> > > +
> > > +                     cp.enable = 0x00;
> > > +                     cp.num_of_sets = 0x00;
> > > +
> > > +                     hci_send_cmd(hdev, HCI_OP_LE_SET_EXT_ADV_ENABLE,
> > > +                                  sizeof(cp), &cp);
> > > +             } else {
> > > +                     u8 enable = 0x00;
> > > +                     hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE,
> > > +                                  sizeof(enable), &enable);
> > > +             }
> >
> > hmmm, I wonder if it is better to create a helper function for this.
> >
> > Regards
> >
> > Marcel
> >
>
> let me verify and submit patch with __hci_req_disable_advertising
>
> Regards
> Sathish N

calling __hci_req_disable_advertising is not working. the command is
not getting executed
I hope the below method is fine? where it works

+static void le_disable_advertising(struct hci_dev *hdev)
+{
+       if (ext_adv_capable(hdev)) {
+               struct hci_cp_le_set_ext_adv_enable cp;
+               cp.enable = 0x00;
+               cp.num_of_sets = 0x00;
+
+               hci_send_cmd(hdev, HCI_OP_LE_SET_EXT_ADV_ENABLE, sizeof(cp),
+                            &cp);
+       } else {
+               u8 enable = 0x00;
+               hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE,
+                            sizeof(enable), &enable);
+       }
+
+}

Regards
Sathish N
