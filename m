Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829FCC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Mar 2021 17:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B07664E04
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Mar 2021 17:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbhCORcS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Mar 2021 13:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbhCORbr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Mar 2021 13:31:47 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E0EC06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Mar 2021 10:31:46 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id j3so18329663edp.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Mar 2021 10:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nqq6J79DXapo9lyac8WtBeFKG3UTSPWojKnujKdSwI4=;
        b=mW7yAhzTwHyMgo9+7NSnpe2WYMPdGhIfXClp0sHopcPMLnPL+ENEOtA9kiAe/1cK+T
         5dQrV08u0y1C/qlro0kCyg6pd8dz7b1OrcYHWL7w5rxVtJLcEglQTXH+1VtIpcIFtoM9
         xuGR/YQ9fvbj0MEjiMa4W6/9xuBBJvkN/yeQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nqq6J79DXapo9lyac8WtBeFKG3UTSPWojKnujKdSwI4=;
        b=mrQr9jUIscCp/yHurX1g1LyzS3N63XlAF8I6yM+UhCPqd9O3zAVWOF5ELR92KM7Vzt
         QIRQu4zogQubp08rRRiHDUKJDW8H39ATC5xj4q1GljqTrjIynYUzMygDOKtv0WlhKYGI
         P4i8K6uCCyc8vxTco4S7Vt6f/I39HOssjMoLm8DtOjukcyALPcWHbA8FCOoFugROyhBN
         Lcmf9JK5+Wvx1tp/1Geb4hFA9GAeKkOVIUNfHkpqPTAE0Hr01lifu+Ystyi7SfYszQac
         CSW6Imk76wRNUU2AEZEPYB2ewlC2dTTSkkbdliYsWEyZIY8k1YLc9rFQZqsdNdqmcMhm
         phgQ==
X-Gm-Message-State: AOAM532GMiLobcHiu+cp0WVd8LpvCMgcd5h07bqeeTNLHmcK78Ni9RQz
        +iZDE/FyzPpMjyAfw09xCE6k4ygcQNd8ew==
X-Google-Smtp-Source: ABdhPJxjt4qkWdx9/2QjyPKXmgVuUiERkYnnOGzdCsax5EC5blPCyqqaUs8fAc25IsnOnpKRfCoA2g==
X-Received: by 2002:aa7:d3ca:: with SMTP id o10mr10179177edr.374.1615829505119;
        Mon, 15 Mar 2021 10:31:45 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id y16sm7785086ejk.43.2021.03.15.10.31.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 10:31:44 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so19946124wmj.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Mar 2021 10:31:44 -0700 (PDT)
X-Received: by 2002:a05:600c:19d1:: with SMTP id u17mr713120wmq.141.1615829503890;
 Mon, 15 Mar 2021 10:31:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210313004435.73331-1-sonnysasaka@chromium.org> <86C70A5F-A214-4CA7-A801-82405C17AC78@holtmann.org>
In-Reply-To: <86C70A5F-A214-4CA7-A801-82405C17AC78@holtmann.org>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Mon, 15 Mar 2021 10:31:32 -0700
X-Gmail-Original-Message-ID: <CAO271mm3N4z674GOvr3t4qBaGKaEWL=x2rMfC0O_XysjF3aCkQ@mail.gmail.com>
Message-ID: <CAO271mm3N4z674GOvr3t4qBaGKaEWL=x2rMfC0O_XysjF3aCkQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Cancel le_scan_restart work when stopping discovery
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

I have just sent a v2 which is rebased on bluetooth-next/master. PTAL. Thanks.


On Sat, Mar 13, 2021 at 3:00 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Sonny,
>
> > Not cancelling it has caused a bug where passive background scanning is
> > disabled out of the blue, preventing BLE keyboards/mice to reconnect.
> > Here is how it happens:
> > After hci_req_stop_discovery, there is still le_scan_restart_work
> > scheduled. Invocation of le_scan_restart_work causes a harmful
> > le_scan_disable_work to be scheduled. This le_scan_disable_work will
> > eventually disable passive scanning when the timer fires.
> >
> > Sample btmon trace:
> >
> > < HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
> >        Type: Passive (0x00)
> >        Interval: 367.500 msec (0x024c)
> >        Window: 37.500 msec (0x003c)
> >        Own address type: Public (0x00)
> >        Filter policy: Accept all advertisement (0x00)
> >> HCI Event: Command Complete (0x0e) plen 4
> >      LE Set Scan Parameters (0x08|0x000b) ncmd 1
> >        Status: Success (0x00)
> > < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
> >        Scanning: Enabled (0x01)
> >        Filter duplicates: Disabled (0x00)
> >> HCI Event: Command Complete (0x0e) plen 4
> >      LE Set Scan Enable (0x08|0x000c) ncmd 2
> >        Status: Success (0x00)
> > ...
> > < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
> >        Scanning: Disabled (0x00)
> >        Filter duplicates: Disabled (0x00)
> >> HCI Event: Command Complete (0x0e) plen 4
> >      LE Set Scan Enable (0x08|0x000c) ncmd 2
> >        Status: Success (0x00)
> > // Background scanning is not working here onwards.
> >
> > Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > Signed-off-by: Sonny Sasaka <sonnysasaka@chromium.org>
> >
> > ---
> > net/bluetooth/hci_request.c | 1 +
> > 1 file changed, 1 insertion(+)
>
> I can apply this cleanly to bluetooth-next tree. Please double-check and rebase if it is still needed.
>
> Regards
>
> Marcel
>
