Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C123F86F4
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 18:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300910; cv=pass; b=QzbePd5oahrU9kJQDwuIQ5XByG7Je64SUklQSJOK+Zwg8V5/dxtA7MW4TyrOzNAiDS7bHMIZnVkJIasjtfLDm+UfoVFErDXvUD+BDjJunEItbmVrBkJcOqcLhuEiEe7ZvSIEpXm6SYMvuLRk1mMy+klWgDSt77bnUj/weh5H364=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300910; c=relaxed/simple;
	bh=hCo79N+1ARBg/5dhs7yL4SQpc+9Y4WIosdD49e5v5y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FhPhE36P3wysTRZ2es0odLlR1l2tW1gha+KJpqCm/GE4z1srRqRQm6RYd794ZvdYhFiPNwajHsLVpT6uE5i8/vZ/bBS9dl6DTAtwoQVLlZmGGzedL8oRqDopqSFdeWx8ih8cl0hRVlXj+LFHuakMmnzIYd86yiQ+gdNGcVd4Uis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0/eGm2+; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0/eGm2+"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-65c37eafcbeso5678276d50.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 11:15:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779300907; cv=none;
        d=google.com; s=arc-20240605;
        b=QSmMim9r7IvrVyeuLLkkpzrcJ5UIYVqiFzrLRA4MiFTbz+K0UNp+PIOv1CAlWMPUtJ
         v0STEZBF+8fuT6P76E1JfyZGUDc9iD5eR5VIosEsIa4qHBVGGY1seNnd/GsXxPJSb9/0
         PsKpLzGARHMPPbmTAwAv7mpDtxrVuZg8JB8jYhIozilXzWyb+tiVIoVI6IWK2N205QVg
         1GWfKCkJ33Rx3DjdEfKmOs9D8cXxcWU8moiueTW0/8GkafmwhQk/xvLN51sS3tQHV+fK
         P8i8HeSg9As5H89JjTEb4OY8rTYMAitcH/wbdCB0jbx+IVfulqKD35yYFkOQA/R+6UHz
         OwxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FYyTA0/bqM+UJglXXAMTjU7rJ2Q0wawFhxb03Y1y+/o=;
        fh=jBLUrRQ7ZsNUcAcd5QG5N83k8jhBNkoqDFBeOlOjxqk=;
        b=OfezT+vYYMDpgcDnhzhzqIJhKzlvqIVTMdDbtIEJZBWg6YYumo/qGyrr/qM3RjRBsu
         zrHQkKvHpycP50UhQq8WAl/ToecS4NCB6M2b5BYtfH5o4Z6DHmnpv8ooG+rrfN0I2Cap
         UebrTfAUAORs8aM6fN0Fz+9VRP1rRdH5a6XZBnl7UNS8aMqntJ2T2mpfLZf6Jfa3mKv0
         O7TBoAsQ1o1NzfHtvcu3WdGX+aZ3eNf6oyeEWIlDB/pNDFB0YzB+uxmFnOsdHSzj7Fll
         AjWGx3b4uaAhmpvwS/rqvFbsnRyPQou63oJNo3zJNnaIjkTVHivv8ZRWTlSleDoibeUG
         Dopg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779300907; x=1779905707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYyTA0/bqM+UJglXXAMTjU7rJ2Q0wawFhxb03Y1y+/o=;
        b=h0/eGm2+qzKD+d5pE3kuMsrZH8mzNAt4vDtjbYjArwBzgSv+rYY4l+eDvpl9fLfJZQ
         vckhN0HY1ZvZirw7ysSAs0nHcNw7VArsPSnnCtDAQXvcIxUCMHu+355E14QZNMAOoXyT
         efZzqb8/b+PDhNKo0whMavgOwJM7Z6qfNL66zHOfE5fFup10xUy8cset6o11oyYQSDg4
         DAmTvDY39OFwoWRovF4eSa3pDamcuxVOmpWYJuCnMwZDDdRV5hWpqXeFVfh/8R+n7bA1
         R2eWz0crKrK76tT/9OsYbVojXaZ37Y8k6yUYc1cUnfa7M44yrFmuN2XySNB2h154wQKe
         GuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779300907; x=1779905707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FYyTA0/bqM+UJglXXAMTjU7rJ2Q0wawFhxb03Y1y+/o=;
        b=J6rCBNz/iG2rO+zpPbQ++n81MsLhyO598+g6z1n/yRqbFqENLBBn3iuhG9xFpX4ntZ
         vy88W2DkdEpfbuL8vLk6Y3FME+2nMCxtKk5frPKSsBJtDoEm+4A/E5Nof1lobXR+yBwX
         F7jTgO29xIasceDtZlckCHPQtkrreQjJdABlib9Id7v/B8i9VXOfr0XmnH4Ex3ScQT85
         uZDcDkKGzpV7a/F+Eyh8Gz14nSV9wwB44ey7Abjcv5mmnOo6oOpwOrlvrlBidGPQC0d+
         1oZ0GVDq42efP+w5ebSBLuv5VVjt+OllFzRJN7c5kxQgEqTBD5p788NlYpiIByZPwvYp
         wR9w==
X-Gm-Message-State: AOJu0Yyx1/MiqW4Se4yWHIqM3L2yyY/HbhReVD+iq3lsJ7MA+7gbqMO5
	yq0yw+6cVjEQFZlkFtCNtZT5+YgzfL8x9kBrNXsGmozdYBQfuhCcDH1DH6SQ2plNu2KRnAMQe93
	1UdHRsB3irypn9aQvvQAByBB3xsEpAB4=
X-Gm-Gg: Acq92OHTpvim9Vct1RcP6xsFELCSslhsCPXbEhUhtr6he/M8hcatu9qx/rJEG+YOzja
	zHmtnJ2m30GzV3FYnHmKSK8UMvvUXb/oFAvOMzA727cZO0keO0sfxEy+YHtdkLuJywOKr5d6P8f
	FV1qCslsQdV1rAfPYZ/bLW907NXX6DhG1E576+aXfgy4o5sgUSkFp/wfxoiy+MohTLj/NFr2lxo
	qHDQeN/OSV+Zf457U+18HVzYxISJaKKLGO5IyDy5g9VS4YDoHyiHj8qsRkdpGv7YjNHjx6j6Ctc
	JulmLAP5N5qZbVU9ZmemvGGangTRWTZ8AdgYxmDL9Z+J8ZKGnXNqhKqrisOFsKLcGce73acfJ5v
	NdA==
X-Received: by 2002:a53:accd:0:20b0:651:97ba:8507 with SMTP id
 956f58d0204a3-65e2289b759mr21238212d50.59.1779300906769; Wed, 20 May 2026
 11:15:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520163037.1823823-1-prathm@qti.qualcomm.com>
In-Reply-To: <20260520163037.1823823-1-prathm@qti.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 May 2026 14:14:54 -0400
X-Gm-Features: AVHnY4KrjiU7KsLMh4k-6E1Hmqx0uKikTtv7vKjqbxZ3Z4BZU9uWet0zX9z-joM
Message-ID: <CABBYNZLPPS2oak=aei9FVzksCSWP7gTJVZu+TGkJbRT7r_Ny0Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1] shared/rap: Add client real-time ranging
 registration and notification parsing
To: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prathibha,

On Wed, May 20, 2026 at 12:30=E2=80=AFPM Prathibha Madugonde
<prathibha.madugonde@oss.qualcomm.com> wrote:
>
> From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
>
> Read the RAS Features characteristic to determine whether the remote
> device supports real-time ranging. If supported, register for real-time
> characteristic notifications using the reqtracker for the CS initiator
> role.
>
> Parse incoming segmented RAS ranging data notifications by accumulating
> segments via iovec and parsing complete subevent headers and CS mode 0-3
> step data, including IQ/tone PCT samples, once the last segment arrives.
> ---
>  src/shared/rap.c | 967 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 965 insertions(+), 2 deletions(-)
>
> diff --git a/src/shared/rap.c b/src/shared/rap.c
> index 145da2060..eabc6d543 100644
> --- a/src/shared/rap.c
> +++ b/src/shared/rap.c
> @@ -29,6 +29,9 @@
>  #define DBG(_rap, fmt, ...) \
>         rap_debug(_rap, "%s:%s() " fmt, __FILE__, __func__, ##__VA_ARGS__=
)
>
> +#define SIGN_EXTEND_TO_16(val, bits) \
> +       ((int16_t)(((val) ^ (1U << ((bits)-1))) - (1U << ((bits)-1))))
> +
>  #define RAS_UUID16                     0x185B
>
>  /* Total number of attribute handles reserved for the RAS service */
> @@ -43,6 +46,11 @@
>  #define RAS_STEP_ABORTED_BIT   0x80/* set step aborted */
>  #define RAS_SUBEVENT_HEADER_SIZE 8
>
> +#define CS_MODE_ZERO_WIRE_INIT_SIZE 7
> +#define CS_MODE_ZERO_WIRE_REF_SIZE 3
> +#define CS_MODE_ONE_WIRE_SIZE_MIN 6
> +#define CS_MODE_ONE_WIRE_SIZE_MAX 12
> +
>  enum pct_format {
>         IQ =3D 0,
>         PHASE =3D 1,
> @@ -134,6 +142,28 @@ static inline void ranging_header_set_pct_format(str=
uct ranging_header *hdr,
>                                 ((format & 0x03) << 6);
>  }
>
> +static inline uint8_t ranging_header_get_antenna_mask(
> +                                       const struct ranging_header *hdr)
> +{
> +       if (!hdr)
> +               return 0;
> +
> +       return hdr->antenna_pct & 0x0F;
> +}
> +
> +static inline uint8_t antenna_mask_count_paths(uint8_t antenna_mask)
> +{
> +       uint8_t count =3D 0;
> +       uint8_t i;
> +
> +       for (i =3D 0; i < 4; i++) {
> +               if (antenna_mask & (1u << i))
> +                       count++;
> +       }
> +
> +       return count;
> +}
> +
>  struct ras_subevent_header {
>         uint16_t start_acl_conn_event;
>         uint16_t frequency_compensation;
> @@ -149,9 +179,21 @@ struct ras_subevent_header {
>  #define RAS_DONE_STATUS_PACK(ranging, subevent) \
>         ((uint8_t)(((ranging) & 0x0F) | (((subevent) & 0x0F) << 4)))
>
> +#define RAS_DONE_STATUS_UNPACK_RANGING(packed) \
> +       ((uint8_t)((packed) & 0x0F))
> +
> +#define RAS_DONE_STATUS_UNPACK_SUBEVENT(packed) \
> +       ((uint8_t)(((packed) >> 4) & 0x0F))
> +
>  #define RAS_ABORT_REASON_PACK(ranging, subevent) \
>         ((uint8_t)(((ranging) & 0x0F) | (((subevent) & 0x0F) << 4)))
>
> +#define RAS_ABORT_REASON_UNPACK_RANGING(packed) \
> +       ((uint8_t)((packed) & 0x0F))
> +
> +#define RAS_ABORT_REASON_UNPACK_SUBEVENT(packed) \
> +       ((uint8_t)(((packed) >> 4) & 0x0F))
> +
>  struct ras_subevent {
>         struct ras_subevent_header subevent_header;
>         uint8_t subevent_data[];
> @@ -206,6 +248,11 @@ struct cstracker {
>         uint16_t last_start_acl_conn_evt_counter;
>         uint16_t last_freq_comp;
>         int8_t last_ref_pwr_lvl;
> +
> +       /* Client - first segment carries this */
> +       struct ranging_header   ranging_header_;
> +       /* Client - subsequent segments appended using iovec */
> +       struct iovec segment_data;
>  };
>
>  /* Ranging Service context */
> @@ -254,6 +301,7 @@ struct bt_rap {
>         void *debug_data;
>         void *user_data;
>         struct cstracker *resptracker;
> +       struct cstracker *reqtracker;
>  };
>
>  static struct queue *rap_db;
> @@ -274,6 +322,28 @@ struct bt_rap_ready {
>         void *data;
>  };
>
> +typedef void (*rap_notify_t)(struct bt_rap *rap, uint16_t value_handle,
> +                       const uint8_t *value, uint16_t length,
> +                       void *user_data);
> +
> +struct bt_rap_notify {
> +       unsigned int id;
> +       struct bt_rap *rap;
> +       rap_notify_t func;
> +       void *user_data;
> +};
> +
> +typedef void (*rap_func_t)(struct bt_rap *rap, bool success,
> +                       uint8_t att_ecode, const uint8_t *value,
> +                       uint16_t length, void *user_data);
> +
> +struct bt_rap_pending {
> +       unsigned int id;
> +       struct bt_rap *rap;
> +       rap_func_t func;
> +       void *userdata;
> +};
> +
>  uint16_t default_ras_mtu =3D 247; /*Section 3.1.2 of RAP 1.0*/
>  uint8_t ras_segment_header_size =3D 1;
>
> @@ -542,6 +612,11 @@ static void rap_free(void *data)
>                 rap->resptracker =3D NULL;
>         }
>
> +       if (rap->reqtracker) {
> +               free(rap->reqtracker);
> +               rap->reqtracker =3D NULL;
> +       }
> +
>         queue_destroy(rap->notify, free);
>         queue_destroy(rap->pending, NULL);
>         queue_destroy(rap->ready_cbs, rap_ready_free);
> @@ -641,6 +716,12 @@ static void cs_tracker_init(struct cstracker *t)
>         t->last_start_acl_conn_evt_counter =3D 0;
>         t->last_freq_comp =3D 0;
>         t->last_ref_pwr_lvl =3D 0;
> +
> +       /* Initialize ranging header using helper functions */
> +       memset(&t->ranging_header_, 0, sizeof(t->ranging_header_));
> +       /* Initialize segment accumulator */
> +       t->segment_data.iov_base =3D NULL;
> +       t->segment_data.iov_len =3D 0;
>  }
>
>  static void ras_features_read_cb(struct gatt_db_attribute *attrib,
> @@ -1698,6 +1779,46 @@ static void form_ras_data_with_cs_subevent_result_=
cont(struct bt_rap *rap,
>                 cont->step_data);
>  }
>
> +static void fill_initiator_data_from_cs_subevent_result_cont(struct bt_r=
ap *rap,
> +               const struct rap_ev_cs_subevent_result_cont *cont,
> +               uint16_t length)
> +{
> +       size_t base_len =3D offsetof(struct rap_ev_cs_subevent_result_con=
t,
> +                                       step_data);
> +       struct cstracker *reqtracker;
> +
> +       if (!rap || !rap->reqtracker || !cont)
> +               return;
> +
> +       if (length < base_len)
> +               return;
> +
> +       DBG(rap, "Received CS subevent result continue subevent: len=3D%d=
",
> +               length);
> +
> +       reqtracker =3D rap->reqtracker;
> +
> +}
> +
> +static void fill_initiator_data_from_cs_subevent_result(struct bt_rap *r=
ap,
> +               const struct rap_ev_cs_subevent_result *data,
> +               uint16_t length)
> +{
> +       size_t base_len =3D offsetof(struct rap_ev_cs_subevent_result,
> +                                       step_data);
> +
> +       if (!rap || !rap->reqtracker || !data)
> +               return;
> +
> +       /* Defensive check: base header must be present */
> +       if (length < base_len)
> +               return;
> +
> +       DBG(rap, "Received CS subevent result subevent: len=3D%d", length=
);
> +
> +
> +}
> +
>  void bt_rap_hci_cs_subevent_result_cont_callback(uint16_t length,
>                                                 const void *param,
>                                                 void *user_data)
> @@ -1707,7 +1828,12 @@ void bt_rap_hci_cs_subevent_result_cont_callback(u=
int16_t length,
>
>         DBG(rap, "Received CS subevent CONT: len=3D%d", length);
>
> -       form_ras_data_with_cs_subevent_result_cont(rap, cont, length);
> +       if (rap->resptracker->role =3D=3D CS_REFLECTOR)
> +               form_ras_data_with_cs_subevent_result_cont(rap, cont, len=
gth);
> +
> +       if (rap->reqtracker->role =3D=3D CS_INITIATOR)
> +               fill_initiator_data_from_cs_subevent_result_cont(rap, con=
t,
> +                                                               length);
>  }
>
>  void bt_rap_hci_cs_subevent_result_callback(uint16_t length,
> @@ -1720,7 +1846,11 @@ void bt_rap_hci_cs_subevent_result_callback(uint16=
_t length,
>         DBG(rap, "Received CS subevent: len=3D%d", length);
>
>         /* Populate CsProcedureData and send RAS payload */
> -       form_ras_data_with_cs_subevent_result(rap, data, length);
> +       if (rap->resptracker->role =3D=3D CS_REFLECTOR)
> +               form_ras_data_with_cs_subevent_result(rap, data, length);
> +
> +       if (rap->reqtracker->role =3D=3D CS_INITIATOR)
> +               fill_initiator_data_from_cs_subevent_result(rap, data, le=
ngth);
>  }
>
>  void bt_rap_hci_cs_procedure_enable_complete_callback(uint16_t length,
> @@ -1763,6 +1893,7 @@ void bt_rap_hci_cs_config_complete_callback(uint16_=
t length,
>         const struct rap_ev_cs_config_cmplt *data =3D param;
>         struct bt_rap *rap =3D user_data;
>         struct cstracker *resptracker;
> +       struct cstracker *reqtracker;
>
>         if (!rap)
>                 return;
> @@ -1781,6 +1912,19 @@ void bt_rap_hci_cs_config_complete_callback(uint16=
_t length,
>         resptracker->config_id =3D data->config_id;
>         resptracker->role =3D data->role;
>         resptracker->rtt_type =3D data->rtt_type;
> +
> +       if (!rap->reqtracker) {
> +               reqtracker =3D new0(struct cstracker, 1);
> +               cs_tracker_init(reqtracker);
> +               rap->reqtracker =3D reqtracker;
> +       }
> +
> +       reqtracker =3D rap->reqtracker;
> +
> +       /* Basic fields */
> +       reqtracker->config_id =3D data->config_id;
> +       reqtracker->role =3D data->role;
> +       reqtracker->rtt_type =3D data->rtt_type;
>  }
>
>  struct bt_rap *bt_rap_new(struct gatt_db *ldb, struct gatt_db *rdb)
> @@ -1815,6 +1959,821 @@ done:
>         return rap;
>  }
>
> +static void ras_pending_destroy(void *data)
> +{
> +       struct bt_rap_pending *pending =3D data;
> +       struct bt_rap *rap =3D pending->rap;
> +
> +       if (queue_remove_if(rap->pending, NULL, pending))
> +               free(pending);
> +}
> +
> +static void ras_pending_complete(bool success, uint8_t att_ecode,
> +                               const uint8_t *value, uint16_t length,
> +                               void *user_data)
> +{
> +       struct bt_rap_pending *pending =3D user_data;
> +
> +       if (pending->func)
> +               pending->func(pending->rap, success, att_ecode, value, le=
ngth,
> +                                         pending->userdata);
> +}
> +
> +static void rap_read_value(struct bt_rap *rap, uint16_t value_handle,
> +                          rap_func_t func, void *user_data)
> +{
> +       struct bt_rap_pending *pending;
> +
> +       pending =3D new0(struct bt_rap_pending, 1);
> +       pending->rap =3D rap;
> +       pending->func =3D func;
> +       pending->userdata =3D user_data;
> +
> +       pending->id =3D bt_gatt_client_read_value(rap->client, value_hand=
le,
> +                                               ras_pending_complete, pen=
ding,
> +                                               ras_pending_destroy);
> +       if (!pending->id) {
> +               DBG(rap, "Unable to send Read request");
> +               free(pending);
> +               return;
> +       }
> +
> +       queue_push_tail(rap->pending, pending);
> +}
> +
> +static void ras_register(uint16_t att_ecode, void *user_data)
> +{
> +       struct bt_rap_notify *notify =3D user_data;
> +
> +       if (att_ecode)
> +               DBG(notify->rap, "RAS register failed 0x%04x", att_ecode)=
;
> +
> +       (void)notify;
> +}
> +
> +static void rap_notify(uint16_t value_handle, const uint8_t *value,
> +                               uint16_t length, void *user_data)
> +{
> +       struct bt_rap_notify *notify =3D user_data;
> +
> +       if (notify->func)
> +               notify->func(notify->rap, value_handle, value, length,
> +                                        notify->user_data);
> +}
> +
> +static void rap_notify_destroy(void *data)
> +{
> +       struct bt_rap_notify *notify =3D data;
> +       struct bt_rap *rap =3D notify->rap;
> +
> +       if (queue_remove_if(rap->notify, NULL, notify))
> +               free(notify);
> +}
> +
> +static unsigned int bt_rap_register_notify(struct bt_rap *rap,
> +                                       uint16_t value_handle,
> +                                       rap_notify_t func,
> +                                       void *user_data)
> +{
> +       struct bt_rap_notify *notify;
> +
> +       notify =3D new0(struct bt_rap_notify, 1);
> +       notify->rap =3D rap;
> +       notify->func =3D func;
> +       notify->user_data =3D user_data;
> +
> +       DBG(rap, "register for notifications");
> +
> +       notify->id =3D bt_gatt_client_register_notify(rap->client,
> +                                       value_handle, ras_register,
> +                                       rap_notify, notify,
> +                                       rap_notify_destroy);
> +       if (!notify->id) {
> +               DBG(rap, "Unable to register for notifications");
> +               free(notify);
> +               return 0;
> +       }
> +
> +       queue_push_tail(rap->notify, notify);
> +
> +       return notify->id;
> +}
> +
> +static inline bool parse_segmentation_header(struct iovec *iov,
> +                                            struct segmentation_header *=
s)
> +{
> +       uint8_t byte;
> +
> +       if (!util_iov_pull_u8(iov, &byte))
> +               return false;
> +
> +       s->first_segment =3D (byte & 0x01) ? 1 : 0;
> +       s->last_segment =3D (byte & 0x02) ? 1 : 0;
> +       s->rolling_segment_counter =3D (byte >> 2) & 0x3F;
> +
> +       return true;
> +}
> +
> +static void parse_i_q_sample(struct iovec *iov, int16_t *i_sample,
> +                               int16_t *q_sample)
> +{
> +       uint32_t buffer;
> +       uint32_t i12;
> +       uint32_t q12;
> +
> +       if (!util_iov_pull_le24(iov, &buffer)) {
> +               *i_sample =3D 0;
> +               *q_sample =3D 0;
> +               return;
> +       }
> +
> +       i12 =3D  buffer        & 0x0FFFU;   /* bits 0..11 */
> +       q12 =3D (buffer >> 12) & 0x0FFFU;   /* bits 12..23 */
> +
> +       *i_sample =3D SIGN_EXTEND_TO_16(i12, 12);
> +       *q_sample =3D SIGN_EXTEND_TO_16(q12, 12);
> +}
> +
> +static size_t get_mode_zero_length(enum cs_role remote_role)
> +{
> +       return (remote_role =3D=3D CS_ROLE_INITIATOR) ?
> +               CS_MODE_ZERO_WIRE_INIT_SIZE :
> +               CS_MODE_ZERO_WIRE_REF_SIZE;
> +}
> +
> +static void parse_mode_zero(struct bt_rap *rap, struct iovec *mode_iov,
> +                           enum cs_role remote_role)
> +{
> +       uint8_t packet_quality;
> +       int8_t packet_rssi_dbm;
> +       uint8_t packet_ant;
> +       uint32_t init_measured_freq_offset =3D 0;
> +
> +       if (!util_iov_pull_u8(mode_iov, &packet_quality) ||
> +           !util_iov_pull_u8(mode_iov, (uint8_t *)&packet_rssi_dbm) ||
> +           !util_iov_pull_u8(mode_iov, &packet_ant)) {
> +               DBG(rap, "Mode 0: failed to parse common fields");
> +               return;
> +       }
> +
> +       if (remote_role =3D=3D CS_ROLE_INITIATOR) {
> +               if (!util_iov_pull_le32(mode_iov, &init_measured_freq_off=
set)) {
> +                       DBG(rap, "Mode 0: failed to parse freq offset");
> +                       return;
> +               }
> +       }
> +
> +       if (remote_role =3D=3D CS_ROLE_INITIATOR) {
> +               DBG(rap, "    cs_mode_zero_data (INITIATOR): "
> +                       "Packet_Quality=3D%u Packet_RSSI=3D%d "
> +                       "Packet_Antenna=3D%u Measured_Freq_Offset=3D%u",
> +                       packet_quality,
> +                       packet_rssi_dbm,
> +                       packet_ant,
> +                       init_measured_freq_offset);
> +       } else {
> +               DBG(rap, "    cs_mode_zero_data (REFLECTOR): "
> +                       "Packet_Quality=3D%u Packet_RSSI=3D%d "
> +                       "Packet_Antenna=3D%u",
> +                       packet_quality,
> +                       packet_rssi_dbm,
> +                       packet_ant);
> +       }
> +}
> +
> +static size_t get_mode_one_length(bool include_pct)
> +{
> +       if (include_pct)
> +               return CS_MODE_ONE_WIRE_SIZE_MAX;
> +       return CS_MODE_ONE_WIRE_SIZE_MIN;
> +}
> +
> +static void parse_mode_one(struct bt_rap *rap, struct iovec *mode_iov,
> +                          enum cs_role remote_role, bool include_pct)
> +{
> +       uint8_t packet_quality;
> +       uint8_t packet_nadm;
> +       int8_t packet_rssi_dbm;
> +       int16_t time_value;
> +       uint8_t packet_ant;
> +       int16_t pct1_i =3D 0, pct1_q =3D 0;
> +       int16_t pct2_i =3D 0, pct2_q =3D 0;
> +
> +       /* Parse fixed fields (6 bytes) using util_iov_pull_* */
> +       if (!util_iov_pull_u8(mode_iov, &packet_quality) ||
> +           !util_iov_pull_u8(mode_iov, &packet_nadm) ||
> +           !util_iov_pull_u8(mode_iov, (uint8_t *)&packet_rssi_dbm) ||
> +           !util_iov_pull_le16(mode_iov, (uint16_t *)&time_value) ||
> +           !util_iov_pull_u8(mode_iov, &packet_ant)) {
> +               DBG(rap, "Mode 1: failed to parse fixed fields");
> +               return;
> +       }
> +
> +       /* Parse optional PCT fields using parse_i_q_sample */
> +       if (include_pct) {
> +               parse_i_q_sample(mode_iov, &pct1_i, &pct1_q);
> +               parse_i_q_sample(mode_iov, &pct2_i, &pct2_q);
> +       }
> +
> +       if (remote_role =3D=3D CS_ROLE_INITIATOR) {
> +               DBG(rap, "    cs_mode_one_data (INITIATOR): "
> +                       "Packet_Quality=3D%u Packet_NADM=3D%u "
> +                       "Packet_RSSI=3D%d ToA_ToD_Initiator=3D0x%4.4x "
> +                       "Packet_Antenna=3D%u",
> +                       packet_quality,
> +                       packet_nadm,
> +                       packet_rssi_dbm,
> +                       time_value,
> +                       packet_ant);
> +               if (include_pct) {
> +                       DBG(rap, "    cs_mode_one_data (INITIATOR): "
> +                               "Packet_PCT1(I=3D0x%3.3x,Q=3D0x%3.3x) "
> +                               "Packet_PCT2(I=3D0x%3.3x,Q=3D0x%3.3x)",
> +                               pct1_i, pct1_q,
> +                               pct2_i, pct2_q);
> +               }
> +       } else {
> +               DBG(rap, "    cs_mode_one_data (REFLECTOR): "
> +                       "Packet_Quality=3D%u Packet_NADM=3D%u "
> +                       "Packet_RSSI=3D%d ToD_ToA_Reflector=3D0x%4.4x  "
> +                       "Packet_Antenna=3D%u",
> +                       packet_quality,
> +                       packet_nadm,
> +                       packet_rssi_dbm,
> +                       time_value,
> +                       packet_ant);
> +               if (include_pct) {
> +                       DBG(rap, "    cs_mode_one_data (REFLECTOR): "
> +                               "Packet_PCT1(I=3D0x%3.3x,Q=3D0x%3.3x) "
> +                               "Packet_PCT2(I=3D0x%3.3x,Q=3D0x%3.3x)",
> +                               pct1_i, pct1_q,
> +                               pct2_i, pct2_q);
> +               }
> +       }
> +}
> +
> +static size_t get_mode_two_length(uint8_t num_antenna_paths)
> +{
> +       uint8_t num_tone_data =3D num_antenna_paths + 1;
> +
> +       return 1 + (4 * num_tone_data);
> +}
> +
> +static void parse_mode_two(struct bt_rap *rap, struct iovec *mode_iov)
> +{
> +       uint8_t ant_perm_index;
> +       int16_t tone_pct_i[5];
> +       int16_t tone_pct_q[5];
> +       uint8_t tone_quality[5];
> +       uint8_t k;
> +       uint8_t max_paths =3D 5;
> +
> +       if (!util_iov_pull_u8(mode_iov, &ant_perm_index)) {
> +               DBG(rap, "Mode 2: failed to parse ant_perm_index");
> +               return;
> +       }
> +
> +       for (k =3D 0; k < max_paths; k++) {
> +               int16_t i_val, q_val;
> +
> +               if (mode_iov->iov_len < 4) {
> +                       DBG(rap, "Mode 2: insufficient PCT for "
> +                               "path %u (rem=3D%zu)",
> +                               k, mode_iov->iov_len);
> +                       break;
> +               }
> +               parse_i_q_sample(mode_iov, &i_val, &q_val);
> +               tone_pct_i[k] =3D i_val;
> +               tone_pct_q[k] =3D q_val;
> +
> +               util_iov_pull_u8(mode_iov, &tone_quality[k]);
> +               DBG(rap, "tone_quality_indicator : %d",
> +                       tone_quality[k]);
> +               DBG(rap, "[i, q] : %d, %d",
> +                       tone_pct_i[k],
> +                       tone_pct_q[k]);
> +       }
> +
> +       DBG(rap, "    cs_mode_two_data: ant_perm_idx=3D%u",
> +               ant_perm_index);
> +       for (k =3D 0; k < max_paths; k++) {
> +               DBG(rap, "      tone[%u]: pct(I=3D0x%3.3x,Q=3D0x%3.3x) qu=
ality=3D%u",
> +                       k,
> +                       tone_pct_i[k],
> +                       tone_pct_q[k],
> +                       tone_quality[k]);
> +       }
> +}
> +
> +static size_t get_mode_three_length(uint8_t num_antenna_paths, bool incl=
ude_pct)
> +{
> +       uint8_t num_tone_data =3D num_antenna_paths + 1;
> +       size_t len;
> +
> +       /* Mode 1 portion: 6 bytes base + optional 6 bytes PCT */
> +       len =3D 6;
> +       if (include_pct)
> +               len +=3D 6;
> +
> +       /* Mode 2 portion: 1 byte antenna index + 4 bytes per tone */
> +       len +=3D 1 + (4 * num_tone_data);
> +
> +       return len;
> +}
> +
> +static void parse_mode_three(struct bt_rap *rap, struct iovec *mode_iov,
> +                            enum cs_role remote_role, bool include_pct)
> +{
> +       uint8_t packet_quality;
> +       uint8_t packet_nadm;
> +       int8_t packet_rssi_dbm;
> +       int16_t time_value;
> +       uint8_t packet_ant;
> +       int16_t pct1_i =3D 0, pct1_q =3D 0;
> +       int16_t pct2_i =3D 0, pct2_q =3D 0;
> +       uint8_t ant_perm_index;
> +       int16_t tone_pct_i[5];
> +       int16_t tone_pct_q[5];
> +       uint8_t tone_quality[5];
> +       uint8_t k;
> +       uint8_t max_paths =3D 5;
> +
> +       /* Parse Mode 1 portion (6 or 12 bytes) */
> +       if (!util_iov_pull_u8(mode_iov, &packet_quality) ||
> +           !util_iov_pull_u8(mode_iov, &packet_nadm) ||
> +           !util_iov_pull_u8(mode_iov, (uint8_t *)&packet_rssi_dbm) ||
> +           !util_iov_pull_le16(mode_iov, (uint16_t *)&time_value) ||
> +           !util_iov_pull_u8(mode_iov, &packet_ant)) {
> +               DBG(rap, "Mode 3: failed to parse Mode 1 fixed fields");
> +               return;
> +       }
> +
> +       /* Parse optional PCT fields using new logic */
> +       if (include_pct) {
> +               parse_i_q_sample(mode_iov, &pct1_i, &pct1_q);
> +               parse_i_q_sample(mode_iov, &pct2_i, &pct2_q);
> +       }
> +
> +       /* Parse Mode 2 portion - antenna permutation index */
> +       if (!util_iov_pull_u8(mode_iov, &ant_perm_index)) {
> +               DBG(rap, "Mode 3: failed to parse ant_perm_index");
> +               return;
> +       }
> +
> +       /* Parse tone paths using new logic */
> +       for (k =3D 0; k < max_paths; k++) {
> +               int16_t i_val, q_val;
> +
> +               if (mode_iov->iov_len < 4) {
> +                       DBG(rap, "Mode 3: insufficient PCT for "
> +                               "path %u (rem=3D%zu)",
> +                               k, mode_iov->iov_len);
> +                       break;
> +               }

There should be empty lines after an if block.

> +               parse_i_q_sample(mode_iov, &i_val, &q_val);
> +               tone_pct_i[k] =3D i_val;
> +               tone_pct_q[k] =3D q_val;
> +
> +               util_iov_pull_u8(mode_iov, &tone_quality[k]);
> +               DBG(rap, "tone_quality_indicator : %d",
> +                       tone_quality[k]);
> +               DBG(rap, "[i, q] : %d, %d",
> +                       tone_pct_i[k],
> +                       tone_pct_q[k]);
> +       }
> +
> +       if (remote_role =3D=3D CS_ROLE_INITIATOR) {
> +               DBG(rap, "    cs_mode_three_data (INITIATOR): "
> +                       "Packet_Quality=3D%u Packet_NADM=3D%u "
> +                       "Packet_RSSI=3D%d ToA_ToD_Initiator=3D0x%4.4x "
> +                       "Packet_Antenna=3D%u",
> +                       packet_quality,
> +                       packet_nadm,
> +                       packet_rssi_dbm,
> +                       time_value,
> +                       packet_ant);
> +               if (include_pct) {
> +                       DBG(rap, "    cs_mode_three_data (INITIATOR): "
> +                               "Packet_PCT1(I=3D0x%3.3x,Q=3D0x%3.3x) "
> +                               "Packet_PCT2(I=3D0x%3.3x,Q=3D0x%3.3x)",
> +                               pct1_i, pct1_q,
> +                               pct2_i, pct2_q);
> +               }
> +               DBG(rap, "    cs_mode_three_data (INITIATOR): "
> +                       "Antenna_Permutation_Index=3D%u",
> +                       ant_perm_index);
> +               for (k =3D 0; k < max_paths; k++) {
> +                       DBG(rap, "      Tone_PCT[%u](I=3D0x%3.3x,Q=3D0x%3=
.3x) "
> +                               "Tone_Quality_Indicator[%u]=3D%u",
> +                               k,
> +                               tone_pct_i[k],
> +                               tone_pct_q[k],
> +                               k,
> +                               tone_quality[k]);

You are adding a lot of debugging, perhaps these should be disabled if
debug is disabled so we don't iterate if nothing will be printed.

> +               }
> +       } else {
> +               DBG(rap, "    cs_mode_three_data (REFLECTOR): "
> +                       "Packet_Quality=3D%u Packet_NADM=3D%u "
> +                       "Packet_RSSI=3D%d ToD_ToA_Reflector=3D0x%4.4x "
> +                       "Packet_Antenna=3D%u",
> +                       packet_quality,
> +                       packet_nadm,
> +                       packet_rssi_dbm,
> +                       time_value,
> +                       packet_ant);
> +               if (include_pct) {
> +                       DBG(rap, "    cs_mode_three_data (REFLECTOR): "
> +                               "Packet_PCT1(I=3D0x%3.3x,Q=3D0x%3.3x) "
> +                               "Packet_PCT2(I=3D0x%3.3x,Q=3D0x%3.3x)",
> +                               pct1_i, pct1_q,
> +                               pct2_i, pct2_q);
> +               }
> +               DBG(rap, "    cs_mode_three_data (REFLECTOR): "
> +                       "Antenna_Permutation_Index=3D%u",
> +                       ant_perm_index);
> +               for (k =3D 0; k < max_paths; k++) {
> +                       DBG(rap, "      Tone_PCT[%u](I=3D0x%3.3x,Q=3D0x%3=
.3x) "
> +                               "Tone_Quality_Indicator[%u]=3D%u",
> +                               k,
> +                               tone_pct_i[k],
> +                               tone_pct_q[k],
> +                               k,
> +                               tone_quality[k]);

Ditto, I just skip early if nothing will be done with this data.

> +               }
> +       }
> +}
> +
> +static void parse_ras_data_segments(struct bt_rap *rap,
> +                              struct cstracker *reqtracker)
> +{
> +       const uint8_t *buf;
> +       size_t buf_len;
> +       size_t offset =3D 0;
> +       uint8_t antenna_mask;
> +       uint8_t num_antenna_paths;
> +
> +       if (!rap || !reqtracker)
> +               return;
> +
> +       DBG(rap, "Complete RAS data received: %zu bytes",
> +           reqtracker->segment_data.iov_len);
> +
> +       /* Extract num_antenna_paths from ranging header */
> +       antenna_mask =3D
> +               ranging_header_get_antenna_mask(&reqtracker->ranging_head=
er_);
> +       num_antenna_paths =3D antenna_mask_count_paths(antenna_mask);
> +
> +       /* Validate complete RAS data structure before parsing */
> +       buf =3D (const uint8_t *)reqtracker->segment_data.iov_base;
> +       buf_len =3D reqtracker->segment_data.iov_len;

Ok, this is part sounds a little suspisus, using a pointer to validate
dat when it was already part of an iovec sound backwards to me, Id
trust a lot more if that would be done via iovec, you can just load
another local variable if you want to perform an extra step of
validating it, but if it just bounds checking then it should be
possible to perform it while parsing.

> +       /* Process all subevents in the accumulated buffer */
> +       while (offset + RAS_SUBEVENT_HEADER_SIZE <=3D buf_len) {
> +               struct ras_subevent_header subevt_hdr;
> +               const uint8_t *hdr =3D buf + offset;
> +               uint8_t done_byte;
> +               uint8_t abort_byte;
> +
> +               subevt_hdr.start_acl_conn_event =3D get_le16(hdr);
> +               subevt_hdr.frequency_compensation =3D
> +                       get_le16(hdr + 2);
> +
> +               done_byte =3D hdr[4];
> +               subevt_hdr.ranging_done_status =3D
> +                       RAS_DONE_STATUS_UNPACK_RANGING(done_byte);
> +               subevt_hdr.subevent_done_status =3D
> +                       RAS_DONE_STATUS_UNPACK_SUBEVENT(done_byte);
> +
> +               abort_byte =3D hdr[5];
> +               subevt_hdr.ranging_abort_reason =3D
> +                       RAS_ABORT_REASON_UNPACK_RANGING(abort_byte);
> +               subevt_hdr.subevent_abort_reason =3D
> +                       RAS_ABORT_REASON_UNPACK_SUBEVENT(abort_byte);
> +
> +               subevt_hdr.reference_power_level =3D (int8_t)hdr[6];
> +               subevt_hdr.num_steps_reported =3D hdr[7];
> +
> +               DBG(rap, "Parsed subevent: start_acl=3D%u "
> +                       "freq_comp=3D%d ref_pwr=3D%d steps=3D%u",
> +                   subevt_hdr.start_acl_conn_event,
> +                   subevt_hdr.frequency_compensation,
> +                   subevt_hdr.reference_power_level,
> +                   subevt_hdr.num_steps_reported);
> +
> +               offset +=3D RAS_SUBEVENT_HEADER_SIZE;
> +
> +               /* Parse step data for this subevent */
> +               for (uint8_t step_idx =3D 0;
> +                    step_idx < subevt_hdr.num_steps_reported;
> +                    step_idx++) {

Loops inside another another is already a sign this should be split
into helper functions so we avoid too many level of identation which
make it hard to read and very easy to hit 80 columns.

> +                       uint8_t mode_byte;
> +                       bool step_aborted;
> +                       uint8_t step_mode;
> +                       size_t step_payload_len =3D 0;
> +                       uint8_t rtt_type;
> +                       bool include_pct;
> +                       /* Determine remote role */
> +                       enum cs_role local_role =3D reqtracker->role;
> +                       enum cs_role remote_role =3D
> +                               (local_role =3D=3D CS_ROLE_INITIATOR) ?
> +                               CS_ROLE_REFLECTOR : CS_ROLE_INITIATOR;
> +
> +                       if (offset >=3D buf_len) {
> +                               DBG(rap, "Insufficient data for "
> +                                       "step %u", step_idx);
> +                               break;
> +                       }
> +
> +                       /* Parse: 1 byte mode + variable payload */
> +                       mode_byte =3D buf[offset++];
> +                       step_aborted =3D (mode_byte & RAS_STEP_ABORTED_BI=
T) !=3D 0;
> +                       step_mode =3D mode_byte & 0x7F;
> +
> +                       if (step_aborted) {
> +                               DBG(rap, "  Step %u: mode=3D%u "
> +                                       "(aborted)",
> +                                       step_idx, step_mode);
> +                               continue;
> +                       }
> +
> +                       /* Determine payload length and parse mode data *=
/
> +                       rtt_type =3D reqtracker->rtt_type;
> +                       include_pct =3D (rtt_type =3D=3D 0x01 || rtt_type=
 =3D=3D 0x02);
> +
> +                       switch (step_mode) {
> +                       case CS_MODE_ZERO:
> +                               step_payload_len =3D
> +                                       get_mode_zero_length(remote_role)=
;
> +                               break;
> +                       case CS_MODE_ONE:
> +                               step_payload_len =3D
> +                                       get_mode_one_length(include_pct);
> +                               break;
> +                       case CS_MODE_TWO:
> +                               step_payload_len =3D
> +                                       get_mode_two_length(num_antenna_p=
aths);
> +                               break;
> +                       case CS_MODE_THREE:
> +                               step_payload_len =3D
> +                                       get_mode_three_length(
> +                                               num_antenna_paths,
> +                                               include_pct);
> +                               break;
> +                       default:
> +                               DBG(rap, "  Step %u: unknown mode=3D%u",
> +                                       step_idx, step_mode);
> +                               step_payload_len =3D 0;
> +                               break;
> +                       }
> +
> +                       if (offset + step_payload_len > buf_len) {
> +                               DBG(rap, "Insufficient data for "
> +                                       "step %u payload (need %zu, have =
%zu)",
> +                                       step_idx, step_payload_len,
> +                                       buf_len - offset);
> +                               break;
> +                       }
> +
> +                       DBG(rap, "  Step %u: mode=3D%u payload_len=3D%zu"=
,
> +                           step_idx, step_mode, step_payload_len);
> +
> +                       /* Parse mode data if payload is present */
> +                       if (step_payload_len > 0) {
> +                               const uint8_t *payload_ptr =3D buf + offs=
et;
> +                               struct iovec mode_iov;
> +
> +                               mode_iov.iov_base =3D (void *)payload_ptr=
;
> +                               mode_iov.iov_len =3D step_payload_len;
> +
> +                               switch (step_mode) {
> +                               case CS_MODE_ZERO:
> +                                       parse_mode_zero(rap, &mode_iov,
> +                                                       remote_role);
> +                                       break;
> +                               case CS_MODE_ONE:
> +                                       parse_mode_one(rap, &mode_iov,
> +                                               remote_role, include_pct)=
;
> +                                       break;
> +                               case CS_MODE_TWO:
> +                                       parse_mode_two(rap, &mode_iov);
> +                                       break;
> +                               case CS_MODE_THREE:
> +                                       parse_mode_three(rap, &mode_iov,
> +                                               remote_role, include_pct)=
;
> +                                       break;
> +                               default:
> +                                       break;
> +                               }
> +
> +                               /* Skip payload */
> +                               offset +=3D step_payload_len;
> +                       }
> +               }
> +
> +               /* Check if this is the last subevent */
> +               if (subevt_hdr.subevent_done_status =3D=3D
> +                   SUBEVENT_DONE_ALL_RESULTS_COMPLETE ||
> +                   subevt_hdr.ranging_done_status =3D=3D
> +                   RANGING_DONE_ALL_RESULTS_COMPLETE) {
> +                       DBG(rap, "Ranging procedure complete");
> +                       break;
> +               }
> +       }
> +
> +       /* Clean up accumulator */
> +       free(reqtracker->segment_data.iov_base);
> +       reqtracker->segment_data.iov_base =3D NULL;
> +       reqtracker->segment_data.iov_len =3D 0;
> +}
> +
> +static bool process_first_segment(struct bt_rap *rap,
> +                                       struct cstracker *reqtracker,
> +                                       struct iovec *iov, bool last_segm=
ent)
> +{
> +       uint16_t counter_config_val;
> +       int8_t selected_tx_power;
> +       uint8_t antenna_pct;
> +
> +       if (!util_iov_pull_le16(iov, &counter_config_val) ||
> +           !util_iov_pull_u8(iov, (uint8_t *)&selected_tx_power) ||
> +           !util_iov_pull_u8(iov, &antenna_pct)) {
> +               DBG(rap, "First segment too short for ranging header");
> +               return false;
> +       }
> +
> +       ranging_header_set_counter(&reqtracker->ranging_header_,
> +                               counter_config_val & 0x0FFF);
> +       ranging_header_set_config_id(&reqtracker->ranging_header_,
> +                               (counter_config_val >> 12) & 0x0F);
> +       reqtracker->ranging_header_.selected_tx_power =3D selected_tx_pow=
er;
> +       reqtracker->ranging_header_.antenna_pct =3D antenna_pct;
> +
> +       DBG(rap, "First segment: parsed ranging header "
> +           "(counter=3D%u, config_id=3D%u, tx_pwr=3D%d)",
> +           counter_config_val & 0x0FFF,
> +           (counter_config_val >> 12) & 0x0F,
> +           selected_tx_power);
> +
> +       if (reqtracker->segment_data.iov_base) {
> +               free(reqtracker->segment_data.iov_base);
> +               reqtracker->segment_data.iov_base =3D NULL;
> +               reqtracker->segment_data.iov_len =3D 0;
> +       }
> +
> +       if (iov->iov_len > 0) {
> +               if (!util_iov_append(&reqtracker->segment_data,
> +                                       iov->iov_base, iov->iov_len)) {
> +                       DBG(rap, "Failed to initialize segment accumulato=
r");
> +                       return false;
> +               }
> +               DBG(rap, "First segment: initialized accumulator "
> +                   "with %zu bytes", iov->iov_len);
> +       }
> +
> +       if (!last_segment)
> +               return false;
> +
> +       DBG(rap, "Single-segment: first=3D1, last=3D1");
> +       return true;
> +}
> +
> +static void ras_realtime_notify_cb(struct bt_rap *rap, uint16_t value_ha=
ndle,
> +                                  const uint8_t *value, uint16_t length,
> +                                  void *user_data)
> +{
> +       struct iovec iov =3D { .iov_base =3D (void *)value, .iov_len =3D =
length };
> +       struct segmentation_header seg_hdr;
> +       struct cstracker *reqtracker;
> +
> +       if (!rap || !value || length =3D=3D 0) {
> +               DBG(rap, "Invalid notification data");
> +               return;
> +       }
> +
> +       DBG(rap, "Received real-time notification: handle=3D0x%04x len=3D=
%u",
> +           value_handle, length);
> +
> +       if (!parse_segmentation_header(&iov, &seg_hdr)) {
> +               DBG(rap, "Failed to parse segmentation header");
> +               return;
> +       }
> +
> +       DBG(rap, "Segment: first=3D%u last=3D%u counter=3D%u",
> +           seg_hdr.first_segment, seg_hdr.last_segment,
> +           seg_hdr.rolling_segment_counter);
> +
> +       if (!rap->reqtracker) {
> +               DBG(rap, "reqtracker is not initialised");
> +               return;
> +       }
> +
> +       reqtracker =3D rap->reqtracker;
> +
> +       if (seg_hdr.first_segment) {
> +               if (!process_first_segment(rap, reqtracker, &iov,
> +                                               seg_hdr.last_segment))
> +                       return;
> +       } else {
> +               if (iov.iov_len > 0) {
> +                       if (!util_iov_append(&reqtracker->segment_data,
> +                                               iov.iov_base, iov.iov_len=
)) {
> +                               DBG(rap, "Failed to append segment data")=
;
> +                               return;
> +                       }
> +                       DBG(rap, "Continuation segment: appended "
> +                           "%zu bytes (total=3D%zu)",
> +                           iov.iov_len,
> +                           reqtracker->segment_data.iov_len);
> +               }
> +       }
> +
> +       /* Last segment: parse complete RAS data */
> +       if (seg_hdr.last_segment)
> +               parse_ras_data_segments(rap, reqtracker);
> +}
> +
> +static void read_ras_features(struct bt_rap *rap, bool success,
> +                       uint8_t att_ecode,
> +                       const uint8_t *value, uint16_t length,
> +                       void *user_data)
> +{
> +       struct iovec iov =3D { .iov_base =3D (void *)value, .iov_len =3D =
length };
> +       uint32_t features =3D 0;
> +       struct ras *ras;
> +       bool supports_realtime;
> +       bool retrieve_lost;
> +       bool abort_operation;
> +
> +       if (!success) {
> +               DBG(rap, "Unable to read RAS Features: error 0x%02x",
> +                       att_ecode);
> +               return;
> +       }
> +
> +       ras =3D rap_get_ras(rap);
> +
> +       if (length =3D=3D 0 || length > 4) {
> +               DBG(rap, "Invalid RAS Features length: %u (expected 1-4)"=
,
> +                       length);
> +               return;
> +       }
> +
> +       if (length < 4) {
> +               uint8_t padded[4] =3D { 0, 0, 0, 0 };
> +
> +               memcpy(padded, value, length);
> +               iov.iov_base =3D padded;
> +               iov.iov_len =3D 4;
> +               DBG(rap, "RAS Features: short read (%u bytes), zero-pad t=
o 4",
> +                   length);
> +       }
> +
> +       if (!util_iov_pull_le32(&iov, &features)) {
> +               DBG(rap, "Unable to parse RAS Features value");
> +               return;
> +       }
> +
> +       DBG(rap, "RAS Features: 0x%08x", features);
> +
> +       supports_realtime =3D (features & 0x01) !=3D 0;
> +       retrieve_lost =3D (features & 0x02) !=3D 0;
> +       abort_operation =3D (features & 0x04) !=3D 0;
> +
> +       DBG(rap, "RAS Features - Real-time: %s, Retrieve Lost: %s, Abort:=
 %s",
> +           supports_realtime ? "Yes" : "No",
> +           retrieve_lost ? "Yes" : "No",
> +           abort_operation ? "Yes" : "No");
> +
> +       DBG(rap, "RAS features read successfully, capabilities determined=
");
> +
> +       /* Register for real-time characteristic notifications if support=
ed */
> +       if (supports_realtime && ras && ras->realtime_chrc && rap->client=
) {
> +               uint16_t value_handle;
> +               bt_uuid_t uuid;
> +
> +               if (gatt_db_attribute_get_char_data(ras->realtime_chrc,
> +                                       NULL, &value_handle,
> +                                       NULL, NULL, &uuid)) {
> +                       unsigned int notify_id;
> +
> +                       notify_id =3D bt_rap_register_notify(rap,
> +                                               value_handle,
> +                                               ras_realtime_notify_cb,
> +                                               NULL);
> +                       if (!notify_id)
> +                               DBG(rap, "Failed to register for "
> +                                       "real-time notifications");
> +                       else
> +                               DBG(rap, "Registered for real-time "
> +                                       "features: id=3D%u", notify_id);
> +               }
> +       } else {
> +               DBG(rap, "On demand ranging "
> +                       "remote device - skipping notification "
> +                       "registration");
> +       }
> +}
> +
>  static void foreach_rap_char(struct gatt_db_attribute *attr, void *user_=
data)
>  {
>         struct bt_rap *rap =3D user_data;
> @@ -1848,6 +2807,10 @@ static void foreach_rap_char(struct gatt_db_attrib=
ute *attr, void *user_data)
>                         return;
>
>                 ras->feat_chrc =3D attr;
> +               if (rap->client) {
> +                       rap_read_value(rap, value_handle,
> +                                       read_ras_features, rap);
> +               }
>         }
>
>         if (!bt_uuid_cmp(&uuid, &uuid_realtime)) {
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
