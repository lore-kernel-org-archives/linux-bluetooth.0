Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com [74.125.224.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE213909BF
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 15:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869733; cv=pass; b=STntLOo/eOH8HRTK4oeJ4DmAIyWf926AnM3MXJwaRzpmaeF/kFpFH96suWfjVhX1ODmOt/Egd5M/clNpXGQH7/TW1pTEeusTNlQWjvKibmzcj/JiaqgMon70W9ZIxx08EQSM1Z4YuoBSyaNBZimnrxliAlsrmffdWcaEBdgYnKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869733; c=relaxed/simple;
	bh=WcW7tfFe3pf4pxLD9pn5MWj3yDmIJfUcCXm87nmBumQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXu4SIOaFUhoolEzq5fJcmNJcWY7B+K5Vo8VLgR4H/knqV19Ytgl9ohuZRErvpkqqwn8KVCKyGFR4uk7jg/MtYyWYSfHKfzgeukLGfjWNeJ7TwTr1v3STyksgKnoK/xgZ8YmAHsvR5DAead6XesehyZskfqTMxj8OhmS+Z/81Uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l72we9Z5; arc=pass smtp.client-ip=74.125.224.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l72we9Z5"
Received: by mail-yx2-f38.google.com with SMTP id 00721157ae682-8ac47074e38so12656557b3.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 08:48:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790869731; cv=none;
        d=google.com; s=arc-20260327;
        b=a8BivfdetHdd7hvaA5dLryz4213spcAbXa9aHf8lf64akHP8R+G08sxllphez0cHD0
         MUBeHn4Ouaw+yJBrOsOc65USCfiwCQMDDuduC36UXishXfs/tpkfyamVtToqdpdWE3eK
         vxrnXIp/nJPsnS0lH3mKc17tB/tRnEGBgfuP/aDYwIbt1gIlIZjl3QtTVQoI4BiQoNsr
         grzsO77i4QsKEWfsaeMDCINGhB0wdJ+IHp1LgZ2g+ipp4YaTAfLH2X3ey7PmYaIQH3Xo
         CXIwKQWqkXOex0Ys1Ykxhj4BSzuKTl4V0gGhywT/oYAoqqEWICWLqAQmSZDidCDi1ct5
         mabg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yHcrQYrTxu154FKiVo4tFwO1mzrVXBrRfDvWNSioI1I=;
        fh=yMRINOhWSIvW8hRDgEW9Bw3sYRl+Gmh1YYZQy/HWyJI=;
        b=i0+C9kyHaNRvH+PRykIbuQrDafTzn5XYyzsOrNha0MIk0S4hg9ERtZ8b7G3m8xGHni
         Re3ylWqbqDmk2E+z8m0ZWyByPQ4ExnhxaS8+AMJ7N+LI42Brwy0SuolPN5psMbtvUd8e
         EynKUWwv9cE3js9+mUczwOYKOgW/rha9MkkmtB50ZH7XrF2Tc9R8piIRSK5yXXXG7DJt
         B5mkwu8z2XRoIT06t7ZrcfdQ/Md8SCBqOvf2Y5L+MD4gGwHOJc8R8LTyW1KU5U/PnVSu
         zaxCpa0tWl5kswyyZVF5RV3h7lXugZPDZsNkbcckcW/JWF1SQwKt9sPr2UcGe2lFYE3Z
         jIwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790869731; x=1791474531; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yHcrQYrTxu154FKiVo4tFwO1mzrVXBrRfDvWNSioI1I=;
        b=l72we9Z5Sqgz9nmxgsDOThi1/1bPc2DQl63mBvP3LMIC5ZkvXt8WaSi4O8Y7CJ31GG
         adbxq+To30n/tHCkymbLh2zdSAjdRbSWL1AKE6SRPLTnOl3rECrfYROmV3K9aDc+idS+
         wjOTAkLPIpkRQRlKGdUWZOWVOOSByd8EFisrPf/+lCr6YE8r0FfiA5Ohguv8RTKNcSiU
         51zkUVw4hDznM1aUrrx8+GCR0XHrgqX89JWWy5mItHLJRoCBYhHMecLqTHfDpIibCJxC
         K88IdiN8MdULLIOSxajLt4+HSehMlhEW2h9bsR1aYcOSEriD8kt+y2nn1Sn3dmV2CvO6
         xq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790869731; x=1791474531;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yHcrQYrTxu154FKiVo4tFwO1mzrVXBrRfDvWNSioI1I=;
        b=EdJmXjKnnGtDMG9Tz/EP63crIQcj8sHu7EJSjfVX/3/WmoWY0bVu/GPiRAIyefmoZA
         vEHl4nCFPTosn7bLIscvMQAOoDiSlvxAccWJ3l6BoALGk3g73AS/Tds9KkdW1FcgduCx
         fd1zQkoHzphFrp9VyZ4P8kgp1Knjwg3N3aC86AbLnGnpF0PbPCZmIkyp29HYFIBdoWzS
         R6ZhnCDtvuRGIIM7tK1PY2v/YEOX7JAvNoFKrtqdNtk86th3CqJHWL92dpS+uYiQSsZb
         phTJ0CIckxwIfs4vGTRFnCyrigRaaIbonTHj8vsG9akzyHeJQ7gGQxdImvfR2zckTgSq
         6msA==
X-Gm-Message-State: AFq9FYIF5V5MRMT2bXWHkLdavg2+GzfvJ0+FYxHrdVHLm8VVsh/9JUc+
	r40h6GujrUA/+ZUMQvjdAFH+I0PA+MFaMzx1zbPK2x61xBiHF5FOzgBksKalMTrEHz8QjGjAOZg
	7nNpkVnFMmD1AHT/561i6dhPu9bpz2zY=
X-Gm-Gg: AYBFou1DpNx4nwf/2Fwq9ji60g8t+2FBkYf1JWeUcf80BQt7r46PE0Z8ytEjS9p59zb
	xtRNZOT91BQelH2fg/EYYz05gQjkCSruRS8+Ez4YEL9Q5Z5XKGusJ/l2zriy8Yd1HEBPacbscUU
	jCcFVvv8Uz4cZQ0CMpUmoQU9bcwMs5jTiNISw77mU1z1B9eEeYq0CemPERTGHdNuiXmxuaP9LIR
	8XI3zmchoeSGhRxjMDYh4spCviFyBMfdfMHP5xHkVnH0oA4QokfvqhE9NnZzQ9+DH1zYJZw2ZDI
	MLKlvHJh8w9Cx2TmtNuJCcqqiN4em2ymluj+gPniH3bxBXVTfVw7Rtp33Sy4jxYALJJCinVf/Q9
	bctwkoL8/V13vKF97NeYKGHrxkjaJefjQEc/ednTq45JvttR4kYuX
X-Received: by 2002:a05:690c:ec4:b0:8a4:cc7b:f7c with SMTP id
 00721157ae682-8acdb061845mr16724527b3.30.1790869730871; Thu, 01 Oct 2026
 08:48:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001131900.707485-1-cheng.jiang@oss.qualcomm.com> <20261001131900.707485-3-cheng.jiang@oss.qualcomm.com>
In-Reply-To: <20261001131900.707485-3-cheng.jiang@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 1 Oct 2026 11:48:39 -0400
X-Gm-Features: AclHuK-v590a00M-k2njPHGzfApEdnunaUHUCzRm5opwmBscO2eqclwl_hT5n1Y
Message-ID: <CABBYNZKVF4iCVzxQ_TC9FHeTOrFYLzZht3tyihfOnfKT=-93Ag@mail.gmail.com>
Subject: Re: [PATCH 02/11] shared/gatt-db: Add gatt_db_attribute_indicate()
To: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, jinwang.li@oss.qualcomm.com, 
	wei.deng@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com, 
	shuai.zhang@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 1, 2026 at 9:48=E2=80=AFAM Cheng Jiang <cheng.jiang@oss.qualcom=
m.com> wrote:
>
> The notify callback leaves the choice between a notification and an
> indication entirely to the CCC value written by the client, preferring
> notifications whenever the client enabled them. Some services need the
> indication transport for a given characteristic regardless: the Ranging
> Service must indicate Ranging Data Ready and Ranging Data Overwritten
> even when the client subscribed to both transports (RAS 3.4.2, 3.5.2).
>
> Add gatt_db_attribute_indicate() alongside gatt_db_attribute_notify() and
> let the callback query which of the two it was invoked from through
> gatt_db_attribute_indicate_only(). Both entry points share a helper, so
> the CCC lookup stays in one place, and neither gatt_db_notify_t nor the
> existing gatt_db_attribute_notify() callers change.
>
> gatt-database honors the request by skipping the notification branch and
> sending an indication instead, provided the client enabled indications.
>
> Assisted-by: Claude:claude-opus-4.8
> ---
>  src/gatt-database.c  |  7 ++++++-
>  src/shared/gatt-db.c | 35 +++++++++++++++++++++++++++++++++--
>  src/shared/gatt-db.h | 17 +++++++++++++++++
>  unit/test-rap.c      | 13 +++++++++----
>  4 files changed, 65 insertions(+), 7 deletions(-)
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index 18b7aa667..800f76032 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -168,6 +168,7 @@ struct notify {
>         uint16_t len;
>         bt_gatt_server_conf_func_t conf;
>         void *user_data;
> +       bool indicate_only;
>  };
>
>  #define CLI_FEAT_SIZE 1
> @@ -1446,7 +1447,7 @@ static void send_notification_to_device(void *data,=
 void *user_data)
>          * TODO: If the device is not connected but bonded, send the
>          * notification/indication when it becomes connected.
>          */
> -       if (ccc->value & 0x0001) {
> +       if (!notify->indicate_only && (ccc->value & 0x0001)) {
>                 DBG("GATT server sending notification");
>                 bt_gatt_server_send_notification(server,
>                                         notify->handle, notify->value,
> @@ -1455,6 +1456,9 @@ static void send_notification_to_device(void *data,=
 void *user_data)
>                 return;
>         }
>
> +       if (!(ccc->value & 0x0002))
> +               return;
> +
>         DBG("GATT server sending indication");
>         bt_gatt_server_send_indication(server, notify->handle, notify->va=
lue,
>                                                 notify->len, notify->conf=
,
> @@ -1486,6 +1490,7 @@ static void gatt_notify_cb(struct gatt_db_attribute=
 *attrib,
>         notify.ccc_handle =3D gatt_db_attribute_get_handle(ccc);
>         notify.value =3D (void *) value;
>         notify.len =3D len;
> +       notify.indicate_only =3D gatt_db_attribute_indicate_only(attrib);
>
>         if (attrib =3D=3D database->svc_chngd)
>                 notify.conf =3D service_changed_conf;
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index 751d4c3da..1f6e9ae14 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -123,6 +123,11 @@ struct gatt_db_attribute {
>
>         unsigned int next_notify_id;
>         struct queue *notify_list;
> +
> +       /* Set only while notify_func is being called on behalf of
> +        * gatt_db_attribute_indicate().
> +        */
> +       bool indicate_only;
>  };
>
>  struct gatt_db_service {
> @@ -2440,9 +2445,9 @@ gatt_db_attribute_get_ccc(struct gatt_db_attribute =
*attrib)
>         return ccc;
>  }
>
> -bool gatt_db_attribute_notify(struct gatt_db_attribute *attrib,
> +static bool attribute_notify(struct gatt_db_attribute *attrib,
>                                         const uint8_t *value, size_t len,
> -                                       struct bt_att *att)
> +                                       struct bt_att *att, bool indicate=
_only)
>  {
>         struct gatt_db_attribute *ccc;
>         struct gatt_db *db;
> @@ -2468,11 +2473,37 @@ bool gatt_db_attribute_notify(struct gatt_db_attr=
ibute *attrib,
>         else
>                 notify_user_data =3D ccc->user_data;
>
> +       attrib->indicate_only =3D indicate_only;
> +
>         attrib->notify_func(attrib, ccc, value, len, att, notify_user_dat=
a);
>
> +       attrib->indicate_only =3D false;
> +
>         return true;
>  }
>
> +bool gatt_db_attribute_notify(struct gatt_db_attribute *attrib,
> +                                       const uint8_t *value, size_t len,
> +                                       struct bt_att *att)
> +{
> +       return attribute_notify(attrib, value, len, att, false);
> +}
> +
> +bool gatt_db_attribute_indicate(struct gatt_db_attribute *attrib,
> +                                       const uint8_t *value, size_t len,
> +                                       struct bt_att *att)
> +{
> +       return attribute_notify(attrib, value, len, att, true);
> +}
> +
> +bool gatt_db_attribute_indicate_only(const struct gatt_db_attribute *att=
rib)
> +{
> +       if (!attrib)
> +               return false;
> +
> +       return attrib->indicate_only;
> +}
> +
>  bool gatt_db_attribute_reset(struct gatt_db_attribute *attrib)
>  {
>         if (!attrib)
> diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
> index da0600c01..63d7f3464 100644
> --- a/src/shared/gatt-db.h
> +++ b/src/shared/gatt-db.h
> @@ -300,6 +300,23 @@ bool gatt_db_attribute_notify(struct gatt_db_attribu=
te *attrib,
>                                         const uint8_t *value, size_t len,
>                                         struct bt_att *att);
>
> +/* Same as gatt_db_attribute_notify() but requests an indication even wh=
en the
> + * client has also enabled notifications. Some profiles mandate the indi=
cation
> + * transport for specific characteristics (e.g. the RAS Ranging Data Rea=
dy and
> + * Ranging Data Overwritten characteristics), which gatt_db_attribute_no=
tify()
> + * cannot express since it prefers notifications whenever the client ena=
bled
> + * them.
> + */
> +bool gatt_db_attribute_indicate(struct gatt_db_attribute *attrib,
> +                                       const uint8_t *value, size_t len,
> +                                       struct bt_att *att);
> +
> +/* Valid only while a gatt_db_notify_t callback is running: tells whethe=
r it was
> + * triggered by gatt_db_attribute_indicate() rather than
> + * gatt_db_attribute_notify().
> + */
> +bool gatt_db_attribute_indicate_only(const struct gatt_db_attribute *att=
rib);
> +
>  bool gatt_db_attribute_reset(struct gatt_db_attribute *attrib);
>
>  void *gatt_db_attribute_get_user_data(struct gatt_db_attribute *attrib);
> diff --git a/unit/test-rap.c b/unit/test-rap.c
> index d7da2ff45..5c6033a4e 100644
> --- a/unit/test-rap.c
> +++ b/unit/test-rap.c
> @@ -167,10 +167,15 @@ static void gatt_notify_cb(struct gatt_db_attribute=
 *attrib,
>
>         printf("%s: notify.value:%d notify->len:%d\n", __func__,
>                 (int)*(notify.value), notify.len);
> -       if (!bt_gatt_server_send_notification(data->server,
> -                       notify.handle, notify.value,
> -                       notify.len, false))
> -               printf("%s: Failed to send notification\n", __func__);
> +       if (gatt_db_attribute_indicate_only(attrib)) {
> +               if (!bt_gatt_server_send_indication(data->server, notify.=
handle,
> +                               notify.value, notify.len, NULL, NULL, NUL=
L) &&
> +                               tester_use_debug())
> +                       tester_debug("Failed to send indication");
> +       } else if (!bt_gatt_server_send_notification(data->server,
> +                       notify.handle, notify.value, notify.len, false) &=
&
> +                       tester_use_debug())
> +               tester_debug("Failed to send notification");
>  }

Don't mix changes from src/shared and unit/, send them in separate
patches, now about the gatt_db_attribute_indicate_only, introducing an
API just for unit testing sounds suboptional and I wonder if it could
be avoided some way.

>  static void gatt_ccc_write_cb(struct gatt_db_attribute *attrib,
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
