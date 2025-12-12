Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8842A1FBC8C
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765552661; cv=none; b=DP1EYMFIKoQOlBks2yOFtFdqXP6/68Oozdv0PC/ko7tH8CvuaD8mRswyCPd91YWSOQH96LWFxDjTZRGkYuDub9qIUHTgalWcNYJstZWnpvTOAeccaTMfgeZTTJc47yf0qYlmsajerP1PErxVMtGd22PVdw7erP5Se0h2RQSh+h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765552661; c=relaxed/simple;
	bh=I+Z2bx+HShSCWG6DgczQxzCv8VqHGNV9Pke/GIaeb2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRSFwgLGXvzQAbauXVxa+58E4LDIF0Kz9IcgKg5yrFZTOh8eRNtmCEadJpIue/OSKEUL1hKNGg8WKaJy3CGp5/8BKIOO6Xs4fWgjQ463uLCb3r5EXFCZBA8/kJqEFDAFykGzjqzvLvujX64nIPbY49YSinxSmSEoQOE4nJpHMIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BoFmStS3; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoFmStS3"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-37a33b06028so12385341fa.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 07:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765552653; x=1766157453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THl4JlscHdahSfkatS+5tZj3ve01/HOIhwzoWodCcjY=;
        b=BoFmStS3QFTBGOLoe2NW7I4JPbI+bAqktEu63Hfn3VPAafl/fhlteo3wBglgXOGYd6
         kcS7Q5Kv54DULVT2mhP55jj2Sqksb7v5kjhEJC5U5T2nQ95uE87y9adPrR7u57TvdDKB
         DzHoSh8ux/w9zFdqy8EuRpwGhL1ngkrBNPMH39Snuy4HnMkgw7R19Q9mZxpLn4WXQqS0
         g0IGGlm0lsj0W1KaE3/g+sCh2b4j1A9D1I0WCvfKcoHR7N7Dl+9kNVzuhKlhPzIhiaVW
         QCG5YwgwPuCJ/QIJXjuoZwk/kLcEKsvXGl1B+LvhW2nfVUkSqd5xH2Jakc8A2dfP9Ld4
         q3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765552653; x=1766157453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=THl4JlscHdahSfkatS+5tZj3ve01/HOIhwzoWodCcjY=;
        b=KlWeDUTzmtxriH0CpCSfMlZcz+QCrY7apWRinqrIXiZfI48u6pbxNp8Pkm8UTQUAUA
         MjkYTNBhXkQVcWMzICS1UrR75YPmzjrWJMmsOkPoUTp0xeO0in75iXjybvPo6tagz2+t
         adVMXB5Sf7Tdv0bEyeAQch5ehu0vOWyfUkMyilKI42bJ4xY0FVqDK42Z8v3IHaeIDQZB
         lD7Pdd91igy0/KKOhpeQludyuWpizLZ2UGdcWEEtsyWyO3UYx7yx8kD/PGfv07KJ17SS
         CzXxS4dwUTRAxLIe/hw6ePWm9pl11/bh24/V/KzWUz4OzcsPH+/zwmdzNeucIOHuzcev
         ioEQ==
X-Gm-Message-State: AOJu0Yx/m4OUgF3TVyr4plgW36IiAqL6d6Al6a5ed8kK6G3MHRR/S7xa
	BZpIhxh6LFrrE6//O9z6ibtrjp9klG5E2SYoVAiIGARs/ySnknnE3Py4OSn+jsroioY1nwfArNl
	jwgrtMT28Fc4v8xOcOqfY07EnVQVdYYjycWKE6Zc=
X-Gm-Gg: AY/fxX679L3O5NR+YkIY9kBn52iIQHZgwazGMFs5kTzByRmvZrLuX4ZxT7Ml5h/3GMM
	xD29hpXL5dKEv1efpf3OZKaqlKUP3SzjqLa/w4I/QKX5uooR4Edz8By09ELASnzt+BiAApZQXFH
	QPDT9RBSMQS5A+PdO0gIxyIroEtbuIcPzXL1bee+j5PyI3USNDBJUTPV5VkeIpMDLb8vNefuxhz
	T/aR/VxYaMKVTDaeR5bk41zyIl9V1zilsf5ZsOmYepV26TnL+x+y5QaKKUeTm6f6MJoBQ==
X-Google-Smtp-Source: AGHT+IGErrwxYsx/F7ojRitsywIJvP/fHuW24i+dsRR/l5O7YDzMTjLJxyfC++uU0HxBQx9EpxrFWFd1xaLOFdvTScw=
X-Received: by 2002:a2e:a554:0:b0:37a:45b0:467a with SMTP id
 38308e7fff4ca-37fd072585dmr8180311fa.5.1765552652364; Fri, 12 Dec 2025
 07:17:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1765484150.git.pav@iki.fi> <f343a41406876428005288982a73bc20ae5d10b7.1765484150.git.pav@iki.fi>
In-Reply-To: <f343a41406876428005288982a73bc20ae5d10b7.1765484150.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 12 Dec 2025 10:17:18 -0500
X-Gm-Features: AQt7F2rYbdDusaqncrjhi3UPkKIl-I8if0qrkptrox7Lj9M5k57l0MjUdg2crEE
Message-ID: <CABBYNZJq4A+SgGsk6HiGx-ydfGikpqW5O_W4o72efgGr9mYYUA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v5 1/7] shared/mcp: support multiple MCP, and add
 non-stub MCS server
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Thu, Dec 11, 2025 at 3:16=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> For Media Control Client, add support for multiple GMCS / MCS services
> on the server. Revise the API accordingly.
>
> For Media Control Server, make it a complete implementation (OTS still
> missing), and add an API the profile can use.
>
> This is mostly a complete rewrite.
> ---
>  lib/bluetooth/uuid.h |   27 +-
>  src/shared/mcp.c     | 3216 ++++++++++++++++++++++++------------------
>  src/shared/mcp.h     |  186 ++-
>  src/shared/mcs.h     |   51 +-
>  4 files changed, 2086 insertions(+), 1394 deletions(-)
>
> diff --git a/lib/bluetooth/uuid.h b/lib/bluetooth/uuid.h
> index 805366c3d..74bd83742 100644
> --- a/lib/bluetooth/uuid.h
> +++ b/lib/bluetooth/uuid.h
> @@ -198,20 +198,21 @@ extern "C" {
>  #define        AICS_AUDIO_INPUT_CP_CHRC_UUID           0X2B7B
>  #define        AICS_INPUT_DESCR_CHAR_UUID              0X2B7C
>
> +#define MCS_UUID                                0x1848
>  #define GMCS_UUID                               0x1849
> -#define MEDIA_PLAYER_NAME_CHRC_UUID             0x2b93
> -#define MEDIA_TRACK_CHNGD_CHRC_UUID             0x2b96
> -#define MEDIA_TRACK_TITLE_CHRC_UUID             0x2b97
> -#define MEDIA_TRACK_DURATION_CHRC_UUID          0x2b98
> -#define MEDIA_TRACK_POSTION_CHRC_UUID           0x2b99
> -#define MEDIA_PLAYBACK_SPEED_CHRC_UUID          0x2b9a
> -#define MEDIA_SEEKING_SPEED_CHRC_UUID           0x2b9b
> -#define MEDIA_PLAYING_ORDER_CHRC_UUID           0x2ba1
> -#define MEDIA_PLAY_ORDER_SUPPRTD_CHRC_UUID      0x2ba2
> -#define MEDIA_STATE_CHRC_UUID                   0x2ba3
> -#define MEDIA_CP_CHRC_UUID                      0x2ba4
> -#define MEDIA_CP_OP_SUPPORTED_CHRC_UUID         0x2ba5
> -#define MEDIA_CONTENT_CONTROL_ID_CHRC_UUID      0x2bba
> +#define MCS_MEDIA_PLAYER_NAME_CHRC_UUID         0x2b93
> +#define MCS_TRACK_CHANGED_CHRC_UUID             0x2b96
> +#define MCS_TRACK_TITLE_CHRC_UUID               0x2b97
> +#define MCS_TRACK_DURATION_CHRC_UUID            0x2b98
> +#define MCS_TRACK_POSITION_CHRC_UUID            0x2b99
> +#define MCS_PLAYBACK_SPEED_CHRC_UUID            0x2b9a
> +#define MCS_SEEKING_SPEED_CHRC_UUID             0x2b9b
> +#define MCS_PLAYING_ORDER_CHRC_UUID             0x2ba1
> +#define MCS_PLAYING_ORDER_SUPPORTED_CHRC_UUID   0x2ba2
> +#define MCS_MEDIA_STATE_CHRC_UUID               0x2ba3
> +#define MCS_MEDIA_CP_CHRC_UUID                  0x2ba4
> +#define MCS_MEDIA_CP_OP_SUPPORTED_CHRC_UUID     0x2ba5
> +#define MCS_CCID_CHRC_UUID                      0x2bba
>
>  /* Telephony and Media Audio Service */
>  #define TMAS_UUID_STR          "00001855-0000-1000-8000-00805f9b34fb"
> diff --git a/src/shared/mcp.c b/src/shared/mcp.c
> index 3b03aff40..21c666175 100644
> --- a/src/shared/mcp.c
> +++ b/src/shared/mcp.c
> @@ -3,7 +3,8 @@
>   *
>   *  BlueZ - Bluetooth protocol stack for Linux
>   *
> - *  Copyright (C) 2022  Intel Corporation. All rights reserved.
> + *  Copyright (C) 2022 Intel Corporation. All rights reserved.
> + *  Copyright (C) 2025 Pauli Virtanen. All rights reserved.
>   *
>   */
>
> @@ -29,1463 +30,2004 @@
>  #include "src/shared/mcp.h"
>  #include "src/shared/mcs.h"
>
> -#define DBG(_mcp, fmt, arg...) \
> -       mcp_debug(_mcp, "%s:%s() " fmt, __FILE__, __func__, ## arg)
> +#define DBG_MCP(mcp, fmt, ...) \
> +       mcp_debug(mcp, "%s:%s() mcp %p | " fmt, __FILE__, __func__, mcp, =
\
> +                                                               ##__VA_AR=
GS__)
> +#define DBG_SVC(service, fmt, ...) \
> +       mcp_debug(service->mcp, "%s:%s() svc %p | " fmt, __FILE__, __func=
__, \
> +                                                       service, ##__VA_A=
RGS__)
> +#define DBG_MCS(mcs, fmt, ...) \
> +       mcs_debug(mcs, "%s:%s() mcs %p | " fmt, __FILE__, __func__, mcs, =
\
> +                                                               ##__VA_AR=
GS__)
>
> -struct bt_mcp_db {
> -       struct gatt_db *db;
> -       struct bt_mcs *mcs;
> -};
> +#define MAX_ATTR       32
> +#define MAX_PENDING    256
>
> -struct bt_mcp_pending {
> -       unsigned int id;
> -       struct bt_mcp *mcp;
> -       bt_gatt_client_read_callback_t func;
> -       void *user_data;
> -};
> +struct bt_mcs_db {
> +       bool gmcs;
> +       int ccid_value;
> +       uint32_t media_cp_op_supported_value;
> +       uint16_t playing_order_supported_value;
>
> -struct event_callback {
> -       const struct bt_mcp_event_callback *cbs;
> -       void *user_data;
> -};
> -
> -struct bt_mcp_session_info {
> -       uint8_t content_control_id;
> -       uint32_t cp_op_supported;
> -};
> -
> -struct bt_mcp {
> -       int ref_count;
> -       struct bt_gatt_client *client;
> -       struct bt_mcp_db *ldb;
> -       struct bt_mcp_db *rdb;
> -       unsigned int mp_name_id;
> -       unsigned int track_changed_id;
> -       unsigned int track_title_id;
> -       unsigned int track_duration_id;
> -       unsigned int track_position_id;
> -       unsigned int media_state_id;
> -       unsigned int media_cp_id;
> -       unsigned int media_cp_op_supported_id;
> -
> -       struct bt_mcp_session_info session;
> -       struct event_callback *cb;
> -
> -       struct queue *pending;
> -
> -       bt_mcp_debug_func_t debug_func;
> -       bt_mcp_destroy_func_t debug_destroy;
> -       void *debug_data;
> -       void *user_data;
> -};
> -
> -struct bt_mcs {
> -       struct bt_mcp_db *mdb;
>         struct gatt_db_attribute *service;
> -       struct gatt_db_attribute *mp_name;
> +       struct gatt_db_attribute *media_player_name;
> +       struct gatt_db_attribute *media_player_name_ccc;
>         struct gatt_db_attribute *track_changed;
>         struct gatt_db_attribute *track_changed_ccc;
>         struct gatt_db_attribute *track_title;
> +       struct gatt_db_attribute *track_title_ccc;
>         struct gatt_db_attribute *track_duration;
> +       struct gatt_db_attribute *track_duration_ccc;
>         struct gatt_db_attribute *track_position;
> +       struct gatt_db_attribute *track_position_ccc;
>         struct gatt_db_attribute *playback_speed;
> +       struct gatt_db_attribute *playback_speed_ccc;
>         struct gatt_db_attribute *seeking_speed;
> -       struct gatt_db_attribute *play_order;
> -       struct gatt_db_attribute *play_order_supported;
> +       struct gatt_db_attribute *seeking_speed_ccc;
> +       struct gatt_db_attribute *playing_order;
> +       struct gatt_db_attribute *playing_order_ccc;
> +       struct gatt_db_attribute *playing_order_supported;
>         struct gatt_db_attribute *media_state;
>         struct gatt_db_attribute *media_state_ccc;
>         struct gatt_db_attribute *media_cp;
>         struct gatt_db_attribute *media_cp_ccc;
> -       struct gatt_db_attribute *media_cp_op_supportd;
> -       struct gatt_db_attribute *content_control_id;
> -       struct gatt_db_attribute *content_control_id_ccc;
> +       struct gatt_db_attribute *media_cp_op_supported;
> +       struct gatt_db_attribute *media_cp_op_supported_ccc;
> +       struct gatt_db_attribute *ccid;
>  };
>
> -static struct queue *mcp_db;
> +struct bt_mcs_client {
> +       struct bt_att *att;
> +
> +       /* Per-client state.
> +        *
> +        * Concurrency is not specified in MCS v1.0.1, everything current=
ly
> +        * implemented seems OK to be in global state.
> +        *
> +        * TODO: Search Results ID likely should go here
> +        */
> +};
> +
> +struct bt_mcs {
> +       struct gatt_db *db;
> +       struct bt_mcs_db ldb;
> +       struct queue *clients;
> +
> +       uint8_t media_state;
> +
> +       const struct bt_mcs_callback *cb;
> +       void *user_data;
> +};
> +
> +struct bt_mcp_listener {
> +       const struct bt_mcp_listener_callback *cb;
> +       void *user_data;
> +};
> +
> +struct bt_mcp_service {
> +       struct bt_mcp *mcp;
> +       struct bt_mcs_db rdb;
> +
> +       bool ready;
> +
> +       unsigned int notify_id[MAX_ATTR];
> +       unsigned int notify_id_count;
> +
> +       unsigned int pending_id;
> +
> +       struct queue *pending;
> +       struct queue *listeners;
> +};
> +
> +struct bt_mcp_pending {
> +       struct bt_mcp_service *service;
> +       unsigned int id;
> +       uint8_t op;
> +       struct {
> +               unsigned int client_id;
> +               struct gatt_db_attribute *attrib;
> +               uint8_t result;
> +       } write;
> +};
> +
> +struct bt_mcp {
> +       bool gmcs;
> +       struct bt_gatt_client *client;
> +       unsigned int idle_id;
> +       unsigned int db_id;
> +       bool ready;
> +
> +       struct queue *services;
> +
> +       const struct bt_mcp_callback *cb;
> +       void *user_data;
> +};
> +
> +#define MCS_COMMAND(name_, op_, arg_, end_state_) \
> +       { \
> +               .name =3D name_, \
> +               .op =3D BT_MCS_CMD_ ## op_, \
> +               .support =3D BT_MCS_CMD_ ## op_ ## _SUPPORTED, \
> +               .int32_arg =3D arg_, \
> +               .end_state =3D end_state_, \
> +       }
> +
> +#define ANY_STATE      -1
> +
> +static const struct mcs_command {
> +       const char *name;
> +       uint8_t op;
> +       uint32_t support;
> +       bool int32_arg;
> +       int end_state;
> +} mcs_command[] =3D {
> +       MCS_COMMAND("Play", PLAY, false, BT_MCS_STATE_PLAYING),
> +       MCS_COMMAND("Pause", PAUSE, false, BT_MCS_STATE_PAUSED),
> +       MCS_COMMAND("Fast Rewind", FAST_REWIND, false, BT_MCS_STATE_SEEKI=
NG),
> +       MCS_COMMAND("Fast Forward", FAST_FORWARD, false, BT_MCS_STATE_SEE=
KING),
> +       MCS_COMMAND("Stop", STOP, false, BT_MCS_STATE_PAUSED),
> +       MCS_COMMAND("Move Relative", MOVE_RELATIVE, true, ANY_STATE),
> +       MCS_COMMAND("Prev Segment", PREV_SEGMENT, false, ANY_STATE),
> +       MCS_COMMAND("Next Segment", NEXT_SEGMENT, false, ANY_STATE),
> +       MCS_COMMAND("First Segment", FIRST_SEGMENT, false, ANY_STATE),
> +       MCS_COMMAND("Last Segment", LAST_SEGMENT, false, ANY_STATE),
> +       MCS_COMMAND("Goto Segment", GOTO_SEGMENT, true, ANY_STATE),
> +       MCS_COMMAND("Prev Track", PREV_TRACK, false, ANY_STATE),
> +       MCS_COMMAND("Next Track", NEXT_TRACK, false, ANY_STATE),
> +       MCS_COMMAND("First Track", FIRST_TRACK, false, ANY_STATE),
> +       MCS_COMMAND("Last Track", LAST_TRACK, false, ANY_STATE),
> +       MCS_COMMAND("Goto Track", GOTO_TRACK, true, ANY_STATE),
> +       MCS_COMMAND("Prev Group", PREV_GROUP, false, ANY_STATE),
> +       MCS_COMMAND("Next Group", NEXT_GROUP, false, ANY_STATE),
> +       MCS_COMMAND("First Group", FIRST_GROUP, false, ANY_STATE),
> +       MCS_COMMAND("Last Group", LAST_GROUP, false, ANY_STATE),
> +       MCS_COMMAND("Goto Group", GOTO_GROUP, true, ANY_STATE),
> +};
> +
> +#define MCS_PLAYING_ORDER(name) \
> +       { BT_MCS_ORDER_ ## name, BT_MCS_ORDER_SUPPORTED_ ## name }
> +
> +static const struct {
> +       uint8_t order;
> +       uint16_t support;
> +} mcs_playing_orders[] =3D {
> +       MCS_PLAYING_ORDER(SINGLE_ONCE),
> +       MCS_PLAYING_ORDER(SINGLE_REPEAT),
> +       MCS_PLAYING_ORDER(IN_ORDER_ONCE),
> +       MCS_PLAYING_ORDER(IN_ORDER_REPEAT),
> +       MCS_PLAYING_ORDER(OLDEST_ONCE),
> +       MCS_PLAYING_ORDER(OLDEST_REPEAT),
> +       MCS_PLAYING_ORDER(NEWEST_ONCE),
> +       MCS_PLAYING_ORDER(NEWEST_REPEAT),
> +       MCS_PLAYING_ORDER(SHUFFLE_ONCE),
> +       MCS_PLAYING_ORDER(SHUFFLE_REPEAT)
> +};
> +
> +typedef bool (*mcs_command_func_t)(void *data);
> +typedef bool (*mcs_command_func_int32_t)(void *data, int32_t offset);
> +typedef void (*mcs_get_func_t)(struct bt_mcs *mcs, struct iovec *buf,
> +                                                               size_t si=
ze);
> +typedef bool (*mcs_set_func_t)(struct bt_mcs *mcs, void *data);
> +
> +static struct queue *servers;
> +static uint8_t servers_ccid;
> +
> +
> +/*
> + * MCS Server
> + */
> +
> +static void mcs_debug_func(const char *str, void *user_data)
> +{
> +       struct bt_mcs *mcs =3D user_data;
> +
> +       mcs->cb->debug(mcs->user_data, str);
> +}
> +
> +static void mcs_debug(struct bt_mcs *mcs, const char *format, ...)
> +{
> +       va_list ap;
> +
> +       if (!mcs || !format || !mcs->cb->debug)
> +               return;
> +
> +       va_start(ap, format);
> +       util_debug_va(mcs_debug_func, mcs, format, ap);
> +       va_end(ap);
> +}
> +
> +static const struct mcs_command *mcs_get_command(uint8_t op)
> +{
> +       size_t i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(mcs_command); ++i)
> +               if (mcs_command[i].op =3D=3D op)
> +                       return &mcs_command[i];
> +
> +       return NULL;
> +}
> +
> +static mcs_command_func_t mcs_get_handler(struct bt_mcs *mcs, uint8_t op=
)
> +
> +{
> +       switch (op) {
> +       case BT_MCS_CMD_PLAY: return mcs->cb->play;
> +       case BT_MCS_CMD_PAUSE: return mcs->cb->pause;
> +       case BT_MCS_CMD_FAST_REWIND: return mcs->cb->fast_rewind;
> +       case BT_MCS_CMD_FAST_FORWARD: return mcs->cb->fast_forward;
> +       case BT_MCS_CMD_STOP: return mcs->cb->stop;
> +       case BT_MCS_CMD_PREV_SEGMENT: return mcs->cb->previous_segment;
> +       case BT_MCS_CMD_NEXT_SEGMENT: return mcs->cb->next_segment;
> +       case BT_MCS_CMD_FIRST_SEGMENT: return mcs->cb->first_segment;
> +       case BT_MCS_CMD_LAST_SEGMENT: return mcs->cb->last_segment;
> +       case BT_MCS_CMD_PREV_TRACK: return mcs->cb->previous_track;
> +       case BT_MCS_CMD_NEXT_TRACK: return mcs->cb->next_track;
> +       case BT_MCS_CMD_FIRST_TRACK: return mcs->cb->first_track;
> +       case BT_MCS_CMD_LAST_TRACK: return mcs->cb->last_track;
> +       case BT_MCS_CMD_PREV_GROUP: return mcs->cb->previous_group;
> +       case BT_MCS_CMD_NEXT_GROUP: return mcs->cb->next_group;
> +       case BT_MCS_CMD_FIRST_GROUP: return mcs->cb->first_group;
> +       case BT_MCS_CMD_LAST_GROUP: return mcs->cb->last_group;
> +       }
> +       return NULL;
> +}
> +
> +static mcs_command_func_int32_t mcs_get_handler_int32(struct bt_mcs *mcs=
,
> +                                                               uint8_t o=
p)
> +
> +{
> +       switch (op) {
> +       case BT_MCS_CMD_MOVE_RELATIVE: return mcs->cb->move_relative;
> +       case BT_MCS_CMD_GOTO_SEGMENT: return mcs->cb->goto_segment;
> +       case BT_MCS_CMD_GOTO_TRACK: return mcs->cb->goto_track;
> +       case BT_MCS_CMD_GOTO_GROUP: return mcs->cb->goto_group;
> +       }
> +       return NULL;
> +}
> +
> +static uint32_t mcs_get_supported(struct bt_mcs *mcs)
> +{
> +       unsigned int i;
> +       uint32_t value =3D 0;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(mcs_command); ++i)
> +               value |=3D mcs_command[i].support;
> +
> +       if (mcs->cb->media_cp_op_supported)
> +               value =3D mcs->cb->media_cp_op_supported(mcs->user_data);
> +
> +       for (i =3D 0; i < ARRAY_SIZE(mcs_command); ++i) {
> +               void *handler =3D mcs_get_handler(mcs, mcs_command[i].op)=
;
> +
> +               if (!handler)
> +                       handler =3D mcs_get_handler_int32(mcs, mcs_comman=
d[i].op);
> +               if (!handler)
> +                       value &=3D ~mcs_command[i].support;
> +       }
> +
> +       mcs->ldb.media_cp_op_supported_value =3D value;
> +       return value;
> +}
> +
> +static void write_media_cp(struct gatt_db_attribute *attrib,
> +                               unsigned int id, uint16_t offset,
> +                               const uint8_t *data, size_t len,
> +                               uint8_t opcode, struct bt_att *att,
> +                               void *user_data)
> +{
> +       struct bt_mcs *mcs =3D user_data;
> +       struct iovec iov =3D { .iov_base =3D (void *)data, .iov_len =3D l=
en };
> +       const struct mcs_command *cmd =3D NULL;
> +       struct bt_mcs_cp_rsp rsp =3D {
> +               .op =3D 0,
> +               .result =3D BT_MCS_RESULT_COMMAND_CANNOT_COMPLETE
> +       };
> +       int ret =3D 0;
> +       int32_t arg =3D 0;
> +       uint8_t op;
> +       bool ok =3D false;
> +
> +       if (offset) {
> +               ret =3D BT_ATT_ERROR_INVALID_OFFSET;
> +               goto respond;
> +       }
> +
> +       if (!util_iov_pull_u8(&iov, &op)) {
> +               ret =3D BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
> +               goto respond;
> +       }
> +
> +       rsp.op =3D op;
> +
> +       cmd =3D mcs_get_command(op);
> +       if (!cmd || !(cmd->support & mcs_get_supported(mcs))) {
> +               rsp.result =3D BT_MCS_RESULT_OP_NOT_SUPPORTED;
> +               goto respond;
> +       }
> +
> +       DBG_MCS(mcs, "Command %s", cmd->name);
> +
> +       /* We may attempt to perform the operation also if inactive (MCS =
v1.0.1
> +        * p. 26), leave decision to upper layer.
> +        */
> +
> +       ok =3D cmd->int32_arg ?
> +               mcs_get_handler_int32(mcs, op)(mcs->user_data, arg) :
> +               mcs_get_handler(mcs, op)(mcs->user_data);
> +       if (ok)
> +               rsp.result =3D BT_MCS_RESULT_SUCCESS;
> +       else if (mcs->media_state =3D=3D BT_MCS_STATE_INACTIVE)
> +               rsp.result =3D BT_MCS_RESULT_MEDIA_PLAYER_INACTIVE;
> +       else
> +               rsp.result =3D BT_MCS_RESULT_COMMAND_CANNOT_COMPLETE;
> +
> +respond:
> +       DBG_MCS(mcs, "%s ret %u result %u", cmd ? cmd->name : "-",
> +                                                       ret, rsp.result);
> +
> +       gatt_db_attribute_write_result(attrib, id, ret);
> +       if (!rsp.op)
> +               return;
> +
> +       /* Make state transition immediately if command was successful an=
d has
> +        * specified end state. Upper layer shall emit spontaneous transi=
tions
> +        * to correct as needed.
> +        */
> +       if (ok) {
> +               bt_mcs_set_media_state(mcs, cmd->end_state);
> +
> +               switch (op) {
> +               case BT_MCS_CMD_STOP:
> +               case BT_MCS_CMD_PREV_TRACK:
> +               case BT_MCS_CMD_NEXT_TRACK:
> +               case BT_MCS_CMD_FIRST_TRACK:
> +               case BT_MCS_CMD_LAST_TRACK:
> +               case BT_MCS_CMD_GOTO_TRACK:
> +               case BT_MCS_CMD_PREV_GROUP:
> +               case BT_MCS_CMD_NEXT_GROUP:
> +               case BT_MCS_CMD_FIRST_GROUP:
> +               case BT_MCS_CMD_LAST_GROUP:
> +               case BT_MCS_CMD_GOTO_GROUP:
> +                       if (mcs->cb->set_track_position)
> +                               mcs->cb->set_track_position(mcs->user_dat=
a, 0);
> +                       bt_mcs_changed(mcs, MCS_TRACK_POSITION_CHRC_UUID)=
;
> +                       break;
> +               }
> +       }
> +
> +       gatt_db_attribute_notify(attrib, (uint8_t *)&rsp, sizeof(rsp), at=
t);
> +}
> +
> +void bt_mcs_set_media_state(struct bt_mcs *mcs, uint8_t state)
> +{
> +       switch (state) {
> +       case BT_MCS_STATE_INACTIVE:
> +       case BT_MCS_STATE_PLAYING:
> +       case BT_MCS_STATE_PAUSED:
> +       case BT_MCS_STATE_SEEKING:
> +               break;
> +       default:
> +               return;
> +       }
> +
> +       if (state =3D=3D mcs->media_state)
> +               return;
> +
> +       mcs->media_state =3D state;
> +       bt_mcs_changed(mcs, MCS_MEDIA_STATE_CHRC_UUID);
> +}
> +
> +uint8_t bt_mcs_get_media_state(struct bt_mcs *mcs)
> +{
> +       return mcs->media_state;
> +}
> +
> +static void get_media_player_name(struct bt_mcs *mcs, struct iovec *buf,
> +                                                               size_t si=
ze)
> +{
> +       if (mcs->cb->media_player_name)
> +               mcs->cb->media_player_name(mcs->user_data, buf, size);
> +}
> +
> +static void get_track_changed(struct bt_mcs *mcs, struct iovec *buf,
> +                                                               size_t si=
ze)
> +{
> +}
> +
> +static void get_track_title(struct bt_mcs *mcs, struct iovec *buf,
> +                                                               size_t si=
ze)
> +{
> +       if (mcs->cb->track_title)
> +               mcs->cb->track_title(mcs->user_data, buf, size);
> +}
> +
> +static void get_track_duration(struct bt_mcs *mcs, struct iovec *buf,
> +                                                               size_t si=
ze)
> +{
> +       int32_t value =3D BT_MCS_DURATION_UNAVAILABLE;
> +
> +       if (mcs->cb->track_duration)
> +               value =3D mcs->cb->track_duration(mcs->user_data);
> +
> +       util_iov_push_le32(buf, (uint32_t)value);
> +}
> +
> +static void get_track_position(struct bt_mcs *mcs, struct iovec *buf,
> +                                                               size_t si=
ze)
> +{
> +       int32_t value =3D BT_MCS_POSITION_UNAVAILABLE;
> +
> +       if (mcs->cb->track_position)
> +               value =3D mcs->cb->track_position(mcs->user_data);
> +
> +       util_iov_push_le32(buf, (uint32_t)value);
> +}
> +
> +static void get_playback_speed(struct bt_mcs *mcs, struct iovec *buf,
> +                                                               size_t si=
ze)
> +{
> +       int8_t value =3D 0x00;
> +
> +       if (mcs->cb->playback_speed)
> +               value =3D mcs->cb->playback_speed(mcs->user_data);
> +
> +       util_iov_push_u8(buf, (uint8_t)value);
> +}
> +
> +static void get_seeking_speed(struct bt_mcs *mcs, struct iovec *buf,
> +                                                               size_t si=
ze)
> +{
> +       int8_t value =3D 0x00;
> +
> +       if (mcs->cb->seeking_speed)
> +               value =3D mcs->cb->seeking_speed(mcs->user_data);
> +
> +       util_iov_push_u8(buf, (uint8_t)value);
> +}
> +
> +static void get_playing_order(struct bt_mcs *mcs, struct iovec *buf,
> +                                                               size_t si=
ze)
> +{
> +       uint8_t value =3D BT_MCS_ORDER_IN_ORDER_REPEAT;
> +
> +       if (mcs->cb->playing_order)
> +               value =3D mcs->cb->playing_order(mcs->user_data);
> +
> +       util_iov_push_u8(buf, value);
> +}
> +
> +static void get_playing_order_supported(struct bt_mcs *mcs, struct iovec=
 *buf,
> +                                                               size_t si=
ze)
> +{
> +       uint16_t value =3D BT_MCS_ORDER_SUPPORTED_IN_ORDER_REPEAT;
> +
> +       if (mcs->cb->playing_order_supported)
> +               value =3D mcs->cb->playing_order_supported(mcs->user_data=
);
> +
> +       util_iov_push_le16(buf, value);
> +}
> +
> +static void get_media_state(struct bt_mcs *mcs, struct iovec *buf,
> +                                                               size_t si=
ze)
> +{
> +       util_iov_push_u8(buf, mcs->media_state);
> +}
> +
> +static void get_media_cp_op_supported(struct bt_mcs *mcs, struct iovec *=
buf,
> +                                                               size_t si=
ze)
> +{
> +       util_iov_push_le32(buf, mcs_get_supported(mcs));
> +}
> +
> +static void get_ccid(struct bt_mcs *mcs, struct iovec *buf, size_t size)
> +{
> +       util_iov_push_u8(buf, mcs->ldb.ccid_value);
> +}
> +
> +static bool set_track_position(struct bt_mcs *mcs, void *data)
> +{
> +       int32_t value =3D (int32_t)get_le32(data);
> +
> +       DBG_MCS(mcs, "Set Track Position %d", value);
> +
> +       if (mcs->cb->set_track_position)
> +               return mcs->cb->set_track_position(mcs->user_data, value)=
;
> +       return false;
> +}
> +
> +static bool set_playback_speed(struct bt_mcs *mcs, void *data)
> +{
> +       int8_t value =3D (int8_t)get_u8(data);
> +
> +       DBG_MCS(mcs, "Set Playback Speed %d", value);
> +
> +       if (mcs->cb->set_playback_speed)
> +               return mcs->cb->set_playback_speed(mcs->user_data, value)=
;
> +       return false;
> +}
> +
> +static bool set_playing_order(struct bt_mcs *mcs, void *data)
> +{
> +       uint8_t value =3D get_u8(data);
> +
> +       DBG_MCS(mcs, "Set Playing Order %u", value);
> +
> +       if (mcs->cb->set_playing_order)
> +               return mcs->cb->set_playing_order(mcs->user_data, value);
> +       return false;
> +}
> +
> +static void read_result(struct bt_mcs *mcs, struct gatt_db_attribute *at=
trib,
> +                       unsigned int id, uint16_t offset, mcs_get_func_t =
get)
> +{
> +       uint8_t buf[BT_ATT_MAX_VALUE_LEN];
> +       struct iovec iov =3D { .iov_base =3D buf, .iov_len =3D 0 };
> +
> +       get(mcs, &iov, sizeof(buf));
> +
> +       if (offset > iov.iov_len) {
> +               gatt_db_attribute_read_result(attrib, id,
> +                                       BT_ATT_ERROR_INVALID_OFFSET, NULL=
, 0);
> +               return;
> +       }
> +
> +       gatt_db_attribute_read_result(attrib, id, 0, buf + offset,
> +                                                       iov.iov_len - off=
set);
> +}
> +
> +#define READ_FUNC(name) \
> +       static void read_ ## name(struct gatt_db_attribute *attrib, \
> +                               unsigned int id, uint16_t offset, \
> +                               uint8_t opcode, struct bt_att *att, \
> +                               void *user_data) \
> +       { \
> +               DBG_MCS(user_data, ""); \
> +               read_result(user_data, attrib, id, offset, get_ ##name); =
\
> +       }
> +
> +READ_FUNC(media_player_name)
> +READ_FUNC(track_title)
> +READ_FUNC(track_duration)
> +READ_FUNC(track_position)
> +READ_FUNC(playback_speed)
> +READ_FUNC(seeking_speed)
> +READ_FUNC(playing_order)
> +READ_FUNC(playing_order_supported)
> +READ_FUNC(media_state)
> +READ_FUNC(media_cp_op_supported)
> +READ_FUNC(ccid)
> +
> +static void write_result(struct bt_mcs *mcs,
> +                               struct gatt_db_attribute *attrib,
> +                               unsigned int id, uint16_t offset,
> +                               const uint8_t *data, size_t len,
> +                               mcs_get_func_t get, mcs_set_func_t set)
> +{
> +       uint8_t buf[4];
> +       struct iovec iov =3D { .iov_base =3D buf, .iov_len =3D 0 };
> +       bt_uuid_t uuid;
> +       uint8_t ret;
> +
> +       get(mcs, &iov, sizeof(buf));
> +
> +       if (len > iov.iov_len) {
> +               gatt_db_attribute_write_result(attrib, id,
> +                               BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN)=
;
> +               return;
> +       }
> +
> +       if (offset + len > iov.iov_len) {
> +               gatt_db_attribute_write_result(attrib, id,
> +                               BT_ATT_ERROR_INVALID_OFFSET);
> +               return;
> +       }
> +
> +       memcpy(iov.iov_base + offset, data, len);
> +
> +       if (set(mcs, iov.iov_base))
> +               ret =3D 0;
> +       else
> +               ret =3D BT_ATT_ERROR_VALUE_NOT_ALLOWED;
> +
> +       gatt_db_attribute_write_result(attrib, id, ret);
> +
> +       if (!gatt_db_attribute_get_char_data(attrib, NULL, NULL, NULL, NU=
LL,
> +                                                                       &=
uuid))
> +               return;
> +       if (!ret)
> +               bt_mcs_changed(mcs, uuid.value.u16);
> +}
> +
> +#define WRITE_FUNC(name) \
> +       static void write_ ## name(struct gatt_db_attribute *attrib, \
> +                               unsigned int id, uint16_t offset, \
> +                               const uint8_t *data, size_t len, \
> +                               uint8_t opcode, struct bt_att *att, \
> +                               void *user_data) \
> +       { write_result(user_data, attrib, id, offset, data, len, \
> +                                               get_ ## name, set_ ## nam=
e); }
> +
> +WRITE_FUNC(track_position)
> +WRITE_FUNC(playback_speed)
> +WRITE_FUNC(playing_order)
> +
> +void bt_mcs_changed(struct bt_mcs *mcs, uint16_t chrc_uuid)
> +{
> +       struct {
> +               struct gatt_db_attribute *attr;
> +               mcs_get_func_t get;
> +       } attrs[] =3D {
> +               { mcs->ldb.media_player_name, get_media_player_name },
> +               { mcs->ldb.track_changed, get_track_changed },
> +               { mcs->ldb.track_title, get_track_title },
> +               { mcs->ldb.track_duration, get_track_duration },
> +               { mcs->ldb.track_position, get_track_position },
> +               { mcs->ldb.playback_speed, get_playback_speed },
> +               { mcs->ldb.seeking_speed, get_seeking_speed },
> +               { mcs->ldb.playing_order, get_playing_order },
> +               { mcs->ldb.media_state, get_media_state },
> +               { mcs->ldb.media_cp_op_supported, get_media_cp_op_support=
ed },
> +       };
> +       uint8_t buf[BT_ATT_MAX_VALUE_LEN];
> +       struct iovec iov =3D { .iov_base =3D buf, .iov_len =3D 0 };
> +       unsigned int i;
> +       bt_uuid_t uuid, uuid_attr;
> +       uint8_t props;
> +
> +       bt_uuid16_create(&uuid, chrc_uuid);
> +
> +       for (i =3D 0; i < ARRAY_SIZE(attrs); ++i) {
> +               if (!gatt_db_attribute_get_char_data(attrs[i].attr, NULL,
> +                                               NULL, &props, NULL, &uuid=
_attr))
> +                       continue;
> +               if (bt_uuid_cmp(&uuid_attr, &uuid))
> +                       continue;
> +
> +               DBG_MCS(mcs, "Notify %u", chrc_uuid);
> +
> +               attrs[i].get(mcs, &iov, sizeof(buf));
> +
> +               /* No client-specific state: notify everyone */
> +               gatt_db_attribute_notify(attrs[i].attr, iov.iov_base,
> +                                                       iov.iov_len, NULL=
);
> +               break;
> +       }
> +}
> +
> +static bool mcs_init_db(struct bt_mcs *mcs, bool is_gmcs)
> +{
> +       struct gatt_db *db =3D mcs->db;
> +       struct bt_mcs_db *ldb =3D &mcs->ldb;
> +       bt_uuid_t uuid;
> +
> +       bt_uuid16_create(&uuid, is_gmcs ? GMCS_UUID : MCS_UUID);
> +       ldb->service =3D gatt_db_add_service(db, &uuid, true, 38);
> +
> +       /* Add also optional CCC */
> +
> +       bt_uuid16_create(&uuid, MCS_MEDIA_PLAYER_NAME_CHRC_UUID);
> +       ldb->media_player_name =3D gatt_db_service_add_characteristic(
> +               ldb->service, &uuid,
> +               BT_ATT_PERM_READ,
> +               BT_GATT_CHRC_PROP_READ | BT_GATT_CHRC_PROP_NOTIFY,
> +               read_media_player_name, NULL, mcs);
> +
> +       ldb->media_player_name_ccc =3D gatt_db_service_add_ccc(
> +               ldb->service, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
> +
> +       bt_uuid16_create(&uuid, MCS_TRACK_CHANGED_CHRC_UUID);
> +       ldb->track_changed =3D gatt_db_service_add_characteristic(
> +               ldb->service, &uuid,
> +               BT_ATT_PERM_NONE, BT_GATT_CHRC_PROP_NOTIFY,
> +               NULL, NULL, mcs);
> +       gatt_db_attribute_set_fixed_length(ldb->track_changed, 0);
> +
> +       ldb->track_changed_ccc =3D gatt_db_service_add_ccc(
> +               ldb->service, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
> +
> +       bt_uuid16_create(&uuid, MCS_TRACK_TITLE_CHRC_UUID);
> +       ldb->track_title =3D gatt_db_service_add_characteristic(
> +               ldb->service, &uuid,
> +               BT_ATT_PERM_READ,
> +               BT_GATT_CHRC_PROP_READ | BT_GATT_CHRC_PROP_NOTIFY,
> +               read_track_title, NULL, mcs);
> +
> +       ldb->track_title_ccc =3D gatt_db_service_add_ccc(
> +               ldb->service, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
> +
> +       bt_uuid16_create(&uuid, MCS_TRACK_DURATION_CHRC_UUID);
> +       ldb->track_duration =3D gatt_db_service_add_characteristic(
> +               ldb->service, &uuid,
> +               BT_ATT_PERM_READ,
> +               BT_GATT_CHRC_PROP_READ | BT_GATT_CHRC_PROP_NOTIFY,
> +               read_track_duration, NULL, mcs);
> +       gatt_db_attribute_set_fixed_length(ldb->track_duration,
> +                                                       sizeof(int32_t));
> +
> +       ldb->track_duration_ccc =3D gatt_db_service_add_ccc(
> +               ldb->service, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
> +
> +       bt_uuid16_create(&uuid, MCS_TRACK_POSITION_CHRC_UUID);
> +       ldb->track_position =3D gatt_db_service_add_characteristic(
> +               ldb->service, &uuid,
> +               BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
> +               BT_GATT_CHRC_PROP_READ | BT_GATT_CHRC_PROP_NOTIFY |
> +               BT_GATT_CHRC_PROP_WRITE | BT_GATT_CHRC_PROP_WRITE_WITHOUT=
_RESP,
> +               read_track_position, write_track_position, mcs);
> +       gatt_db_attribute_set_fixed_length(ldb->track_position,
> +                                                       sizeof(int32_t));
> +
> +       ldb->track_position_ccc =3D gatt_db_service_add_ccc(
> +               ldb->service, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
> +
> +       bt_uuid16_create(&uuid, MCS_PLAYBACK_SPEED_CHRC_UUID);
> +       ldb->playback_speed =3D gatt_db_service_add_characteristic(
> +               ldb->service, &uuid,
> +               BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
> +               BT_GATT_CHRC_PROP_READ | BT_GATT_CHRC_PROP_NOTIFY |
> +               BT_GATT_CHRC_PROP_WRITE | BT_GATT_CHRC_PROP_WRITE_WITHOUT=
_RESP,
> +               read_playback_speed, write_playback_speed, mcs);
> +       gatt_db_attribute_set_fixed_length(ldb->playback_speed, sizeof(in=
t8_t));
> +
> +       ldb->playback_speed_ccc =3D gatt_db_service_add_ccc(
> +               ldb->service, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
> +
> +       bt_uuid16_create(&uuid, MCS_SEEKING_SPEED_CHRC_UUID);
> +       ldb->seeking_speed =3D gatt_db_service_add_characteristic(
> +               ldb->service, &uuid,
> +               BT_ATT_PERM_READ,
> +               BT_GATT_CHRC_PROP_READ | BT_GATT_CHRC_PROP_NOTIFY,
> +               read_seeking_speed, NULL, mcs);
> +       gatt_db_attribute_set_fixed_length(ldb->seeking_speed, sizeof(int=
8_t));
> +
> +       ldb->seeking_speed_ccc =3D gatt_db_service_add_ccc(
> +               ldb->service, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
> +
> +       bt_uuid16_create(&uuid, MCS_PLAYING_ORDER_CHRC_UUID);
> +       ldb->playing_order =3D gatt_db_service_add_characteristic(
> +               ldb->service, &uuid,
> +               BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
> +               BT_GATT_CHRC_PROP_READ | BT_GATT_CHRC_PROP_NOTIFY |
> +               BT_GATT_CHRC_PROP_WRITE | BT_GATT_CHRC_PROP_WRITE_WITHOUT=
_RESP,
> +               read_playing_order, write_playing_order, mcs);
> +       gatt_db_attribute_set_fixed_length(ldb->playing_order, sizeof(uin=
t8_t));
> +
> +       ldb->playing_order_ccc =3D gatt_db_service_add_ccc(
> +               ldb->service, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
> +
> +       bt_uuid16_create(&uuid, MCS_PLAYING_ORDER_SUPPORTED_CHRC_UUID);
> +       ldb->playing_order_supported =3D gatt_db_service_add_characterist=
ic(
> +               ldb->service, &uuid,
> +               BT_ATT_PERM_READ, BT_GATT_CHRC_PROP_READ,
> +               read_playing_order_supported, NULL, mcs);
> +       gatt_db_attribute_set_fixed_length(ldb->playing_order_supported,
> +                                                       sizeof(uint16_t))=
;
> +
> +       bt_uuid16_create(&uuid, MCS_MEDIA_STATE_CHRC_UUID);
> +       ldb->media_state =3D gatt_db_service_add_characteristic(
> +               ldb->service, &uuid,
> +               BT_ATT_PERM_READ,
> +               BT_GATT_CHRC_PROP_READ | BT_GATT_CHRC_PROP_NOTIFY,
> +               read_media_state, NULL, mcs);
> +       gatt_db_attribute_set_fixed_length(ldb->media_state, sizeof(uint8=
_t));
> +
> +       ldb->media_state_ccc =3D gatt_db_service_add_ccc(
> +               ldb->service, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
> +
> +       bt_uuid16_create(&uuid, MCS_MEDIA_CP_CHRC_UUID);
> +       ldb->media_cp =3D gatt_db_service_add_characteristic(
> +               ldb->service, &uuid,
> +               BT_ATT_PERM_WRITE,
> +               BT_GATT_CHRC_PROP_WRITE | BT_GATT_CHRC_PROP_NOTIFY |
> +                                       BT_GATT_CHRC_PROP_WRITE_WITHOUT_R=
ESP,
> +               NULL, write_media_cp, mcs);
> +
> +       ldb->media_cp_ccc =3D gatt_db_service_add_ccc(
> +               ldb->service, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
> +
> +       bt_uuid16_create(&uuid, MCS_MEDIA_CP_OP_SUPPORTED_CHRC_UUID);
> +       ldb->media_cp_op_supported =3D gatt_db_service_add_characteristic=
(
> +               ldb->service, &uuid,
> +               BT_ATT_PERM_READ,
> +               BT_GATT_CHRC_PROP_READ | BT_GATT_CHRC_PROP_NOTIFY,
> +               read_media_cp_op_supported, NULL, mcs);
> +       gatt_db_attribute_set_fixed_length(ldb->media_cp_op_supported,
> +                                                       sizeof(uint32_t))=
;
> +
> +       ldb->media_cp_op_supported_ccc =3D gatt_db_service_add_ccc(
> +               ldb->service, BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
> +
> +       bt_uuid16_create(&uuid, MCS_CCID_CHRC_UUID);
> +       ldb->ccid =3D gatt_db_service_add_characteristic(
> +               ldb->service, &uuid,
> +               BT_ATT_PERM_READ, BT_GATT_CHRC_PROP_READ,
> +               read_ccid, NULL, mcs);
> +       gatt_db_attribute_set_fixed_length(ldb->ccid, sizeof(uint8_t));
> +
> +       return true;
> +}
> +
> +uint8_t bt_mcs_get_ccid(struct bt_mcs *mcs)
> +{
> +       return mcs->ldb.ccid_value;
> +}
> +
> +struct match_mcs_data {
> +       struct gatt_db *db;
> +       bool gmcs;
> +       bool any;
> +       int ccid;
> +};
> +
> +static bool match_mcs(const void *data, const void *user_data)
> +{
> +       const struct bt_mcs *mcs =3D data;
> +       const struct match_mcs_data *match =3D user_data;
> +
> +       if (match->db !=3D mcs->db)
> +               return false;
> +       if (match->gmcs)
> +               return mcs->ldb.gmcs;
> +       if (match->any)
> +               return true;
> +       return match->ccid =3D=3D mcs->ldb.ccid_value;
> +}
> +
> +static int mcs_alloc_ccid(struct gatt_db *db)
> +{
> +       unsigned int ccid;
> +
> +       if (!db)
> +               return 0;
> +
> +       for (ccid =3D servers_ccid; ccid < servers_ccid + 0x100u; ccid++)=
 {
> +               struct match_mcs_data match =3D { .db =3D db, .ccid =3D c=
cid & 0xff };
> +
> +               if (!queue_find(servers, match_mcs, &match)) {
> +                       servers_ccid =3D ccid + 1;
> +                       return match.ccid;
> +               }
> +       }
> +
> +       return -ENOENT;
> +}
> +
> +void bt_mcs_test_util_reset_ccid(void)
> +{
> +       servers_ccid =3D 0;
> +}
> +
> +struct bt_mcs *bt_mcs_register(struct gatt_db *db, bool is_gmcs,
> +                       const struct bt_mcs_callback *cb, void *user_data=
)
> +{
> +       struct bt_mcs *mcs;
> +       int ccid;
> +
> +       if (!db || !cb)
> +               return NULL;
> +
> +       if (is_gmcs) {
> +               struct match_mcs_data match =3D { .db =3D db, .gmcs =3D t=
rue };
> +
> +               /* Only one GMCS possible */
> +               if (queue_find(servers, match_mcs, &match))
> +                       return NULL;
> +       }
> +
> +       ccid =3D mcs_alloc_ccid(db);
> +       if (ccid < 0)
> +               return NULL;
> +
> +       mcs =3D new0(struct bt_mcs, 1);
> +       mcs->db =3D db;
> +       mcs->ldb.ccid_value =3D ccid;
> +       mcs->cb =3D cb;
> +       mcs->user_data =3D user_data;
> +
> +       mcs->media_state =3D BT_MCS_STATE_INACTIVE;
> +
> +       if (!mcs_init_db(mcs, is_gmcs)) {
> +               free(mcs);
> +               return NULL;
> +       }
> +
> +       gatt_db_ref(mcs->db);
> +
> +       if (!servers)
> +               servers =3D queue_new();
> +       queue_push_tail(servers, mcs);
> +
> +       gatt_db_service_set_active(mcs->ldb.service, true);
> +       return mcs;
> +}
> +
> +void bt_mcs_unregister(struct bt_mcs *mcs)
> +{
> +       if (!mcs)
> +               return;
> +
> +       if (mcs->cb->destroy)
> +               mcs->cb->destroy(mcs->user_data);
> +
> +       queue_remove(servers, mcs);
> +
> +       gatt_db_remove_service(mcs->db, mcs->ldb.service);
> +       gatt_db_unref(mcs->db);
> +
> +       if (queue_isempty(servers)) {
> +               queue_destroy(servers, NULL);
> +               servers =3D NULL;
> +       }
> +
> +       free(mcs);
> +}
> +
> +void bt_mcs_unregister_all(struct gatt_db *db)
> +{
> +       struct bt_mcs *mcs;
> +
> +       do {
> +               struct match_mcs_data match =3D { .db =3D db, .any =3D tr=
ue };
> +
> +               mcs =3D queue_find(servers, match_mcs, &match);
> +               bt_mcs_unregister(mcs);
> +       } while (mcs);
> +}
> +
> +/*
> + * MCP Client
> + */
> +
> +static void mcp_service_reread(struct bt_mcp_service *service,
> +                                       struct gatt_db_attribute *attrib)=
;
> +
> +static void mcp_debug_func(const char *str, void *user_data)
> +{
> +       struct bt_mcp *mcp =3D user_data;
> +
> +       mcp->cb->debug(mcp->user_data, str);
> +}
>
>  static void mcp_debug(struct bt_mcp *mcp, const char *format, ...)
>  {
>         va_list ap;
>
> -       if (!mcp || !format || !mcp->debug_func)
> +       if (!mcp || !format || !mcp->cb->debug)
>                 return;
>
>         va_start(ap, format);
> -       util_debug_va(mcp->debug_func, mcp->debug_data, format, ap);
> +       util_debug_va(mcp_debug_func, mcp, format, ap);
>         va_end(ap);
>  }
>
> -static bool mcp_db_match(const void *data, const void *match_data)
> +static bool match_ccid(const void *data, const void *user_data)
>  {
> -       const struct bt_mcp_db *mdb =3D data;
> -       const struct gatt_db *db =3D match_data;
> +       const struct bt_mcp_service *service =3D data;
>
> -       return (mdb->db =3D=3D db);
> +       return service->rdb.ccid_value =3D=3D (int)PTR_TO_UINT(user_data)=
;
>  }
>
> -static void mcp_db_free(void *data)
> -{
> -       struct bt_mcp_db *bdb =3D data;
> -
> -       if (!bdb)
> -               return;
> -
> -       gatt_db_unref(bdb->db);
> -
> -       free(bdb->mcs);
> -       free(bdb);
> -}
> -
> -static void mcp_free(void *data)
> -{
> -       struct bt_mcp *mcp =3D data;
> -
> -       DBG(mcp, "");
> -
> -       bt_mcp_detach(mcp);
> -
> -       mcp_db_free(mcp->rdb);
> -
> -       queue_destroy(mcp->pending, NULL);
> -
> -       free(mcp);
> -}
> -
> -struct bt_mcp *bt_mcp_ref(struct bt_mcp *mcp)
> +static struct bt_mcp_service *mcp_service(struct bt_mcp *mcp, uint8_t cc=
id)
>  {
>         if (!mcp)
>                 return NULL;
>
> -       __sync_fetch_and_add(&mcp->ref_count, 1);
> -
> -       return mcp;
> +       return queue_find(mcp->services, match_ccid, UINT_TO_PTR(ccid));
>  }
>
> -void bt_mcp_unref(struct bt_mcp *mcp)
> +static bool match_pending(const void *data, const void *user_data)
>  {
> -       if (!mcp)
> -               return;
> +       const struct bt_mcp_pending *pending =3D data;
>
> -       if (__sync_sub_and_fetch(&mcp->ref_count, 1))
> -               return;
> -
> -       mcp_free(mcp);
> +       return pending->id =3D=3D PTR_TO_UINT(user_data);
>  }
>
> -bool bt_mcp_set_user_data(struct bt_mcp *mcp, void *user_data)
> -{
> -       if (!mcp)
> -               return false;
> -
> -       mcp->user_data =3D user_data;
> -
> -       return true;
> -}
> -
> -void *bt_mcp_get_user_data(struct bt_mcp *mcp)
> -{
> -       if (!mcp)
> -               return NULL;
> -
> -       return mcp->user_data;
> -}
> -
> -bool bt_mcp_set_debug(struct bt_mcp *mcp, bt_mcp_debug_func_t func,
> -                       void *user_data, bt_mcp_destroy_func_t destroy)
> -{
> -       if (!mcp)
> -               return false;
> -
> -       if (mcp->debug_destroy)
> -               mcp->debug_destroy(mcp->debug_data);
> -
> -       mcp->debug_func =3D func;
> -       mcp->debug_destroy =3D destroy;
> -       mcp->debug_data =3D user_data;
> -
> -       return true;
> -}
> -
> -static void mcs_mp_name_read(struct gatt_db_attribute *attrib,
> -                               unsigned int id, uint16_t offset,
> -                               uint8_t opcode, struct bt_att *att,
> -                               void *user_data)
> -{
> -       char mp_name[] =3D "";
> -       struct iovec iov;
> -
> -       iov.iov_base =3D mp_name;
> -       iov.iov_len =3D sizeof(mp_name);
> -
> -       gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
> -                                                       iov.iov_len);
> -}
> -
> -static void mcs_track_title_read(struct gatt_db_attribute *attrib,
> -                               unsigned int id, uint16_t offset,
> -                               uint8_t opcode, struct bt_att *att,
> -                               void *user_data)
> -{
> -       char track_title[] =3D "";
> -       struct iovec iov;
> -
> -       iov.iov_base =3D track_title;
> -       iov.iov_len =3D 0;
> -
> -       gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
> -                                                       iov.iov_len);
> -}
> -
> -static void mcs_track_duration_read(struct gatt_db_attribute *attrib,
> -                               unsigned int id, uint16_t offset,
> -                               uint8_t opcode, struct bt_att *att,
> -                               void *user_data)
> -{
> -       int32_t track_duration =3D 0xFFFFFFFF;
> -       struct iovec iov;
> -
> -       iov.iov_base =3D &track_duration;
> -       iov.iov_len =3D sizeof(track_duration);
> -
> -       gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
> -                                                       iov.iov_len);
> -}
> -
> -static void mcs_track_position_read(struct gatt_db_attribute *attrib,
> -                               unsigned int id, uint16_t offset,
> -                               uint8_t opcode, struct bt_att *att,
> -                               void *user_data)
> -{
> -       int32_t track_position =3D 0xFFFFFFFF;
> -       struct iovec iov;
> -
> -       iov.iov_base =3D &track_position;
> -       iov.iov_len =3D sizeof(track_position);
> -
> -       gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
> -                                                       iov.iov_len);
> -}
> -
> -static void mcs_track_position_write(struct gatt_db_attribute *attrib,
> -                               unsigned int id, uint16_t offset,
> -                               const uint8_t *value, size_t len,
> -                               uint8_t opcode, struct bt_att *att,
> -                               void *user_data)
> -{
> -       gatt_db_attribute_write_result(attrib, id,
> -                       BT_ATT_ERROR_INSUFFICIENT_RESOURCES);
> -}
> -
> -static void mcs_playback_speed_read(struct gatt_db_attribute *attrib,
> -                               unsigned int id, uint16_t offset,
> -                               uint8_t opcode, struct bt_att *att,
> -                               void *user_data)
> -{
> -       int8_t playback_speed =3D 0x00;
> -       struct iovec iov;
> -
> -       iov.iov_base =3D &playback_speed;
> -       iov.iov_len =3D sizeof(playback_speed);
> -
> -       gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
> -                                                       iov.iov_len);
> -}
> -
> -static void mcs_playback_speed_write(struct gatt_db_attribute *attrib,
> -                               unsigned int id, uint16_t offset,
> -                               const uint8_t *value, size_t len,
> -                               uint8_t opcode, struct bt_att *att,
> -                               void *user_data)
> -{
> -       gatt_db_attribute_write_result(attrib, id,
> -                               BT_ATT_ERROR_INSUFFICIENT_RESOURCES);
> -}
> -
> -static void mcs_seeking_speed_read(struct gatt_db_attribute *attrib,
> -                               unsigned int id, uint16_t offset,
> -                               uint8_t opcode, struct bt_att *att,
> -                               void *user_data)
> -{
> -       int8_t seeking_speed =3D 0x00;
> -       struct iovec iov;
> -
> -       iov.iov_base =3D &seeking_speed;
> -       iov.iov_len =3D sizeof(seeking_speed);
> -
> -       gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
> -                                                       iov.iov_len);
> -}
> -
> -static void mcs_playing_order_read(struct gatt_db_attribute *attrib,
> -                               unsigned int id, uint16_t offset,
> -                               uint8_t opcode, struct bt_att *att,
> -                               void *user_data)
> -{
> -       uint8_t playing_order =3D 0x01;
> -       struct iovec iov;
> -
> -       iov.iov_base =3D &playing_order;
> -       iov.iov_len =3D sizeof(playing_order);
> -
> -       gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
> -                                                       iov.iov_len);
> -}
> -
> -static void mcs_playing_order_write(struct gatt_db_attribute *attrib,
> -                               unsigned int id, uint16_t offset,
> -                               const uint8_t *value, size_t len,
> -                               uint8_t opcode, struct bt_att *att,
> -                               void *user_data)
> -{
> -       gatt_db_attribute_write_result(attrib, id,
> -                               BT_ATT_ERROR_INSUFFICIENT_RESOURCES);
> -}
> -
> -static void mcs_playing_order_supported_read(struct gatt_db_attribute *a=
ttrib,
> -                               unsigned int id, uint16_t offset,
> -                               uint8_t opcode, struct bt_att *att,
> -                               void *user_data)
> -{
> -       uint16_t playing_order_supported =3D 0x01;
> -       struct iovec iov;
> -
> -       iov.iov_base =3D &playing_order_supported;
> -       iov.iov_len =3D sizeof(playing_order_supported);
> -
> -       gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
> -                                                       iov.iov_len);
> -}
> -
> -static void mcs_media_state_read(struct gatt_db_attribute *attrib,
> -                               unsigned int id, uint16_t offset,
> -                               uint8_t opcode, struct bt_att *att,
> -                               void *user_data)
> -{
> -       uint8_t media_state =3D 0x00;
> -       struct iovec iov;
> -
> -       iov.iov_base =3D &media_state;
> -       iov.iov_len =3D sizeof(media_state);
> -
> -       gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
> -                                                       iov.iov_len);
> -}
> -
> -static void mcs_media_cp_write(struct gatt_db_attribute *attrib,
> -                               unsigned int id, uint16_t offset,
> -                               const uint8_t *value, size_t len,
> -                               uint8_t opcode, struct bt_att *att,
> -                               void *user_data)
> -{
> -       gatt_db_attribute_write_result(attrib, id,
> -                               BT_ATT_ERROR_INSUFFICIENT_RESOURCES);
> -}
> -
> -static void mcs_media_cp_op_supported_read(struct gatt_db_attribute *att=
rib,
> -                               unsigned int id, uint16_t offset,
> -                               uint8_t opcode, struct bt_att *att,
> -                               void *user_data)
> -{
> -       uint32_t cp_op_supported =3D 0x00000000;
> -       struct iovec iov;
> -
> -       iov.iov_base =3D &cp_op_supported;
> -       iov.iov_len =3D sizeof(cp_op_supported);
> -
> -       gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
> -                                                       iov.iov_len);
> -}
> -
> -static void mcs_media_content_control_id_read(struct gatt_db_attribute *=
attrib,
> -                               unsigned int id, uint16_t offset,
> -                               uint8_t opcode, struct bt_att *att,
> -                               void *user_data)
> -{
> -       uint8_t content_control_id =3D 0x00;
> -       struct iovec iov;
> -
> -       iov.iov_base =3D &content_control_id;
> -       iov.iov_len =3D sizeof(content_control_id);
> -
> -       gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
> -                                                       iov.iov_len);
> -}
> -
> -static struct bt_mcs *mcs_new(struct gatt_db *db)
> -{
> -       struct bt_mcs *mcs;
> -       bt_uuid_t uuid;
> -
> -       if (!db)
> -               return NULL;
> -
> -       mcs =3D new0(struct bt_mcs, 1);
> -
> -       /* Populate DB with MCS attributes */
> -       bt_uuid16_create(&uuid, GMCS_UUID);
> -       mcs->service =3D gatt_db_add_service(db, &uuid, true, 31);
> -
> -       bt_uuid16_create(&uuid, MEDIA_PLAYER_NAME_CHRC_UUID);
> -       mcs->mp_name =3D gatt_db_service_add_characteristic(mcs->service,=
 &uuid,
> -                                       BT_ATT_PERM_READ,
> -                                       BT_GATT_CHRC_PROP_READ,
> -                                       mcs_mp_name_read, NULL,
> -                                       mcs);
> -
> -       bt_uuid16_create(&uuid, MEDIA_TRACK_CHNGD_CHRC_UUID);
> -       mcs->track_changed =3D gatt_db_service_add_characteristic(mcs->se=
rvice,
> -                                       &uuid,
> -                                       BT_ATT_PERM_NONE,
> -                                       BT_GATT_CHRC_PROP_NOTIFY,
> -                                       NULL, NULL,
> -                                       mcs);
> -
> -       mcs->track_changed_ccc =3D gatt_db_service_add_ccc(mcs->service,
> -                                       BT_ATT_PERM_READ | BT_ATT_PERM_WR=
ITE);
> -
> -       bt_uuid16_create(&uuid, MEDIA_TRACK_TITLE_CHRC_UUID);
> -       mcs->track_title =3D gatt_db_service_add_characteristic(mcs->serv=
ice,
> -                                       &uuid,
> -                                       BT_ATT_PERM_READ,
> -                                       BT_GATT_CHRC_PROP_READ,
> -                                       mcs_track_title_read, NULL,
> -                                       mcs);
> -
> -       bt_uuid16_create(&uuid, MEDIA_TRACK_DURATION_CHRC_UUID);
> -       mcs->track_duration =3D gatt_db_service_add_characteristic(mcs->s=
ervice,
> -                                       &uuid,
> -                                       BT_ATT_PERM_READ,
> -                                       BT_GATT_CHRC_PROP_READ,
> -                                       mcs_track_duration_read, NULL,
> -                                       mcs);
> -
> -       bt_uuid16_create(&uuid, MEDIA_TRACK_POSTION_CHRC_UUID);
> -       mcs->track_position =3D gatt_db_service_add_characteristic(mcs->s=
ervice,
> -                                       &uuid,
> -                                       BT_ATT_PERM_READ | BT_ATT_PERM_WR=
ITE,
> -                                       BT_GATT_CHRC_PROP_READ |
> -                                       BT_GATT_CHRC_PROP_WRITE |
> -                                       BT_GATT_CHRC_PROP_WRITE_WITHOUT_R=
ESP,
> -                                       mcs_track_position_read,
> -                                       mcs_track_position_write,
> -                                       mcs);
> -
> -       bt_uuid16_create(&uuid, MEDIA_PLAYBACK_SPEED_CHRC_UUID);
> -       mcs->playback_speed =3D gatt_db_service_add_characteristic(mcs->s=
ervice,
> -                                       &uuid,
> -                                       BT_ATT_PERM_READ | BT_ATT_PERM_WR=
ITE,
> -                                       BT_GATT_CHRC_PROP_READ |
> -                                       BT_GATT_CHRC_PROP_WRITE |
> -                                       BT_GATT_CHRC_PROP_WRITE_WITHOUT_R=
ESP,
> -                                       mcs_playback_speed_read,
> -                                       mcs_playback_speed_write,
> -                                       mcs);
> -
> -       bt_uuid16_create(&uuid, MEDIA_SEEKING_SPEED_CHRC_UUID);
> -       mcs->seeking_speed =3D gatt_db_service_add_characteristic(mcs->se=
rvice,
> -                                       &uuid,
> -                                       BT_ATT_PERM_READ,
> -                                       BT_GATT_CHRC_PROP_READ,
> -                                       mcs_seeking_speed_read, NULL,
> -                                       mcs);
> -
> -       bt_uuid16_create(&uuid, MEDIA_PLAYING_ORDER_CHRC_UUID);
> -       mcs->play_order =3D gatt_db_service_add_characteristic(mcs->servi=
ce,
> -                                       &uuid,
> -                                       BT_ATT_PERM_READ | BT_ATT_PERM_WR=
ITE,
> -                                       BT_GATT_CHRC_PROP_READ |
> -                                       BT_GATT_CHRC_PROP_WRITE |
> -                                       BT_GATT_CHRC_PROP_WRITE_WITHOUT_R=
ESP,
> -                                       mcs_playing_order_read,
> -                                       mcs_playing_order_write,
> -                                       mcs);
> -
> -       bt_uuid16_create(&uuid, MEDIA_PLAY_ORDER_SUPPRTD_CHRC_UUID);
> -       mcs->play_order_supported =3D gatt_db_service_add_characteristic(
> -                                       mcs->service,
> -                                       &uuid,
> -                                       BT_ATT_PERM_READ,
> -                                       BT_GATT_CHRC_PROP_READ,
> -                                       mcs_playing_order_supported_read,=
 NULL,
> -                                       mcs);
> -
> -       bt_uuid16_create(&uuid, MEDIA_STATE_CHRC_UUID);
> -       mcs->media_state =3D gatt_db_service_add_characteristic(mcs->serv=
ice,
> -                                       &uuid,
> -                                       BT_ATT_PERM_READ,
> -                                       BT_GATT_CHRC_PROP_READ |
> -                                       BT_GATT_CHRC_PROP_NOTIFY,
> -                                       mcs_media_state_read, NULL,
> -                                       mcs);
> -
> -       mcs->media_state_ccc =3D gatt_db_service_add_ccc(mcs->service,
> -                                       BT_ATT_PERM_READ | BT_ATT_PERM_WR=
ITE);
> -
> -       bt_uuid16_create(&uuid, MEDIA_CP_CHRC_UUID);
> -       mcs->media_cp =3D gatt_db_service_add_characteristic(mcs->service=
, &uuid,
> -                                       BT_ATT_PERM_WRITE,
> -                                       BT_GATT_CHRC_PROP_WRITE |
> -                                       BT_GATT_CHRC_PROP_NOTIFY |
> -                                       BT_GATT_CHRC_PROP_WRITE_WITHOUT_R=
ESP,
> -                                       NULL, mcs_media_cp_write,
> -                                       mcs);
> -
> -       mcs->media_cp_ccc =3D gatt_db_service_add_ccc(mcs->service,
> -                                       BT_ATT_PERM_READ | BT_ATT_PERM_WR=
ITE);
> -
> -       bt_uuid16_create(&uuid, MEDIA_CP_OP_SUPPORTED_CHRC_UUID);
> -       mcs->media_cp_op_supportd =3D gatt_db_service_add_characteristic(
> -                                       mcs->service,
> -                                       &uuid,
> -                                       BT_ATT_PERM_READ,
> -                                       BT_GATT_CHRC_PROP_READ,
> -                                       mcs_media_cp_op_supported_read, N=
ULL,
> -                                       mcs);
> -
> -       bt_uuid16_create(&uuid, MEDIA_CONTENT_CONTROL_ID_CHRC_UUID);
> -       mcs->content_control_id =3D gatt_db_service_add_characteristic(
> -                                       mcs->service,
> -                                       &uuid,
> -                                       BT_ATT_PERM_READ,
> -                                       BT_GATT_CHRC_PROP_READ |
> -                                       BT_GATT_CHRC_PROP_NOTIFY,
> -                                       mcs_media_content_control_id_read=
,
> -                                       NULL,
> -                                       mcs);
> -
> -       mcs->content_control_id_ccc =3D gatt_db_service_add_ccc(mcs->serv=
ice,
> -                                       BT_ATT_PERM_READ | BT_ATT_PERM_WR=
ITE);
> -
> -       gatt_db_service_set_active(mcs->service, false);
> -
> -       return mcs;
> -}
> -
> -static struct bt_mcs *mcp_get_mcs(struct bt_mcp *mcp)
> -{
> -       if (!mcp)
> -               return NULL;
> -
> -       if (mcp->rdb->mcs)
> -               return mcp->rdb->mcs;
> -
> -       mcp->rdb->mcs =3D new0(struct bt_mcs, 1);
> -       mcp->rdb->mcs->mdb =3D mcp->rdb;
> -
> -       return mcp->rdb->mcs;
> -}
> -
> -static unsigned int mcp_send(struct bt_mcp *mcp, uint8_t operation)
> -{
> -       struct bt_mcs *mcs =3D mcp_get_mcs(mcp);
> -       int ret;
> -       uint16_t handle;
> -
> -       DBG(mcp, "mcs %p", mcs);
> -
> -       if (!mcp->client)
> -               return -1;
> -
> -       if (!gatt_db_attribute_get_char_data(mcs->media_cp, NULL, &handle=
,
> -                                       NULL, NULL, NULL))
> -               return -1;
> -
> -       ret =3D bt_gatt_client_write_without_response(mcp->client, handle=
, false,
> -                                       &operation, sizeof(uint8_t));
> -       if (!ret)
> -               return -1;
> -
> -       return 0;
> -}
> -
> -unsigned int bt_mcp_play(struct bt_mcp *mcp)
> -{
> -       if (!mcp)
> -               return 0;
> -
> -       if (!(mcp->session.cp_op_supported & BT_MCS_CMD_PLAY_SUPPORTED))
> -               return -ENOTSUP;
> -
> -       DBG(mcp, "mcp %p", mcp);
> -
> -       return mcp_send(mcp, BT_MCS_CMD_PLAY);
> -}
> -
> -unsigned int bt_mcp_pause(struct bt_mcp *mcp)
> -{
> -       if (!mcp)
> -               return 0;
> -
> -       if (!(mcp->session.cp_op_supported & BT_MCS_CMD_PAUSE_SUPPORTED))
> -               return -ENOTSUP;
> -
> -       DBG(mcp, "mcp %p", mcp);
> -
> -       return mcp_send(mcp, BT_MCS_CMD_PAUSE);
> -}
> -
> -unsigned int bt_mcp_stop(struct bt_mcp *mcp)
> -{
> -       if (!mcp)
> -               return 0;
> -
> -       if (!(mcp->session.cp_op_supported & BT_MCS_CMD_STOP_SUPPORTED))
> -               return -ENOTSUP;
> -
> -       DBG(mcp, "mcp %p", mcp);
> -
> -       return mcp_send(mcp, BT_MCS_CMD_STOP);
> -}
> -
> -unsigned int bt_mcp_next_track(struct bt_mcp *mcp)
> -{
> -       if (!mcp)
> -               return 0;
> -
> -       if (!(mcp->session.cp_op_supported & BT_MCS_CMD_NEXT_TRACK_SUPPOR=
TED))
> -               return -ENOTSUP;
> -
> -       DBG(mcp, "mcp %p", mcp);
> -
> -       return mcp_send(mcp, BT_MCS_CMD_NEXT_TRACK);
> -}
> -
> -unsigned int bt_mcp_previous_track(struct bt_mcp *mcp)
> -{
> -       if (!mcp)
> -               return 0;
> -
> -       if (!(mcp->session.cp_op_supported & BT_MCS_CMD_PREV_TRACK_SUPPOR=
TED))
> -               return -ENOTSUP;
> -
> -       DBG(mcp, "mcp %p", mcp);
> -
> -       return mcp_send(mcp, BT_MCS_CMD_PREV_TRACK);
> -}
> -
> -static void mcp_mp_set_player_name(struct bt_mcp *mcp, const uint8_t *va=
lue,
> -                                       uint16_t length)
> -{
> -       struct event_callback *cb;
> -
> -       if (!mcp)
> -               return;
> -
> -       cb =3D mcp->cb;
> -
> -       if (cb && cb->cbs && cb->cbs->player_name)
> -               cb->cbs->player_name(mcp, value, length);
> -}
> -
> -static void mcp_mp_set_track_title(struct bt_mcp *mcp, const uint8_t *va=
lue,
> -                                       uint16_t length)
> -{
> -       struct event_callback *cb;
> -
> -       if (!mcp)
> -               return;
> -
> -       cb =3D mcp->cb;
> -
> -       if (cb && cb->cbs && cb->cbs->track_title)
> -               cb->cbs->track_title(mcp, value, length);
> -}
> -
> -static void mcp_mp_set_title_duration(struct bt_mcp *mcp, int32_t durati=
on)
> -{
> -       struct event_callback *cb;
> -
> -       if (!mcp)
> -               return;
> -
> -       cb =3D mcp->cb;
> -
> -       DBG(mcp, "Track Duration 0x%08x", duration);
> -
> -       if (cb && cb->cbs && cb->cbs->track_duration)
> -               cb->cbs->track_duration(mcp, duration);
> -}
> -
> -static void mcp_mp_set_title_position(struct bt_mcp *mcp, int32_t positi=
on)
> -{
> -       struct event_callback *cb;
> -
> -       if (!mcp)
> -               return;
> -
> -       cb =3D mcp->cb;
> -
> -       DBG(mcp, "Track Position 0x%08x", position);
> -
> -       if (cb && cb->cbs && cb->cbs->track_position)
> -               cb->cbs->track_position(mcp, position);
> -}
> -
> -static void mcp_mp_set_media_state(struct bt_mcp *mcp, uint8_t state)
> -{
> -       struct event_callback *cb;
> -
> -       if (!mcp)
> -               return;
> -
> -       cb =3D mcp->cb;
> -
> -       DBG(mcp, "Media State 0x%02x", state);
> -
> -       if (cb && cb->cbs && cb->cbs->media_state)
> -               cb->cbs->media_state(mcp, state);
> -}
> -
> -static void read_media_player_name(bool success, uint8_t att_ecode,
> -                               const uint8_t *value, uint16_t length,
> -                               void *user_data)
> -{
> -       struct bt_mcp *mcp =3D user_data;
> -
> -       if (!success) {
> -               DBG(mcp, "Unable to read media player name: error 0x%02x"=
,
> -                               att_ecode);
> -               return;
> -       }
> -
> -       if (!length)
> -               return;
> -
> -       mcp_mp_set_player_name(mcp, value, length);
> -}
> -
> -static void read_track_title(bool success, uint8_t att_ecode,
> -                               const uint8_t *value, uint16_t length,
> -                               void *user_data)
> -{
> -       struct bt_mcp *mcp =3D user_data;
> -
> -       if (!success) {
> -               DBG(mcp, "Unable to read track title: error 0x%02x",
> -                                       att_ecode);
> -               return;
> -       }
> -
> -       if (!length)
> -               return;
> -
> -       mcp_mp_set_track_title(mcp, value, length);
> -}
> -
> -static void read_track_duration(bool success, uint8_t att_ecode,
> -                               const uint8_t *value, uint16_t length,
> -                               void *user_data)
> -{
> -       struct bt_mcp *mcp =3D user_data;
> -       int32_t duration;
> -
> -       if (!success) {
> -               DBG(mcp, "Unable to read track duration: error 0x%02x",
> -                                       att_ecode);
> -               return;
> -       }
> -
> -       if (length !=3D sizeof(duration))
> -               DBG(mcp, "Wrong length received Length : %u", length);
> -
> -       memcpy(&duration, value, length);
> -       mcp_mp_set_title_duration(mcp, duration);
> -}
> -
> -static void read_track_position(bool success, uint8_t att_ecode,
> -                               const uint8_t *value, uint16_t length,
> -                               void *user_data)
> -{
> -       struct bt_mcp *mcp =3D user_data;
> -       int32_t position;
> -
> -       if (!success) {
> -               DBG(mcp, "Unable to read track position: error 0x%02x",
> -                                       att_ecode);
> -               return;
> -       }
> -
> -       if (length !=3D sizeof(position))
> -               DBG(mcp, "Wrong length received Length : %u", length);
> -
> -       memcpy(&position, value, length);
> -       mcp_mp_set_title_position(mcp, position);
> -}
> -
> -static void read_media_state(bool success, uint8_t att_ecode,
> -                               const uint8_t *value, uint16_t length,
> -                               void *user_data)
> -{
> -       struct bt_mcp *mcp =3D user_data;
> -
> -       if (!success) {
> -               DBG(mcp, "Unable to read media state: error 0x%02x",
> -                                       att_ecode);
> -               return;
> -       }
> -
> -       if (length !=3D sizeof(uint8_t))
> -               DBG(mcp, "Wrong length received Length : %u", length);
> -
> -       mcp_mp_set_media_state(mcp, *value);
> -}
> -
> -static void read_media_cp_op_supported(bool success, uint8_t att_ecode,
> -                               const uint8_t *value, uint16_t length,
> -                               void *user_data)
> -{
> -       struct bt_mcp *mcp =3D user_data;
> -
> -       if (!success) {
> -               DBG(mcp, "Unable to read media CP OP supported: error 0x%=
02x",
> -                                       att_ecode);
> -               return;
> -       }
> -
> -       if (length !=3D sizeof(uint32_t))
> -               DBG(mcp, "Wrong length received Length : %u", length);
> -
> -       memcpy(&mcp->session.cp_op_supported, value, sizeof(uint32_t));
> -       DBG(mcp, "Media Control Point Opcodes Supported 0x%08x",
> -                       mcp->session.cp_op_supported);
> -}
> -
> -static void read_content_control_id(bool success, uint8_t att_ecode,
> -                               const uint8_t *value, uint16_t length,
> -                               void *user_data)
> -{
> -       struct bt_mcp *mcp =3D user_data;
> -
> -       if (!success) {
> -               DBG(mcp, "Unable to read content control id: error 0x%02x=
",
> -                                       att_ecode);
> -               return;
> -       }
> -
> -       if (length !=3D sizeof(uint8_t))
> -               DBG(mcp, "Wrong length received Length : %u", length);
> -
> -       DBG(mcp, "Content Control ID 0x%02x", *value);
> -}
> -
> -static void mcp_pending_destroy(void *data)
> -{
> -       struct bt_mcp_pending *pending =3D data;
> -       struct bt_mcp *mcp =3D pending->mcp;
> -
> -       queue_remove_if(mcp->pending, NULL, pending);
> -}
> -
> -static void mcp_pending_complete(bool success, uint8_t att_ecode,
> -                               const uint8_t *value, uint16_t length,
> -                               void *user_data)
> -{
> -       struct bt_mcp_pending *pending =3D user_data;
> -
> -       if (pending->func)
> -               pending->func(success, att_ecode, value, length,
> -                                               pending->user_data);
> -}
> -
> -static void mcp_read_value(struct bt_mcp *mcp, uint16_t value_handle,
> -                               bt_gatt_client_read_callback_t func,
> -                               void *user_data)
> +static struct bt_mcp_pending *mcp_pending_new(struct bt_mcp_service *ser=
vice)
>  {
>         struct bt_mcp_pending *pending;
>
> -       pending =3D new0(struct bt_mcp_pending, 1);
> -       pending->mcp =3D mcp;
> -       pending->func =3D func;
> -       pending->user_data =3D user_data;
> +       if (queue_length(service->pending) > MAX_PENDING)
> +               return NULL;
>
> -       pending->id =3D bt_gatt_client_read_value(mcp->client, value_hand=
le,
> -                                               mcp_pending_complete, pen=
ding,
> -                                               mcp_pending_destroy);
> -       if (!pending->id) {
> -               DBG(mcp, "Unable to send Read request");
> +       while (!service->pending_id || queue_find(service->pending,
> +                       match_pending, UINT_TO_PTR(service->pending_id)))
> +               service->pending_id++;
> +
> +       pending =3D new0(struct bt_mcp_pending, 1);
> +       pending->service =3D service;
> +       pending->id =3D service->pending_id++;
> +       return pending;
> +}
> +
> +static unsigned int mcp_send(struct bt_mcp_service *service, uint8_t *bu=
f,
> +                                                               uint16_t =
length)
> +{
> +       struct bt_mcp *mcp =3D service->mcp;
> +       uint16_t handle;
> +       struct bt_mcp_pending *pending;
> +       int ret;
> +       uint8_t op =3D buf[0];
> +
> +       if (!gatt_db_attribute_get_char_data(service->rdb.media_cp, NULL,
> +                                               &handle, NULL, NULL, NULL=
))
> +               return 0;
> +
> +       pending =3D mcp_pending_new(service);
> +       if (!pending)
> +               return 0;
> +
> +       ret =3D bt_gatt_client_write_without_response(mcp->client,
> +                                               handle, false, buf, lengt=
h);
> +       if (!ret) {
>                 free(pending);
> +               return 0;
> +       }
> +
> +       pending->op =3D op;
> +       queue_push_tail(service->pending, pending);
> +
> +       DBG_SVC(service, "%u", pending->id);
> +       return pending->id;
> +}
> +
> +static void mcp_pending_write_cb(bool success, uint8_t att_ecode,
> +                                                               void *use=
r_data)
> +{
> +       struct bt_mcp_pending *pending =3D user_data;
> +       uint8_t props;
> +
> +       if (!success) {
> +               pending->write.result =3D BT_MCS_RESULT_COMMAND_CANNOT_CO=
MPLETE;
>                 return;
>         }
>
> -       queue_push_tail(mcp->pending, pending);
> +       pending->write.result =3D BT_MCS_RESULT_SUCCESS;
> +
> +       if (!gatt_db_attribute_get_char_data(pending->write.attrib, NULL,
> +                                               NULL, &props, NULL, NULL)=
)
> +               return;
> +       if (props & BT_GATT_CHRC_PROP_NOTIFY)
> +               return;
> +
> +       /* If the attribute doesn't have notify, reread to get the new va=
lue */
> +       mcp_service_reread(pending->service, pending->write.attrib);
>  }
>
> -static void mcp_mp_name_register(uint16_t att_ecode, void *user_data)
> +static void mcp_pending_write_done(void *user_data)
>  {
> +       struct bt_mcp_pending *pending =3D user_data;
> +       struct bt_mcp_service *service =3D pending->service;
> +       struct bt_mcp *mcp =3D service->mcp;
> +
> +       DBG_SVC(service, "write %u", pending->id);
> +
> +       queue_remove(service->pending, pending);
> +
> +       if (mcp->cb->complete)
> +               mcp->cb->complete(mcp->user_data, pending->id,
> +                                                       pending->write.re=
sult);
> +       free(pending);
> +}
> +
> +static unsigned int mcp_write_chrc(struct bt_mcp_service *service,
> +               struct gatt_db_attribute *attrib, void *data, uint16_t le=
ngth)
> +{
> +       struct bt_mcp *mcp;
> +       struct bt_mcp_pending *pending;
> +       uint16_t handle;
> +
> +       if (!service)
> +               return 0;
> +
> +       mcp =3D service->mcp;
> +
> +       if (!gatt_db_attribute_get_char_data(attrib, NULL, &handle, NULL,=
 NULL,
> +                                                                       N=
ULL))
> +               return 0;
> +
> +       pending =3D mcp_pending_new(service);
> +       if (!pending)
> +               return 0;
> +
> +       pending->write.attrib =3D attrib;
> +       pending->write.client_id =3D bt_gatt_client_write_value(mcp->clie=
nt,
> +                               handle, data, length, mcp_pending_write_c=
b,
> +                               pending, mcp_pending_write_done);
> +       if (!pending->write.client_id) {
> +               free(pending);
> +               return 0;
> +       }
> +
> +       queue_push_tail(service->pending, pending);
> +       return pending->id;
> +}
> +
> +static bool match_pending_write(const void *data, const void *user_data)
> +{
> +       const struct bt_mcp_pending *pending =3D data;
> +
> +       return !pending->op;
> +}
> +
> +static void mcp_cancel_pending_writes(struct bt_mcp_service *service)
> +{
> +       struct bt_mcp_pending *pending;
> +       struct bt_gatt_client *client =3D service->mcp->client;
> +
> +       do {
> +               pending =3D queue_remove_if(service->pending, match_pendi=
ng_write,
> +                                                                       N=
ULL);
> +               if (pending) {
> +                       if (!bt_gatt_client_cancel(client,
> +                                               pending->write.client_id)=
)
> +                               free(pending);
> +               }
> +       } while (pending);
> +}
> +
> +static unsigned int mcp_command(struct bt_mcp *mcp, uint8_t ccid, uint8_=
t op,
> +                                                               int32_t a=
rg)
> +{
> +       const struct mcs_command *cmd =3D mcs_get_command(op);
> +       struct bt_mcp_service *service =3D mcp_service(mcp, ccid);
> +       uint8_t buf[5];
> +       struct iovec iov =3D { .iov_base =3D buf, .iov_len =3D 0 };
> +
> +       if (!service || !cmd)
> +               return 0;
> +
> +       if (!(service->rdb.media_cp_op_supported_value & cmd->support))
> +               return 0;
> +
> +       DBG_SVC(service, "%s %d", cmd->name, arg);
> +
> +       util_iov_push_u8(&iov, op);
> +       if (cmd->int32_arg)
> +               util_iov_push_le32(&iov, arg);
> +
> +       return mcp_send(service, iov.iov_base, iov.iov_len);
> +}
> +
> +unsigned int bt_mcp_play(struct bt_mcp *mcp, uint8_t ccid)
> +{
> +       return mcp_command(mcp, ccid, BT_MCS_CMD_PLAY, 0);
> +}
> +
> +unsigned int bt_mcp_pause(struct bt_mcp *mcp, uint8_t ccid)
> +{
> +       return mcp_command(mcp, ccid, BT_MCS_CMD_PAUSE, 0);
> +}
> +
> +unsigned int bt_mcp_fast_rewind(struct bt_mcp *mcp, uint8_t ccid)
> +{
> +       return mcp_command(mcp, ccid, BT_MCS_CMD_FAST_REWIND, 0);
> +}
> +
> +unsigned int bt_mcp_fast_forward(struct bt_mcp *mcp, uint8_t ccid)
> +{
> +       return mcp_command(mcp, ccid, BT_MCS_CMD_FAST_FORWARD, 0);
> +}
> +
> +unsigned int bt_mcp_stop(struct bt_mcp *mcp, uint8_t ccid)
> +{
> +       return mcp_command(mcp, ccid, BT_MCS_CMD_STOP, 0);
> +}
> +
> +unsigned int bt_mcp_move_relative(struct bt_mcp *mcp, uint8_t ccid,
> +                                                               int32_t o=
ffset)
> +{
> +       return mcp_command(mcp, ccid, BT_MCS_CMD_MOVE_RELATIVE, offset);
> +}
> +
> +unsigned int bt_mcp_previous_segment(struct bt_mcp *mcp, uint8_t ccid)
> +{
> +       return mcp_command(mcp, ccid, BT_MCS_CMD_PREV_SEGMENT, 0);
> +}
> +
> +unsigned int bt_mcp_next_segment(struct bt_mcp *mcp, uint8_t ccid)
> +{
> +       return mcp_command(mcp, ccid, BT_MCS_CMD_NEXT_SEGMENT, 0);
> +}
> +
> +unsigned int bt_mcp_first_segment(struct bt_mcp *mcp, uint8_t ccid)
> +{
> +       return mcp_command(mcp, ccid, BT_MCS_CMD_FIRST_SEGMENT, 0);
> +}
> +
> +unsigned int bt_mcp_last_segment(struct bt_mcp *mcp, uint8_t ccid)
> +{
> +       return mcp_command(mcp, ccid, BT_MCS_CMD_LAST_SEGMENT, 0);
> +}
> +
> +unsigned int bt_mcp_goto_segment(struct bt_mcp *mcp, uint8_t ccid, int32=
_t n)
> +{
> +       return mcp_command(mcp, ccid, BT_MCS_CMD_GOTO_SEGMENT, n);
> +}
> +
> +unsigned int bt_mcp_previous_track(struct bt_mcp *mcp, uint8_t ccid)
> +{
> +       return mcp_command(mcp, ccid, BT_MCS_CMD_PREV_TRACK, 0);
> +}
> +
> +unsigned int bt_mcp_next_track(struct bt_mcp *mcp, uint8_t ccid)
> +{
> +       return mcp_command(mcp, ccid, BT_MCS_CMD_NEXT_TRACK, 0);
> +}
> +
> +unsigned int bt_mcp_first_track(struct bt_mcp *mcp, uint8_t ccid)
> +{
> +       return mcp_command(mcp, ccid, BT_MCS_CMD_FIRST_TRACK, 0);
> +}
> +
> +unsigned int bt_mcp_last_track(struct bt_mcp *mcp, uint8_t ccid)
> +{
> +       return mcp_command(mcp, ccid, BT_MCS_CMD_LAST_TRACK, 0);
> +}
> +
> +unsigned int bt_mcp_goto_track(struct bt_mcp *mcp, uint8_t ccid, int32_t=
 n)
> +{
> +       return mcp_command(mcp, ccid, BT_MCS_CMD_GOTO_TRACK, n);
> +}
> +
> +unsigned int bt_mcp_previous_group(struct bt_mcp *mcp, uint8_t ccid)
> +{
> +       return mcp_command(mcp, ccid, BT_MCS_CMD_PREV_GROUP, 0);
> +}
> +
> +unsigned int bt_mcp_next_group(struct bt_mcp *mcp, uint8_t ccid)
> +{
> +       return mcp_command(mcp, ccid, BT_MCS_CMD_NEXT_GROUP, 0);
> +}
> +
> +unsigned int bt_mcp_first_group(struct bt_mcp *mcp, uint8_t ccid)
> +{
> +       return mcp_command(mcp, ccid, BT_MCS_CMD_FIRST_GROUP, 0);
> +}
> +
> +unsigned int bt_mcp_last_group(struct bt_mcp *mcp, uint8_t ccid)
> +{
> +       return mcp_command(mcp, ccid, BT_MCS_CMD_LAST_GROUP, 0);
> +}
> +
> +unsigned int bt_mcp_goto_group(struct bt_mcp *mcp, uint8_t ccid, int32_t=
 n)
> +{
> +       return mcp_command(mcp, ccid, BT_MCS_CMD_GOTO_GROUP, n);
> +}
> +
> +unsigned int bt_mcp_set_track_position(struct bt_mcp *mcp, uint8_t ccid,
> +                                                       int32_t position)
> +{
> +       struct bt_mcp_service *service =3D mcp_service(mcp, ccid);
> +
> +       position =3D cpu_to_le32(position);
> +       return mcp_write_chrc(service, service->rdb.track_position,
> +                                               &position, sizeof(positio=
n));
> +}
> +
> +unsigned int bt_mcp_set_playback_speed(struct bt_mcp *mcp, uint8_t ccid,
> +                                                               int8_t va=
lue)
> +{
> +       struct bt_mcp_service *service =3D mcp_service(mcp, ccid);
> +
> +       return mcp_write_chrc(service, service->rdb.playback_speed,
> +                                                       &value, sizeof(va=
lue));
> +}
> +
> +unsigned int bt_mcp_set_playing_order(struct bt_mcp *mcp, uint8_t ccid,
> +                                                               uint8_t v=
alue)
> +{
> +       struct bt_mcp_service *service =3D mcp_service(mcp, ccid);
> +       uint16_t support =3D 0;
> +       unsigned int i;
> +
> +       if (!service)
> +               return 0;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(mcs_playing_orders); ++i) {
> +               if (mcs_playing_orders[i].order =3D=3D value) {
> +                       support =3D mcs_playing_orders[i].support;
> +                       break;
> +               }
> +       }
> +       if (!(service->rdb.playing_order_supported_value & support))
> +               return 0;
> +
> +       return mcp_write_chrc(service, service->rdb.playing_order,
> +                                                       &value, sizeof(va=
lue));
> +}
> +
> +uint16_t bt_mcp_get_supported_playing_order(struct bt_mcp *mcp, uint8_t =
ccid)
> +{
> +       struct bt_mcp_service *service =3D mcp_service(mcp, ccid);
> +
> +       if (!service)
> +               return 0;
> +       return service->rdb.playing_order_supported_value;
> +}
> +
> +uint32_t bt_mcp_get_supported_commands(struct bt_mcp *mcp, uint8_t ccid)
> +{
> +       struct bt_mcp_service *service =3D mcp_service(mcp, ccid);
> +
> +       if (!service)
> +               return 0;
> +       return service->rdb.media_cp_op_supported_value;
> +}
> +
> +#define LISTENER_CB(service, method, ...) \
> +       do { \
> +               const struct queue_entry *entry =3D \
> +                               queue_get_entries((service)->listeners); =
\
> +               for (; entry; entry =3D entry->next) { \
> +                       struct bt_mcp_listener *listener =3D entry->data;=
 \
> +                       if (listener->cb->method) \
> +                               listener->cb->method(listener->user_data,=
 \
> +                                                       ## __VA_ARGS__); =
\
> +               } \
> +       } while (0)
> +
> +static void update_media_player_name(bool success, uint8_t att_ecode,
> +                               const uint8_t *value, uint16_t length,
> +                               void *user_data)
> +{
> +       struct bt_mcp_service *service =3D user_data;
> +
> +       DBG_SVC(service, "Media Player Name");
> +
> +       LISTENER_CB(service, media_player_name, value, length);
> +}
> +
> +static void update_track_changed(bool success, uint8_t att_ecode,
> +                               const uint8_t *value, uint16_t length,
> +                               void *user_data)
> +{
> +       struct bt_mcp_service *service =3D user_data;
> +
> +       if (!success) {
> +               DBG_SVC(service, "Unable to read Track Changed: "
> +                                               "error 0x%02x", att_ecode=
);
> +               return;
> +       }
> +
> +       DBG_SVC(service, "Track Changed");
> +
> +       LISTENER_CB(service, track_changed);
> +}
> +
> +static void update_track_title(bool success, uint8_t att_ecode,
> +                               const uint8_t *value, uint16_t length,
> +                               void *user_data)
> +{
> +       struct bt_mcp_service *service =3D user_data;
> +
> +       if (!success) {
> +               DBG_SVC(service, "Unable to read Track Title: error 0x%02=
x",
> +                                                               att_ecode=
);
> +               return;
> +       }
> +
> +       DBG_SVC(service, "Track Title");
> +
> +       LISTENER_CB(service, track_title, value, length);
> +}
> +
> +static void update_track_duration(bool success, uint8_t att_ecode,
> +                               const uint8_t *value, uint16_t length,
> +                               void *user_data)
> +{
> +       struct bt_mcp_service *service =3D user_data;
> +       struct iovec iov =3D { .iov_base =3D (void *)value, .iov_len =3D =
length };
> +       uint32_t v;
> +
> +       if (!success || !util_iov_pull_le32(&iov, &v)) {
> +               DBG_SVC(service, "Unable to read Track Duration: "
> +                                               "error 0x%02x", att_ecode=
);
> +               return;
> +       }
> +
> +       DBG_SVC(service, "Track Duration: %d", (int32_t)v);
> +
> +       LISTENER_CB(service, track_duration, (int32_t)v);
> +}
> +
> +static void update_track_position(bool success, uint8_t att_ecode,
> +                               const uint8_t *value, uint16_t length,
> +                               void *user_data)
> +{
> +       struct bt_mcp_service *service =3D user_data;
> +       struct iovec iov =3D { .iov_base =3D (void *)value, .iov_len =3D =
length };
> +       uint32_t v;
> +
> +       if (!success || !util_iov_pull_le32(&iov, &v)) {
> +               DBG_SVC(service, "Unable to read Track Position: "
> +                                               "error 0x%02x", att_ecode=
);
> +               return;
> +       }
> +
> +       DBG_SVC(service, "Track Position: %d", (int32_t)v);
> +
> +       LISTENER_CB(service, track_position, (int32_t)v);
> +}
> +
> +static void update_playback_speed(bool success, uint8_t att_ecode,
> +                               const uint8_t *value, uint16_t length,
> +                               void *user_data)
> +{
> +       struct bt_mcp_service *service =3D user_data;
> +       struct iovec iov =3D { .iov_base =3D (void *)value, .iov_len =3D =
length };
> +       uint8_t v;
> +
> +       if (!success || !util_iov_pull_u8(&iov, &v)) {
> +               DBG_SVC(service, "Unable to read Playback Speed: "
> +                                               "error 0x%02x", att_ecode=
);
> +               return;
> +       }
> +
> +       DBG_SVC(service, "Playback Speed: %d", (int8_t)v);
> +
> +       LISTENER_CB(service, playback_speed, (int8_t)v);
> +}
> +
> +static void update_seeking_speed(bool success, uint8_t att_ecode,
> +                               const uint8_t *value, uint16_t length,
> +                               void *user_data)
> +{
> +       struct bt_mcp_service *service =3D user_data;
> +       struct iovec iov =3D { .iov_base =3D (void *)value, .iov_len =3D =
length };
> +       uint8_t v;
> +
> +       if (!success || !util_iov_pull_u8(&iov, &v)) {
> +               DBG_SVC(service, "Unable to read Seeking Speed: "
> +                                               "error 0x%02x", att_ecode=
);
> +               return;
> +       }
> +
> +       DBG_SVC(service, "Seeking Speed: %d", (int8_t)v);
> +
> +       LISTENER_CB(service, seeking_speed, (int8_t)v);
> +}
> +
> +static void update_playing_order(bool success, uint8_t att_ecode,
> +                               const uint8_t *value, uint16_t length,
> +                               void *user_data)
> +{
> +       struct bt_mcp_service *service =3D user_data;
> +       struct iovec iov =3D { .iov_base =3D (void *)value, .iov_len =3D =
length };
> +       uint8_t v;
> +
> +       if (!success || !util_iov_pull_u8(&iov, &v)) {
> +               DBG_SVC(service, "Unable to read Playing Order: "
> +                                               "error 0x%02x", att_ecode=
);
> +               return;
> +       }
> +
> +       DBG_SVC(service, "Playing Order: %u", v);
> +
> +       LISTENER_CB(service, playing_order, v);
> +}
> +
> +static void update_playing_order_supported(bool success, uint8_t att_eco=
de,
> +                               const uint8_t *value, uint16_t length,
> +                               void *user_data)
> +{
> +       struct bt_mcp_service *service =3D user_data;
> +       struct iovec iov =3D { .iov_base =3D (void *)value, .iov_len =3D =
length };
> +       uint16_t v;
> +
> +       if (!success || !util_iov_pull_le16(&iov, &v)) {
> +               DBG_SVC(service, "Unable to read "
> +                       "Playing Order Supported: error 0x%02x", att_ecod=
e);
> +               return;
> +       }
> +
> +       DBG_SVC(service, "Playing Order Supported: %u", v);
> +
> +       service->rdb.playing_order_supported_value =3D v;
> +}
> +
> +static void update_media_state(bool success, uint8_t att_ecode,
> +                               const uint8_t *value, uint16_t length,
> +                               void *user_data)
> +{
> +       struct bt_mcp_service *service =3D user_data;
> +       struct iovec iov =3D { .iov_base =3D (void *)value, .iov_len =3D =
length };
> +       uint8_t v;
> +
> +       if (!success || !util_iov_pull_u8(&iov, &v)) {
> +               DBG_SVC(service, "Unable to read Media State: error 0x%02=
x",
> +                                                               att_ecode=
);
> +               return;
> +       }
> +
> +       DBG_SVC(service, "Media State: %u", v);
> +
> +       LISTENER_CB(service, media_state, v);
> +}
> +
> +static bool match_pending_op(const void *data, const void *user_data)
> +{
> +       const struct bt_mcp_pending *pending =3D data;
> +
> +       return pending->op && pending->op =3D=3D PTR_TO_UINT(user_data);
> +}
> +
> +static void update_media_cp(bool success, uint8_t att_ecode,
> +                               const uint8_t *value, uint16_t length,
> +                               void *user_data)
> +{
> +       struct bt_mcp_service *service =3D user_data;
> +       struct bt_mcp *mcp =3D service->mcp;
> +       struct iovec iov =3D { .iov_base =3D (void *)value, .iov_len =3D =
length };
> +       struct bt_mcp_pending *pending;
> +       uint8_t op, result;
> +
> +       if (!success || !util_iov_pull_u8(&iov, &op) ||
> +                                       !util_iov_pull_u8(&iov, &result))=
 {
> +               DBG_SVC(service, "Unable to read Media CP: error 0x%02x",
> +                                                               att_ecode=
);
> +               return;
> +       }
> +
> +       DBG_SVC(service, "Media CP %u result %u", op, result);
> +
> +       pending =3D queue_remove_if(service->pending, match_pending_op,
> +                                                       UINT_TO_PTR(op));
> +       if (!pending)
> +               return;
> +
> +       if (mcp->cb->complete)
> +               mcp->cb->complete(mcp->user_data, pending->id, result);
> +
> +       free(pending);
> +}
> +
> +static void update_media_cp_op_supported(bool success, uint8_t att_ecode=
,
> +                               const uint8_t *value, uint16_t length,
> +                               void *user_data)
> +{
> +       struct bt_mcp_service *service =3D user_data;
> +       struct iovec iov =3D { .iov_base =3D (void *)value, .iov_len =3D =
length };
> +       uint32_t v;
> +
> +       if (!success || !util_iov_pull_le32(&iov, &v)) {
> +               DBG_SVC(service, "Unable to read "
> +                       "Media CP Op Supported: error 0x%02x", att_ecode)=
;
> +               return;
> +       }
> +
> +       DBG_SVC(service, "Media CP Op Supported: %d", v);
> +
> +       service->rdb.media_cp_op_supported_value =3D v;
> +}
> +
> +static void update_add_service(void *data, void *user_data)
> +{
> +       struct bt_mcp_service *service =3D data;
>         struct bt_mcp *mcp =3D user_data;
>
> -       if (att_ecode)
> -               DBG(mcp, "Media Player Name notification failed: 0x%04x",
> -                                       att_ecode);
> +       if (service->rdb.ccid_value < 0)
> +               return;
> +
> +       if (service->ready)
> +               return;
> +
> +       service->ready =3D true;
> +       if (mcp->cb->ccid)
> +               mcp->cb->ccid(mcp->user_data, service->rdb.ccid_value,
> +                                                       service->rdb.gmcs=
);
>  }
>
> -static void mcp_mp_name_notify(uint16_t value_handle, const uint8_t *val=
ue,
> +static void update_ccid(bool success, uint8_t att_ecode,
> +                               const uint8_t *value, uint16_t length,
> +                               void *user_data)
> +{
> +       struct bt_mcp_service *service =3D user_data;
> +       struct iovec iov =3D { .iov_base =3D (void *)value, .iov_len =3D =
length };
> +       uint8_t v;
> +
> +       if (!success || !util_iov_pull_u8(&iov, &v)) {
> +               DBG_SVC(service, "Unable to read Media State: error 0x%02=
x",
> +                                                               att_ecode=
);
> +               return;
> +       }
> +
> +       DBG_SVC(service, "CCID: %u", v);
> +
> +       service->rdb.ccid_value =3D v;
> +
> +       update_add_service(service, service->mcp);
> +}
> +
> +static void mcp_service_reread(struct bt_mcp_service *service,
> +                                       struct gatt_db_attribute *attrib)
> +{
> +       const struct {
> +               struct gatt_db_attribute *attr;
> +               bt_gatt_client_read_callback_t cb;
> +       } attrs[] =3D {
> +               { service->rdb.track_title, update_track_title },
> +               { service->rdb.track_duration, update_track_duration },
> +               { service->rdb.track_position, update_track_position },
> +               { service->rdb.playback_speed, update_playback_speed },
> +               { service->rdb.seeking_speed, update_seeking_speed },
> +               { service->rdb.playing_order, update_playing_order },
> +               { service->rdb.playing_order_supported,
> +                 update_playing_order_supported },
> +               { service->rdb.media_state, update_media_state },
> +               { service->rdb.media_cp_op_supported,
> +                 update_media_cp_op_supported },
> +       };
> +       struct bt_gatt_client *client =3D service->mcp->client;
> +       uint16_t value_handle;
> +       unsigned int i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(attrs); ++i) {
> +               if (!attrs[i].attr)
> +                       continue;
> +               if (attrib && attrs[i].attr !=3D attrib)
> +                       continue;
> +
> +               if (!gatt_db_attribute_get_char_data(attrs[i].attr, NULL,
> +                                       &value_handle, NULL, NULL, NULL))
> +                       return;
> +
> +               DBG_SVC(service, "re-read handle 0x%04x", value_handle);
> +
> +               bt_gatt_client_read_value(client, value_handle,
> +                                               attrs[i].cb, service, NUL=
L);
> +       }
> +}
> +
> +static void notify_media_player_name(struct bt_mcp_service *service)
> +{
> +       /* On player name change, re-read all attributes */
> +       mcp_service_reread(service, NULL);
> +}
> +
> +static void mcp_idle(void *data)
> +{
> +       struct bt_mcp *mcp =3D data;
> +
> +       DBG_MCP(mcp, "");
> +
> +       mcp->idle_id =3D 0;
> +
> +       if (!mcp->ready) {
> +               mcp->ready =3D true;
> +               if (mcp->cb->ready)
> +                       mcp->cb->ready(mcp->user_data);
> +       }
> +}
> +
> +struct chrc_notify_data {
> +       const char *name;
> +       struct bt_mcp_service *service;
> +       bt_gatt_client_read_callback_t cb;
> +       void (*notify_cb)(struct bt_mcp_service *service);
> +};
> +
> +static void chrc_register(uint16_t att_ecode, void *user_data)
> +{
> +       struct chrc_notify_data *data =3D user_data;
> +
> +       if (att_ecode)
> +               DBG_SVC(data->service, "%s notification failed: 0x%04x",
> +                                                       data->name, att_e=
code);
> +}
> +
> +static void chrc_notify(uint16_t value_handle, const uint8_t *value,
>                                         uint16_t length, void *user_data)
>  {
> -       struct bt_mcp *mcp =3D user_data;
> +       struct chrc_notify_data *data =3D user_data;
> +       struct bt_mcp_service *service =3D data->service;
> +       struct bt_gatt_client *client =3D service->mcp->client;
> +       uint16_t mtu =3D bt_gatt_client_get_mtu(client);
>
> -       if (!length)
> +       DBG_SVC(service, "Notify %s", data->name);
> +
> +       if (length =3D=3D mtu - 3) {
> +               /* Probably truncated value */
> +               DBG_SVC(service, "Read %s", data->name);
> +
> +               bt_gatt_client_read_value(client, value_handle,
> +                                               data->cb, service, NULL);
>                 return;
> +       }
>
> -       mcp_mp_set_player_name(mcp, value, length);
> -}
> +       data->cb(true, 0xff, value, length, data->service);
>
> -static void mcp_track_changed_register(uint16_t att_ecode, void *user_da=
ta)
> -{
> -       struct bt_mcp *mcp =3D user_data;
> -
> -       if (att_ecode)
> -               DBG(mcp, "Media Track Changed notification failed: 0x%04x=
",
> -                                       att_ecode);
> -}
> -
> -static void mcp_track_changed_notify(uint16_t value_handle,
> -                       const uint8_t *value, uint16_t length, void *user=
_data)
> -{
> -       struct bt_mcp *mcp =3D user_data;
> -       struct event_callback *cb =3D mcp->cb;
> -
> -       DBG(mcp, "Track Changed");
> -
> -       if (cb && cb->cbs && cb->cbs->track_changed)
> -               cb->cbs->track_changed(mcp);
> -}
> -
> -static void mcp_track_title_register(uint16_t att_ecode, void *user_data=
)
> -{
> -       struct bt_mcp *mcp =3D user_data;
> -
> -       if (att_ecode)
> -               DBG(mcp, "Media Track Title notification failed: 0x%04x",
> -                                       att_ecode);
> -}
> -
> -static void mcp_track_title_notify(uint16_t value_handle,
> -                       const uint8_t *value, uint16_t length, void *user=
_data)
> -{
> -       struct bt_mcp *mcp =3D user_data;
> -
> -       mcp_mp_set_track_title(mcp, value, length);
> -}
> -
> -static void mcp_track_duration_register(uint16_t att_ecode, void *user_d=
ata)
> -{
> -       struct bt_mcp *mcp =3D user_data;
> -
> -       if (att_ecode)
> -               DBG(mcp, "Media Track Duration notification failed: 0x%04=
x",
> -                                       att_ecode);
> -}
> -
> -static void mcp_track_duration_notify(uint16_t value_handle,
> -                       const uint8_t *value, uint16_t length, void *user=
_data)
> -{
> -       struct bt_mcp *mcp =3D user_data;
> -       int32_t duration;
> -
> -       memcpy(&duration, value, sizeof(int32_t));
> -       mcp_mp_set_title_duration(mcp, duration);
> -}
> -
> -static void mcp_track_position_register(uint16_t att_ecode, void *user_d=
ata)
> -{
> -       struct bt_mcp *mcp =3D user_data;
> -
> -       if (att_ecode)
> -               DBG(mcp, "Media Track Position notification failed: 0x%04=
x",
> -                                       att_ecode);
> -}
> -
> -static void mcp_track_position_notify(uint16_t value_handle,
> -               const uint8_t *value, uint16_t length, void *user_data)
> -{
> -       struct bt_mcp *mcp =3D user_data;
> -       int32_t position;
> -
> -       memcpy(&position, value, sizeof(int32_t));
> -       mcp_mp_set_title_position(mcp, position);
> -}
> -
> -static void mcp_media_state_register(uint16_t att_ecode, void *user_data=
)
> -{
> -       struct bt_mcp *mcp =3D user_data;
> -
> -       if (att_ecode)
> -               DBG(mcp, "Media Media State notification failed: 0x%04x",
> -                                       att_ecode);
> -}
> -
> -static void mcp_media_state_notify(uint16_t value_handle,
> -                       const uint8_t *value, uint16_t length, void *user=
_data)
> -{
> -       struct bt_mcp *mcp =3D user_data;
> -
> -       mcp_mp_set_media_state(mcp, *value);
> -}
> -
> -static void mcp_media_cp_register(uint16_t att_ecode, void *user_data)
> -{
> -       struct bt_mcp *mcp =3D user_data;
> -
> -       if (att_ecode)
> -               DBG(mcp, "Media Media CP notification failed: 0x%04x",
> -                                       att_ecode);
> -}
> -
> -static void mcp_media_cp_notify(uint16_t value_handle, const uint8_t *va=
lue,
> -                                       uint16_t length, void *user_data)
> -{
> -       struct bt_mcp *mcp =3D user_data;
> -
> -       DBG(mcp, "Media CP Notification");
> -}
> -
> -static void mcp_media_cp_op_supported_register(uint16_t att_ecode,
> -                                       void *user_data)
> -{
> -       struct bt_mcp *mcp =3D user_data;
> -
> -       if (att_ecode)
> -               DBG(mcp, "Media Media CP OP Supported notify failed: 0x%0=
4x",
> -                                       att_ecode);
> -}
> -
> -static void mcp_media_cp_op_supported_notify(uint16_t value_handle,
> -                       const uint8_t *value, uint16_t length, void *user=
_data)
> -{
> -       struct bt_mcp *mcp =3D user_data;
> -
> -       memcpy(&mcp->session.cp_op_supported, value, sizeof(uint32_t));
> -       DBG(mcp, "Media CP Opcodes Supported Notification 0x%08x",
> -                       mcp->session.cp_op_supported);
> -}
> -
> -static void bt_mcp_mp_name_attach(struct bt_mcp *mcp)
> -{
> -       uint16_t value_handle;
> -       struct bt_mcs *mcs =3D mcp_get_mcs(mcp);
> -
> -       if (!gatt_db_attribute_get_char_data(mcs->mp_name, NULL, &value_h=
andle,
> -                                               NULL, NULL, NULL))
> -               return;
> -
> -       DBG(mcp, "Media Player handle 0x%04x", value_handle);
> -
> -       mcp_read_value(mcp, value_handle, read_media_player_name, mcp);
> -
> -       mcp->mp_name_id =3D bt_gatt_client_register_notify(mcp->client,
> -                               value_handle, mcp_mp_name_register,
> -                               mcp_mp_name_notify, mcp, NULL);
> -}
> -
> -static void bt_mcp_track_changed_attach(struct bt_mcp *mcp)
> -{
> -       uint16_t value_handle;
> -       struct bt_mcs *mcs =3D mcp_get_mcs(mcp);
> -
> -       if (!gatt_db_attribute_get_char_data(mcs->track_changed, NULL,
> -                               &value_handle, NULL, NULL, NULL))
> -               return;
> -
> -       DBG(mcp, "Track Changed handle 0x%04x", value_handle);
> -
> -       mcp->track_changed_id =3D bt_gatt_client_register_notify(mcp->cli=
ent,
> -                               value_handle, mcp_track_changed_register,
> -                               mcp_track_changed_notify, mcp, NULL);
> -}
> -
> -static void bt_mcp_track_title_attach(struct bt_mcp *mcp)
> -{
> -       uint16_t value_handle;
> -       struct bt_mcs *mcs =3D mcp_get_mcs(mcp);
> -
> -       if (!gatt_db_attribute_get_char_data(mcs->track_title, NULL,
> -                               &value_handle, NULL, NULL, NULL))
> -               return;
> -
> -       DBG(mcp, "Track Title handle 0x%04x", value_handle);
> -
> -       mcp_read_value(mcp, value_handle, read_track_title, mcp);
> -
> -       mcp->track_title_id =3D bt_gatt_client_register_notify(mcp->clien=
t,
> -                               value_handle, mcp_track_title_register,
> -                               mcp_track_title_notify, mcp, NULL);
> -}
> -
> -static void bt_mcp_track_duration_attach(struct bt_mcp *mcp)
> -{
> -       uint16_t value_handle;
> -       struct bt_mcs *mcs =3D mcp_get_mcs(mcp);
> -
> -       if (!gatt_db_attribute_get_char_data(mcs->track_duration, NULL,
> -                               &value_handle, NULL, NULL, NULL))
> -               return;
> -
> -       DBG(mcp, "Track Duration handle 0x%04x", value_handle);
> -
> -       mcp_read_value(mcp, value_handle, read_track_duration, mcp);
> -
> -       mcp->track_duration_id =3D bt_gatt_client_register_notify(mcp->cl=
ient,
> -                               value_handle, mcp_track_duration_register=
,
> -                               mcp_track_duration_notify, mcp, NULL);
> -}
> -
> -static void bt_mcp_track_position_attach(struct bt_mcp *mcp)
> -{
> -       uint16_t value_handle;
> -       struct bt_mcs *mcs =3D mcp_get_mcs(mcp);
> -
> -       if (!gatt_db_attribute_get_char_data(mcs->track_position, NULL,
> -                               &value_handle, NULL, NULL, NULL))
> -               return;
> -
> -       DBG(mcp, "Track Position handle 0x%04x", value_handle);
> -
> -       mcp_read_value(mcp, value_handle, read_track_position, mcp);
> -
> -       mcp->track_position_id =3D bt_gatt_client_register_notify(mcp->cl=
ient,
> -                               value_handle, mcp_track_position_register=
,
> -                               mcp_track_position_notify, mcp, NULL);
> -}
> -
> -static void bt_mcp_media_state_attach(struct bt_mcp *mcp)
> -{
> -       uint16_t value_handle;
> -       struct bt_mcs *mcs =3D mcp_get_mcs(mcp);
> -
> -       if (!gatt_db_attribute_get_char_data(mcs->media_state, NULL,
> -                               &value_handle, NULL, NULL, NULL))
> -               return;
> -
> -       DBG(mcp, "Media State handle 0x%04x", value_handle);
> -
> -       mcp_read_value(mcp, value_handle, read_media_state, mcp);
> -
> -       mcp->media_state_id =3D bt_gatt_client_register_notify(mcp->clien=
t,
> -                                       value_handle, mcp_media_state_reg=
ister,
> -                                       mcp_media_state_notify, mcp, NULL=
);
> -}
> -
> -static void bt_mcp_media_cp_attach(struct bt_mcp *mcp)
> -{
> -       uint16_t value_handle;
> -       struct bt_mcs *mcs =3D mcp_get_mcs(mcp);
> -
> -       if (!gatt_db_attribute_get_char_data(mcs->media_cp, NULL,
> -                               &value_handle, NULL, NULL, NULL))
> -               return;
> -
> -       DBG(mcp, "Media Control Point handle 0x%04x", value_handle);
> -
> -       mcp->media_cp_id =3D bt_gatt_client_register_notify(mcp->client,
> -                                       value_handle, mcp_media_cp_regist=
er,
> -                                       mcp_media_cp_notify, mcp, NULL);
> -}
> -
> -static void bt_mcp_media_cp_op_supported_attach(struct bt_mcp *mcp)
> -{
> -       uint16_t value_handle;
> -       struct bt_mcs *mcs =3D mcp_get_mcs(mcp);
> -
> -       if (!gatt_db_attribute_get_char_data(mcs->media_cp_op_supportd, N=
ULL,
> -                               &value_handle, NULL, NULL, NULL))
> -               return;
> -
> -       DBG(mcp, "Media Control Point Opcodes Supported handle 0x%04x",
> -                       value_handle);
> -
> -       mcp_read_value(mcp, value_handle, read_media_cp_op_supported, mcp=
);
> -
> -       mcp->media_cp_op_supported_id =3D bt_gatt_client_register_notify(
> -               mcp->client, value_handle, mcp_media_cp_op_supported_regi=
ster,
> -               mcp_media_cp_op_supported_notify, mcp, NULL);
> -}
> -
> -static void bt_mcp_content_control_id_supported_attach(struct bt_mcp *mc=
p)
> -{
> -       uint16_t value_handle;
> -       struct bt_mcs *mcs =3D mcp_get_mcs(mcp);
> -
> -       if (!gatt_db_attribute_get_char_data(mcs->content_control_id, NUL=
L,
> -                               &value_handle, NULL, NULL, NULL))
> -               return;
> -
> -       DBG(mcp, "Media Content Control id Supported handle 0x%04x",
> -                               value_handle);
> -       mcp_read_value(mcp, value_handle, read_content_control_id, mcp);
> +       if (data->notify_cb)
> +               data->notify_cb(service);
>  }
>
>  static void foreach_mcs_char(struct gatt_db_attribute *attr, void *user_=
data)
>  {
> -       struct bt_mcp *mcp =3D user_data;
> +       struct bt_mcp_service *service =3D user_data;
> +       struct bt_mcp *mcp =3D service->mcp;
> +       const struct {
> +               uint16_t uuid;
> +               const char *name;
> +               struct gatt_db_attribute **dst;
> +               bt_gatt_client_read_callback_t cb;
> +               void (*notify_cb)(struct bt_mcp_service *service);
> +               bool no_read;
> +               bool no_notify;
> +       } attrs[] =3D {
> +               { MCS_CCID_CHRC_UUID, "CCID", &service->rdb.ccid,
> +                 update_ccid, .no_notify =3D true },
> +               { MCS_MEDIA_PLAYER_NAME_CHRC_UUID, "Media Player Name",
> +                 &service->rdb.media_player_name, update_media_player_na=
me,
> +                 .notify_cb =3D notify_media_player_name },
> +               { MCS_TRACK_CHANGED_CHRC_UUID, "Track Changed",
> +                 &service->rdb.track_changed, update_track_changed,
> +                 .no_read =3D true },
> +               { MCS_TRACK_TITLE_CHRC_UUID, "Track Title",
> +                 &service->rdb.track_title, update_track_title },
> +               { MCS_TRACK_DURATION_CHRC_UUID, "Track Duration",
> +                 &service->rdb.track_duration, update_track_duration },
> +               { MCS_TRACK_POSITION_CHRC_UUID, "Track Position",
> +                 &service->rdb.track_position, update_track_position },
> +               { MCS_PLAYBACK_SPEED_CHRC_UUID, "Playback Speed",
> +                 &service->rdb.playback_speed, update_playback_speed },
> +               { MCS_SEEKING_SPEED_CHRC_UUID, "Seeking Speed",
> +                 &service->rdb.seeking_speed, update_seeking_speed },
> +               { MCS_PLAYING_ORDER_CHRC_UUID, "Playing Order",
> +                 &service->rdb.playing_order, update_playing_order },
> +               { MCS_PLAYING_ORDER_SUPPORTED_CHRC_UUID,
> +                 "Playing Order Supported",
> +                 &service->rdb.playing_order_supported,
> +                 update_playing_order_supported, .no_notify =3D true },
> +               { MCS_MEDIA_STATE_CHRC_UUID, "Media State",
> +                 &service->rdb.media_state, update_media_state },
> +               { MCS_MEDIA_CP_CHRC_UUID, "Media Control Point",
> +                 &service->rdb.media_cp, update_media_cp },
> +               { MCS_MEDIA_CP_OP_SUPPORTED_CHRC_UUID, "Media CP Op Suppo=
rted",
> +                 &service->rdb.media_cp_op_supported,
> +                 update_media_cp_op_supported },
> +       };
> +       struct bt_gatt_client *client =3D service->mcp->client;
> +       bt_uuid_t uuid, uuid_attr;
>         uint16_t value_handle;
> -       bt_uuid_t uuid, uuid_mp_name, uuid_track_changed, uuid_track_titl=
e,
> -               uuid_track_duration, uuid_track_position, uuid_media_stat=
e,
> -               uuid_media_cp, uuid_media_cp_op_supported,
> -               uuid_content_control_id;
> -       struct bt_mcs *mcs;
> +       uint8_t props;
> +       unsigned int i;
>
>         if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle,
> -                                               NULL, NULL, &uuid))
> +                                               &props, NULL, &uuid_attr)=
)
>                 return;
>
> -       bt_uuid16_create(&uuid_mp_name, MEDIA_PLAYER_NAME_CHRC_UUID);
> -       bt_uuid16_create(&uuid_track_changed, MEDIA_TRACK_CHNGD_CHRC_UUID=
);
> -       bt_uuid16_create(&uuid_track_title, MEDIA_TRACK_TITLE_CHRC_UUID);
> -       bt_uuid16_create(&uuid_track_duration, MEDIA_TRACK_DURATION_CHRC_=
UUID);
> -       bt_uuid16_create(&uuid_track_position, MEDIA_TRACK_POSTION_CHRC_U=
UID);
> -       bt_uuid16_create(&uuid_media_state, MEDIA_STATE_CHRC_UUID);
> -       bt_uuid16_create(&uuid_media_cp, MEDIA_CP_CHRC_UUID);
> -       bt_uuid16_create(&uuid_media_cp_op_supported,
> -                                       MEDIA_CP_OP_SUPPORTED_CHRC_UUID);
> -       bt_uuid16_create(&uuid_content_control_id,
> -                                       MEDIA_CONTENT_CONTROL_ID_CHRC_UUI=
D);
> +       for (i =3D 0; i < ARRAY_SIZE(attrs); ++i) {
> +               unsigned int id;
> +               struct chrc_notify_data *data;
>
> -       if (!bt_uuid_cmp(&uuid, &uuid_mp_name)) {
> -               DBG(mcp, "Media Player Name found: handle 0x%04x",
> -                                       value_handle);
> +               if (*attrs[i].dst)
> +                       continue;
>
> -               mcs =3D mcp_get_mcs(mcp);
> -               if (!mcs || mcs->mp_name)
> -                       return;
> +               bt_uuid16_create(&uuid, attrs[i].uuid);
> +               if (bt_uuid_cmp(&uuid_attr, &uuid))
> +                       continue;
>
> -               mcs->mp_name =3D attr;
> -               bt_mcp_mp_name_attach(mcp);
> +               DBG_SVC(service, "%s found: handle 0x%04x",
> +                                               attrs[i].name, value_hand=
le);
> +               *attrs[i].dst =3D attr;
> +
> +               if ((props & BT_GATT_CHRC_PROP_READ) && !attrs[i].no_read=
)
> +                       bt_gatt_client_read_value(client, value_handle,
> +                                               attrs[i].cb, service, NUL=
L);
> +
> +               if (!(props & BT_GATT_CHRC_PROP_NOTIFY) || attrs[i].no_no=
tify)
> +                       break;
> +               if (service->notify_id_count >=3D ARRAY_SIZE(service->not=
ify_id))
> +                       break;
> +
> +               data =3D new0(struct chrc_notify_data, 1);
> +               data->name =3D attrs[i].name;
> +               data->service =3D service;
> +               data->cb =3D attrs[i].cb;
> +
> +               id =3D bt_gatt_client_register_notify(client, value_handl=
e,
> +                                               chrc_register, chrc_notif=
y,
> +                                               data, free);
> +               if (id)
> +                       service->notify_id[service->notify_id_count++] =
=3D id;
> +               else
> +                       free(data);
> +
> +               break;
>         }
>
> -       if (!bt_uuid_cmp(&uuid, &uuid_track_changed)) {
> -               DBG(mcp, "Track Changed found: handle 0x%04x", value_hand=
le);
> -
> -               mcs =3D mcp_get_mcs(mcp);
> -               if (!mcs || mcs->track_changed)
> -                       return;
> -
> -               mcs->track_changed =3D attr;
> -               bt_mcp_track_changed_attach(mcp);
> -       }
> -
> -       if (!bt_uuid_cmp(&uuid, &uuid_track_title)) {
> -               DBG(mcp, "Track Title found: handle 0x%04x", value_handle=
);
> -
> -               mcs =3D mcp_get_mcs(mcp);
> -               if (!mcs || mcs->track_title)
> -                       return;
> -
> -               mcs->track_title =3D attr;
> -               bt_mcp_track_title_attach(mcp);
> -       }
> -
> -       if (!bt_uuid_cmp(&uuid, &uuid_track_duration)) {
> -               DBG(mcp, "Track Duration found: handle 0x%04x", value_han=
dle);
> -
> -               mcs =3D mcp_get_mcs(mcp);
> -               if (!mcs || mcs->track_duration)
> -                       return;
> -
> -               mcs->track_duration =3D attr;
> -               bt_mcp_track_duration_attach(mcp);
> -       }
> -
> -       if (!bt_uuid_cmp(&uuid, &uuid_track_position)) {
> -               DBG(mcp, "Track Position found: handle 0x%04x", value_han=
dle);
> -
> -
> -               mcs =3D mcp_get_mcs(mcp);
> -               if (!mcs || mcs->track_position)
> -                       return;
> -
> -               mcs->track_position =3D attr;
> -               bt_mcp_track_position_attach(mcp);
> -       }
> -
> -       if (!bt_uuid_cmp(&uuid, &uuid_media_state)) {
> -               DBG(mcp, "Media State found: handle 0x%04x", value_handle=
);
> -
> -               mcs =3D mcp_get_mcs(mcp);
> -               if (!mcs || mcs->media_state)
> -                       return;
> -
> -               mcs->media_state =3D attr;
> -               bt_mcp_media_state_attach(mcp);
> -       }
> -
> -       if (!bt_uuid_cmp(&uuid, &uuid_media_cp)) {
> -               DBG(mcp, "Media Control Point found: handle 0x%04x",
> -                                       value_handle);
> -
> -               mcs =3D mcp_get_mcs(mcp);
> -               if (!mcs || mcs->media_cp)
> -                       return;
> -
> -               mcs->media_cp =3D attr;
> -               bt_mcp_media_cp_attach(mcp);
> -       }
> -
> -       if (!bt_uuid_cmp(&uuid, &uuid_media_cp_op_supported)) {
> -               DBG(mcp, "Media CP Opcodes Supported found: handle 0x%04x=
",
> -                                       value_handle);
> -
> -               mcs =3D mcp_get_mcs(mcp);
> -               if (!mcs || mcs->media_cp_op_supportd)
> -                       return;
> -
> -               mcs->media_cp_op_supportd =3D attr;
> -               bt_mcp_media_cp_op_supported_attach(mcp);
> -       }
> -
> -       if (!bt_uuid_cmp(&uuid, &uuid_content_control_id)) {
> -               DBG(mcp, "Content Control ID found: handle 0x%04x",
> -                                       value_handle);
> -
> -               mcs =3D mcp_get_mcs(mcp);
> -               if (!mcs || mcs->content_control_id)
> -                       return;
> -
> -               mcs->content_control_id =3D attr;
> -               bt_mcp_content_control_id_supported_attach(mcp);
> -       }
> +       if (!mcp->idle_id && i < ARRAY_SIZE(attrs))
> +               mcp->idle_id =3D bt_gatt_client_idle_register(mcp->client=
,
> +                                                       mcp_idle, mcp, NU=
LL);
>  }
>
> -void bt_mcp_set_event_callbacks(struct bt_mcp *mcp,
> -                               const struct bt_mcp_event_callback *cbs,
> -                               void *user_data)
> +static void foreach_mcs_ccid(struct gatt_db_attribute *attr, void *user_=
data)
>  {
> -       struct event_callback *cb;
> +       bt_uuid_t uuid, uuid_attr;
>
> -       if (!mcp)
> +       if (!gatt_db_attribute_get_char_data(attr, NULL, NULL, NULL, NULL=
,
> +                                                               &uuid_att=
r))
>                 return;
>
> -       if (mcp->cb)
> -               free(mcp->cb);
> +       bt_uuid16_create(&uuid, MCS_CCID_CHRC_UUID);
> +       if (bt_uuid_cmp(&uuid_attr, &uuid))
> +               return;
>
> -       cb =3D new0(struct event_callback, 1);
> -       cb->cbs =3D cbs;
> -       cb->user_data =3D user_data;
> -
> -       mcp->cb =3D cb;
> +       foreach_mcs_char(attr, user_data);
>  }
>
> -static void foreach_mcs_service(struct gatt_db_attribute *attr,
> -                                               void *user_data)
> +static void listener_destroy(void *data)
> +{
> +       struct bt_mcp_listener *listener =3D data;
> +
> +       if (listener->cb->destroy)
> +               listener->cb->destroy(listener->user_data);
> +
> +       free(listener);
> +}
> +
> +static void mcp_service_destroy(void *data)
> +{
> +       struct bt_mcp_service *service =3D data;
> +       struct bt_gatt_client *client =3D service->mcp->client;
> +       unsigned int i;
> +
> +       mcp_cancel_pending_writes(service);
> +
> +       queue_destroy(service->listeners, listener_destroy);
> +
> +       for (i =3D 0; i < service->notify_id_count; ++i)
> +               bt_gatt_client_unregister_notify(client, service->notify_=
id[i]);
> +
> +       queue_destroy(service->pending, free);
> +       free(service);
> +}
> +
> +static void foreach_mcs_service(struct gatt_db_attribute *attr, void *us=
er_data)
>  {
>         struct bt_mcp *mcp =3D user_data;
> -       struct bt_mcs *mcs =3D mcp_get_mcs(mcp);
> +       struct bt_mcp_service *service;
> +       bt_uuid_t uuid, uuid_attr;
> +       bool gmcs, mcs;
>
> -       DBG(mcp, "");
> +       DBG_MCP(mcp, "");
>
> -       mcs->service =3D attr;
> +       if (!gatt_db_attribute_get_service_uuid(attr, &uuid_attr))
> +               return;
>
> -       gatt_db_service_foreach_char(attr, foreach_mcs_char, mcp);
> +       bt_uuid16_create(&uuid, GMCS_UUID);
> +       gmcs =3D !bt_uuid_cmp(&uuid_attr, &uuid);
> +
> +       if (gmcs !=3D mcp->gmcs)
> +               return;
> +
> +       bt_uuid16_create(&uuid, MCS_UUID);
> +       mcs =3D !bt_uuid_cmp(&uuid_attr, &uuid);
> +
> +       if (!gmcs && !mcs)
> +               return;
> +
> +       service =3D new0(struct bt_mcp_service, 1);
> +       service->mcp =3D mcp;
> +       service->rdb.gmcs =3D gmcs;
> +       service->rdb.service =3D attr;
> +       service->rdb.ccid_value =3D -1;
> +       service->pending =3D queue_new();
> +       service->listeners =3D queue_new();
> +
> +       /* Find CCID first */
> +       gatt_db_service_foreach_char(attr, foreach_mcs_ccid, service);
> +
> +       gatt_db_service_foreach_char(attr, foreach_mcs_char, service);
> +
> +       queue_push_tail(mcp->services, service);
>  }
>
> -static struct bt_mcp_db *mcp_db_new(struct gatt_db *db)
> +static bool match_service_attr(const void *data, const void *user_data)
>  {
> -       struct bt_mcp_db *mdb;
> +       const struct bt_mcp_service *service =3D data;
>
> -       if (!db)
> -               return NULL;
> -
> -       mdb =3D new0(struct bt_mcp_db, 1);
> -       mdb->db =3D gatt_db_ref(db);
> -
> -       if (!mcp_db)
> -               mcp_db =3D queue_new();
> -
> -       queue_push_tail(mcp_db, mdb);
> -
> -       mdb->mcs =3D mcs_new(db);
> -       return mdb;
> +       return service->rdb.service =3D=3D user_data;
>  }
>
> -static struct bt_mcp_db *mcp_get_db(struct gatt_db *db)
> +static void mcp_service_added(struct gatt_db_attribute *attr, void *user=
_data)
>  {
> -       struct bt_mcp_db *mdb;
> +       struct bt_mcp *mcp =3D user_data;
>
> -       mdb =3D queue_find(mcp_db, mcp_db_match, db);
> -       if (mdb)
> -               return mdb;
> -
> -       return mcp_db_new(db);
> +       foreach_mcs_service(attr, mcp);
>  }
>
> -struct bt_mcp *bt_mcp_new(struct gatt_db *ldb, struct gatt_db *rdb)
> +static void mcp_service_removed(struct gatt_db_attribute *attr, void *us=
er_data)
> +{
> +       struct bt_mcp *mcp =3D user_data;
> +
> +       queue_remove_all(mcp->services, match_service_attr, attr,
> +                                                       mcp_service_destr=
oy);
> +}
> +
> +struct bt_mcp *bt_mcp_attach(struct bt_gatt_client *client, bool gmcs,
> +                       const struct bt_mcp_callback *cb, void *user_data=
)
>  {
>         struct bt_mcp *mcp;
> -       struct bt_mcp_db *mdb;
> +       struct gatt_db *db;
> +       bt_uuid_t uuid;
>
> -       if (!ldb)
> +       if (!cb)
>                 return NULL;
>
> -       mdb =3D mcp_get_db(ldb);
> -       if (!mdb)
> -               return NULL;
> +       client =3D bt_gatt_client_clone(client);
> +       if (!client)
> +               return false;
>
>         mcp =3D new0(struct bt_mcp, 1);
> -       mcp->ldb =3D mdb;
> -       mcp->pending =3D queue_new();
> +       mcp->gmcs =3D gmcs;
> +       mcp->client =3D client;
> +       mcp->services =3D queue_new();
> +       mcp->cb =3D cb;
> +       mcp->user_data =3D user_data;
>
> -       if (!rdb)
> -               goto done;
> +       DBG_MCP(mcp, "");
>
> -       mdb =3D new0(struct bt_mcp_db, 1);
> -       mdb->db =3D gatt_db_ref(rdb);
> +       db =3D bt_gatt_client_get_db(client);
>
> -       mcp->rdb =3D mdb;
> +       bt_uuid16_create(&uuid, GMCS_UUID);
> +       gatt_db_foreach_service(db, &uuid, foreach_mcs_service, mcp);
>
> -done:
> -       bt_mcp_ref(mcp);
> +       bt_uuid16_create(&uuid, MCS_UUID);
> +       gatt_db_foreach_service(db, &uuid, foreach_mcs_service, mcp);
> +
> +       mcp->db_id =3D gatt_db_register(db, mcp_service_added,
> +                                               mcp_service_removed, mcp,=
 NULL);
> +
> +       if (!mcp->idle_id)
> +               mcp_idle(mcp);
>
>         return mcp;
>  }
>
> -void bt_mcp_register(struct gatt_db *db)
> -{
> -       if (!db)
> -               return;
> -
> -       mcp_db_new(db);
> -}
> -
> -bool bt_mcp_attach(struct bt_mcp *mcp, struct bt_gatt_client *client)
> -{
> -       bt_uuid_t uuid;
> -
> -       if (!mcp)
> -               return false;
> -
> -       DBG(mcp, "mcp %p", mcp);
> -
> -       mcp->client =3D bt_gatt_client_clone(client);
> -       if (!mcp->client)
> -               return false;
> -
> -       if (mcp->rdb->mcs) {
> -               bt_mcp_mp_name_attach(mcp);
> -               bt_mcp_track_changed_attach(mcp);
> -               bt_mcp_track_title_attach(mcp);
> -               bt_mcp_track_duration_attach(mcp);
> -               bt_mcp_track_position_attach(mcp);
> -               bt_mcp_media_state_attach(mcp);
> -               bt_mcp_media_cp_attach(mcp);
> -               bt_mcp_media_cp_op_supported_attach(mcp);
> -               bt_mcp_content_control_id_supported_attach(mcp);
> -
> -               return true;
> -       }
> -
> -       bt_uuid16_create(&uuid, GMCS_UUID);
> -       gatt_db_foreach_service(mcp->rdb->db, &uuid, foreach_mcs_service,=
 mcp);
> -
> -       return true;
> -}
> -
>  void bt_mcp_detach(struct bt_mcp *mcp)
>  {
> +       struct gatt_db *db;
> +
>         if (!mcp)
>                 return;
>
> -       DBG(mcp, "%p", mcp);
> +       DBG_MCP(mcp, "");
> +
> +       queue_destroy(mcp->services, mcp_service_destroy);
> +
> +       if (mcp->cb->destroy)
> +               mcp->cb->destroy(mcp->user_data);
> +
> +       if (mcp->idle_id)
> +               bt_gatt_client_idle_unregister(mcp->client, mcp->idle_id)=
;
> +
> +       db =3D bt_gatt_client_get_db(mcp->client);
> +       if (mcp->db_id)
> +               gatt_db_unregister(db, mcp->db_id);
>
>         bt_gatt_client_unref(mcp->client);
> -       mcp->client =3D NULL;
> +
> +       free(mcp);
> +}
> +
> +bool bt_mcp_add_listener(struct bt_mcp *mcp, uint8_t ccid,
> +                               const struct bt_mcp_listener_callback *cb=
,
> +                               void *user_data)
> +{
> +       struct bt_mcp_listener *listener;
> +       struct bt_mcp_service *service;
> +
> +       if (!cb)
> +               return false;
> +
> +       service =3D queue_find(mcp->services, match_ccid, UINT_TO_PTR(cci=
d));
> +       if (!service)
> +               return false;
> +
> +       listener =3D new0(struct bt_mcp_listener, 1);
> +       listener->cb =3D cb;
> +       listener->user_data =3D user_data;
> +
> +       queue_push_tail(service->listeners, listener);
> +       return true;
>  }
> diff --git a/src/shared/mcp.h b/src/shared/mcp.h
> index ee57ed4bf..937afb6d3 100644
> --- a/src/shared/mcp.h
> +++ b/src/shared/mcp.h
> @@ -10,54 +10,160 @@
>  #include <stdbool.h>
>  #include <inttypes.h>
>
> -#ifndef __packed
> -#define __packed __attribute__((packed))
> -#endif
> -
>  struct bt_mcp;
> -struct bt_mcp_db;
> -struct bt_mcp_session_info;
> +struct bt_mcs;
>
> -typedef void (*bt_mcp_debug_func_t)(const char *str, void *user_data);
> -typedef void (*bt_mcp_destroy_func_t)(void *user_data);
> +/*
> + * Media Control Client
> + */
>
> -struct bt_mcp_event_callback {
> -       void (*player_name)(struct bt_mcp *mcp,  const uint8_t *value,
> -                                       uint16_t length);
> -       void (*track_changed)(struct bt_mcp *mcp);
> -       void (*track_title)(struct bt_mcp *mcp, const uint8_t *value,
> -                                       uint16_t length);
> -       void (*track_duration)(struct bt_mcp *mcp, int32_t duration);
> -       void (*track_position)(struct bt_mcp *mcp, int32_t position);
> -       void (*playback_speed)(struct bt_mcp *mcp, int8_t speed);
> -       void (*seeking_speed)(struct bt_mcp *mcp, int8_t speed);
> -       void (*play_order)(struct bt_mcp *mcp, uint8_t order);
> -       void (*play_order_supported)(struct bt_mcp *mcp,
> -                                       uint16_t order_supported);
> -       void (*media_state)(struct bt_mcp *mcp, uint8_t state);
> -       void (*content_control_id)(struct bt_mcp *mcp, uint8_t cc_id);
> +struct bt_mcp_callback {
> +       /* New player seen */
> +       void (*ccid)(void *data, uint8_t ccid, bool gmcs);
> +
> +       /* Client command complete */
> +       void (*complete)(void *data, unsigned int id, uint8_t status);
> +
> +       /* Attach complete */
> +       void (*ready)(void *data);
> +
> +       /* Debug message */
> +       void (*debug)(void *data, const char *str);
> +
> +       /* mcp destroyed (no further callbacks) */
> +       void (*destroy)(void *data);
>  };
>
> -void bt_mcp_set_event_callbacks(struct bt_mcp *mcp,
> -                               const struct bt_mcp_event_callback *cbs,
> +struct bt_mcp_listener_callback {
> +       /* Value notification */
> +       void (*media_player_name)(void *data, const uint8_t *value,
> +                                                       uint16_t length);
> +       void (*track_changed)(void *data);
> +       void (*track_title)(void *data, const uint8_t *value, uint16_t le=
ngth);
> +       void (*track_duration)(void *data, int32_t duration_centisecond);
> +       void (*track_position)(void *data, int32_t position_centisecond);
> +       void (*playback_speed)(void *data, int8_t log2_speed);
> +       void (*seeking_speed)(void *data, int8_t log2_speed);
> +       void (*playing_order)(void *data, uint8_t order);
> +       void (*media_state)(void *data, uint8_t state);
> +
> +       /* TODO: OTS */
> +
> +       /* Listener destroyed (no further callbacks) */
> +       void (*destroy)(void *data);
> +};
> +
> +unsigned int bt_mcp_play(struct bt_mcp *mcp, uint8_t ccid);
> +unsigned int bt_mcp_pause(struct bt_mcp *mcp, uint8_t ccid);
> +unsigned int bt_mcp_fast_rewind(struct bt_mcp *mcp, uint8_t ccid);
> +unsigned int bt_mcp_fast_forward(struct bt_mcp *mcp, uint8_t ccid);
> +unsigned int bt_mcp_stop(struct bt_mcp *mcp, uint8_t ccid);
> +unsigned int bt_mcp_move_relative(struct bt_mcp *mcp, uint8_t ccid,
> +                                                               int32_t o=
ffset);
> +
> +unsigned int bt_mcp_previous_segment(struct bt_mcp *mcp, uint8_t ccid);
> +unsigned int bt_mcp_next_segment(struct bt_mcp *mcp, uint8_t ccid);
> +unsigned int bt_mcp_first_segment(struct bt_mcp *mcp, uint8_t ccid);
> +unsigned int bt_mcp_last_segment(struct bt_mcp *mcp, uint8_t ccid);
> +unsigned int bt_mcp_goto_segment(struct bt_mcp *mcp, uint8_t ccid, int32=
_t n);
> +
> +unsigned int bt_mcp_previous_track(struct bt_mcp *mcp, uint8_t ccid);
> +unsigned int bt_mcp_next_track(struct bt_mcp *mcp, uint8_t ccid);
> +unsigned int bt_mcp_first_track(struct bt_mcp *mcp, uint8_t ccid);
> +unsigned int bt_mcp_last_track(struct bt_mcp *mcp, uint8_t ccid);
> +unsigned int bt_mcp_goto_track(struct bt_mcp *mcp, uint8_t ccid, int32_t=
 n);
> +
> +unsigned int bt_mcp_previous_group(struct bt_mcp *mcp, uint8_t ccid);
> +unsigned int bt_mcp_next_group(struct bt_mcp *mcp, uint8_t ccid);
> +unsigned int bt_mcp_first_group(struct bt_mcp *mcp, uint8_t ccid);
> +unsigned int bt_mcp_last_group(struct bt_mcp *mcp, uint8_t ccid);
> +unsigned int bt_mcp_goto_group(struct bt_mcp *mcp, uint8_t ccid, int32_t=
 n);
> +
> +unsigned int bt_mcp_set_track_position(struct bt_mcp *mcp, uint8_t ccid,
> +                                                       int32_t position)=
;
> +unsigned int bt_mcp_set_playback_speed(struct bt_mcp *mcp, uint8_t ccid,
> +                                                       int8_t speed);
> +unsigned int bt_mcp_set_playing_order(struct bt_mcp *mcp, uint8_t ccid,
> +                                                       uint8_t order);
> +
> +uint16_t bt_mcp_get_supported_playing_order(struct bt_mcp *mcp, uint8_t =
ccid);
> +uint32_t bt_mcp_get_supported_commands(struct bt_mcp *mcp, uint8_t ccid)=
;
> +
> +bool bt_mcp_add_listener(struct bt_mcp *mcp, uint8_t ccid,
> +                               const struct bt_mcp_listener_callback *cb=
,
>                                 void *user_data);
>
> -bool bt_mcp_set_debug(struct bt_mcp *mcp, bt_mcp_debug_func_t cb,
> -                       void *user_data, bt_mcp_destroy_func_t destroy);
> -
> -void bt_mcp_register(struct gatt_db *db);
> -bool bt_mcp_attach(struct bt_mcp *mcp, struct bt_gatt_client *client);
> +struct bt_mcp *bt_mcp_attach(struct bt_gatt_client *client, bool gmcs,
> +                               const struct bt_mcp_callback *cb,
> +                               void *user_data);
>  void bt_mcp_detach(struct bt_mcp *mcp);
>
> -struct bt_mcp *bt_mcp_new(struct gatt_db *ldb, struct gatt_db *rdb);
> -struct bt_mcp *bt_mcp_ref(struct bt_mcp *mcp);
> -void bt_mcp_unref(struct bt_mcp *mcp);
> +/*
> + * Media Control Server
> + */
>
> -bool bt_mcp_set_user_data(struct bt_mcp *mcp, void *user_data);
> -void *bt_mcp_get_user_data(struct bt_mcp *mcp);
> +struct bt_mcs_callback {
> +       /* Value requests */
> +       void (*media_player_name)(void *data, struct iovec *buf, size_t s=
ize);
> +       void (*track_title)(void *data, struct iovec *buf, size_t size);
> +       int32_t (*track_duration)(void *data);
> +       int32_t (*track_position)(void *data);
> +       int8_t (*playback_speed)(void *data);
> +       int8_t (*seeking_speed)(void *data);
> +       uint8_t (*playing_order)(void *data);
> +       uint16_t (*playing_order_supported)(void *data);
> +       uint32_t (*media_cp_op_supported)(void *data);
>
> -unsigned int bt_mcp_play(struct bt_mcp *mcp);
> -unsigned int bt_mcp_pause(struct bt_mcp *mcp);
> -unsigned int bt_mcp_stop(struct bt_mcp *mcp);
> -unsigned int bt_mcp_next_track(struct bt_mcp *mcp);
> -unsigned int bt_mcp_previous_track(struct bt_mcp *mcp);
> +       /* TODO: OTS */
> +
> +       /* Set value notification */
> +       bool (*set_track_position)(void *data, int32_t value);
> +       bool (*set_playback_speed)(void *data, int8_t value);
> +       bool (*set_playing_order)(void *data, uint8_t value);
> +
> +       /* Command notification */
> +       bool (*play)(void *data);
> +       bool (*pause)(void *data);
> +       bool (*fast_rewind)(void *data);
> +       bool (*fast_forward)(void *data);
> +       bool (*stop)(void *data);
> +       bool (*move_relative)(void *data, int32_t offset);
> +
> +       bool (*previous_segment)(void *data);
> +       bool (*next_segment)(void *data);
> +       bool (*first_segment)(void *data);
> +       bool (*last_segment)(void *data);
> +       bool (*goto_segment)(void *data, int32_t n);
> +
> +       bool (*previous_track)(void *data);
> +       bool (*next_track)(void *data);
> +       bool (*first_track)(void *data);
> +       bool (*last_track)(void *data);
> +       bool (*goto_track)(void *data, int32_t n);
> +
> +       bool (*previous_group)(void *data);
> +       bool (*next_group)(void *data);
> +       bool (*first_group)(void *data);
> +       bool (*last_group)(void *data);
> +       bool (*goto_group)(void *data, int32_t n);
> +
> +       /* Debug message */
> +       void (*debug)(void *data, const char *str);
> +
> +       /* Player destroyed (no further callbacks) */
> +       void (*destroy)(void *data);
> +};
> +
> +void bt_mcs_set_media_state(struct bt_mcs *mcs, uint8_t state);
> +uint8_t bt_mcs_get_media_state(struct bt_mcs *mcs);
> +
> +void bt_mcs_changed(struct bt_mcs *mcs, uint16_t chrc_uuid);
> +uint8_t bt_mcs_get_ccid(struct bt_mcs *mcs);
> +
> +struct bt_mcs *bt_mcs_register(struct gatt_db *db, bool is_gmcs,
> +                       const struct bt_mcs_callback *cb, void *user_data=
);
> +void bt_mcs_unregister(struct bt_mcs *mcs);
> +void bt_mcs_unregister_all(struct gatt_db *db);
> +
> +/* For tests: */
> +void bt_mcs_test_util_reset_ccid(void);
> diff --git a/src/shared/mcs.h b/src/shared/mcs.h
> index 09b3bffe8..f6666ab58 100644
> --- a/src/shared/mcs.h
> +++ b/src/shared/mcs.h
> @@ -7,11 +7,54 @@
>   *
>   */
>
> +#ifndef __packed
> +#define __packed __attribute__((packed))
> +#endif
> +
> +struct bt_mcs_cp_rsp {
> +       uint8_t op;
> +       uint8_t result;
> +} __packed;
> +
> +/* MCP Track Position */
> +#define BT_MCS_POSITION_UNAVAILABLE    ((int32_t)0xffffffffu)
> +#define BT_MCS_DURATION_UNAVAILABLE    ((int32_t)0xffffffffu)
> +
>  /* MCP Media State */
> -#define BT_MCS_STATUS_INACTIVE 0x00
> -#define BT_MCS_STATUS_PLAYING  0x01
> -#define BT_MCS_STATUS_PAUSED   0x02
> -#define BT_MCS_STATUS_SEEKING  0x03
> +#define BT_MCS_STATE_INACTIVE  0x00
> +#define BT_MCS_STATE_PLAYING   0x01
> +#define BT_MCS_STATE_PAUSED    0x02
> +#define BT_MCS_STATE_SEEKING   0x03
> +
> +/* MCP Playing Order */
> +#define BT_MCS_ORDER_SINGLE_ONCE       0x01
> +#define BT_MCS_ORDER_SINGLE_REPEAT     0x02
> +#define BT_MCS_ORDER_IN_ORDER_ONCE     0x03
> +#define BT_MCS_ORDER_IN_ORDER_REPEAT   0x04
> +#define BT_MCS_ORDER_OLDEST_ONCE       0x05
> +#define BT_MCS_ORDER_OLDEST_REPEAT     0x06
> +#define BT_MCS_ORDER_NEWEST_ONCE       0x07
> +#define BT_MCS_ORDER_NEWEST_REPEAT     0x08
> +#define BT_MCS_ORDER_SHUFFLE_ONCE      0x09
> +#define BT_MCS_ORDER_SHUFFLE_REPEAT    0x0a
> +
> +/* MCP Playing Order Supported */
> +#define BT_MCS_ORDER_SUPPORTED_SINGLE_ONCE     0x0001
> +#define BT_MCS_ORDER_SUPPORTED_SINGLE_REPEAT   0x0002
> +#define BT_MCS_ORDER_SUPPORTED_IN_ORDER_ONCE   0x0004
> +#define BT_MCS_ORDER_SUPPORTED_IN_ORDER_REPEAT 0x0008
> +#define BT_MCS_ORDER_SUPPORTED_OLDEST_ONCE     0x0010
> +#define BT_MCS_ORDER_SUPPORTED_OLDEST_REPEAT   0x0020
> +#define BT_MCS_ORDER_SUPPORTED_NEWEST_ONCE     0x0040
> +#define BT_MCS_ORDER_SUPPORTED_NEWEST_REPEAT   0x0080
> +#define BT_MCS_ORDER_SUPPORTED_SHUFFLE_ONCE    0x0100
> +#define BT_MCS_ORDER_SUPPORTED_SHUFFLE_REPEAT  0x0200
> +
> +/* Control Point result codes */
> +#define BT_MCS_RESULT_SUCCESS                  0x01
> +#define BT_MCS_RESULT_OP_NOT_SUPPORTED         0x02
> +#define BT_MCS_RESULT_MEDIA_PLAYER_INACTIVE    0x03
> +#define BT_MCS_RESULT_COMMAND_CANNOT_COMPLETE  0x04
>
>  /* MCP Control Point Opcodes */
>  #define BT_MCS_CMD_PLAY                            0x01
> --
> 2.51.1

There quite a few build errors when build each patch:

profiles/audio/mcp.c: In function =E2=80=98mcp_status_val_to_string=E2=80=
=99:
profiles/audio/mcp.c:91:14: error: =E2=80=98BT_MCS_STATUS_PLAYING=E2=80=99 =
undeclared
(first use in this function); did you mean =E2=80=98BT_MCS_STATE_PLAYING=E2=
=80=99?
   91 |         case BT_MCS_STATUS_PLAYING:
      |              ^~~~~~~~~~~~~~~~~~~~~
      |              BT_MCS_STATE_PLAYING
profiles/audio/mcp.c:91:14: note: each undeclared identifier is
reported only once for each function it appears in
profiles/audio/mcp.c:93:14: error: =E2=80=98BT_MCS_STATUS_PAUSED=E2=80=99 u=
ndeclared
(first use in this function); did you mean =E2=80=98BT_MCS_STATE_PAUSED=E2=
=80=99?
   93 |         case BT_MCS_STATUS_PAUSED:
      |              ^~~~~~~~~~~~~~~~~~~~
      |              BT_MCS_STATE_PAUSED
profiles/audio/mcp.c:95:14: error: =E2=80=98BT_MCS_STATUS_INACTIVE=E2=80=99=
 undeclared
(first use in this function); did you mean =E2=80=98BT_MCS_STATE_INACTIVE=
=E2=80=99?
   95 |         case BT_MCS_STATUS_INACTIVE:
      |              ^~~~~~~~~~~~~~~~~~~~~~
      |              BT_MCS_STATE_INACTIVE
profiles/audio/mcp.c:97:14: error: =E2=80=98BT_MCS_STATUS_SEEKING=E2=80=99 =
undeclared
(first use in this function); did you mean =E2=80=98BT_MCS_STATE_SEEKING=E2=
=80=99?
   97 |         case BT_MCS_STATUS_SEEKING:
      |              ^~~~~~~~~~~~~~~~~~~~~
      |              BT_MCS_STATE_SEEKING
profiles/audio/mcp.c: In function =E2=80=98cb_player_name=E2=80=99:
profiles/audio/mcp.c:121:35: error: implicit declaration of function
=E2=80=98bt_mcp_get_user_data=E2=80=99; did you mean =E2=80=98btd_service_g=
et_user_data=E2=80=99?
[-Wimplicit-function-declaration]
  121 |         struct media_player *mp =3D bt_mcp_get_user_data(mcp);
      |                                   ^~~~~~~~~~~~~~~~~~~~
      |                                   btd_service_get_user_data
profiles/audio/mcp.c:121:35: error: initialization of =E2=80=98struct
media_player *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from integ=
er without a cast
[-Wint-conversion]
profiles/audio/mcp.c: In function =E2=80=98cb_track_title=E2=80=99:
profiles/audio/mcp.c:144:35: error: initialization of =E2=80=98struct
media_player *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from integ=
er without a cast
[-Wint-conversion]
  144 |         struct media_player *mp =3D bt_mcp_get_user_data(mcp);
      |                                   ^~~~~~~~~~~~~~~~~~~~
profiles/audio/mcp.c: In function =E2=80=98cb_track_duration=E2=80=99:
profiles/audio/mcp.c:159:35: error: initialization of =E2=80=98struct
media_player *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from integ=
er without a cast
[-Wint-conversion]
  159 |         struct media_player *mp =3D bt_mcp_get_user_data(mcp);
      |                                   ^~~~~~~~~~~~~~~~~~~~
profiles/audio/mcp.c: In function =E2=80=98cb_track_position=E2=80=99:
profiles/audio/mcp.c:170:35: error: initialization of =E2=80=98struct
media_player *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from integ=
er without a cast
[-Wint-conversion]
  170 |         struct media_player *mp =3D bt_mcp_get_user_data(mcp);
      |                                   ^~~~~~~~~~~~~~~~~~~~
profiles/audio/mcp.c: In function =E2=80=98cb_media_state=E2=80=99:
profiles/audio/mcp.c:178:35: error: initialization of =E2=80=98struct
media_player *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from integ=
er without a cast
[-Wint-conversion]
  178 |         struct media_player *mp =3D bt_mcp_get_user_data(mcp);
      |                                   ^~~~~~~~~~~~~~~~~~~~
profiles/audio/mcp.c: At top level:
profiles/audio/mcp.c:183:21: error: variable =E2=80=98cbs=E2=80=99 has init=
ializer but
incomplete type
  183 | static const struct bt_mcp_event_callback cbs =3D {
      |                     ^~~~~~~~~~~~~~~~~~~~~
profiles/audio/mcp.c:184:10: error: =E2=80=98const struct
bt_mcp_event_callback=E2=80=99 has no member named =E2=80=98player_name=E2=
=80=99
  184 |         .player_name                    =3D cb_player_name,
      |          ^~~~~~~~~~~
profiles/audio/mcp.c:184:43: error: excess elements in struct
initializer [-Werror]
  184 |         .player_name                    =3D cb_player_name,
      |                                           ^~~~~~~~~~~~~~
profiles/audio/mcp.c:184:43: note: (near initialization for =E2=80=98cbs=E2=
=80=99)
profiles/audio/mcp.c:185:10: error: =E2=80=98const struct
bt_mcp_event_callback=E2=80=99 has no member named =E2=80=98track_changed=
=E2=80=99
  185 |         .track_changed                  =3D cb_track_changed,
      |          ^~~~~~~~~~~~~
profiles/audio/mcp.c:185:43: error: excess elements in struct
initializer [-Werror]
  185 |         .track_changed                  =3D cb_track_changed,
      |                                           ^~~~~~~~~~~~~~~~
profiles/audio/mcp.c:185:43: note: (near initialization for =E2=80=98cbs=E2=
=80=99)
profiles/audio/mcp.c:186:10: error: =E2=80=98const struct
bt_mcp_event_callback=E2=80=99 has no member named =E2=80=98track_title=E2=
=80=99
  186 |         .track_title                    =3D cb_track_title,
      |          ^~~~~~~~~~~
profiles/audio/mcp.c:186:43: error: excess elements in struct
initializer [-Werror]
  186 |         .track_title                    =3D cb_track_title,
      |                                           ^~~~~~~~~~~~~~
profiles/audio/mcp.c:186:43: note: (near initialization for =E2=80=98cbs=E2=
=80=99)
profiles/audio/mcp.c:187:10: error: =E2=80=98const struct
bt_mcp_event_callback=E2=80=99 has no member named =E2=80=98track_duration=
=E2=80=99
  187 |         .track_duration                 =3D cb_track_duration,
      |          ^~~~~~~~~~~~~~
profiles/audio/mcp.c:187:43: error: excess elements in struct
initializer [-Werror]
  187 |         .track_duration                 =3D cb_track_duration,
      |                                           ^~~~~~~~~~~~~~~~~
profiles/audio/mcp.c:187:43: note: (near initialization for =E2=80=98cbs=E2=
=80=99)
profiles/audio/mcp.c:188:10: error: =E2=80=98const struct
bt_mcp_event_callback=E2=80=99 has no member named =E2=80=98track_position=
=E2=80=99
  188 |         .track_position                 =3D cb_track_position,
      |          ^~~~~~~~~~~~~~
profiles/audio/mcp.c:188:43: error: excess elements in struct
initializer [-Werror]
  188 |         .track_position                 =3D cb_track_position,
      |                                           ^~~~~~~~~~~~~~~~~
profiles/audio/mcp.c:188:43: note: (near initialization for =E2=80=98cbs=E2=
=80=99)
profiles/audio/mcp.c:189:10: error: =E2=80=98const struct
bt_mcp_event_callback=E2=80=99 has no member named =E2=80=98media_state=E2=
=80=99
  189 |         .media_state                    =3D cb_media_state,
      |          ^~~~~~~~~~~
profiles/audio/mcp.c:189:43: error: excess elements in struct
initializer [-Werror]
  189 |         .media_state                    =3D cb_media_state,
      |                                           ^~~~~~~~~~~~~~
profiles/audio/mcp.c:189:43: note: (near initialization for =E2=80=98cbs=E2=
=80=99)
profiles/audio/mcp.c: In function =E2=80=98ct_play=E2=80=99:
profiles/audio/mcp.c:196:16: error: too few arguments to function
=E2=80=98bt_mcp_play=E2=80=99; expected 2, have 1
  196 |         return bt_mcp_play(mcp);
      |                ^~~~~~~~~~~
In file included from profiles/audio/mcp.c:42:
./src/shared/mcp.h:56:14: note: declared here
   56 | unsigned int bt_mcp_play(struct bt_mcp *mcp, uint8_t ccid);
      |              ^~~~~~~~~~~
profiles/audio/mcp.c: In function =E2=80=98ct_pause=E2=80=99:
profiles/audio/mcp.c:203:16: error: too few arguments to function
=E2=80=98bt_mcp_pause=E2=80=99; expected 2, have 1
  203 |         return bt_mcp_pause(mcp);
      |                ^~~~~~~~~~~~
./src/shared/mcp.h:57:14: note: declared here
   57 | unsigned int bt_mcp_pause(struct bt_mcp *mcp, uint8_t ccid);
      |              ^~~~~~~~~~~~
profiles/audio/mcp.c: In function =E2=80=98ct_stop=E2=80=99:
profiles/audio/mcp.c:210:16: error: too few arguments to function
=E2=80=98bt_mcp_stop=E2=80=99; expected 2, have 1
  210 |         return bt_mcp_stop(mcp);
      |                ^~~~~~~~~~~
./src/shared/mcp.h:60:14: note: declared here
   60 | unsigned int bt_mcp_stop(struct bt_mcp *mcp, uint8_t ccid);
      |              ^~~~~~~~~~~
profiles/audio/mcp.c: In function =E2=80=98ct_next=E2=80=99:
profiles/audio/mcp.c:217:16: error: too few arguments to function
=E2=80=98bt_mcp_next_track=E2=80=99; expected 2, have 1
  217 |         return bt_mcp_next_track(mcp);
      |                ^~~~~~~~~~~~~~~~~
./src/shared/mcp.h:71:14: note: declared here
   71 | unsigned int bt_mcp_next_track(struct bt_mcp *mcp, uint8_t ccid);
      |              ^~~~~~~~~~~~~~~~~
profiles/audio/mcp.c: In function =E2=80=98ct_previous=E2=80=99:
profiles/audio/mcp.c:224:16: error: too few arguments to function
=E2=80=98bt_mcp_previous_track=E2=80=99; expected 2, have 1
  224 |         return bt_mcp_previous_track(mcp);
      |                ^~~~~~~~~~~~~~~~~~~~~
./src/shared/mcp.h:70:14: note: declared here
   70 | unsigned int bt_mcp_previous_track(struct bt_mcp *mcp, uint8_t ccid=
);
      |              ^~~~~~~~~~~~~~~~~~~~~
profiles/audio/mcp.c: In function =E2=80=98mcp_probe=E2=80=99:
profiles/audio/mcp.c:255:21: error: implicit declaration of function
=E2=80=98bt_mcp_new=E2=80=99; did you mean =E2=80=98bt_att_new=E2=80=99?
[-Wimplicit-function-declaration]
  255 |         data->mcp =3D bt_mcp_new(btd_gatt_database_get_db(database)=
,
      |                     ^~~~~~~~~~
      |                     bt_att_new
profiles/audio/mcp.c:255:19: error: assignment to =E2=80=98struct bt_mcp *=
=E2=80=99
from =E2=80=98int=E2=80=99 makes pointer from integer without a cast
[-Wint-conversion]
  255 |         data->mcp =3D bt_mcp_new(btd_gatt_database_get_db(database)=
,
      |                   ^
profiles/audio/mcp.c:258:9: error: implicit declaration of function
=E2=80=98bt_mcp_set_debug=E2=80=99; did you mean =E2=80=98bt_att_set_debug=
=E2=80=99?
[-Wimplicit-function-declaration]
  258 |         bt_mcp_set_debug(data->mcp, mcp_debug, NULL, NULL);
      |         ^~~~~~~~~~~~~~~~
      |         bt_att_set_debug
profiles/audio/mcp.c: In function =E2=80=98mcp_data_free=E2=80=99:
profiles/audio/mcp.c:270:17: error: implicit declaration of function
=E2=80=98bt_mcp_set_user_data=E2=80=99; did you mean =E2=80=98btd_service_s=
et_user_data=E2=80=99?
[-Wimplicit-function-declaration]
  270 |                 bt_mcp_set_user_data(data->mcp, NULL);
      |                 ^~~~~~~~~~~~~~~~~~~~
      |                 btd_service_set_user_data
profiles/audio/mcp.c:278:9: error: implicit declaration of function
=E2=80=98bt_mcp_unref=E2=80=99; did you mean =E2=80=98bt_att_unref=E2=80=99=
?
[-Wimplicit-function-declaration]
  278 |         bt_mcp_unref(data->mcp);
      |         ^~~~~~~~~~~~
      |         bt_att_unref
profiles/audio/mcp.c: In function =E2=80=98mcp_accept=E2=80=99:
profiles/audio/mcp.c:317:27: error: passing argument 1 of
=E2=80=98bt_mcp_attach=E2=80=99 from incompatible pointer type
[-Wincompatible-pointer-types]
  317 |         bt_mcp_attach(data->mcp, client);
      |                       ~~~~^~~~~
      |                           |
      |                           struct bt_mcp *
./src/shared/mcp.h:96:53: note: expected =E2=80=98struct bt_gatt_client *=
=E2=80=99 but
argument is of type =E2=80=98struct bt_mcp *=E2=80=99
   96 | struct bt_mcp *bt_mcp_attach(struct bt_gatt_client *client, bool gm=
cs,
      |                              ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
profiles/audio/mcp.c:317:9: error: too few arguments to function
=E2=80=98bt_mcp_attach=E2=80=99; expected 4, have 2
  317 |         bt_mcp_attach(data->mcp, client);
      |         ^~~~~~~~~~~~~
./src/shared/mcp.h:96:16: note: declared here
   96 | struct bt_mcp *bt_mcp_attach(struct bt_gatt_client *client, bool gm=
cs,
      |                ^~~~~~~~~~~~~
profiles/audio/mcp.c:329:9: error: implicit declaration of function
=E2=80=98bt_mcp_set_event_callbacks=E2=80=99 [-Wimplicit-function-declarati=
on]
  329 |         bt_mcp_set_event_callbacks(data->mcp, &cbs, data->mp);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/mcp.c: In function =E2=80=98media_control_server_probe=E2=80=
=99:
profiles/audio/mcp.c:372:9: error: implicit declaration of function
=E2=80=98bt_mcp_register=E2=80=99; did you mean =E2=80=98bt_mcs_register=E2=
=80=99?
[-Wimplicit-function-declaration]
  372 |         bt_mcp_register(btd_gatt_database_get_db(database));
      |         ^~~~~~~~~~~~~~~
      |         bt_mcs_register
profiles/audio/mcp.c: At top level:
profiles/audio/mcp.c:183:43: error: storage size of =E2=80=98cbs=E2=80=99 i=
sn=E2=80=99t known
  183 | static const struct bt_mcp_event_callback cbs =3D {
      |                                           ^~~
cc1: all warnings being treated as errors

It looks like it is only fixed in the follow up changes, which means
it breaks the likes of bisect.

--=20
Luiz Augusto von Dentz
