Return-Path: <SRS0=YdAw=6E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6964DC55182
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 22:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FFCF21D79
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 22:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6PuOtT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgDTWxu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgDTWxu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Apr 2020 18:53:50 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D695C061A0E
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2020 15:53:50 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id s202so10396658oih.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2020 15:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fVjHHYJ1vId2KvrdWJsFEYl7QgTMuUSpPwB3r8jfRdQ=;
        b=d6PuOtT0OjYP0h177+RYqdTNWmYdqFimtCIHTA3Wy8z47WruPS+ayp322by+LF8u4G
         0Mclu56MbEAvOtx2Lz6HLnxfE5mGbwSayA0DFvf4nEH5hVcRqPHUdQ114V+4mCtmD7Jj
         DVAUhfccjnt0n2zHgQDANbBAEoYdAcY9xOvUGbjSJMvbTHVQjpczaN9ha5KGa5KwLkom
         mlhNnEkMkpEOsw+TUVZWKq15G73E0Jk4pDFpRZ/NfJN8eYJVVTJI/320fPsXhclxmE2a
         KLfXmcNcilJuA7rD8j7QO6OBXjguuUpil0zuh40alselsiGsXNszweoCaILMynaeS6YM
         K7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fVjHHYJ1vId2KvrdWJsFEYl7QgTMuUSpPwB3r8jfRdQ=;
        b=crXDFse179jmvZ8yv0GNWRfeLxSlPxnZip5BaMuGCsIckbQdfSNyj+QFM3Uak6PuV9
         eDTyORN4TBd+p5uOo3yQhayLiYcXR+Qst0DOBXVm/rPSHdqKqpLzn9quZZgSyqza5NpX
         Rd/CIOPgzPP3so3//hUDODlVf9sX9cOknQNACXB1TR1YkbKp0UGSxS1r9p2hRs44FH3E
         qe/JQvMB4+Qhm42Zczc5BbAhxnVb+OHaq4wo//SvE/kxHFQTxZFq+uVmsKIXMOxW445k
         87hlE1oY0Wq4ekgpMLm36KBNpByh+XC8eg5SQMtbSG0XEFdKQIzyMHedOlqMztoEyaXT
         fMGg==
X-Gm-Message-State: AGi0PuYqunILY18Zc6oe9GbcrvoEQTR21nnWkKvvxT/es3uTZC8Rt2uG
        7d9DNoKlP0vh+yR8PZplYhVFxtqycWlJBzsS3wk=
X-Google-Smtp-Source: APiQypIeoF1kC4PSiz/RR/zpLYsYxSoqaX9vuF7iTW8Qqhnc19XtqPbP5uJzp2w3ZXERuN+A+Mj+jPJwSwyqkAZzDWk=
X-Received: by 2002:aca:f584:: with SMTP id t126mr1275141oih.108.1587423229576;
 Mon, 20 Apr 2020 15:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200417200903.BlueZ.v1.1.If9f6be992cbaeaa35423de29da6db28675b35fcc@changeid>
In-Reply-To: <20200417200903.BlueZ.v1.1.If9f6be992cbaeaa35423de29da6db28675b35fcc@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 20 Apr 2020 15:53:38 -0700
Message-ID: <CABBYNZ+tSNta-MjYQh51k8jExcS+vi1TqqA0cWQAxqSHd9GJkw@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1] doc: Describe the new Advertisement Monitor support
To:     Miao-chen Chou <mcchou@chromium.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Michael Sun <michaelfsun@google.com>,
        Yoni Shavit <yshavit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao,

On Fri, Apr 17, 2020 at 8:13 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>
> This describes the following commands.
> - Add Advertisement Patterns Monitor
> - Remove Advertisement Monitor
> - Remove All Advertisement Monitors
> Note that the content of a monitor can differ based on its type. For now we
> introduce only pattern-based monitor, so you may find that unlike commands
> for removing monitor(s), the Add command is tied to a specific type.
>
> Signed-off-by: Miao-chen Chou <mcchou@chromium.org>

For userspace we don't require signed-of-by line.

> ---
>
>  doc/mgmt-api.txt | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 39f23c456..fcd281a35 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -3138,6 +3138,74 @@ Read Security Information Command
>                                 Invalid Index
>
>
> +Add Advertisement Patterns Monitor Command
> +=========================================
> +
> +       Command Code:           0x0049
> +       Controller Index:       <controller id>
> +       Command Parameters:     Pattern_count (1 Octets)
> +                               Pattern1 {
> +                                       AD_Data_Type (1 Octet)
> +                                       Index (1 Octet)

What is this index for, it is not very clear why would we need it here
since we are going to return a index already.

> +                                       Length (1 Octet)
> +                                       Value (variable length)
> +                               }
> +                               Pattern2 { }
> +                               ...
> +       Return Parameters:      Monitor_Index (8 Octets)

I guess we could call this a handle if the is assigned by the
controller not the host stack, also it might be more a good idea to
put some example on how to build the parameter list, etc, to make it
easier to visualize how these parameters are put together.

> +
> +       This command is used to add an advertisement monitor whose filtering
> +       conditions are patterns. The kernel would track the number of registered
> +       monitors to determine whether to perform LE scanning while there is
> +       ongoing LE scanning for other intentions, such as auto-reconnection and
> +       discovery session. If the controller supports Microsoft HCI extension,
> +       the kernel would offload the content filtering to the controller in
> +       order to reduce power consumption; otherwise the kernel ignore the
> +       content of the monitor.
> +
> +       Possible errors:        Failed
> +                               Busy
> +                               Invalid Parameters
> +
> +
> +Remove Advertisement Monitor Command
> +====================================
> +
> +       Command Code:           0x004A
> +       Controller Index:       <controller id>
> +       Command Parameters:     Monitor_Index (8 Octets)
> +       Return Parameters:      Monitor_Index (8 Octets)
> +
> +       This command is used to remove an advertisement monitor. The kernel
> +       would remove the monitor with Monitor_Index and update the LE scanning.
> +       If the controller supports Microsoft HCI extension and the monitor has
> +       been offloaded, the kernel would cancel the offloading; otherwise the
> +       kernel takes no further actions other than removing it from the list.
> +
> +       Possible errors:        Failed
> +                               Busy
> +                               Invalid Index
> +
> +
> +Remove All Advertisement Monitors Command
> +=========================================
> +
> +       Command Code:           0x004B
> +       Controller Index:       <controller id>
> +       Command Parameters:
> +       Return Parameters:      Num_removed_Monitors (2 Octets)
> +                               Monitor_Index[i] (2 Octets)
> +
> +       This command is used to remove all advertisement monitors. The kernel
> +       would remove all monitors and update the LE scanning if needed. If the
> +       controller supports Microsoft HCI extension the monitors have been
> +       offloaded, the kernel would cancel all offloadings; otherwise the kernel
> +       takes no further actions other than removing all monitors from the list.
> +
> +       Possible errors:        Failed
> +                               Busy

I wonder if we could keep this simple and just have a special value
passed to Remove that would be consider remove all e.g.
0x0000000000000000, that way we don't have to allocate yet another
opcode for removing all, though Im not sure how the values are managed
in that namespace so it may not be possible allocate one for use with
remote all logic, the other option would be to have a num_monitors and
then in case none is provided do the remove all, that actually might
be useful since if there are multiple application/monitors we can
remove all monitors from one application without afting the others
leaving remove all logic just for when bluetoothd is restarted which
is basically a cleanup.

> +
>  Command Complete Event
>  ======================
>
> --
> 2.24.1
>


-- 
Luiz Augusto von Dentz
