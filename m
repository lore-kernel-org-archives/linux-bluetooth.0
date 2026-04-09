Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AD03DD50F
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775747997; cv=pass; b=qLjlg5kMAi1pyJx/cWJtH5Mz4s1zBtmkR3rgEk39/JUXn5vqUW35WFqGy38HtBBPQ5n3O2Pf9UD7IRELf4vF88C0Gm48wixFilIdaKmaDA4a+04dTLK18H1Nvws4OxQnf0i4x6l2TI9UkFyxpwVMC5yGGKSDGDOKPje4dC2KfSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775747997; c=relaxed/simple;
	bh=WxVxUebbeL3BGl6sp1FAzNJgwszo6zFr1Z0dFZU2TQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkytBjIKpdzF2ejgCc3lVrwPQVZlFawAVlGitob60RQLO8aDDrjWy2e2wLe+RrnhP5tQU/NpNRSoO4oSuywu8qZ6Pcg1ruRGZd6ULMuuftUpa3FUoQKOcFi7iHKJ0qOwzeb91gFxnEcSYNkw9CkDfRB399xj9PiMBO2lJ6PBACg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAT+6OEp; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAT+6OEp"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64fc6b21789so728427d50.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 08:19:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775747995; cv=none;
        d=google.com; s=arc-20240605;
        b=Lbdt9db0N/+jmMvLfUlnXdFLKDt3GM+zGKTCq//zifYBoT2seLvzs8jQcRkOvyDi2L
         mgemlYzKmDe9rYsFOuyBreiKXVVjTXPTq7tzGzXLkv6VDBIPKRhfluKn4mdqwT7ZkWxJ
         vpCKLWRY4SyCopyf3j7tc8fXudKo/UbWrcVZt3YLB6XjeqULgVnXmF0Waq4otT6dNg+0
         F4xU0Lb6ftYJOTpICZVv2QOL+bt+4E5/vz7/ZuEd9ILRj+qNxktHMnY+5x9/ahLpfh+8
         65M8WgvDUymj0SBkum3z8emXwaOMTKik9uPo/3Locw1wa18JVnBszZh/6AauFGdCb09c
         HCvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fSe3huXWAFFZZ1NES5Jyko0bJR3+jewHlkBFn+VuI2c=;
        fh=LJjZ95Y72qQs2fnjpGcJ2qjfcbeOh0SYnwbCAeVN9AA=;
        b=C378BffyLUUBslxZF3pIKf8ng64/6A1SjSq76oumqidBu1LnOQ6xvaKZeceJLNoFVx
         xoD1Z5Zi3cRWbtb6cE5uGc5k6jJ8TmV8eyrPVKTTycykjbVD4gU0CuujRPG0SpP7ExjA
         0onuc8ivj7R4+PTaM6v5UKwyS+IlgmjVml39L69N2NhRY2Rt3OvI898WbVq2yKmxjBej
         3Mp0VBwghcmnPfvt/4A8BGaAUX1EjjIulcx1pHR9ktYPs6q1BqS7o5ZzcB5g6ik1q5WD
         3u5qzvuCjByC7hucE4L5Wpp5TByOa0oK7DiiWY95cAjm9fzN5+h24CDVGIASiQCL9+oe
         3ojw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775747995; x=1776352795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSe3huXWAFFZZ1NES5Jyko0bJR3+jewHlkBFn+VuI2c=;
        b=EAT+6OEp6d2KXwzDrgqfluqzd837HraDN3DiPRRa4aQ32OY78nBYXc89KbO7z9powC
         h4OmArl/wX6il64xFIWTINc3Nb7/1AAFZy7LXCGXVDMcxHiQA/M9q/qOSKQynbHU8xo9
         FdxS7B+/bFsOebC8BDkMMCUXqxvAeRpyKw3+amd6fz071Def5jjfnQkhz2ks76MtPrlu
         mjLVHGcs87GDfW9wWUTI9jqhJJjKAhv4t9v5lwHUKuVOwELYiXt7zCdf+T30w6Ullhzu
         cxgoVJC/6zM2Gabn5fGVa9L5Z+U68GdNGwziRUs5juPbP3cWq6kS2oC952Yfq+xhfph0
         uwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775747995; x=1776352795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fSe3huXWAFFZZ1NES5Jyko0bJR3+jewHlkBFn+VuI2c=;
        b=kyyuB/BOzs+mVqGv49TsDopkn/61X3n2RgLhMbuaYVwWRWxj4vTVcRaOtdDvC9I3eh
         82A2Hn4ya8JxH8G6gthL6MjFeX50oZQMw2VcGmz8KpSnpkGlYaT/c3Emmrlo3g8aAziX
         pwptSByBf4MRutLNWY7+n8DDiklmQUQiumQNmskv8eXTWwz/8JHWejU9IT42XsiaIgtm
         e49rFy1NuhorpQfHJoKLUBca/bP2dwp9UEaBY3OBfO3h1FSgkbPvjs7Vl4nO3J3+ADf1
         SvDZ69+HF2jXMPHldOi9FWKRYdiBap/J8YnOdX+ySp50O4gUVlU9w98M0ijkKqwU28XA
         pLWg==
X-Forwarded-Encrypted: i=1; AJvYcCXA1BoxPUKkzY2T5HRsv0MM0xIcaJX6jiPZe3s/htBUYzY17dGeeBLceHdg447I+eG9XvvYwBykVeYlLSHc7GI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2DV13YDgWNLdgE/CdggN4BYAwWFvLp1IaqnzZqeO8vqLZ066s
	w1PuRlI2xJ+/lYXVuK00/WNUp9R1nuKsXPdwutntgMp+SXDYlnZnWRXnmBrcGDo0oQnLLf5GMBX
	XeNuysHFvasGKT0jlrCJynz9ydgSUSwk=
X-Gm-Gg: AeBDiet0qy3/yapwUoKxwj3ytP+Tj2amcqmYmrY8Cz+ifWlt7K9GvAVC66YcHih50MJ
	D3uok3A70ulad1Rbl01/rp41dqCchDegs4cwgRBzja2IeoixjSHTnyaNq9wqKiLyWVrUiVINGiV
	qQ00x1ex0yREkX+P/Wc+GE0XQT1kX8W8HQWS8rpEz/qMQLzoG7purrBORW0g9zqQAbv/X6uHCD6
	MYBpklZW/R2yijLSogPYOpfWhAuFonzeYdZLe5QxXCs8Cwavt+EBKM5kqzfqompApfcgTjCJrMJ
	Agu39CSMhQ9//hnAMJNm0A3/EcJatDF6UBsnUZNn27nAhHulNUYnIh2amhBrsbaN8aA=
X-Received: by 2002:a05:690e:1341:b0:650:370c:d909 with SMTP id
 956f58d0204a3-6504868fd4amr24052318d50.15.1775747994519; Thu, 09 Apr 2026
 08:19:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408155638.95927-1-devnexen@gmail.com>
In-Reply-To: <20260408155638.95927-1-devnexen@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 9 Apr 2026 11:19:41 -0400
X-Gm-Features: AQROBzBL8FUn8i2X1o7D0pqyptla6siZrv0FoNEDlwQg8icOzCLUu8ag_DQGPmw
Message-ID: <CABBYNZLMMbjy5ZsravMc9pCCvxMKGPNPVsaOy76LdZTyFPkfhg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_conn: validate connection before BIG creation
To: David Carlier <devnexen@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Wed, Apr 8, 2026 at 11:56=E2=80=AFAM David Carlier <devnexen@gmail.com> =
wrote:
>
> Add missing hci_conn_valid() check in create_big_sync() to prevent
> a potential use-after-free. The connection object passed via
> hci_cmd_sync_queue() could be freed before the async callback
> executes, leading to a dereference of stale memory.
>
> All other async callbacks using the same pattern already validate
> the connection (e.g. hci_le_big_create_sync, hci_acl_create_conn_sync,
> hci_le_create_conn_sync, abort_conn_sync).
>
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  net/bluetooth/hci_conn.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 11d3ad8d2551..be522fae0058 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -2130,6 +2130,9 @@ static int create_big_sync(struct hci_dev *hdev, vo=
id *data)
>         u32 flags =3D 0;
>         int err;
>
> +       if (!hci_conn_valid(hdev, conn))
> +               return -ECANCELED;
> +
>         if (qos->bcast.out.phys =3D=3D BIT(1))
>                 flags |=3D MGMT_ADV_FLAG_SEC_2M;
>
> --
> 2.53.0

https://sashiko.dev/#/patchset/20260408155638.95927-1-devnexen%40gmail.com

Seem valid, I guess we probably need to use hci_conn_get to make it
safe to use hci_conn_valid and then on create_big_complete
hci_conn_put.

--=20
Luiz Augusto von Dentz
