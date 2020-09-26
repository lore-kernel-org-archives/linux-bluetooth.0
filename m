Return-Path: <SRS0=G13S=DD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CC9C47420
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Sep 2020 18:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0429420809
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Sep 2020 18:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YNG4b9ji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbgIZSly (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Sep 2020 14:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgIZSly (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Sep 2020 14:41:54 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF81C0613CE
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Sep 2020 11:41:54 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k15so7372817wrn.10
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Sep 2020 11:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I4dYLd41ZGSY4Tt4CiINz+mTj1y2KoBQ8YuZjcUzXC0=;
        b=YNG4b9jiouUrFSwXOrLTI4gXmhjnbStLA0C8NXZERPabMTQQNmOhYeMAZbID1f88f8
         gcF+kY5aR9YeKL7jSdR1ScVcYA67ln8bu/h4PRoOIJAvLEuXESIv7zNQ/5pxgGQVqyO4
         bufwW91somv/REUGJJSPeQKlPPJ2KZRncXKhOSArrOTdAVc0JidcsNFkI6VgNq1dXv2s
         OoJi23s2umuykK9Uhg4ce86Aa5IevUnwMCgVSWWOVUyeVOWYyvscbjvYXJftye+I2e3R
         Qy7mkIQI59ytYugWyKSbZhz2KMNN0IwmCClFZ2oLKnfOAhs4gw0cxFDejxaubJb4gH/Z
         03Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I4dYLd41ZGSY4Tt4CiINz+mTj1y2KoBQ8YuZjcUzXC0=;
        b=SpaEcGtCCBSlQHT1F96zmiGy4M4zkUCW83pPTs6sQGFyURIOzbAFxHitSdjTPlfrV8
         UVK3yE4vGE5iWV8ie0t6t9mMfJtVOx1I7Jn2djCD0l6Iz077y2c4J329qwvpzPLws1c1
         vcVdg4U9gAJCF6pTZ/Efr0RmNDRCiP+kUEKBlX1TnidMB8DaDdx0EBr+PP5fs0czYjsS
         TZR82J8fojbXqiyvLfsx3CkQMpC3r+Iu69iFMjCCObL2gWs+uoPtUPRAZ2U2BAoY3EPS
         ivDxV2qv+96Bl88l7D03jbMRPwepwMi/vaEgo8aTcYEUNaCPv72XOKu93CnS53AQmS8S
         6ciw==
X-Gm-Message-State: AOAM5318FjkQFifPEv53raeMuc7ff0vVIwKipS2kL4mLCTLLObr2XSUW
        TgaGb71Qs1aSGSUHmDYI3p1yZElrW6uP8/7cpMFe3g==
X-Google-Smtp-Source: ABdhPJwQh72QzsgsfDFHEOxaBPVk7aRYfJwq2jeISqkzTIgdALcJGPRbZjkQhO+nb3VD9XY8QrzwiJH12015JEc2UgY=
X-Received: by 2002:adf:8544:: with SMTP id 62mr10536553wrh.262.1601145712421;
 Sat, 26 Sep 2020 11:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200922155548.v3.1.I67a8b8cd4def8166970ca37109db46d731b62bb6@changeid>
 <BC59363A-B32A-4DAA-BAF5-F7FBA01752E6@holtmann.org>
In-Reply-To: <BC59363A-B32A-4DAA-BAF5-F7FBA01752E6@holtmann.org>
From:   Archie Pusaka <apusaka@google.com>
Date:   Sun, 27 Sep 2020 02:41:41 +0800
Message-ID: <CAJQfnxHPDktGp=MQJzY57qmMTO7TPfNZvLHLm7DAyZ-4qM-DnQ@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: Check for encryption key size on connect
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Sat, 26 Sep 2020 at 00:37, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Archie,
>
> > When receiving connection, we only check whether the link has been
> > encrypted, but not the encryption key size of the link.
> >
> > This patch adds check for encryption key size, and reject L2CAP
> > connection which size is below the specified threshold (default 7)
> > with security block.
> >
> > Here is some btmon trace.
> > @ MGMT Event: New Link Key (0x0009) plen 26    {0x0001} [hci0] 5.847722
> >        Store hint: No (0x00)
> >        BR/EDR Address: 38:00:25:F7:F1:B0 (OUI 38-00-25)
> >        Key type: Unauthenticated Combination key from P-192 (0x04)
> >        Link key: 7bf2f68c81305d63a6b0ee2c5a7a34bc
> >        PIN length: 0
> >> HCI Event: Encryption Change (0x08) plen 4        #29 [hci0] 5.871537
> >        Status: Success (0x00)
> >        Handle: 256
> >        Encryption: Enabled with E0 (0x01)
> > < HCI Command: Read Encryp... (0x05|0x0008) plen 2  #30 [hci0] 5.871609
> >        Handle: 256
> >> HCI Event: Command Complete (0x0e) plen 7         #31 [hci0] 5.872524
> >      Read Encryption Key Size (0x05|0x0008) ncmd 1
> >        Status: Success (0x00)
> >        Handle: 256
> >        Key size: 3
> >
> > ////// WITHOUT PATCH //////
> >> ACL Data RX: Handle 256 flags 0x02 dlen 12        #42 [hci0] 5.895023
> >      L2CAP: Connection Request (0x02) ident 3 len 4
> >        PSM: 4097 (0x1001)
> >        Source CID: 64
> > < ACL Data TX: Handle 256 flags 0x00 dlen 16        #43 [hci0] 5.895213
> >      L2CAP: Connection Response (0x03) ident 3 len 8
> >        Destination CID: 64
> >        Source CID: 64
> >        Result: Connection successful (0x0000)
> >        Status: No further information available (0x0000)
> >
> > ////// WITH PATCH //////
> >> ACL Data RX: Handle 256 flags 0x02 dlen 12        #42 [hci0] 4.887024
> >      L2CAP: Connection Request (0x02) ident 3 len 4
> >        PSM: 4097 (0x1001)
> >        Source CID: 64
> > < ACL Data TX: Handle 256 flags 0x00 dlen 16        #43 [hci0] 4.887127
> >      L2CAP: Connection Response (0x03) ident 3 len 8
> >        Destination CID: 0
> >        Source CID: 64
> >        Result: Connection refused - security block (0x0003)
> >        Status: No further information available (0x0000)
> >
> > Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> >
> > ---
> >
> > Changes in v3:
> > * Move the check to hci_conn_check_link_mode()
> >
> > Changes in v2:
> > * Add btmon trace to the commit message
> >
> > net/bluetooth/hci_conn.c | 4 ++++
> > 1 file changed, 4 insertions(+)
> >
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index 9832f8445d43..89085fac797c 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -1348,6 +1348,10 @@ int hci_conn_check_link_mode(struct hci_conn *conn)
> >           !test_bit(HCI_CONN_ENCRYPT, &conn->flags))
> >               return 0;
> >
> > +     if (test_bit(HCI_CONN_ENCRYPT, &conn->flags) &&
> > +         conn->enc_key_size < conn->hdev->min_enc_key_size)
> > +             return 0;
> > +
> >       return 1;
> > }
>
> I am a bit concerned since we had that check and I on purpose moved it. See commit 693cd8ce3f88 for the change where I removed and commit d5bb334a8e17 where I initially added it.
>
> Naively adding the check in that location caused a major regression with Bluetooth 2.0 devices. This makes me a bit reluctant to re-add it here since I restructured the whole change to check the key size a different location.

I have tried this patch (both v2 and v3) to connect with a Bluetooth
2.0 device, it doesn't have any connection problem.
I suppose because in the original patch (d5bb334a8e17), there is no
check for the HCI_CONN_ENCRYPT flag.

>
> Now I have to ask, are you running an upstream kernel with both commits above that address KNOB vulnerability?

Actually no, I haven't heard of KNOB vulnerability before.
This patch is written for qualification purposes, specifically to pass
GAP/SEC/SEM/BI-05-C to BI-08-C.
However, it sounds like it could also prevent some KNOB vulnerability
as a bonus.
>
> Regards
>
> Marcel
>

Thanks,
Archie
