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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC03C48BE8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jun 2021 18:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8F52613EE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jun 2021 18:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbhFRSVJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbhFRSVI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jun 2021 14:21:08 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30021C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jun 2021 11:18:58 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id bj15so11384248qkb.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jun 2021 11:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tc2Vok33i3SPo66GQN+Zv5tKWf0voPo+q2So69jBMO8=;
        b=bRM7I//112tM5hvtnQEaHhJytNqr4scoZU3Ox9mfodGIVHrBKuzk3S5E3FokZdSwgi
         nkRTfajOtVitpUdR/lN3EumBC14jf39O96U67H3iG85wJOiQZC4HWO3694IcbGqbChBY
         4d3W9NIb5mNnex1XFji3wFsPWVxXrNVV0Px73sSPHlp3tDbi2ONsPB8hW3f91TS26bTX
         sCq37e60qOS0uIbeHLRTJRJWD68cFcWg5jHlxypvNWD13lzqgJX4CdgfhBCj8dVL1h+j
         k8tY17HcZGCZ7CwW6fztuYvcUOwQuwRwStnLDcPCU3o/3kDeXatRaFbNeFzSBackZNtx
         s5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tc2Vok33i3SPo66GQN+Zv5tKWf0voPo+q2So69jBMO8=;
        b=dwLAPPcsNdELg1YBD79Gt7TG+VS5I3eLsKUyttIu1on8Q6P+I/HKaeDGAoavjEjb02
         2yE7+Tkt+bt+TWaKE/a/41Heb2NFooFF4wwerLRYBu3MpVTqMNg8Bfsh/k4qGexFg/qT
         cueFG2uaLJmO51bKGC19uI4AFUPPNvExSTHonN78NbZ6lYaFaLpnWY/SRQkeUzNzk6nS
         PN20LwK9AZM2gb1aJmaIkSv6M3Rlri7FrTPujDwAN8l95reRA+FSeTmrHPTjzEmg6FpM
         KttuOzDhcajJdpphCaBZO0FrHIDm4rKm9iJvDPb1lykxr2+02pil9pjp5Zo08IxZDwuk
         BgVw==
X-Gm-Message-State: AOAM530jIU6fSXfBRaj0tqYqv2PSN8zNnoeVUPE1jvm6Cy12UvYt0BWj
        8S6mH2AVLMR61M11etsbRsWt3/99BilutrlXVrQ=
X-Google-Smtp-Source: ABdhPJy27SJ3yx26id6g1ymk9eKWl6rAoPDnT/agDH/MubBSEh3gyC3Rvk5VTP7QBnyPwhf9ViEzM9g+PujoboK7n+4=
X-Received: by 2002:a25:9a04:: with SMTP id x4mr14851782ybn.440.1624040336814;
 Fri, 18 Jun 2021 11:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210618001559.1284204-1-mcchou@chromium.org> <20210617170013.BlueZ.v1.1.If79c3f0720cc893be1770c6853fe2fbe626f2caa@changeid>
In-Reply-To: <20210617170013.BlueZ.v1.1.If79c3f0720cc893be1770c6853fe2fbe626f2caa@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 18 Jun 2021 11:18:46 -0700
Message-ID: <CABBYNZJZbc10FaOpXwqpZW9PTzXeTNc8ZpTU+KGwHbgUUMU_gQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1 1/3] error: BR/EDR and LE connection failure reasons
To:     Miao-chen Chou <mcchou@chromium.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao,

On Thu, Jun 17, 2021 at 8:08 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>
> The source of Connect() failures can be divided into the following
> three.
> - bluetoothd's device interface state transition and profile state
>   transition
> - Kernel's L2CAP layer state transition
> - Potential HCI error codes returned by the remote device
>
> Reviewed-by: Alain Michaud <alainm@chromium.org>
> Reviewed-by: Howard Chung <howardchung@google.com>
> ---
>
>  src/error.c | 124 +++++++++++++++++++++++++++++++++++++
>  src/error.h | 171 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 295 insertions(+)
>
> diff --git a/src/error.c b/src/error.c
> index 89517075e..b72e3d764 100644
> --- a/src/error.c
> +++ b/src/error.c
> @@ -27,6 +27,7 @@
>  #include <config.h>
>  #endif
>
> +#include <stdio.h>
>  #include "gdbus/gdbus.h"
>
>  #include "error.h"
> @@ -43,6 +44,15 @@ DBusMessage *btd_error_invalid_args_str(DBusMessage *msg, const char *str)
>                                         "%s", str);
>  }
>
> +DBusMessage *btd_error_invalid_args_err(DBusMessage *msg, uint16_t err)
> +{
> +       char str[16];
> +
> +       sprintf(str, "BtdError:0x%04X", err);
> +       return g_dbus_create_error(msg, ERROR_INTERFACE ".InvalidArguments",
> +                                       "%s", str);
> +}
> +
>  DBusMessage *btd_error_busy(DBusMessage *msg)
>  {
>         return g_dbus_create_error(msg, ERROR_INTERFACE ".InProgress",
> @@ -79,12 +89,30 @@ DBusMessage *btd_error_in_progress(DBusMessage *msg)
>                                         "In Progress");
>  }
>
> +DBusMessage *btd_error_in_progress_err(DBusMessage *msg, uint16_t err)
> +{
> +       char str[16];
> +
> +       sprintf(str, "BtdError:0x%04X", err);
> +       return g_dbus_create_error(msg, ERROR_INTERFACE ".InProgress", "%s",
> +                                       str);

Was there a problem that you didn't use g_dbus_create_error to convert
the error? I mean instead of using %s use BtdError:0x%04X, actually it
might be enough to just have the code portion and skip BtdError as
that can be assumed implicitly the our error messages would contain
error codes.

> +}
> +
>  DBusMessage *btd_error_not_available(DBusMessage *msg)
>  {
>         return g_dbus_create_error(msg, ERROR_INTERFACE ".NotAvailable",
>                                         "Operation currently not available");
>  }
>
> +DBusMessage *btd_error_not_available_err(DBusMessage *msg, uint16_t err)
> +{
> +       char str[16];
> +
> +       sprintf(str, "BtdError:0x%04X", err);
> +       return g_dbus_create_error(msg, ERROR_INTERFACE ".NotAvailable", "%s",
> +                                       str);
> +}
> +
>  DBusMessage *btd_error_does_not_exist(DBusMessage *msg)
>  {
>         return g_dbus_create_error(msg, ERROR_INTERFACE ".DoesNotExist",
> @@ -121,8 +149,104 @@ DBusMessage *btd_error_not_ready(DBusMessage *msg)
>                                         "Resource Not Ready");
>  }
>
> +DBusMessage *btd_error_not_ready_err(DBusMessage *msg, uint16_t err)
> +{
> +       char str[16];
> +
> +       sprintf(str, "BtdError:0x%04X", err);
> +       return g_dbus_create_error(msg, ERROR_INTERFACE ".NotReady", "%s", str);
> +}
> +
>  DBusMessage *btd_error_failed(DBusMessage *msg, const char *str)
>  {
>         return g_dbus_create_error(msg, ERROR_INTERFACE
>                                         ".Failed", "%s", str);
>  }
> +
> +DBusMessage *btd_error_failed_err(DBusMessage *msg, uint16_t err)
> +{
> +       char str[16];
> +
> +       sprintf(str, "BtdError:0x%04X", err);
> +       return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed", "%s", str);
> +}
> +
> +uint16_t btd_error_bredr_conn_from_errno(int errno_code)
> +{
> +       switch (-errno_code) {
> +       case EALREADY:
> +       case EISCONN: // Fall through
> +               return BTD_ERR_BREDR_CONN_ALREADY_CONNECTED;
> +       case EHOSTDOWN:
> +               return BTD_ERR_BREDR_CONN_PAGE_TIMEOUT;
> +       case ENOPROTOOPT:
> +               return BTD_ERR_BREDR_CONN_PROFILE_UNAVAILABLE;
> +       case EIO:
> +               return BTD_ERR_BREDR_CONN_CREATE_SOCKET;
> +       case EINVAL:
> +               return BTD_ERR_BREDR_CONN_INVALID_ARGUMENTS;
> +       case EHOSTUNREACH:
> +               return BTD_ERR_BREDR_CONN_ADAPTER_NOT_POWERED;
> +       case EOPNOTSUPP:
> +       case EPROTONOSUPPORT: // Fall through
> +               return BTD_ERR_BREDR_CONN_NOT_SUPPORTED;
> +       case EBADFD:
> +               return BTD_ERR_BREDR_CONN_BAD_SOCKET;
> +       case ENOMEM:
> +               return BTD_ERR_BREDR_CONN_MEMORY_ALLOC;
> +       case EBUSY:
> +               return BTD_ERR_BREDR_CONN_BUSY;
> +       case EMLINK:
> +               return BTD_ERR_BREDR_CONN_SYNC_CONNECT_LIMIT;
> +       case ETIMEDOUT:
> +               return BTD_ERR_BREDR_CONN_TIMEOUT;
> +       case ECONNREFUSED:
> +               return BTD_ERR_BREDR_CONN_REFUSED;
> +       case ECONNRESET:
> +               return BTD_ERR_BREDR_CONN_TERM_BY_REMOTE;
> +       case ECONNABORTED:
> +               return BTD_ERR_BREDR_CONN_TERM_BY_LOCAL;
> +       case EPROTO:
> +               return BTD_ERR_BREDR_CONN_PROTO_ERROR;
> +       default:
> +               return BTD_ERR_BREDR_CONN_UNKNOWN;
> +       }
> +}
> +
> +uint16_t btd_error_le_conn_from_errno(int errno_code)
> +{
> +       switch (-errno_code) {
> +       case EINVAL:
> +               return BTD_ERR_LE_CONN_INVALID_ARGUMENTS;
> +       case EHOSTUNREACH:
> +               return BTD_ERR_LE_CONN_ADAPTER_NOT_POWERED;
> +       case EOPNOTSUPP:
> +       case EPROTONOSUPPORT: // Fall through
> +               return BTD_ERR_LE_CONN_NOT_SUPPORTED;
> +       case EALREADY:
> +       case EISCONN: // Fall through
> +               return BTD_ERR_LE_CONN_ALREADY_CONNECTED;
> +       case EBADFD:
> +               return BTD_ERR_LE_CONN_BAD_SOCKET;
> +       case ENOMEM:
> +               return BTD_ERR_LE_CONN_MEMORY_ALLOC;
> +       case EBUSY:
> +               return BTD_ERR_LE_CONN_BUSY;
> +       case ECONNREFUSED:
> +               return BTD_ERR_LE_CONN_REFUSED;
> +       case EIO:
> +               return BTD_ERR_LE_CONN_CREATE_SOCKET;
> +       case ETIMEDOUT:
> +               return BTD_ERR_LE_CONN_TIMEOUT;
> +       case EMLINK:
> +               return BTD_ERR_LE_CONN_SYNC_CONNECT_LIMIT;
> +       case ECONNRESET:
> +               return BTD_ERR_LE_CONN_TERM_BY_REMOTE;
> +       case ECONNABORTED:
> +               return BTD_ERR_LE_CONN_TERM_BY_LOCAL;
> +       case EPROTO:
> +               return BTD_ERR_LE_CONN_PROTO_ERROR;
> +       default:
> +               return BTD_ERR_LE_CONN_UNKNOWN;
> +       }
> +}
> diff --git a/src/error.h b/src/error.h
> index 7c8cad066..f258cc4e7 100644
> --- a/src/error.h
> +++ b/src/error.h
> @@ -24,22 +24,193 @@
>   */
>
>  #include <dbus/dbus.h>
> +#include <stdint.h>
>
>  #define ERROR_INTERFACE "org.bluez.Error"
>
> +/* BR/EDR connection failure reasons
> + * BT_ERR_* should be used as one of the parameters to btd_error_*_err().
> + */
> +
> +/* Either the profile is already connected or ACL connection is in
> + * place.
> + * errno: EALREADY, EISCONN
> + */
> +#define BTD_ERR_BREDR_CONN_ALREADY_CONNECTED   0x0001
> +/* Failed due to page timeout.
> + * errno: EHOSTDOWN
> + */
> +#define BTD_ERR_BREDR_CONN_PAGE_TIMEOUT                0x0002
> +/* Failed to find connectable services or the target service.
> + * errno: ENOPROTOOPT
> + */
> +#define BTD_ERR_BREDR_CONN_PROFILE_UNAVAILABLE 0x0003
> +/* Failed to complete the SDP search.
> + * errno: none
> + */
> +#define BTD_ERR_BREDR_CONN_SDP_SEARCH          0x0004
> +/* Failed to create or connect to BT IO socket. This can also indicate
> + * hardware failure in the controller.
> + * errno: EIO
> + */
> +#define BTD_ERR_BREDR_CONN_CREATE_SOCKET       0x0005
> +/* Failed due to invalid arguments.
> + * errno: EINVAL
> + */
> +#define BTD_ERR_BREDR_CONN_INVALID_ARGUMENTS   0x0006
> +/* Failed due to adapter not powered.
> + * errno: EHOSTUNREACH
> + */
> +#define BTD_ERR_BREDR_CONN_ADAPTER_NOT_POWERED 0x0007
> +/* Failed due to unsupported state transition of L2CAP channel or other
> + * features either by the local host or the remote.
> + * errno: EOPNOTSUPP, EPROTONOSUPPORT
> + */
> +#define BTD_ERR_BREDR_CONN_NOT_SUPPORTED       0x0008
> +/* Failed due to the socket is in bad state.
> + * errno: EBADFD
> + */
> +#define BTD_ERR_BREDR_CONN_BAD_SOCKET          0x0009
> +/* Failed to allocate memory in either host stack or controller.
> + * errno: ENOMEM
> + */
> +#define BTD_ERR_BREDR_CONN_MEMORY_ALLOC                0x000A
> +/* Failed due to other ongoing operations, such as pairing, busy L2CAP
> + * channel or the operation disallowed by the controller.
> + * errno: EBUSY
> + */
> +#define BTD_ERR_BREDR_CONN_BUSY                        0x000B
> +/* Failed due to reaching the synchronous connection limit to a device.
> + * errno: EMLINK
> + */
> +#define BTD_ERR_BREDR_CONN_SYNC_CONNECT_LIMIT  0x000C
> +/* Failed due to connection timeout
> + * errno: ETIMEDOUT
> + */
> +#define BTD_ERR_BREDR_CONN_TIMEOUT             0x000D
> +/* Refused by the remote device due to limited resource, security reason
> + * or unacceptable address type.
> + * errno: ECONNREFUSED
> + */
> +#define BTD_ERR_BREDR_CONN_REFUSED             0x000E
> +/* Terminated by the remote device due to limited resource or power
> + * off.
> + * errno: ECONNRESET
> + */
> +#define BTD_ERR_BREDR_CONN_TERM_BY_REMOTE      0x000F
> +/* Terminated by the local host.
> + * errno: ECONNABORTED
> + */
> +#define BTD_ERR_BREDR_CONN_TERM_BY_LOCAL       0x0010
> +/* Failed due to LMP protocol error.
> + * errno: EPROTO
> + */
> +#define BTD_ERR_BREDR_CONN_PROTO_ERROR         0x0011
> +/* Failed due to cancellation caused by adapter drop, unexpected device drop,
> + * or incoming disconnection request before connection request is completed.
> + * errno: none
> + */
> +#define BTD_ERR_BREDR_CONN_CANCELED            0x0012
> +/* Failed due to unknown reason.
> + * errno: ENOSYS
> + */
> +#define BTD_ERR_BREDR_CONN_UNKNOWN             0x0013
> +
> +/* LE connection failure reasons
> + * BT_ERR_* should be used as one of the parameters to btd_error_*_err().
> + */
> +
> +/* Failed due to invalid arguments.
> + * errno: EINVAL
> + */
> +#define BTD_ERR_LE_CONN_INVALID_ARGUMENTS      0x0101
> +/* Failed due to adapter not powered.
> + * errno: EHOSTUNREACH
> + */
> +#define BTD_ERR_LE_CONN_ADAPTER_NOT_POWERED    0x0102
> +/* Failed due to unsupported state transition of L2CAP channel or other
> + * features (e.g. LE features) either by the local host or the remote.
> + * errno: EOPNOTSUPP, EPROTONOSUPPORT
> + */
> +#define BTD_ERR_LE_CONN_NOT_SUPPORTED          0x0103
> +/* Either the BT IO is already connected or LE link connection in place.
> + * errno: EALREADY, EISCONN
> + */
> +#define BTD_ERR_LE_CONN_ALREADY_CONNECTED      0x0104
> +/* Failed due to the socket is in bad state.
> + * errno: EBADFD
> + */
> +#define BTD_ERR_LE_CONN_BAD_SOCKET             0x0105
> +/* Failed to allocate memory in either host stack or controller.
> + * errno: ENOMEM
> + */
> +#define BTD_ERR_LE_CONN_MEMORY_ALLOC           0x0106
> +/* Failed due to other ongoing operations, such as pairing, connecting, busy
> + * L2CAP channel or the operation disallowed by the controller.
> + * errno: EBUSY
> + */
> +#define BTD_ERR_LE_CONN_BUSY                   0x0107
> +/* Failed due to that LE is not enabled or the attempt is refused by the remote
> + * device due to limited resource, security reason or unacceptable address type.
> + * errno: ECONNREFUSED
> + */
> +#define BTD_ERR_LE_CONN_REFUSED                        0x0108
> +/* Failed to create or connect to BT IO socket. This can also indicate
> + * hardware failure in the controller.
> + * errno: EIO
> + */
> +#define BTD_ERR_LE_CONN_CREATE_SOCKET          0x0109
> +/* Failed due to connection timeout
> + * errno: ETIMEDOUT
> + */
> +#define BTD_ERR_LE_CONN_TIMEOUT                        0x010A
> +/* Failed due to reaching the synchronous connection limit to a device.
> + * errno: EMLINK
> + */
> +#define BTD_ERR_LE_CONN_SYNC_CONNECT_LIMIT     0x010B
> +/* Terminated by the remote device due to limited resource or power
> + * off.
> + * errno: ECONNRESET
> + */
> +#define BTD_ERR_LE_CONN_TERM_BY_REMOTE         0x010C
> +/* Terminated by the local host.
> + * errno: ECONNABORTED
> + */
> +#define BTD_ERR_LE_CONN_TERM_BY_LOCAL          0x010D
> +/* Failed due to LL protocol error.
> + * errno: EPROTO
> + */
> +#define BTD_ERR_LE_CONN_PROTO_ERROR            0x010E
> +/* Failed to complete the GATT browsing.
> + * errno: none
> + */
> +#define BTD_ERR_LE_CONN_GATT_BROWSE            0x010F
> +/* Failed due to unknown reason.
> + * errno: ENOSYS
> + */
> +#define BTD_ERR_LE_CONN_UNKNOWN                        0x0110
> +
>  DBusMessage *btd_error_invalid_args(DBusMessage *msg);
>  DBusMessage *btd_error_invalid_args_str(DBusMessage *msg, const char *str);
> +DBusMessage *btd_error_invalid_args_err(DBusMessage *msg, uint16_t err);
>  DBusMessage *btd_error_busy(DBusMessage *msg);
>  DBusMessage *btd_error_already_exists(DBusMessage *msg);
>  DBusMessage *btd_error_not_supported(DBusMessage *msg);
>  DBusMessage *btd_error_not_connected(DBusMessage *msg);
>  DBusMessage *btd_error_already_connected(DBusMessage *msg);
>  DBusMessage *btd_error_not_available(DBusMessage *msg);
> +DBusMessage *btd_error_not_available_err(DBusMessage *msg, uint16_t err);
>  DBusMessage *btd_error_in_progress(DBusMessage *msg);
> +DBusMessage *btd_error_in_progress_err(DBusMessage *msg, uint16_t err);
>  DBusMessage *btd_error_does_not_exist(DBusMessage *msg);
>  DBusMessage *btd_error_not_authorized(DBusMessage *msg);
>  DBusMessage *btd_error_not_permitted(DBusMessage *msg, const char *str);
>  DBusMessage *btd_error_no_such_adapter(DBusMessage *msg);
>  DBusMessage *btd_error_agent_not_available(DBusMessage *msg);
>  DBusMessage *btd_error_not_ready(DBusMessage *msg);
> +DBusMessage *btd_error_not_ready_err(DBusMessage *msg, uint16_t err);
>  DBusMessage *btd_error_failed(DBusMessage *msg, const char *str);
> +DBusMessage *btd_error_failed_err(DBusMessage *msg, uint16_t err);
> +
> +uint16_t btd_error_bredr_conn_from_errno(int errno_code);
> +uint16_t btd_error_le_conn_from_errno(int errno_code);
> --
> 2.32.0.288.g62a8d224e6-goog
>


-- 
Luiz Augusto von Dentz
