Return-Path: <SRS0=1iyh=56=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39D7C2BB1D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 06:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93CB520735
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 06:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blsedS6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgDNGtq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Apr 2020 02:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbgDNGtp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Apr 2020 02:49:45 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5A5C0A3BDC
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2020 23:49:43 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id o127so12147551iof.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2020 23:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ScUW+oHrbgi3JWOg1Fgyv4znG7u4C+rqTqGYloCdaHI=;
        b=blsedS6yvApc63DBWz6J9Xlp6Si30n4aUNoRdSDYLfCv4r3mFyf2cetul9zOh72YIh
         wro1yaT64aYaT9gWUwSxS2sZ99ku4squQkjplWHaeED8HrM9Bf1mrYJl8ah+ck81z871
         JpycMkgpyRG+vJqjyI9NtV0Z8R56/pkkS97uOo7jhnOhhQU4KvE/odwieUTkJOPi1EiT
         t6eAeBdnEqh5XWc04S6DDNQ1nr19UoGpYyFe759G/f2EGBDzVL3zesqbrOHfLPb1d2Qf
         phU/8ogc1qGd9jc+CCjOVfhZaQatGZpAobCvpYLEshCubFHrNVT1/DqLHDax+DrFwpng
         PW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ScUW+oHrbgi3JWOg1Fgyv4znG7u4C+rqTqGYloCdaHI=;
        b=pBj0tDIkCQ1kWWXlsow1ZcMl+WHNHg+cEHR4bBhi/so3oU9ZBwl+pmrb8ZMjtIKXRF
         phUe2sWBH1lJWQBx+546bL92FeKuiSj2UTjxUoaExD+zxYqDmMhJkUzxd3pyzb5P+yWY
         SDJ5fWkIWsE77D65js9M8ihoR0j90FQIcgVgV5pKpNwCDZvx8idj6YCFAuym2hc7jk75
         wJa336G4Z6bI/k6+SZFYX11Wn5EET6AbHi83N0tHXXsg4cfeTVkpMpoCE5xNHVNKwJvP
         V7qPEJb+H6hjDQZzhOjRI2vhtiJNskqqNxFqBEO7TYQ/10/xPK1b+a/uk6kC52kinHxu
         /wdw==
X-Gm-Message-State: AGi0PuaFBPmdt0QcObSAVqwTLHMWUcubKyzJQHlwwbVy/L/YYVqHS+MK
        vFtQrWxfAPmSLeLvli30aOSRqUcFRACLbfZWJVUvopTsJBWSlg==
X-Google-Smtp-Source: APiQypJAqEiEdX3RiyRpG0iw+c/QjBg2YUvZXpLMhT8JT8AK40v/+O79ogoHNKA7j6LmFaLXQk/ziDC7XndrxpiT9Po=
X-Received: by 2002:a5d:940d:: with SMTP id v13mr4447311ion.1.1586846982888;
 Mon, 13 Apr 2020 23:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586412226.git.marcel@holtmann.org> <6b6ecbf19559cb16793d7ef3e96c1181a32b4df5.1586412226.git.marcel@holtmann.org>
In-Reply-To: <6b6ecbf19559cb16793d7ef3e96c1181a32b4df5.1586412226.git.marcel@holtmann.org>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Tue, 14 Apr 2020 12:19:32 +0530
Message-ID: <CAOVXEJLTj0=SUyE2HtbR6iDSyiTvJCaj6+AVOAC=StOe_jz5bA@mail.gmail.com>
Subject: Re: [PATCH 3/4] Bluetooth: Enable LE Enhanced Connection Complete event.
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel

On Thu, Apr 9, 2020 at 11:38 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> In case LL Privacy is supported by the controller, it is also a good
> idea to use the LE Enhanced Connection Complete event for getting all
> information about the new connection and its addresses.
>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h | 1 +
>  net/bluetooth/hci_core.c    | 8 ++++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index ff42d05b3e72..1da8cec8e210 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -460,6 +460,7 @@ enum {
>  #define HCI_LE_SLAVE_FEATURES          0x08
>  #define HCI_LE_PING                    0x10
>  #define HCI_LE_DATA_LEN_EXT            0x20
> +#define HCI_LE_LL_PRIVACY              0x40
>  #define HCI_LE_EXT_SCAN_POLICY         0x80
>  #define HCI_LE_PHY_2M                  0x01
>  #define HCI_LE_PHY_CODED               0x08
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 589c4085499c..0d726d59a492 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -638,6 +638,14 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
>                 if (hdev->le_features[0] & HCI_LE_DATA_LEN_EXT)
>                         events[0] |= 0x40;      /* LE Data Length Change */
>
> +               /* If the controller supports LL Privacy feature, enable
> +                * the corresponding event.
> +                */
> +               if (hdev->le_features[0] & HCI_LE_LL_PRIVACY)
> +                       events[1] |= 0x02;      /* LE Enhanced Connection
> +                                                * Complete
> +                                                */
> +
>                 /* If the controller supports Extended Scanner Filter
>                  * Policies, enable the correspondig event.
>                  */
> --
> 2.25.2
>
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/bluetooth/hci_core.c#n717

I see LE Enhanced Connection complete event is enabled here.

Regards
Sathish N
