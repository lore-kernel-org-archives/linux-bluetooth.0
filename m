Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82A2C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Apr 2022 21:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351169AbiDAVDg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Apr 2022 17:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242899AbiDAVDf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Apr 2022 17:03:35 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D061F6F0E
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Apr 2022 14:01:45 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id g9so7181758ybf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Apr 2022 14:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4e9+m/DSMhBCZyp7NfRKenwAvUXoZrayHyvupX6TC10=;
        b=VQV9X+MoL0EoyBRSTonJz7lcGvZtxRINqpNXoA+NW6p8m8GlEYQX3GpzHDu0HXCa1S
         kNF9v92AX8NjzKCwIhSP2yB2xHQIjEuncw6RdcJs3BguBx3jtFUiD/WPHnUVBL0PFRNq
         gfzZS8kuWuYeTgeK2FPefUwkxaiZektmB1lWLycpXrqgnbnwgtJyyzzoshTJlXJfUDsg
         tI3SQxy4jnxXcbS/YkUz1OsojTNJbhotZQ8IjrMdPWANGPjdwWvLNhD/ITxMhQGpIe7w
         PNhKbSEKcX1x/hrdYVOoqXf6O+GUjehvwJBErdqb3I8Mk82ve5AW6yq7LMKbR0xchpeR
         6Abg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4e9+m/DSMhBCZyp7NfRKenwAvUXoZrayHyvupX6TC10=;
        b=YweeItfnE3jvKSqnmiu36ytrhdI0QFrkoSQxiEbXl68m8WF6WI+VFPV97U7pKEpzXV
         3dmhG8PkLll4Wimg9t3Jwj16nSWMZidGOWGBseGB3mvnSVu2NqlYHyFxT2ujhJA0hYxT
         9uz6aWj2XJs0rrm9OzHGN+fQa/G7kqbcJ4yNAR2QHrCUgcIhPXbQUS4Qh3I6KmKM2MAx
         1jgVd8hqpog7BOqWtZ7JAiiw1fbmhAojFcHlMCI1jUwquKuV+T881dEt+6L2Xl5+0J3G
         9KQC9/f+QOICqoFawo9BFDPjj3x5JUGk8ojC4cFLjASFclMsMrJgbvXyRxkEKfqjFYd2
         q8UA==
X-Gm-Message-State: AOAM53138nqpPyaZZ+DY70tBJ7+zPpEp8mQ2NpOZ1xWF/aJ+F/ieB9G1
        C2s6P79CXvVkJjr4CJ7E7M8fTKbfizyZL+S9Z28n5Pq0Ixc=
X-Google-Smtp-Source: ABdhPJz8RRSrYMWzVQaaUhsOneMdA9ubWd4WLgxmJ0DblVYOiAjOAMcyxHZdIkc0NpttSytfVZrlXusm/Fie8ekFPzc=
X-Received: by 2002:a25:59c3:0:b0:63d:8ccc:37b0 with SMTP id
 n186-20020a2559c3000000b0063d8ccc37b0mr1676101ybb.612.1648846904896; Fri, 01
 Apr 2022 14:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220330182552.2613523-1-luiz.dentz@gmail.com>
 <20220330182552.2613523-2-luiz.dentz@gmail.com> <6AFB6D57-1342-445D-A9CC-C761DB356E16@holtmann.org>
In-Reply-To: <6AFB6D57-1342-445D-A9CC-C761DB356E16@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 1 Apr 2022 14:01:34 -0700
Message-ID: <CABBYNZKtvNxPaBfKfjh_V7j-=1gJGXytz--Qcm4e_pSHzr+2Vg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] Bluetooth: Print broken quirks
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Fri, Apr 1, 2022 at 10:29 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > This prints warnings for controllers setting broken quirks to increase
> > their visibility and warn about broken controllers firmware that
> > probably needs updates to behave properly.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > net/bluetooth/hci_sync.c | 53 +++++++++++++++++++++++++++++++++++++---
> > 1 file changed, 49 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index 8f4c5698913d..e97880d7bdb2 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -3825,6 +3825,54 @@ static int hci_init_sync(struct hci_dev *hdev)
> >       return 0;
> > }
> >
> > +#define HCI_QUIRK_BROKEN(_quirk, _desc) { HCI_QUIRK_BROKEN_##_quirk, _desc }
> > +
> > +static const struct {
> > +     unsigned long quirk;
> > +     const char *desc;
> > +} hci_broken_table[] = {
> > +     HCI_QUIRK_BROKEN(LOCAL_COMMANDS,
> > +                      "HCI Read Local Supported Commands not supported"),
> > +     HCI_QUIRK_BROKEN(STORED_LINK_KEY,
> > +                      "HCI Delete Stored Link Key command is advertised, "
> > +                      "but not supported."),
> > +     HCI_QUIRK_BROKEN(ERR_DATA_REPORTING,
> > +                      "HCI Read Default Erroneous Data Reporting command is "
> > +                      "advertised, but not supported."),
> > +     HCI_QUIRK_BROKEN(READ_TRANSMIT_POWER,
> > +                      "HCI Read Transmit Power Level command is advertised, "
> > +                      "but not supported."),
> > +     HCI_QUIRK_BROKEN(FILTER_CLEAR_ALL,
> > +                      "HCI Set Event Filter command not supported."),
> > +     HCI_QUIRK_BROKEN(ENHANCED_SETUP_SYNC_CONN,
> > +                      "HCI Enhanced Setup Synchronous Connection command is "
> > +                      "advertised, but not supported.")
> > +};
> > +
> > +static int hci_dev_setup_sync(struct hci_dev *hdev)
> > +{
> > +     size_t i;
> > +
> > +     bt_dev_dbg(hdev, "");
> > +
> > +     hci_sock_dev_event(hdev, HCI_DEV_SETUP);
> > +
> > +     if (hdev->setup) {
> > +             int ret;
> > +
> > +             ret = hdev->setup(hdev);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     for (i = 0; i < ARRAY_SIZE(hci_broken_table); i++) {
> > +             if (test_bit(hci_broken_table[i].quirk, &hdev->quirks))
> > +                     bt_dev_warn(hdev, "%s", hci_broken_table[i].desc);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > int hci_dev_open_sync(struct hci_dev *hdev)
> > {
> >       int ret = 0;
> > @@ -3887,10 +3935,7 @@ int hci_dev_open_sync(struct hci_dev *hdev)
> >           test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
> >               bool invalid_bdaddr;
> >
> > -             hci_sock_dev_event(hdev, HCI_DEV_SETUP);
> > -
> > -             if (hdev->setup)
> > -                     ret = hdev->setup(hdev);
> > +             ret = hci_dev_setup_sync(hdev);
>
> just put the code here instead of creating another helper function.

Ive added another function since hci_dev_open_sync is quite big
already and it easier to find out where we call ->setup if it is a
separated function that does perform all the necessary checks and set
HCI_DEV_SETUP, I was actually considering moving the whole block under
the if statement so we avoid this weird goto setup_failed, but perhaps
you want any rewrite to be on its own patch to make it easier to
bisect?

> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz
