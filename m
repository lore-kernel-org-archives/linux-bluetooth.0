Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493A93806DA
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2026 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025707; cv=pass; b=K/y3Xx5DGTluBQzKwpjzn/2CsodaybUwL776j7F1g/OPjv+zQV9+D89jAY2MAEEVXEt7YfmV7o32v8xynP/RdyIB8O8B/ag/wWnlj5evvGVnwxftsZCPnclIjdZsmz6etZW4w+StQMoBJ1RmJqVePUD8xEykD99gQq8/DkpRAps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025707; c=relaxed/simple;
	bh=DM147Ymxa955Qvfd5148oBfMclhfStDvQjwPJFg7vE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZrizkofOkPFkDLBnhjDUzrHvSxxnYy431T5eSR7Wcsyy6ENqks4qMJRRVRlXWf7E/qomFg+W3iYN+KNpoNVZ1w4WJ/1abxAuJW/7NgFMRgiyo8evIKKEIDxwRZnNzZkwN8mcUuk6Fr9l8zfYOW0oSGRbKOo6Ab/sWRKdc8uOvpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njZ+63Z1; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njZ+63Z1"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8111c0c7561so27713927b3.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Aug 2026 07:14:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786025692; cv=none;
        d=google.com; s=arc-20260327;
        b=NE0jtU5o2raiBGt5CIrLBbGErY3RAK5SaF/I9sRD+3oKM0vaFpoXcng+sUU0/oMBrM
         V5FORz46rvRQZTQIXaNN96FhMzLwb/LjqI9y7V/R4L8PLKGVUXIlOr1sV+ighL01fXCB
         UEX8pXzOcpe4/xCE4fqjMivVmdWZnlXd+Yu6IRLjrjZjdstw+ABkG3ihyRip4XyCya4r
         lfGG6d5wHnxoHm8Y3d9JPq4QTeiUhIMXu/UIkjp0k4HLhMXGHPDxec8kngAUaivQ/57w
         2wZ43xuf2FouSN3kvPltTBuVzOXFz/CaWxbKygXc5pNcC+vsXdVWi/0vCQYrOQjMJ3yn
         EMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hHLfShrZFY/MkrZY1pAEJXuvFa/dxJQH/x5kzM2CO+w=;
        fh=DBIRJP4DvnAE+M31BcQ50XI3CAn/idN52/MNTtsfw9E=;
        b=p7BgCLNS/L/faHmYkKTe5wKQzePNgxPfDEzGJrP0FuIzs5LI+khBF+LG/15lOBpkR/
         eRaT0Vl0CeV9VP5YuI8wA8hR1unIRsY3FmCMLVYSkWP9/FEEdVOcu7w6lIJ4puChoOxv
         uWQUhHVdIkb1VTajYfMdpOKxxIzbgWq21mv3QbYwn/U6iV3KyVFBLnohXkfWeiQ8e5+g
         BKcGnHlF7sUS0Ghe0XMTyyOGFkRn1xxLvgejiVf4tmkmPTDVukItwr2clGY2RH+P5jMD
         VflAe/rgJVYJH7YzhbNg45eh2r/5zkqFNyjSru6vUXLAQjg1TP+3YYSIX7QlgHmb4koN
         JGvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786025692; x=1786630492; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hHLfShrZFY/MkrZY1pAEJXuvFa/dxJQH/x5kzM2CO+w=;
        b=njZ+63Z11lJvDdt3U+Q1IXMRNap20T4ZZMl6UBqMsgsTC3Jbu/xhTHNkY3TUlH9gzw
         gZJFFhquHqWi38okYgH7pjCQ3OpbXDL7VAJDRIbRskIxMm7oz5XNtzT1sSCMbT74f/0H
         pICiFkV+BwOxSZLvv8/dAf7IL6yqH2XVo7gqDlGwa0Yq0qoaZvyKOYC6j8UCZ0TjX90B
         ItJBTYsAbLm2KYsvzyY6B0JSDzljxIbEa4pTDVBozgSatLwdavr7Z/c5qTleLlbpKV/a
         ZXbSI4KMPTinSHrI8X+Gf/Pfb+i3Y9F/yfaRLrLNBKwlVVnvS+vw9ZoDYTsKSuRbEKeQ
         97jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786025692; x=1786630492;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hHLfShrZFY/MkrZY1pAEJXuvFa/dxJQH/x5kzM2CO+w=;
        b=J1oE5EcLpPdofHVay2qqwM/QyZpijIwFPr2sgX/kOTEzTVu5J1K5ykYgdMNeJGo9m1
         CJkVeC7mP9nGUjgl3q/2ZNqbeazl1PZZKdjCCXfncSbBgS3GkSuQ61xKkci6xuyd8RoN
         qVJ16ShBr+2nd9tZhnt+tOpL4l6QZJTu3+QqxVOliS7KP4WLv5v5B17cQqgfWybMNb5P
         gUyc9aIy7onv8cVW/DQB5KRUvvhpjuhU9PMafiE54EYq8Q6cf8RB7f8g9Fx6fLF7RHGz
         C9uOM3uDojuIgZNdyppqeWND8jT6UIUdJn8mAb25J4if8EZvVAk2x2OTLXMG04Oav+kB
         vJ2A==
X-Gm-Message-State: AOJu0YwXiMW8egDGumFwaVfTEjKw+F8xC0OXcthnIWzzk9oVXNQDTtwa
	P0BO20P4XHc1Fw+uTbdRAlLN1vL7QxcCT+g7WjqkeQTRXcJ1wx+T+OJ4AdT7GRiicVyOTU0ZC/G
	medDGexm741urapLTKu8yc/lJ2Pq+bJc=
X-Gm-Gg: AR+sD11O6NxV+B7fMqCmwKs9h+0OPBpjBQSeFTVrUrbt5Dedj+pRB8Nhl30qNnDSQEH
	k0VQy3ZwNyAQlc4c6MggoJrYgSIF8C9h1Bndjx7aYygwOkDmXViTPu6WK5NFiLqcujetBCMlBd/
	VE3YdcNA99ISNYrACurjuFteaA+NCjmVkKKbONqZdgJO3ukgUy0gcqBE035ekSJs70zLnvNozVv
	LsTHicb9Kvmx8OzrEHGXOkD2WryZUbk3aZsTlfRAYgOgZhevJU0bH+bt/uezxt379RHV/eU85RZ
	kv6XEx8QMA3OupmI5MxS4fnih7KCEzwDJCHc7u19gH5F4xnon2eU+o5ENnD1niky76bhA0hQjBV
	tBdymKos+rHsvQkszyhI73QfNP65FJ3c=
X-Received: by 2002:a05:690c:e08:b0:7db:ccda:a409 with SMTP id
 00721157ae682-820222ad0camr103531067b3.9.1786025690472; Thu, 06 Aug 2026
 07:14:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806132231.3052523-1-hadess@hadess.net> <20260806132231.3052523-3-hadess@hadess.net>
In-Reply-To: <20260806132231.3052523-3-hadess@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 6 Aug 2026 10:14:37 -0400
X-Gm-Features: AUfX_mwQQyVY_qb-XovX3JByd_Hte5JmY2hCYd_9FAKMxRC3pDKNBfKsSiZitmI
Message-ID: <CABBYNZK7iPm4_y++hmRypfqnZ2oE-3J0fWYnpYpA8fORgxsO7g@mail.gmail.com>
Subject: Re: [BlueZ, v3 2/5] unit: Remove left-over test-avrcp Android test
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Thu, Aug 6, 2026 at 9:29=E2=80=AFAM Bastien Nocera <hadess@hadess.net> w=
rote:
>
> This test was supposed to exercise the avrcp-lib from the Android
> backend, but that backend was removed, and the library moved into
> the unit/ directory.
>
> The tests provide 0% coverage towards profiles/audio so they're just
> dead code we should remove.
> ---
>  Makefile.am       |    9 -
>  unit/avrcp-lib.c  | 3604 ---------------------------------------------
>  unit/avrcp-lib.h  |  343 -----
>  unit/test-avrcp.c | 2084 --------------------------
>  4 files changed, 6040 deletions(-)
>  delete mode 100644 unit/avrcp-lib.c
>  delete mode 100644 unit/avrcp-lib.h
>  delete mode 100644 unit/test-avrcp.c
>
> diff --git a/Makefile.am b/Makefile.am
> index 19c468d3a504..f4f638323c79 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -651,15 +651,6 @@ unit_test_avctp_SOURCES =3D unit/test-avctp.c \
>                                 unit/avctp.c unit/avctp.h
>  unit_test_avctp_LDADD =3D src/libshared-glib.la $(GLIB_LIBS)
>
> -unit_tests +=3D unit/test-avrcp
> -
> -unit_test_avrcp_SOURCES =3D unit/test-avrcp.c \
> -                               src/log.h src/log.c \
> -                               unit/avctp.c unit/avctp.h \
> -                               unit/avrcp-lib.c unit/avrcp-lib.h
> -unit_test_avrcp_LDADD =3D lib/libbluetooth-internal.la \
> -                               src/libshared-glib.la $(GLIB_LIBS)

The tests are valid, what isn't valid is that it doesn't test the
right implementation, I understand this is a much bigger work though.

>  unit_tests +=3D unit/test-hfp
>
>  unit_test_hfp_SOURCES =3D unit/test-hfp.c
> diff --git a/unit/avrcp-lib.c b/unit/avrcp-lib.c
> deleted file mode 100644
> index 720775fd2603..000000000000
> --- a/unit/avrcp-lib.c
> +++ /dev/null
> @@ -1,3604 +0,0 @@
> -// SPDX-License-Identifier: LGPL-2.1-or-later
> -/*
> - *
> - *  BlueZ - Bluetooth protocol stack for Linux
> - *
> - *  Copyright (C) 2014  Intel Corporation. All rights reserved.
> - *
> - *
> - */
> -
> -#ifdef HAVE_CONFIG_H
> -#include <config.h>
> -#endif
> -
> -#define _GNU_SOURCE
> -#include <stdbool.h>
> -#include <glib.h>
> -#include <errno.h>
> -#include <string.h>
> -
> -#include "bluetooth/bluetooth.h"
> -
> -#include "src/shared/util.h"
> -#include "src/log.h"
> -
> -#include "avctp.h"
> -#include "avrcp-lib.h"
> -
> -
> -/* Packet types */
> -#define AVRCP_PACKET_TYPE_SINGLE               0x00
> -#define AVRCP_PACKET_TYPE_START                        0x01
> -#define AVRCP_PACKET_TYPE_CONTINUING           0x02
> -#define AVRCP_PACKET_TYPE_END                  0x03
> -
> -#define AVRCP_CHARSET_UTF8     0x006a
> -
> -#if __BYTE_ORDER =3D=3D __LITTLE_ENDIAN
> -
> -struct avrcp_header {
> -       uint8_t company_id[3];
> -       uint8_t pdu_id;
> -       uint8_t packet_type:2;
> -       uint8_t rsvd:6;
> -       uint16_t params_len;
> -       uint8_t params[0];
> -} __attribute__ ((packed));
> -#define AVRCP_HEADER_LENGTH 7
> -
> -#elif __BYTE_ORDER =3D=3D __BIG_ENDIAN
> -
> -struct avrcp_header {
> -       uint8_t company_id[3];
> -       uint8_t pdu_id;
> -       uint8_t rsvd:6;
> -       uint8_t packet_type:2;
> -       uint16_t params_len;
> -       uint8_t params[0];
> -} __attribute__ ((packed));
> -#define AVRCP_HEADER_LENGTH 7
> -
> -#else
> -#error "Unknown byte order"
> -#endif
> -
> -struct avrcp_browsing_header {
> -       uint8_t pdu_id;
> -       uint16_t params_len;
> -       uint8_t params[0];
> -} __attribute__ ((packed));
> -#define AVRCP_BROWSING_HEADER_LENGTH 3
> -
> -struct get_capabilities_req {
> -       uint8_t cap;
> -       uint8_t params[0];
> -} __attribute__ ((packed));
> -
> -struct get_capabilities_rsp {
> -       uint8_t cap;
> -       uint8_t number;
> -       uint8_t params[0];
> -} __attribute__ ((packed));
> -
> -struct list_attributes_rsp {
> -       uint8_t number;
> -       uint8_t params[0];
> -} __attribute__ ((packed));
> -
> -struct list_values_req {
> -       uint8_t attr;
> -} __attribute__ ((packed));
> -
> -struct list_values_rsp {
> -       uint8_t number;
> -       uint8_t params[0];
> -} __attribute__ ((packed));
> -
> -struct get_value_req {
> -       uint8_t number;
> -       uint8_t attrs[0];
> -} __attribute__ ((packed));
> -
> -struct attr_value {
> -       uint8_t attr;
> -       uint8_t value;
> -} __attribute__ ((packed));
> -
> -struct value_rsp {
> -       uint8_t number;
> -       struct attr_value values[0];
> -} __attribute__ ((packed));
> -
> -struct set_value_req {
> -       uint8_t number;
> -       struct attr_value values[0];
> -} __attribute__ ((packed));
> -
> -struct get_attribute_text_req {
> -       uint8_t number;
> -       uint8_t attrs[0];
> -} __attribute__ ((packed));
> -
> -struct text_value {
> -       uint8_t attr;
> -       uint16_t charset;
> -       uint8_t len;
> -       char data[0];
> -} __attribute__ ((packed));
> -
> -struct get_attribute_text_rsp {
> -       uint8_t number;
> -       struct text_value values[0];
> -} __attribute__ ((packed));
> -
> -struct get_value_text_req {
> -       uint8_t attr;
> -       uint8_t number;
> -       uint8_t values[0];
> -} __attribute__ ((packed));
> -
> -struct get_value_text_rsp {
> -       uint8_t number;
> -       struct text_value values[0];
> -} __attribute__ ((packed));
> -
> -struct media_item {
> -       uint32_t attr;
> -       uint16_t charset;
> -       uint16_t len;
> -       char data[0];
> -} __attribute__ ((packed));
> -
> -struct get_element_attributes_req {
> -       uint64_t id;
> -       uint8_t number;
> -       uint32_t attrs[0];
> -} __attribute__ ((packed));
> -
> -struct get_element_attributes_rsp {
> -       uint8_t number;
> -       struct media_item items[0];
> -} __attribute__ ((packed));
> -
> -struct get_play_status_rsp {
> -       uint32_t duration;
> -       uint32_t position;
> -       uint8_t status;
> -} __attribute__ ((packed));
> -
> -struct register_notification_req {
> -       uint8_t event;
> -       uint32_t interval;
> -} __attribute__ ((packed));
> -
> -struct register_notification_rsp {
> -       uint8_t event;
> -       uint8_t data[0];
> -} __attribute__ ((packed));
> -
> -struct set_volume_req {
> -       uint8_t value;
> -} __attribute__ ((packed));
> -
> -struct set_volume_rsp {
> -       uint8_t value;
> -} __attribute__ ((packed));
> -
> -struct set_addressed_req {
> -       uint16_t id;
> -} __attribute__ ((packed));
> -
> -struct set_addressed_rsp {
> -       uint8_t status;
> -} __attribute__ ((packed));
> -
> -struct set_browsed_req {
> -       uint16_t id;
> -} __attribute__ ((packed));
> -
> -struct set_browsed_rsp {
> -       uint8_t status;
> -       uint16_t counter;
> -       uint32_t items;
> -       uint16_t charset;
> -       uint8_t depth;
> -       uint8_t data[0];
> -} __attribute__ ((packed));
> -
> -struct get_folder_items_req {
> -       uint8_t scope;
> -       uint32_t start;
> -       uint32_t end;
> -       uint8_t number;
> -       uint32_t attrs[0];
> -} __attribute__ ((packed));
> -
> -struct get_folder_items_rsp {
> -       uint8_t status;
> -       uint16_t counter;
> -       uint16_t number;
> -       uint8_t data[0];
> -} __attribute__ ((packed));
> -
> -struct change_path_req {
> -       uint16_t counter;
> -       uint8_t direction;
> -       uint64_t uid;
> -} __attribute__ ((packed));
> -
> -struct change_path_rsp {
> -       uint8_t status;
> -       uint32_t items;
> -} __attribute__ ((packed));
> -
> -struct get_item_attributes_req {
> -       uint8_t scope;
> -       uint64_t uid;
> -       uint16_t counter;
> -       uint8_t number;
> -       uint32_t attrs[0];
> -} __attribute__ ((packed));
> -
> -struct get_item_attributes_rsp {
> -       uint8_t status;
> -       uint8_t number;
> -       struct media_item items[0];
> -} __attribute__ ((packed));
> -
> -struct play_item_req {
> -       uint8_t scope;
> -       uint64_t uid;
> -       uint16_t counter;
> -} __attribute__ ((packed));
> -
> -struct play_item_rsp {
> -       uint8_t status;
> -} __attribute__ ((packed));
> -
> -struct search_req {
> -       uint16_t charset;
> -       uint16_t len;
> -       char string[0];
> -} __attribute__ ((packed));
> -
> -struct search_rsp {
> -       uint8_t status;
> -       uint16_t counter;
> -       uint32_t items;
> -} __attribute__ ((packed));
> -
> -struct add_to_now_playing_req {
> -       uint8_t scope;
> -       uint64_t uid;
> -       uint16_t counter;
> -} __attribute__ ((packed));
> -
> -struct add_to_now_playing_rsp {
> -       uint8_t status;
> -} __attribute__ ((packed));
> -
> -struct avrcp_control_handler {
> -       uint8_t id;
> -       uint8_t code;
> -       uint8_t rsp;
> -       ssize_t (*func) (struct avrcp *session, uint8_t transaction,
> -                       uint16_t params_len, uint8_t *params, void *user_=
data);
> -};
> -
> -struct avrcp_browsing_handler {
> -       uint8_t id;
> -       ssize_t (*func) (struct avrcp *session, uint8_t transaction,
> -                       uint16_t params_len, uint8_t *params, void *user_=
data);
> -};
> -
> -struct avrcp_continuing {
> -       uint8_t pdu_id;
> -       struct iovec pdu;
> -};
> -
> -struct avrcp {
> -       struct avctp *conn;
> -       struct avrcp_player *player;
> -
> -       const struct avrcp_control_handler *control_handlers;
> -       void *control_data;
> -       unsigned int control_id;
> -       uint16_t control_mtu;
> -
> -       struct avrcp_continuing *continuing;
> -
> -       const struct avrcp_passthrough_handler *passthrough_handlers;
> -       void *passthrough_data;
> -       unsigned int passthrough_id;
> -
> -       const struct avrcp_browsing_handler *browsing_handlers;
> -       void *browsing_data;
> -       unsigned int browsing_id;
> -
> -       avrcp_destroy_cb_t destroy;
> -       void *destroy_data;
> -};
> -
> -struct avrcp_player {
> -       const struct avrcp_control_ind *ind;
> -       const struct avrcp_control_cfm *cfm;
> -
> -       void *user_data;
> -};
> -
> -static inline uint32_t ntoh24(const uint8_t src[3])
> -{
> -       return src[0] << 16 | src[1] << 8 | src[2];
> -}
> -
> -static inline void hton24(uint8_t dst[3], uint32_t src)
> -{
> -       dst[0] =3D (src & 0xff0000) >> 16;
> -       dst[1] =3D (src & 0x00ff00) >> 8;
> -       dst[2] =3D (src & 0x0000ff);
> -}
> -
> -static void continuing_free(struct avrcp_continuing *continuing)
> -{
> -       g_free(continuing->pdu.iov_base);
> -       g_free(continuing);
> -}
> -
> -void avrcp_shutdown(struct avrcp *session)
> -{
> -       if (session->conn) {
> -               if (session->control_id > 0)
> -                       avctp_unregister_pdu_handler(session->conn,
> -                                                       session->control_=
id);
> -               if (session->passthrough_id > 0)
> -                       avctp_unregister_passthrough_handler(session->con=
n,
> -                                               session->passthrough_id);
> -
> -               if (session->browsing_id > 0)
> -                       avctp_unregister_browsing_pdu_handler(session->co=
nn,
> -                                                       session->browsing=
_id);
> -
> -               /* clear destroy callback that would call shutdown again =
*/
> -               avctp_set_destroy_cb(session->conn, NULL, NULL);
> -               avctp_shutdown(session->conn);
> -       }
> -
> -       if (session->destroy)
> -               session->destroy(session->destroy_data);
> -
> -       if (session->continuing)
> -               continuing_free(session->continuing);
> -
> -       g_free(session->player);
> -       g_free(session);
> -}
> -
> -static struct avrcp_header *parse_pdu(uint8_t *operands, size_t operand_=
count)
> -{
> -       struct avrcp_header *pdu;
> -
> -       if (!operands || operand_count < sizeof(*pdu)) {
> -               error("AVRCP: packet too small (%zu bytes)", operand_coun=
t);
> -               return NULL;
> -       }
> -
> -       pdu =3D (void *) operands;
> -       pdu->params_len =3D ntohs(pdu->params_len);
> -
> -       if (operand_count !=3D pdu->params_len + sizeof(*pdu)) {
> -               error("AVRCP: invalid parameter length (%u bytes)",
> -                                                       pdu->params_len);
> -               return NULL;
> -       }
> -
> -       return pdu;
> -}
> -
> -static struct avrcp_browsing_header *parse_browsing_pdu(uint8_t *operand=
s,
> -                                                       size_t operand_co=
unt)
> -{
> -       struct avrcp_browsing_header *pdu;
> -
> -       if (!operands || operand_count < sizeof(*pdu)) {
> -               error("AVRCP: packet too small (%zu bytes)", operand_coun=
t);
> -               return NULL;
> -       }
> -
> -       pdu =3D (void *) operands;
> -       pdu->params_len =3D ntohs(pdu->params_len);
> -
> -       if (operand_count !=3D pdu->params_len + sizeof(*pdu)) {
> -               error("AVRCP: invalid parameter length (%u bytes)",
> -                                                       pdu->params_len);
> -               return NULL;
> -       }
> -
> -       return pdu;
> -}
> -
> -static uint8_t errno2status(int err)
> -{
> -       switch (err) {
> -       case -ENOSYS:
> -               return AVRCP_STATUS_INVALID_COMMAND;
> -       case -EINVAL:
> -               return AVRCP_STATUS_INVALID_PARAM;
> -       case 0:
> -               return AVRCP_STATUS_SUCCESS;
> -       case -ENOTDIR:
> -               return AVRCP_STATUS_NOT_DIRECTORY;
> -       case -EBADRQC:
> -               return AVRCP_STATUS_INVALID_SCOPE;
> -       case -ERANGE:
> -               return AVRCP_STATUS_OUT_OF_BOUNDS;
> -       case -ENOENT:
> -               return AVRCP_STATUS_DOES_NOT_EXIST;
> -       default:
> -               return AVRCP_STATUS_INTERNAL_ERROR;
> -       }
> -}
> -
> -static ssize_t handle_vendordep_pdu(struct avctp *conn, uint8_t transact=
ion,
> -                                       uint8_t *code, uint8_t *subunit,
> -                                       uint8_t *operands, size_t operand=
_count,
> -                                       void *user_data)
> -{
> -       struct avrcp *session =3D user_data;
> -       const struct avrcp_control_handler *handler;
> -       struct avrcp_header *pdu;
> -       uint32_t company_id;
> -       ssize_t ret;
> -
> -       pdu =3D parse_pdu(operands, operand_count);
> -       if (!pdu) {
> -               pdu =3D (void *) operands;
> -               pdu->params[0] =3D AVRCP_STATUS_INVALID_COMMAND;
> -               goto reject;
> -       }
> -
> -       company_id =3D ntoh24(pdu->company_id);
> -       if (company_id !=3D IEEEID_BTSIG) {
> -               *code =3D AVC_CTYPE_NOT_IMPLEMENTED;
> -               return 0;
> -       }
> -
> -       DBG("AVRCP PDU 0x%02X, len 0x%04X", pdu->pdu_id, pdu->params_len)=
;
> -
> -       pdu->packet_type =3D 0;
> -       pdu->rsvd =3D 0;
> -
> -       if (!session->control_handlers)
> -               goto reject;
> -
> -       for (handler =3D session->control_handlers; handler->id; handler+=
+) {
> -               if (handler->id =3D=3D pdu->pdu_id)
> -                       break;
> -       }
> -
> -       if (handler->id !=3D pdu->pdu_id || handler->code !=3D *code) {
> -               pdu->params[0] =3D AVRCP_STATUS_INVALID_COMMAND;
> -               goto reject;
> -       }
> -
> -       if (!handler->func) {
> -               pdu->params[0] =3D AVRCP_STATUS_INVALID_PARAM;
> -               goto reject;
> -       }
> -
> -       ret =3D handler->func(session, transaction, pdu->params_len, pdu-=
>params,
> -                                                       session->control_=
data);
> -       if (ret =3D=3D 0)
> -               return -EAGAIN;
> -
> -       if (ret < 0) {
> -               if (ret =3D=3D -EAGAIN)
> -                       return ret;
> -               pdu->params[0] =3D errno2status(ret);
> -               goto reject;
> -       }
> -
> -       *code =3D handler->rsp;
> -       pdu->params_len =3D htons(ret);
> -
> -       return AVRCP_HEADER_LENGTH + ret;
> -
> -reject:
> -       pdu->params_len =3D htons(1);
> -       *code =3D AVC_CTYPE_REJECTED;
> -
> -       return AVRCP_HEADER_LENGTH + 1;
> -}
> -
> -static bool handle_passthrough_pdu(struct avctp *conn, uint8_t op,
> -                                               bool pressed, void *user_=
data)
> -{
> -       struct avrcp *session =3D user_data;
> -       const struct avrcp_passthrough_handler *handler;
> -
> -       if (!session->passthrough_handlers)
> -               return false;
> -
> -       for (handler =3D session->passthrough_handlers; handler->func;
> -                                                               handler++=
) {
> -               if (handler->op =3D=3D op)
> -                       break;
> -       }
> -
> -       if (handler->func =3D=3D NULL)
> -               return false;
> -
> -       return handler->func(session, pressed, session->passthrough_data)=
;
> -}
> -
> -static void disconnect_cb(void *data)
> -{
> -       struct avrcp *session =3D data;
> -
> -       session->conn =3D NULL;
> -
> -       avrcp_shutdown(session);
> -}
> -
> -struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t versi=
on)
> -{
> -       struct avrcp *session;
> -
> -       session =3D g_new0(struct avrcp, 1);
> -
> -       session->conn =3D avctp_new(fd, imtu, omtu, version);
> -       if (!session->conn) {
> -               g_free(session);
> -               return NULL;
> -       }
> -
> -       session->passthrough_id =3D avctp_register_passthrough_handler(
> -                                                       session->conn,
> -                                                       handle_passthroug=
h_pdu,
> -                                                       session);
> -       session->control_id =3D avctp_register_pdu_handler(session->conn,
> -                                                       AVC_OP_VENDORDEP,
> -                                                       handle_vendordep_=
pdu,
> -                                                       session);
> -       session->control_mtu =3D omtu - AVC_DATA_OFFSET;
> -
> -       /*
> -        * 27.1.2 AV/C Command Frame
> -        * An AV/C command frame contains up to 512 octets of data
> -        */
> -       if (session->control_mtu > AVC_DATA_MTU)
> -               session->control_mtu =3D AVC_DATA_MTU;
> -
> -       avctp_set_destroy_cb(session->conn, disconnect_cb, session);
> -
> -       return session;
> -}
> -
> -static ssize_t handle_browsing_pdu(struct avctp *conn,
> -                                       uint8_t transaction, uint8_t *ope=
rands,
> -                                       size_t operand_count, void *user_=
data)
> -{
> -       struct avrcp *session =3D user_data;
> -       const struct avrcp_browsing_handler *handler;
> -       struct avrcp_browsing_header *pdu;
> -       int ret;
> -
> -       pdu =3D parse_browsing_pdu(operands, operand_count);
> -       if (!pdu) {
> -               pdu =3D (void *) operands;
> -               pdu->params[0] =3D AVRCP_STATUS_INVALID_COMMAND;
> -               goto reject;
> -       }
> -
> -       DBG("AVRCP Browsing PDU 0x%02X, len 0x%04X", pdu->pdu_id,
> -                                                       pdu->params_len);
> -
> -       if (!session->browsing_handlers) {
> -               pdu->pdu_id =3D AVRCP_GENERAL_REJECT;
> -               pdu->params[0] =3D AVRCP_STATUS_INTERNAL_ERROR;
> -               goto reject;
> -       }
> -
> -       for (handler =3D session->browsing_handlers; handler->id; handler=
++) {
> -               if (handler->id =3D=3D pdu->pdu_id)
> -                       break;
> -       }
> -
> -       if (handler->id !=3D pdu->pdu_id) {
> -               pdu->pdu_id =3D AVRCP_GENERAL_REJECT;
> -               pdu->params[0] =3D AVRCP_STATUS_INVALID_COMMAND;
> -               goto reject;
> -       }
> -
> -       if (!handler->func) {
> -               pdu->params[0] =3D AVRCP_STATUS_INVALID_PARAM;
> -               goto reject;
> -       }
> -
> -       ret =3D handler->func(session, transaction, pdu->params_len, pdu-=
>params,
> -                                                       session->control_=
data);
> -       if (ret =3D=3D 0)
> -               return -EAGAIN;
> -
> -       if (ret < 0) {
> -               if (ret =3D=3D -EAGAIN)
> -                       return ret;
> -               pdu->params[0] =3D errno2status(ret);
> -               goto reject;
> -       }
> -
> -       pdu->params_len =3D htons(ret);
> -
> -       return AVRCP_BROWSING_HEADER_LENGTH + ret;
> -
> -reject:
> -       pdu->params_len =3D htons(1);
> -
> -       return AVRCP_BROWSING_HEADER_LENGTH + 1;
> -}
> -
> -static void browsing_disconnect_cb(void *data)
> -{
> -       struct avrcp *session =3D data;
> -
> -       session->browsing_id =3D 0;
> -}
> -
> -int avrcp_connect_browsing(struct avrcp *session, int fd, size_t imtu,
> -                                                               size_t om=
tu)
> -{
> -       int err;
> -
> -       err =3D avctp_connect_browsing(session->conn, fd, imtu, omtu);
> -       if (err < 0)
> -               return err;
> -
> -       session->browsing_id =3D avctp_register_browsing_pdu_handler(
> -                                                       session->conn,
> -                                                       handle_browsing_p=
du,
> -                                                       session,
> -                                                       browsing_disconne=
ct_cb);
> -
> -       return 0;
> -}
> -
> -void avrcp_set_destroy_cb(struct avrcp *session, avrcp_destroy_cb_t cb,
> -                                                       void *user_data)
> -{
> -       session->destroy =3D cb;
> -       session->destroy_data =3D user_data;
> -}
> -
> -static ssize_t get_capabilities(struct avrcp *session, uint8_t transacti=
on,
> -                               uint16_t params_len, uint8_t *params,
> -                               void *user_data)
> -{
> -       struct avrcp_player *player =3D user_data;
> -       struct get_capabilities_req *req;
> -
> -       if (!params || params_len !=3D sizeof(*req))
> -               return -EINVAL;
> -
> -       req =3D (void *) params;
> -
> -       switch (req->cap) {
> -       case CAP_COMPANY_ID:
> -               req->params[0] =3D 1;
> -               hton24(&req->params[1], IEEEID_BTSIG);
> -               return 5;
> -       case CAP_EVENTS_SUPPORTED:
> -               if (!player->ind || !player->ind->get_capabilities)
> -                       return -ENOSYS;
> -               return player->ind->get_capabilities(session, transaction=
,
> -                                                       player->user_data=
);
> -       }
> -
> -       return -EINVAL;
> -}
> -
> -static ssize_t list_attributes(struct avrcp *session, uint8_t transactio=
n,
> -                               uint16_t params_len, uint8_t *params,
> -                               void *user_data)
> -{
> -       struct avrcp_player *player =3D user_data;
> -
> -       DBG("");
> -
> -       if (!player->ind || !player->ind->list_attributes)
> -               return -ENOSYS;
> -
> -       return player->ind->list_attributes(session, transaction,
> -                                                       player->user_data=
);
> -}
> -
> -static bool check_attributes(uint8_t number, const uint8_t *attrs)
> -{
> -       int i;
> -
> -       for (i =3D 0; i < number; i++) {
> -               if (attrs[i] > AVRCP_ATTRIBUTE_LAST ||
> -                                       attrs[i] =3D=3D AVRCP_ATTRIBUTE_I=
LEGAL)
> -                       return false;
> -       }
> -
> -       return true;
> -}
> -
> -static ssize_t get_attribute_text(struct avrcp *session, uint8_t transac=
tion,
> -                                       uint16_t params_len, uint8_t *par=
ams,
> -                                       void *user_data)
> -{
> -       struct avrcp_player *player =3D user_data;
> -       struct get_attribute_text_req *req;
> -
> -       DBG("");
> -
> -       if (!player->ind || !player->ind->get_attribute_text)
> -               return -ENOSYS;
> -
> -       if (!params || params_len < sizeof(*req))
> -               return -EINVAL;
> -
> -       req =3D (void *) params;
> -       if (params_len !=3D sizeof(*req) + req->number)
> -               return -EINVAL;
> -
> -       if (!check_attributes(req->number, req->attrs))
> -               return -EINVAL;
> -
> -       return player->ind->get_attribute_text(session, transaction,
> -                                               req->number, req->attrs,
> -                                               player->user_data);
> -}
> -
> -static ssize_t list_values(struct avrcp *session, uint8_t transaction,
> -                                       uint16_t params_len, uint8_t *par=
ams,
> -                                       void *user_data)
> -{
> -       struct avrcp_player *player =3D user_data;
> -       struct list_values_req *req;
> -
> -       DBG("");
> -
> -       if (!params || params_len !=3D sizeof(*req))
> -               return -EINVAL;
> -
> -       req =3D (void *) params;
> -       if (req->attr > AVRCP_ATTRIBUTE_LAST ||
> -                                       req->attr =3D=3D AVRCP_ATTRIBUTE_=
ILEGAL)
> -               return -EINVAL;
> -
> -       if (!player->ind || !player->ind->list_values)
> -               return -ENOSYS;
> -
> -       return player->ind->list_values(session, transaction, req->attr,
> -                                                       player->user_data=
);
> -}
> -
> -static bool check_value(uint8_t attr, uint8_t number, const uint8_t *val=
ues)
> -{
> -       int i;
> -
> -       for (i =3D 0; i < number; i++) {
> -               /* Check for invalid value */
> -               switch (attr) {
> -               case AVRCP_ATTRIBUTE_EQUALIZER:
> -                       if (values[i] < AVRCP_EQUALIZER_OFF ||
> -                                               values[i] > AVRCP_EQUALIZ=
ER_ON)
> -                               return false;
> -                       break;
> -               case AVRCP_ATTRIBUTE_REPEAT_MODE:
> -                       if (values[i] < AVRCP_REPEAT_MODE_OFF ||
> -                                       values[i] > AVRCP_REPEAT_MODE_GRO=
UP)
> -                               return false;
> -                       break;
> -               case AVRCP_ATTRIBUTE_SHUFFLE:
> -                       if (values[i] < AVRCP_SHUFFLE_OFF ||
> -                                       values[i] > AVRCP_SHUFFLE_GROUP)
> -                               return false;
> -                       break;
> -               case AVRCP_ATTRIBUTE_SCAN:
> -                       if (values[i] < AVRCP_SCAN_OFF ||
> -                                       values[i] > AVRCP_SCAN_GROUP)
> -                               return false;
> -                       break;
> -               }
> -       }
> -
> -       return true;
> -}
> -
> -static ssize_t get_value_text(struct avrcp *session, uint8_t transaction=
,
> -                                       uint16_t params_len, uint8_t *par=
ams,
> -                                       void *user_data)
> -{
> -       struct avrcp_player *player =3D user_data;
> -       struct get_value_text_req *req;
> -
> -       DBG("");
> -
> -       if (!player->ind || !player->ind->get_value_text)
> -               return -ENOSYS;
> -
> -       if (!params || params_len < sizeof(*req))
> -               return -EINVAL;
> -
> -       req =3D (void *) params;
> -       if (params_len !=3D sizeof(*req) + req->number)
> -               return -EINVAL;
> -
> -       if (req->number > AVRCP_ATTRIBUTE_LAST ||
> -                                       req->number =3D=3D AVRCP_ATTRIBUT=
E_ILEGAL)
> -               return -EINVAL;
> -
> -       if (!check_value(req->attr, req->number, req->values))
> -               return -EINVAL;
> -
> -       return player->ind->get_value_text(session, transaction, params[0=
],
> -                                               params[1], &params[2],
> -                                               player->user_data);
> -}
> -
> -static ssize_t get_value(struct avrcp *session, uint8_t transaction,
> -                                       uint16_t params_len, uint8_t *par=
ams,
> -                                       void *user_data)
> -{
> -       struct avrcp_player *player =3D user_data;
> -       struct get_value_req *req;
> -
> -       DBG("");
> -
> -       if (!player->ind || !player->ind->get_value)
> -               return -ENOSYS;
> -
> -       if (!params || params_len < sizeof(*req))
> -               return -EINVAL;
> -
> -       req =3D (void *) params;
> -       if (params_len < sizeof(*req) + req->number)
> -               return -EINVAL;
> -
> -       if (!check_attributes(req->number, req->attrs))
> -               return -EINVAL;
> -
> -       return player->ind->get_value(session, transaction, params[0],
> -                                       &params[1], player->user_data);
> -}
> -
> -static ssize_t set_value(struct avrcp *session, uint8_t transaction,
> -                                       uint16_t params_len, uint8_t *par=
ams,
> -                                       void *user_data)
> -{
> -       struct avrcp_player *player =3D user_data;
> -       struct set_value_req *req;
> -       uint8_t attrs[AVRCP_ATTRIBUTE_LAST];
> -       uint8_t values[AVRCP_ATTRIBUTE_LAST];
> -       int i;
> -
> -       DBG("");
> -
> -       if (!player->ind || !player->ind->set_value)
> -               return -ENOSYS;
> -
> -       if (!params || params_len < sizeof(*req))
> -               return -EINVAL;
> -
> -       req =3D (void *) params;
> -       if (params_len < sizeof(*req) + req->number * sizeof(*req->values=
))
> -               return -EINVAL;
> -
> -       for (i =3D 0; i < req->number; i++) {
> -               attrs[i] =3D req->values[i].attr;
> -               values[i] =3D req->values[i].value;
> -
> -               if (!check_value(attrs[i], 1, &values[i]))
> -                       return -EINVAL;
> -       }
> -
> -       return player->ind->set_value(session, transaction, req->number,
> -                                       attrs, values, player->user_data)=
;
> -}
> -
> -static ssize_t get_play_status(struct avrcp *session, uint8_t transactio=
n,
> -                                       uint16_t params_len, uint8_t *par=
ams,
> -                                       void *user_data)
> -{
> -       struct avrcp_player *player =3D user_data;
> -
> -       DBG("");
> -
> -       if (!player->ind || !player->ind->get_play_status)
> -               return -ENOSYS;
> -
> -       return player->ind->get_play_status(session, transaction,
> -                                                       player->user_data=
);
> -}
> -
> -static bool parse_attributes(struct get_element_attributes_req *req,
> -                                       uint16_t params_len, uint8_t numb=
er,
> -                                       uint32_t *attrs)
> -{
> -       int i;
> -
> -       for (i =3D 0; i < number && params_len >=3D sizeof(*attrs); i++,
> -                                       params_len -=3D sizeof(*attrs)) {
> -               attrs[i] =3D be32_to_cpu(req->attrs[i]);
> -
> -               if (attrs[i] =3D=3D AVRCP_MEDIA_ATTRIBUTE_ILLEGAL ||
> -                               attrs[i] > AVRCP_MEDIA_ATTRIBUTE_LAST)
> -                       return false;
> -       }
> -
> -       return true;
> -}
> -
> -static ssize_t get_element_attributes(struct avrcp *session,
> -                                               uint8_t transaction,
> -                                               uint16_t params_len,
> -                                               uint8_t *params,
> -                                               void *user_data)
> -{
> -       struct avrcp_player *player =3D user_data;
> -       struct get_element_attributes_req *req;
> -       uint64_t uid;
> -       uint32_t attrs[AVRCP_MEDIA_ATTRIBUTE_LAST];
> -
> -       DBG("");
> -
> -       if (!player->ind || !player->ind->get_element_attributes)
> -               return -ENOSYS;
> -
> -       req =3D (void *) params;
> -       if (!params || params_len < sizeof(*req))
> -               return -EINVAL;
> -
> -       if (!parse_attributes(req, params_len - sizeof(*req),
> -                                                       req->number, attr=
s))
> -               return -EINVAL;
> -
> -       uid =3D get_be64(params);
> -
> -       return player->ind->get_element_attributes(session, transaction, =
uid,
> -                                                       req->number, attr=
s,
> -                                                       player->user_data=
);
> -}
> -
> -static ssize_t register_notification(struct avrcp *session, uint8_t tran=
saction,
> -                                       uint16_t params_len, uint8_t *par=
ams,
> -                                       void *user_data)
> -{
> -       struct avrcp_player *player =3D user_data;
> -       struct register_notification_req *req;
> -       uint32_t interval;
> -
> -       DBG("");
> -
> -       if (!player->ind || !player->ind->register_notification)
> -               return -ENOSYS;
> -
> -       if (!params || params_len !=3D sizeof(*req))
> -               return -EINVAL;
> -
> -       req =3D (void *) params;
> -
> -       interval =3D be32_to_cpu(req->interval);
> -
> -       return player->ind->register_notification(session, transaction,
> -                                                       req->event, inter=
val,
> -                                                       player->user_data=
);
> -}
> -
> -static ssize_t set_volume(struct avrcp *session, uint8_t transaction,
> -                                       uint16_t params_len, uint8_t *par=
ams,
> -                                       void *user_data)
> -{
> -       struct avrcp_player *player =3D user_data;
> -       struct set_volume_req *req;
> -       uint8_t volume;
> -
> -       DBG("");
> -
> -       if (!player->ind || !player->ind->set_volume)
> -               return -ENOSYS;
> -
> -       if (!params || params_len !=3D sizeof(volume))
> -               return -EINVAL;
> -
> -       req =3D (void *) params;
> -
> -       volume =3D req->value & 0x7f;
> -
> -       return player->ind->set_volume(session, transaction, volume,
> -                                                       player->user_data=
);
> -}
> -
> -static ssize_t set_addressed(struct avrcp *session, uint8_t transaction,
> -                                       uint16_t params_len, uint8_t *par=
ams,
> -                                       void *user_data)
> -{
> -       struct avrcp_player *player =3D user_data;
> -       struct set_addressed_req *req;
> -       uint16_t id;
> -
> -       DBG("");
> -
> -       if (!player->ind || !player->ind->set_addressed)
> -               return -ENOSYS;
> -
> -       if (!params || params_len !=3D sizeof(*req))
> -               return -EINVAL;
> -
> -       req =3D (void *) params;
> -
> -       id =3D be16_to_cpu(req->id);
> -
> -       return player->ind->set_addressed(session, transaction, id,
> -                                                       player->user_data=
);
> -}
> -
> -static void continuing_new(struct avrcp *session, uint8_t pdu_id,
> -                                       const struct iovec *iov, int iov_=
cnt,
> -                                       size_t offset)
> -{
> -       struct avrcp_continuing *continuing;
> -       int i;
> -       size_t len =3D 0;
> -
> -       continuing =3D g_new0(struct avrcp_continuing, 1);
> -       continuing->pdu_id =3D pdu_id;
> -
> -       for (i =3D 0; i < iov_cnt; i++) {
> -               if (i =3D=3D 0 && offset) {
> -                       len +=3D iov[i].iov_len - offset;
> -                       continue;
> -               }
> -
> -               len +=3D iov[i].iov_len;
> -       }
> -
> -       continuing->pdu.iov_base =3D g_malloc0(len);
> -
> -       DBG("len %zu", len);
> -
> -       for (i =3D 0; i < iov_cnt; i++) {
> -               if (i =3D=3D 0 && offset) {
> -                       memcpy(continuing->pdu.iov_base,
> -                                               iov[i].iov_base + offset,
> -                                               iov[i].iov_len - offset);
> -                       continuing->pdu.iov_len +=3D iov[i].iov_len - off=
set;
> -                       continue;
> -               }
> -
> -               memcpy(continuing->pdu.iov_base + continuing->pdu.iov_len=
,
> -                                       iov[i].iov_base, iov[i].iov_len);
> -               continuing->pdu.iov_len +=3D iov[i].iov_len;
> -       }
> -
> -       session->continuing =3D continuing;
> -}
> -
> -static int avrcp_send_internal(struct avrcp *session, uint8_t transactio=
n,
> -                                       uint8_t code, uint8_t subunit,
> -                                       uint8_t pdu_id, uint8_t type,
> -                                       const struct iovec *iov, int iov_=
cnt)
> -{
> -       struct iovec pdu[iov_cnt + 1];
> -       struct avrcp_header hdr;
> -       int i;
> -
> -       /*
> -        * If a receiver receives a start fragment or non-fragmented AVRC=
P
> -        * Specific AV/C message when it already has an incomplete fragme=
nt
> -        * from that sender then the receiver shall consider the first PD=
U
> -        * aborted.
> -        */
> -       if (session->continuing) {
> -               continuing_free(session->continuing);
> -               session->continuing =3D NULL;
> -       }
> -
> -       memset(&hdr, 0, sizeof(hdr));
> -
> -       pdu[0].iov_base =3D &hdr;
> -       pdu[0].iov_len =3D sizeof(hdr);
> -
> -       hdr.packet_type =3D type;
> -
> -       for (i =3D 0; i < iov_cnt; i++) {
> -               pdu[i + 1].iov_base =3D iov[i].iov_base;
> -
> -               if (pdu[0].iov_len + hdr.params_len + iov[i].iov_len <=3D
> -                                                       session->control_=
mtu) {
> -                       pdu[i + 1].iov_len =3D iov[i].iov_len;
> -                       hdr.params_len +=3D iov[i].iov_len;
> -                       if (hdr.packet_type !=3D AVRCP_PACKET_TYPE_SINGLE=
)
> -                               hdr.packet_type =3D AVRCP_PACKET_TYPE_END=
;
> -                       continue;
> -               }
> -
> -               /*
> -                * Only send what can fit and store the remaining in the
> -                * continuing iovec
> -                */
> -               pdu[i + 1].iov_len =3D session->control_mtu -
> -                                       (pdu[0].iov_len + hdr.params_len)=
;
> -               hdr.params_len +=3D pdu[i + 1].iov_len;
> -
> -               continuing_new(session, pdu_id, &iov[i], iov_cnt - i,
> -                                                       pdu[i + 1].iov_le=
n);
> -
> -               hdr.packet_type =3D hdr.packet_type !=3D AVRCP_PACKET_TYP=
E_SINGLE ?
> -                                               AVRCP_PACKET_TYPE_CONTINU=
ING :
> -                                               AVRCP_PACKET_TYPE_START;
> -               break;
> -       }
> -
> -       hton24(hdr.company_id, IEEEID_BTSIG);
> -       hdr.pdu_id =3D pdu_id;
> -       hdr.params_len =3D htons(hdr.params_len);
> -
> -       return avctp_send_vendor(session->conn, transaction, code, subuni=
t,
> -                                                       pdu, iov_cnt + 1)=
;
> -}
> -
> -static ssize_t request_continuing(struct avrcp *session, uint8_t transac=
tion,
> -                                       uint16_t params_len, uint8_t *par=
ams,
> -                                       void *user_data)
> -{
> -       struct iovec iov;
> -       int err;
> -
> -       DBG("");
> -
> -       if (!params || params_len !=3D 1 || !session->continuing ||
> -                               session->continuing->pdu_id !=3D params[0=
])
> -               return -EINVAL;
> -
> -       iov.iov_base =3D session->continuing->pdu.iov_base;
> -       iov.iov_len =3D session->continuing->pdu.iov_len;
> -
> -       DBG("len %zu", iov.iov_len);
> -
> -       session->continuing->pdu.iov_base =3D NULL;
> -
> -       err =3D avrcp_send_internal(session, transaction, AVC_CTYPE_STABL=
E,
> -                                       AVC_SUBUNIT_PANEL, params[0],
> -                                       AVRCP_PACKET_TYPE_CONTINUING, &io=
v, 1);
> -
> -       g_free(iov.iov_base);
> -
> -       if (err < 0)
> -               return -EINVAL;
> -
> -       return 0;
> -}
> -
> -static ssize_t abort_continuing(struct avrcp *session, uint8_t transacti=
on,
> -                                       uint16_t params_len, uint8_t *par=
ams,
> -                                       void *user_data)
> -{
> -       DBG("");
> -
> -       if (!params || params_len !=3D 1 || !session->continuing)
> -               return -EINVAL;
> -
> -       continuing_free(session->continuing);
> -       session->continuing =3D NULL;
> -
> -       avrcp_send_internal(session, transaction, AVC_CTYPE_ACCEPTED,
> -                               AVC_SUBUNIT_PANEL, AVRCP_ABORT_CONTINUING=
,
> -                               AVRCP_PACKET_TYPE_SINGLE, NULL, 0);
> -
> -       return 0;
> -}
> -
> -static const struct avrcp_control_handler player_handlers[] =3D {
> -               { AVRCP_GET_CAPABILITIES,
> -                                       AVC_CTYPE_STATUS, AVC_CTYPE_STABL=
E,
> -                                       get_capabilities },
> -               { AVRCP_LIST_PLAYER_ATTRIBUTES,
> -                                       AVC_CTYPE_STATUS, AVC_CTYPE_STABL=
E,
> -                                       list_attributes },
> -               { AVRCP_GET_PLAYER_ATTRIBUTE_TEXT,
> -                                       AVC_CTYPE_STATUS, AVC_CTYPE_STABL=
E,
> -                                       get_attribute_text },
> -               { AVRCP_LIST_PLAYER_VALUES,
> -                                       AVC_CTYPE_STATUS, AVC_CTYPE_STABL=
E,
> -                                       list_values },
> -               { AVRCP_GET_PLAYER_VALUE_TEXT,
> -                                       AVC_CTYPE_STATUS, AVC_CTYPE_STABL=
E,
> -                                       get_value_text },
> -               { AVRCP_GET_CURRENT_PLAYER_VALUE,
> -                                       AVC_CTYPE_STATUS, AVC_CTYPE_STABL=
E,
> -                                       get_value },
> -               { AVRCP_SET_PLAYER_VALUE,
> -                                       AVC_CTYPE_CONTROL, AVC_CTYPE_STAB=
LE,
> -                                       set_value },
> -               { AVRCP_GET_PLAY_STATUS,
> -                                       AVC_CTYPE_STATUS, AVC_CTYPE_STABL=
E,
> -                                       get_play_status },
> -               { AVRCP_GET_ELEMENT_ATTRIBUTES,
> -                                       AVC_CTYPE_STATUS, AVC_CTYPE_STABL=
E,
> -                                       get_element_attributes },
> -               { AVRCP_REGISTER_NOTIFICATION,
> -                                       AVC_CTYPE_NOTIFY, AVC_CTYPE_INTER=
IM,
> -                                       register_notification },
> -               { AVRCP_SET_ABSOLUTE_VOLUME,
> -                                       AVC_CTYPE_CONTROL, AVC_CTYPE_STAB=
LE,
> -                                       set_volume },
> -               { AVRCP_SET_ADDRESSED_PLAYER,
> -                                       AVC_CTYPE_CONTROL, AVC_CTYPE_STAB=
LE,
> -                                       set_addressed },
> -               { AVRCP_REQUEST_CONTINUING,
> -                                       AVC_CTYPE_CONTROL, AVC_CTYPE_STAB=
LE,
> -                                       request_continuing },
> -               { AVRCP_ABORT_CONTINUING,
> -                                       AVC_CTYPE_CONTROL, AVC_CTYPE_ACCE=
PTED,
> -                                       abort_continuing },
> -               { },
> -};
> -
> -static void avrcp_set_control_handlers(struct avrcp *session,
> -                               const struct avrcp_control_handler *handl=
ers,
> -                               void *user_data)
> -{
> -       session->control_handlers =3D handlers;
> -       session->control_data =3D user_data;
> -}
> -
> -static ssize_t set_browsed(struct avrcp *session, uint8_t transaction,
> -                                       uint16_t params_len, uint8_t *par=
ams,
> -                                       void *user_data)
> -{
> -       struct avrcp_player *player =3D user_data;
> -       struct set_browsed_req *req;
> -       uint16_t id;
> -
> -       DBG("");
> -
> -       if (!player->ind || !player->ind->set_browsed)
> -               return -ENOSYS;
> -
> -       if (!params || params_len !=3D sizeof(*req))
> -               return -EINVAL;
> -
> -       req =3D (void *) params;
> -
> -       id =3D be16_to_cpu(req->id);
> -
> -       return player->ind->set_browsed(session, transaction, id,
> -                                                       player->user_data=
);
> -}
> -
> -static ssize_t get_folder_items(struct avrcp *session, uint8_t transacti=
on,
> -                                       uint16_t params_len, uint8_t *par=
ams,
> -                                       void *user_data)
> -{
> -       struct avrcp_player *player =3D user_data;
> -       struct get_folder_items_req *req;
> -       uint32_t start, end;
> -       uint16_t number;
> -       uint32_t attrs[AVRCP_MEDIA_ATTRIBUTE_LAST];
> -       int i;
> -
> -       DBG("");
> -
> -       if (!player->ind || !player->ind->get_folder_items)
> -               return -ENOSYS;
> -
> -       if (!params || params_len < sizeof(*req))
> -               return -EINVAL;
> -
> -       req =3D (void *) params;
> -
> -       if (req->scope > AVRCP_MEDIA_NOW_PLAYING)
> -               return -EBADRQC;
> -
> -       start =3D be32_to_cpu(req->start);
> -       end =3D be32_to_cpu(req->end);
> -
> -       if (start > end)
> -               return -ERANGE;
> -
> -       number =3D be16_to_cpu(req->number);
> -
> -       for (i =3D 0; i < number; i++) {
> -               attrs[i] =3D be32_to_cpu(req->attrs[i]);
> -
> -               if (attrs[i] =3D=3D AVRCP_MEDIA_ATTRIBUTE_ILLEGAL ||
> -                               attrs[i] > AVRCP_MEDIA_ATTRIBUTE_LAST)
> -                       return -EINVAL;
> -       }
> -
> -       return player->ind->get_folder_items(session, transaction, req->s=
cope,
> -                                               start, end, number, attrs=
,
> -                                               player->user_data);
> -}
> -
> -static ssize_t change_path(struct avrcp *session, uint8_t transaction,
> -                                       uint16_t params_len, uint8_t *par=
ams,
> -                                       void *user_data)
> -{
> -       struct avrcp_player *player =3D user_data;
> -       struct change_path_req *req;
> -       uint16_t counter;
> -       uint64_t uid;
> -
> -       DBG("");
> -
> -       if (!player->ind || !player->ind->change_path)
> -               return -ENOSYS;
> -
> -       if (!params || params_len < sizeof(*req))
> -               return -EINVAL;
> -
> -       req =3D (void *) params;
> -
> -       counter =3D be16_to_cpu(req->counter);
> -       uid =3D be64_to_cpu(req->uid);
> -
> -       return player->ind->change_path(session, transaction, counter,
> -                                       req->direction, uid, player->user=
_data);
> -}
> -
> -static ssize_t get_item_attributes(struct avrcp *session, uint8_t transa=
ction,
> -                                       uint16_t params_len, uint8_t *par=
ams,
> -                                       void *user_data)
> -{
> -       struct avrcp_player *player =3D user_data;
> -       struct get_item_attributes_req *req;
> -       uint64_t uid;
> -       uint16_t counter;
> -       uint32_t attrs[AVRCP_MEDIA_ATTRIBUTE_LAST];
> -       int i;
> -
> -       DBG("");
> -
> -       if (!player->ind || !player->ind->get_item_attributes)
> -               return -ENOSYS;
> -
> -       if (!params || params_len < sizeof(*req))
> -               return -EINVAL;
> -
> -       req =3D (void *) params;
> -
> -       if (req->scope > AVRCP_MEDIA_NOW_PLAYING)
> -               return -EBADRQC;
> -
> -       uid =3D be64_to_cpu(req->uid);
> -       counter =3D be16_to_cpu(req->counter);
> -
> -       for (i =3D 0; i < req->number; i++) {
> -               attrs[i] =3D be32_to_cpu(req->attrs[i]);
> -
> -               if (attrs[i] =3D=3D AVRCP_MEDIA_ATTRIBUTE_ILLEGAL ||
> -                               attrs[i] > AVRCP_MEDIA_ATTRIBUTE_LAST)
> -                       return -EINVAL;
> -       }
> -
> -       return player->ind->get_item_attributes(session, transaction,
> -                                               req->scope, uid, counter,
> -                                               req->number, attrs,
> -                                               player->user_data);
> -}
> -
> -static ssize_t play_item(struct avrcp *session, uint8_t transaction,
> -                                       uint16_t params_len, uint8_t *par=
ams,
> -                                       void *user_data)
> -{
> -       struct avrcp_player *player =3D user_data;
> -       struct play_item_req *req;
> -       uint64_t uid;
> -       uint16_t counter;
> -
> -       DBG("");
> -
> -       if (!player->ind || !player->ind->play_item)
> -               return -ENOSYS;
> -
> -       if (!params || params_len < sizeof(*req))
> -               return -EINVAL;
> -
> -       req =3D (void *) params;
> -
> -       if (req->scope > AVRCP_MEDIA_NOW_PLAYING)
> -               return -EBADRQC;
> -
> -       uid =3D be64_to_cpu(req->uid);
> -       counter =3D be16_to_cpu(req->counter);
> -
> -       return player->ind->play_item(session, transaction, req->scope, u=
id,
> -                                               counter, player->user_dat=
a);
> -}
> -
> -static ssize_t search(struct avrcp *session, uint8_t transaction,
> -                                       uint16_t params_len, uint8_t *par=
ams,
> -                                       void *user_data)
> -{
> -       struct avrcp_player *player =3D user_data;
> -       struct search_req *req;
> -       char *string;
> -       uint16_t len;
> -       int ret;
> -
> -       DBG("");
> -
> -       if (!player->ind || !player->ind->search)
> -               return -ENOSYS;
> -
> -       if (!params || params_len < sizeof(*req))
> -               return -EINVAL;
> -
> -       req =3D (void *) params;
> -
> -       len =3D be16_to_cpu(req->len);
> -       if (!len)
> -               return -EINVAL;
> -
> -       string =3D strndup(req->string, len);
> -
> -       ret =3D player->ind->search(session, transaction, string,
> -                                                       player->user_data=
);
> -
> -       free(string);
> -
> -       return ret;
> -}
> -
> -static ssize_t add_to_now_playing(struct avrcp *session, uint8_t transac=
tion,
> -                                       uint16_t params_len, uint8_t *par=
ams,
> -                                       void *user_data)
> -{
> -       struct avrcp_player *player =3D user_data;
> -       struct add_to_now_playing_req *req;
> -       uint64_t uid;
> -       uint16_t counter;
> -
> -       DBG("");
> -
> -       if (!player->ind || !player->ind->add_to_now_playing)
> -               return -ENOSYS;
> -
> -       if (!params || params_len < sizeof(*req))
> -               return -EINVAL;
> -
> -       req =3D (void *) params;
> -
> -       if (req->scope > AVRCP_MEDIA_NOW_PLAYING)
> -               return -EBADRQC;
> -
> -       uid =3D be64_to_cpu(req->uid);
> -       counter =3D be16_to_cpu(req->counter);
> -
> -       return player->ind->add_to_now_playing(session, transaction, req-=
>scope,
> -                                                       uid, counter,
> -                                                       player->user_data=
);
> -}
> -
> -static const struct avrcp_browsing_handler browsing_handlers[] =3D {
> -               { AVRCP_SET_BROWSED_PLAYER, set_browsed },
> -               { AVRCP_GET_FOLDER_ITEMS, get_folder_items },
> -               { AVRCP_CHANGE_PATH, change_path },
> -               { AVRCP_GET_ITEM_ATTRIBUTES, get_item_attributes },
> -               { AVRCP_PLAY_ITEM, play_item },
> -               { AVRCP_SEARCH, search },
> -               { AVRCP_ADD_TO_NOW_PLAYING, add_to_now_playing },
> -               { },
> -};
> -
> -static void avrcp_set_browsing_handlers(struct avrcp *session,
> -                               const struct avrcp_browsing_handler *hand=
lers,
> -                               void *user_data)
> -{
> -       session->browsing_handlers =3D handlers;
> -       session->browsing_data =3D user_data;
> -}
> -
> -void avrcp_register_player(struct avrcp *session,
> -                               const struct avrcp_control_ind *ind,
> -                               const struct avrcp_control_cfm *cfm,
> -                               void *user_data)
> -{
> -       struct avrcp_player *player;
> -
> -       player =3D g_new0(struct avrcp_player, 1);
> -       player->ind =3D ind;
> -       player->cfm =3D cfm;
> -       player->user_data =3D user_data;
> -
> -       avrcp_set_control_handlers(session, player_handlers, player);
> -       avrcp_set_browsing_handlers(session, browsing_handlers, player);
> -       session->player =3D player;
> -}
> -
> -void avrcp_set_passthrough_handlers(struct avrcp *session,
> -                       const struct avrcp_passthrough_handler *handlers,
> -                       void *user_data)
> -{
> -       session->passthrough_handlers =3D handlers;
> -       session->passthrough_data =3D user_data;
> -}
> -
> -int avrcp_init_uinput(struct avrcp *session, const char *name,
> -                                                       const char *addre=
ss)
> -{
> -       return avctp_init_uinput(session->conn, name, address);
> -}
> -
> -int avrcp_send(struct avrcp *session, uint8_t transaction, uint8_t code,
> -                                       uint8_t subunit, uint8_t pdu_id,
> -                                       const struct iovec *iov, int iov_=
cnt)
> -{
> -       return avrcp_send_internal(session, transaction, code, subunit, p=
du_id,
> -                                       AVRCP_PACKET_TYPE_SINGLE, iov, io=
v_cnt);
> -}
> -
> -static int status2errno(uint8_t status)
> -{
> -       switch (status) {
> -       case AVRCP_STATUS_INVALID_COMMAND:
> -               return -ENOSYS;
> -       case AVRCP_STATUS_INVALID_PARAM:
> -               return -EINVAL;
> -       case AVRCP_STATUS_SUCCESS:
> -               return 0;
> -       case AVRCP_STATUS_NOT_DIRECTORY:
> -               return -ENOTDIR;
> -       case AVRCP_STATUS_INVALID_SCOPE:
> -               return -EBADRQC;
> -       case AVRCP_STATUS_OUT_OF_BOUNDS:
> -               return -ERANGE;
> -       case AVRCP_STATUS_INTERNAL_ERROR:
> -       case AVRCP_STATUS_INVALID_PLAYER_ID:
> -       case AVRCP_STATUS_PLAYER_NOT_BROWSABLE:
> -       case AVRCP_STATUS_NO_AVAILABLE_PLAYERS:
> -       case AVRCP_STATUS_ADDRESSED_PLAYER_CHANGED:
> -               return -EPERM;
> -       default:
> -               return -EPROTO;
> -       }
> -}
> -
> -static int parse_status(struct avrcp_header *pdu)
> -{
> -       if (pdu->params_len < 1)
> -               return -EPROTO;
> -
> -       return status2errno(pdu->params[0]);
> -}
> -
> -static int parse_browsing_status(struct avrcp_browsing_header *pdu)
> -{
> -       if (pdu->params_len < 1)
> -               return -EPROTO;
> -
> -       return status2errno(pdu->params[0]);
> -}
> -
> -static int avrcp_send_req(struct avrcp *session, uint8_t code, uint8_t s=
ubunit,
> -                                       uint8_t pdu_id, const struct iove=
c *iov,
> -                                       int iov_cnt, avctp_rsp_cb func,
> -                                       void *user_data)
> -{
> -       struct iovec pdu[iov_cnt + 1];
> -       struct avrcp_header hdr;
> -       int i;
> -
> -       memset(&hdr, 0, sizeof(hdr));
> -
> -       pdu[0].iov_base =3D &hdr;
> -       pdu[0].iov_len =3D sizeof(hdr);
> -
> -       for (i =3D 0; i < iov_cnt; i++) {
> -               pdu[i + 1].iov_base =3D iov[i].iov_base;
> -               pdu[i + 1].iov_len =3D iov[i].iov_len;
> -               hdr.params_len +=3D iov[i].iov_len;
> -       }
> -
> -       hton24(hdr.company_id, IEEEID_BTSIG);
> -       hdr.pdu_id =3D pdu_id;
> -       hdr.packet_type =3D AVRCP_PACKET_TYPE_SINGLE;
> -       hdr.params_len =3D htons(hdr.params_len);
> -
> -       return avctp_send_vendor_req(session->conn, code, subunit, pdu,
> -                                               iov_cnt + 1, func, user_d=
ata);
> -}
> -
> -static int avrcp_send_browsing_req(struct avrcp *session, uint8_t pdu_id=
,
> -                                       const struct iovec *iov, int iov_=
cnt,
> -                                       avctp_browsing_rsp_cb func,
> -                                       void *user_data)
> -{
> -       struct iovec pdu[iov_cnt + 1];
> -       struct avrcp_browsing_header hdr;
> -       int i;
> -
> -       memset(&hdr, 0, sizeof(hdr));
> -
> -       for (i =3D 0; i < iov_cnt; i++) {
> -               pdu[i + 1].iov_base =3D iov[i].iov_base;
> -               pdu[i + 1].iov_len =3D iov[i].iov_len;
> -               hdr.params_len +=3D iov[i].iov_len;
> -       }
> -
> -       hdr.pdu_id =3D pdu_id;
> -       hdr.params_len =3D htons(hdr.params_len);
> -
> -       pdu[0].iov_base =3D &hdr;
> -       pdu[0].iov_len =3D sizeof(hdr);
> -
> -       return avctp_send_browsing_req(session->conn, pdu, iov_cnt + 1,
> -                                                       func, user_data);
> -}
> -
> -static int avrcp_send_browsing(struct avrcp *session, uint8_t transactio=
n,
> -                               uint8_t pdu_id, const struct iovec *iov,
> -                               int iov_cnt)
> -{
> -       struct iovec pdu[iov_cnt + 1];
> -       struct avrcp_browsing_header hdr;
> -       int i;
> -
> -       memset(&hdr, 0, sizeof(hdr));
> -
> -       for (i =3D 0; i < iov_cnt; i++) {
> -               pdu[i + 1].iov_base =3D iov[i].iov_base;
> -               pdu[i + 1].iov_len =3D iov[i].iov_len;
> -               hdr.params_len +=3D iov[i].iov_len;
> -       }
> -
> -       hdr.pdu_id =3D pdu_id;
> -       hdr.params_len =3D htons(hdr.params_len);
> -
> -       pdu[0].iov_base =3D &hdr;
> -       pdu[0].iov_len =3D sizeof(hdr);
> -
> -       return avctp_send_browsing(session->conn, transaction, pdu,
> -                                                               iov_cnt +=
 1);
> -}
> -
> -static gboolean get_capabilities_rsp(struct avctp *conn,
> -                                       uint8_t code, uint8_t subunit,
> -                                       uint8_t *operands, size_t operand=
_count,
> -                                       void *user_data)
> -{
> -       struct avrcp *session =3D user_data;
> -       struct avrcp_player *player =3D session->player;
> -       struct avrcp_header *pdu;
> -       struct get_capabilities_rsp *rsp;
> -       uint8_t number =3D 0;
> -       uint8_t *params =3D NULL;
> -       int err;
> -
> -       DBG("");
> -
> -       if (!player || !player->cfm || !player->cfm->get_capabilities)
> -               return FALSE;
> -
> -       pdu =3D parse_pdu(operands, operand_count);
> -       if (!pdu) {
> -               err =3D -EPROTO;
> -               goto done;
> -       }
> -
> -       if (code =3D=3D AVC_CTYPE_REJECTED) {
> -               err =3D parse_status(pdu);
> -               goto done;
> -       }
> -
> -       if (pdu->params_len < sizeof(*rsp)) {
> -               err =3D -EPROTO;
> -               goto done;
> -       }
> -
> -       rsp =3D (void *) pdu->params;
> -
> -       switch (rsp->cap) {
> -       case CAP_COMPANY_ID:
> -       case CAP_EVENTS_SUPPORTED:
> -               break;
> -       default:
> -               err =3D -EPROTO;
> -               goto done;
> -       }
> -
> -       if (rsp->number > 0) {
> -               number =3D rsp->number;
> -               params =3D rsp->params;
> -       }
> -
> -       err =3D 0;
> -
> -done:
> -       player->cfm->get_capabilities(session, err, number, params,
> -                                                       player->user_data=
);
> -
> -       return FALSE;
> -}
> -
> -
> -int avrcp_get_capabilities(struct avrcp *session, uint8_t param)
> -{
> -       struct iovec iov;
> -       struct get_capabilities_req req;
> -
> -       req.cap =3D param;
> -
> -       iov.iov_base =3D &req;
> -       iov.iov_len =3D sizeof(req);
> -
> -       return avrcp_send_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANE=
L,
> -                                       AVRCP_GET_CAPABILITIES, &iov, 1,
> -                                       get_capabilities_rsp, session);
> -}
> -
> -static gboolean register_notification_rsp(struct avctp *conn,
> -                                       uint8_t code, uint8_t subunit,
> -                                       uint8_t *operands, size_t operand=
_count,
> -                                       void *user_data)
> -{
> -       struct avrcp *session =3D user_data;
> -       struct avrcp_player *player =3D session->player;
> -       struct avrcp_header *pdu;
> -       struct register_notification_rsp *rsp;
> -       uint8_t event =3D 0;
> -       uint16_t value16, value16_2[2];
> -       uint32_t value32;
> -       uint64_t value64;
> -       uint8_t *params =3D NULL;
> -       int err;
> -
> -       DBG("");
> -
> -       if (!player || !player->cfm || !player->cfm->register_notificatio=
n)
> -               return FALSE;
> -
> -       pdu =3D parse_pdu(operands, operand_count);
> -       if (!pdu) {
> -               err =3D -EPROTO;
> -               goto done;
> -       }
> -
> -       if (code =3D=3D AVC_CTYPE_REJECTED) {
> -               err =3D parse_status(pdu);
> -               goto done;
> -       }
> -
> -       if (pdu->params_len < sizeof(*rsp)) {
> -               err =3D -EPROTO;
> -               goto done;
> -       }
> -
> -       rsp =3D (void *) pdu->params;
> -       event =3D rsp->event;
> -
> -       if (event > AVRCP_EVENT_LAST) {
> -               err =3D -EPROTO;
> -               goto done;
> -       }
> -
> -       switch (event) {
> -       case AVRCP_EVENT_STATUS_CHANGED:
> -               if (pdu->params_len !=3D sizeof(*rsp) + sizeof(uint8_t)) =
{
> -                       err =3D -EPROTO;
> -                       goto done;
> -               }
> -               params =3D rsp->data;
> -               break;
> -       case AVRCP_EVENT_VOLUME_CHANGED:
> -               if (pdu->params_len !=3D sizeof(*rsp) + sizeof(uint8_t)) =
{
> -                       err =3D -EPROTO;
> -                       goto done;
> -               }
> -               params =3D rsp->data;
> -               params[0] &=3D 0x7f;
> -               break;
> -       case AVRCP_EVENT_TRACK_CHANGED:
> -               if (pdu->params_len !=3D sizeof(*rsp) + sizeof(value64)) =
{
> -                       err =3D -EPROTO;
> -                       goto done;
> -               }
> -               value64 =3D get_be64(rsp->data);
> -               params =3D (uint8_t *) &value64;
> -               break;
> -       case AVRCP_EVENT_PLAYBACK_POS_CHANGED:
> -               if (pdu->params_len !=3D sizeof(*rsp) + sizeof(value32)) =
{
> -                       err =3D -EPROTO;
> -                       goto done;
> -               }
> -               value32 =3D get_be32(rsp->data);
> -               params =3D (uint8_t *) &value32;
> -               break;
> -       case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
> -               if (pdu->params_len < sizeof(*rsp) + sizeof(value16_2)) {
> -                       err =3D -EPROTO;
> -                       goto done;
> -               }
> -               value16_2[0] =3D get_be16(rsp->data);
> -               value16_2[1] =3D get_be16(rsp->data + 2);
> -               params =3D (uint8_t *) value16_2;
> -               break;
> -       case AVRCP_EVENT_SETTINGS_CHANGED:
> -               if (pdu->params_len < sizeof(*rsp) + sizeof(uint8_t)) {
> -                       err =3D -EPROTO;
> -                       goto done;
> -               }
> -               params =3D rsp->data;
> -               break;
> -       case AVRCP_EVENT_UIDS_CHANGED:
> -               if (pdu->params_len < sizeof(*rsp) + sizeof(value16)) {
> -                       err =3D -EPROTO;
> -                       goto done;
> -               }
> -               value16 =3D get_be16(rsp->data);
> -               params =3D (uint8_t *) &value16;
> -               break;
> -       }
> -
> -       err =3D 0;
> -
> -done:
> -       return player->cfm->register_notification(session, err, code, eve=
nt,
> -                                               params, player->user_data=
);
> -}
> -
> -int avrcp_register_notification(struct avrcp *session, uint8_t event,
> -                                                       uint32_t interval=
)
> -{
> -       struct iovec iov;
> -       struct register_notification_req req;
> -
> -       if (event > AVRCP_EVENT_LAST)
> -               return -EINVAL;
> -
> -       req.event =3D event;
> -       req.interval =3D cpu_to_be32(interval);
> -
> -       iov.iov_base =3D &req;
> -       iov.iov_len =3D sizeof(req);
> -
> -       return avrcp_send_req(session, AVC_CTYPE_NOTIFY, AVC_SUBUNIT_PANE=
L,
> -                               AVRCP_REGISTER_NOTIFICATION, &iov, 1,
> -                               register_notification_rsp, session);
> -}
> -
> -static gboolean list_attributes_rsp(struct avctp *conn,
> -                                       uint8_t code, uint8_t subunit,
> -                                       uint8_t *operands, size_t operand=
_count,
> -                                       void *user_data)
> -{
> -       struct avrcp *session =3D user_data;
> -       struct avrcp_player *player =3D session->player;
> -       struct avrcp_header *pdu =3D (void *) operands;
> -       struct list_attributes_rsp *rsp;
> -       uint8_t number =3D 0;
> -       uint8_t *attrs =3D NULL;
> -       int err;
> -
> -       DBG("");
> -
> -       if (!player || !player->cfm || !player->cfm->list_attributes)
> -               return FALSE;
> -
> -       pdu =3D parse_pdu(operands, operand_count);
> -       if (!pdu) {
> -               err =3D -EPROTO;
> -               goto done;
> -       }
> -
> -       if (code =3D=3D AVC_CTYPE_REJECTED) {
> -               err =3D parse_status(pdu);
> -               goto done;
> -       }
> -
> -       rsp =3D (void *) pdu->params;
> -
> -       if (pdu->params_len < sizeof(*rsp)) {
> -               err =3D -EPROTO;
> -               goto done;
> -       }
> -
> -       number =3D rsp->number;
> -       if (number > 0)
> -               attrs =3D rsp->params;
> -
> -       err =3D 0;
> -
> -done:
> -       player->cfm->list_attributes(session, err, number, attrs,
> -                                                       player->user_data=
);
> -
> -       return FALSE;
> -}
> -
> -int avrcp_list_player_attributes(struct avrcp *session)
> -{
> -       return avrcp_send_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANE=
L,
> -                               AVRCP_LIST_PLAYER_ATTRIBUTES, NULL, 0,
> -                               list_attributes_rsp, session);
> -}
> -
> -static int parse_text_rsp(struct avrcp_header *pdu, uint8_t *number,
> -                                       uint8_t *attrs, char **text)
> -{
> -       uint8_t *ptr;
> -       uint16_t params_len;
> -       int i;
> -
> -       if (pdu->params_len < 1)
> -               return -EPROTO;
> -
> -       *number =3D pdu->params[0];
> -       if (*number > AVRCP_ATTRIBUTE_LAST) {
> -               *number =3D 0;
> -               return -EPROTO;
> -       }
> -
> -       params_len =3D pdu->params_len - 1;
> -       for (i =3D 0, ptr =3D &pdu->params[1]; i < *number && params_len =
> 0; i++) {
> -               struct text_value *val;
> -
> -               if (params_len < sizeof(*val))
> -                       goto fail;
> -
> -               val =3D (void *) ptr;
> -
> -               attrs[i] =3D val->attr;
> -
> -               params_len -=3D sizeof(*val);
> -               ptr +=3D sizeof(*val);
> -
> -               if (val->len > params_len)
> -                       goto fail;
> -
> -               if (val->len > 0) {
> -                       text[i] =3D g_strndup(val->data, val->len);
> -                       params_len -=3D val->len;
> -                       ptr +=3D val->len;
> -               }
> -       }
> -
> -       if (i !=3D *number)
> -               goto fail;
> -
> -       return 0;
> -
> -fail:
> -       for (i -=3D 1; i >=3D 0; i--)
> -               g_free(text[i]);
> -
> -       *number =3D 0;
> -
> -       return -EPROTO;
> -}
> -
> -static gboolean get_attribute_text_rsp(struct avctp *conn,
> -                                       uint8_t code, uint8_t subunit,
> -                                       uint8_t *operands, size_t operand=
_count,
> -                                       void *user_data)
> -{
> -       struct avrcp *session =3D user_data;
> -       struct avrcp_player *player =3D session->player;
> -       struct avrcp_header *pdu;
> -       uint8_t number =3D 0;
> -       uint8_t attrs[AVRCP_ATTRIBUTE_LAST];
> -       char *text[AVRCP_ATTRIBUTE_LAST];
> -       int err;
> -
> -       DBG("");
> -
> -       if (!player || !player->cfm || !player->cfm->get_attribute_text)
> -               return FALSE;
> -
> -       pdu =3D parse_pdu(operands, operand_count);
> -       if (!pdu) {
> -               err =3D -EPROTO;
> -               goto done;
> -       }
> -
> -       if (code =3D=3D AVC_CTYPE_REJECTED) {
> -               err =3D parse_status(pdu);
> -               goto done;
> -       }
> -
> -       err =3D parse_text_rsp(pdu, &number, attrs, text);
> -
> -done:
> -       player->cfm->get_attribute_text(session, err, number, attrs, text=
,
> -                                                       player->user_data=
);
> -
> -       return FALSE;
> -}
> -
> -int avrcp_get_player_attribute_text(struct avrcp *session, uint8_t numbe=
r,
> -                                                               uint8_t *=
attrs)
> -{
> -       struct iovec iov[2];
> -
> -       if (!number || number > AVRCP_ATTRIBUTE_LAST)
> -               return -EINVAL;
> -
> -       iov[0].iov_base =3D &number;
> -       iov[0].iov_len =3D sizeof(number);
> -
> -       iov[1].iov_base =3D attrs;
> -       iov[1].iov_len =3D number;
> -
> -       return avrcp_send_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANE=
L,
> -                               AVRCP_GET_PLAYER_ATTRIBUTE_TEXT, iov, 2,
> -                               get_attribute_text_rsp, session);
> -}
> -
> -static gboolean list_values_rsp(struct avctp *conn,
> -                                       uint8_t code, uint8_t subunit,
> -                                       uint8_t *operands, size_t operand=
_count,
> -                                       void *user_data)
> -{
> -       struct avrcp *session =3D user_data;
> -       struct avrcp_player *player =3D session->player;
> -       struct avrcp_header *pdu;
> -       struct list_values_rsp *rsp;
> -       uint8_t number =3D 0;
> -       uint8_t *values =3D NULL;
> -       int err;
> -
> -       DBG("");
> -
> -       if (!player || !player->cfm || !player->cfm->list_values)
> -               return FALSE;
> -
> -       pdu =3D parse_pdu(operands, operand_count);
> -       if (!pdu) {
> -               err =3D -EPROTO;
> -               goto done;
> -       }
> -
> -       if (code =3D=3D AVC_CTYPE_REJECTED) {
> -               err =3D parse_status(pdu);
> -               goto done;
> -       }
> -
> -       if (pdu->params_len < sizeof(*rsp)) {
> -               err =3D -EPROTO;
> -               goto done;
> -       }
> -
> -       rsp =3D (void *) pdu->params;
> -
> -       if (rsp->number > 0) {
> -               number =3D rsp->number;
> -               values =3D rsp->params;
> -       }
> -
> -       err =3D 0;
> -
> -done:
> -       player->cfm->list_values(session, err, number, values,
> -                                                       player->user_data=
);
> -
> -       return FALSE;
> -}
> -
> -int avrcp_list_player_values(struct avrcp *session, uint8_t attr)
> -{
> -       struct iovec iov;
> -
> -       iov.iov_base =3D &attr;
> -       iov.iov_len =3D sizeof(attr);
> -
> -       return avrcp_send_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANE=
L,
> -                                       AVRCP_LIST_PLAYER_VALUES, &iov, 1=
,
> -                                       list_values_rsp, session);
> -}
> -
> -static gboolean get_value_text_rsp(struct avctp *conn,
> -                                       uint8_t code, uint8_t subunit,
> -                                       uint8_t *operands, size_t operand=
_count,
> -                                       void *user_data)
> -{
> -       struct avrcp *session =3D user_data;
> -       struct avrcp_player *player =3D session->player;
> -       struct avrcp_header *pdu;
> -       uint8_t number =3D 0;
> -       uint8_t values[AVRCP_ATTRIBUTE_LAST];
> -       char *text[AVRCP_ATTRIBUTE_LAST];
> -       int err;
> -
> -       DBG("");
> -
> -       if (!player || !player->cfm || !player->cfm->get_value_text)
> -               return FALSE;
> -
> -       pdu =3D parse_pdu(operands, operand_count);
> -       if (!pdu) {
> -               err =3D -EPROTO;
> -               goto done;
> -       }
> -
> -       if (code =3D=3D AVC_CTYPE_REJECTED) {
> -               err =3D parse_status(pdu);
> -               goto done;
> -       }
> -
> -       err =3D parse_text_rsp(pdu, &number, values, text);
> -
> -done:
> -       player->cfm->get_value_text(session, err, number, values, text,
> -                                                       player->user_data=
);
> -
> -       return FALSE;
> -}
> -
> -int avrcp_get_player_value_text(struct avrcp *session, uint8_t attr,
> -                                       uint8_t number, uint8_t *values)
> -{
> -       struct iovec iov[2];
> -       struct get_value_text_req req;
> -
> -       if (!number)
> -               return -EINVAL;
> -
> -       req.attr =3D attr;
> -       req.number =3D number;
> -
> -       iov[0].iov_base =3D &req;
> -       iov[0].iov_len =3D sizeof(req);
> -
> -       iov[1].iov_base =3D values;
> -       iov[1].iov_len =3D number;
> -
> -       return avrcp_send_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANE=
L,
> -                                       AVRCP_GET_PLAYER_VALUE_TEXT, iov,=
 2,
> -                                       get_value_text_rsp, session);
> -}
> -
> -static int parse_value(struct avrcp_header *pdu, uint8_t *number,
> -                                       uint8_t *attrs, uint8_t *values)
> -{
> -       int i;
> -       struct value_rsp *rsp;
> -
> -       if (pdu->params_len < sizeof(*rsp))
> -               return -EPROTO;
> -
> -       rsp =3D (void *) pdu->params;
> -
> -       /*
> -        * Check if PDU is big enough to hold the number of (attribute, v=
alue)
> -        * tuples.
> -        */
> -       if (rsp->number > AVRCP_ATTRIBUTE_LAST ||
> -                       sizeof(*rsp) + rsp->number * 2 !=3D pdu->params_l=
en) {
> -               *number =3D 0;
> -               return -EPROTO;
> -       }
> -
> -       for (i =3D 0; i < rsp->number; i++) {
> -               attrs[i] =3D rsp->values[i].attr;
> -               values[i] =3D rsp->values[i].value;
> -       }
> -
> -       *number =3D rsp->number;
> -
> -       return 0;
> -}
> -
> -static gboolean get_value_rsp(struct avctp *conn,
> -                                       uint8_t code, uint8_t subunit,
> -                                       uint8_t *operands, size_t operand=
_count,
> -                                       void *user_data)
> -{
> -       struct avrcp *session =3D user_data;
> -       struct avrcp_player *player =3D session->player;
> -       struct avrcp_header *pdu;
> -       uint8_t number =3D 0;
> -       uint8_t attrs[AVRCP_ATTRIBUTE_LAST];
> -       uint8_t values[AVRCP_ATTRIBUTE_LAST];
> -       int err;
> -
> -       DBG("");
> -
> -       if (!player || !player->cfm || !player->cfm->get_value)
> -               return FALSE;
> -
> -       pdu =3D parse_pdu(operands, operand_count);
> -       if (!pdu) {
> -               err =3D -EPROTO;
> -               goto done;
> -       }
> -
> -       if (code =3D=3D AVC_CTYPE_REJECTED) {
> -               err =3D parse_status(pdu);
> -               goto done;
> -       }
> -
> -       err =3D parse_value(pdu, &number, attrs, values);
> -
> -done:
> -       player->cfm->get_value(session, err, number, attrs, values,
> -                                                       player->user_data=
);
> -
> -       return FALSE;
> -}
> -
> -int avrcp_get_current_player_value(struct avrcp *session, uint8_t number=
,
> -                                                       uint8_t *attrs)
> -
> -{
> -       struct iovec iov[2];
> -
> -       if (number > AVRCP_ATTRIBUTE_LAST)
> -               return -EINVAL;
> -
> -       iov[0].iov_base =3D &number;
> -       iov[0].iov_len =3D sizeof(number);
> -
> -       iov[1].iov_base =3D attrs;
> -       iov[1].iov_len =3D number;
> -
> -       return avrcp_send_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANE=
L,
> -                               AVRCP_GET_CURRENT_PLAYER_VALUE, iov, 2,
> -                               get_value_rsp, session);
> -}
> -
> -static gboolean set_value_rsp(struct avctp *conn,
> -                                       uint8_t code, uint8_t subunit,
> -                                       uint8_t *operands, size_t operand=
_count,
> -                                       void *user_data)
> -{
> -       struct avrcp *session =3D user_data;
> -       struct avrcp_player *player =3D session->player;
> -       struct avrcp_header *pdu;
> -       int err;
> -
> -       DBG("");
> -
> -       if (!player || !player->cfm || !player->cfm->set_value)
> -               return FALSE;
> -
> -       pdu =3D parse_pdu(operands, operand_count);
> -       if (!pdu) {
> -               err =3D -EPROTO;
> -               goto done;
> -       }
> -
> -       if (code =3D=3D AVC_CTYPE_REJECTED) {
> -               err =3D parse_status(pdu);
> -               goto done;
> -       }
> -
> -       err =3D 0;
> -
> -done:
> -       player->cfm->set_value(session, err, player->user_data);
> -
> -       return FALSE;
> -}
> -
> -int avrcp_set_player_value(struct avrcp *session, uint8_t number,
> -                                       uint8_t *attrs, uint8_t *values)
> -{
> -       struct iovec iov[2];
> -       struct attr_value val[AVRCP_ATTRIBUTE_LAST];
> -       int i;
> -
> -       if (number > AVRCP_ATTRIBUTE_LAST)
> -               return -EINVAL;
> -
> -       iov[0].iov_base =3D &number;
> -       iov[0].iov_len =3D sizeof(number);
> -
> -       for (i =3D 0; i < number; i++) {
> -               val[i].attr =3D attrs[i];
> -               val[i].value =3D values[i];
> -       }
> -
> -       iov[1].iov_base =3D val;
> -       iov[1].iov_len =3D sizeof(*val) * number;
> -
> -       return avrcp_send_req(session, AVC_CTYPE_CONTROL, AVC_SUBUNIT_PAN=
EL,
> -                                       AVRCP_SET_PLAYER_VALUE, iov, 2,
> -                                       set_value_rsp, session);
> -}
> -
> -static gboolean get_play_status_rsp(struct avctp *conn,
> -                                       uint8_t code, uint8_t subunit,
> -                                       uint8_t *operands, size_t operand=
_count,
> -                                       void *user_data)
> -{
> -       struct avrcp *session =3D user_data;
> -       struct avrcp_player *player =3D session->player;
> -       struct avrcp_header *pdu;
> -       struct get_play_status_rsp *rsp;
> -       uint8_t status =3D 0;
> -       uint32_t position =3D 0;
> -       uint32_t duration =3D 0;
> -       int err;
> -
> -       DBG("");
> -
> -       if (!player || !player->cfm || !player->cfm->get_play_status)
> -               return FALSE;
> -
> -       pdu =3D parse_pdu(operands, operand_count);
> -       if (!pdu) {
> -               err =3D -EPROTO;
> -               goto done;
> -       }
> -
> -       if (code =3D=3D AVC_CTYPE_REJECTED) {
> -               err =3D parse_status(pdu);
> -               goto done;
> -       }
> -
> -       if (pdu->params_len < sizeof(*rsp)) {
> -               err =3D -EPROTO;
> -               goto done;
> -       }
> -
> -       rsp =3D (void *) pdu->params;
> -
> -       duration =3D be32_to_cpu(rsp->duration);
> -       position =3D be32_to_cpu(rsp->position);
> -       status =3D rsp->status;
> -       err =3D 0;
> -
> -done:
> -       player->cfm->get_play_status(session, err, status, position, dura=
tion,
> -                                                       player->user_data=
);
> -
> -       return FALSE;
> -}
> -
> -int avrcp_get_play_status(struct avrcp *session)
> -{
> -       return avrcp_send_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANE=
L,
> -                               AVRCP_GET_PLAY_STATUS, NULL, 0,
> -                               get_play_status_rsp, session);
> -}
> -
> -static gboolean set_volume_rsp(struct avctp *conn,
> -                                       uint8_t code, uint8_t subunit,
> -                                       uint8_t *operands, size_t operand=
_count,
> -                                       void *user_data)
> -{
> -       struct avrcp *session =3D user_data;
> -       struct avrcp_player *player =3D session->player;
> -       struct avrcp_header *pdu;
> -       struct set_volume_rsp *rsp;
> -       uint8_t value =3D 0;
> -       int err;
> -
> -       DBG("");
> -
> -       if (!player || !player->cfm || !player->cfm->set_volume)
> -               return FALSE;
> -
> -       pdu =3D parse_pdu(operands, operand_count);
> -       if (!pdu) {
> -               err =3D -EPROTO;
> -               goto done;
> -       }
> -
> -       if (code =3D=3D AVC_CTYPE_REJECTED) {
> -               err =3D parse_status(pdu);
> -               goto done;
> -       }
> -
> -       if (pdu->params_len < sizeof(*rsp)) {
> -               err =3D -EPROTO;
> -               goto done;
> -       }
> -
> -       rsp =3D (void *) pdu->params;
> -
> -       value =3D rsp->value & 0x7f;
> -       err =3D 0;
> -
> -done:
> -       player->cfm->set_volume(session, err, value, player->user_data);
> -
> -       return FALSE;
> -}
> -
> -int avrcp_set_volume(struct avrcp *session, uint8_t volume)
> -{
> -       struct iovec iov;
> -
> -       iov.iov_base =3D &volume;
> -       iov.iov_len =3D sizeof(volume);
> -
> -       return avrcp_send_req(session, AVC_CTYPE_CONTROL, AVC_SUBUNIT_PAN=
EL,
> -                               AVRCP_SET_ABSOLUTE_VOLUME, &iov, 1,
> -                               set_volume_rsp, session);
> -}
> -
> -static int parse_attribute_list(uint8_t *params, uint16_t params_len,
> -                               uint8_t number, uint32_t *attrs, char **t=
ext)
> -{
> -       struct media_item *item;
> -       int i;
> -
> -       if (number > AVRCP_MEDIA_ATTRIBUTE_LAST)
> -               return -EPROTO;
> -
> -       for (i =3D 0; i < number && params_len >=3D sizeof(*item); i++) {
> -               item =3D (void *) params;
> -
> -               item->attr =3D be32_to_cpu(item->attr);
> -               item->charset =3D be16_to_cpu(item->charset);
> -               item->len =3D be16_to_cpu(item->len);
> -
> -               params_len -=3D sizeof(*item);
> -               params +=3D sizeof(*item);
> -               if (item->len > params_len)
> -                       goto fail;
> -
> -               if (item->len > 0) {
> -                       text[i] =3D g_strndup(item->data, item->len);
> -                       attrs[i] =3D item->attr;
> -                       params_len -=3D item->len;
> -                       params +=3D item->len;
> -               } else {
> -                       text[i] =3D NULL;
> -                       attrs[i] =3D 0;
> -               }
> -       }
> -
> -       return 0;
> -
> -fail:
> -       for (i -=3D 1; i >=3D 0; i--)
> -               g_free(text[i]);
> -
> -       return -EPROTO;
> -}
> -
> -static void free_attribute_list(uint8_t number, char **text)
> -{
> -       while(number--)
> -               g_free(text[number]);
> -}
> -
> -static int parse_elements(struct avrcp_header *pdu, uint8_t *number,
> -                                               uint32_t *attrs, char **t=
ext)
> -{
> -       struct get_element_attributes_rsp *rsp;
> -
> -       if (pdu->params_len < sizeof(*rsp))
> -               return -EPROTO;
> -
> -       rsp =3D (void *) pdu->params;
> -       if (rsp->number > AVRCP_MEDIA_ATTRIBUTE_LAST)
> -               return -EPROTO;
> -
> -       *number =3D rsp->number;
> -
> -       return parse_attribute_list(pdu->params + sizeof(*rsp),
> -                                               pdu->params_len - sizeof(=
*rsp),
> -                                               *number, attrs, text);
> -}
> -
> -static int parse_items(struct avrcp_browsing_header *pdu, uint8_t *numbe=
r,
> -                                               uint32_t *attrs, char **t=
ext)
> -{
> -       struct get_item_attributes_rsp *rsp;
> -
> -       if (pdu->params_len < sizeof(*rsp))
> -               return -EPROTO;
> -
> -       rsp =3D (void *) pdu->params;
> -
> -       if (rsp->number > AVRCP_MEDIA_ATTRIBUTE_LAST)
> -               return -EPROTO;
> -
> -       *number =3D rsp->number;
> -
> -       return parse_attribute_list(pdu->params + sizeof(*rsp),
> -                                               pdu->params_len - sizeof(=
*rsp),
> -                                               *number, attrs, text);
> -}
> -
> -static gboolean get_element_attributes_rsp(struct avctp *conn,
> -                                       uint8_t code, uint8_t subunit,
> -                                       uint8_t *operands, size_t operand=
_count,
> -                                       void *user_data)
> -{
> -       struct avrcp *session =3D user_data;
> -       struct avrcp_player *player =3D session->player;
> -       struct avrcp_header *pdu;
> -       uint8_t number =3D 0;
> -       uint32_t attrs[AVRCP_MEDIA_ATTRIBUTE_LAST];
> -       char *text[AVRCP_MEDIA_ATTRIBUTE_LAST];
> -       int err;
> -
> -       DBG("");
> -
> -       if (!player || !player->cfm || !player->cfm->get_element_attribut=
es)
> -               return FALSE;
> -
> -       pdu =3D parse_pdu(operands, operand_count);
> -       if (!pdu) {
> -               err =3D -EPROTO;
> -               goto done;
> -       }
> -
> -       if (code =3D=3D AVC_CTYPE_REJECTED) {
> -               err =3D parse_status(pdu);
> -               goto done;
> -       }
> -
> -       err =3D parse_elements(pdu, &number, attrs, text);
> -
> -done:
> -       player->cfm->get_element_attributes(session, err, number, attrs, =
text,
> -                                                       player->user_data=
);
> -
> -       if (err =3D=3D 0)
> -               free_attribute_list(number, text);
> -
> -       return FALSE;
> -}
> -
> -int avrcp_get_element_attributes(struct avrcp *session)
> -{
> -       struct iovec iov;
> -       struct get_element_attributes_req req;
> -
> -       /* This returns all attributes */
> -       memset(&req, 0, sizeof(req));
> -
> -       iov.iov_base =3D &req;
> -       iov.iov_len =3D sizeof(req);
> -
> -       return avrcp_send_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANE=
L,
> -                               AVRCP_GET_ELEMENT_ATTRIBUTES, &iov, 1,
> -                               get_element_attributes_rsp, session);
> -}
> -
> -static gboolean set_addressed_rsp(struct avctp *conn,
> -                                       uint8_t code, uint8_t subunit,
> -                                       uint8_t *operands, size_t operand=
_count,
> -                                       void *user_data)
> -{
> -       struct avrcp *session =3D user_data;
> -       struct avrcp_player *player =3D session->player;
> -       struct avrcp_header *pdu;
> -       int err;
> -
> -       DBG("");
> -
> -       if (!player || !player->cfm || !player->cfm->set_addressed)
> -               return FALSE;
> -
> -       pdu =3D parse_pdu(operands, operand_count);
> -       if (!pdu) {
> -               err =3D -EPROTO;
> -               goto done;
> -       }
> -
> -       err =3D parse_status(pdu);
> -
> -done:
> -       player->cfm->set_addressed(session, err, player->user_data);
> -
> -       return FALSE;
> -}
> -
> -int avrcp_set_addressed_player(struct avrcp *session, uint16_t player_id=
)
> -{
> -       struct iovec iov;
> -       struct set_addressed_req req;
> -
> -       req.id =3D cpu_to_be16(player_id);
> -
> -       iov.iov_base =3D &req;
> -       iov.iov_len =3D sizeof(req);
> -
> -       return avrcp_send_req(session, AVC_CTYPE_CONTROL, AVC_SUBUNIT_PAN=
EL,
> -                                       AVRCP_SET_ADDRESSED_PLAYER, &iov,=
 1,
> -                                       set_addressed_rsp, session);
> -}
> -
> -static char *parse_folder_list(uint8_t *params, uint16_t params_len,
> -                                                               uint8_t d=
epth)
> -{
> -       char **folders, *path;
> -       uint8_t count;
> -       size_t i;
> -
> -       folders =3D g_new0(char *, depth + 2);
> -       folders[0] =3D g_strdup("/Filesystem");
> -
> -       for (i =3D 0, count =3D 1; count <=3D depth && i < params_len; co=
unt++) {
> -               uint8_t len;
> -
> -               len =3D params[i++];
> -
> -               if (i + len > params_len || len =3D=3D 0) {
> -                       g_strfreev(folders);
> -                       return NULL;
> -               }
> -
> -               folders[count] =3D util_memdup(&params[i], len);
> -               i +=3D len;
> -       }
> -
> -       path =3D g_build_pathv("/", folders);
> -       g_strfreev(folders);
> -
> -       return path;
> -}
> -
> -static gboolean set_browsed_rsp(struct avctp *conn, uint8_t *operands,
> -                                       size_t operand_count, void *user_=
data)
> -{
> -       struct avrcp *session =3D user_data;
> -       struct avrcp_player *player =3D session->player;
> -       struct avrcp_browsing_header *pdu;
> -       struct set_browsed_rsp *rsp;
> -       uint16_t counter =3D 0;
> -       uint32_t items =3D 0;
> -       char *path =3D NULL;
> -       int err;
> -
> -       DBG("");
> -
> -       if (!player || !player->cfm || !player->cfm->set_browsed)
> -               return FALSE;
> -
> -       pdu =3D parse_browsing_pdu(operands, operand_count);
> -       if (!pdu) {
> -               err =3D -EPROTO;
> -               goto done;
> -       }
> -
> -       err =3D parse_browsing_status(pdu);
> -       if (err < 0)
> -               goto done;
> -
> -       if (pdu->params_len < sizeof(*rsp)) {
> -               err =3D -EPROTO;
> -               goto done;
> -       }
> -
> -       rsp =3D (void *) pdu->params;
> -
> -       counter =3D be16_to_cpu(rsp->counter);
> -       items =3D be32_to_cpu(rsp->items);
> -
> -       path =3D parse_folder_list(rsp->data, pdu->params_len - sizeof(*r=
sp),
> -                                                               rsp->dept=
h);
> -       if (!path)
> -               err =3D -EPROTO;
> -
> -done:
> -       player->cfm->set_browsed(session, err, counter, items, path,
> -                                                       player->user_data=
);
> -
> -       return FALSE;
> -}
> -
> -int avrcp_set_browsed_player(struct avrcp *session, uint16_t player_id)
> -{
> -       struct iovec iov;
> -       struct set_browsed_req req;
> -
> -       req.id =3D cpu_to_be16(player_id);
> -
> -       iov.iov_base =3D &req;
> -       iov.iov_len =3D sizeof(req);
> -
> -       return avrcp_send_browsing_req(session, AVRCP_SET_BROWSED_PLAYER,
> -                                       &iov, 1, set_browsed_rsp, session=
);
> -}
> -
> -static gboolean get_folder_items_rsp(struct avctp *conn,
> -                                       uint8_t *operands, size_t operand=
_count,
> -                                       void *user_data)
> -{
> -       struct avrcp *session =3D user_data;
> -       struct avrcp_player *player =3D session->player;
> -       struct avrcp_browsing_header *pdu;
> -       struct get_folder_items_rsp *rsp;
> -       uint16_t counter =3D 0, number =3D 0;
> -       uint8_t *params =3D NULL;
> -       int err;
> -
> -       DBG("");
> -
> -       if (!player || !player->cfm || !player->cfm->get_folder_items)
> -               return FALSE;
> -
> -       pdu =3D parse_browsing_pdu(operands, operand_count);
> -       if (!pdu) {
> -               err =3D -EPROTO;
> -               goto done;
> -       }
> -
> -       err =3D parse_browsing_status(pdu);
> -       if (err < 0)
> -               goto done;
> -
> -       if (pdu->params_len < sizeof(*rsp)) {
> -               err =3D -EPROTO;
> -               goto done;
> -       }
> -
> -       rsp =3D (void *) pdu->params;
> -
> -       counter =3D be16_to_cpu(rsp->counter);
> -       number =3D be16_to_cpu(rsp->number);
> -       params =3D rsp->data;
> -
> -       /* FIXME: Add proper parsing for each item type */
> -
> -done:
> -       player->cfm->get_folder_items(session, err, counter, number, para=
ms,
> -                                                       player->user_data=
);
> -
> -       return FALSE;
> -}
> -
> -int avrcp_get_folder_items(struct avrcp *session, uint8_t scope,
> -                               uint32_t start, uint32_t end, uint8_t num=
ber,
> -                               uint32_t *attrs)
> -{
> -
> -       struct iovec iov[2];
> -       struct get_folder_items_req req;
> -       int i;
> -
> -       req.scope =3D scope;
> -       req.start =3D cpu_to_be32(start);
> -       req.end =3D cpu_to_be32(end);
> -       req.number =3D number;
> -
> -       iov[0].iov_base =3D &req;
> -       iov[0].iov_len =3D sizeof(req);
> -
> -       if (!number)
> -               return avrcp_send_browsing_req(session, AVRCP_GET_FOLDER_=
ITEMS,
> -                                               iov, 1, get_folder_items_=
rsp,
> -                                               session);
> -
> -       for (i =3D 0; i < number; i++)
> -               attrs[i] =3D cpu_to_be32(attrs[i]);
> -
> -       iov[1].iov_base =3D attrs;
> -       iov[1].iov_len =3D number * sizeof(*attrs);
> -
> -       return avrcp_send_browsing_req(session, AVRCP_GET_FOLDER_ITEMS,
> -                                       iov, 2, get_folder_items_rsp, ses=
sion);
> -}
> -
> -static gboolean change_path_rsp(struct avctp *conn, uint8_t *operands,
> -                                       size_t operand_count, void *user_=
data)
> -{
> -       struct avrcp *session =3D user_data;
> -       struct avrcp_player *player =3D session->player;
> -       struct avrcp_browsing_header *pdu;
> -       struct change_path_rsp *rsp;
> -       uint32_t items =3D 0;
> -       int err;
> -
> -       DBG("");
> -
> -       if (!player || !player->cfm || !player->cfm->change_path)
> -               return FALSE;
> -
> -       pdu =3D parse_browsing_pdu(operands, operand_count);
> -       if (!pdu) {
> -               err =3D -EPROTO;
> -               goto done;
> -       }
> -
> -       err =3D parse_browsing_status(pdu);
> -       if (err < 0)
> -               goto done;
> -
> -       if (pdu->params_len < sizeof(*rsp)) {
> -               err =3D -EPROTO;
> -               goto done;
> -       }
> -
> -       rsp =3D (void *) pdu->params;
> -
> -       items =3D be32_to_cpu(rsp->items);
> -
> -done:
> -       player->cfm->change_path(session, err, items, player->user_data);
> -
> -       return FALSE;
> -}
> -
> -int avrcp_change_path(struct avrcp *session, uint8_t direction, uint64_t=
 uid,
> -                                                       uint16_t counter)
> -{
> -       struct iovec iov;
> -       struct change_path_req req;
> -
> -       req.counter =3D cpu_to_be16(counter);
> -       req.direction =3D direction;
> -       req.uid =3D cpu_to_be64(uid);
> -
> -       iov.iov_base =3D &req;
> -       iov.iov_len =3D sizeof(req);
> -
> -       return avrcp_send_browsing_req(session, AVRCP_CHANGE_PATH,
> -                                       &iov, 1, change_path_rsp, session=
);
> -}
> -
> -static gboolean get_item_attributes_rsp(struct avctp *conn, uint8_t *ope=
rands,
> -                                       size_t operand_count, void *user_=
data)
> -{
> -       struct avrcp *session =3D user_data;
> -       struct avrcp_player *player =3D session->player;
> -       struct avrcp_browsing_header *pdu;
> -       uint8_t number =3D 0;
> -       uint32_t attrs[AVRCP_MEDIA_ATTRIBUTE_LAST];
> -       char *text[AVRCP_MEDIA_ATTRIBUTE_LAST];
> -       int err;
> -
> -       DBG("");
> -
> -       if (!player || !player->cfm || !player->cfm->get_item_attributes)
> -               return FALSE;
> -
> -       pdu =3D parse_browsing_pdu(operands, operand_count);
> -       if (!pdu) {
> -               err =3D -EPROTO;
> -               goto done;
> -       }
> -
> -       err =3D parse_browsing_status(pdu);
> -       if (err < 0)
> -               goto done;
> -
> -       err =3D parse_items(pdu, &number, attrs, text);
> -
> -done:
> -       player->cfm->get_item_attributes(session, err, number, attrs, tex=
t,
> -                                                       player->user_data=
);
> -
> -       if (err =3D=3D 0)
> -               free_attribute_list(number, text);
> -
> -       return FALSE;
> -}
> -
> -int avrcp_get_item_attributes(struct avrcp *session, uint8_t scope,
> -                               uint64_t uid, uint16_t counter, uint8_t n=
umber,
> -                               uint32_t *attrs)
> -{
> -       struct iovec iov[2];
> -       struct get_item_attributes_req req;
> -       int i;
> -
> -       req.scope =3D scope;
> -       req.uid =3D cpu_to_be64(uid);
> -       req.counter =3D cpu_to_be16(counter);
> -       req.number =3D number;
> -
> -       iov[0].iov_base =3D &req;
> -       iov[0].iov_len =3D sizeof(req);
> -
> -       if (!number)
> -               return avrcp_send_browsing_req(session,
> -                                               AVRCP_GET_ITEM_ATTRIBUTES=
,
> -                                               iov, 1, get_item_attribut=
es_rsp,
> -                                               session);
> -
> -       if (number > AVRCP_MEDIA_ATTRIBUTE_LAST)
> -               return -EINVAL;
> -
> -       for (i =3D 0; i < number; i++) {
> -               if (attrs[i] > AVRCP_MEDIA_ATTRIBUTE_LAST ||
> -                               attrs[i] =3D=3D AVRCP_MEDIA_ATTRIBUTE_ILL=
EGAL)
> -                       return -EINVAL;
> -               attrs[i] =3D cpu_to_be32(attrs[i]);
> -       }
> -
> -       iov[1].iov_base =3D attrs;
> -       iov[1].iov_len =3D number * sizeof(*attrs);
> -
> -       return avrcp_send_browsing_req(session, AVRCP_GET_ITEM_ATTRIBUTES=
,
> -                                       iov, 2, get_item_attributes_rsp,
> -                                       session);
> -}
> -
> -static gboolean play_item_rsp(struct avctp *conn, uint8_t *operands,
> -                                       size_t operand_count, void *user_=
data)
> -{
> -       struct avrcp *session =3D user_data;
> -       struct avrcp_player *player =3D session->player;
> -       struct avrcp_browsing_header *pdu;
> -       int err;
> -
> -       DBG("");
> -
> -       if (!player || !player->cfm || !player->cfm->play_item)
> -               return FALSE;
> -
> -       pdu =3D parse_browsing_pdu(operands, operand_count);
> -       if (!pdu) {
> -               err =3D -EPROTO;
> -               goto done;
> -       }
> -
> -       err =3D parse_browsing_status(pdu);
> -
> -done:
> -       player->cfm->play_item(session, err, player->user_data);
> -
> -       return FALSE;
> -}
> -
> -int avrcp_play_item(struct avrcp *session, uint8_t scope, uint64_t uid,
> -                                                       uint16_t counter)
> -{
> -       struct iovec iov;
> -       struct play_item_req req;
> -
> -       if (scope > AVRCP_MEDIA_NOW_PLAYING)
> -               return -EINVAL;
> -
> -       req.scope =3D scope;
> -       req.uid =3D cpu_to_be64(uid);
> -       req.counter =3D cpu_to_be16(counter);
> -
> -       iov.iov_base =3D &req;
> -       iov.iov_len =3D sizeof(req);
> -
> -       return avrcp_send_browsing_req(session, AVRCP_PLAY_ITEM, &iov, 1,
> -                                               play_item_rsp, session);
> -}
> -
> -static gboolean search_rsp(struct avctp *conn, uint8_t *operands,
> -                                       size_t operand_count, void *user_=
data)
> -{
> -       struct avrcp *session =3D user_data;
> -       struct avrcp_player *player =3D session->player;
> -       struct avrcp_browsing_header *pdu;
> -       struct search_rsp *rsp;
> -       uint16_t counter =3D 0;
> -       uint32_t items =3D 0;
> -       int err;
> -
> -       DBG("");
> -
> -       if (!player || !player->cfm || !player->cfm->search)
> -               return FALSE;
> -
> -       pdu =3D parse_browsing_pdu(operands, operand_count);
> -       if (!pdu) {
> -               err =3D -EPROTO;
> -               goto done;
> -       }
> -
> -       err =3D parse_browsing_status(pdu);
> -       if (err < 0)
> -               goto done;
> -
> -       if (pdu->params_len < sizeof(*rsp)) {
> -               err =3D -EPROTO;
> -               goto done;
> -       }
> -
> -       rsp =3D (void *) pdu->params;
> -
> -       counter =3D be16_to_cpu(rsp->counter);
> -       items =3D be32_to_cpu(rsp->items);
> -
> -       err =3D 0;
> -
> -done:
> -       player->cfm->search(session, err, counter, items, player->user_da=
ta);
> -
> -       return FALSE;
> -}
> -
> -int avrcp_search(struct avrcp *session, const char *string)
> -{
> -       struct iovec iov[2];
> -       struct search_req req;
> -       size_t len;
> -
> -       if (!string)
> -               return -EINVAL;
> -
> -       len =3D strnlen(string, UINT8_MAX);
> -
> -       req.charset =3D cpu_to_be16(AVRCP_CHARSET_UTF8);
> -       req.len =3D cpu_to_be16(len);
> -
> -       iov[0].iov_base =3D &req;
> -       iov[0].iov_len =3D sizeof(req);
> -
> -       iov[1].iov_base =3D (void *) string;
> -       iov[1].iov_len =3D len;
> -
> -       return avrcp_send_browsing_req(session, AVRCP_SEARCH, iov, 2,
> -                                                       search_rsp, sessi=
on);
> -}
> -
> -static gboolean add_to_now_playing_rsp(struct avctp *conn, uint8_t *oper=
ands,
> -                                       size_t operand_count, void *user_=
data)
> -{
> -       struct avrcp *session =3D user_data;
> -       struct avrcp_player *player =3D session->player;
> -       struct avrcp_browsing_header *pdu;
> -       int err;
> -
> -       DBG("");
> -
> -       if (!player || !player->cfm || !player->cfm->add_to_now_playing)
> -               return FALSE;
> -
> -       pdu =3D parse_browsing_pdu(operands, operand_count);
> -       if (!pdu) {
> -               err =3D -EPROTO;
> -               goto done;
> -       }
> -
> -       err =3D parse_browsing_status(pdu);
> -
> -done:
> -       player->cfm->add_to_now_playing(session, err, player->user_data);
> -
> -       return FALSE;
> -}
> -
> -int avrcp_add_to_now_playing(struct avrcp *session, uint8_t scope, uint6=
4_t uid,
> -                                                       uint16_t counter)
> -{
> -       struct iovec iov;
> -       struct add_to_now_playing_req req;
> -
> -       if (scope > AVRCP_MEDIA_NOW_PLAYING)
> -               return -EINVAL;
> -
> -       req.scope =3D scope;
> -       req.uid =3D cpu_to_be64(uid);
> -       req.counter =3D cpu_to_be16(counter);
> -
> -       iov.iov_base =3D &req;
> -       iov.iov_len =3D sizeof(req);
> -
> -       return avrcp_send_browsing_req(session, AVRCP_ADD_TO_NOW_PLAYING,
> -                                       &iov, 1, add_to_now_playing_rsp,
> -                                       session);
> -}
> -
> -int avrcp_get_capabilities_rsp(struct avrcp *session, uint8_t transactio=
n,
> -                                               uint8_t number, uint8_t *=
events)
> -{
> -       struct iovec iov[2];
> -       struct get_capabilities_rsp rsp;
> -
> -       if (number > AVRCP_EVENT_LAST)
> -               return -EINVAL;
> -
> -       rsp.cap =3D CAP_EVENTS_SUPPORTED;
> -       rsp.number =3D number;
> -
> -       iov[0].iov_base =3D &rsp;
> -       iov[0].iov_len =3D sizeof(rsp);
> -
> -       iov[1].iov_base =3D events;
> -       iov[1].iov_len =3D number;
> -
> -       return avrcp_send(session, transaction, AVC_CTYPE_STABLE,
> -                               AVC_SUBUNIT_PANEL, AVRCP_GET_CAPABILITIES=
,
> -                               iov, 2);
> -}
> -
> -int avrcp_list_player_attributes_rsp(struct avrcp *session, uint8_t tran=
saction,
> -                                       uint8_t number, uint8_t *attrs)
> -{
> -       struct iovec iov[2];
> -       struct list_attributes_rsp rsp;
> -
> -       if (number > AVRCP_ATTRIBUTE_LAST)
> -               return -EINVAL;
> -
> -       rsp.number =3D number;
> -
> -       iov[0].iov_base =3D &rsp;
> -       iov[0].iov_len =3D sizeof(rsp);
> -
> -       if (!number)
> -               return avrcp_send(session, transaction, AVC_CTYPE_STABLE,
> -                               AVC_SUBUNIT_PANEL, AVRCP_LIST_PLAYER_ATTR=
IBUTES,
> -                               iov, 1);
> -
> -       iov[1].iov_base =3D attrs;
> -       iov[1].iov_len =3D number;
> -
> -       return avrcp_send(session, transaction, AVC_CTYPE_STABLE,
> -                               AVC_SUBUNIT_PANEL, AVRCP_LIST_PLAYER_ATTR=
IBUTES,
> -                               iov, 2);
> -}
> -
> -int avrcp_get_player_attribute_text_rsp(struct avrcp *session,
> -                                       uint8_t transaction, uint8_t numb=
er,
> -                                       uint8_t *attrs, const char **text=
)
> -{
> -       struct iovec iov[1 + AVRCP_ATTRIBUTE_LAST * 2];
> -       struct text_value val[AVRCP_ATTRIBUTE_LAST];
> -       int i;
> -
> -       if (number > AVRCP_ATTRIBUTE_LAST)
> -               return -EINVAL;
> -
> -       iov[0].iov_base =3D &number;
> -       iov[0].iov_len =3D sizeof(number);
> -
> -       for (i =3D 0; i < number; i++) {
> -               uint8_t len =3D 0;
> -
> -               if (attrs[i] > AVRCP_ATTRIBUTE_LAST ||
> -                                       attrs[i] =3D=3D AVRCP_ATTRIBUTE_I=
LEGAL)
> -                       return -EINVAL;
> -
> -               if (text[i])
> -                       len =3D strlen(text[i]);
> -
> -               val[i].attr =3D attrs[i];
> -               val[i].charset =3D cpu_to_be16(AVRCP_CHARSET_UTF8);
> -               val[i].len =3D len;
> -
> -               iov[i + 1].iov_base =3D &val[i];
> -               iov[i + 1].iov_len =3D sizeof(val[i]);
> -
> -               iov[i + 2].iov_base =3D (void *) text[i];
> -               iov[i + 2].iov_len =3D len;
> -       }
> -
> -       return avrcp_send(session, transaction, AVC_CTYPE_STABLE,
> -                       AVC_SUBUNIT_PANEL, AVRCP_GET_PLAYER_ATTRIBUTE_TEX=
T,
> -                       iov, 1 + i * 2);
> -}
> -
> -int avrcp_list_player_values_rsp(struct avrcp *session, uint8_t transact=
ion,
> -                                       uint8_t number, uint8_t *values)
> -{
> -       struct iovec iov[2];
> -
> -       if (number > AVRCP_ATTRIBUTE_LAST)
> -               return -EINVAL;
> -
> -       iov[0].iov_base =3D &number;
> -       iov[0].iov_len =3D sizeof(number);
> -
> -       iov[1].iov_base =3D values;
> -       iov[1].iov_len =3D number;
> -
> -       return avrcp_send(session, transaction, AVC_CTYPE_STABLE,
> -                               AVC_SUBUNIT_PANEL, AVRCP_LIST_PLAYER_VALU=
ES,
> -                               iov, 2);
> -}
> -
> -int avrcp_get_play_status_rsp(struct avrcp *session, uint8_t transaction=
,
> -                               uint32_t position, uint32_t duration,
> -                               uint8_t status)
> -{
> -       struct iovec iov;
> -       struct get_play_status_rsp rsp;
> -
> -       rsp.duration =3D cpu_to_be32(duration);
> -       rsp.position =3D cpu_to_be32(position);
> -       rsp.status =3D status;
> -
> -       iov.iov_base =3D &rsp;
> -       iov.iov_len =3D sizeof(rsp);
> -
> -       return avrcp_send(session, transaction, AVC_CTYPE_STABLE,
> -                               AVC_SUBUNIT_PANEL, AVRCP_GET_PLAY_STATUS,
> -                               &iov, 1);
> -}
> -
> -int avrcp_get_player_values_text_rsp(struct avrcp *session,
> -                                       uint8_t transaction, uint8_t numb=
er,
> -                                       uint8_t *values, const char **tex=
t)
> -{
> -       struct iovec iov[1 + AVRCP_ATTRIBUTE_LAST * 2];
> -       struct text_value val[AVRCP_ATTRIBUTE_LAST];
> -       int i;
> -
> -       if (number > AVRCP_ATTRIBUTE_LAST)
> -               return -EINVAL;
> -
> -       iov[0].iov_base =3D &number;
> -       iov[0].iov_len =3D sizeof(number);
> -
> -       for (i =3D 0; i < number; i++) {
> -               uint8_t len =3D 0;
> -
> -               if (text[i])
> -                       len =3D strlen(text[i]);
> -
> -               val[i].attr =3D values[i];
> -               val[i].charset =3D cpu_to_be16(AVRCP_CHARSET_UTF8);
> -               val[i].len =3D len;
> -
> -               iov[i + 1].iov_base =3D &val[i];
> -               iov[i + 1].iov_len =3D sizeof(val[i]);
> -
> -               iov[i + 2].iov_base =3D (void *) text[i];
> -               iov[i + 2].iov_len =3D len;
> -       }
> -
> -       return avrcp_send(session, transaction, AVC_CTYPE_STABLE,
> -                               AVC_SUBUNIT_PANEL, AVRCP_GET_PLAYER_VALUE=
_TEXT,
> -                               iov, 1 + i * 2);
> -}
> -
> -int avrcp_get_current_player_value_rsp(struct avrcp *session,
> -                                       uint8_t transaction, uint8_t numb=
er,
> -                                       uint8_t *attrs, uint8_t *values)
> -{
> -       struct iovec iov[1 + AVRCP_ATTRIBUTE_LAST];
> -       struct attr_value val[AVRCP_ATTRIBUTE_LAST];
> -       int i;
> -
> -       if (number > AVRCP_ATTRIBUTE_LAST)
> -               return -EINVAL;
> -
> -       iov[0].iov_base =3D &number;
> -       iov[0].iov_len =3D sizeof(number);
> -
> -       for (i =3D 0; i < number; i++) {
> -               val[i].attr =3D attrs[i];
> -               val[i].value =3D values[i];
> -
> -               iov[i + 1].iov_base =3D &val[i];
> -               iov[i + 1].iov_len =3D sizeof(val[i]);
> -       }
> -
> -       return avrcp_send(session, transaction, AVC_CTYPE_STABLE,
> -                       AVC_SUBUNIT_PANEL, AVRCP_GET_CURRENT_PLAYER_VALUE=
,
> -                       iov, 1 + i);
> -}
> -
> -int avrcp_set_player_value_rsp(struct avrcp *session, uint8_t transactio=
n)
> -{
> -       return avrcp_send(session, transaction, AVC_CTYPE_STABLE,
> -                       AVC_SUBUNIT_PANEL, AVRCP_SET_PLAYER_VALUE, NULL, =
0);
> -}
> -
> -int avrcp_get_element_attrs_rsp(struct avrcp *session, uint8_t transacti=
on,
> -                                       uint8_t *params, size_t params_le=
n)
> -{
> -       struct iovec iov;
> -
> -       iov.iov_base =3D params;
> -       iov.iov_len =3D params_len;
> -
> -       return avrcp_send(session, transaction, AVC_CTYPE_STABLE,
> -                               AVC_SUBUNIT_PANEL, AVRCP_GET_ELEMENT_ATTR=
IBUTES,
> -                               &iov, 1);
> -}
> -
> -int avrcp_register_notification_rsp(struct avrcp *session, uint8_t trans=
action,
> -                                       uint8_t code, uint8_t event,
> -                                       void *data, size_t len)
> -{
> -       struct iovec iov[2];
> -       uint16_t *player;
> -       uint8_t *volume;
> -
> -       if (event > AVRCP_EVENT_LAST)
> -               return -EINVAL;
> -
> -       iov[0].iov_base =3D &event;
> -       iov[0].iov_len =3D sizeof(event);
> -
> -       switch (event) {
> -       case AVRCP_EVENT_STATUS_CHANGED:
> -               if (len !=3D sizeof(uint8_t))
> -                       return -EINVAL;
> -               break;
> -       case AVRCP_EVENT_VOLUME_CHANGED:
> -               if (len !=3D sizeof(uint8_t))
> -                       return -EINVAL;
> -               volume =3D data;
> -               if (volume[0] > 127)
> -                       return -EINVAL;
> -               break;
> -       case AVRCP_EVENT_TRACK_CHANGED:
> -               if (len !=3D sizeof(uint64_t))
> -                       return -EINVAL;
> -
> -               put_be64(*(uint64_t *) data, data);
> -               break;
> -       case AVRCP_EVENT_PLAYBACK_POS_CHANGED:
> -               if (len !=3D sizeof(uint32_t))
> -                       return -EINVAL;
> -
> -               put_be32(*(uint32_t *) data, data);
> -               break;
> -       case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
> -               if (len !=3D 4)
> -                       return -EINVAL;
> -
> -               player =3D data;
> -               player[0] =3D cpu_to_be16(player[0]);
> -               player[1] =3D cpu_to_be16(player[1]);
> -
> -               break;
> -       case AVRCP_EVENT_SETTINGS_CHANGED:
> -               if (len < sizeof(uint8_t))
> -                       return -EINVAL;
> -               break;
> -       case AVRCP_EVENT_UIDS_CHANGED:
> -               if (len !=3D sizeof(uint16_t))
> -                       return -EINVAL;
> -
> -               put_be16(*(uint16_t *) data, data);
> -               break;
> -       default:
> -               return avrcp_send(session, transaction, code, AVC_SUBUNIT=
_PANEL,
> -                                       AVRCP_REGISTER_NOTIFICATION, iov,=
 1);
> -       }
> -
> -       iov[1].iov_base =3D data;
> -       iov[1].iov_len =3D len;
> -
> -       return avrcp_send(session, transaction, code, AVC_SUBUNIT_PANEL,
> -                                       AVRCP_REGISTER_NOTIFICATION, iov,=
 2);
> -}
> -
> -int avrcp_set_volume_rsp(struct avrcp *session, uint8_t transaction,
> -                                                       uint8_t volume)
> -{
> -       struct iovec iov;
> -
> -       if (volume > 127)
> -               return -EINVAL;
> -
> -       iov.iov_base =3D &volume;
> -       iov.iov_len =3D sizeof(volume);
> -
> -       return avrcp_send(session, transaction, AVC_CTYPE_STABLE,
> -                               AVC_SUBUNIT_PANEL, AVRCP_SET_ABSOLUTE_VOL=
UME,
> -                               &iov, 1);
> -}
> -
> -int avrcp_set_addressed_player_rsp(struct avrcp *session, uint8_t transa=
ction,
> -                                                       uint8_t status)
> -{
> -       struct iovec iov;
> -
> -       iov.iov_base =3D &status;
> -       iov.iov_len =3D sizeof(status);
> -
> -       return avrcp_send(session, transaction, AVC_CTYPE_STABLE,
> -                               AVC_SUBUNIT_PANEL, AVRCP_SET_ADDRESSED_PL=
AYER,
> -                               &iov, 1);
> -}
> -
> -static int avrcp_status_rsp(struct avrcp *session, uint8_t transaction,
> -                                               uint8_t pdu_id, uint8_t s=
tatus)
> -{
> -       struct iovec iov;
> -
> -       if (status > AVRCP_STATUS_ADDRESSED_PLAYER_CHANGED)
> -               return -EINVAL;
> -
> -       iov.iov_base =3D &status;
> -       iov.iov_len =3D sizeof(status);
> -
> -       return avrcp_send_browsing(session, transaction, pdu_id, &iov, 1)=
;
> -}
> -
> -int avrcp_set_browsed_player_rsp(struct avrcp *session, uint8_t transact=
ion,
> -                                       uint8_t status, uint16_t counter,
> -                                       uint32_t items, uint8_t depth,
> -                                       const char **folders)
> -{
> -       struct iovec iov[UINT8_MAX * 2 + 1];
> -       struct set_browsed_rsp rsp;
> -       uint16_t len[UINT8_MAX];
> -       int i;
> -
> -       if (status !=3D AVRCP_STATUS_SUCCESS)
> -               return avrcp_status_rsp(session, transaction,
> -                                       AVRCP_SET_BROWSED_PLAYER, status)=
;
> -
> -       rsp.status =3D status;
> -       rsp.counter =3D cpu_to_be16(counter);
> -       rsp.items =3D cpu_to_be32(items);
> -       rsp.charset =3D cpu_to_be16(AVRCP_CHARSET_UTF8);
> -       rsp.depth =3D depth;
> -
> -       iov[0].iov_base =3D &rsp;
> -       iov[0].iov_len =3D sizeof(rsp);
> -
> -       if (!depth)
> -               return avrcp_send_browsing(session, transaction,
> -                                               AVRCP_SET_BROWSED_PLAYER,
> -                                               iov, 1);
> -
> -       for (i =3D 0; i < depth; i++) {
> -               if (!folders[i])
> -                       return -EINVAL;
> -
> -               len[i] =3D strlen(folders[i]);
> -
> -               iov[i * 2 + 2].iov_base =3D (void *) folders[i];
> -               iov[i * 2 + 2].iov_len =3D len[i];
> -
> -               len[i] =3D cpu_to_be16(len[i]);
> -
> -               iov[i * 2 + 1].iov_base =3D &len[i];
> -               iov[i * 2 + 1].iov_len =3D sizeof(len[i]);
> -       }
> -
> -       return avrcp_send_browsing(session, transaction,
> -                                       AVRCP_SET_BROWSED_PLAYER, iov,
> -                                       depth * 2 + 1);
> -}
> -
> -int avrcp_get_folder_items_rsp(struct avrcp *session, uint8_t transactio=
n,
> -                                       uint8_t status, uint16_t counter,
> -                                       uint8_t number, uint8_t *type,
> -                                       uint16_t *len, uint8_t **params)
> -{
> -       struct iovec iov[UINT8_MAX * 2 + 1];
> -       struct get_folder_items_rsp rsp;
> -       uint8_t item[UINT8_MAX][3];
> -       int i;
> -
> -       if (status !=3D AVRCP_STATUS_SUCCESS)
> -               return avrcp_status_rsp(session, transaction,
> -                                       AVRCP_GET_FOLDER_ITEMS, status);
> -
> -       rsp.status =3D status;
> -       rsp.counter =3D cpu_to_be16(counter);
> -       rsp.number =3D cpu_to_be16(number);
> -
> -       iov[0].iov_base =3D &rsp;
> -       iov[0].iov_len =3D sizeof(rsp);
> -
> -       for (i =3D 0; i < number; i++) {
> -               item[i][0] =3D type[i];
> -               put_be16(len[i], &item[i][1]);
> -
> -               iov[i * 2 + 1].iov_base =3D item[i];
> -               iov[i * 2 + 1].iov_len =3D sizeof(item[i]);
> -
> -               iov[i * 2 + 2].iov_base =3D params[i];
> -               iov[i * 2 + 2].iov_len =3D len[i];
> -       }
> -
> -       return avrcp_send_browsing(session, transaction, AVRCP_GET_FOLDER=
_ITEMS,
> -                                                       iov, number * 2 +=
 1);
> -}
> -
> -int avrcp_change_path_rsp(struct avrcp *session, uint8_t transaction,
> -                                               uint8_t status, uint32_t =
items)
> -{
> -       struct iovec iov;
> -       struct change_path_rsp rsp;
> -
> -       if (status !=3D AVRCP_STATUS_SUCCESS)
> -               return avrcp_status_rsp(session, transaction, AVRCP_CHANG=
E_PATH,
> -                                                                       s=
tatus);
> -
> -       rsp.status =3D status;
> -       rsp.items =3D cpu_to_be32(items);
> -
> -       iov.iov_base =3D &rsp;
> -       iov.iov_len =3D sizeof(rsp);
> -
> -       return avrcp_send_browsing(session, transaction, AVRCP_CHANGE_PAT=
H,
> -                                                               &iov, 1);
> -}
> -
> -static bool pack_attribute_list(struct iovec *iov, uint8_t number,
> -                                       uint32_t *attrs, const char **tex=
t)
> -{
> -       int i;
> -       struct media_item val[AVRCP_MEDIA_ATTRIBUTE_LAST];
> -
> -       for (i =3D 0; i < number; i++) {
> -               uint16_t len =3D 0;
> -
> -               if (attrs[i] > AVRCP_MEDIA_ATTRIBUTE_LAST ||
> -                               attrs[i] =3D=3D AVRCP_MEDIA_ATTRIBUTE_ILL=
EGAL)
> -                       return false;
> -
> -               if (text[i])
> -                       len =3D strlen(text[i]);
> -
> -               val[i].attr =3D cpu_to_be32(attrs[i]);
> -               val[i].charset =3D cpu_to_be16(AVRCP_CHARSET_UTF8);
> -               val[i].len =3D cpu_to_be16(len);
> -
> -               iov[i].iov_base =3D &val[i];
> -               iov[i].iov_len =3D sizeof(val[i]);
> -
> -               iov[i + 1].iov_base =3D (void *) text[i];
> -               iov[i + 1].iov_len =3D len;
> -       }
> -
> -       return true;
> -}
> -
> -int avrcp_get_item_attributes_rsp(struct avrcp *session, uint8_t transac=
tion,
> -                                       uint8_t status, uint8_t number,
> -                                       uint32_t *attrs, const char **tex=
t)
> -{
> -       struct iovec iov[AVRCP_MEDIA_ATTRIBUTE_LAST * 2 + 1];
> -       struct get_item_attributes_rsp rsp;
> -
> -       if (number > AVRCP_MEDIA_ATTRIBUTE_LAST)
> -               return -EINVAL;
> -
> -       if (status !=3D AVRCP_STATUS_SUCCESS)
> -               return avrcp_status_rsp(session, transaction,
> -                                       AVRCP_GET_ITEM_ATTRIBUTES, status=
);
> -
> -       rsp.status =3D status;
> -       rsp.number =3D number;
> -
> -       iov[0].iov_base =3D &rsp;
> -       iov[0].iov_len =3D sizeof(rsp);
> -
> -       if (!pack_attribute_list(&iov[1], number, attrs, text))
> -               return -EINVAL;
> -
> -       return avrcp_send_browsing(session, transaction,
> -                                       AVRCP_GET_ITEM_ATTRIBUTES, iov,
> -                                       number * 2 + 1);
> -}
> -
> -int avrcp_play_item_rsp(struct avrcp *session, uint8_t transaction,
> -                                                               uint8_t s=
tatus)
> -{
> -       return avrcp_status_rsp(session, transaction, AVRCP_PLAY_ITEM,
> -                                                               status);
> -}
> -
> -int avrcp_search_rsp(struct avrcp *session, uint8_t transaction, uint8_t=
 status,
> -                                       uint16_t counter, uint32_t items)
> -{
> -       struct iovec iov;
> -       struct search_rsp rsp;
> -
> -       if (status !=3D AVRCP_STATUS_SUCCESS)
> -               return avrcp_status_rsp(session, transaction, AVRCP_SEARC=
H,
> -                                                               status);
> -
> -       rsp.status =3D status;
> -       rsp.counter =3D cpu_to_be16(counter);
> -       rsp.items =3D cpu_to_be32(items);
> -
> -       iov.iov_base =3D &rsp;
> -       iov.iov_len =3D sizeof(rsp);
> -
> -       return avrcp_send_browsing(session, transaction, AVRCP_SEARCH,
> -                                                               &iov, 1);
> -}
> -
> -int avrcp_add_to_now_playing_rsp(struct avrcp *session, uint8_t transact=
ion,
> -                                                               uint8_t s=
tatus)
> -{
> -       return avrcp_status_rsp(session, transaction, AVRCP_ADD_TO_NOW_PL=
AYING,
> -                                                               status);
> -}
> -
> -int avrcp_send_passthrough(struct avrcp *session, uint32_t vendor, uint8=
_t op)
> -{
> -       uint8_t params[5];
> -
> -       if (!vendor)
> -               return avctp_send_passthrough(session->conn, op, NULL, 0)=
;
> -
> -       hton24(params, vendor);
> -       put_be16(op, &params[3]);
> -
> -       return avctp_send_passthrough(session->conn, AVC_VENDOR_UNIQUE, p=
arams,
> -                                                               sizeof(pa=
rams));
> -}
> diff --git a/unit/avrcp-lib.h b/unit/avrcp-lib.h
> deleted file mode 100644
> index 5adb321880e8..000000000000
> --- a/unit/avrcp-lib.h
> +++ /dev/null
> @@ -1,343 +0,0 @@
> -/* SPDX-License-Identifier: LGPL-2.1-or-later */
> -/*
> - *
> - *  BlueZ - Bluetooth protocol stack for Linux
> - *
> - *  Copyright (C) 2014  Intel Corporation. All rights reserved.
> - *
> - *
> - */
> -
> -/* Control PDU ids */
> -#define AVRCP_GET_CAPABILITIES         0x10
> -#define AVRCP_LIST_PLAYER_ATTRIBUTES   0X11
> -#define AVRCP_LIST_PLAYER_VALUES       0x12
> -#define AVRCP_GET_CURRENT_PLAYER_VALUE 0x13
> -#define AVRCP_SET_PLAYER_VALUE         0x14
> -#define AVRCP_GET_PLAYER_ATTRIBUTE_TEXT        0x15
> -#define AVRCP_GET_PLAYER_VALUE_TEXT    0x16
> -#define AVRCP_DISPLAYABLE_CHARSET      0x17
> -#define AVRCP_CT_BATTERY_STATUS                0x18
> -#define AVRCP_GET_ELEMENT_ATTRIBUTES   0x20
> -#define AVRCP_GET_PLAY_STATUS          0x30
> -#define AVRCP_REGISTER_NOTIFICATION    0x31
> -#define AVRCP_REQUEST_CONTINUING       0x40
> -#define AVRCP_ABORT_CONTINUING         0x41
> -#define AVRCP_SET_ABSOLUTE_VOLUME      0x50
> -#define AVRCP_SET_ADDRESSED_PLAYER     0x60
> -#define AVRCP_SET_BROWSED_PLAYER       0x70
> -#define AVRCP_GET_FOLDER_ITEMS         0x71
> -#define AVRCP_CHANGE_PATH              0x72
> -#define AVRCP_GET_ITEM_ATTRIBUTES      0x73
> -#define AVRCP_PLAY_ITEM                        0x74
> -#define AVRCP_SEARCH                   0x80
> -#define AVRCP_ADD_TO_NOW_PLAYING       0x90
> -#define AVRCP_GENERAL_REJECT           0xA0
> -
> -/* Notification events */
> -#define AVRCP_EVENT_STATUS_CHANGED             0x01
> -#define AVRCP_EVENT_TRACK_CHANGED              0x02
> -#define AVRCP_EVENT_TRACK_REACHED_END          0x03
> -#define AVRCP_EVENT_TRACK_REACHED_START                0x04
> -#define AVRCP_EVENT_PLAYBACK_POS_CHANGED       0x05
> -#define AVRCP_EVENT_SETTINGS_CHANGED           0x08
> -#define AVRCP_EVENT_NOW_PLAYING_CONTENT_CHANGED        0x09
> -#define AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED  0x0a
> -#define AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED   0x0b
> -#define AVRCP_EVENT_UIDS_CHANGED               0x0c
> -#define AVRCP_EVENT_VOLUME_CHANGED             0x0d
> -#define AVRCP_EVENT_LAST                       AVRCP_EVENT_VOLUME_CHANGE=
D
> -
> -/* Status codes */
> -#define AVRCP_STATUS_INVALID_COMMAND           0x00
> -#define AVRCP_STATUS_INVALID_PARAM             0x01
> -#define AVRCP_STATUS_PARAM_NOT_FOUND           0x02
> -#define AVRCP_STATUS_INTERNAL_ERROR            0x03
> -#define AVRCP_STATUS_SUCCESS                   0x04
> -#define AVRCP_STATUS_UID_CHANGED               0x05
> -#define AVRCP_STATUS_NOT_DIRECTORY             0x08
> -#define AVRCP_STATUS_DOES_NOT_EXIST            0x09
> -#define AVRCP_STATUS_INVALID_SCOPE             0x0a
> -#define AVRCP_STATUS_OUT_OF_BOUNDS             0x0b
> -#define AVRCP_STATUS_INVALID_PLAYER_ID         0x11
> -#define AVRCP_STATUS_PLAYER_NOT_BROWSABLE      0x12
> -#define AVRCP_STATUS_NO_AVAILABLE_PLAYERS      0x15
> -#define AVRCP_STATUS_ADDRESSED_PLAYER_CHANGED  0x16
> -
> -/* Capabilities for AVRCP_GET_CAPABILITIES pdu */
> -#define CAP_COMPANY_ID                         0x02
> -#define CAP_EVENTS_SUPPORTED                   0x03
> -
> -/* Player Attributes */
> -#define AVRCP_ATTRIBUTE_ILEGAL                 0x00
> -#define AVRCP_ATTRIBUTE_EQUALIZER              0x01
> -#define AVRCP_ATTRIBUTE_REPEAT_MODE            0x02
> -#define AVRCP_ATTRIBUTE_SHUFFLE                        0x03
> -#define AVRCP_ATTRIBUTE_SCAN                   0x04
> -#define AVRCP_ATTRIBUTE_LAST                   AVRCP_ATTRIBUTE_SCAN
> -
> -/* equalizer values */
> -#define AVRCP_EQUALIZER_OFF            0x01
> -#define AVRCP_EQUALIZER_ON             0x02
> -
> -/* repeat mode values */
> -#define AVRCP_REPEAT_MODE_OFF          0x01
> -#define AVRCP_REPEAT_MODE_SINGLE       0x02
> -#define AVRCP_REPEAT_MODE_ALL          0x03
> -#define AVRCP_REPEAT_MODE_GROUP                0x04
> -
> -/* shuffle values */
> -#define AVRCP_SHUFFLE_OFF              0x01
> -#define AVRCP_SHUFFLE_ALL              0x02
> -#define AVRCP_SHUFFLE_GROUP            0x03
> -
> -/* scan values */
> -#define AVRCP_SCAN_OFF                 0x01
> -#define AVRCP_SCAN_ALL                 0x02
> -#define AVRCP_SCAN_GROUP               0x03
> -
> -/* media attributes */
> -#define AVRCP_MEDIA_ATTRIBUTE_ILLEGAL  0x00
> -#define AVRCP_MEDIA_ATTRIBUTE_TITLE    0x01
> -#define AVRCP_MEDIA_ATTRIBUTE_ARTIST   0x02
> -#define AVRCP_MEDIA_ATTRIBUTE_ALBUM    0x03
> -#define AVRCP_MEDIA_ATTRIBUTE_TRACK    0x04
> -#define AVRCP_MEDIA_ATTRIBUTE_N_TRACKS 0x05
> -#define AVRCP_MEDIA_ATTRIBUTE_GENRE    0x06
> -#define AVRCP_MEDIA_ATTRIBUTE_DURATION 0x07
> -#define AVRCP_MEDIA_ATTRIBUTE_LAST     AVRCP_MEDIA_ATTRIBUTE_DURATION
> -
> -/* Media Scope */
> -#define AVRCP_MEDIA_PLAYER_LIST                        0x00
> -#define AVRCP_MEDIA_PLAYER_VFS                 0x01
> -#define AVRCP_MEDIA_SEARCH                     0x02
> -#define AVRCP_MEDIA_NOW_PLAYING                        0x03
> -
> -/* SDP features */
> -#define AVRCP_FEATURE_CATEGORY_1       0x0001
> -#define AVRCP_FEATURE_CATEGORY_2       0x0002
> -#define AVRCP_FEATURE_CATEGORY_3       0x0004
> -#define AVRCP_FEATURE_CATEGORY_4       0x0008
> -#define AVRCP_FEATURE_PLAYER_SETTINGS  0x0010
> -#define AVRCP_FEATURE_GROUP_NAVIGATION 0x0020
> -#define AVRCP_FEATURE_BROWSING         0x0040
> -#define AVRCP_FEATURE_MULTIPLE_PLAYERS 0x0080
> -
> -/* Company IDs for vendor dependent commands */
> -#define IEEEID_BTSIG           0x001958
> -
> -struct avrcp;
> -
> -struct avrcp_control_ind {
> -       int (*get_capabilities) (struct avrcp *session, uint8_t transacti=
on,
> -                                                       void *user_data);
> -       int (*list_attributes) (struct avrcp *session, uint8_t transactio=
n,
> -                                                       void *user_data);
> -       int (*get_attribute_text) (struct avrcp *session, uint8_t transac=
tion,
> -                                       uint8_t number, uint8_t *attrs,
> -                                       void *user_data);
> -       int (*list_values) (struct avrcp *session, uint8_t transaction,
> -                                       uint8_t attr, void *user_data);
> -       int (*get_value_text) (struct avrcp *session, uint8_t transaction=
,
> -                                       uint8_t attr, uint8_t number,
> -                                       uint8_t *values, void *user_data)=
;
> -       int (*get_value) (struct avrcp *session, uint8_t transaction,
> -                                       uint8_t number, uint8_t *attrs,
> -                                       void *user_data);
> -       int (*set_value) (struct avrcp *session, uint8_t transaction,
> -                                       uint8_t number, uint8_t *attrs,
> -                                       uint8_t *values, void *user_data)=
;
> -       int (*get_play_status) (struct avrcp *session, uint8_t transactio=
n,
> -                                       void *user_data);
> -       int (*get_element_attributes) (struct avrcp *session,
> -                                       uint8_t transaction, uint64_t uid=
,
> -                                       uint8_t number, uint32_t *attrs,
> -                                       void *user_data);
> -       int (*register_notification) (struct avrcp *session,
> -                                       uint8_t transaction, uint8_t even=
t,
> -                                       uint32_t interval, void *user_dat=
a);
> -       int (*set_volume) (struct avrcp *session, uint8_t transaction,
> -                                       uint8_t volume, void *user_data);
> -       int (*set_addressed) (struct avrcp *session, uint8_t transaction,
> -                                       uint16_t id, void *user_data);
> -       int (*set_browsed) (struct avrcp *session, uint8_t transaction,
> -                                       uint16_t id, void *user_data);
> -       int (*get_folder_items) (struct avrcp *session, uint8_t transacti=
on,
> -                                       uint8_t scope, uint32_t start,
> -                                       uint32_t end, uint16_t number,
> -                                       uint32_t *attrs, void *user_data)=
;
> -       int (*change_path) (struct avrcp *session, uint8_t transaction,
> -                                       uint16_t counter, uint8_t directi=
on,
> -                                       uint64_t uid, void *user_data);
> -       int (*get_item_attributes) (struct avrcp *session, uint8_t transa=
ction,
> -                                       uint8_t scope, uint64_t uid,
> -                                       uint16_t counter, uint8_t number,
> -                                       uint32_t *attrs, void *user_data)=
;
> -       int (*play_item) (struct avrcp *session, uint8_t transaction,
> -                                       uint8_t scope, uint64_t uid,
> -                                       uint16_t counter, void *user_data=
);
> -       int (*search) (struct avrcp *session, uint8_t transaction,
> -                                       const char *string, void *user_da=
ta);
> -       int (*add_to_now_playing) (struct avrcp *session, uint8_t transac=
tion,
> -                                       uint8_t scope, uint64_t uid,
> -                                       uint16_t counter, void *user_data=
);
> -};
> -
> -struct avrcp_control_cfm {
> -       void (*get_capabilities) (struct avrcp *session, int err,
> -                                       uint8_t number, uint8_t *params,
> -                                       void *user_data);
> -       void (*list_attributes) (struct avrcp *session, int err,
> -                                       uint8_t number, uint8_t *attrs,
> -                                       void *user_data);
> -       void (*get_attribute_text) (struct avrcp *session, int err,
> -                                       uint8_t number, uint8_t *attrs,
> -                                       char **text, void *user_data);
> -       void (*list_values) (struct avrcp *session, int err,
> -                                       uint8_t number, uint8_t *values,
> -                                       void *user_data);
> -       void (*get_value_text) (struct avrcp *session, int err,
> -                                       uint8_t number, uint8_t *values,
> -                                       char **text, void *user_data);
> -       void (*get_value) (struct avrcp *session, int err,
> -                                       uint8_t number, uint8_t *attrs,
> -                                       uint8_t *values, void *user_data)=
;
> -       void (*set_value) (struct avrcp *session, int err, void *user_dat=
a);
> -       void (*get_play_status) (struct avrcp *session, int err,
> -                                       uint8_t status, uint32_t position=
,
> -                                       uint32_t duration, void *user_dat=
a);
> -       void (*get_element_attributes) (struct avrcp *session, int err,
> -                                       uint8_t number, uint32_t *attrs,
> -                                       char **text, void *user_data);
> -       bool (*register_notification) (struct avrcp *session, int err,
> -                                       uint8_t code, uint8_t event,
> -                                       void *params, void *user_data);
> -       void (*set_volume) (struct avrcp *session, int err, uint8_t volum=
e,
> -                                       void *user_data);
> -       void (*set_addressed) (struct avrcp *session, int err,
> -                                       void *user_data);
> -       void (*set_browsed) (struct avrcp *session, int err,
> -                                       uint16_t counter, uint32_t items,
> -                                       char *path, void *user_data);
> -       void (*get_folder_items) (struct avrcp *session, int err,
> -                                       uint16_t counter, uint16_t number=
,
> -                                       uint8_t *params, void *user_data)=
;
> -       void (*change_path) (struct avrcp *session, int err,
> -                                       uint32_t items, void *user_data);
> -       void (*get_item_attributes) (struct avrcp *session, int err,
> -                                       uint8_t number, uint32_t *attrs,
> -                                       char **text, void *user_data);
> -       void (*play_item) (struct avrcp *session, int err, void *user_dat=
a);
> -       void (*search) (struct avrcp *session, int err, uint16_t counter,
> -                                       uint32_t items, void *user_data);
> -       void (*add_to_now_playing) (struct avrcp *session, int err,
> -                                       void *user_data);
> -};
> -
> -struct avrcp_passthrough_handler {
> -       uint8_t op;
> -       bool (*func) (struct avrcp *session, bool pressed, void *user_dat=
a);
> -};
> -
> -typedef void (*avrcp_destroy_cb_t) (void *user_data);
> -
> -struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t versi=
on);
> -void avrcp_shutdown(struct avrcp *session);
> -void avrcp_set_destroy_cb(struct avrcp *session, avrcp_destroy_cb_t cb,
> -                                                       void *user_data);
> -int avrcp_connect_browsing(struct avrcp *session, int fd, size_t imtu,
> -                                                               size_t om=
tu);
> -
> -void avrcp_register_player(struct avrcp *session,
> -                               const struct avrcp_control_ind *ind,
> -                               const struct avrcp_control_cfm *cfm,
> -                               void *user_data);
> -void avrcp_set_passthrough_handlers(struct avrcp *session,
> -                       const struct avrcp_passthrough_handler *handlers,
> -                       void *user_data);
> -int avrcp_init_uinput(struct avrcp *session, const char *name,
> -                                                       const char *addre=
ss);
> -int avrcp_send(struct avrcp *session, uint8_t transaction, uint8_t code,
> -                                       uint8_t subunit, uint8_t pdu_id,
> -                                       const struct iovec *iov, int iov_=
cnt);
> -int avrcp_get_capabilities(struct avrcp *session, uint8_t param);
> -int avrcp_register_notification(struct avrcp *session, uint8_t event,
> -                                                       uint32_t interval=
);
> -int avrcp_list_player_attributes(struct avrcp *session);
> -int avrcp_get_player_attribute_text(struct avrcp *session, uint8_t numbe=
r,
> -                                                       uint8_t *attrs);
> -int avrcp_list_player_values(struct avrcp *session, uint8_t attr);
> -int avrcp_get_player_value_text(struct avrcp *session, uint8_t attr,
> -                                       uint8_t number, uint8_t *values);
> -int avrcp_set_player_value(struct avrcp *session, uint8_t number,
> -                                       uint8_t *attrs, uint8_t *values);
> -int avrcp_get_current_player_value(struct avrcp *session, uint8_t number=
,
> -                                                       uint8_t *attrs);
> -int avrcp_get_play_status(struct avrcp *session);
> -int avrcp_set_volume(struct avrcp *session, uint8_t volume);
> -int avrcp_get_element_attributes(struct avrcp *session);
> -int avrcp_set_addressed_player(struct avrcp *session, uint16_t player_id=
);
> -int avrcp_set_browsed_player(struct avrcp *session, uint16_t player_id);
> -int avrcp_get_folder_items(struct avrcp *session, uint8_t scope,
> -                               uint32_t start, uint32_t end, uint8_t num=
ber,
> -                               uint32_t *attrs);
> -int avrcp_change_path(struct avrcp *session, uint8_t direction, uint64_t=
 uid,
> -                                                       uint16_t counter)=
;
> -int avrcp_get_item_attributes(struct avrcp *session, uint8_t scope,
> -                               uint64_t uid, uint16_t counter, uint8_t n=
umber,
> -                               uint32_t *attrs);
> -int avrcp_play_item(struct avrcp *session, uint8_t scope, uint64_t uid,
> -                                                       uint16_t counter)=
;
> -int avrcp_search(struct avrcp *session, const char *string);
> -int avrcp_add_to_now_playing(struct avrcp *session, uint8_t scope, uint6=
4_t uid,
> -                                                       uint16_t counter)=
;
> -
> -int avrcp_get_capabilities_rsp(struct avrcp *session, uint8_t transactio=
n,
> -                                       uint8_t number, uint8_t *events);
> -int avrcp_list_player_attributes_rsp(struct avrcp *session, uint8_t tran=
saction,
> -                                       uint8_t number, uint8_t *attrs);
> -int avrcp_get_player_attribute_text_rsp(struct avrcp *session,
> -                                       uint8_t transaction, uint8_t numb=
er,
> -                                       uint8_t *attrs, const char **text=
);
> -int avrcp_list_player_values_rsp(struct avrcp *session, uint8_t transact=
ion,
> -                                       uint8_t number, uint8_t *values);
> -int avrcp_get_play_status_rsp(struct avrcp *session, uint8_t transaction=
,
> -                               uint32_t position, uint32_t duration,
> -                               uint8_t status);
> -int avrcp_get_player_values_text_rsp(struct avrcp *session,
> -                                       uint8_t transaction, uint8_t numb=
er,
> -                                       uint8_t *values, const char **tex=
t);
> -int avrcp_get_current_player_value_rsp(struct avrcp *session,
> -                                       uint8_t transaction, uint8_t numb=
er,
> -                                       uint8_t *attrs, uint8_t *values);
> -int avrcp_set_player_value_rsp(struct avrcp *session, uint8_t transactio=
n);
> -int avrcp_get_element_attrs_rsp(struct avrcp *session, uint8_t transacti=
on,
> -                                       uint8_t *params, size_t params_le=
n);
> -int avrcp_register_notification_rsp(struct avrcp *session, uint8_t trans=
action,
> -                                       uint8_t code, uint8_t event,
> -                                       void *data, size_t len);
> -int avrcp_set_volume_rsp(struct avrcp *session, uint8_t transaction,
> -                                                       uint8_t volume);
> -int avrcp_set_addressed_player_rsp(struct avrcp *session, uint8_t transa=
ction,
> -                                                       uint8_t status);
> -int avrcp_set_browsed_player_rsp(struct avrcp *session, uint8_t transact=
ion,
> -                                       uint8_t status, uint16_t counter,
> -                                       uint32_t items, uint8_t depth,
> -                                       const char **folders);
> -int avrcp_get_folder_items_rsp(struct avrcp *session, uint8_t transactio=
n,
> -                                       uint8_t status, uint16_t counter,
> -                                       uint8_t number, uint8_t *type,
> -                                       uint16_t *len, uint8_t **params);
> -int avrcp_change_path_rsp(struct avrcp *session, uint8_t transaction,
> -                                               uint8_t status, uint32_t =
items);
> -int avrcp_get_item_attributes_rsp(struct avrcp *session, uint8_t transac=
tion,
> -                                       uint8_t status, uint8_t number,
> -                                       uint32_t *attrs, const char **tex=
t);
> -int avrcp_play_item_rsp(struct avrcp *session, uint8_t transaction,
> -                                       uint8_t status);
> -int avrcp_search_rsp(struct avrcp *session, uint8_t transaction, uint8_t=
 status,
> -                                       uint16_t counter, uint32_t items)=
;
> -int avrcp_add_to_now_playing_rsp(struct avrcp *session, uint8_t transact=
ion,
> -                                                               uint8_t s=
tatus);
> -
> -int avrcp_send_passthrough(struct avrcp *session, uint32_t vendor, uint8=
_t op);
> diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
> deleted file mode 100644
> index 7bed8fbaf74a..000000000000
> --- a/unit/test-avrcp.c
> +++ /dev/null
> @@ -1,2084 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - *
> - *  BlueZ - Bluetooth protocol stack for Linux
> - *
> - *  Copyright (C) 2014  Intel Corporation. All rights reserved.
> - *
> - *
> - */
> -
> -#ifdef HAVE_CONFIG_H
> -#include <config.h>
> -#endif
> -
> -#include <unistd.h>
> -#include <stdlib.h>
> -#include <stdbool.h>
> -#include <inttypes.h>
> -#include <string.h>
> -#include <fcntl.h>
> -#include <errno.h>
> -#include <sys/socket.h>
> -
> -#include <glib.h>
> -
> -#include "src/shared/util.h"
> -#include "src/shared/tester.h"
> -#include "src/log.h"
> -#include "bluetooth/bluetooth.h"
> -
> -#include "unit/avctp.h"
> -#include "unit/avrcp-lib.h"
> -
> -struct test_pdu {
> -       bool valid;
> -       bool fragmented;
> -       bool continuing;
> -       bool browse;
> -       uint8_t *data;
> -       size_t size;
> -};
> -
> -struct test_data {
> -       char *test_name;
> -       struct test_pdu *pdu_list;
> -};
> -
> -struct context {
> -       struct avrcp *session;
> -       guint source;
> -       guint browse_source;
> -       guint process;
> -       int fd;
> -       int browse_fd;
> -       unsigned int pdu_offset;
> -       const struct test_data *data;
> -};
> -
> -#define data(args...) ((const unsigned char[]) { args })
> -
> -#define raw_pdu(args...)                                       \
> -       {                                                       \
> -               .valid =3D true,                                  \
> -               .data =3D util_memdup(data(args), sizeof(data(args))), \
> -               .size =3D sizeof(data(args)),                     \
> -       }
> -
> -#define brs_pdu(args...)                                       \
> -       {                                                       \
> -               .valid =3D true,                                  \
> -               .browse =3D true,                                 \
> -               .data =3D util_memdup(data(args), sizeof(data(args))), \
> -               .size =3D sizeof(data(args)),                     \
> -       }
> -
> -#define frg_pdu(args...)                                       \
> -       {                                                       \
> -               .valid =3D true,                                  \
> -               .fragmented =3D true,                             \
> -               .data =3D util_memdup(data(args), sizeof(data(args))), \
> -               .size =3D sizeof(data(args)),                     \
> -       }
> -
> -#define cont_pdu(args...)                                      \
> -       {                                                       \
> -               .valid =3D true,                                  \
> -               .continuing =3D true,                             \
> -               .data =3D util_memdup(data(args), sizeof(data(args))), \
> -               .size =3D sizeof(data(args)),                     \
> -       }
> -
> -#define define_test(name, function, args...)                           \
> -       do {                                                            \
> -               const struct test_pdu pdus[] =3D {                       =
 \
> -                       args, { }                                       \
> -               };                                                      \
> -               static struct test_data data;                           \
> -               data.test_name =3D g_strdup(name);                       =
 \
> -               data.pdu_list =3D util_memdup(pdus, sizeof(pdus));       =
 \
> -               tester_add(name, &data, NULL, function, NULL);          \
> -       } while (0)
> -
> -static void test_free(gconstpointer user_data)
> -{
> -       const struct test_data *data =3D user_data;
> -       struct test_pdu *pdu;
> -       int i;
> -
> -       for (i =3D 0; (pdu =3D &data->pdu_list[i]) && pdu->valid; i++)
> -               g_free(pdu->data);
> -
> -       g_free(data->test_name);
> -       g_free(data->pdu_list);
> -}
> -
> -static void destroy_context(struct context *context)
> -{
> -       if (context->source > 0)
> -               g_source_remove(context->source);
> -
> -       if (context->browse_source > 0)
> -               g_source_remove(context->browse_source);
> -
> -       avrcp_shutdown(context->session);
> -
> -       test_free(context->data);
> -       g_free(context);
> -}
> -
> -static gboolean context_quit(gpointer user_data)
> -{
> -       struct context *context =3D user_data;
> -
> -       if (context->process > 0)
> -               g_source_remove(context->process);
> -
> -       destroy_context(context);
> -
> -       tester_test_passed();
> -
> -       return FALSE;
> -}
> -
> -static gboolean send_pdu(gpointer user_data)
> -{
> -       struct context *context =3D user_data;
> -       const struct test_pdu *pdu;
> -       ssize_t len;
> -
> -       pdu =3D &context->data->pdu_list[context->pdu_offset++];
> -
> -       if (pdu->browse) {
> -               len =3D write(context->browse_fd, pdu->data, pdu->size);
> -               tester_monitor('<', 0x0000, 0x001b, pdu->data, len);
> -       } else {
> -               len =3D write(context->fd, pdu->data, pdu->size);
> -               tester_monitor('<', 0x0000, 0x0017, pdu->data, len);
> -       }
> -
> -       g_assert_cmpint(len, =3D=3D, pdu->size);
> -
> -       if (pdu->fragmented)
> -               return send_pdu(user_data);
> -
> -       context->process =3D 0;
> -       return FALSE;
> -}
> -
> -static void context_process(struct context *context)
> -{
> -       if (!context->data->pdu_list[context->pdu_offset].valid) {
> -               context_quit(context);
> -               return;
> -       }
> -
> -       context->process =3D g_idle_add(send_pdu, context);
> -}
> -
> -static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
> -                                                       gpointer user_dat=
a)
> -{
> -       struct context *context =3D user_data;
> -       const struct test_pdu *pdu;
> -       unsigned char buf[512];
> -       ssize_t len;
> -       int fd;
> -
> -       pdu =3D &context->data->pdu_list[context->pdu_offset++];
> -
> -       g_assert(!pdu->browse);
> -
> -       if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
> -               context->source =3D 0;
> -               tester_debug("%s: cond %x\n", __func__, cond);
> -               return FALSE;
> -       }
> -
> -       fd =3D g_io_channel_unix_get_fd(channel);
> -
> -       len =3D read(fd, buf, sizeof(buf));
> -
> -       g_assert(len > 0);
> -
> -       tester_monitor('>', 0x0000, 0x0017, buf, len);
> -
> -       if (!pdu->continuing)
> -               g_assert_cmpint(len, =3D=3D, pdu->size);
> -
> -       g_assert(memcmp(buf, pdu->data, pdu->size) =3D=3D 0);
> -
> -       if (!pdu->fragmented)
> -               context_process(context);
> -
> -       return TRUE;
> -}
> -
> -static gboolean browse_test_handler(GIOChannel *channel, GIOCondition co=
nd,
> -                                                       gpointer user_dat=
a)
> -{
> -       struct context *context =3D user_data;
> -       const struct test_pdu *pdu;
> -       unsigned char buf[512];
> -       ssize_t len;
> -       int fd;
> -
> -       pdu =3D &context->data->pdu_list[context->pdu_offset++];
> -
> -       g_assert(pdu->browse);
> -
> -       if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
> -               context->browse_source =3D 0;
> -               tester_debug("%s: cond %x\n", __func__, cond);
> -               return FALSE;
> -       }
> -
> -       fd =3D g_io_channel_unix_get_fd(channel);
> -
> -       len =3D read(fd, buf, sizeof(buf));
> -
> -       g_assert(len > 0);
> -
> -       tester_monitor('>', 0x0000, 0x001b, buf, len);
> -
> -       g_assert_cmpint(len, =3D=3D, pdu->size);
> -
> -       g_assert(memcmp(buf, pdu->data, pdu->size) =3D=3D 0);
> -
> -       if (!pdu->fragmented)
> -               context_process(context);
> -
> -       return TRUE;
> -}
> -
> -static struct context *create_context(uint16_t version, gconstpointer da=
ta)
> -{
> -       struct context *context =3D g_new0(struct context, 1);
> -       GIOChannel *channel;
> -       int err, sv[2];
> -
> -       /* Control channel setup */
> -
> -       err =3D socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0, sv)=
;
> -       g_assert(!err);
> -
> -       context->session =3D avrcp_new(sv[0], 672, 672, version);
> -       g_assert(context->session !=3D NULL);
> -
> -       channel =3D g_io_channel_unix_new(sv[1]);
> -
> -       g_io_channel_set_close_on_unref(channel, TRUE);
> -       g_io_channel_set_encoding(channel, NULL, NULL);
> -       g_io_channel_set_buffered(channel, FALSE);
> -
> -       context->source =3D g_io_add_watch(channel,
> -                               G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL=
,
> -                               test_handler, context);
> -       g_assert(context->source > 0);
> -
> -       g_io_channel_unref(channel);
> -
> -       context->fd =3D sv[1];
> -
> -       /* Browsing channel setup */
> -
> -       err =3D socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0, sv)=
;
> -       g_assert(!err);
> -
> -       err =3D avrcp_connect_browsing(context->session, sv[0], 672, 672)=
;
> -       g_assert(!err);
> -
> -       channel =3D g_io_channel_unix_new(sv[1]);
> -
> -       g_io_channel_set_close_on_unref(channel, TRUE);
> -       g_io_channel_set_encoding(channel, NULL, NULL);
> -       g_io_channel_set_buffered(channel, FALSE);
> -
> -       context->browse_source =3D g_io_add_watch(channel,
> -                               G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL=
,
> -                               browse_test_handler, context);
> -       g_assert(context->browse_source > 0);
> -
> -       g_io_channel_unref(channel);
> -
> -       context->browse_fd =3D sv[1];
> -
> -       context->data =3D data;
> -
> -       return context;
> -}
> -
> -static void test_dummy(gconstpointer data)
> -{
> -       struct context *context =3D  create_context(0x0100, data);
> -
> -       context_quit(context);
> -}
> -
> -static bool handle_play(struct avrcp *session, bool pressed, void *user_=
data)
> -{
> -       return true;
> -}
> -
> -static bool handle_volume_up(struct avrcp *session, bool pressed,
> -                                                       void *user_data)
> -{
> -       return true;
> -}
> -
> -static bool handle_channel_up(struct avrcp *session, bool pressed,
> -                                                       void *user_data)
> -{
> -       return true;
> -}
> -
> -static bool handle_select(struct avrcp *session, bool pressed, void *use=
r_data)
> -{
> -       return true;
> -}
> -
> -static bool handle_vendor_uniq(struct avrcp *session, bool pressed,
> -                                                               void *use=
r_data)
> -{
> -       return true;
> -}
> -
> -static const struct avrcp_passthrough_handler passthrough_handlers[] =3D=
 {
> -               { AVC_PLAY, handle_play },
> -               { AVC_VOLUME_UP, handle_volume_up },
> -               { AVC_CHANNEL_UP, handle_channel_up },
> -               { AVC_SELECT, handle_select },
> -               { AVC_VENDOR_UNIQUE, handle_vendor_uniq },
> -               { },
> -};
> -
> -static int get_capabilities(struct avrcp *session, uint8_t transaction,
> -                                                       void *user_data)
> -{
> -       return -EINVAL;
> -}
> -
> -static int list_attributes(struct avrcp *session, uint8_t transaction,
> -                                                       void *user_data)
> -{
> -       avrcp_list_player_attributes_rsp(session, transaction, 0, NULL);
> -
> -       return 0;
> -}
> -
> -static int get_attribute_text(struct avrcp *session, uint8_t transaction=
,
> -                                       uint8_t number, uint8_t *attrs,
> -                                       void *user_data)
> -{
> -       const char *text[number];
> -
> -       if (number) {
> -               memset(text, 0, number);
> -               text[0] =3D "equalizer";
> -       }
> -
> -       avrcp_get_player_attribute_text_rsp(session, transaction, number,=
 attrs,
> -                                                                       t=
ext);
> -
> -       return 0;
> -}
> -
> -static int list_values(struct avrcp *session, uint8_t transaction,
> -                                               uint8_t attr, void *user_=
data)
> -{
> -       avrcp_list_player_values_rsp(session, transaction, 0, NULL);
> -
> -       return -EINVAL;
> -}
> -
> -static int get_value_text(struct avrcp *session, uint8_t transaction,
> -                               uint8_t attr, uint8_t number, uint8_t *va=
lues,
> -                               void *user_data)
> -{
> -       const char *text[number];
> -
> -       if (number) {
> -               memset(text, 0, number);
> -               text[0] =3D "on";
> -       }
> -
> -       avrcp_get_player_values_text_rsp(session, transaction, number,
> -                                                               values, t=
ext);
> -
> -       return -EINVAL;
> -}
> -
> -static int get_value(struct avrcp *session, uint8_t transaction,
> -                       uint8_t number, uint8_t *attrs, void *user_data)
> -{
> -       uint8_t values[number];
> -
> -       memset(values, 0, number);
> -
> -       avrcp_get_current_player_value_rsp(session, transaction, number, =
attrs,
> -                                                                       v=
alues);
> -
> -       return 0;
> -}
> -
> -static int set_value(struct avrcp *session, uint8_t transaction,
> -                       uint8_t number, uint8_t *attrs, uint8_t *values,
> -                       void *user_data)
> -{
> -       avrcp_set_player_value_rsp(session, transaction);
> -
> -       return 0;
> -}
> -
> -static int get_play_status(struct avrcp *session, uint8_t transaction,
> -                                                       void *user_data)
> -{
> -       avrcp_get_play_status_rsp(session, transaction, 0xaaaaaaaa, 0xbbb=
bbbbb,
> -                                                                       0=
x00);
> -
> -       return 0;
> -}
> -
> -static int get_element_attributes(struct avrcp *session, uint8_t transac=
tion,
> -                                       uint64_t uid, uint8_t number,
> -                                       uint32_t *attrs, void *user_data)
> -{
> -       struct context *context =3D user_data;
> -
> -       if (g_str_has_prefix(context->data->test_name, "/TP/RCR")) {
> -               uint8_t params[1024];
> -
> -               memset(params, 0x00, sizeof(params) / 2);
> -               memset(params + (sizeof(params) / 2), 0xff, sizeof(params=
) / 2);
> -
> -               avrcp_get_element_attrs_rsp(session, transaction, params,
> -                                                       sizeof(params));
> -       } else
> -               avrcp_get_element_attrs_rsp(session, transaction, NULL, 0=
);
> -
> -       return 0;
> -}
> -
> -static int track_changed(struct avrcp *session, uint8_t transaction,
> -                                       uint32_t interval, void *user_dat=
a)
> -{
> -       struct context *context =3D user_data;
> -       uint64_t track;
> -
> -       if (g_str_equal(context->data->test_name, "/TP/NFY/BV-05-C") ||
> -               g_str_equal(context->data->test_name, "/TP/NFY/BV-08-C"))
> -               memset(&track, 0, sizeof(track));
> -       else
> -               memset(&track, 0xff, sizeof(track));
> -
> -       avrcp_register_notification_rsp(session, transaction, AVC_CTYPE_I=
NTERIM,
> -                                               AVRCP_EVENT_TRACK_CHANGED=
,
> -                                               &track, sizeof(track));
> -
> -       avrcp_register_notification_rsp(session, transaction, AVC_CTYPE_C=
HANGED,
> -                                               AVRCP_EVENT_TRACK_CHANGED=
,
> -                                               &track, sizeof(track));
> -
> -       return 0;
> -}
> -
> -static int settings_changed(struct avrcp *session, uint8_t transaction,
> -                                       uint32_t interval, void *user_dat=
a)
> -{
> -       uint8_t settings[3];
> -
> -       settings[0] =3D 0x01;
> -       settings[1] =3D 0x01;
> -       settings[2] =3D 0x02;
> -
> -       avrcp_register_notification_rsp(session, transaction, AVC_CTYPE_I=
NTERIM,
> -                                               AVRCP_EVENT_SETTINGS_CHAN=
GED,
> -                                               settings, sizeof(settings=
));
> -
> -       avrcp_register_notification_rsp(session, transaction, AVC_CTYPE_C=
HANGED,
> -                                               AVRCP_EVENT_SETTINGS_CHAN=
GED,
> -                                               settings, sizeof(settings=
));
> -
> -       return 0;
> -}
> -
> -static int available_players_changed(struct avrcp *session, uint8_t tran=
saction,
> -                                       uint32_t interval, void *user_dat=
a)
> -{
> -       avrcp_register_notification_rsp(session, transaction, AVC_CTYPE_I=
NTERIM,
> -                                       AVRCP_EVENT_AVAILABLE_PLAYERS_CHA=
NGED,
> -                                       NULL, 0);
> -
> -       avrcp_register_notification_rsp(session, transaction, AVC_CTYPE_C=
HANGED,
> -                                       AVRCP_EVENT_AVAILABLE_PLAYERS_CHA=
NGED,
> -                                       NULL, 0);
> -
> -       return 0;
> -}
> -
> -static int addressed_player_changed(struct avrcp *session, uint8_t trans=
action,
> -                                       uint32_t interval, void *user_dat=
a)
> -{
> -       uint16_t player[2];
> -
> -       player[0] =3D 0x0001;
> -       player[1] =3D 0x0001;
> -
> -       avrcp_register_notification_rsp(session, transaction, AVC_CTYPE_I=
NTERIM,
> -                                       AVRCP_EVENT_ADDRESSED_PLAYER_CHAN=
GED,
> -                                       player, sizeof(player));
> -
> -       player[0] =3D 0x0200;
> -       player[1] =3D 0x0200;
> -
> -       avrcp_register_notification_rsp(session, transaction, AVC_CTYPE_C=
HANGED,
> -                                       AVRCP_EVENT_ADDRESSED_PLAYER_CHAN=
GED,
> -                                       player, sizeof(player));
> -
> -       return 0;
> -}
> -
> -static int uids_changed(struct avrcp *session, uint8_t transaction,
> -                                       uint32_t interval, void *user_dat=
a)
> -{
> -       struct context *context =3D user_data;
> -       uint16_t counter;
> -
> -       if (g_str_equal(context->data->test_name, "/TP/MCN/CB/BV-09-C"))
> -               counter =3D 0x0000;
> -       else
> -               counter =3D 0x0001;
> -
> -       avrcp_register_notification_rsp(session, transaction, AVC_CTYPE_I=
NTERIM,
> -                                               AVRCP_EVENT_UIDS_CHANGED,
> -                                               &counter, sizeof(counter)=
);
> -
> -       if (!g_str_equal(context->data->test_name, "/TP/MCN/CB/BV-11-C") =
&&
> -               !g_str_equal(context->data->test_name, "/TP/MCN/CB/BI-05-=
C"))
> -               return 0;
> -
> -       counter =3D 0x0200;
> -
> -       avrcp_register_notification_rsp(session, transaction, AVC_CTYPE_C=
HANGED,
> -                                               AVRCP_EVENT_UIDS_CHANGED,
> -                                               &counter, sizeof(counter)=
);
> -
> -       return 0;
> -}
> -
> -static int now_playing_content_changed(struct avrcp *session,
> -                                       uint8_t transaction, uint32_t int=
erval,
> -                                       void *user_data)
> -{
> -       avrcp_register_notification_rsp(session, transaction, AVC_CTYPE_I=
NTERIM,
> -                                       AVRCP_EVENT_NOW_PLAYING_CONTENT_C=
HANGED,
> -                                       NULL, 0);
> -
> -       avrcp_register_notification_rsp(session, transaction, AVC_CTYPE_C=
HANGED,
> -                                       AVRCP_EVENT_NOW_PLAYING_CONTENT_C=
HANGED,
> -                                       NULL, 0);
> -
> -       return 0;
> -}
> -
> -static int volume_changed(struct avrcp *session, uint8_t transaction,
> -                                       uint32_t interval, void *user_dat=
a)
> -{
> -       uint8_t volume =3D 0x00;
> -
> -       avrcp_register_notification_rsp(session, transaction, AVC_CTYPE_I=
NTERIM,
> -                                       AVRCP_EVENT_VOLUME_CHANGED,
> -                                       &volume, sizeof(volume));
> -
> -       volume =3D 0x01;
> -
> -       avrcp_register_notification_rsp(session, transaction, AVC_CTYPE_C=
HANGED,
> -                                       AVRCP_EVENT_VOLUME_CHANGED,
> -                                       &volume, sizeof(volume));
> -
> -       return 0;
> -}
> -
> -static int register_notification(struct avrcp *session, uint8_t transact=
ion,
> -                                       uint8_t event, uint32_t interval,
> -                                       void *user_data)
> -{
> -       switch (event) {
> -       case AVRCP_EVENT_TRACK_CHANGED:
> -               return track_changed(session, transaction, interval, user=
_data);
> -       case AVRCP_EVENT_SETTINGS_CHANGED:
> -               return settings_changed(session, transaction, interval,
> -                                                               user_data=
);
> -       case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
> -               return available_players_changed(session, transaction, in=
terval,
> -                                                               user_data=
);
> -       case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
> -               return addressed_player_changed(session, transaction, int=
erval,
> -                                                               user_data=
);
> -       case AVRCP_EVENT_UIDS_CHANGED:
> -               return uids_changed(session, transaction, interval, user_=
data);
> -       case AVRCP_EVENT_NOW_PLAYING_CONTENT_CHANGED:
> -               return now_playing_content_changed(session, transaction,
> -                                                       interval, user_da=
ta);
> -       case AVRCP_EVENT_VOLUME_CHANGED:
> -               return volume_changed(session, transaction,
> -                                                       interval, user_da=
ta);
> -       default:
> -               return -EINVAL;
> -       }
> -}
> -
> -static int set_volume(struct avrcp *session, uint8_t transaction,
> -                                       uint8_t volume, void *user_data)
> -{
> -       avrcp_set_volume_rsp(session, transaction, volume);
> -
> -       return 0;
> -}
> -
> -static int set_addressed(struct avrcp *session, uint8_t transaction,
> -                                               uint16_t id, void *user_d=
ata)
> -{
> -       struct context *context =3D user_data;
> -       uint8_t status;
> -
> -       if (g_str_equal(context->data->test_name, "/TP/MPS/BI-01-C"))
> -               status =3D AVRCP_STATUS_INVALID_PLAYER_ID;
> -       else
> -               status =3D AVRCP_STATUS_SUCCESS;
> -
> -       avrcp_set_addressed_player_rsp(session, transaction, status);
> -
> -       return 0;
> -}
> -
> -static int set_browsed(struct avrcp *session, uint8_t transaction,
> -                                               uint16_t id, void *user_d=
ata)
> -{
> -       struct context *context =3D user_data;
> -       const char *folders[1] =3D { "Filesystem" };
> -
> -       if (g_str_equal(context->data->test_name, "/TP/MPS/BI-02-C"))
> -               avrcp_set_browsed_player_rsp(session, transaction,
> -                                               AVRCP_STATUS_INVALID_PLAY=
ER_ID,
> -                                               0, 0, 0, NULL);
> -       else
> -               avrcp_set_browsed_player_rsp(session, transaction,
> -                                               AVRCP_STATUS_SUCCESS,
> -                                               0xabcd, 0, 1, folders);
> -
> -       return 0;
> -}
> -
> -static int get_folder_items(struct avrcp *session, uint8_t transaction,
> -                               uint8_t scope, uint32_t start, uint32_t e=
nd,
> -                               uint16_t number, uint32_t *attrs,
> -                               void *user_data)
> -{
> -       struct context *context =3D user_data;
> -
> -       if (g_str_equal(context->data->test_name, "/TP/MCN/CB/BI-02-C"))
> -               return -ERANGE;
> -
> -       if (start > 1)
> -               return -ERANGE;
> -
> -       avrcp_get_folder_items_rsp(session, transaction, AVRCP_STATUS_SUC=
CESS,
> -                                               0xabcd, 0, NULL, NULL, NU=
LL);
> -
> -       return 0;
> -}
> -
> -static int change_path(struct avrcp *session, uint8_t transaction,
> -                                       uint16_t counter, uint8_t directi=
on,
> -                                       uint64_t uid, void *user_data)
> -{
> -       if (!uid)
> -               return -ENOTDIR;
> -
> -       avrcp_change_path_rsp(session, transaction, AVRCP_STATUS_SUCCESS,=
 0);
> -
> -       return 0;
> -}
> -
> -static int get_item_attributes(struct avrcp *session, uint8_t transactio=
n,
> -                                       uint8_t scope, uint64_t uid,
> -                                       uint16_t counter, uint8_t number,
> -                                       uint32_t *attrs, void *user_data)
> -{
> -       struct context *context =3D user_data;
> -       uint8_t status;
> -
> -       if (g_str_equal(context->data->test_name, "/TP/MCN/CB/BI-05-C"))
> -               status =3D AVRCP_STATUS_UID_CHANGED;
> -       else
> -               status =3D AVRCP_STATUS_SUCCESS;
> -
> -       avrcp_get_item_attributes_rsp(session, transaction, status, 0, NU=
LL,
> -                                                                       N=
ULL);
> -
> -       return 0;
> -}
> -
> -static int play_item(struct avrcp *session, uint8_t transaction, uint8_t=
 scope,
> -                       uint64_t uid, uint16_t counter, void *user_data)
> -{
> -       if (!uid)
> -               return -ENOENT;
> -
> -       avrcp_play_item_rsp(session, transaction, AVRCP_STATUS_SUCCESS);
> -
> -       return 0;
> -}
> -
> -static int search(struct avrcp *session, uint8_t transaction,
> -                                       const char *string, void *user_da=
ta)
> -{
> -       avrcp_search_rsp(session, transaction, AVRCP_STATUS_SUCCESS, 0xaa=
bb, 0);
> -
> -       return 0;
> -}
> -
> -static int add_to_now_playing(struct avrcp *session, uint8_t transaction=
,
> -                               uint8_t scope, uint64_t uid, uint16_t cou=
nter,
> -                               void *user_data)
> -{
> -       if (!uid)
> -               return -ENOENT;
> -
> -       avrcp_add_to_now_playing_rsp(session, transaction,
> -                                                       AVRCP_STATUS_SUCC=
ESS);
> -
> -       return 0;
> -}
> -
> -static const struct avrcp_control_ind control_ind =3D {
> -       .get_capabilities =3D get_capabilities,
> -       .list_attributes =3D list_attributes,
> -       .get_attribute_text =3D get_attribute_text,
> -       .list_values =3D list_values,
> -       .get_value_text =3D get_value_text,
> -       .get_value =3D get_value,
> -       .set_value =3D set_value,
> -       .get_play_status =3D get_play_status,
> -       .get_element_attributes =3D get_element_attributes,
> -       .register_notification =3D register_notification,
> -       .set_volume =3D set_volume,
> -       .set_addressed =3D set_addressed,
> -       .set_browsed =3D set_browsed,
> -       .get_folder_items =3D get_folder_items,
> -       .change_path =3D change_path,
> -       .get_item_attributes =3D get_item_attributes,
> -       .play_item =3D play_item,
> -       .search =3D search,
> -       .add_to_now_playing =3D add_to_now_playing,
> -};
> -
> -static void test_server(gconstpointer data)
> -{
> -       struct context *context =3D create_context(0x0100, data);
> -
> -       avrcp_set_passthrough_handlers(context->session, passthrough_hand=
lers,
> -                                                               context);
> -       avrcp_register_player(context->session, &control_ind, NULL, conte=
xt);
> -
> -       g_idle_add(send_pdu, context);
> -}
> -
> -static void get_folder_items_rsp(struct avrcp *session, int err,
> -                                       uint16_t counter, uint16_t number=
,
> -                                       uint8_t *params, void *user_data)
> -{
> -       struct context *context =3D user_data;
> -
> -       g_assert_cmpint(err, =3D=3D, 0);
> -       g_assert_cmpint(counter, =3D=3D, 0xabcd);
> -       g_assert_cmpint(number, =3D=3D, 0);
> -
> -       context_quit(context);
> -}
> -
> -static void set_volume_rsp(struct avrcp *session, int err, uint8_t volum=
e,
> -                                                       void *user_data)
> -{
> -       struct context *context =3D user_data;
> -
> -       g_assert_cmpint(err, =3D=3D, 0);
> -       g_assert_cmpint(volume, =3D=3D, 1);
> -
> -       context_quit(context);
> -}
> -
> -static bool register_notification_rsp(struct avrcp *session, int err,
> -                                       uint8_t code, uint8_t event,
> -                                       void *params, void *user_data)
> -{
> -       struct context *context =3D user_data;
> -       uint8_t *p =3D params;
> -
> -       g_assert_cmpint(err, =3D=3D, 0);
> -
> -       switch (event) {
> -       case AVRCP_EVENT_VOLUME_CHANGED:
> -               if (g_str_equal(context->data->test_name, "/TP/VLH/BV-03-=
C")) {
> -                       g_assert_cmpint(p[0], =3D=3D, 0);
> -                       break;
> -               } else if (code =3D=3D AVC_CTYPE_INTERIM) {
> -                       g_assert_cmpint(p[0], =3D=3D, 0);
> -                       return true;
> -               }
> -               g_assert_cmpint(p[0], =3D=3D, 1);
> -               break;
> -       }
> -
> -       context_quit(context);
> -
> -       return false;
> -}
> -
> -static const struct avrcp_control_cfm control_cfm =3D {
> -       .register_notification =3D register_notification_rsp,
> -       .set_volume =3D set_volume_rsp,
> -       .get_folder_items =3D get_folder_items_rsp,
> -};
> -
> -static void test_client(gconstpointer data)
> -{
> -       struct context *context =3D create_context(0x0100, data);
> -
> -       avrcp_register_player(context->session, NULL, &control_cfm, conte=
xt);
> -
> -       if (g_str_equal(context->data->test_name, "/TP/MPS/BV-01-C"))
> -               avrcp_set_addressed_player(context->session, 0xabcd);
> -
> -       if (g_str_equal(context->data->test_name, "/TP/MPS/BV-03-C"))
> -               avrcp_set_browsed_player(context->session, 0xabcd);
> -
> -       if (g_str_equal(context->data->test_name, "/TP/MPS/BV-06-C") ||
> -               g_str_equal(context->data->test_name, "/TP/MPS/BV-08-C"))
> -               avrcp_get_folder_items(context->session,
> -                                       AVRCP_MEDIA_PLAYER_LIST, 0, 2, 0,=
 NULL);
> -
> -       if (g_str_equal(context->data->test_name, "/TP/MPS/BV-01-I"))
> -               avrcp_get_folder_items(context->session,
> -                                       AVRCP_MEDIA_PLAYER_LIST, 0, 2, 0,=
 NULL);
> -
> -       if (g_str_equal(context->data->test_name, "/TP/MCN/CB/BV-01-C"))
> -               avrcp_get_folder_items(context->session,
> -                                       AVRCP_MEDIA_PLAYER_VFS, 0, 2, 0, =
NULL);
> -
> -       if (g_str_equal(context->data->test_name, "/TP/MCN/CB/BV-04-C"))
> -               avrcp_change_path(context->session, 0x01, 0x01, 0xaabb);
> -
> -       if (g_str_equal(context->data->test_name, "/TP/MCN/CB/BV-07-C"))
> -               avrcp_get_item_attributes(context->session,
> -                                       AVRCP_MEDIA_PLAYER_VFS, 0x01, 0xa=
abb,
> -                                       0, NULL);
> -
> -       if (g_str_equal(context->data->test_name, "/TP/MCN/SRC/BV-01-C"))
> -               avrcp_search(context->session, "Country");
> -
> -       if (g_str_equal(context->data->test_name, "/TP/MCN/SRC/BV-03-C"))
> -               avrcp_get_folder_items(context->session, AVRCP_MEDIA_SEAR=
CH,
> -                                               0, 2, 0, NULL);
> -
> -       if (g_str_equal(context->data->test_name, "/TP/MCN/SRC/BV-05-C"))
> -               avrcp_get_item_attributes(context->session,
> -                                       AVRCP_MEDIA_SEARCH, 0x01, 0xaabb,
> -                                       0, NULL);
> -
> -       if (g_str_equal(context->data->test_name, "/TP/MCN/NP/BV-01-C"))
> -               avrcp_play_item(context->session, AVRCP_MEDIA_NOW_PLAYING=
, 1,
> -                                                                       1=
);
> -
> -       if (g_str_equal(context->data->test_name, "/TP/MCN/NP/BV-03-C"))
> -               avrcp_add_to_now_playing(context->session,
> -                                       AVRCP_MEDIA_NOW_PLAYING, 0x01, 0x=
aabb);
> -
> -       if (g_str_equal(context->data->test_name, "/TP/MCN/NP/BV-05-C"))
> -               avrcp_get_folder_items(context->session,
> -                                       AVRCP_MEDIA_NOW_PLAYING, 0, 2, 0,=
 NULL);
> -
> -       if (g_str_equal(context->data->test_name, "/TP/MCN/NP/BV-08-C"))
> -               avrcp_get_item_attributes(context->session,
> -                                       AVRCP_MEDIA_NOW_PLAYING, 0x01, 0x=
aabb,
> -                                       0, NULL);
> -
> -       if (g_str_equal(context->data->test_name, "/TP/CFG/BV-01-C"))
> -               avrcp_get_capabilities(context->session, CAP_EVENTS_SUPPO=
RTED);
> -
> -       if (g_str_equal(context->data->test_name, "/TP/PAS/BV-01-C"))
> -               avrcp_list_player_attributes(context->session);
> -
> -       if (g_str_equal(context->data->test_name, "/TP/PAS/BV-03-C")) {
> -               uint8_t attrs[2] =3D { AVRCP_ATTRIBUTE_EQUALIZER,
> -                                               AVRCP_ATTRIBUTE_REPEAT_MO=
DE };
> -
> -               avrcp_get_player_attribute_text(context->session, sizeof(=
attrs),
> -                                                                       a=
ttrs);
> -       }
> -
> -       if (g_str_equal(context->data->test_name, "/TP/PAS/BV-05-C"))
> -               avrcp_list_player_values(context->session,
> -                                               AVRCP_ATTRIBUTE_EQUALIZER=
);
> -
> -       if (g_str_equal(context->data->test_name, "/TP/PAS/BV-07-C")) {
> -               uint8_t values[2] =3D { AVRCP_EQUALIZER_OFF, AVRCP_EQUALI=
ZER_ON };
> -
> -               avrcp_get_player_value_text(context->session,
> -                                               AVRCP_ATTRIBUTE_EQUALIZER=
,
> -                                               sizeof(values), values);
> -       }
> -
> -       if (g_str_equal(context->data->test_name, "/TP/PAS/BV-09-C")) {
> -               uint8_t attrs[2] =3D { AVRCP_ATTRIBUTE_EQUALIZER,
> -                                               AVRCP_ATTRIBUTE_REPEAT_MO=
DE };
> -
> -               avrcp_get_current_player_value(context->session, sizeof(a=
ttrs),
> -                                                                       a=
ttrs);
> -       }
> -
> -       if (g_str_equal(context->data->test_name, "/TP/PAS/BV-11-C")) {
> -               uint8_t attrs[2] =3D { AVRCP_ATTRIBUTE_EQUALIZER,
> -                                               AVRCP_ATTRIBUTE_REPEAT_MO=
DE };
> -               uint8_t values[2] =3D { 0xaa, 0xff };
> -
> -               avrcp_set_player_value(context->session, sizeof(attrs), a=
ttrs,
> -                                                               values);
> -       }
> -
> -       if (g_str_equal(context->data->test_name, "/TP/MDI/BV-01-C"))
> -               avrcp_get_play_status(context->session);
> -
> -       if (g_str_equal(context->data->test_name, "/TP/MDI/BV-03-C"))
> -               avrcp_get_element_attributes(context->session);
> -
> -       if (g_str_equal(context->data->test_name, "/TP/NFY/BV-01-C"))
> -               avrcp_register_notification(context->session,
> -                                               AVRCP_EVENT_STATUS_CHANGE=
D, 0);
> -
> -       if (g_str_equal(context->data->test_name, "/TP/BGN/BV-01-I"))
> -               avrcp_send_passthrough(context->session, IEEEID_BTSIG,
> -                                               AVC_VENDOR_NEXT_GROUP);
> -
> -       if (g_str_equal(context->data->test_name, "/TP/BGN/BV-02-I"))
> -               avrcp_send_passthrough(context->session, IEEEID_BTSIG,
> -                                               AVC_VENDOR_PREV_GROUP);
> -
> -       if (g_str_equal(context->data->test_name, "/TP/VLH/BV-01-C"))
> -               avrcp_set_volume(context->session, 0x00);
> -
> -       if (g_str_equal(context->data->test_name, "/TP/VLH/BV-03-C"))
> -               avrcp_register_notification(context->session,
> -                                               AVRCP_EVENT_VOLUME_CHANGE=
D, 0);
> -
> -       if (g_str_equal(context->data->test_name, "/TP/VLH/BI-03-C"))
> -               avrcp_set_volume(context->session, 0x01);
> -
> -       if (g_str_equal(context->data->test_name, "/TP/VLH/BI-04-C"))
> -               avrcp_register_notification(context->session,
> -                                               AVRCP_EVENT_VOLUME_CHANGE=
D, 0);
> -
> -       if (g_str_equal(context->data->test_name, "/TP/PTH/BV-01-C"))
> -               avrcp_send_passthrough(context->session, 0, AVC_PLAY);
> -
> -       if (g_str_equal(context->data->test_name, "/TP/PTH/BV-02-C"))
> -               avrcp_send_passthrough(context->session, 0, AVC_FAST_FORW=
ARD);
> -}
> -
> -int main(int argc, char *argv[])
> -{
> -       tester_init(&argc, &argv);
> -
> -       __btd_log_init("*", 0);
> -
> -       /* Media Player Selection Commands and Notifications */
> -
> -       /* SetAddressedPlayer - CT */
> -       define_test("/TP/MPS/BV-01-C", test_client,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, 0x60, 0x00, 0x00,
> -                               0x02, 0xab, 0xcd));
> -
> -       /* SetAddressedPlayer - TG */
> -       define_test("/TP/MPS/BV-02-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_SET_ADDRESSED_PLA=
YER,
> -                               0x00, 0x00, 0x02, 0xab, 0xcd),
> -                       raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_STABLE,
> -                               0x48, 0x00, 0x00, 0x19, 0x58,
> -                               AVRCP_SET_ADDRESSED_PLAYER,
> -                               0x00, 0x00, 0x01, 0x04));
> -
> -       /* SetBrowsedPlayer - CT */
> -       define_test("/TP/MPS/BV-03-C", test_client,
> -                       brs_pdu(0x00, 0x11, 0x0e, 0x70, 0x00, 0x02,
> -                               0xab, 0xcd));
> -
> -       /* SetBrowsedPlayer - TG */
> -       define_test("/TP/MPS/BV-04-C", test_server,
> -                       brs_pdu(0x00, 0x11, 0x0e, 0x70, 0x00, 0x02,
> -                               0xab, 0xcd),
> -                       brs_pdu(0x02, 0x11, 0x0e, 0x70, 0x00, 0x16,
> -                               0x04, 0xab, 0xcd, 0x00, 0x00, 0x00,
> -                               0x00, 0x00, 0x6a, 0x01, 0x00, 0x0a,
> -                               0x46, 0x69, 0x6c, 0x65, 0x73, 0x79,
> -                               0x73, 0x74, 0x65, 0x6d));
> -
> -       /* AddressedPlayerChanged notification =E2=80=93 TG */
> -       define_test("/TP/MPS/BV-05-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x03, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x05, 0x0b,
> -                               0x00, 0x00, 0x00, 0x00),
> -                       frg_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_INTERIM, 0x48=
, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x05, 0x0b,
> -                               0x00, 0x01, 0x00, 0x01),
> -                       raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_CHANGED, 0x48=
, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x05, 0x0b,
> -                               0x02, 0x00, 0x02, 0x00));
> -
> -       /* GetFolderItems - CT */
> -       define_test("/TP/MPS/BV-06-C", test_client,
> -                       brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
> -                               0x00, 0x0a, AVRCP_MEDIA_PLAYER_LIST,
> -                               0x00, 0x00, 0x00, 0x00, /* start */
> -                               0x00, 0x00, 0x00, 0x02, /* end */
> -                               0x00),
> -                       brs_pdu(0x02, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
> -                               0x00, 0x05, 0x04, 0xab, 0xcd, 0x00, 0x00)=
);
> -
> -       /* AvailablePlayersChanged Notification =E2=80=93 TG */
> -       define_test("/TP/MPS/BV-07-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x03, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x05, 0x0a,
> -                               0x00, 0x00, 0x00, 0x00),
> -                       frg_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_INTERIM, 0x48=
, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x01, 0x0a),
> -                       raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_CHANGED, 0x48=
, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x01, 0x0a));
> -
> -       /* GetFolderItems - CT */
> -       define_test("/TP/MPS/BV-08-C", test_client,
> -                       brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
> -                               0x00, 0x0a, AVRCP_MEDIA_PLAYER_LIST,
> -                               0x00, 0x00, 0x00, 0x00, /* start */
> -                               0x00, 0x00, 0x00, 0x02, /* end */
> -                               0x00));
> -
> -       /* GetFolderItems - TG */
> -       define_test("/TP/MPS/BV-09-C", test_server,
> -                       brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
> -                               0x00, 0x0a, AVRCP_MEDIA_PLAYER_LIST,
> -                               0x00, 0x00, 0x00, 0x00, /* start */
> -                               0x00, 0x00, 0x00, 0x02, /* end */
> -                               0x00),
> -                       brs_pdu(0x02, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
> -                               0x00, 0x05, 0x04, 0xab, 0xcd, 0x00, 0x00)=
);
> -
> -       /* SetAddressedPlayer - TG */
> -       define_test("/TP/MPS/BI-01-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_SET_ADDRESSED_PLA=
YER,
> -                               0x00, 0x00, 0x02, 0xab, 0xcd),
> -                       raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_STABLE,
> -                               0x48, 0x00, 0x00, 0x19, 0x58,
> -                               AVRCP_SET_ADDRESSED_PLAYER,
> -                               0x00, 0x00, 0x01, 0x11));
> -
> -       /* SetBrowsedPlayer - TG */
> -       define_test("/TP/MPS/BI-02-C", test_server,
> -                       brs_pdu(0x00, 0x11, 0x0e, 0x70, 0x00, 0x02,
> -                               0xab, 0xcd),
> -                       brs_pdu(0x02, 0x11, 0x0e, 0x70, 0x00, 0x01,
> -                               0x11));
> -
> -       /*
> -        * Media Content Navigation Commands and Notifications for Conten=
t
> -        * Browsing.
> -        */
> -
> -       /* GetFolderItems - Virtual FS - CT */
> -       define_test("/TP/MCN/CB/BV-01-C", test_client,
> -                       brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
> -                               0x00, 0x0a, AVRCP_MEDIA_PLAYER_VFS,
> -                               0x00, 0x00, 0x00, 0x00, /* start */
> -                               0x00, 0x00, 0x00, 0x02, /* end */
> -                               0x00));
> -
> -       /* GetFolderItems - Virtual FS - TG */
> -       define_test("/TP/MCN/CB/BV-02-C", test_server,
> -                       brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
> -                               0x00, 0x0a, AVRCP_MEDIA_PLAYER_VFS,
> -                               0x00, 0x00, 0x00, 0x00, /* start */
> -                               0x00, 0x00, 0x00, 0x02, /* end */
> -                               0x00),
> -                       brs_pdu(0x02, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
> -                               0x00, 0x05, 0x04, 0xab, 0xcd, 0x00, 0x00)=
);
> -
> -       /* GetFolderItems - Virtual FS - TG */
> -       define_test("/TP/MCN/CB/BV-03-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_SET_ADDRESSED_PLA=
YER,
> -                               0x00, 0x00, 0x02, 0xab, 0xcd),
> -                       raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_STABLE,
> -                               0x48, 0x00, 0x00, 0x19, 0x58,
> -                               AVRCP_SET_ADDRESSED_PLAYER,
> -                               0x00, 0x00, 0x01, 0x04),
> -                       brs_pdu(0x00, 0x11, 0x0e, 0x70, 0x00, 0x02,
> -                               0xab, 0xcd),
> -                       brs_pdu(0x02, 0x11, 0x0e, 0x70, 0x00, 0x16,
> -                               0x04, 0xab, 0xcd, 0x00, 0x00, 0x00,
> -                               0x00, 0x00, 0x6a, 0x01, 0x00, 0x0a,
> -                               0x46, 0x69, 0x6c, 0x65, 0x73, 0x79,
> -                               0x73, 0x74, 0x65, 0x6d),
> -                       brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
> -                               0x00, 0x0a, AVRCP_MEDIA_PLAYER_VFS,
> -                               0x00, 0x00, 0x00, 0x00, /* start */
> -                               0x00, 0x00, 0x00, 0x02, /* end */
> -                               0x00),
> -                       brs_pdu(0x02, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
> -                               0x00, 0x05, 0x04, 0xab, 0xcd, 0x00, 0x00)=
);
> -
> -       /* ChangePath - CT */
> -       define_test("/TP/MCN/CB/BV-04-C", test_client,
> -                       brs_pdu(0x00, 0x11, 0x0e, AVRCP_CHANGE_PATH,
> -                               0x00, 0x0b,
> -                               0xaa, 0xbb,             /* counter */
> -                               0x01,                   /* direction */
> -                               0x00, 0x00, 0x00, 0x00,
> -                               0x00, 0x00, 0x00, 0x01  /* Folder UID */)=
);
> -
> -       /* ChangePath - TG */
> -       define_test("/TP/MCN/CB/BV-05-C", test_server,
> -                       brs_pdu(0x00, 0x11, 0x0e, AVRCP_CHANGE_PATH,
> -                               0x00, 0x0b,
> -                               0xaa, 0xbb,             /* counter */
> -                               0x01,                   /* direction */
> -                               0x00, 0x00, 0x00, 0x00,
> -                               0x00, 0x00, 0x00, 0x01  /* Folder UID */)=
,
> -                       brs_pdu(0x02, 0x11, 0x0e, AVRCP_CHANGE_PATH,
> -                               0x00, 0x05, 0x04, 0x00, 0x00, 0x00, 0x00)=
);
> -
> -       /* ChangePath - TG */
> -       define_test("/TP/MCN/CB/BV-06-C", test_server,
> -                       brs_pdu(0x00, 0x11, 0x0e, AVRCP_CHANGE_PATH,
> -                               0x00, 0x0b,
> -                               0xaa, 0xbb,             /* counter */
> -                               0x00,                   /* direction */
> -                               0x00, 0x00, 0x00, 0x00,
> -                               0x00, 0x00, 0x00, 0x01  /* Folder UID */)=
,
> -                       brs_pdu(0x02, 0x11, 0x0e, AVRCP_CHANGE_PATH,
> -                               0x00, 0x05, 0x04, 0x00, 0x00, 0x00, 0x00)=
);
> -
> -       /* GetItemAttributes - CT */
> -       define_test("/TP/MCN/CB/BV-07-C", test_client,
> -                       brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_ITEM_ATTRIBUT=
ES,
> -                               0x00, 0x0c, AVRCP_MEDIA_PLAYER_VFS,
> -                               0x00, 0x00, 0x00, 0x00,
> -                               0x00, 0x00, 0x00, 0x01, /* uuid */
> -                               0xaa, 0xbb,             /* counter */
> -                               0x00));                 /* num attr */
> -
> -       /* GetItemAttributes - TG */
> -       define_test("/TP/MCN/CB/BV-08-C", test_server,
> -                       brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_ITEM_ATTRIBUT=
ES,
> -                               0x00, 0x0c, AVRCP_MEDIA_PLAYER_VFS,
> -                               0x00, 0x00, 0x00, 0x00,
> -                               0x00, 0x00, 0x00, 0x01, /* uuid */
> -                               0xaa, 0xbb,             /* counter */
> -                               0x00),                  /* num attr */
> -                       brs_pdu(0x02, 0x11, 0x0e, AVRCP_GET_ITEM_ATTRIBUT=
ES,
> -                               0x00, 0x02, 0x04, 0x00));
> -
> -       /* UIDcounter - TG */
> -       define_test("/TP/MCN/CB/BV-09-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x03, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x05, 0x0c,
> -                               0x00, 0x00, 0x00, 0x00),
> -                       raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_INTERIM, 0x48=
, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x03, 0x0c,
> -                               0x00, 0x00));
> -
> -       /* UIDcounter - TG */
> -       define_test("/TP/MCN/CB/BV-10-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x03, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x05, 0x0c,
> -                               0x00, 0x00, 0x00, 0x00),
> -                       raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_INTERIM, 0x48=
, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x03, 0x0c,
> -                               0x00, 0x01));
> -
> -       /* UIDcounter - TG */
> -       define_test("/TP/MCN/CB/BV-11-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x03, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x05, 0x0c,
> -                               0x00, 0x00, 0x00, 0x00),
> -                       frg_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_INTERIM, 0x48=
, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x03, 0x0c,
> -                               0x00, 0x01),
> -                       raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_CHANGED, 0x48=
, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x03, 0x0c,
> -                               0x02, 0x00));
> -
> -       /* GetFolderItems - Virtual FS - TG */
> -       define_test("/TP/MCN/CB/BI-01-C", test_server,
> -                       brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
> -                               0x00, 0x0a, AVRCP_MEDIA_PLAYER_VFS,
> -                               0x00, 0x00, 0x00, 0x01, /* start */
> -                               0x00, 0x00, 0x00, 0x00, /* end */
> -                               0x00),
> -                       brs_pdu(0x02, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
> -                               0x00, 0x01, 0x0b));
> -
> -       /* GetFolderItems - Virtual FS - TG */
> -       define_test("/TP/MCN/CB/BI-02-C", test_server,
> -                       brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
> -                               0x00, 0x0a, AVRCP_MEDIA_PLAYER_VFS,
> -                               0x00, 0x00, 0x00, 0x00, /* start */
> -                               0x00, 0x00, 0x00, 0x01, /* end */
> -                               0x00),
> -                       brs_pdu(0x02, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
> -                               0x00, 0x01, 0x0b));
> -
> -       /* GetFolderItems - Virtual FS - TG */
> -       define_test("/TP/MCN/CB/BI-03-C", test_server,
> -                       brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
> -                               0x00, 0x0a, AVRCP_MEDIA_PLAYER_VFS,
> -                               0x00, 0x00, 0x00, 0x02, /* start */
> -                               0x00, 0x00, 0x00, 0x03, /* end */
> -                               0x00),
> -                       brs_pdu(0x02, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
> -                               0x00, 0x01, 0x0b));
> -
> -       /* ChangePath - TG */
> -       define_test("/TP/MCN/CB/BI-04-C", test_server,
> -                       brs_pdu(0x00, 0x11, 0x0e, AVRCP_CHANGE_PATH,
> -                               0x00, 0x0b,
> -                               0xaa, 0xbb,             /* counter */
> -                               0x01,                   /* direction */
> -                               0x00, 0x00, 0x00, 0x00,
> -                               0x00, 0x00, 0x00, 0x00  /* Folder UID */)=
,
> -                       brs_pdu(0x02, 0x11, 0x0e, AVRCP_CHANGE_PATH,
> -                               0x00, 0x01, 0x08));
> -
> -       /* UIDcounter - TG */
> -       define_test("/TP/MCN/CB/BI-05-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x03, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x05, 0x0c,
> -                               0x00, 0x00, 0x00, 0x00),
> -                       frg_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_INTERIM, 0x48=
, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x03, 0x0c,
> -                               0x00, 0x01),
> -                       raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_CHANGED, 0x48=
, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x03, 0x0c,
> -                               0x02, 0x00),
> -                       brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_ITEM_ATTRIBUT=
ES,
> -                               0x00, 0x0c, AVRCP_MEDIA_NOW_PLAYING,
> -                               0x00, 0x00, 0x00, 0x00,
> -                               0x00, 0x00, 0x00, 0x01,
> -                               0xaa, 0xbb,
> -                               0x00),
> -                       brs_pdu(0x02, 0x11, 0x0e, AVRCP_GET_ITEM_ATTRIBUT=
ES,
> -                               0x00, 0x01, 0x05));
> -
> -       /* Media Content Navigation Commands and Notifications for Search=
 */
> -
> -       /* Search - CT */
> -       define_test("/TP/MCN/SRC/BV-01-C", test_client,
> -                       brs_pdu(0x00, 0x11, 0x0e, AVRCP_SEARCH,
> -                               0x00, 0x0b, 0x00, 0x6a,
> -                               0x00, 0x07,
> -                               0x43, 0x6f, 0x75, 0x6e, 0x74, 0x72, 0x79)=
);
> -
> -       define_test("/TP/MCN/SRC/BV-02-C", test_server,
> -                       brs_pdu(0x00, 0x11, 0x0e, AVRCP_SEARCH,
> -                               0x00, 0x0b, 0x00, 0x6a,
> -                               0x00, 0x07,
> -                               0x43, 0x6f, 0x75, 0x6e, 0x74, 0x72, 0x79)=
,
> -                       brs_pdu(0x02, 0x11, 0x0e, AVRCP_SEARCH,
> -                               0x00, 0x07, 0x04,
> -                               0xaa, 0xbb,             /* counter */
> -                               0x00, 0x00, 0x00, 0x00));
> -
> -       /* GetFolderItems - CT */
> -       define_test("/TP/MCN/SRC/BV-03-C", test_client,
> -                       brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
> -                               0x00, 0x0a, AVRCP_MEDIA_SEARCH,
> -                               0x00, 0x00, 0x00, 0x00, /* start */
> -                               0x00, 0x00, 0x00, 0x02, /* end */
> -                               0x00));
> -
> -       /* GetFolderItems - NowPlaying - TG */
> -       define_test("/TP/MCN/SCR/BV-04-C", test_server,
> -                       brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
> -                               0x00, 0x0a, AVRCP_MEDIA_SEARCH,
> -                               0x00, 0x00, 0x00, 0x00, /* start */
> -                               0x00, 0x00, 0x00, 0x02, /* end */
> -                               0x00),
> -                       brs_pdu(0x02, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
> -                               0x00, 0x05, 0x04, 0xab, 0xcd, 0x00, 0x00)=
);
> -
> -       /* GetItemAttributes - CT */
> -       define_test("/TP/MCN/SRC/BV-05-C", test_client,
> -                       brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_ITEM_ATTRIBUT=
ES,
> -                               0x00, 0x0c, AVRCP_MEDIA_SEARCH,
> -                               0x00, 0x00, 0x00, 0x00,
> -                               0x00, 0x00, 0x00, 0x01, /* uuid */
> -                               0xaa, 0xbb,             /* counter */
> -                               0x00));                 /* num attr */
> -
> -       /* GetItemAttributes - TG */
> -       define_test("/TP/MCN/SRC/BV-06-C", test_server,
> -                       brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_ITEM_ATTRIBUT=
ES,
> -                               0x00, 0x0c, AVRCP_MEDIA_SEARCH,
> -                               0x00, 0x00, 0x00, 0x00,
> -                               0x00, 0x00, 0x00, 0x01, /* uid */
> -                               0xaa, 0xbb,             /* counter */
> -                               0x00),                  /* num attr */
> -                       brs_pdu(0x02, 0x11, 0x0e, AVRCP_GET_ITEM_ATTRIBUT=
ES,
> -                               0x00, 0x02, 0x04, 0x00));
> -
> -       /* Media Content Navigation Commands and Notifications for NowPla=
ying */
> -
> -       /* PlayItem - NowPlaying - CT */
> -       define_test("/TP/MCN/NP/BV-01-C", test_client,
> -                       brs_pdu(0x00, 0x11, 0x0e, AVRCP_PLAY_ITEM,
> -                               0x00, 0x0b, AVRCP_MEDIA_NOW_PLAYING,
> -                               0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,=
 0x01,
> -                               0x00, 0x01));
> -
> -       /* PlayItem - NowPlaying - TG */
> -       define_test("/TP/MCN/NP/BV-02-C", test_server,
> -                       brs_pdu(0x00, 0x11, 0x0e, AVRCP_PLAY_ITEM,
> -                               0x00, 0x0b, AVRCP_MEDIA_NOW_PLAYING,
> -                               0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,=
 0x01,
> -                               0x00, 0x01),
> -                       brs_pdu(0x02, 0x11, 0x0e, AVRCP_PLAY_ITEM,
> -                               0x00, 0x01, 0x04));
> -
> -       /* AddToNowPlaying - NowPlaying - CT */
> -       define_test("/TP/MCN/NP/BV-03-C", test_client,
> -                       brs_pdu(0x00, 0x11, 0x0e, AVRCP_ADD_TO_NOW_PLAYIN=
G,
> -                               0x00, 0x0b, AVRCP_MEDIA_NOW_PLAYING,
> -                               0x00, 0x00, 0x00, 0x00,
> -                               0x00, 0x00, 0x00, 0x01, /* uid */
> -                               0xaa, 0xbb));
> -
> -       /* AddToNowPlaying - NowPlaying - TG */
> -       define_test("/TP/MCN/NP/BV-04-C", test_server,
> -                       brs_pdu(0x00, 0x11, 0x0e, AVRCP_ADD_TO_NOW_PLAYIN=
G,
> -                               0x00, 0x0b, AVRCP_MEDIA_NOW_PLAYING,
> -                               0x00, 0x00, 0x00, 0x00,
> -                               0x00, 0x00, 0x00, 0x01, /* uid */
> -                               0xaa, 0xbb),
> -                       brs_pdu(0x02, 0x11, 0x0e, AVRCP_ADD_TO_NOW_PLAYIN=
G,
> -                               0x00, 0x01, 0x04));
> -
> -       /* GetFolderItems - NowPlaying - CT */
> -       define_test("/TP/MCN/NP/BV-05-C", test_client,
> -                       brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
> -                               0x00, 0x0a, AVRCP_MEDIA_NOW_PLAYING,
> -                               0x00, 0x00, 0x00, 0x00, /* start */
> -                               0x00, 0x00, 0x00, 0x02, /* end */
> -                               0x00));
> -
> -       /* GetFolderItems - NowPlaying - TG */
> -       define_test("/TP/MCN/NP/BV-06-C", test_server,
> -                       brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
> -                               0x00, 0x0a, AVRCP_MEDIA_NOW_PLAYING,
> -                               0x00, 0x00, 0x00, 0x00, /* start */
> -                               0x00, 0x00, 0x00, 0x02, /* end */
> -                               0x00),
> -                       brs_pdu(0x02, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
> -                               0x00, 0x05, 0x04, 0xab, 0xcd, 0x00, 0x00)=
);
> -
> -       /* NowPlayingContentChanged Notification =E2=80=93 TG */
> -       define_test("/TP/MCN/NP/BV-07-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x03, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x05, 0x09,
> -                               0x00, 0x00, 0x00, 0x00),
> -                       frg_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_INTERIM, 0x48=
, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x01, 0x09),
> -                       raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_CHANGED, 0x48=
, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x01, 0x09));
> -
> -       /* GetItemAttributes - CT */
> -       define_test("/TP/MCN/NP/BV-08-C", test_client,
> -                       brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_ITEM_ATTRIBUT=
ES,
> -                               0x00, 0x0c, AVRCP_MEDIA_NOW_PLAYING,
> -                               0x00, 0x00, 0x00, 0x00,
> -                               0x00, 0x00, 0x00, 0x01, /* uid */
> -                               0xaa, 0xbb,             /* counter */
> -                               0x00));                 /* num attr */
> -
> -       /* GetItemAttributes - TG */
> -       define_test("/TP/MCN/CB/BV-09-C", test_server,
> -                       brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_ITEM_ATTRIBUT=
ES,
> -                               0x00, 0x0c, AVRCP_MEDIA_NOW_PLAYING,
> -                               0x00, 0x00, 0x00, 0x00,
> -                               0x00, 0x00, 0x00, 0x01, /* uid */
> -                               0xaa, 0xbb,             /* counter */
> -                               0x00),                  /* num attr */
> -                       brs_pdu(0x02, 0x11, 0x0e, AVRCP_GET_ITEM_ATTRIBUT=
ES,
> -                               0x00, 0x02, 0x04, 0x00));
> -
> -       /* PlayItem - NowPlaying - TG */
> -       define_test("/TP/MCN/NP/BI-01-C", test_server,
> -                       brs_pdu(0x00, 0x11, 0x0e, AVRCP_PLAY_ITEM,
> -                               0x00, 0x0b, AVRCP_MEDIA_NOW_PLAYING,
> -                               0x00, 0x00, 0x00, 0x00,
> -                               0x00, 0x00, 0x00, 0x00, /* uid */
> -                               0xaa, 0xbb),            /* counter */
> -                       brs_pdu(0x02, 0x11, 0x0e, AVRCP_PLAY_ITEM,
> -                               0x00, 0x01, 0x09));
> -
> -       /* AddToNowPlaying - NowPlaying - TG */
> -       define_test("/TP/MCN/NP/BI-02-C", test_server,
> -                       brs_pdu(0x00, 0x11, 0x0e, AVRCP_ADD_TO_NOW_PLAYIN=
G,
> -                               0x00, 0x0b, AVRCP_MEDIA_NOW_PLAYING,
> -                               0x00, 0x00, 0x00, 0x00,
> -                               0x00, 0x00, 0x00, 0x00, /* uid */
> -                               0xaa, 0xbb),            /* counter */
> -                       brs_pdu(0x02, 0x11, 0x0e, AVRCP_ADD_TO_NOW_PLAYIN=
G,
> -                               0x00, 0x01, 0x09));
> -
> -       /* Media Player Selection IOP tests */
> -
> -       /* Listing of available media players */
> -       define_test("/TP/MPS/BV-01-I", test_client,
> -                       brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
> -                               0x00, 0x0a, AVRCP_MEDIA_PLAYER_LIST,
> -                               0x00, 0x00, 0x00, 0x00, /* start */
> -                               0x00, 0x00, 0x00, 0x02, /* end */
> -                               0x00));
> -
> -       /* Connection Establishment for Browsing tests */
> -
> -       /*
> -        * Tests are checking connection establishment and release
> -        * for browsing channel. Since we are connected through socketpai=
r
> -        * the tests are dummy
> -        */
> -       define_test("/TP/CON/BV-01-C", test_dummy, raw_pdu(0x00));
> -       define_test("/TP/CON/BV-02-C", test_dummy, raw_pdu(0x00));
> -       define_test("/TP/CON/BV-03-C", test_dummy, raw_pdu(0x00));
> -       define_test("/TP/CON/BV-04-C", test_dummy, raw_pdu(0x00));
> -       define_test("/TP/CON/BV-05-C", test_dummy, raw_pdu(0x00));
> -
> -       /* Connection Establishment for Control tests */
> -
> -       /*
> -        * Tests are checking connection establishement and release
> -        * for control channel. Since we are connected through socketpair
> -        * the tests are dummy
> -        */
> -       define_test("/TP/CEC/BV-01-I", test_dummy, raw_pdu(0x00));
> -       define_test("/TP/CEC/BV-02-I", test_dummy, raw_pdu(0x00));
> -       define_test("/TP/CRC/BV-01-I", test_dummy, raw_pdu(0x00));
> -       define_test("/TP/CRC/BV-02-I", test_dummy, raw_pdu(0x00));
> -
> -       /* Information collection for control tests */
> -
> -       define_test("/TP/ICC/BV-01-I", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x01, 0xf8, 0x30,
> -                               0xff, 0xff, 0xff, 0xff, 0xff),
> -                       raw_pdu(0x02, 0x11, 0x0e, 0x0c, 0xf8, 0x30,
> -                               0x07, 0x48, 0xff, 0xff, 0xff));
> -
> -       define_test("/TP/ICC/BV-02-I", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x01, 0xf8, 0x31,
> -                               0x07, 0xff, 0xff, 0xff, 0xff),
> -                       raw_pdu(0x02, 0x11, 0x0e, 0x0c, 0xf8, 0x31,
> -                               0x07, 0x48, 0xff, 0xff, 0xff));
> -
> -       define_test("/TP/PTT/BV-01-I", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48, 0x7c,
> -                               0x44, 0x00),
> -                       raw_pdu(0x02, 0x11, 0x0e, 0x09, 0x48, 0x7c,
> -                               0x44, 0x00));
> -
> -       define_test("/TP/PTT/BV-02-I", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48, 0x7c,
> -                               AVC_VOLUME_UP, 0x00),
> -                       raw_pdu(0x02, 0x11, 0x0e, 0x09, 0x48, 0x7c,
> -                               AVC_VOLUME_UP, 0x00));
> -
> -       define_test("/TP/PTT/BV-03-I", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48, 0x7c,
> -                               AVC_CHANNEL_UP, 0x00),
> -                       raw_pdu(0x02, 0x11, 0x0e, 0x09, 0x48, 0x7c,
> -                               AVC_CHANNEL_UP, 0x00));
> -
> -       define_test("/TP/PTT/BV-04-I", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48, 0x7c,
> -                               AVC_SELECT, 0x00),
> -                       raw_pdu(0x02, 0x11, 0x0e, 0x09, 0x48, 0x7c,
> -                               AVC_SELECT, 0x00));
> -
> -       define_test("/TP/PTT/BV-05-I", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48, 0x7c,
> -                               AVC_PLAY, 0x00),
> -                       raw_pdu(0x02, 0x11, 0x0e, 0x09, 0x48, 0x7c,
> -                               AVC_PLAY, 0x00),
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48, 0x7c,
> -                               AVC_PLAY | 0x80, 0x00),
> -                       raw_pdu(0x02, 0x11, 0x0e, 0x09, 0x48, 0x7c,
> -                               AVC_PLAY | 0x80, 0x00));
> -
> -       /* Metadata transfer tests */
> -
> -       define_test("/TP/CFG/BV-01-C", test_client,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, 0x10, 0x00, 0x00,
> -                               0x01, 0x03));
> -
> -       define_test("/TP/CFG/BV-02-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, 0x10, 0x00, 0x00,
> -                               0x01, 0x02),
> -                       raw_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, 0x10, 0x00, 0x00,
> -                               0x05, 0x02, 0x01, 0x00, 0x19, 0x58));
> -
> -       define_test("/TP/CFG/BI-01-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, 0x10, 0x00, 0x00,
> -                               0x01, 0x7f),
> -                       raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_REJECTED,
> -                               0x48, 0x00, 0x00, 0x19, 0x58, 0x10,
> -                               0x00, 0x00, 0x01,
> -                               AVRCP_STATUS_INVALID_PARAM));
> -
> -       /* Player Application Settings tests */
> -
> -       define_test("/TP/PAS/BV-01-C", test_client,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, 0x11, 0x00, 0x00,
> -                               0x00));
> -
> -       define_test("/TP/PAS/BV-02-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, 0x11, 0x00, 0x00,
> -                               0x00),
> -                       raw_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, 0x11, 0x00, 0x00,
> -                               0x01, 0x00));
> -
> -       define_test("/TP/PAS/BV-03-C", test_client,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
> -                               0x00, 0x19, 0x58,
> -                               AVRCP_GET_PLAYER_ATTRIBUTE_TEXT,
> -                               0x00, 0x00, 0x03, 0x02,
> -                               AVRCP_ATTRIBUTE_EQUALIZER,
> -                               AVRCP_ATTRIBUTE_REPEAT_MODE));
> -
> -       define_test("/TP/PAS/BV-04-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
> -                               0x00, 0x19, 0x58,
> -                               AVRCP_GET_PLAYER_ATTRIBUTE_TEXT,
> -                               0x00, 0x00, 0x02, 0x01, 0x01),
> -                       raw_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
> -                               0x00, 0x19, 0x58,
> -                               AVRCP_GET_PLAYER_ATTRIBUTE_TEXT,
> -                               0x00, 0x00, 0x0e, 0x01, 0x01, 0x00,
> -                               0x6a, 0x09, 0x65, 0x71, 0x75, 0x61,
> -                               0x6c, 0x69, 0x7a, 0x65, 0x72));
> -
> -       define_test("/TP/PAS/BV-05-C", test_client,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
> -                               0x00, 0x19, 0x58,
> -                               AVRCP_LIST_PLAYER_VALUES,
> -                               0x00, 0x00, 0x01,
> -                               AVRCP_ATTRIBUTE_EQUALIZER));
> -
> -       define_test("/TP/PAS/BV-06-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
> -                               0x00, 0x19, 0x58,
> -                               AVRCP_LIST_PLAYER_VALUES,
> -                               0x00, 0x00, 0x01, AVRCP_ATTRIBUTE_EQUALIZ=
ER),
> -                       raw_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
> -                               0x00, 0x19, 0x58,
> -                               AVRCP_LIST_PLAYER_VALUES,
> -                               0x00, 0x00, 0x01, 0x00));
> -
> -       define_test("/TP/PAS/BV-07-C", test_client,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
> -                               0x00, 0x19, 0x58,
> -                               AVRCP_GET_PLAYER_VALUE_TEXT,
> -                               0x00, 0x00, 0x04,
> -                               AVRCP_ATTRIBUTE_EQUALIZER, 0x02,
> -                               AVRCP_EQUALIZER_OFF,
> -                               AVRCP_EQUALIZER_ON));
> -
> -       define_test("/TP/PAS/BV-08-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
> -                               0x00, 0x19, 0x58,
> -                               AVRCP_GET_PLAYER_VALUE_TEXT,
> -                               0x00, 0x00, 0x03, AVRCP_ATTRIBUTE_EQUALIZ=
ER,
> -                               0x01, 0x01),
> -                       raw_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
> -                               0x00, 0x19, 0x58,
> -                               AVRCP_GET_PLAYER_VALUE_TEXT,
> -                               0x00, 0x00, 0x07, 0x01, 0x01, 0x00,
> -                               0x6a, 0x02, 0x6f, 0x6e));
> -
> -       define_test("/TP/PAS/BV-09-C", test_client,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
> -                               0x00, 0x19, 0x58,
> -                               AVRCP_GET_CURRENT_PLAYER_VALUE,
> -                               0x00, 0x00, 0x03, 0x02,
> -                               AVRCP_ATTRIBUTE_EQUALIZER,
> -                               AVRCP_ATTRIBUTE_REPEAT_MODE));
> -
> -       define_test("/TP/PAS/BV-10-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
> -                               0x00, 0x19, 0x58,
> -                               AVRCP_GET_CURRENT_PLAYER_VALUE,
> -                               0x00, 0x00, 0x03, 0x02,
> -                               AVRCP_ATTRIBUTE_EQUALIZER,
> -                               AVRCP_ATTRIBUTE_REPEAT_MODE),
> -                       raw_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
> -                               0x00, 0x19, 0x58,
> -                               AVRCP_GET_CURRENT_PLAYER_VALUE,
> -                               0x00, 0x00, 0x05, 0x02,
> -                               AVRCP_ATTRIBUTE_EQUALIZER, 0x00,
> -                               AVRCP_ATTRIBUTE_REPEAT_MODE, 0x00));
> -
> -       define_test("/TP/PAS/BV-11-C", test_client,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48, 0x00,
> -                               0x00, 0x19, 0x58,
> -                               AVRCP_SET_PLAYER_VALUE,
> -                               0x00, 0x00, 0x05, 0x02,
> -                               AVRCP_ATTRIBUTE_EQUALIZER, 0xaa,
> -                               AVRCP_ATTRIBUTE_REPEAT_MODE, 0xff));
> -
> -       /* Get player app setting attribute text invalid behavior - TG */
> -       define_test("/TP/PAS/BI-01-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
> -                               0x00, 0x19, 0x58,
> -                               AVRCP_GET_PLAYER_ATTRIBUTE_TEXT,
> -                               0x00, 0x00, 0x02, 0x01,
> -                               /* Invalid attribute id */
> -                               0x7f),
> -                       raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_REJECTED,
> -                               0x48, 0x00, 0x00, 0x19, 0x58,
> -                               AVRCP_GET_PLAYER_ATTRIBUTE_TEXT,
> -                               0x00, 0x00, 0x01, AVRCP_STATUS_INVALID_PA=
RAM));
> -
> -       /* List player application setting values invalid behavior - TG *=
/
> -       define_test("/TP/PAS/BI-02-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
> -                               0x00, 0x19, 0x58,
> -                               AVRCP_LIST_PLAYER_VALUES,
> -                               0x00, 0x00, 0x01,
> -                               /* Invalid attribute id */
> -                               0x7f),
> -                       raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_REJECTED,
> -                               0x48, 0x00, 0x00, 0x19, 0x58,
> -                               AVRCP_LIST_PLAYER_VALUES,
> -                               0x00, 0x00, 0x01, AVRCP_STATUS_INVALID_PA=
RAM));
> -
> -       /* Get player application setting value text invalid behavior - T=
G */
> -       define_test("/TP/PAS/BI-03-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
> -                               0x00, 0x19, 0x58,
> -                               AVRCP_GET_PLAYER_VALUE_TEXT,
> -                               0x00, 0x00, 0x03, AVRCP_ATTRIBUTE_EQUALIZ=
ER,
> -                               0x01,
> -                               /* Invalid setting value */
> -                               0x7f),
> -                       raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_REJECTED,
> -                               0x48, 0x00, 0x00, 0x19, 0x58,
> -                               AVRCP_GET_PLAYER_VALUE_TEXT,
> -                               0x00, 0x00, 0x01, AVRCP_STATUS_INVALID_PA=
RAM));
> -
> -       /* Get current player application setting value invalid behavior =
- TG */
> -       define_test("/TP/PAS/BI-04-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
> -                               0x00, 0x19, 0x58,
> -                               AVRCP_GET_CURRENT_PLAYER_VALUE,
> -                               0x00, 0x00, 0x02, 0x01,
> -                               /* Invalid attribute */
> -                               0x7f),
> -                       raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_REJECTED,
> -                               0x48, 0x00, 0x00, 0x19, 0x58,
> -                               AVRCP_GET_CURRENT_PLAYER_VALUE,
> -                               0x00, 0x00, 0x01, AVRCP_STATUS_INVALID_PA=
RAM));
> -
> -       /* Set player application setting value invalid behavior - TG */
> -       define_test("/TP/PAS/BI-05-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48, 0x00,
> -                               0x00, 0x19, 0x58,
> -                               AVRCP_SET_PLAYER_VALUE,
> -                               0x00, 0x00, 0x03, 0x01,
> -                               AVRCP_ATTRIBUTE_REPEAT_MODE, 0x7f),
> -                       raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_REJECTED,
> -                               0x48, 0x00, 0x00, 0x19, 0x58,
> -                               AVRCP_SET_PLAYER_VALUE,
> -                               0x00, 0x00, 0x01, AVRCP_STATUS_INVALID_PA=
RAM));
> -
> -       /* Media Information Commands */
> -
> -       /* Get play status - CT */
> -       define_test("/TP/MDI/BV-01-C", test_client,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_GET_PLAY_STATUS,
> -                               0x00, 0x00, 0x00));
> -
> -       /* Get play status - TG */
> -       define_test("/TP/MDI/BV-02-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_GET_PLAY_STATUS,
> -                               0x00, 0x00, 0x00),
> -                       raw_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_GET_PLAY_STATUS,
> -                               0x00, 0x00, 0x09,
> -                               0xbb, 0xbb, 0xbb, 0xbb, /* duration */
> -                               0xaa, 0xaa, 0xaa, 0xaa, /* position */
> -                               0x00));
> -
> -       /* Get element attributes - CT */
> -       define_test("/TP/MDI/BV-03-C", test_client,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_GET_ELEMENT_ATTRI=
BUTES,
> -                               0x00, 0x00, 0x09, 0x00, 0x00, 0x00,
> -                               0x00, 0x00, 0x00, 0x00, 0x00, 0x00));
> -
> -       /* Get element attributes - TG */
> -       define_test("/TP/MDI/BV-04-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_GET_ELEMENT_ATTRI=
BUTES,
> -                               0x00, 0x00, 0x09, 0x00, 0x00, 0x00,
> -                               0x00, 0x00, 0x00, 0x00, 0x00, 0x00),
> -                       raw_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_GET_ELEMENT_ATTRI=
BUTES,
> -                               0x00, 0x00, 0x00));
> -
> -       /* Get element attributes - TG */
> -       define_test("/TP/MDI/BV-05-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_GET_ELEMENT_ATTRI=
BUTES,
> -                               0x00, 0x00, 0x0d, 0x00, 0x00, 0x00,
> -                               0x00, 0x00, 0x00, 0x00, 0x00, 0x01,
> -                               0x00, 0x00, 0x00, 0x01),
> -                       raw_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_GET_ELEMENT_ATTRI=
BUTES,
> -                               0x00, 0x00, 0x00));
> -
> -       /* Notification Commands */
> -
> -       /* Register notification - CT */
> -       define_test("/TP/NFY/BV-01-C", test_client,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x03, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x05, AVRCP_EVENT_STATUS_CHAN=
GED,
> -                               0x00, 0x00, 0x00, 0x00));
> -
> -       /* Register notification - TG */
> -       define_test("/TP/NFY/BV-02-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x03, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x05, AVRCP_EVENT_TRACK_CHANG=
ED,
> -                               0x00, 0x00, 0x00, 0x00),
> -                       frg_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_INTERIM, 0x48=
, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x09, AVRCP_EVENT_TRACK_CHANG=
ED,
> -                               0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> -                               0xff, 0xff),
> -                       raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_CHANGED, 0x48=
, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x09, AVRCP_EVENT_TRACK_CHANG=
ED,
> -                               0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> -                               0xff, 0xff));
> -
> -       /* Register notification - TG */
> -       define_test("/TP/NFY/BV-03-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x03, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x05,
> -                               AVRCP_EVENT_SETTINGS_CHANGED,
> -                               0x00, 0x00, 0x00, 0x00),
> -                       raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_INTERIM, 0x48=
, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x04,
> -                               AVRCP_EVENT_SETTINGS_CHANGED,
> -                               0x01, 0x01, 0x02),
> -                       raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_CHANGED, 0x48=
, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x04,
> -                               AVRCP_EVENT_SETTINGS_CHANGED,
> -                               0x01, 0x01, 0x02));
> -
> -       /* Register notification - Track Changed - No Selected Track - TG=
 */
> -       define_test("/TP/NFY/BV-04-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x03, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x05, AVRCP_EVENT_TRACK_CHANG=
ED,
> -                               0x00, 0x00, 0x00, 0x00),
> -                       raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_INTERIM, 0x48=
, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x09, AVRCP_EVENT_TRACK_CHANG=
ED,
> -                               0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> -                               0xff, 0xff));
> -
> -       /* Register notification - Track Changed - Track Playing - TG */
> -       define_test("/TP/NFY/BV-05-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x03, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x05, AVRCP_EVENT_TRACK_CHANG=
ED,
> -                               0x00, 0x00, 0x00, 0x00),
> -                       raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_INTERIM, 0x48=
, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x09, AVRCP_EVENT_TRACK_CHANG=
ED,
> -                               0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -                               0x00, 0x00));
> -
> -       /* Register notification - Track Changed - Selected Track - TG */
> -       define_test("/TP/NFY/BV-08-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x03, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x05, AVRCP_EVENT_TRACK_CHANG=
ED,
> -                               0x00, 0x00, 0x00, 0x00),
> -                       raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_INTERIM, 0x48=
, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x09, AVRCP_EVENT_TRACK_CHANG=
ED,
> -                               0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -                               0x00, 0x00));
> -
> -       /* Register notification - Register for events invalid behavior -=
 TG */
> -       define_test("/TP/NFY/BI-01-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x03, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x05,
> -                               /* Invalid event id */
> -                               0xff,
> -                               0x00, 0x00, 0x00, 0x00),
> -                       raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_REJECTED,
> -                               0x48, 0x00, 0x00, 0x19, 0x58,
> -                               AVRCP_REGISTER_NOTIFICATION,
> -                               0x00, 0x00, 0x01, AVRCP_STATUS_INVALID_PA=
RAM));
> -
> -       /* Invalid commands */
> -
> -       /* Invalid PDU ID - TG */
> -       define_test("/TP/INV/BI-01-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x03, 0x48, 0x00,
> -                               0x00, 0x19, 0x58,
> -                               /* Invalid PDU ID */
> -                               0xff,
> -                               0x00, 0x00, 0x00),
> -                       raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_REJECTED,
> -                               0x48, 0x00, 0x00, 0x19, 0x58,
> -                               0xff, 0x00, 0x00, 0x01,
> -                               AVRCP_STATUS_INVALID_COMMAND));
> -
> -       /* Invalid PDU ID - Browsing TG */
> -       define_test("/TP/INV/BI-02-C", test_server,
> -                       brs_pdu(0x00, 0x11, 0x0e, 0xff, 0x00, 0x00),
> -                       brs_pdu(0x02, 0x11, 0x0e, AVRCP_GENERAL_REJECT,
> -                               0x00, 0x01, AVRCP_STATUS_INVALID_COMMAND)=
);
> -
> -       /* Next Group command transfer - CT */
> -       define_test("/TP/BGN/BV-01-I", test_client,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48,
> -                               AVC_OP_PASSTHROUGH,
> -                               AVC_VENDOR_UNIQUE, 0x05, 0x00, 0x19,
> -                               0x58, 0x00, AVC_VENDOR_NEXT_GROUP));
> -
> -       /* Next Group command transfer - TG */
> -       define_test("/TP/BGN/BV-01-I", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48,
> -                               AVC_OP_PASSTHROUGH,
> -                               AVC_VENDOR_UNIQUE, 0x05, 0x00, 0x19,
> -                               0x58, 0x00, AVC_VENDOR_NEXT_GROUP),
> -                       raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_ACCEPTED,
> -                               0x48, AVC_OP_PASSTHROUGH,
> -                               AVC_VENDOR_UNIQUE, 0x05, 0x00, 0x19,
> -                               0x58, 0x00, AVC_VENDOR_NEXT_GROUP));
> -
> -       /* Previous Group command transfer - CT */
> -       define_test("/TP/BGN/BV-02-I", test_client,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48,
> -                               AVC_OP_PASSTHROUGH,
> -                               AVC_VENDOR_UNIQUE, 0x05, 0x00, 0x19,
> -                               0x58, 0x00, AVC_VENDOR_PREV_GROUP));
> -
> -       /* Previous Group command transfer - TG */
> -       define_test("/TP/BGN/BV-02-I", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48,
> -                               AVC_OP_PASSTHROUGH,
> -                               AVC_VENDOR_UNIQUE, 0x05, 0x00, 0x19,
> -                               0x58, 0x00, AVC_VENDOR_PREV_GROUP),
> -                       raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_ACCEPTED,
> -                               0x48, AVC_OP_PASSTHROUGH,
> -                               AVC_VENDOR_UNIQUE, 0x05, 0x00, 0x19,
> -                               0x58, 0x00, AVC_VENDOR_PREV_GROUP));
> -
> -       /* Volume Level Handling */
> -
> -       /* Set absolute volume =E2=80=93 CT */
> -       define_test("/TP/VLH/BV-01-C", test_client,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_SET_ABSOLUTE_VOLU=
ME,
> -                               0x00, 0x00, 0x01, 0x00));
> -
> -       /* Set absolute volume =E2=80=93 TG */
> -       define_test("/TP/VLH/BV-02-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_SET_ABSOLUTE_VOLU=
ME,
> -                               0x00, 0x00, 0x01, 0x00),
> -                       raw_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_SET_ABSOLUTE_VOLU=
ME,
> -                               0x00, 0x00, 0x01, 0x00));
> -
> -       /* NotifyVolumeChange - CT */
> -       define_test("/TP/VLH/BV-03-C", test_client,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x03, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x05, 0x0d,
> -                               0x00, 0x00, 0x00, 0x00),
> -                       raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_INTERIM, 0x48=
, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x02, 0x0d,
> -                               0x00));
> -
> -       /* NotifyVolumeChange - TG */
> -       define_test("/TP/VLH/BV-04-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x03, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x05, 0x0d,
> -                               0x00, 0x00, 0x00, 0x00),
> -                       frg_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_INTERIM, 0x48=
, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x02, 0x0d,
> -                               0x00),
> -                       raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_CHANGED, 0x48=
, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x02, 0x0d,
> -                               0x01));
> -
> -       /* Set absolute volume =E2=80=93 TG */
> -       define_test("/TP/VLH/BI-01-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_SET_ABSOLUTE_VOLU=
ME,
> -                               0x00, 0x00, 0x00),
> -                       raw_pdu(0x02, 0x11, 0x0e, 0x0a, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_SET_ABSOLUTE_VOLU=
ME,
> -                               0x00, 0x00, 0x01, 0x01));
> -
> -       /* Set absolute volume =E2=80=93 TG */
> -       define_test("/TP/VLH/BI-02-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_SET_ABSOLUTE_VOLU=
ME,
> -                               0x00, 0x00, 0x01, 0x80),
> -                       raw_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_SET_ABSOLUTE_VOLU=
ME,
> -                               0x00, 0x00, 0x01, 0x00));
> -
> -       /* Set Absolute Volume invalid behavior CT */
> -       define_test("/TP/VLH/BI-03-C", test_client,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_SET_ABSOLUTE_VOLU=
ME,
> -                               0x00, 0x00, 0x01, 0x01),
> -                       raw_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_SET_ABSOLUTE_VOLU=
ME,
> -                               0x00, 0x00, 0x01, 0x81));
> -
> -       /* Set Absolute Volume invalid behavior CT */
> -       define_test("/TP/VLH/BI-04-C", test_client,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x03, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x05, 0x0d,
> -                               0x00, 0x00, 0x00, 0x00),
> -                       frg_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_INTERIM, 0x48=
, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x02, 0x0d,
> -                               0x00),
> -                       raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_CHANGED, 0x48=
, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICA=
TION,
> -                               0x00, 0x00, 0x02, 0x0d,
> -                               0x81));
> -
> -       /* PASS THROUGH Handling */
> -
> -       /* Press and release =E2=80=93 CT */
> -       define_test("/TP/PTH/BV-01-C", test_client,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48,
> -                               AVC_OP_PASSTHROUGH, AVC_PLAY, 0x00),
> -                       raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_ACCEPTED, 0x4=
8,
> -                               AVC_OP_PASSTHROUGH, AVC_PLAY),
> -                       raw_pdu(0x10, 0x11, 0x0e, 0x00, 0x48,
> -                               AVC_OP_PASSTHROUGH, AVC_PLAY | 0x80, 0x00=
));
> -
> -       define_test("/TP/PTH/BV-02-C", test_client,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48,
> -                               AVC_OP_PASSTHROUGH, AVC_FAST_FORWARD, 0x0=
0),
> -                       raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_ACCEPTED, 0x4=
8,
> -                               AVC_OP_PASSTHROUGH, AVC_FAST_FORWARD),
> -                       raw_pdu(0x10, 0x11, 0x0e, 0x00, 0x48,
> -                               AVC_OP_PASSTHROUGH, AVC_FAST_FORWARD | 0x=
80,
> -                               0x00),
> -                       raw_pdu(0x12, 0x11, 0x0e, AVC_CTYPE_ACCEPTED, 0x4=
8,
> -                               AVC_OP_PASSTHROUGH, AVC_FAST_FORWARD | 0x=
80),
> -                       raw_pdu(0x20, 0x11, 0x0e, 0x00, 0x48,
> -                               AVC_OP_PASSTHROUGH, AVC_FAST_FORWARD, 0x0=
0));
> -
> -       /* Request continuing response - TG */
> -       define_test("/TP/RCR/BV-02-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_GET_ELEMENT_ATTRI=
BUTES,
> -                               0x00, 0x00, 0x09, 0x00, 0x00, 0x00,
> -                               0x00, 0x00, 0x00, 0x00, 0x00, 0x00),
> -                       cont_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_GET_ELEMENT_ATTRI=
BUTES,
> -                               0x01, 0x01, 0xf9),
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REQUEST_CONTINUIN=
G,
> -                               0x00, 0x00, 0x01, AVRCP_GET_ELEMENT_ATTRI=
BUTES),
> -                       cont_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_GET_ELEMENT_ATTRI=
BUTES,
> -                               0x02, 0x01, 0xf9),
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_REQUEST_CONTINUIN=
G,
> -                               0x00, 0x00, 0x01, AVRCP_GET_ELEMENT_ATTRI=
BUTES),
> -                       cont_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_GET_ELEMENT_ATTRI=
BUTES,
> -                               0x03, 0x00, 0x0e));
> -
> -       /* Abort continuing response - TG */
> -       define_test("/TP/RCR/BV-04-C", test_server,
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_GET_ELEMENT_ATTRI=
BUTES,
> -                               0x00, 0x00, 0x09, 0x00, 0x00, 0x00,
> -                               0x00, 0x00, 0x00, 0x00, 0x00, 0x00),
> -                       cont_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_GET_ELEMENT_ATTRI=
BUTES,
> -                               0x01, 0x01, 0xf9),
> -                       raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_ABORT_CONTINUING,
> -                               0x00, 0x00, 0x01, AVRCP_GET_ELEMENT_ATTRI=
BUTES),
> -                       raw_pdu(0x02, 0x11, 0x0e, 0x09, 0x48, 0x00,
> -                               0x00, 0x19, 0x58, AVRCP_ABORT_CONTINUING,
> -                               0x00, 0x00, 0x00));
> -
> -       return tester_run();
> -}
> --
> 2.55.0
>
>


--=20
Luiz Augusto von Dentz
