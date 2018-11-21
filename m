Return-Path: <SRS0=IL+U=OA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D4DC43441
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Nov 2018 09:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0AAE2145D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Nov 2018 09:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgSLChOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0AAE2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbeKUTuD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Nov 2018 14:50:03 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36498 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeKUTuD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Nov 2018 14:50:03 -0500
Received: by mail-oi1-f193.google.com with SMTP id x23so3957987oix.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Nov 2018 01:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=9NonInrmMeQUZt9BxikKVXLOn61UaS8cGj6eIKTd3RQ=;
        b=lgSLChOzoz+tZ/epWvAEEgjzgIk2do+4uJTvz8CAR01ByOSya5cGcEAbDH9TsQMQ4e
         SZ7OiGe37AZtYNPoWhJvgm48apoctICYN5LbXCVoE+RUujE2MpuBhFHkw/aCALB63qjf
         XN64wxHmaBHwfbxHtOp+BBjCsMYdE1LZKTcXpoSEmVdHZImnJMpFQOyupoDCpq9rb0Td
         dYgujfFX1VX4vFnICIyH9DDcI2WyF/TvuNOldSWnOxdLNOiZbQz5qHJsebbkG2StoaGO
         bVapuZ9J62PEFTF8FTJ6wd9ITSRUNBD5x4Yf8Qn9U2mq8Jvvcmjhb91ojh+V+p3TGYn6
         +VIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=9NonInrmMeQUZt9BxikKVXLOn61UaS8cGj6eIKTd3RQ=;
        b=d/n2q7QxPQssuymI6vhQroupq3K8Qh2FnqvuDXlok8uSfGE/ztfKjUKsULiOmkXcUz
         JKJXza4seOVgyl+Rtp71urBWz3MU8vanndnjVK7hQKNq2WzTu1ZSbVHoLhfS1Qf29a6H
         XUWKIhBJxkb33sgpDP1DAbpPctznniuGCPPyBrftW91qhLe5wH3KdB86XHhU+O6KTQRc
         iVFZfgh1KHcnw3RukHqwht0eafgbneFNHQuJv8O+baeAk0ruZOo57Extc3pnH6u0V5/f
         c/MjMd8BqJrmqwJ5jN/8Sx4s7ZkoCQ5lzuvhEXYkfaeSlR4z9V18K8Ozf7cy6z2Ib8Rr
         oXSw==
X-Gm-Message-State: AGRZ1gKSdt2Tu9FxaRlRxN4414bHc36C3VhgPaB9GliRWu5rYpCCUKD0
        qZSF1FgQOzS94DxgQA658b9idWdS3Oww0yCn2ymRAA==
X-Google-Smtp-Source: AJdET5cTDWKoIzDpPGDYOb3xBSfltomiMBIBdbeEnPwyLg+NKxFBiZBEnQq61aLOMhW/rkcBM0vchwDXg7RQHxjbJtU=
X-Received: by 2002:a05:6808:97:: with SMTP id s23mr2949824oic.251.1542791780816;
 Wed, 21 Nov 2018 01:16:20 -0800 (PST)
MIME-Version: 1.0
References: <20181120135821.18082-1-luiz.dentz@gmail.com>
In-Reply-To: <20181120135821.18082-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 21 Nov 2018 11:16:09 +0200
Message-ID: <CABBYNZ+WF_ea7TMqcd+gDO+x3EpWuRWVW3EwfgK-vDBL3Ygt8A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] shared/log: Add common code to interface with
 logging channel
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
On Tue, Nov 20, 2018 at 3:58 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This enables any code using shared to log information using the logging
> channel which can then be decoded by the likes of btmon.
> ---
>  Makefile.am      |   1 +
>  src/shared/log.c | 191 +++++++++++++++++++++++++++++++++++++++++++++++
>  src/shared/log.h |  31 ++++++++
>  3 files changed, 223 insertions(+)
>  create mode 100644 src/shared/log.c
>  create mode 100644 src/shared/log.h
>
> diff --git a/Makefile.am b/Makefile.am
> index 0ccf393c6..3f613a617 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -119,6 +119,7 @@ shared_sources = src/shared/io.h src/shared/timeout.h \
>                         src/shared/gatt-server.h src/shared/gatt-server.c \
>                         src/shared/gatt-db.h src/shared/gatt-db.c \
>                         src/shared/gap.h src/shared/gap.c \
> +                       src/shared/log.h src/shared/log.c \
>                         src/shared/tty.h
>
>  if READLINE
> diff --git a/src/shared/log.c b/src/shared/log.c
> new file mode 100644
> index 000000000..d42bae713
> --- /dev/null
> +++ b/src/shared/log.c
> @@ -0,0 +1,191 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2018  Intel Corporation. All rights reserved.
> + *
> + *
> + *  This library is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU Lesser General Public
> + *  License as published by the Free Software Foundation; either
> + *  version 2.1 of the License, or (at your option) any later version.
> + *
> + *  This library is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  Lesser General Public License for more details.
> + *
> + *  You should have received a copy of the GNU Lesser General Public
> + *  License along with this library; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <stdio.h>
> +#include <errno.h>
> +#include <inttypes.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <stdarg.h>
> +#include <string.h>
> +#include <signal.h>
> +#include <sys/socket.h>
> +
> +#include "lib/bluetooth.h"
> +#include "lib/hci.h"
> +
> +#include "src/shared/util.h"
> +#include "src/shared/log.h"
> +
> +struct log_hdr {
> +       uint16_t opcode;
> +       uint16_t index;
> +       uint16_t len;
> +       uint8_t  priority;
> +       uint8_t  ident_len;
> +} __attribute__((packed));
> +
> +struct log_l2cap_hdr {
> +       uint16_t cid;
> +       uint16_t psm;
> +} __attribute__((packed));
> +
> +static int log_fd = -1;
> +
> +int bt_log_sendmsg(uint16_t index, const char *label, int level,
> +                                       struct iovec *io, size_t io_len)
> +{
> +       struct log_hdr hdr;
> +       struct msghdr msg;
> +       struct iovec iov[5];
> +       size_t i;
> +       int err;
> +
> +       if (io_len > 3)
> +               return -EMSGSIZE;
> +
> +       log_fd = bt_log_open();
> +       if (log_fd < 0)
> +               return log_fd;
> +
> +       hdr.opcode = cpu_to_le16(0x0000);
> +       hdr.index = cpu_to_le16(index);
> +       hdr.ident_len = strlen(label) + 1;
> +       hdr.len = cpu_to_le16(2 + hdr.ident_len);
> +       hdr.priority = level;
> +
> +       iov[0].iov_base = &hdr;
> +       iov[0].iov_len = sizeof(hdr);
> +
> +       iov[1].iov_base = (void *) label;
> +       iov[1].iov_len = hdr.ident_len;
> +
> +       memset(&msg, 0, sizeof(msg));
> +       msg.msg_iov = iov;
> +       msg.msg_iovlen = 2;
> +
> +       for (i = 0; i < io_len; i++) {
> +               iov[i + 2] = io[i];
> +               hdr.len += io[i].iov_len;
> +               msg.msg_iovlen++;
> +       }
> +
> +       err = sendmsg(log_fd, &msg, 0);
> +       if (err < 0) {
> +               err = -errno;
> +               close(log_fd);
> +               log_fd = -1;
> +       }
> +
> +       return err;
> +}
> +
> +int bt_log_open(void)
> +{
> +       struct sockaddr_hci addr;
> +       int fd;
> +       static int err;
> +
> +       if (err < 0)
> +               return err;
> +
> +       if (log_fd >= 0)
> +               return log_fd;
> +
> +       fd = socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
> +       if (fd < 0) {
> +               err = -errno;
> +               return -errno;
> +       }
> +
> +       memset(&addr, 0, sizeof(addr));
> +       addr.hci_family = AF_BLUETOOTH;
> +       addr.hci_dev = HCI_DEV_NONE;
> +       addr.hci_channel = HCI_CHANNEL_LOGGING;
> +
> +       err = bind(fd, (struct sockaddr *) &addr, sizeof(addr));
> +       if (err < 0) {
> +               err = -errno;
> +               close(fd);
> +               return err;
> +       }
> +
> +       log_fd = fd;
> +
> +       return fd;
> +}
> +
> +int bt_log_vprintf(uint16_t index, const char *label, int level,
> +                                       const char *format, va_list ap)
> +{
> +       struct iovec iov;
> +       char *str;
> +       int len;
> +
> +       len = vasprintf(&str, format, ap);
> +       if (len < 0)
> +               return errno;
> +
> +       len = strlen(str);
> +
> +       /* Replace new line since btmon already adds it */
> +       if (len > 1 && str[len - 1] == '\n') {
> +               str[len - 1] = '\0';
> +               len--;
> +       }
> +
> +       iov.iov_base = str;
> +       iov.iov_len = len + 1;
> +
> +       len = bt_log_sendmsg(index, label, level, &iov, 1);
> +
> +       free(str);
> +
> +       return len;
> +}
> +
> +int bt_log_printf(uint16_t index, const char *label, int level,
> +                                               const char *format, ...)
> +{
> +       va_list ap;
> +       int err;
> +
> +       va_start(ap, format);
> +       err = bt_log_vprintf(index, label, level, format, ap);
> +       va_end(ap);
> +
> +       return err;
> +}
> +
> +void bt_log_close(void)
> +{
> +       if (log_fd < 0)
> +               return;
> +
> +       close(log_fd);
> +       log_fd = -1;
> +}
> diff --git a/src/shared/log.h b/src/shared/log.h
> new file mode 100644
> index 000000000..c72ab735b
> --- /dev/null
> +++ b/src/shared/log.h
> @@ -0,0 +1,31 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2018  Intel Corporation. All rights reserved.
> + *
> + *
> + *  This library is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU Lesser General Public
> + *  License as published by the Free Software Foundation; either
> + *  version 2.1 of the License, or (at your option) any later version.
> + *
> + *  This library is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  Lesser General Public License for more details.
> + *
> + *  You should have received a copy of the GNU Lesser General Public
> + *  License along with this library; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + */
> +
> +int bt_log_open(void);
> +int bt_log_sendmsg(uint16_t index, const char *label, int level,
> +                                       struct iovec *io, size_t io_len);
> +int bt_log_vprintf(uint16_t index, const char *label, int level,
> +                                       const char *format, va_list ap);
> +int bt_log_printf(uint16_t index, const char *label, int level,
> +                                       const char *format, ...);
> +void bt_log_close(void);
> --
> 2.17.2

Applied.

-- 
Luiz Augusto von Dentz
