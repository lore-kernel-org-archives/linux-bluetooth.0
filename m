Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9D0C4320A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Aug 2021 13:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFFF761040
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Aug 2021 13:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbhHINc0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Aug 2021 09:32:26 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47453 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbhHINcZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Aug 2021 09:32:25 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id 95A99CEE01;
        Mon,  9 Aug 2021 15:32:03 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [BlueZ PATCH v5 2/4] error: BR/EDR and LE connection failure
 reasons
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210806164624.BlueZ.v5.2.If79c3f0720cc893be1770c6853fe2fbe626f2caa@changeid>
Date:   Mon, 9 Aug 2021 15:32:03 +0200
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <991E0A86-77E3-46E1-8E19-CED2742D374F@holtmann.org>
References: <20210806234720.286157-1-mcchou@chromium.org>
 <20210806164624.BlueZ.v5.2.If79c3f0720cc893be1770c6853fe2fbe626f2caa@changeid>
To:     Miao-chen Chou <mcchou@chromium.org>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao-chen,

> The source of Connect() failures can be divided into the following
> three.
> - bluetoothd's device interface state transition and profile state
>  transition
> - Kernel's L2CAP layer state transition
> - Potential HCI error codes returned by the remote device
> 
> Reviewed-by: Alain Michaud <alainm@chromium.org>
> Reviewed-by: Howard Chung <howardchung@google.com>
> ---
> 
> Changes in v5:
> - Replace uint16_t error code with string
> 
> Changes in v4:
> - Address make errors
> 
> Changes in v3:
> - Separate error-code.txt into its own commit
> 
> Changes in v2:
> - Add error-code.txt
> - Remove BtdError from return string
> 
> src/error.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> src/error.h |  59 +++++++++++++++++++++++++++++++
> 2 files changed, 159 insertions(+)
> 
> diff --git a/src/error.c b/src/error.c
> index 89517075e..411f36fcb 100644
> --- a/src/error.c
> +++ b/src/error.c
> @@ -27,6 +27,8 @@
> #include <config.h>
> #endif
> 
> +#include <error.h>
> +#include <stdio.h>
> #include "gdbus/gdbus.h"
> 
> #include "error.h"
> @@ -79,12 +81,24 @@ DBusMessage *btd_error_in_progress(DBusMessage *msg)
> 					"In Progress");
> }
> 
> +DBusMessage *btd_error_in_progress_str(DBusMessage *msg, const char *str)
> +{
> +	return g_dbus_create_error(msg, ERROR_INTERFACE ".InProgress",
> +					"%s", str);
> +}
> +
> DBusMessage *btd_error_not_available(DBusMessage *msg)
> {
> 	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotAvailable",
> 					"Operation currently not available");
> }
> 
> +DBusMessage *btd_error_not_available_str(DBusMessage *msg, const char *str)
> +{
> +	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotAvailable",
> +					"%s", str);
> +}
> +
> DBusMessage *btd_error_does_not_exist(DBusMessage *msg)
> {
> 	return g_dbus_create_error(msg, ERROR_INTERFACE ".DoesNotExist",
> @@ -121,8 +135,94 @@ DBusMessage *btd_error_not_ready(DBusMessage *msg)
> 					"Resource Not Ready");
> }
> 
> +DBusMessage *btd_error_not_ready_str(DBusMessage *msg, const char *str)
> +{
> +	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotReady",
> +					"%s", str);
> +}
> +
> DBusMessage *btd_error_failed(DBusMessage *msg, const char *str)
> {
> 	return g_dbus_create_error(msg, ERROR_INTERFACE
> 					".Failed", "%s", str);
> }
> +
> +const char* btd_error_bredr_conn_from_errno(int errno_code)
> +{
> +	switch (-errno_code) {
> +	case EALREADY:
> +	case EISCONN:
> +		return ERR_BREDR_CONN_ALREADY_CONNECTED;
> +	case EHOSTDOWN:
> +		return ERR_BREDR_CONN_PAGE_TIMEOUT;
> +	case ENOPROTOOPT:
> +		return ERR_BREDR_CONN_PROFILE_UNAVAILABLE;
> +	case EIO:
> +		return ERR_BREDR_CONN_CREATE_SOCKET;
> +	case EINVAL:
> +		return ERR_BREDR_CONN_INVALID_ARGUMENTS;
> +	case EHOSTUNREACH:
> +		return ERR_BREDR_CONN_ADAPTER_NOT_POWERED;
> +	case EOPNOTSUPP:
> +	case EPROTONOSUPPORT:
> +		return ERR_BREDR_CONN_NOT_SUPPORTED;
> +	case EBADFD:
> +		return ERR_BREDR_CONN_BAD_SOCKET;
> +	case ENOMEM:
> +		return ERR_BREDR_CONN_MEMORY_ALLOC;
> +	case EBUSY:
> +		return ERR_BREDR_CONN_BUSY;
> +	case EMLINK:
> +		return ERR_BREDR_CONN_CNCR_CONNECT_LIMIT;
> +	case ETIMEDOUT:
> +		return ERR_BREDR_CONN_TIMEOUT;
> +	case ECONNREFUSED:
> +		return ERR_BREDR_CONN_REFUSED;
> +	case ECONNRESET:
> +		return ERR_BREDR_CONN_ABORT_BY_REMOTE;
> +	case ECONNABORTED:
> +		return ERR_BREDR_CONN_ABORT_BY_LOCAL;
> +	case EPROTO:
> +		return ERR_BREDR_CONN_LMP_PROTO_ERROR;
> +	default:
> +		return ERR_BREDR_CONN_UNKNOWN;
> +	}
> +}
> +
> +const char* btd_error_le_conn_from_errno(int errno_code)
> +{
> +	switch (-errno_code) {
> +	case EINVAL:
> +		return ERR_LE_CONN_INVALID_ARGUMENTS;
> +	case EHOSTUNREACH:
> +		return ERR_LE_CONN_ADAPTER_NOT_POWERED;
> +	case EOPNOTSUPP:
> +	case EPROTONOSUPPORT:
> +		return ERR_LE_CONN_NOT_SUPPORTED;
> +	case EALREADY:
> +	case EISCONN:
> +		return ERR_LE_CONN_ALREADY_CONNECTED;
> +	case EBADFD:
> +		return ERR_LE_CONN_BAD_SOCKET;
> +	case ENOMEM:
> +		return ERR_LE_CONN_MEMORY_ALLOC;
> +	case EBUSY:
> +		return ERR_LE_CONN_BUSY;
> +	case ECONNREFUSED:
> +		return ERR_LE_CONN_REFUSED;
> +	case EIO:
> +		return ERR_LE_CONN_CREATE_SOCKET;
> +	case ETIMEDOUT:
> +		return ERR_LE_CONN_TIMEOUT;
> +	case EMLINK:
> +		return ERR_LE_CONN_SYNC_CONNECT_LIMIT;
> +	case ECONNRESET:
> +		return ERR_LE_CONN_ABORT_BY_REMOTE;
> +	case ECONNABORTED:
> +		return ERR_LE_CONN_ABORT_BY_LOCAL;
> +	case EPROTO:
> +		return ERR_LE_CONN_LL_PROTO_ERROR;
> +	default:
> +		return ERR_LE_CONN_UNKNOWN;
> +	}
> +}
> diff --git a/src/error.h b/src/error.h
> index 7c8cad066..91a02654a 100644
> --- a/src/error.h
> +++ b/src/error.h
> @@ -24,9 +24,62 @@
>  */
> 
> #include <dbus/dbus.h>
> +#include <stdint.h>
> 
> #define ERROR_INTERFACE "org.bluez.Error"
> 
> +/* BR/EDR connection failure reasons */
> +#define ERR_BREDR_CONN_ALREADY_CONNECTED	"BR/EDR connection already "\
> +						"connected"
> +#define ERR_BREDR_CONN_PAGE_TIMEOUT		"BR/EDR connection page timeout"
> +#define ERR_BREDR_CONN_PROFILE_UNAVAILABLE	"BR/EDR connection profile "\
> +						"unavailable"
> +#define ERR_BREDR_CONN_SDP_SEARCH		"BR/EDR connection SDP search"
> +#define ERR_BREDR_CONN_CREATE_SOCKET		"BR/EDR connection create "\
> +						"socket"
> +#define ERR_BREDR_CONN_INVALID_ARGUMENTS	"BR/EDR connection invalid "\
> +						"argument"
> +#define ERR_BREDR_CONN_ADAPTER_NOT_POWERED	"BR/EDR connection adapter "\
> +						"not powered"
> +#define ERR_BREDR_CONN_NOT_SUPPORTED		"BR/EDR connection not "\
> +						"suuported"
> +#define ERR_BREDR_CONN_BAD_SOCKET		"BR/EDR connection bad socket"
> +#define ERR_BREDR_CONN_MEMORY_ALLOC		"BR/EDR connection memory "\
> +						"allocation"
> +#define ERR_BREDR_CONN_BUSY			"BR/EDR connection busy"
> +#define ERR_BREDR_CONN_CNCR_CONNECT_LIMIT	"BR/EDR connection concurrent "\
> +						"connection limit"
> +#define ERR_BREDR_CONN_TIMEOUT			"BR/EDR connection timeout"
> +#define ERR_BREDR_CONN_REFUSED			"BR/EDR connection refused"
> +#define ERR_BREDR_CONN_ABORT_BY_REMOTE		"BR/EDR connection aborted by "\
> +						"remote"
> +#define ERR_BREDR_CONN_ABORT_BY_LOCAL		"BR/EDR connection aborted by "\
> +						"local"
> +#define ERR_BREDR_CONN_LMP_PROTO_ERROR		"BR/EDR connection LMP "\
> +						"protocol error"
> +#define ERR_BREDR_CONN_CANCELED			"BR/EDR connection canceled"
> +#define ERR_BREDR_CONN_UNKNOWN			"BR/EDR connection unknown"
> +
> +/* LE connection failure reasons */
> +#define ERR_LE_CONN_INVALID_ARGUMENTS	"LE connection invalid arguments"
> +#define ERR_LE_CONN_ADAPTER_NOT_POWERED	"LE connection adapter not powered"
> +#define ERR_LE_CONN_NOT_SUPPORTED	"LE connection not supported"
> +#define ERR_LE_CONN_ALREADY_CONNECTED	"LE connection already connected"
> +#define ERR_LE_CONN_BAD_SOCKET		"LE connection bad socket"
> +#define ERR_LE_CONN_MEMORY_ALLOC	"LE connection memory allocation"
> +#define ERR_LE_CONN_BUSY		"LE connection busy"
> +#define ERR_LE_CONN_REFUSED		"LE connection refused"
> +#define ERR_LE_CONN_CREATE_SOCKET	"LE connection create socket"
> +#define ERR_LE_CONN_TIMEOUT		"LE connection timeout"
> +#define ERR_LE_CONN_SYNC_CONNECT_LIMIT	"LE connection concurrent connection "\
> +					"limit"
> +#define ERR_LE_CONN_ABORT_BY_REMOTE	"LE connection abort by remote"
> +#define ERR_LE_CONN_ABORT_BY_LOCAL	"LE connection abort by local"
> +#define ERR_LE_CONN_LL_PROTO_ERROR	"LE connection link layer protocol "\
> +					"error"
> +#define ERR_LE_CONN_GATT_BROWSE		"LE connection GATT browsing"
> +#define ERR_LE_CONN_UNKNOWN		"LE connection unknown"

I rather have you use strings like “le-connection-not-supported” to make this similar to what we are using for other strings in the API.

And I am always torn between using “bredr-“ and just using “br-“.

Regards

Marcel

