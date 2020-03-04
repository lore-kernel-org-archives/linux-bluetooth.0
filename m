Return-Path: <SRS0=QCqs=4V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B384C3F2D1
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Mar 2020 01:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1378C2067C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Mar 2020 01:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kGkj+eD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgCDBL0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Mar 2020 20:11:26 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:39274 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbgCDBL0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Mar 2020 20:11:26 -0500
Received: by mail-vs1-f65.google.com with SMTP id a19so91791vsp.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Mar 2020 17:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/aM4CAj9ICNj/ibOV8Q5gAx6qK4daZIIhsp+e6ZLm3w=;
        b=kGkj+eD7XNvA4VRXbiZINghavk64lXRg36IYCaEPYB5lHbC+S23xZVzZgXiHq48aTW
         SVfcN8gpucy2z5tHE0hzvp8errYj2bDs6LjZygn7Fmg+4Vgshtadse216kk+2DwSn/j1
         r0vOnbX7RRiozbIXM4OsoP52wwuu1GtGPB8jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/aM4CAj9ICNj/ibOV8Q5gAx6qK4daZIIhsp+e6ZLm3w=;
        b=jzW6FZEp2HNhhyeBAzbeIZdBCgg8oq8WentAaw2Gy/T10J4RpoD5vHmhY2qQr3dSAf
         Y9Arf+jsZ6goHWqeeaamElCiS4sk1rq9oWhebmU9sSgGYTm71537V8lQna+wjiRq/s15
         +f0jPHIiNSiZf65WHxfUOVx+pvTq9ZSTii8YZJxNbIKPoybd454ON7DRlmYG8ZuHl54G
         R70qtabBQ/evvvFeNNv5qkmGX58mWqFyjPM5zncpixCE6cDWYZFr4rCdLlrzXgxXd3WF
         5bcj+u1PPkVsNKw2BsVjMq9+VOFoi2kRkH2o/5WU7Zd62UuQDiN21eS6+5JmFvfy8x16
         2byA==
X-Gm-Message-State: ANhLgQ2kT9RwWbhUUn66+YCx2ZNhYlp51ffYLJX54FxY2/M+KjcjwMi7
        t9XVmuXaia2IzJs9ZRVrIMH2n5jpM84SiHgnQ3wUnw==
X-Google-Smtp-Source: ADFU+vvVp81NKQ1iE/DA5zgNfLUZ2yCcBL+wpFPmDmdHGVvQiXoT8bvAPLcMGC/mbouJUTz5y5TxIFEgPkvWF/jpaBg=
X-Received: by 2002:a67:fc8c:: with SMTP id x12mr394289vsp.96.1583284285590;
 Tue, 03 Mar 2020 17:11:25 -0800 (PST)
MIME-Version: 1.0
References: <20200225000036.156250-1-abhishekpandit@chromium.org>
 <20200224160019.RFC.v3.1.I797e2f4cb824299043e771f3ab9cef86ee09f4db@changeid>
 <CANFp7mUehaCSR2W3mXpq2s80YLJVfO2U8D_N+sRzJ2pMZQw1UA@mail.gmail.com> <3532949B-483D-4087-A94B-E9567878EC3E@holtmann.org>
In-Reply-To: <3532949B-483D-4087-A94B-E9567878EC3E@holtmann.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Tue, 3 Mar 2020 17:11:14 -0800
Message-ID: <CANFp7mXEiAYEYNxcuo62uxEaZmotzEG=kygvmQi3Kk-QnctvjA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/5] Bluetooth: Add mgmt op set_wake_capable
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Alain Michaud <alainm@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

Yes, I've sent up a v4. While enabling and testing these changes, I
found a bug (which I had originally implemented but missed during
various merges) where powered down and powering down adapters weren't
working.

I've ran the most recent series through a set of automated tests (on
4.19, 4.14, 4.4 and 3.18 kernels) and they are all passing now.

Thanks
Abhishek

On Mon, Mar 2, 2020 at 2:17 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Abhishek,
>
> > I seem to have forgotten to update the series changes here. In series
> > 3, I added a wakeable property to le_conn_param so that the wakeable
> > list is only used for BR/EDR as requested in the previous revision.
>
> are you sending a v4?
>
> Regards
>
> Marcel
>
