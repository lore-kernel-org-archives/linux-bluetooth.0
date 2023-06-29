Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157CEEB64D7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jun 2023 01:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjF2B7G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jun 2023 21:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjF2B7E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jun 2023 21:59:04 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 28 Jun 2023 18:59:02 PDT
Received: from mx-lax3-3.ucr.edu (mx-lax3-3.ucr.edu [169.235.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEAF2693
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 18:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1688003942; x=1719539942;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc:content-transfer-encoding;
  bh=pe35qtVkGgjfoC1i4JMkatChz6WIyH40TUO3MKRfwUU=;
  b=sh76aNU//FSXh/8Siz++l+feKuI+/ggXfEuIZ7DrQOYzDCAN3lLGo9IJ
   rUc+bWVyUkOY6rzSG428DgRXSYOpy8DRa3Ot/WdxInRHuNVWHTRQszokh
   btR5BIVJXDmbzdWWdJZNkkyegTpCGSWoxQxXVUPA4c/BJEp/PLmqvEpPI
   UqSksnIpB5Xhb+NFNrb6d3s22Ds6+DGgcC+ZahA+AOAhiTPcXvyyX7mMM
   v6tuPAjhP1RQJLV7C2cLALZgR2k90GRir/W9P8ty8YmKZMU73VjcfAFeL
   qUduV1e+h/dspX185VBf9OVJmtq7H5jcVex9zP2fDjhNPg2FcLvWcuILw
   w==;
Received: from mail-wr1-f71.google.com ([209.85.221.71])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2023 18:57:59 -0700
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3127a76c56bso82734f8f.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 18:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1688003878; x=1690595878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pe35qtVkGgjfoC1i4JMkatChz6WIyH40TUO3MKRfwUU=;
        b=VFkawkT4irTE5sIF+gsnj7bJs7eIR08hSU7dK4LdxEsh08HQmbnpeKrOycV34L3fOY
         j6E1gcT79LHbD95tV+xo5fG1a6EqAAExDRJDkPt6t5BNks3SYoM6iL6qy6TwYEK+26zu
         W6wfV0vMe1Yrwog+wtydo9HFVBv9YK5tiZpL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688003878; x=1690595878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pe35qtVkGgjfoC1i4JMkatChz6WIyH40TUO3MKRfwUU=;
        b=Jc4zdzELTBNBJNbN3tEu/pWsgMGlmPCagfwMMeR8Wy5TPiY19GOMXFUaOnh4jUqXwP
         tZbuSjJX2y3V4xpU5tE31xz7JHJduX3IwWRVNPg45XOiBkwvqy/up/T7EExzJtjmVs7H
         zO9BbISrkcJZkwK4Yyu5/izSyQRig6VkCixWq9ryTDfV+gu6fO9/g/4GIUBjnm/V0SqE
         jityVFIvnJQ5K9QqMEOVY6CKhab/g6Zc+Q+pmYCuPlWLJ1/4z8YUk2kjrLRA1L+OgGPZ
         bS2HI3dQ4Yf3d/1mzhW1XVvnWRDENeU2WcIkTyQPm1Sv1s/WJ3kKCyBPGhhKSqqILsGX
         KeRA==
X-Gm-Message-State: ABy/qLYCQKt374oG2RzOrzJmJiH3ubFChjmc5dA4jI3e5sEkA040oy1h
        AgwOgOI19SncPcXe3zI+jEcttBKHdB5JL9UOB9P9D6Eeh8Mkkcch4JIZWR6DEofFLNFPU6qRG9R
        lcXih3zRW/9HEXJ65bm059VgOZB0xoHXumDhwRDI8MP1geQ==
X-Received: by 2002:adf:f2c7:0:b0:314:13da:39a4 with SMTP id d7-20020adff2c7000000b0031413da39a4mr743210wrp.66.1688003878301;
        Wed, 28 Jun 2023 18:57:58 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFOF/6OWGWZTemvPXak6D95jENYjn5TNXI25OqnTNh53Sx8ZHggcEwCmrswHwElG9FHDlCm3+xlThuhf23SAes=
X-Received: by 2002:adf:f2c7:0:b0:314:13da:39a4 with SMTP id
 d7-20020adff2c7000000b0031413da39a4mr743200wrp.66.1688003878052; Wed, 28 Jun
 2023 18:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230628150140.GU21539@linux-l9pv.suse>
In-Reply-To: <20230628150140.GU21539@linux-l9pv.suse>
From:   Yu Hao <yhao016@ucr.edu>
Date:   Wed, 28 Jun 2023 18:57:47 -0700
Message-ID: <CA+UBctDPEvHdkHMwD340=n02rh+jNRJNNQ5LBZNA+Wm4Keh2ow@mail.gmail.com>
Subject: Re: How to reproduce the BUG general protection fault in hci_uart_tty_ioctl?
To:     Weiteng Chen <wchen130@ucr.edu>
Cc:     joeyli <jlee@suse.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Weiteng,

Could you give more info about the bug, e.g., kernel configuration,
qemu arguments.

Thanks.
Yu Hao
Ph.D. student
Department of Computer Science & Engineering
University of California, Riverside

On Wed, Jun 28, 2023 at 8:02=E2=80=AFAM joeyli <jlee@suse.com> wrote:
>
> Hi Yu Hao,
>
> I am looking at your "BUG: general protection fault in hci_uart_tty_ioctl=
":
>
> https://lore.kernel.org/all/CA+UBctC3p49aTgzbVgkSZ2+TQcqq4fPDO7yZitFT5uBP=
DeCO2g@mail.gmail.com/
>
> I am trying the C reproducer in your URL, but it is not success yet:
> https://gist.github.com/ZHYfeng/a3e3ff2bdfea5ed5de5475f0b54d55cb
>
> I am using v6.2 mainline kernel to run the C reproducer.
>
> Could you please provide suggestions for how to reproduce this issue?
> And what is your qemu environment for reproducing issue?
>
> Thanks a lot!
> Joey Lee
