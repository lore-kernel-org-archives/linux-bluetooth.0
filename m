Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93975C388F7
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Nov 2020 18:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 209342067D
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Nov 2020 18:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1z0NRej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbgKISEa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Nov 2020 13:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729119AbgKISEa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Nov 2020 13:04:30 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F7EC0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2020 10:04:30 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id m13so11147701oih.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2020 10:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rx60EXHB9TnaKiQGc75QW86JlY6lYIMTABjv2rkp1PU=;
        b=D1z0NRejcg4zWNeReQEHoiEWVy4/pJK1OrO0TtOdhmbI9ACXcg/9STZUUlW6Ua7SYy
         mgVbc1W+4pdT4E+Q5K4CQUkClK0JFTnVjmo1KQtljw0i1szMPMaHEK7sI3b0FxPDM2fr
         TP7MiIrTgi3ZBg880hNIsC5bTN7B/hEbQ3JPfC4C1QACba+wwukvgJmrnTJXO/pLkIZ1
         cP/IRw1jxiqNgqKdc90wlu6PgJJPJC04aerFj+FO/rYIcd/Y3NJNSvShd5qbq9qPSB5V
         pRP0BeWZI+Y7qgennd+chyoOjQLZXbhEyJ+xnLTdRpDNkcKE9Oqn8AoFl3olt40eHsH5
         wcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rx60EXHB9TnaKiQGc75QW86JlY6lYIMTABjv2rkp1PU=;
        b=JADvoS1Fc+C8irHHLsEKGbuYZK7iEBMHBwVD16umYvzeD5qYgFU22U7uM6GrHPFAAB
         0grN+0WnBtLM0GiksW9EBGJDudd3IE61AZOLoZ09o5XBfYckUYjZ78qWk+ZvIqu5asm1
         GXI+mEGfmYPrJIk1AlYOdphu2TiHahwB7EINlMenC2ADC9jHcXnJcCVX6cH3mzaiNjpT
         E3LpiN2kut+TZFcuBeVOTfDJ+4jJEl9DqYUVFtxvLT4Bfswr9K1XEHpHWnf8J0AKZ52F
         oN4xImiDLZ15TxGgZpRup2MS1TQPnf309ER9LeENgpTzbuZUA94+ui4FkhquYP+WwO0i
         CrXg==
X-Gm-Message-State: AOAM531BhPeW97PQgqH2Jbq+Dy3U3yFRYQAL8Ff4PS/73lgcutUPkG+F
        32Ps3t/19Jx6b/jJbILlL0bu7TXIPxE6flBB3ts=
X-Google-Smtp-Source: ABdhPJzEbeMN0oTH6d1M3y/RfllSMq+puXaNHsa1y6umrU2nH3CD7WCWOfgMWXyJC0NcfSrtLqAY33/tg7SX0uD1MkA=
X-Received: by 2002:aca:cc08:: with SMTP id c8mr213398oig.161.1604945069538;
 Mon, 09 Nov 2020 10:04:29 -0800 (PST)
MIME-Version: 1.0
References: <20201107070312.8561-1-inga.stotland@intel.com> <20201107070312.8561-3-inga.stotland@intel.com>
In-Reply-To: <20201107070312.8561-3-inga.stotland@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 9 Nov 2020 10:04:18 -0800
Message-ID: <CABBYNZLYTqsT0+0N-8MCghYT-VeaNpPT0AL_B2vXfwFZy9GZwQ@mail.gmail.com>
Subject: Re: [RFC PATCH BlueZ 02/10] emulator/hciemu: Create ELL based version
 of hciemu
To:     Inga Stotland <inga.stotland@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

On Fri, Nov 6, 2020 at 11:06 PM Inga Stotland <inga.stotland@intel.com> wrote:
>
> This adds a separate implementtion of hciemu code, hciemu-ell.c,
> that uses ELL library primitives.

I wonder if this should really be separated like this or we just make
use of struct io instead of l_io, that way we don't need to keep
duplicating things on the emulator, the other option would be to drop
entirely the glib version but I guess you haven't done that because
there are quite a few dependencies to get rid in order to run the
tester with ell.

> ---
>  emulator/hciemu-ell.c | 564 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 564 insertions(+)
>  create mode 100644 emulator/hciemu-ell.c
>
> diff --git a/emulator/hciemu-ell.c b/emulator/hciemu-ell.c
> new file mode 100644
> index 000000000..40342e99b
> --- /dev/null
> +++ b/emulator/hciemu-ell.c
> @@ -0,0 +1,564 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2012-2014, 2020  Intel Corporation. All rights reserved.
> + *
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <stdbool.h>
> +#include <errno.h>
> +#include <sys/socket.h>
> +
> +#include <ell/ell.h>
> +
> +#include "lib/bluetooth.h"
> +#include "lib/hci.h"
> +
> +#include "monitor/bt.h"
> +#include "emulator/btdev.h"
> +#include "emulator/bthost.h"
> +#include "src/shared/util.h"
> +#include "src/shared/queue.h"
> +#include "emulator/hciemu.h"
> +
> +struct hciemu {
> +       int ref_count;
> +       enum btdev_type btdev_type;
> +       struct bthost *host_stack;
> +       struct btdev *master_dev;
> +       struct btdev *client_dev;
> +       struct l_io *host_io;
> +       struct l_io *master_io;
> +       struct l_io *client_io;
> +       struct queue *post_command_hooks;
> +       char bdaddr_str[18];
> +
> +       hciemu_debug_func_t debug_callback;
> +       hciemu_destroy_func_t debug_destroy;
> +       void *debug_data;
> +};
> +
> +struct hciemu_command_hook {
> +       hciemu_command_func_t function;
> +       void *user_data;
> +};
> +
> +static void destroy_command_hook(void *data)
> +{
> +       struct hciemu_command_hook *hook = data;
> +
> +       free(hook);
> +}
> +
> +struct run_data {
> +       uint16_t opcode;
> +       const void *data;
> +       uint8_t len;
> +};
> +
> +static void run_command_hook(void *data, void *user_data)
> +{
> +       struct hciemu_command_hook *hook = data;
> +       struct run_data *run_data = user_data;
> +
> +       if (hook->function)
> +               hook->function(run_data->opcode, run_data->data,
> +                                       run_data->len, hook->user_data);
> +}
> +
> +static void master_command_callback(uint16_t opcode,
> +                               const void *data, uint8_t len,
> +                               btdev_callback callback, void *user_data)
> +{
> +       struct hciemu *hciemu = user_data;
> +       struct run_data run_data = { .opcode = opcode,
> +                                               .data = data, .len = len };
> +
> +       btdev_command_default(callback);
> +
> +       queue_foreach(hciemu->post_command_hooks, run_command_hook, &run_data);
> +}
> +
> +static void client_command_callback(uint16_t opcode,
> +                               const void *data, uint8_t len,
> +                               btdev_callback callback, void *user_data)
> +{
> +       btdev_command_default(callback);
> +}
> +
> +static void writev_callback(const struct iovec *iov, int iovlen,
> +                                                               void *user_data)
> +{
> +       struct l_io *io = user_data;
> +       ssize_t written;
> +       int fd;
> +
> +       fd = l_io_get_fd(io);
> +
> +       written = writev(fd, iov, iovlen);
> +       if (written < 0)
> +               return;
> +}
> +
> +static bool receive_bthost(struct l_io *io, void *user_data)
> +{
> +       struct bthost *bthost = user_data;
> +       unsigned char buf[4096];
> +       ssize_t len;
> +       int fd;
> +
> +       fd = l_io_get_fd(io);
> +
> +       len = read(fd, buf, sizeof(buf));
> +       if (len < 0)
> +               return false;
> +
> +       bthost_receive_h4(bthost, buf, len);
> +
> +       return true;
> +}
> +
> +static struct l_io *create_io_bthost(int fd, struct bthost *bthost)
> +{
> +       struct l_io *io;
> +
> +       io = l_io_new(fd);
> +
> +       l_io_set_close_on_destroy(io, true);
> +
> +       bthost_set_send_handler(bthost, writev_callback, io);
> +
> +       l_io_set_read_handler(io, receive_bthost, bthost, NULL);
> +
> +       return io;
> +}
> +
> +static bool receive_btdev(struct l_io *io, void *user_data)
> +
> +{
> +       struct btdev *btdev = user_data;
> +       unsigned char buf[4096];
> +       ssize_t len;
> +       int fd;
> +
> +       fd = l_io_get_fd(io);
> +
> +       len = read(fd, buf, sizeof(buf));
> +       if (len < 0) {
> +               if (errno == EAGAIN || errno == EINTR)
> +                       return true;
> +
> +               return false;
> +       }
> +
> +       if (len < 1)
> +               return false;
> +
> +       switch (buf[0]) {
> +       case BT_H4_CMD_PKT:
> +       case BT_H4_ACL_PKT:
> +       case BT_H4_SCO_PKT:
> +               btdev_receive_h4(btdev, buf, len);
> +               break;
> +       }
> +
> +       return true;
> +}
> +
> +static struct l_io *create_io_btdev(int fd, struct btdev *btdev)
> +{
> +       struct l_io *io;
> +
> +       io = l_io_new(fd);
> +
> +       l_io_set_close_on_destroy(io, true);
> +
> +       btdev_set_send_handler(btdev, writev_callback, io);
> +
> +       l_io_set_read_handler(io, receive_btdev, btdev, NULL);
> +
> +       return io;
> +}
> +
> +static bool create_vhci(struct hciemu *hciemu)
> +{
> +       struct btdev *btdev;
> +       uint8_t create_req[2];
> +       ssize_t written;
> +       int fd;
> +
> +       btdev = btdev_create(hciemu->btdev_type, 0x00);
> +       if (!btdev)
> +               return false;
> +
> +       btdev_set_command_handler(btdev, master_command_callback, hciemu);
> +
> +       fd = open("/dev/vhci", O_RDWR | O_NONBLOCK | O_CLOEXEC);
> +       if (fd < 0) {
> +               perror("Opening /dev/vhci failed");
> +               btdev_destroy(btdev);
> +               return false;
> +       }
> +
> +       create_req[0] = HCI_VENDOR_PKT;
> +       create_req[1] = HCI_PRIMARY;
> +
> +       written = write(fd, create_req, sizeof(create_req));
> +       if (written < 0) {
> +               close(fd);
> +               btdev_destroy(btdev);
> +               return false;
> +       }
> +
> +       hciemu->master_dev = btdev;
> +
> +       hciemu->master_io = create_io_btdev(fd, btdev);
> +
> +       return true;
> +}
> +
> +struct bthost *hciemu_client_get_host(struct hciemu *hciemu)
> +{
> +       if (!hciemu)
> +               return NULL;
> +
> +       return hciemu->host_stack;
> +}
> +
> +static bool create_stack(struct hciemu *hciemu)
> +{
> +       struct btdev *btdev;
> +       struct bthost *bthost;
> +       int sv[2];
> +
> +       btdev = btdev_create(hciemu->btdev_type, 0x00);
> +       if (!btdev)
> +               return false;
> +
> +       bthost = bthost_create();
> +       if (!bthost) {
> +               btdev_destroy(btdev);
> +               return false;
> +       }
> +
> +       btdev_set_command_handler(btdev, client_command_callback, hciemu);
> +
> +       if (socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_NONBLOCK | SOCK_CLOEXEC,
> +                                                               0, sv) < 0) {
> +               bthost_destroy(bthost);
> +               btdev_destroy(btdev);
> +               return false;
> +       }
> +
> +       hciemu->client_dev = btdev;
> +       hciemu->host_stack = bthost;
> +
> +       hciemu->client_io = create_io_btdev(sv[0], btdev);
> +       hciemu->host_io = create_io_bthost(sv[1], bthost);
> +
> +       return true;
> +}
> +
> +static void start_stack(void *user_data)
> +{
> +       struct hciemu *hciemu = user_data;
> +
> +       bthost_start(hciemu->host_stack);
> +}
> +
> +struct hciemu *hciemu_new(enum hciemu_type type)
> +{
> +       struct hciemu *hciemu;
> +
> +       hciemu = new0(struct hciemu, 1);
> +       if (!hciemu)
> +               return NULL;
> +
> +       switch (type) {
> +       case HCIEMU_TYPE_BREDRLE:
> +               hciemu->btdev_type = BTDEV_TYPE_BREDRLE;
> +               break;
> +       case HCIEMU_TYPE_BREDR:
> +               hciemu->btdev_type = BTDEV_TYPE_BREDR;
> +               break;
> +       case HCIEMU_TYPE_LE:
> +               hciemu->btdev_type = BTDEV_TYPE_LE;
> +               break;
> +       case HCIEMU_TYPE_LEGACY:
> +               hciemu->btdev_type = BTDEV_TYPE_BREDR20;
> +               break;
> +       case HCIEMU_TYPE_BREDRLE50:
> +               hciemu->btdev_type = BTDEV_TYPE_BREDRLE50;
> +               break;
> +       case HCIEMU_TYPE_BREDRLE52:
> +               hciemu->btdev_type = BTDEV_TYPE_BREDRLE52;
> +               break;
> +       default:
> +               return NULL;
> +       }
> +
> +       hciemu->post_command_hooks = queue_new();
> +       if (!hciemu->post_command_hooks) {
> +               free(hciemu);
> +               return NULL;
> +       }
> +
> +       if (!create_vhci(hciemu)) {
> +               queue_destroy(hciemu->post_command_hooks, NULL);
> +               free(hciemu);
> +               return NULL;
> +       }
> +
> +       if (!create_stack(hciemu)) {
> +               l_io_destroy(hciemu->master_io);
> +               btdev_destroy(hciemu->master_dev);
> +               queue_destroy(hciemu->post_command_hooks, NULL);
> +               free(hciemu);
> +               return NULL;
> +       }
> +
> +       l_idle_oneshot(start_stack, hciemu, NULL);
> +
> +       return hciemu_ref(hciemu);
> +}
> +
> +struct hciemu *hciemu_ref(struct hciemu *hciemu)
> +{
> +       if (!hciemu)
> +               return NULL;
> +
> +       __sync_fetch_and_add(&hciemu->ref_count, 1);
> +
> +       return hciemu;
> +}
> +
> +void hciemu_unref(struct hciemu *hciemu)
> +{
> +       if (!hciemu)
> +               return;
> +
> +       if (__sync_sub_and_fetch(&hciemu->ref_count, 1))
> +               return;
> +
> +       queue_destroy(hciemu->post_command_hooks, destroy_command_hook);
> +
> +       l_io_destroy(hciemu->host_io);
> +       l_io_destroy(hciemu->client_io);
> +       l_io_destroy(hciemu->master_io);
> +
> +       bthost_destroy(hciemu->host_stack);
> +       btdev_destroy(hciemu->client_dev);
> +       btdev_destroy(hciemu->master_dev);
> +
> +       free(hciemu);
> +}
> +
> +static void bthost_debug(const char *str, void *user_data)
> +{
> +       struct hciemu *hciemu = user_data;
> +
> +       util_debug(hciemu->debug_callback, hciemu->debug_data,
> +                                       "bthost: %s", str);
> +}
> +
> +static void btdev_master_debug(const char *str, void *user_data)
> +{
> +       struct hciemu *hciemu = user_data;
> +
> +       util_debug(hciemu->debug_callback, hciemu->debug_data,
> +                                       "btdev: %s", str);
> +}
> +
> +static void btdev_client_debug(const char *str, void *user_data)
> +{
> +       struct hciemu *hciemu = user_data;
> +
> +       util_debug(hciemu->debug_callback, hciemu->debug_data,
> +                                       "btdev[bthost]: %s", str);
> +}
> +
> +bool hciemu_set_debug(struct hciemu *hciemu, hciemu_debug_func_t callback,
> +                       void *user_data, hciemu_destroy_func_t destroy)
> +{
> +       if (!hciemu)
> +               return false;
> +
> +       if (hciemu->debug_destroy)
> +               hciemu->debug_destroy(hciemu->debug_data);
> +
> +       hciemu->debug_callback = callback;
> +       hciemu->debug_destroy = destroy;
> +       hciemu->debug_data = user_data;
> +
> +       btdev_set_debug(hciemu->master_dev, btdev_master_debug, hciemu, NULL);
> +       btdev_set_debug(hciemu->client_dev, btdev_client_debug, hciemu, NULL);
> +       bthost_set_debug(hciemu->host_stack, bthost_debug, hciemu, NULL);
> +
> +       return true;
> +}
> +
> +const char *hciemu_get_address(struct hciemu *hciemu)
> +{
> +       const uint8_t *addr;
> +
> +       if (!hciemu || !hciemu->master_dev)
> +               return NULL;
> +
> +       addr = btdev_get_bdaddr(hciemu->master_dev);
> +       sprintf(hciemu->bdaddr_str, "%2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X",
> +                       addr[5], addr[4], addr[3], addr[2], addr[1], addr[0]);
> +       return hciemu->bdaddr_str;
> +}
> +
> +uint8_t *hciemu_get_features(struct hciemu *hciemu)
> +{
> +       if (!hciemu || !hciemu->master_dev)
> +               return NULL;
> +
> +       return btdev_get_features(hciemu->master_dev);
> +}
> +
> +const uint8_t *hciemu_get_master_bdaddr(struct hciemu *hciemu)
> +{
> +       if (!hciemu || !hciemu->master_dev)
> +               return NULL;
> +
> +       return btdev_get_bdaddr(hciemu->master_dev);
> +}
> +
> +const uint8_t *hciemu_get_client_bdaddr(struct hciemu *hciemu)
> +{
> +       if (!hciemu || !hciemu->client_dev)
> +               return NULL;
> +
> +       return btdev_get_bdaddr(hciemu->client_dev);
> +}
> +
> +uint8_t hciemu_get_master_scan_enable(struct hciemu *hciemu)
> +{
> +       if (!hciemu || !hciemu->master_dev)
> +               return 0;
> +
> +       return btdev_get_scan_enable(hciemu->master_dev);
> +}
> +
> +uint8_t hciemu_get_master_le_scan_enable(struct hciemu *hciemu)
> +{
> +       if (!hciemu || !hciemu->master_dev)
> +               return 0;
> +
> +       return btdev_get_le_scan_enable(hciemu->master_dev);
> +}
> +
> +void hciemu_set_master_le_states(struct hciemu *hciemu,
> +                                               const uint8_t *le_states)
> +{
> +       if (!hciemu || !hciemu->master_dev)
> +               return;
> +
> +       btdev_set_le_states(hciemu->master_dev, le_states);
> +}
> +
> +bool hciemu_add_master_post_command_hook(struct hciemu *hciemu,
> +                       hciemu_command_func_t function, void *user_data)
> +{
> +       struct hciemu_command_hook *hook;
> +
> +       if (!hciemu)
> +               return false;
> +
> +       hook = new0(struct hciemu_command_hook, 1);
> +       if (!hook)
> +               return false;
> +
> +       hook->function = function;
> +       hook->user_data = user_data;
> +
> +       if (!queue_push_tail(hciemu->post_command_hooks, hook)) {
> +               free(hook);
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
> +bool hciemu_clear_master_post_command_hooks(struct hciemu *hciemu)
> +{
> +       if (!hciemu)
> +               return false;
> +
> +       queue_remove_all(hciemu->post_command_hooks,
> +                                       NULL, NULL, destroy_command_hook);
> +       return true;
> +}
> +
> +int hciemu_add_hook(struct hciemu *hciemu, enum hciemu_hook_type type,
> +                               uint16_t opcode, hciemu_hook_func_t function,
> +                               void *user_data)
> +{
> +       enum btdev_hook_type hook_type;
> +
> +       if (!hciemu)
> +               return -1;
> +
> +       switch (type) {
> +       case HCIEMU_HOOK_PRE_CMD:
> +               hook_type = BTDEV_HOOK_PRE_CMD;
> +               break;
> +       case HCIEMU_HOOK_POST_CMD:
> +               hook_type = BTDEV_HOOK_POST_CMD;
> +               break;
> +       case HCIEMU_HOOK_PRE_EVT:
> +               hook_type = BTDEV_HOOK_PRE_EVT;
> +               break;
> +       case HCIEMU_HOOK_POST_EVT:
> +               hook_type = BTDEV_HOOK_POST_EVT;
> +               break;
> +       default:
> +               return -1;
> +       }
> +
> +       return btdev_add_hook(hciemu->master_dev, hook_type, opcode, function,
> +                                                               user_data);
> +}
> +
> +bool hciemu_del_hook(struct hciemu *hciemu, enum hciemu_hook_type type,
> +                                                               uint16_t opcode)
> +{
> +       enum btdev_hook_type hook_type;
> +
> +       if (!hciemu)
> +               return false;
> +
> +       switch (type) {
> +       case HCIEMU_HOOK_PRE_CMD:
> +               hook_type = BTDEV_HOOK_PRE_CMD;
> +               break;
> +       case HCIEMU_HOOK_POST_CMD:
> +               hook_type = BTDEV_HOOK_POST_CMD;
> +               break;
> +       case HCIEMU_HOOK_PRE_EVT:
> +               hook_type = BTDEV_HOOK_PRE_EVT;
> +               break;
> +       case HCIEMU_HOOK_POST_EVT:
> +               hook_type = BTDEV_HOOK_POST_EVT;
> +               break;
> +       default:
> +               return false;
> +       }
> +
> +       return btdev_del_hook(hciemu->master_dev, hook_type, opcode);
> +}
> --
> 2.26.2
>


-- 
Luiz Augusto von Dentz
