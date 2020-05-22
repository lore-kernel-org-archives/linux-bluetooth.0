Return-Path: <SRS0=Rzh7=7E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5066FC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 17:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F6BD20756
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 17:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9b0wOwQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730762AbgEVRs5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 May 2020 13:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbgEVRs5 (ORCPT
        <rfc822;Linux-bluetooth@vger.kernel.org>);
        Fri, 22 May 2020 13:48:57 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D945C061A0E
        for <Linux-bluetooth@vger.kernel.org>; Fri, 22 May 2020 10:48:57 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 63so8855872oto.8
        for <Linux-bluetooth@vger.kernel.org>; Fri, 22 May 2020 10:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lEMHMNKawgxn7/xc+Awu+QaXt6f8Yh5it5FLS1n+BVk=;
        b=P9b0wOwQU0biGeDG3np+e7/P5Z1M3akkM38veC7yQ0AhGos5M6fZSJgF6FiaVIwSLp
         3NpaGMyvTBljLerxD82oAoZXmpSTU4uFzF/osdm/ab4AAAdSKbNlEKc7YVQSs+skRhyw
         Iy2d2MW43PjJKQ8X43mQgqrxRR4A79LLUzMV2MMceN3/bpriGU0kXf+qNd8lw2lLgn4g
         TMeQ9Na8O6DF0Bc8wHuvtqaUtxtT7oAR8Pu3Mlv8gGTbSMT0H8SVhsWndvuBQ8wq1dG/
         Z2Od+j+lXIfbY3Kngezq2uDgYviOX5wx95b9ECCq6T4Rw9StEfhDCOWmlwhlJ564F9xc
         in+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lEMHMNKawgxn7/xc+Awu+QaXt6f8Yh5it5FLS1n+BVk=;
        b=QVaOaJ59IZPPImj+LnBY2EAe1yFQyl3bW2vYvZR/ShehQzJ5d8VdFBTjLI0zzaSBzY
         I0MxWBMoQ62Mnf6cuw9Kk3vbTgDjKe74gtkTRouuW5yqwGVXZh0XXa78t5kbPv0bXxgM
         g6I9wGTma6FhDHpENGKSoLWl3v6SYitHf4n8eu5AgGytAFJfY5tZQI0PUmhFSYTSqgeB
         6BUaaK+UpSPaV/P6/0OxSqRy/H5db4G65tqZHdbuin3gUlCJWsfnpZAL3brFNDR0DTSZ
         rucGhuDYbEXyuIeK2aaCu9iOIHxbrxTX1OxZynxYvJ1A+emtd4CU5BQdL+4sppBlDOxs
         k8dQ==
X-Gm-Message-State: AOAM532nR2ErfRNjDoytaBStXfINuf5oU3qXyyaIS9q2xug2qNOxR4Rx
        ulBlLWaV6kn322YAkJkI3xEQG1FsGxEbUDN4M1s=
X-Google-Smtp-Source: ABdhPJxrUhTNMVQGXmGTE2F2xBThp6UXaHOLbamFId092WDsLfb6xCXM6MJE7kCms34LkqmN86rcq9zh4sslb7B1pRQ=
X-Received: by 2002:a05:6830:310c:: with SMTP id b12mr12134171ots.11.1590169736198;
 Fri, 22 May 2020 10:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <MWHPR17MB19671EAD4D74EA7BC5915CA7C5B40@MWHPR17MB1967.namprd17.prod.outlook.com>
In-Reply-To: <MWHPR17MB19671EAD4D74EA7BC5915CA7C5B40@MWHPR17MB1967.namprd17.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 22 May 2020 10:48:44 -0700
Message-ID: <CABBYNZKonvHxnabQsu84rVQEPpou45UgqVUECZ2HoTdd7pWT+A@mail.gmail.com>
Subject: Re: Comments on the ConnectDevice API function
To:     Martin Woolley <mwoolley@bluetooth.com>
Cc:     "Linux-bluetooth@vger.kernel.org" <Linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Martin,

On Fri, May 22, 2020 at 1:25 AM Martin Woolley <mwoolley@bluetooth.com> wro=
te:
>
> Hello
>
> I've recently been working with BlueZ via D-Bus and have a situation whic=
h requires me to be able to connect to a device whose Bluetooth device addr=
ess is known, but without first scanning. This is a link layer state transi=
tion with the specification allows.
>
> BlueZ currently supports this via an API adapter function called ConnectD=
evice, whose status is currently "experimental". From my experience of usin=
g this function, it seems to behave like this:
>
> If the BlueZ instance has not scanned yet, so that the target device is n=
ot known to it, the ConnectDevice call results in scanning taking place and=
 then if the target device is found, it is connected to. Success!
>
> But if scanning has previously been performed, regardless of the state of=
 the actual device (e.g. advertising and ready to accept connections), an e=
xception is thrown with a message whose text value is "Already Exists".
>
> I was wondering if I could influence the design of the API before the Con=
nectDevice experimental status is removed?
>
> I would like to suggest that there should be no need for a special API to=
 connect directly to a device without first scanning. Why burden the applic=
ation developer needing to call it just in case this condition applies, cat=
ching the BlueZ exception ("Already Exists") and responding by then calling=
 the normal Connect API?

I guess the intention was to have the application use the intended API
for devices already present _before_ calling ConnectDevice, so before
entering the address manually the application would enumerate the
existing devices and figure out if that was already present.

> An alternative would be to accommodate this special case (not scanned bef=
ore) in the implementation of the standard device Connect(bdaddr) function =
or if that makes no sense because Device objects must correspond to previou=
sly discovered, physical devices, then at least the adapter ConnectDevice f=
unction could take care of the two possible paths and simplify matters for =
the application developer.

I guess you probably know this but just in case someone look at the
archives it is better that we make some things clearer, while the core
spec allows connecting without scanning D-Bus are intend to be a
higher level API thus why ConnectDevice was not really necessary for a
long time and we just introduced it for qualification purpose or when
there are multiple adapter where one acts as scanner. Also ever since
the introduction of privacy (random addresses) APIs that takes
addresses becomes rather complicated to be used directly, and there
exists ways to scan for a specific address with pattern filtering:
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/adapter-api.txt=
#n122

That said I don't oppose to remove Already Exists error, but we should
be very clear that the use of such API should only be recommended with
users input and does not substitute the likes of Device.Connect.

--=20
Luiz Augusto von Dentz
