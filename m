Return-Path: <SRS0=i/J9=5R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31410C43331
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 20:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0956206E9
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 20:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZUuD+eQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732720AbgDAUEn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Apr 2020 16:04:43 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38326 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732645AbgDAUEn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Apr 2020 16:04:43 -0400
Received: by mail-vs1-f66.google.com with SMTP id x206so766939vsx.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2020 13:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OQn92F6zqAcA7McpSz4ntwmWmKNa+/uVLCLy/g/DK54=;
        b=ZUuD+eQ7THDE7pJ8P/Bb/hlat6+n0WwGhga7I8JkAsJppl8tr1J1avC4pE+Aypwc8K
         damavMlJbZhznAQmHgA9vFE7xCSj6d9ISRGA5QqGNPL9YIPI4aNqGGi+ieT+EAFYXLMu
         iPK4ymYyyy3ROjUT8yWGjTFjuxN/shFBlOhms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OQn92F6zqAcA7McpSz4ntwmWmKNa+/uVLCLy/g/DK54=;
        b=VDjc2UDixSTkan5G/9ydmC+gEbAIGtCTf043TtQCiMICkzurqf/Lvu/2J3bOn7X2RZ
         8qtYqXJLK9PQ9u2yYst9Btk7TCS5t7gWUQXUJq8llIe6ZN1T8j+hDCJklAC+WEF0zwi3
         xqCvIIa9+bOaAAx0haLbRUd5iqjxbVaXTJOCup8h7sMJ4aR7je9WuWEMBxVIaNb7g0jH
         I5d9ESD2ZyJjoeBs92KbtyUsOT8zJsK8rnkFIsREa24107vE8SoVc6ISzo33GvtJfNrd
         WbPzSkeVDQOMZR+dvYir8xHAW9rok8C6qpqze1ygsLfyO+u8is+edIldRYEw99tJMXTl
         0dFQ==
X-Gm-Message-State: AGi0PuZ1pD7SraNRKZz2MhPpCShBIblqrj2kztLL/X5bcG1er/olAxi+
        /C7Y+agnJ89ZPnQKr5p/QnZRIL9zpFssX0kUnNCDrw==
X-Google-Smtp-Source: APiQypLkn/esxTF2Wt7Nd9oaMdFgODziaoS75aQYV8KTK6vOvyvWAbDRYtv/2ondHVN6kkaot5uKJR7qFK+zXUJm5PE=
X-Received: by 2002:a67:d086:: with SMTP id s6mr17796821vsi.93.1585771482307;
 Wed, 01 Apr 2020 13:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200312100754.3445-1-sathish.narasimman@intel.com> <CAOVXEJJK0WgeXvwPM=_7kUxrb7O13E5XcaNDpURC6acwrGgXWg@mail.gmail.com>
In-Reply-To: <CAOVXEJJK0WgeXvwPM=_7kUxrb7O13E5XcaNDpURC6acwrGgXWg@mail.gmail.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Wed, 1 Apr 2020 13:04:32 -0700
Message-ID: <CANFp7mUpEwwKCw6xsGWzRXH7q+ZPBJPJaG8n53UsSFd0yfnSzw@mail.gmail.com>
Subject: Re: [PATCH 0/7] LE LL Priavcy support enabled
To:     Sathish Narasimman <nsathish41@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Sathish Narsimman <sathish.narasimman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Satish,

Looking through the patches in this series, it looks like you are
adding the IRK for all connected devices and I'm not sure that's the
best method.
The resolv list seems to be useful in the same way as the le
whitelist: to filter incoming advertisements for devices we care
about.

Thus, to simplify your design, could we not do the same thing as the
le whitelist:
* Update the resolv list anytime passive/background scan is being enabled
* Only keep entries in the resolv list that are part of the
pend_le_conn or pend_le_report lists

Then, you would only need to update the resolv list in
hci_req_add_le_passive_scan and any IRK changes would just disable
passive scan, remove IRKs if existing and re-enable passive scan
(which would add it back with the new one).

Thanks,
Abhishek

On Wed, Mar 18, 2020 at 1:56 AM Sathish Narasimman <nsathish41@gmail.com> wrote:
>
> Hi
>
> A gentle reminder to review the patches
>
> On Thu, Mar 12, 2020 at 3:36 PM Sathish Narsimman <nsathish41@gmail.com> wrote:
> >
> > With this LE LL Priavcy feature available if BT controller supports
> > LL Privacy when privacy is enabled.
> >
> > The patches are verified in below case.
> > Pairing - where the IRK is added to device Resolving List after
> > identity info & IRK is shared in SMP.
> > Unpair - Delete the resolving entry from the Device resolving list
> > Local IRK change - Whenever there is change in local IRK (privacy) the
> > resolving list entries in the device is updated.
> > Whitelist - filter policies for whitelist is updated based on LL_adress
> > resolution support.
> > Reload Resolving list - device reset/sysmte reboot the Resolving list
> > reloaded in to the device.
> >
> > Sathish Narsimman (7):
> >   Bluetooth: LL Privacy Delete Store Resolving list
> >   Bluetooth: Add device to Resolving List
> >   Bluetooth: Update the Resolving list when Local IRK changed
> >   Bluetooth: LL_PRIVACY re-load resolving list
> >   Bluetooth: LL Privacy Check and Update the Resolving List
> >   Bluetooth: Enable LL Privacy
> >   Bluetooth LL Privacy update White list
> >
> >  include/net/bluetooth/hci.h      |   3 +
> >  include/net/bluetooth/hci_core.h |   7 +
> >  net/bluetooth/hci_conn.c         |  32 ++++
> >  net/bluetooth/hci_core.c         |  20 ++-
> >  net/bluetooth/hci_event.c        |  32 +++-
> >  net/bluetooth/hci_request.c      | 251 ++++++++++++++++++++++++++++++-
> >  net/bluetooth/hci_request.h      |   2 +
> >  net/bluetooth/mgmt.c             |  10 +-
> >  net/bluetooth/smp.c              |  11 ++
> >  9 files changed, 354 insertions(+), 14 deletions(-)
> >
> > --
> > 2.17.1
> >
