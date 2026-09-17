Received: from mail-yx2-f15.google.com (mail-yx2-f15.google.com [74.125.224.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ECF388878
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789656502; cv=pass; b=lao5GOQGUo9zkSD1QLUmZ5EwiMW8o0jFmKyrwio9GSbze2bDEy3xFlwlWADLVzJxqCji0gDCG7mqsNmY2kpPhex+c8kclhQIi0IKGbNg1ciab2BSzUwYsXWCyIC5ylzM8TXlxlM2qOESbNrV9RMFsHDjaCUATDuX2hjFgLgbF3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789656502; c=relaxed/simple;
	bh=tTgUiyKUYViN+Atg3XfbgB6M0Q0rUf/j2BeBPr8Rw0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T0HUK3zmSNQMmkXyIYsNibOUt/GHTEVHPStSqkSgVv1i6lPb9APuXrTnCXQ2WMLeno06K9pksoqdV4bljONxa8T5MD2JarwgfX8vvilyzxj0kMx4ueZKgxCJ+d5KyUnyqdyUkzqkAqJUZJRdclv6VnZYkJhitjxExysaUbmRWJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHVBNhvb; arc=pass smtp.client-ip=74.125.224.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHVBNhvb"
Received: by mail-yx2-f15.google.com with SMTP id 956f58d0204a3-66e4aae3149so711073d50.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 07:48:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789656491; cv=none;
        d=google.com; s=arc-20260327;
        b=ekDFxoAV8H0BOFt8NDKALQ7JwIJBcDO+HhQ7y3HY4cH3ulsAGbA/W41m+HdYTJsBFO
         7ZyvwBPSebpzZ+msrLYIo8exNiWPGpcUD1/hggQnKw6tK21RbKp7WZ6xZ1oeTnr79rH0
         glvIX/pbbj1Dmohr32IRraYvuOjPpvo2kkYt4R3kv2osnOSS14gGVVEVtLhHq7OseQCW
         8vrYVy2Y02zH5lEP7qC5l9tZAAVC7zgy/juiikD19f1s7KgZR3iMUDhdbGwPaD0wGQU/
         pJYnRS28JNnoUPigoKHo23pozHk2vafPvBWJVve8Vo92xr5q8AGkjfF6RRuyTU+eRbMY
         7h0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UvQyowQO/iMrH2EN6A0lbKVe8Ekn2Ik/zgi3GGMg+s4=;
        fh=rhg0Gle/4xL7toZLvPTXiQYaR5XkHzpydvfLlubNvfM=;
        b=AlFaDZdyqHRgjZuMZObGTSNEKL8NwkeZ7m++yanh8h4BQPEuYrRvdHriNjlRcK/qvq
         4GUr14oSAxQyYqo+54lyksdCT+dmG0eWJssjLchKBuLWuFRlRIVLRRwUk98IeCF/liio
         ifxzlLd4j6k6FFBlHskNlo6rkM5jFbn2+W1BuIEYmarN7iygQFEAbvltKJmeZEwnIFy9
         VXveX5ApqnHTHeplypF2Br1EjkQTnEM+UjiiKDMM8XEjVC/LMnzzsKLqERVvYivP+O4t
         ftv0+lxOXECQRC8FD/wC/okvbkmWVDi43yu6tHEqf6dmCsKCxVWeGVuTmXnITRDzHWDq
         rcAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789656491; x=1790261291; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UvQyowQO/iMrH2EN6A0lbKVe8Ekn2Ik/zgi3GGMg+s4=;
        b=AHVBNhvbRQm3gVZS+WElvUBxu2nQW+9bN2md0JFpffZl0Ieq0Lwl6NW7LCfHi6dewF
         +bpy5NYNnEhiLQ9yYQ/QV9nOZi5yANfpjRP/gIfXXnHJSauinV00Izjr2Z6rN910v4Hi
         IfzsJVxScVdVzPe5Pmg1JwUQKOV3Q5yNMSz0XsuPD9DvWd+ivJU50H9EMxhALdL4GORq
         YerGU9N7XBcbronjfANOd3jxiewNjI3NuBB1cQTGwF0rAU389CDbBbAd1Y1iz0O/E0Zf
         DedCudtLz7RPFdSll9erj4FgcxG7R2pZqY3/qiOEm/cbF1CZsi0VEYKx648wS1x+o5BX
         9lTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789656491; x=1790261291;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UvQyowQO/iMrH2EN6A0lbKVe8Ekn2Ik/zgi3GGMg+s4=;
        b=Uwvd46MpOcqJEKA5ibrVglPVtjsgIQFtoogBTBP7BBhOOY9pnBc2orYmU6WxhUtFNN
         fQ9DDQKUlIsEwOFHokIvJZlqyd25zqGlZ0UsmnRT0Lxh9gY6ByYovg2mcF1E+mT/vRw7
         kEs4+Qvw9ZDlCCAo/FbIK/rNEQmdaQ94Nl1z5pNDoN0wXtRBo4VSojMO07Fx9uEer0jC
         E3pCScYhBhy/IoOhwwrwZto4qXFYEV4+qVXl1DFdPYMPmn71I8JEPP4b3wEWaboIgWTI
         dZgKmML6+Txiok2pPLPo7ES2KkVidFl7ovcB2xWavnBBJEnq6edjszth58ZMBPRf/mXJ
         5MZQ==
X-Gm-Message-State: AFuF++nrvyb/eB1N/+mrRoM718GWjsX0YjR3gfTVgcsBeq+ZP4ShKtcg
	84bHaIW+35o1OQSU9LHsKYA1xUl/fY5rRrN0seripxbEIRvkbgOlm9G3j5+F8ejPSx6BLeN5TGC
	co6WRXrK3Lq1pYKVChnqkq34wwfJ8FSI=
X-Gm-Gg: AYBFou1Kv7pUxXagnHwiSBZC0IIAacgxjg/th8QIgp41ZHsSQedVRrQJeZMRb4cuyfL
	YlokUNEm4gpqNCBV/Hl+jZru7Sou5wJ5Lc/hSquoUlUA+owxYql6je2Ode4yqcHbLogxLoCt8mq
	IDTQO5selTEHQ/shjU+kaR1P2Bg/tbX/WkMcClFTJirdOhWu/8jZVSJNK8Twi00huTLB6lsKIa9
	eWIFeC8e2BMSxwk6AIv++NDpjyV5niaXQmj9tFZL8t62yLuoarzlCduQZddrLKH4mbMcbbB3DfM
	rHXv2hSQ/TCLU1KlHUg5bQGnof3JTyZX18WNOOkawLCNHiy8LvG6AGwyAhJrw1FHLs7opGGap/9
	xVejlZWkHeiIfjqDSJV0Vwu3oIIN/eoDN6KyiQf0cWJ4=
X-Received: by 2002:a05:690e:4808:b0:671:70d1:d6dd with SMTP id
 956f58d0204a3-67170d1df87mr565288d50.79.1789656490878; Thu, 17 Sep 2026
 07:48:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <IGuo_ED6hoZcdNfKi5TCkYNNfYCJKn1CUSYS4a4ZNZ9WjaZCMI3rmBzLoslV22TvEjShB4iyBBAec3nrM4mMGI_r8dHKBUfAGLjZxXmgfIE=@proton.me>
 <pEIogdpm1KrQokz6n7Vp2rMm4FqyjlQ2X2YtxXFBhhWy_IaqXXNp8K7EwDeohmT6yelHFNOy7IuYYi7ooLtT2zeODVf8LPoBiOTrs7ua3O4=@proton.me>
In-Reply-To: <pEIogdpm1KrQokz6n7Vp2rMm4FqyjlQ2X2YtxXFBhhWy_IaqXXNp8K7EwDeohmT6yelHFNOy7IuYYi7ooLtT2zeODVf8LPoBiOTrs7ua3O4=@proton.me>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 17 Sep 2026 10:47:59 -0400
X-Gm-Features: AcwNN1XeHFNJS4O5aS17WSyjEpPWJePcP5QRHg6JABOYvskYJPYK6YtP4gkqSM8
Message-ID: <CABBYNZ+hzc_v_t5xtwsMPDzrhFgLzUwcN6QmABy_=GqJjMHEHg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] unit: Test metadata during BAP client reconfig
To: dt <derektern@proton.me>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 16, 2026 at 7:14=E2=80=AFAM dt <derektern@proton.me> wrote:
>
> From: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>
>
> Add client tests for both remote Sink and Source ASEs. Reuse an actual
> configured stream, start a second Codec Configuration, and cache local
> metadata before the peer responds.
>
> Check metadata retention and absence of an extra local CONFIG callback.
> Require QoS to remain blocked after reuse and after the successful
> control point response. Only the fresh peer CONFIG notification may
> make the stream ready for a nonzero QoS request and the subsequent
> exchange.
>
> Without the shared/bap fix, the premature local CONFIG callback attempts
> QoS before the stream is ready and both tests fail at that assertion.
> ---
>  unit/test-bap.c | 134 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 134 insertions(+)
>
> diff --git a/unit/test-bap.c b/unit/test-bap.c
> index 4e89ba6af..5fcf0262d 100644
> --- a/unit/test-bap.c
> +++ b/unit/test-bap.c
> @@ -82,6 +82,11 @@ struct test_data {
>         size_t iovcnt;
>         struct iovec *iov;
>         int fds[8][2];
> +       unsigned int metadata_config_count;
> +       struct bt_bap_stream *metadata_stream;
> +       bool metadata_reused;
> +       bool metadata_config_replied;
> +       unsigned int metadata_qos_id;
>  };
>
>  struct notify {
> @@ -4215,6 +4220,129 @@ static void test_scc_release(void)
>         test_usr_scc_release();
>  }
>
> +static bool metadata_reuse_pac(struct bt_bap_pac *lpac,
> +                               struct bt_bap_pac *rpac, void *user_data)
> +{
> +       struct test_data *data =3D user_data;
> +       struct bt_bap_stream *stream;
> +
> +       stream =3D bt_bap_stream_new(data->bap, lpac, rpac, &data->cfg->q=
os,
> +                                                       &data->cfg->cc);
> +       g_assert(stream =3D=3D data->metadata_stream);
> +       data->metadata_reused =3D true;
> +
> +       return false;
> +}
> +
> +static void metadata_config_response(struct bt_bap_stream *stream,
> +                                       uint8_t code, uint8_t reason,
> +                                       void *user_data)
> +{
> +       struct test_data *data =3D user_data;
> +       unsigned int id;
> +
> +       g_assert_cmpuint(code, =3D=3D, 0);
> +       g_assert_cmpuint(reason, =3D=3D, 0);
> +       g_assert_cmpuint(data->metadata_config_count, =3D=3D, 1);
> +
> +       /* A successful CP response has not confirmed the new ASE status.=
 */
> +       id =3D bt_bap_stream_qos(stream, &data->cfg->qos, bap_qos, data);
> +       g_assert_cmpuint(id, =3D=3D, 0);
> +       data->metadata_config_replied =3D true;
> +}
> +
> +/* Local metadata must not replace the peer's Codec Configured notificat=
ion. */
> +static void state_cc_metadata(struct bt_bap_stream *stream,
> +                                       uint8_t old_state, uint8_t new_st=
ate,
> +                                       void *user_data)
> +{
> +       struct test_data *data =3D user_data;
> +       uint8_t value[] =3D { 0x03, 0x02, 0x02, 0x00 };
> +       struct iovec metadata =3D {
> +               .iov_base =3D value,
> +               .iov_len =3D sizeof(value),
> +       };
> +       struct iovec *cached;
> +       unsigned int id;
> +
> +       if (new_state =3D=3D BT_BAP_STREAM_STATE_QOS) {
> +               g_assert_cmpuint(data->metadata_config_count, =3D=3D, 2);
> +               g_assert(data->metadata_config_replied);
> +               g_assert(data->metadata_qos_id);
> +               id =3D bt_bap_stream_release(stream, bap_release, data);
> +               g_assert(id);
> +               return;
> +       }
> +
> +       if (new_state !=3D BT_BAP_STREAM_STATE_CONFIG)
> +               return;
> +
> +       data->metadata_config_count++;
> +
> +       if (data->metadata_config_count =3D=3D 2) {
> +               /* The peer notification makes the reused stream QoS-read=
y. */
> +               g_assert_cmpuint(old_state, =3D=3D, BT_BAP_STREAM_STATE_C=
ONFIG);
> +               id =3D bt_bap_stream_qos(stream, &data->cfg->qos, bap_qos=
, data);
> +               g_assert(id);
> +               g_assert(data->metadata_config_replied);
> +               data->metadata_qos_id =3D id;
> +               return;
> +       }
> +
> +       g_assert_cmpuint(data->metadata_config_count, =3D=3D, 1);
> +
> +       /* Reuse the actual configured ASE, setting internal need_reconfi=
g. */
> +       data->metadata_stream =3D stream;
> +       bt_bap_foreach_pac(data->bap, bt_bap_stream_get_dir(stream),
> +                                               metadata_reuse_pac, data)=
;
> +       g_assert(data->metadata_reused);
> +       id =3D bt_bap_stream_qos(stream, &data->cfg->qos, bap_qos, data);
> +       g_assert_cmpuint(id, =3D=3D, 0);
> +
> +       id =3D bt_bap_stream_config(stream, &data->cfg->qos, &data->cfg->=
cc,
> +                                               metadata_config_response,=
 data);
> +       g_assert(id);
> +
> +       id =3D bt_bap_stream_metadata(stream, &metadata, NULL, NULL);
> +       g_assert_cmpuint(id, =3D=3D, 0);
> +       g_assert_cmpuint(data->metadata_config_count, =3D=3D, 1);
> +
> +       cached =3D bt_bap_stream_get_metadata(stream);
> +       g_assert(cached);
> +       g_assert_cmpuint(cached->iov_len, =3D=3D, metadata.iov_len);
> +       g_assert(!memcmp(cached->iov_base, value, sizeof(value)));
> +}
> +
> +static struct test_config cfg_snk_cc_metadata =3D {
> +       .cc =3D LC3_CONFIG_16_2,
> +       .qos =3D LC3_QOS_16_2_1,
> +       .snk =3D true,
> +       .state_func =3D state_cc_metadata,
> +};
> +
> +static struct test_config cfg_src_cc_metadata =3D {
> +       .cc =3D LC3_CONFIG_16_2,
> +       .qos =3D LC3_QOS_16_2_1,
> +       .src =3D true,
> +       .state_func =3D state_cc_metadata,
> +};
> +
> +#define SCC_SNK_CC_METADATA \
> +       SCC_SNK_16_2, \
> +       SCC_SNK(LC3_CODEC_ID_DATA, 0x0a, 0x02, 0x01, 0x03, 0x02, 0x02, \
> +                       0x01, 0x03, 0x04, 0x28, 0x00), \
> +       QOS_SNK(0x10, 0x27, 0x00, 0x00, 0x02, 0x28, 0x00, 0x02, 0x0a, 0x0=
0, \
> +               0x40, 0x9c, 0x00), \
> +       ASE_SNK_RELEASE
> +
> +#define SCC_SRC_CC_METADATA \
> +       SCC_SRC_16_2, \
> +       SCC_SRC(LC3_CODEC_ID_DATA, 0x0a, 0x02, 0x01, 0x03, 0x02, 0x02, \
> +                       0x01, 0x03, 0x04, 0x28, 0x00), \
> +       QOS_SRC(0x10, 0x27, 0x00, 0x00, 0x02, 0x28, 0x00, 0x02, 0x0a, 0x0=
0, \
> +               0x40, 0x9c, 0x00), \
> +       ASE_SRC_RELEASE
> +
>  static void bap_metadata(struct bt_bap_stream *stream,
>                                         uint8_t code, uint8_t reason,
>                                         void *user_data)
> @@ -4341,6 +4469,12 @@ static struct test_config cfg_src_metadata_streami=
ng =3D {
>   */
>  static void test_ucl_scc_metadata(void)
>  {
> +       define_test("BAP/UCL/SCC/Metadata-Configured-Sink",
> +                       test_setup, test_client, &cfg_snk_cc_metadata,
> +                       SCC_SNK_CC_METADATA);
> +       define_test("BAP/UCL/SCC/Metadata-Configured-Source",
> +                       test_setup, test_client, &cfg_src_cc_metadata,
> +                       SCC_SRC_CC_METADATA);

While adding a test is a great initiative, these are not qualification
tests though, and afaik this is only mimicking the code at
profiles/audio/bap.c so I wonder if it wouldn't be a better idea to
just move this testing to test-functional and have `bluetoothctl`
issue endpoint.config to reconfigure the stream.

>         define_test("BAP/UCL/SCC/BV-115-C [UCL SNK Update Metadata in Ena=
bling "
>                         "State]",
>                         test_setup, test_client, &cfg_src_metadata,
> --
> 2.55.0
>
>
>


--=20
Luiz Augusto von Dentz
