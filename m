Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE454C43334
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Jul 2022 12:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbiGDMyA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Jul 2022 08:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbiGDMxq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Jul 2022 08:53:46 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D6A12773
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Jul 2022 05:53:09 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id r82so12861927oig.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Jul 2022 05:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZvGPHzqXOjO0+1seQCszr1VbWo5HG6fo0/oOceTIlxI=;
        b=DzYh9WvYkucJEo1Xux7VQItw8IFc5+GEOk3dWV8oaIG8y1h8e/tOO9J1qRSXkQj5n2
         jraaPaLFRdRg67fFcbmK3VbbuH1y/juhUq+F4MrXEr7hirF8zS571i57uzweOod1S8S4
         RPPjsu8uf+9KE2UkxQk7q2ZqszGac9RBvxo7tNO6nxRsKAl+U5pG8mzOoEZ6Fp8X2MZ0
         qyrvqdk9DC21MPEewATS291wS+ekCCIY5DDkl/8FbEH+gjk86XG80sm3xsy3RwP1h5w4
         eT2emv4/4iEIuBlJYAUuWKFqxp1Lu/LFYoCkauctfLpPPIpFTsiXw+f36mzQonhLhxiw
         IlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZvGPHzqXOjO0+1seQCszr1VbWo5HG6fo0/oOceTIlxI=;
        b=1QjkBPylLmrRrKpl/yu1A9awb0+m2Qinw+DQI8wDH0f9a6REG8uWs0Pg3CZ2lvHH8k
         UPEoMif2OZD5l8CdmXQ7R546KtnSzl4WW57ZXuBqZQMAoJbvpHoSjUSe2s3nof9F7tlt
         YoJs89xKvV0FdECqiKMceN0Z9g2AdcGtigFrXlrox5SEPFxcPOSRl5MCbUOHA5pwkxt5
         pTW9QALsQPZrMaCvFD+2d/JhTIQnYbvZDsP9pXu8353D7f5s5RTLhglX569BcdM0VPSD
         cNMWowf0GtK2W64ATi7o+6T8FQe/EuLEZCg1gNnxTBWQAFnYz/PwiH20Sk00aDO4pvuy
         RipA==
X-Gm-Message-State: AJIora/4EcJ1rWZsGtsgNX6jQLshd5fp2wNyusYUCllf2rRM0KQMFJPo
        Pg/H5zAiVERuWY9DbokcOA+oQVZXkHlF3POt7l5Cgq+O2nTGYgZI
X-Google-Smtp-Source: AGRyM1uHniRW1a2E9ScUGtXXGttDuZbOISycUxLl7bqwCgMINEt/GiaEPBtw94Z4fYLR2Ex5XTh4H4eP2InoBIuayBw=
X-Received: by 2002:a05:6808:181c:b0:335:710d:e107 with SMTP id
 bh28-20020a056808181c00b00335710de107mr18804789oib.154.1656939184593; Mon, 04
 Jul 2022 05:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220607104015.2126118-1-poprdi@google.com> <CAPUC6bJbVMPn1FMLYnXg2GUX4ikesMSRjj=oPOOrS5H2DOx_bA@mail.gmail.com>
 <CAPUC6b+xMnk8VDGv_7p9j4GHD75FrxG3hWKpTSF2zHj508=x9A@mail.gmail.com>
 <CANp29Y7gb7cop8p8k-LqR1WoLwOLxi+QGRGLEZrbYW8Tw6_i2w@mail.gmail.com> <CACT4Y+b3LHerJNwcPuUSxWMXRKFAunK83BHEXiwGs53Jves6QQ@mail.gmail.com>
In-Reply-To: <CACT4Y+b3LHerJNwcPuUSxWMXRKFAunK83BHEXiwGs53Jves6QQ@mail.gmail.com>
From:   =?UTF-8?Q?Tam=C3=A1s_Koczka?= <poprdi@google.com>
Date:   Mon, 4 Jul 2022 14:52:53 +0200
Message-ID: <CAPUC6bJNhgM3ydSb+KHVMiY--GWvgHW_NRPYz8K7gAZL9=JrmQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Collect kcov coverage from hci_rx_work
To:     Marcel Holtmann <marcel@holtmann.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Aleksandr Nogikh <nogikh@google.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Nguyen <theflow@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

If you need any clarification about the patch or if you have questions
or if the patch needs to be modified, please feel free to tell me.

Basically the patch should not have any effect on a kernel which is
not compiled with CONFIG_KCOV and we'd like to use the patch to make
the coverage of the hci_rx_work background thread visible to
Syzkaller, because the BT packet parsing / handling logic happens
there and this way Syzkaller will be able to more effectively mutate
the packets used for fuzzing, hopefully reaching new code paths, maybe
discovering and reporting new vulnerabilities before they reach the
mainline.

Thank you,
Tamas


On Thu, Jun 23, 2022 at 11:18 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, 22 Jun 2022 at 12:20, Aleksandr Nogikh <nogikh@google.com> wrote:
> >
> > (Resending the reply I sent to the v1 of the patch. I sent it by
> > mistake with HTML content, so it did not reach lore.)
> >
> > I checked out v5.18.1, applied this patch and fuzzed it with syzkaller
> > for a day. The fuzzer was indeed able to find and report more coverage
> > of the BT subsystem than without the patch.
> >
> > Tested-by: Aleksandr Nogikh <nogikh@google.com>
> >
> >
> > On Tue, Jun 14, 2022 at 3:34 PM Tam=C3=A1s Koczka <poprdi@google.com> w=
rote:
> > >
> > > Hello Marcel,
> > >
> > > I hope this was the change you originally requested, and I did not
> > > misunderstand anything, but if you need any additional modification t=
o
> > > the code or the commit, please feel free to let me know!
> > >
> > > Thank you,
> > > Tamas
> > >
> > > On Tue, Jun 7, 2022 at 1:44 PM Tam=C3=A1s Koczka <poprdi@google.com> =
wrote:
> > > >
> > > > Hello Marcel,
> > > >
> > > > I added some comments into the code about what the kcov_remote call=
s do and
> > > > why they were implemented and I also added some reasoning to the co=
mmit
> > > > message.
> > > >
> > > > I did not mention in the commit but these functions only run if the=
 kernel
> > > > is compiled with CONFIG_KCOV.
> > > >
> > > > Thank you again for reviewing the patch!
> > > >
> > > > --
> > > > Tamas
> > > >
> > > > On Tue, Jun 7, 2022 at 12:40 PM Tamas Koczka <poprdi@google.com> wr=
ote:
> > > > >
> > > > > Annotate hci_rx_work() with kcov_remote_start() and kcov_remote_s=
top()
> > > > > calls, so remote KCOV coverage is collected while processing the =
rx_q
> > > > > queue which is the main incoming Bluetooth packet queue.
> > > > >
> > > > > Coverage is associated with the thread which created the packet s=
kb.
> > > > >
> > > > > The collected extra coverage helps kernel fuzzing efforts in find=
ing
> > > > > vulnerabilities.
> > > > >
> > > > > Signed-off-by: Tamas Koczka <poprdi@google.com>
> > > > > ---
> > > > > Changelog since v1:
> > > > >  - add comment about why kcov_remote functions are called
> > > > >
> > > > > v1: https://lore.kernel.org/all/20220517094532.2729049-1-poprdi@g=
oogle.com/
> > > > >
> > > > >  net/bluetooth/hci_core.c | 10 +++++++++-
> > > > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > > > > index 45c2dd2e1590..0af43844c55a 100644
> > > > > --- a/net/bluetooth/hci_core.c
> > > > > +++ b/net/bluetooth/hci_core.c
> > > > > @@ -29,6 +29,7 @@
> > > > >  #include <linux/rfkill.h>
> > > > >  #include <linux/debugfs.h>
> > > > >  #include <linux/crypto.h>
> > > > > +#include <linux/kcov.h>
> > > > >  #include <linux/property.h>
> > > > >  #include <linux/suspend.h>
> > > > >  #include <linux/wait.h>
> > > > > @@ -3780,7 +3781,14 @@ static void hci_rx_work(struct work_struct=
 *work)
> > > > >
> > > > >         BT_DBG("%s", hdev->name);
> > > > >
> > > > > -       while ((skb =3D skb_dequeue(&hdev->rx_q))) {
> > > > > +       /* The kcov_remote functions used for collecting packet p=
arsing
> > > > > +        * coverage information from this background thread and a=
ssociate
> > > > > +        * the coverage with the syscall's thread which originall=
y injected
> > > > > +        * the packet. This helps fuzzing the kernel.
> > > > > +        */
> > > > > +       for (; (skb =3D skb_dequeue(&hdev->rx_q)); kcov_remote_st=
op()) {
> > > > > +               kcov_remote_start_common(skb_get_kcov_handle(skb)=
);
> > > > > +
> > > > >                 /* Send copy to monitor */
> > > > >                 hci_send_to_monitor(hdev, skb);
>
> Looks good to me.
> Anything else needed to merge this patch?
>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
