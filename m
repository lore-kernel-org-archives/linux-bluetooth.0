Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CEFC6377D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 07:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A962761106
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 07:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhGVG0q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 02:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbhGVG0p (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 02:26:45 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FA6C061575
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 00:07:20 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id x192so6870697ybe.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 00:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pCweIOqGQEXbjO8x0ZSXEFX8aT2lPgRjfL8xR9OP/zM=;
        b=OesLZ/jM16d2HdKZM/IvVi05RoBazT+WBGTIas39n0l9vI8r5GRnN2cTJ8thjw3jMi
         JN1kd5Ambw3e3pMhEAUwDA10Zv7YAa0cEsPgb2+KizyapZgLos5OOayYkjC7tOdXkKk8
         oTyKrzySjRnoNWLvodokw+wNaYChSDycfPJa3n3StheA8ZCVMeY7I/ZaJ2ylDlLYRuA1
         X/lfDO3Rd3vhc92zcoCcGWlMCPinHdOO0zQrIIMzSG/qLTCPdfX6Ztc4LPnAzqDJPwTq
         SqxJZ6mLiROU8aA/vOC588JfoqexDBFYmAUpn15P5cJGCClTKGCgVOWi1UyBmk+Q/fGL
         Y+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pCweIOqGQEXbjO8x0ZSXEFX8aT2lPgRjfL8xR9OP/zM=;
        b=EC4b4lJHUTG7emWbE5SfavrZkXwJ2rZkQJ9VPyRGNJl0yqbGhTzDlYnIX6JUetndX8
         iTIHFP06e689mOj0zOKe01hpmiK+e58igbhURAT9uuPq49MgsDNtetIwmhU7vrKpJhvl
         2BQddIbDRcJWJvOJWt/eCtRr5tc0CD2kOJa+WZukh/H7b2e94/FH6T+aHP+a/zKdjm/N
         fFqzwk/dIfupK4a6x7zFBZO7sIUjRsxUfqFrRKLlr+TMI61Io+UqtY2l3UblPIh1iWcs
         1vbBLQp+YZBikn5KimkBD676I8a3IAXMbMBaJPeL/0oTiznno2K7B8eO17jmVRMHvtJX
         3inQ==
X-Gm-Message-State: AOAM5312HEVSB9sVF9djP2No9irDx0LQK8+mT7QsTdYhRuMnZZTPeNS3
        6Pj1PMv/RUPnoo8Lj8ITpyQldbRZgz51//OwPPeybGVF+5D6Mw==
X-Google-Smtp-Source: ABdhPJzpF08C6copgidiUj5olROjSBP+2Li3zgAS47C7eHDb8gi7ec7zrMckBxtgmGE3cAHBdPNV3bmgP3SMd5U/Ync=
X-Received: by 2002:a25:6985:: with SMTP id e127mr53348866ybc.212.1626937639443;
 Thu, 22 Jul 2021 00:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210722021952.18260-1-wangyouwan@uniontech.com>
In-Reply-To: <20210722021952.18260-1-wangyouwan@uniontech.com>
From:   Barry Byford <31baz66@gmail.com>
Date:   Thu, 22 Jul 2021 08:07:08 +0100
Message-ID: <CAAu3APbE1jQSC_zPzXDYQcuMJqoKQ3cbApQt5sJ6M_6ZDWQ4Jg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_bluez=3Afix_btmon_tools_=E2=80=9CAllow_slave=E2=80=9D_?=
        =?UTF-8?Q?to_=22Master_Or_Slave=22_=23431_=5Bhci0=5D_99=2E922927?=
To:     wangyouwan <wangyouwan@uniontech.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, 22 Jul 2021 at 03:23, wangyouwan <wangyouwan@uniontech.com> wrote:
>
>     I want to explain it as=E3=80=80=E2=80=9CMaster Or Slave=E2=80=9D, be=
cause this is explained in the Core_v5.2
>

There is now Core V5.3 which has been updated to use inclusive
language as outlined by Archie in his post:

https://marc.info/?l=3Dlinux-bluetooth&m=3D162195325125419&w=3D2

I think the terms should be Central or Peripheral. Here is the same
extract from the spec in v5.3

8.6.5 Role switch
There are several occasions when a role switch is used:
=E2=80=A2 A role switch is necessary in order to make a paging device a Per=
ipheral
when joining an existing piconet, since by definition the paging device is
initially Central of a piconet involving the pager (Central) and the paged
(Peripheral) device.
=E2=80=A2 A role switch is necessary in order for a Peripheral in an existi=
ng piconet to
set up a new piconet with itself as Central and the original piconet Centra=
l as
Peripheral. If the original piconet had more than one Peripheral, then this
implies a double role for the original piconet Central; it becomes a Periph=
eral
in the new piconet while still maintaining the original piconet as Central.

>     8.6.5 Role switch
>     There are several occasions when a role switch is used:
>     =E2=80=A2 A role switch is necessary in order to make a paging device=
 a slave when
>     joining an existing piconet, since by definition the paging device is=
 initially
>     master of a piconet involving the pager (master) and the paged (slave=
)
>     device.
>     =E2=80=A2 A role switch is necessary in order for a slave in an exist=
ing piconet to set up
>     a new piconet with itself as master and the original piconet master a=
s slave.
>     If the original piconet had more than one slave, then this implies a =
double
>     role for the original piconet master; it becomes a slave
>
> Signed-off-by: wangyouwan <wangyouwan@uniontech.com>
> ---
>  monitor/packet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/monitor/packet.c b/monitor/packet.c
> index 52d22ab21..b73615509 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -4143,7 +4143,7 @@ static void create_conn_cmd(const void *data, uint8=
_t size)
>                 str =3D "Stay master";
>                 break;
>         case 0x01:
> -               str =3D "Allow slave";
> +               str =3D "Master Or Slave";
>                 break;
>         default:
>                 str =3D "Reserved";
> --
> 2.20.1
>
>
>
