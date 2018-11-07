Return-Path: <SRS0=TbT7=NS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14F6C0044C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Nov 2018 18:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A273E20862
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Nov 2018 18:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A273E20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbeKHD4F convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:56:05 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:44010 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbeKHD4F (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Nov 2018 22:56:05 -0500
Received: from marcel-macbook.fritz.box (p4FF9F655.dip0.t-ipconnect.de [79.249.246.85])
        by mail.holtmann.org (Postfix) with ESMTPSA id 32C8ECF2B1;
        Wed,  7 Nov 2018 19:31:57 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH BlueZ 1/3] shared/monitor: Add common code to interface
 with monitor
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181107161432.13081-1-luiz.dentz@gmail.com>
Date:   Wed, 7 Nov 2018 19:24:28 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <9FA12570-7CC6-4635-B163-8FC6A0E73159@holtmann.org>
References: <20181107161432.13081-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This enables any code using shared to log into monitor.
> ---
> Makefile.am          |   1 +
> src/shared/monitor.c | 177 +++++++++++++++++++++++++++++++++++++++++++
> src/shared/monitor.h |  30 ++++++++
> 3 files changed, 208 insertions(+)
> create mode 100644 src/shared/monitor.c
> create mode 100644 src/shared/monitor.h
> 
> diff --git a/Makefile.am b/Makefile.am
> index 0ccf393c6..2243248aa 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -119,6 +119,7 @@ shared_sources = src/shared/io.h src/shared/timeout.h \
> 			src/shared/gatt-server.h src/shared/gatt-server.c \
> 			src/shared/gatt-db.h src/shared/gatt-db.c \
> 			src/shared/gap.h src/shared/gap.c \
> +			src/shared/monitor.h src/shared/monitor.c \
> 			src/shared/tty.h
> 
> if READLINE
> diff --git a/src/shared/monitor.c b/src/shared/monitor.c
> new file mode 100644
> index 000000000..78766ed1a
> --- /dev/null
> +++ b/src/shared/monitor.c
> @@ -0,0 +1,177 @@
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
> +#include "src/shared/monitor.h"
> +
> +struct monitor_hdr {
> +	uint16_t opcode;
> +	uint16_t index;
> +	uint16_t len;
> +	uint8_t  priority;
> +	uint8_t  ident_len;
> +} __attribute__((packed));
> +
> +struct monitor_l2cap_hdr {
> +	uint16_t cid;
> +	uint16_t psm;
> +} __attribute__((packed));
> +
> +static int monitor_fd = -1;
> +
> +int bt_monitor_sendmsg(const char *label, int level, struct iovec *io,
> +							size_t io_len)
> +{
> +	struct monitor_hdr hdr;
> +	struct msghdr msg;
> +	struct iovec iov[5];
> +	size_t i;
> +	int err;
> +
> +	if (io_len > 3)
> +		return -EMSGSIZE;
> +
> +	monitor_fd = bt_monitor_open();
> +	if (monitor_fd < 0)
> +		return monitor_fd;
> +
> +	hdr.opcode = cpu_to_le16(0x0000);
> +	hdr.index = cpu_to_le16(0xffff);
> +	hdr.ident_len = strlen(label) + 1;
> +	hdr.len = cpu_to_le16(2 + hdr.ident_len);
> +	hdr.priority = level;
> +
> +	iov[0].iov_base = &hdr;
> +	iov[0].iov_len = sizeof(hdr);
> +
> +	iov[1].iov_base = (void *) label;
> +	iov[1].iov_len = hdr.ident_len;
> +
> +	memset(&msg, 0, sizeof(msg));
> +	msg.msg_iov = iov;
> +	msg.msg_iovlen = 2;
> +
> +	for (i = 0; i < io_len; i++) {
> +		iov[i + 2] = io[i];
> +		hdr.len += io[i].iov_len;
> +		msg.msg_iovlen++;
> +	}
> +
> +	err = sendmsg(monitor_fd, &msg, 0);
> +	if (err < 0) {
> +		err = -errno;
> +		close(monitor_fd);
> +		monitor_fd = -1;
> +	}
> +
> +	return err;
> +}
> +
> +int bt_monitor_open(void)
> +{
> +	struct sockaddr_hci addr;
> +	int fd;
> +	int err;
> +
> +	if (monitor_fd >= 0)
> +		return monitor_fd;
> +
> +	fd = socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
> +	if (fd < 0)
> +		return -errno;
> +
> +	memset(&addr, 0, sizeof(addr));
> +	addr.hci_family = AF_BLUETOOTH;
> +	addr.hci_dev = HCI_DEV_NONE;
> +	addr.hci_channel = HCI_CHANNEL_LOGGING;
> +
> +	err = bind(fd, (struct sockaddr *) &addr, sizeof(addr));
> +	if (err < 0 ){
> +		err = -errno;
> +		close(fd);
> +		return err;
> +	}
> +
> +	monitor_fd = fd;
> +
> +	return fd;
> +}
> +
> +int bt_monitor_vprintf(const char *label, int level, const char *format,
> +								va_list ap)
> +{
> +	struct iovec iov;
> +	char *str;
> +	int err;
> +
> +	err = vasprintf(&str, format, ap);
> +	if (err < 0)
> +		return errno;
> +
> +	iov.iov_base = str;
> +	iov.iov_len = strlen(str) + 1;
> +
> +	err = bt_monitor_sendmsg(label, level, &iov, 1);
> +
> +	free(str);
> +
> +	return err;
> +}
> +
> +int bt_monitor_printf(const char *label, int level, const char *format, ...)
> +{
> +	va_list ap;
> +	int err;
> +
> +	va_start(ap, format);
> +	err = bt_monitor_vprintf(label, level, format, ap);
> +	va_end(ap);
> +
> +	return err;
> +}
> +
> +void bt_monitor_close(void)
> +{
> +	if (monitor_fd < 0)
> +		return;
> +
> +	close(monitor_fd);
> +	monitor_fd = -1;
> +}
> diff --git a/src/shared/monitor.h b/src/shared/monitor.h
> new file mode 100644
> index 000000000..0aa538e36
> --- /dev/null
> +++ b/src/shared/monitor.h
> @@ -0,0 +1,30 @@
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
> +int bt_monitor_open(void);
> +int bt_monitor_sendmsg(const char *label, int level, struct iovec *io,
> +							size_t io_len);
> +int bt_monitor_vprintf(const char *label, int level, const char *format,
> +								va_list ap);
> +int bt_monitor_printf(const char *label, int level, const char *format, ...);
> +void bt_monitor_close(void);

so I do not like the naming here. This has nothing to do with the monitor actually. It is the logging into the kernel API. So better make this src/shared/log.[ch] and the bt_log_.

Essentially you want a generic logging that does the right thing with sending data to the logging interface and optionally also sending it to syslog / stdout.

Regards

Marcel

