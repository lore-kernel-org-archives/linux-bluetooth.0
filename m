Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9605A35C1A9
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214651; cv=pass; b=YHUTyX0ZVvELO8/cRZh/NjRjnhr6j/IUPVHT7lvIaEIW1lzInzugWc14KfQaUgoPRIMmyaMsR6pP6XTzB1oTdWzvqh40DXWg87KqQBFXwcjTeSIWcC8nUFCEw5MYBR16YXL0TgOUz7bj6UCXz5TIDDsoG0DiKkBPexye5imwDZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214651; c=relaxed/simple;
	bh=G6GsEx0eBXyBfSLN6wd69IQecnnT5ccXPjHexwdRDLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZqqB3OSw0/A6XmYqUsZkiY7HmKsRPEbSfFb5QpV8bwVfssGiHxtV9YuvjY9MnU85JhafvsfEn7y4h5v2k66YgXNuh5nGMc4BFOFGMK2fBWCRx+UMsMnysmUo6MXV3tuSRH94dXCkWu5rEZtXpZgYiNnIWKF57zRwUv4kb8Ol6xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q72xy1Gy; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q72xy1Gy"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6579254f996so2539954d50.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 11:17:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779214648; cv=none;
        d=google.com; s=arc-20240605;
        b=Y6W2aHrCsriqLY/TKCQ1Lr8rmfjLnUjH9IK9vpVXvlzR6JGmTwoZ2J9Grm2SP32EjZ
         jOGaK0hFz8BhDdPBWn7SwRzHy4kbTpu/1uPz0++ibmmAr9aECdrwh0Xz3/AXuahEIWJB
         GNsBf94Jbaa85g2tUZM9Iy4Nu6qbmQdMC41clpLXf/aa/LyK22Wj39pXIMKS0S2GeWlb
         M0PXP/0QaTnUXWWjq71dI+ri3WNwQ8tbaiDsgUrlhmMCjB+PUj1cZz8kt5vEE1tBTQSA
         SRTDbN26XKSrVd/GyqxoUerwT5d2JLf8Fpc01hL0Ca5pPN273RHQdF7AO6UtnOya0hoQ
         S/VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tYWeN0ft4OV9FJ2/f7iqDEkUliNeJo8syOXSgyYtJsI=;
        fh=fAVvqa29TMCSLQ1BWo+IkeTh9vOt2h2EvlnFWIq0DOI=;
        b=RGrSRLUe+HuD149pOidbyVhCriitmH+LxWdUehABfumWKFDUkIe4HRGdFmPlGniZbu
         NpiT8OsbmBXQzu/fpjdNQHchj+VCkIzTvI+vjhGfnmF3+BxHChXyX0LonnABthoQcM3N
         hZ9Gn5zJRExCVcwawoxtMAuHgTipUvrIT0IwlJncb1iLMfO+FJC5V4GSESo0peFGjEz3
         yxJVsRvDyKU9t168/yQZ6Fn5UhIkGnjunCZPm1F1gA6Jqz9E8vngPrFqBLLG8wSZJFXe
         AjX3ZmZB5vRK2G68ktAAKr8eXR1KxV2XNhQ6pjcWx+pLNrtrixaHFUbRX9gO4RtnmUzh
         8E7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779214648; x=1779819448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYWeN0ft4OV9FJ2/f7iqDEkUliNeJo8syOXSgyYtJsI=;
        b=Q72xy1GyxqnPPfJDaz/akkbzrhs5ERkIhPNVvJh6SoE7ySefiNYMPxJ4gUpXxlc/0Q
         W7HlPOLRWxMzm2QqQejUGvy9YOgcBzmj5s2ZPLt/ALaPOx4a0u/wb8BaOP4Z0518w/gm
         8jlfItwHJ58GtsCy2lh1mFPtd8YteVKL28HtgGClzk3l+QDEZM+BEQtVmg9/oNht5FFo
         loVHBklE0gigOqfhwwHvUc0r/+XowuYV0tzloRuV++Fe1cnoVsoKqmJa5qqu7MyYVrTY
         oGNa6iTrAKzIcSsKQkbXyik+R0imrDj4jmKMwAEAV8d+P/E3WSG4KmLlex+hICJDhyIe
         sZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779214648; x=1779819448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tYWeN0ft4OV9FJ2/f7iqDEkUliNeJo8syOXSgyYtJsI=;
        b=abIxyL8nD6jyDGcmtRAb5IDCnQh5tcTouLGPggaSBL8ySTnonSQcYL4GiYABa08txv
         CiPk0z4Ge3wGHNqCU0EsttijA+qe1djvrdZfRkZwTCuu+ShOQjYhEp4I2JYkIWXQGjDE
         Opp0ApyxW2RmnHf+k3i9sVbC2E6pKePDjn+mjhXZ9g4kqW5riHOEYScXmlupMnX3r/dk
         dNysuUl5w3OCdkuiePzkwswdHrXmf5Vfpf7MK/DGHeyPDzpS0JIKHbIEyeFAsjbfyCDZ
         E38D8VhkGj/30qm+4CA5lneDVX+AULSrecmUPrYHQJrF3AqZWljaqLrNca8UgiHTdhJ4
         mHNA==
X-Gm-Message-State: AOJu0YwV/1h2gas1IgY9+LjO+qCb/pH8xxPjdkShw2zu68k+YvJfvAek
	r/2Bbqt/n+CYP4cEAuGxgs3U4TdUVlk5ISuQ6qx0tT9CQ/2nnV7PI4Tq65D7PFJ7GMZP0ZL0Zmb
	2jbrzNvruJ8yrs96/FJgX7wMrF9FWzps=
X-Gm-Gg: Acq92OGki/pPpuUxzeOPeTmDCUu2UzqWslmLKqMj3gsR0rrM5MglUZzVQq+llrMEMqZ
	YtUcTc5TifEZaqBHoCWsrCr1/Twf8Nf0sYlqaJ6JVKvQ7bOrI0SyNON7PDiiPWsFO7l9T29YP5W
	rKamjgRIHlTOVxAbMsEwQoCANOXzOGaepUqRrgm3Ybru5he7OLrceOPyduCCIIQGjwSnqz06bUe
	dwiIyW2BmhY3RJfvVp4nwDszEVsGDWS6gQlo0nA1JZLWp4fVF4w1NHVrum1pi7MWw62y+c9SJv7
	O7csCfIVHk/thjCkvvfAA1tMaNaMLvrNV0fh52vHPNGnINg3twyndLlAIanEn5cw5OVH6hEjZng
	CSGu4
X-Received: by 2002:a05:690e:138a:b0:65e:449f:4e24 with SMTP id
 956f58d0204a3-65e449f4f98mr13187495d50.47.1779214648393; Tue, 19 May 2026
 11:17:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <60b9da865b9beb482f914818c31866ebb00960f7.1779011736.git.pav@iki.fi>
In-Reply-To: <60b9da865b9beb482f914818c31866ebb00960f7.1779011736.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 19 May 2026 14:17:17 -0400
X-Gm-Features: AVHnY4I-_DCLoom5hSGRKhDTKMkxYrFnfybWhwchwfFwaGyfoMfr70krXNFgZZQ
Message-ID: <CABBYNZL6+4tY1DiahNoGwC=DZEbzN5k4Z=6B4EQF3mD+WuLYag@mail.gmail.com>
Subject: Re: [PATCH BlueZ] media: use custom DBus timeouts only when remote
 side is waiting
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sun, May 17, 2026 at 5:59=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Under high system load (VM instance on boot) it's observed the 3 sec
> timeout BlueZ uses for BAP broadcast SetConfiguration may be missed by
> Wireplumber, as these are set up immediately on startup together with
> any other setup (eg ALSA) that may need time.
>
> There's no actual need for using a short custom timeout in BlueZ for
> this, as in this case there is no remote side that is waiting for a reply=
.
>
> Fix by limiting custom timeouts to cases where there is a waiting
> remote.  A2DP-specific timeout should be used only for A2DP
> SetConfiguration.  Similarly, using timeout for BAP only makes sense for
> unicast, and should derive from the ATT timeout.
> ---
>  profiles/audio/media.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index cdaafb04e..0297e4c79 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -71,7 +71,11 @@
>  #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
>  #define MEDIA_PLAYER_INTERFACE "org.mpris.MediaPlayer2.Player"
>
> -#define REQUEST_TIMEOUT (3 * 1000)             /* 3 seconds */
> +/* Timeout should be less than avdtp request timeout (4 seconds) */
> +#define A2DP_REQUEST_TIMEOUT_MSEC      (3 * 1000)
> +
> +/* Timeout should be less than ATT timeout (30 seconds) */
> +#define BAP_REQUEST_TIMEOUT_MSEC       (20 * 1000)

Is there any particular reason for this to be so long? We don't have
any custom timeout other than ATT, in the other hand, I'd rather not
wait 20 seconds for the endpoint to respond. 3 seconds might be too
short depending on the environment but in a real environment, even one
second to respond sounds plenty. Perhaps we should only use such a
high timeout if testing has been set which hints that the environment
may have been modified to allow the testing harness.

>
>  struct media_app {
>         struct media_adapter    *adapter;
> @@ -465,16 +469,16 @@ static gboolean media_endpoint_async_call(DBusMessa=
ge *msg,
>                                         struct media_transport *transport=
,
>                                         media_endpoint_cb_t cb,
>                                         void *user_data,
> -                                       GDestroyNotify destroy)
> +                                       GDestroyNotify destroy,
> +                                       int timeout_msec)
>  {
>         struct endpoint_request *request;
>
>         request =3D g_new0(struct endpoint_request, 1);
>
> -       /* Timeout should be less than avdtp request timeout (4 seconds) =
*/
>         if (g_dbus_send_message_with_reply(btd_get_dbus_connection(),
>                                                 msg, &request->call,
> -                                               REQUEST_TIMEOUT) =3D=3D F=
ALSE) {
> +                                               timeout_msec) =3D=3D FALS=
E) {
>                 error("D-Bus send failed");
>                 g_free(request);
>                 return FALSE;
> @@ -521,7 +525,7 @@ static gboolean select_configuration(struct media_end=
point *endpoint,
>                                         DBUS_TYPE_INVALID);
>
>         return media_endpoint_async_call(msg, endpoint, NULL,
> -                                               cb, user_data, destroy);
> +                                               cb, user_data, destroy, -=
1);
>  }
>
>  static int transport_device_cmp(gconstpointer data, gconstpointer user_d=
ata)
> @@ -604,7 +608,8 @@ static gboolean set_configuration(struct media_endpoi=
nt *endpoint,
>         g_dbus_get_properties(conn, path, "org.bluez.MediaTransport1", &i=
ter);
>
>         return media_endpoint_async_call(msg, endpoint, transport,
> -                                               cb, user_data, destroy);
> +                                               cb, user_data, destroy,
> +                                               A2DP_REQUEST_TIMEOUT_MSEC=
);
>  }
>  #endif
>
> @@ -1093,7 +1098,7 @@ static int pac_select(struct bt_bap_pac *lpac, stru=
ct bt_bap_pac *rpac,
>         dbus_message_iter_close_container(&iter, &dict);
>
>         if (!media_endpoint_async_call(msg, endpoint, NULL, pac_select_cb=
,
> -                                                               data, fre=
e))
> +                                                               data, fre=
e, -1))
>                 return -EIO;
>
>         return 0;
> @@ -1233,6 +1238,7 @@ static int pac_config(struct bt_bap_stream *stream,=
 struct iovec *cfg,
>         DBusMessage *msg;
>         DBusMessageIter iter;
>         const char *path;
> +       int timeout_msec;
>
>         DBG("endpoint %p stream %p", endpoint, stream);
>
> @@ -1243,9 +1249,11 @@ static int pac_config(struct bt_bap_stream *stream=
, struct iovec *cfg,
>         switch (bt_bap_stream_get_type(stream)) {
>         case BT_BAP_STREAM_TYPE_UCAST:
>                 transport =3D pac_ucast_config(stream, cfg, endpoint);
> +               timeout_msec =3D BAP_REQUEST_TIMEOUT_MSEC;
>                 break;
>         case BT_BAP_STREAM_TYPE_BCAST:
>                 transport =3D pac_bcast_config(stream, cfg, endpoint);
> +               timeout_msec =3D -1;
>                 break;
>         default:
>                 transport =3D NULL;
> @@ -1279,7 +1287,8 @@ static int pac_config(struct bt_bap_stream *stream,=
 struct iovec *cfg,
>         g_dbus_get_properties(conn, path, "org.bluez.MediaTransport1", &i=
ter);
>
>         if (!media_endpoint_async_call(msg, endpoint, transport,
> -                                               pac_config_cb, data, free=
))
> +                                               pac_config_cb, data, free=
,
> +                                               timeout_msec))
>                 return -EIO;
>
>         return 0;
> --
> 2.54.0
>
>


--=20
Luiz Augusto von Dentz
