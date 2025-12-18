Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31193002BA
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 19:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766084889; cv=none; b=FghzcozFKQ0rfFAfNOvqvx5zUd8d0H3naPCUe0JC0DwevRTEb6hKnE9x8xHlICT+0c7a0B11dcY2a8AG8/F7zH76LD4NvifafoB1BnL0qe03YT1xm7gCyLJJO9XJtt3bqc5S20VnVQVedkwzoSQFV9snNe3xkB9OKA/pT6Os4i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766084889; c=relaxed/simple;
	bh=JT4WILd4SFYoQdtdV5PVOEHTtvRFhoDUDM83hOlPxHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bxbYY9+xbWZHWTdTk25ke1NpyGmTpjk3YSTL8HBDfHUq3vBdZS8TovyuaVr7oMJH3o/M47foOznMrXIgn/TW1qgX9WKZbMhuaf82E36qHpFfNh98PNbEqGsK5UQSDQmqaoD79TTNqcMigbAGmYnGiXX6OTTkUoCl7z8MnJgeSmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chHoFMd6; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chHoFMd6"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-598f8136a24so1094909e87.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 11:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766084886; x=1766689686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fi/Vf6GBHdUYT/6lj2lhJxt0B5Vsqz2iM87g6wLB88=;
        b=chHoFMd6/zOiX4ZxC8aHOa8b4jCiBu9yyjkiH7AAUi+C/kY6pCsAc7of8P9hWfF7zZ
         7Lmtyl786ziKLCvBa22c+8h/mfkh4ie17LzGZfePMY5d1yfX0+IPcm5+ZFELfLEMw+I3
         a9ZQ2JUNvh8SyXbQnCbgpVUzM9eb9Gq0lFM3Pqr/lWegLzxlj1A1NT7Kc8Poy2UdsOIY
         ltCzsGdnCg2r1sjM8aPX9GW3aU7plNaqhwAVSHzywBSQweifCYu06sCKAfbw1++iu0Ca
         n2hTniug5sHJZWyGwa/AZyfGuc7tmtpF1hbqp79v+vAbOTlyy979Qz9vJfX4ni5VyBSv
         RlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766084886; x=1766689686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5fi/Vf6GBHdUYT/6lj2lhJxt0B5Vsqz2iM87g6wLB88=;
        b=s/OUZcCHazrpiOlyjx0TmZVe4PgHI95kJstEQtTWlbxCkye6CA+fuAE2dP2kV0AQEb
         r+2rujDlLw9YWiFcVJJocR8Ta2sAvLz9ZEuDo06eZmvWIA3n070tipo9hYzmVgz0Z6sg
         D2Pjt2vTLXRPM9ehOrymfxpAcdCrZs+8+LrC4T/2DMW2ekx0L53+OsqWZBg/fzcYXw0x
         XuzRa4gUfIzvvnM0L98k9m7XDGXFD7vkgyVo5HWWGz8r29NmRU5GqoPahd7NkmyC+Lkk
         X+7qVGETNZhBj05iv8YGFC0heV8sG5BGXYFkJzThgBOWSj+gPHH4wTOfA5D+aYNDT3Fz
         Gv/w==
X-Gm-Message-State: AOJu0YzvWRwGPN/nFNLWpbCnjk7ElM7/9Ms+wNjGh/yvz3wLOMYrusuR
	CqKzTu9VEW12Hrq2/eoZQO4ApIs9RUv6JQopPXEpRfQadlSE4w4v7ISNhCdkIUf0JnapPibScL3
	xM1eyZZE4zZj1eRsl2NJSLJyYZQbERn5lDgRnEgQ=
X-Gm-Gg: AY/fxX7no4bEuenNBDXtKFdixrXN7VbJJbX+ZYH8I2tyJFpTaQ3c+r+SJpfitjR8FOH
	iqCAcnJZlSpdj3Z0JFpwb4XXy1NHdxM1PGY1rjt/UlzvBAmUMlMVTdn6gz21ctjZGQ8lsoIYkHJ
	EZ0MuhoMbDd7xMx06pHfIEodIaost7CLl1O9V6O7d8uztCXAscrJFbx/CzBkUpN5pioaW8rz7Ma
	mlJMmId/i4ph3n/RJaLuSbJK35cc6dRT5xJdSfvSSiFvkQtQOq7qiJ4TdgUVXT1mQoqPQ==
X-Google-Smtp-Source: AGHT+IEuMj1gSiWaMDVBdW9ckNLFrpOYiCijGfLiUpsTaHerq8z35pqYpS3lds5FDtGnxw3nHHeIc8sc+e+8iUwTYcI=
X-Received: by 2002:a05:6512:220d:b0:595:81eb:5368 with SMTP id
 2adb3069b0e04-59a17db78c5mr187297e87.39.1766084885465; Thu, 18 Dec 2025
 11:08:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217164820.277845-1-frederic.danis@collabora.com> <20251217164820.277845-2-frederic.danis@collabora.com>
In-Reply-To: <20251217164820.277845-2-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 18 Dec 2025 14:07:51 -0500
X-Gm-Features: AQt7F2pLZFFuZAsxDvRpnSY3Pr_OY-HrZXqgB5SbpRhyMrTSPv6sezcPJUAv0r4
Message-ID: <CABBYNZKvY=3MBMinWKNkx6Uht_cMV7xi=1FRpyA0C4i9yvjo+w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/3] audio/hfp-hf: Add simple call support
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frederic,

On Wed, Dec 17, 2025 at 12:09=E2=80=AFPM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> This allows to dial, hang-up, answer or reject a call.
> ---
>  profiles/audio/hfp-hf.c | 184 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 184 insertions(+)
>
> diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
> index 384480c9e..81d5f4437 100644
> --- a/profiles/audio/hfp-hf.c
> +++ b/profiles/audio/hfp-hf.c
> @@ -36,6 +36,7 @@
>  #include "src/btd.h"
>  #include "src/dbus-common.h"
>  #include "src/device.h"
> +#include "src/error.h"
>  #include "src/log.h"
>  #include "src/plugin.h"
>  #include "src/profile.h"
> @@ -52,6 +53,7 @@ struct hfp_device {
>         uint16_t                version;
>         GIOChannel              *io;
>         struct hfp_hf           *hf;
> +       GSList                  *calls;

Use struct queue instead of GSList.

>  };
>
>  static void hfp_hf_debug(const char *str, void *user_data)
> @@ -59,6 +61,33 @@ static void hfp_hf_debug(const char *str, void *user_d=
ata)
>         DBG_IDX(0xffff, "%s", str);
>  }
>
> +static enum call_state hfp_call_status_to_call_state(
> +                                               enum hfp_call_status stat=
us)
> +{
> +       switch (status) {
> +       case CALL_STATUS_ACTIVE: return CALL_STATE_ACTIVE; break;
> +       case CALL_STATUS_HELD: return CALL_STATE_HELD; break;
> +       case CALL_STATUS_DIALING: return CALL_STATE_DIALING; break;
> +       case CALL_STATUS_ALERTING: return CALL_STATE_ALERTING; break;
> +       case CALL_STATUS_INCOMING: return CALL_STATE_INCOMING; break;
> +       case CALL_STATUS_WAITING: return CALL_STATE_WAITING; break;
> +       case CALL_STATUS_RESPONSE_AND_HOLD:
> +               return CALL_STATE_RESPONSE_AND_HOLD; break;
> +       default:
> +               DBG("Unknown hfp_call_status: %u", status);
> +       }
> +
> +       return CALL_STATE_DISCONNECTED;
> +}
> +
> +static int call_id_cmp(gconstpointer a, gconstpointer b)
> +{
> +       struct call *call =3D (struct call *) a;
> +       uint16_t id =3D GPOINTER_TO_UINT(b);
> +
> +       return call->idx =3D=3D id ? 0 : -1;
> +}
> +
>  static void device_destroy(struct hfp_device *dev)
>  {
>         DBG("%s", telephony_get_path(dev->telephony));
> @@ -115,6 +144,42 @@ static void hfp_hf_update_operator(const char *opera=
tor_name, void *user_data)
>         telephony_set_operator_name(dev->telephony, operator_name);
>  }
>
> +static void hfp_hf_call_added(uint id, enum hfp_call_status status,
> +                                                       void *user_data)
> +{
> +       struct hfp_device *dev =3D user_data;
> +       struct call *call;
> +
> +       call =3D telephony_new_call(dev->telephony, id,
> +                                       hfp_call_status_to_call_state(sta=
tus),
> +                                       NULL);
> +       if (telephony_call_register_interface(call)) {
> +               telephony_free_call(call);
> +               return;
> +       }
> +
> +       dev->calls =3D g_slist_append(dev->calls, call);
> +}
> +
> +static void hfp_hf_call_removed(uint id, void *user_data)
> +{
> +       struct hfp_device *dev =3D user_data;
> +       GSList *match;
> +       struct call *call;
> +
> +       match =3D g_slist_find_custom(dev->calls, GINT_TO_POINTER(id),
> +                                                       call_id_cmp);
> +       if (!match) {
> +               DBG("Unknown call id: %u", id);
> +               return;
> +       }
> +       call =3D match->data;
> +
> +       telephony_call_set_state(call, CALL_STATE_DISCONNECTED);
> +       dev->calls =3D g_slist_remove(dev->calls, call);
> +       telephony_call_unregister_interface(call);
> +}
> +
>  static void hfp_hf_session_ready_cb(enum hfp_result res, enum hfp_error =
cme_err,
>                                                         void *user_data)
>  {
> @@ -129,10 +194,51 @@ static void hfp_hf_session_ready_cb(enum hfp_result=
 res, enum hfp_error cme_err,
>         telephony_set_state(dev->telephony, CONNECTED);
>  }
>
> +static void hfp_hf_call_status_updated(uint id, enum hfp_call_status sta=
tus,
> +                                                       void *user_data)
> +{
> +       struct hfp_device *dev =3D user_data;
> +       GSList *match;
> +       struct call *call;
> +
> +       match =3D g_slist_find_custom(dev->calls, GINT_TO_POINTER(id),
> +                                                       call_id_cmp);
> +       if (!match) {
> +               DBG("Unknown call id: %u", id);
> +               return;
> +       }
> +       call =3D match->data;
> +
> +       telephony_call_set_state(call, hfp_call_status_to_call_state(stat=
us));
> +}
> +
> +static void hfp_hf_call_line_id_updated(uint id, const char *number,
> +                                                       unsigned int type=
,
> +                                                       void *user_data)
> +{
> +       struct hfp_device *dev =3D user_data;
> +       GSList *match;
> +       struct call *call;
> +
> +       match =3D g_slist_find_custom(dev->calls, GINT_TO_POINTER(id),
> +                                                       call_id_cmp);
> +       if (!match) {
> +               DBG("Unknown call id: %u", id);
> +               return;
> +       }
> +       call =3D match->data;
> +
> +       telephony_call_set_line_id(call, number);
> +}
> +
>  static struct hfp_hf_callbacks hf_session_callbacks =3D {
>         .session_ready =3D hfp_hf_session_ready_cb,
>         .update_indicator =3D hfp_hf_update_indicator,
>         .update_operator =3D hfp_hf_update_operator,
> +       .call_added =3D hfp_hf_call_added,
> +       .call_removed =3D hfp_hf_call_removed,
> +       .call_status_updated =3D hfp_hf_call_status_updated,
> +       .call_line_id_updated =3D hfp_hf_call_line_id_updated,
>  };
>
>  static void hfp_disconnect_watch(void *user_data)
> @@ -184,7 +290,85 @@ failed:
>         device_destroy(dev);
>  }
>
> +static void cmd_complete(enum hfp_result res, enum hfp_error cme_err,
> +                                                       void *user_data)
> +{
> +       DBusMessage *msg =3D user_data;
> +
> +       if (res !=3D HFP_RESULT_OK) {
> +               DBusMessage *reply;
> +               const char *name =3D dbus_message_get_member(msg);
> +
> +               error("Command %s error: %d", name, res);
> +               reply =3D g_dbus_create_error(msg, ERROR_INTERFACE
> +                                       ".Failed",
> +                                       "Command %s failed: %d", name, re=
s);
> +               g_dbus_send_message(btd_get_dbus_connection(), reply);
> +               dbus_message_unref(msg);
> +               return;
> +       }
> +
> +       g_dbus_send_reply(btd_get_dbus_connection(), msg, DBUS_TYPE_INVAL=
ID);
> +       dbus_message_unref(msg);
> +}
> +
> +static DBusMessage *dial(DBusConnection *conn, DBusMessage *msg,
> +                               void *profile_data)
> +{
> +       struct hfp_device *dev =3D profile_data;
> +       const char *number;
> +       bool ret;
> +
> +       if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &number,
> +                                       DBUS_TYPE_INVALID)) {
> +               return btd_error_invalid_args(msg);
> +       }
> +
> +       if (strncmp(number, URI_PREFIX, strlen(URI_PREFIX)) !=3D 0)
> +               return btd_error_invalid_args(msg);
> +
> +       ret =3D hfp_hf_dial(dev->hf, number + strlen(URI_PREFIX), cmd_com=
plete,
> +                                       dbus_message_ref(msg));
> +       if (!ret)
> +               return btd_error_failed(msg, "Dial command failed");
> +
> +       return NULL;
> +}
> +
> +static DBusMessage *call_answer(DBusConnection *conn, DBusMessage *msg,
> +                               void *call_data)
> +{
> +       struct call *call =3D call_data;
> +       struct hfp_device *dev =3D telephony_get_profile_data(call->devic=
e);
> +       bool ret;
> +
> +       ret =3D hfp_hf_call_answer(dev->hf, call->idx, cmd_complete,
> +                                       dbus_message_ref(msg));
> +       if (!ret)
> +               return btd_error_failed(msg, "Answer call command failed"=
);
> +
> +       return NULL;
> +}
> +
> +static DBusMessage *call_hangup(DBusConnection *conn, DBusMessage *msg,
> +                               void *call_data)
> +{
> +       struct call *call =3D call_data;
> +       struct hfp_device *dev =3D telephony_get_profile_data(call->devic=
e);
> +       bool ret;
> +
> +       ret =3D hfp_hf_call_hangup(dev->hf, call->idx, cmd_complete,
> +                                       dbus_message_ref(msg));
> +       if (!ret)
> +               return btd_error_failed(msg, "Hangup call command failed"=
);
> +
> +       return NULL;
> +}
> +
>  struct telephony_callbacks hfp_callbacks =3D {
> +       .dial =3D dial,
> +       .call_answer =3D call_answer,
> +       .call_hangup =3D call_hangup,
>  };
>
>  static int hfp_connect(struct btd_service *service)
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
