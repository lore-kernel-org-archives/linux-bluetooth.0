Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907FD30E0F5
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 19:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382335; cv=pass; b=MtUTGuODqRgwagqVwQv7GrbUL95wIoo0DpRuPj+PbUK1VFo2pQyN0RUvcl2wqDTpkhHtwBsDKWd8tlLbI39USDyCXx341iSWgpc4284wJO0eRgAhbbH26T+XRrlY5M0ndFJ8071gxz/BGa4eXUIpity90inq6BazllIO30x5+s4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382335; c=relaxed/simple;
	bh=K9IuzhYYmDLUdWNfhmzYMoyuaBDKgDyPeOYOWndWT6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scaqXnpceIyr4+JgbjAZWiFS0MuxzngsGQjh25+AEZJwoGR4thvhjIr7j8uOJs2fA0tc/FYu2A5LmPgCCxdLyjZxyIWiqjg/fUA3x8msAUlFDKIQSpf+iVTHRZHc/rtaNz5YVGkZiHjYCsMt2xXO/4f7cOfKLBq8vDRKXYTKpiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqLgHpVK; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqLgHpVK"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79a2ee65171so44324837b3.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 12:58:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774382333; cv=none;
        d=google.com; s=arc-20240605;
        b=YfiPk8ZwgsQKDrJeLEpP7wRZrY2YWzY7Ipxz92HT/ViqyMREXjVm74tr65UjcbhWvT
         khIdQJ9JGiASvHNLqS5UxG+gc978VRle9Lsi9GDUITdMqP2G065cFdd/WFNpRWdcGrNA
         qjH0wGSMg33SqgJSb/ivwFjRGLa6LV+zBHsr4EJ+cEceLNlqqaLnt5LT7eHpVXzMqPqW
         nHPK1D8iyN7AeU2/jH13Dff09nAM1Djam24GZ6bvEHgxoBKSmc2bs96c66PXBTK6gj+b
         H6b4Gg865h+jQdtc2d9deIAOmTk2CEkbXsbaMaONyZni8Z4N7mvTdzbhOI8JLXwUjb5v
         sllg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7zevCyt2vC4ZYx2RIYiFn+zWEyk1izcJrxbbK+kyv3U=;
        fh=JpOYBX1SNLta4hG28TtXzJHAyk8H52A+yFcnxvD+94A=;
        b=lJw1swKG45a4r8IJRazhJp+dKUpDC71/DiAchhSlsmjJ3sQbBQja2TNyOQaAlsVcMY
         Kkp1CDl26nylUNGsgWg28UTiyWd6RHxBQyN08/kgYdboXaXRMbLClHvmEnD9dFfAd8Mt
         ZD2pKyA5cfUqHWe8RiSqRPV9BCINnVh6CW09MOHBevvEFk9XrBm14DH7lfzRTUmU2Ef/
         TRs/QB+bDW0VKhqXFoZVYDTllDfcQ+nHi0dmYMOcMdXA84LzTW4J5bgwFjA7XnSM+DxH
         NzzFM3KXvVFjg80gZhvbwI3iRsH33Jrkqw6PvCbnPXV1QMSCHrq4vRHV75L/e0Aty3MM
         BMkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774382333; x=1774987133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zevCyt2vC4ZYx2RIYiFn+zWEyk1izcJrxbbK+kyv3U=;
        b=dqLgHpVKph40Dz6LjD8YJCY7E8xXmTM74UVMZKybgBNdRD9u6bkVz0MJtyvRnGgbDw
         R9k80dDrdJBrq6Ojn6m6aAr6eFiUEX9HmBGLgGv++qMqJclq+qe5E0QeZXKxkt5roVW/
         A+9neEsLbgy6lqwXC24XvzZUOMuwLazTJVna8UA+53zCA73qPZDNV0iiyfgzkZxOU34R
         34XqFVawQn854aeA8Dk//050E2tE3QqfhdrV8CluKOqLWmzifFP4DgtIcUVPoawAyI2a
         porspZJrQrxgDcC0HrDyeXYnNMFwkGsLmoAU82oxCIjqAR+/ZAD7aEUvhHGu7xZUT86S
         ycQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774382333; x=1774987133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7zevCyt2vC4ZYx2RIYiFn+zWEyk1izcJrxbbK+kyv3U=;
        b=sPHIybKyVZCJkG7HnjRsNhv7Dc/GZXFHCaoxZsTKlkfFhpkOq5yE+dgzpNkyyHgHPt
         hpXclPhXNaeRGCQQTDz2JEcIZy3pJGgvLcKMtecKxBbE2TtslnQPJOtUjhCaTb9yBW/3
         2uXgy9X8qdo5xC4OfyUz0AAlSxluvy+Fqya5Ac5Cqe04XVJl2BsdDjvzWZpsw4Xe/Dvi
         C6pJmEGOM1zdYuEicaNmXfivcCGC6tuA2f5u2g3sfoC7NLK8a+SdVnsbczTqgS6ZRtej
         lD+XBvQvfN5WOdovOTefVUfDLzOsegAIXY2rtp7yKSO8/eCTbzn+un3J/lHTiVcq2lH2
         PuHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuAscawYbB3/9d/XmyGMIBB6k+0nolKOnVmAgjgDkNkwwMzJVrWfmJjI9Lxsy86BduJOh0HTtIRx1moUlEIW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5+EllEiZsZZxLLGcE+HZOW7ct8dVeRFQjk7oPI/K//DGx95nh
	GE7f2qEzX+AHs7lEssYI7Kg/axXd6PGIjMAeED2AkLcNIEhQFFOR9cu08c2EBQNQDIySAwrxkZh
	q+jst7tAdSrumxWMi19T5Aan6q4LB754=
X-Gm-Gg: ATEYQzzkqEJzgqAFyllB/zhilFaAfd+BMgHih3zoxXt98I+oN6mKZf7l4v4m3893ntd
	XWgW+KSVTBp2boA+gnBeCKbYx712jQANTxGW77ED7hKMqMrmhCqc1TH6COfVo1thd09AnOAeVfk
	uJWTg9OhO7HKEdsSWn/9xzDoI9svSLjWpSH8HWNiB74iZZDLy6O8HLCvMPdSvAypvLzRqQqvDGA
	LkEvAjj9vaNz5wqkaoO7UecGHPTu5aBxXZFjwPnqTSdH22mggCIf7zO3a0Abju0CGWbHbC8e6Td
	DgAlxGf2U3uipTH8hOBYyV4Z7kh83uAlV5epqsPN1xUSw3b82mKivF9EbQ/zisTTYQmSgL3uOAE
	eTjlQ
X-Received: by 2002:a05:690c:c50a:b0:79a:8f2f:c86 with SMTP id
 00721157ae682-79acf6a9557mr10403067b3.49.1774382333512; Tue, 24 Mar 2026
 12:58:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324020427.60125-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260324020427.60125-1-pengpeng@iscas.ac.cn>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 24 Mar 2026 15:58:42 -0400
X-Gm-Features: AaiRm51Ed6KR_xr4KJvi9nXNh3liQicrC8Y-3ffNbi-o6fXsigE_DYCYm3sD1N4
Message-ID: <CABBYNZL9-GdR6WYGVwgTPmiBSBwQ123BadpxVYiKKk1Dh_ZVjQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: clamp SCO altsetting table indices
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 23, 2026 at 10:05=E2=80=AFPM Pengpeng Hou <pengpeng@iscas.ac.cn=
> wrote:
>
> btusb_work() maps the number of active SCO links to USB alternate
> settings through a three-entry lookup table when CVSD traffic uses
> transparent voice settings. The lookup currently indexes alts[] with
> data->sco_num - 1 without first constraining sco_num to the number of
> available table entries.
>
> While the table only defines alternate settings for up to three SCO
> links, data->sco_num comes from hci_conn_num() and is used directly.
> Cap the lookup to the last table entry before indexing it so the
> driver keeps selecting the highest supported alternate setting without
> reading past alts[].
>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/bluetooth/btusb.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index a1c5eb993e47..870a6aa92216 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2376,8 +2376,11 @@ static void btusb_work(struct work_struct *work)
>                 if (data->air_mode =3D=3D HCI_NOTIFY_ENABLE_SCO_CVSD) {
>                         if (hdev->voice_setting & 0x0020) {
>                                 static const int alts[3] =3D { 2, 4, 5 };
> +                               unsigned int sco_idx;
>
> -                               new_alts =3D alts[data->sco_num - 1];
> +                               sco_idx =3D min_t(unsigned int, data->sco=
_num,
> +                                               ARRAY_SIZE(alts)) - 1;
> +                               new_alts =3D alts[sco_idx];
>                         } else {
>                                 new_alts =3D data->sco_num;
>                         }
> --
> 2.50.1 (Apple Git-155)

https://sashiko.dev/#/patchset/20260324020427.60125-1-pengpeng%40iscas.ac.c=
n

They seem valid to me, so we might need to check if sco_idx is looping
around, etc.

--=20
Luiz Augusto von Dentz
