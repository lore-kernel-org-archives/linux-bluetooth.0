Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9847B25333F
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 17:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617744; cv=pass; b=CX3gwQvxPCh23fpspYId6rjQolKTwFDF2rnXInGVzqxcTcg2G9oRln95KNMat+H2NPjS70c14pf2MZmiMoGNBvyJfhi9mZPpeeuMvlreXw5e/tBpy4fSsg1/O0VU9Z44Kc0dfE4tCo7LD14Ja90XeIbBoxZAdtT0FBAfJFc2eIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617744; c=relaxed/simple;
	bh=9gn3rZgfoIoV0/IZyyabm8JZKtD7h4h9nfltIk4+s6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7Ys4MSBD2At7x0lq7rVTWYQZX5xjl+ehTUWaYpzdD8CwQbkgd2tVoYpWaPtH+jKAqn6Po85TUNArfq/SAaMNLlWy8I/a4xjzuyUZRbFuLohs9qNpy9rmP72lyEwk1YUlp/C7nghQsnYKjEKJQ/vR3vjOMy6eV68gfTOdDzfMRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWV6ZuU2; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWV6ZuU2"
Received: by mail-yx2-f43.google.com with SMTP id 956f58d0204a3-66f7f72a284so3273924d50.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 10:49:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790617742; cv=none;
        d=google.com; s=arc-20260327;
        b=NU+SoE9ZhThUsDPaDprZ/0C8WbH2T275yhionhLb4KmEKUtEgk01tzyEViV89+nEOl
         Wy/Dmfdr7j4+zwJOijaYVufOYACT9vbc+oJBE2yAss3igdwqHvyTeka+7Q9c6eJBL466
         BqdQloHgmb1SZ2QpNFXE3e586mLSlpB0dkkB2UOBWOjPKDRVDL14uVi1pW2ZhJ5Vtil3
         hztTcgyuAweSEt7j9uP7cVW9+Xl1mH/1Zwiqhy/b+XM6yHKJfJdDxeILvq5M8OQxCdY6
         K8jCjxsXX0jkSWmYPAowAdG8/+x3GDiCHjAiA662Q0mBwYshSI6aI+znXvHoOXDN2JUl
         2xaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g8kGHDFFIpZUwGkuSsrfOJ/pd2BFiFnaRnWtUdMSpK4=;
        fh=7D949Lg6u5H1QH8oRhEwlKthqiBYbKT3BI3EAksmOXw=;
        b=i5mzIpACcnGbpP1KrFKzcQWqALZcnf0/vKwURFncoI05OjU5dK6/IVa4v9YPHU+sbh
         fBSLicpwJt57qJfS4spO8HeI9h/e/sX8Lp1gvJ/V297NtxYqeHkf5a/slcdCib5RS1gc
         WgzxJYokrGROlTm54XXSHeIdu5NxqRwB4diHgtkZzMkTk8cG/zpEKlNKOJwMqKLvj/QU
         OMlvkQ5bktQujSg1UW/awLch9rzJcvVeGmIvtYMrorVIFbUwCKpDmXEmwXGS1uVHx/jI
         bErtcRf6CgbCdcvGZrokysnONtWa5xUlXssBVOgg8VojT0yQ4jk/VCxmaD2OFksAZP7u
         Q76Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790617742; x=1791222542; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g8kGHDFFIpZUwGkuSsrfOJ/pd2BFiFnaRnWtUdMSpK4=;
        b=LWV6ZuU2TAEe256V7VlQXd/okKwZ32B3LTae8atTBCZ68PS+G22vuLO8DN5G8e5wKF
         1h8dyfJRUwHxtZq4hq6l5m5N969EGfvb2T9CI06l7JdixZCVI0UX7ov6z4DXz8ys5gtn
         o1TGM//r1zQ6E0a5lsdOEjBrpNM5fIr3ws0zsOHLM2OH0msMxyFvZKFvsf/YD3yXlLLX
         RI8hbMauQp5eiGA6aCBC390NT1TZ2qgXmvFRZmOHyDm8zupwaD96yo0ZLVBKCR6j1joq
         Zy/YcRWMwzOp5vCv6UcP7EIds2jSh9+MAMll9pbTRlVA93S1qmjSinzzGfGhppiRCjT8
         Byng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617742; x=1791222542;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g8kGHDFFIpZUwGkuSsrfOJ/pd2BFiFnaRnWtUdMSpK4=;
        b=MsWIT3gy7eim7b8Hv/JxLaBEoJYBGwc7Og6w0B9XMd4zUMJoQzVLSoifEWf2QE4lsA
         AOaPlf4C7ulC/aMiQn8ntCMg+29k7E0f9wA3GrWgWXSqq+BzBMcdI4ixOYnxceWz2nCA
         faD+erjYUJ82XZVgXFT4kDF84IppxH7y7Vp/rbHLwXBJNVDt44R7M0LC5XUkjzKcTCL9
         3AtrWk3dFT7lOFDTh/VCMHdLyLxaRkK6ErmeMk0GZQVC+33yyPBXMf7ppjascPmxfXsd
         kXqNa4JSvcQo/6NcIaVavXxXxA/bABKpT4WbWRUxm3kYsFqe79WdM9fqh9z/zhHmSGgy
         roWw==
X-Gm-Message-State: AFq9FYJv6vtgYAzSXRtYBoYDn5+JcfQUzkRQu9alk9LYERoAeWC+CDhE
	CeZMx0vPXGLoKHohRZSpHryMG3q+iX0hkI0dmJjauQyejak8aBbfAHAwd3OglkkH0r3z4TXidl8
	aQTTMv9z562tmioxTxV9kPPa1oMBLeS3RiRl34h0p3g==
X-Gm-Gg: AYBFou33T0911TKS5BUfEuJVIjzAfd+46egRQF/fdJKsS9g/96U/dzNfC9/5TkSNEz2
	Q+e6TAj0O2pkHtgVddE7NZBMUvOvr9fzc6GEXNSiMCSqtIv+nyarZmdctZISxgKcfp8IT7Xzchm
	Z9U1sYGxPlPJVbRk2RVCO6YMNZFYwDY9VUi4tep/mZcP7BYtb86J0764svddkwPCHqReqzrlwdM
	DC7pvYomvCOc0IT2Y+9Om0CzmRXBb8Lb3uK0xXdIi4gvkUvLckdjy8MFdb6R5dHT+oMSQyArisa
	9HKy00cQ0cDmIWOECkrMDNjHxDDBfKpVbGqTvh8isVUzXNOCWUkR+XFqfn0Yp4e1xop2r4HXjam
	k8xCYWF6IrbKQPXISOzpnqTJAUriloIOMCWKNt7YWvDkydrmksGtE
X-Received: by 2002:a05:690e:118b:b0:674:e730:f133 with SMTP id
 956f58d0204a3-674e74f7de1mr3075373d50.6.1790617742430; Mon, 28 Sep 2026
 10:49:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACmoRBYhQg2kAp04fFeNyArgQRoMHpBwpNX3b0-1knp6RiLpWw@mail.gmail.com>
In-Reply-To: <CACmoRBYhQg2kAp04fFeNyArgQRoMHpBwpNX3b0-1knp6RiLpWw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 28 Sep 2026 13:48:51 -0400
X-Gm-Features: AclHuK8BoacrsBbxuv6mpea3JJ4e9FgQYT0dh7T9PZIfQ_zu0WtGyKN9k6JSYGE
Message-ID: <CABBYNZKb1cr85s8sRQe6LQwhmqeApAs26OaDgV_fJpNQu=ViAQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] input: Reset report map state on detach
To: Giuseppe Piscitelli <ooonea@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Giuseppe,

On Fri, Sep 25, 2026 at 1:42=E2=80=AFPM Giuseppe Piscitelli <ooonea@gmail.c=
om> wrote:
>
> From: Giuseppe Piscitelli <35407790+ooonea@users.noreply.github.com>
>
> read_report_map() leaves report_map_id set after a failed read. Detach
> cancels queued GATT operations but retains that ID, so a later attach
> cannot request the report map again and never creates the UHID device.
>
> Clear the ID when cancelling GATT operations on detach. This also lets
> a reconnect retry a read that was still pending at disconnection.
>
> A socketpair reproducer fails to read the map after either an ATT error
> or cancellation before this change; both cases create UHID afterwards.
> The existing HoG and UHID unit tests also pass.
>
> Assisted-by: OpenAI Codex:gpt-6
> ---
>  profiles/input/hog-lib.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> index 6c75c60..2b6dcae 100644
> --- a/profiles/input/hog-lib.c
> +++ b/profiles/input/hog-lib.c
> @@ -1908,6 +1908,7 @@ void bt_hog_detach(struct bt_hog *hog, bool force)
>         }
>
>         queue_remove_all(hog->gatt_op, cancel_gatt_req, hog, destroy_gatt=
_req);
> +       hog->report_map_id =3D 0;
>         g_attrib_unref(hog->attrib);
>         hog->attrib =3D NULL;

There is a set rewriting hog-lib with
src/shared/gatt-client.c:bt_gatt_client:
https://patchwork.kernel.org/project/bluetooth/patch/20260928173243.1073509=
-14-luiz.dentz@gmail.com/,
it is probably worth checking if that fixes this issue for you. (hmm,
that seem to not be the case because there is no use of
bt_gatt_client_clone to track HoG operations and then cancel it
properly on unref).

--=20
Luiz Augusto von Dentz
