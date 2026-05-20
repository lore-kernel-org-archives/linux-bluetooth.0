Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C6D3469F6
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 22:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779314604; cv=pass; b=G5uO3DUoR8fhzl2sKAu96U5EJ0cF/c/OmxL4PftwsEI7o4EFnwDq8jJXlnWzoXt8Wt5twUBs8Ne0i3UvR+i4RJpEzs8pO4lKDC4x6yvGAPMi7YPLjzP2uaoqUNDo/h46aW48MZHg1d05hQh1w1EuuaTZeshzWQmil/6kmofsFcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779314604; c=relaxed/simple;
	bh=hYyAEWQeadvM6XovVkhdPt+HnOAggUi3yfPoxwF/oQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XkiFp7szDOhoasLRzG4pHXWmTfw7Re3l3KMIiNnl6dUf3b0s/fknrXyufXM8f7WcELmnIpqk/rk+QoinKgRfhTCZTcgKKrdo7cJI/CCYOdODJLDO4+xRTeRqGA6ts7jHEotp1DKdxGFOFxpGNLf1flZc1f0E2ZOwzBSIsPEDqP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUqESv+n; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUqESv+n"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65c1ba7eeb6so5544963d50.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 15:03:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779314602; cv=none;
        d=google.com; s=arc-20240605;
        b=jRGkkkIMwdE7iKhrHfhR5D/lSqlOmJV5pFxxckRiDVt+ex6Xe64D3AxfLCwuV+YMBp
         R8KS1Kdh3vLv3+T0j7+e1hej6aot2qPDaRqSoYn6o8hCBTB7+gor3RbGVitCdUPACT0H
         Fo38zy0KINF7Z/ihnStuMd4hADtNfavGNdNobl6iiRoM1KoBeRr/KvnaqEyca48+TLJV
         tExWixQnJs4MTh8Jf22slhlIdZ2zMfOk+tW+Uzkbcq9Et2VHC9YPpjHyhweGoQAdjPRf
         u2EYdkVle+jjU1eoEhT2Ic8Yt9bpknGhleX+SQtPOo6EKho3oaNquWHaov+i+NDJ28b7
         DNDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A/jMvDfBLv4FeAIfLBUVwZHVmH8wDPOnohCdxyOjuvM=;
        fh=HBYvj/8bRhg4+iZLzCWFK/F6n1asoUre0hLnyKcVpQI=;
        b=L/ngeAqOwpz6tcgUJxZ7GwZjRruC9ndDmpQx2fUIXJVRLzU4Lt2CHveX0sOT76QEKZ
         E6U/Qs9dfTpyvkQNVvm3xXZai1ydBp5dVFHXQvWZFJYvxUPjzKwuO3Pa/FpVjguFRvCj
         z+HfAjRw8Yfmr3uQUtNEGAOzGD9z853uATvoDzkrAGsd1ZOa9s9xFuTrBkSA6TkSBUiR
         98pwvQO92HQUVJ6Mdl6t2+08eCF4nK69zw+KVSPPW0r1Ar5W4Ev5G1VpruaRh6fnIF2q
         jjxpOWU7n0lSiSyYcrm7es1PmhYsUW08PVgBoZH2G2cXPmCI0j8BBDk0sSyZNtUT8p9p
         WhNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779314602; x=1779919402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/jMvDfBLv4FeAIfLBUVwZHVmH8wDPOnohCdxyOjuvM=;
        b=UUqESv+nXUISgVCqSMfa9UqsRkBH5PX0oV4c/9FRh1T1AEjVZfE2oRXrs0y1GQEmhE
         /FNjV3+21ZEn7nRmZqRerGjRUPrtkAGVCHXynCKw3sUs1Q6ekGkEshJ/mGWMdX5/GFeW
         D+LggCBADNckBTRnCF0R9wbFOGFjPPnckFvsbkMF25thj6ut7HK4DkIvN/uz+cAgYEWO
         r7ExIrRx0SrsvZk59EiHrXpUEPvHGwxLfCruroZ1mQBaJihoIJoVlA1+o8cVBCir2ti3
         0TA/q+HYrSU+nIDaujLlE1WxK1ESYr+yRWljkGcmdxHnm9flNoaFjwXetwVljTTWD2qn
         QHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779314602; x=1779919402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A/jMvDfBLv4FeAIfLBUVwZHVmH8wDPOnohCdxyOjuvM=;
        b=CgBjblRP+FvrXfAVoypAa3z29KDOCiIHShGWBNq4ELL2Xe7peOHRlpLDxhF5MqDTw8
         skHMvydoiAJSemtoxdgJNTZ1AGHG8GHzyvJxjMq+3gMucbwsx4vpFOD+7gGc9pb0PQRz
         mW0L3P0CIqXXsB+fvqEzVcQWPsFyOuOeecuHWeUqgWirI7WJQ35+8EzUfLhggqctUnRb
         kQ1ugEpPDE5o+3yco229tDMzIwmtDTdusFlkB76/65Ml1gdsrNln35QrtqUrbVT/cnLF
         wZSTViMjmR6CTBc8PP6IiZz2piN00hD9xzuHkg0MPej+7ylP4XhDi9Vrhi2vXo9LwDc5
         bB3A==
X-Gm-Message-State: AOJu0YwhZOiPytDuWpOiTOIo3lD0UnFNylyye47OBB5W4koxnPOqxKN+
	P8ilt2dmHMLeIFvK4pPs2BulMJRim/bQW/B1Tp9UtIaBubj7Bi6ulkR+YbZMbrDRAVHKMoVACLH
	nmi78U74uHHPIP71JI+rg314sWdBVHwF2Neq3pgY=
X-Gm-Gg: Acq92OFxRiBsV9iq9BgZqebtPV9RO9ej0dbV2Dpaw8aaN5SxcD+F4XGKZ39pote8kvy
	XPhFogNHKy34A2q6csK3Te2S1WQ5vbR6dCaKwVQqKAyQav8sTvBvKKl3/1irlXTqm64uTWS73GJ
	i2FZ2nNWl/8TwcMfhyQl+ALP4XTO26cRSYnsSst5Sc0zRthZmfEd0xBRD6W9rYBQd2t6Jq3Ncig
	+lPe2kjp7tNeL8z5tVdjIekDdzvxgjyZyOtLEB0CNzkclRtgOtAbHloQTSFi0ziV5oYzDKqVpvp
	sX1bUrk969cxr7urnHc9os09oq2jPnMLcW9cfVXeimoO8WwQKT0CaKOuVhFwh/zqcpZtcqYmhLW
	PUYVn
X-Received: by 2002:a05:690e:1582:10b0:651:c268:479 with SMTP id
 956f58d0204a3-65eae320374mr31086d50.57.1779314602147; Wed, 20 May 2026
 15:03:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517234805.116570-1-meatuni001@gmail.com> <20260520214133.27746-1-meatuni001@gmail.com>
In-Reply-To: <20260520214133.27746-1-meatuni001@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 May 2026 18:03:10 -0400
X-Gm-Features: AVHnY4IDP4f3fU1q7OQm9ioU-LLNyCU5B45JUnyoa8UjzoNYgEKkpFTZQWC-6-4
Message-ID: <CABBYNZ+Oc=LU6d8_xK9_a9yk-TFyaE=0KsNvAwKbNZVs1EJpWg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: HIDP: fix missing length checks in hidp_input_report()
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	marcel@holtmann.org, johan.hedberg@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Muhammad,

On Wed, May 20, 2026 at 5:41=E2=80=AFPM Muhammad Bilal <meatuni001@gmail.co=
m> wrote:
>
> hidp_input_report() reads keyboard and mouse payload data from an skb
> without first verifying that skb->len contains enough data.
>
> hidp_recv_intr_frame() pulls the 1-byte HIDP header before dispatching
> to hidp_input_report(). If a paired device sends a truncated packet,
> the handler reads beyond the valid skb data, resulting in an
> out-of-bounds read of skb data. The OOB bytes may be interpreted as
> phantom key presses or spurious mouse movement.
>
> Add a check that skb->len is non-zero before the type switch, and
> per-report-type minimum length checks before accessing the payload.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>  net/bluetooth/hidp/core.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> index 976f91eeb..03838a6ff 100644
> --- a/net/bluetooth/hidp/core.c
> +++ b/net/bluetooth/hidp/core.c
> @@ -179,12 +179,22 @@ static void hidp_input_report(struct hidp_session *=
session, struct sk_buff *skb)
>  {
>         struct input_dev *dev =3D session->input;
>         unsigned char *keys =3D session->keys;
> -       unsigned char *udata =3D skb->data + 1;
> -       signed char *sdata =3D skb->data + 1;
> -       int i, size =3D skb->len - 1;
> +       unsigned char *udata;
> +       signed char *sdata;
> +       int i, size;
> +
> +       if (!skb->len)
> +               return;
> +
> +       udata =3D skb->data + 1;
> +       sdata =3D skb->data + 1;
> +       size =3D skb->len - 1;

If you use skb_pull_data, you won't need to use pointer arithmetic, or
store the actual size.

>
>         switch (skb->data[0]) {
>         case 0x01:      /* Keyboard report */
> +               if (size < 8)
> +                       break;
> +
>                 for (i =3D 0; i < 8; i++)
>                         input_report_key(dev, hidp_keycode[i + 224], (uda=
ta[0] >> i) & 1);
>
> @@ -213,6 +223,9 @@ static void hidp_input_report(struct hidp_session *se=
ssion, struct sk_buff *skb)
>                 break;
>
>         case 0x02:      /* Mouse report */
> +               if (size < 3)
> +                       break;
> +
>                 input_report_key(dev, BTN_LEFT,   sdata[0] & 0x01);
>                 input_report_key(dev, BTN_RIGHT,  sdata[0] & 0x02);
>                 input_report_key(dev, BTN_MIDDLE, sdata[0] & 0x04);
> --
> 2.54.0
>


--=20
Luiz Augusto von Dentz
