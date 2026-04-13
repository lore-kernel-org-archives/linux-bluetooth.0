Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3133318ED2
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 17:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776100598; cv=pass; b=bEjiViGbsOnzlOfJhjdPOMJFOiAhHDbf0siI3120ti8Y1NnN/qARukWvoX0Aa9Pout6VNgjxQNjCkfcd6jmbZMaBiUMEf/+oeCxPUmAlTtENItctFCDofjQgLtIpWKOpIhoEhOvCKqfSZeEyOEwILzlg473iusnbImqZL3qpyM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776100598; c=relaxed/simple;
	bh=a0vzy/oooun964RoWrHs1qqqty9bGG/iGDcYxZAu/EI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KG/rdzH0++5YdZi3aZc9vaVZV9q82fpB9jNbT0bhEfMh7OVs6vNQSxVuk7g6YBamSs77CmLTPwU0KR1oTB8tPsXW5VVYEhoySRlLri3MDZea/1syxFa9pEFxvJaTVihcAD1JukBtBYvrkeVEYCc7Uq94Ws/BlKPHMX47KDZcX2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oD/i8S4a; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oD/i8S4a"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-651c3212b0bso747369d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 10:16:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776100596; cv=none;
        d=google.com; s=arc-20240605;
        b=byX2Stn29452IfiJhM1ZCXs1WZ8QZLrDdSSWa7PS/Ay7Kt+fU4sc/bjRLnVmc866yN
         mS1pgRciBQRZdGubKTdskShWWtNrF/BSNAgReu7KDpgyuWe/uSQp8eDERkBE08lb0p3E
         HWUtuASRa/mdP3u7a+YznCW+0BKqL7ErWp/Rhvbyfcy3bg+ysdWShytmFPi5TtBurzEd
         axIhmHXY25nYIc2+FINpXmUi9r1hV9vHkGq47sneVJ/vUdi3V7LM+QMJxVgASP/V9ha5
         PEJa2rjU+7yli4Le+E/1DG5oYk9so2nfY+imygDk82Losm0SKU1AjH5vT0BrJSuIkR1y
         5W3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=idw0Cb17Pj971s6GmxsQbqxvtC0xq6BDpzgxMkIri3w=;
        fh=PeOzssJ/43VGRrnsaH8Dm/FjC3UjwiDRNKAn3gtAkUw=;
        b=JsV7FNkbDcN1EsTK+QG30pma8grDdNMLCCAIhqJJuaq1EndqwTvjx7E7Zri/M0J2xH
         KPO3FfgXlFuP4bVQa+VsQTjhsQr92+YqakhjvZKn9uKTXTXsePAzEb3qgp/GpZLVnfnQ
         4ih4Hg4K55pVQcnxXQ7JTcKGo+SVQ6lZyq64/qztxNWp84IMQOnrmTB0ky8yeZJ38yNp
         mF6nVtVfnMNOHjlTlmQ3nCKUjCwCNEnzWPt4smqwT4yO+ttIYTMMbsMWLyojB9dTZ8te
         QWCISBCghHpGGrZKCXq4QdxnIU9Np3Rxk3WlvysBgisWuzFxUJ1+C8oz5i/K6+UidP0A
         J4eQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776100596; x=1776705396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idw0Cb17Pj971s6GmxsQbqxvtC0xq6BDpzgxMkIri3w=;
        b=oD/i8S4ay6XD3sR/vaT+R2A61/cCQAU9DxPQjGLHpmS672qlYln8ohgi1R580wb0Vc
         Rl21DzKmOUmuEEdckAWnusy8Ywpzibzh2RBy3c7rM22Mzl1YmU3l4BB3WrTXtvyvzRjP
         nE6HaTx2OIpCnKn/1dI4MfJbZ81vRUkXhdFsqHXyPKiAjDuOwU43aospyJZPtmB8MDJ6
         peJglWGnIYp06PScl3u/qcP73g2g2LT6PaIAGnr3Jrfi1jPOvLefASDqu1xBnk8VSpPt
         iya1/bYC3utLZ4CZd/e2SKStNyD1TWAqNxMW/JPPVK45Lbu1h1IdtsB7s05dwD3XxQdQ
         wRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776100596; x=1776705396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=idw0Cb17Pj971s6GmxsQbqxvtC0xq6BDpzgxMkIri3w=;
        b=sna1Pa3WIk7DPqsHC+QC6HqzeFKfb/54Y3JA6YSUp+8exN6SWR7LBRuA6/Tw5VkM7Q
         3qaBpVCJFzGAAplb5wdLZDoiECSerCvKEbG0Ddq+Eqfxq0zmA2Ya7nfc0+Wa5LAvnhkn
         mFVf+SO+PryaEyKdcSmx4QUqVgdQ+HVTz4ewszGhFFTocWJkEH2nIO6DAwTrSVpS4nCI
         Pz1asaH1lGa3cEs7JuTMhVvjhNAjLtn/5DeqfuiUxEFZegQPnsRoUyXNnVQpMmtpv1sD
         9jJTmQ1gwS6hkV2J+3ZLW+3mohbQ2EG4hoyIa+Ch4p7CU91oYK8YKatBerNXSzo83C5g
         LScg==
X-Gm-Message-State: AOJu0YyQZ0EmMk4tfRAComT/1Nvy6F8BgPeCNaquTkAeoPimX0MRCxp3
	LG8Ul8NXQ5GaCXYYalm9NOzP9RIoFwzbj3NdICMyzkaiDrCm8xenF+VXRQ5xql5UsOf8W37l8Ck
	T0588Ia7EqHXvS4qPsYEeZRRCFMkv46FhBugu
X-Gm-Gg: AeBDies0BoNdw04BRnNxEmXdKP42tWhiJuyd9ZHchL5UiIJlYPeb7OjPsXQwTyZNbBe
	Oc9L2kr2AcR5Qw3bqX6XMWqSsuOhoJvOxrkI7gbcw+BL1RKCPlRDpsnpEWHILDi5zmxP6R7YbsD
	wV7wKP7SgK4mrAe6MsvxJV7+3+kL64qc1t2cKo75jd5WB+n14TrNC97tylE24Hh9Lug+GBKYh98
	mcs7cxuSdU5sjGo16j36mSmODcrGmbEShiE/OIM9m952YtRgCuO5ysDKi1X57QIAkNvXn8OtA6k
	cmg9iy25T6idSWO4Sr/ofuX678JZ5kWaQIocu3iJ9S3p2PLZIBAO6nIj7otjylecNfMsHw==
X-Received: by 2002:a05:690e:2416:b0:650:14bd:f34d with SMTP id
 956f58d0204a3-65198bb5258mr9834129d50.52.1776100596012; Mon, 13 Apr 2026
 10:16:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413085600.75248-1-phx0fer@gmail.com>
In-Reply-To: <20260413085600.75248-1-phx0fer@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 13 Apr 2026 13:16:24 -0400
X-Gm-Features: AQROBzA9Yn9QUXbaridSgHlrHrwsP_HxxRUww9eGEK7uWNS7l68K1KoYCMHDoLY
Message-ID: <CABBYNZ+Ya4FUvA3mgXNVtXWA92=jjtj0GfJF8mJ0hMaC8C2_uA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: l2cap: Fix MPS check in l2cap_ecred_reconf_req
To: Dudu Lu <phx0fer@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dudu,

On Mon, Apr 13, 2026 at 4:56=E2=80=AFAM Dudu Lu <phx0fer@gmail.com> wrote:
>
> The L2CAP Enhanced Credit Based Flow Control specification (Core Spec
> 5.4, Vol 3, Part A, Section 7.11) states that if more than one channel
> is being reconfigured, the MPS shall not be decreased. The current code
> uses `&& i` (loop index) to approximate "more than one channel", but
> this incorrectly allows MPS decrease for the first channel (i=3D=3D0) eve=
n
> when multiple channels are being reconfigured, and incorrectly blocks
> MPS decrease for subsequent channels even when only that single channel
> is being reconfigured via index > 0.
>
> Replace `&& i` with `&& num_scid > 1` which correctly checks whether
> the reconfiguration request covers more than one channel, matching the
> specification intent.
>
> Signed-off-by: Dudu Lu <phx0fer@gmail.com>
> ---
>  net/bluetooth/l2cap_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 95c65fece39b..b069f965a339 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -5428,7 +5428,7 @@ static inline int l2cap_ecred_reconf_req(struct l2c=
ap_conn *conn,
>                  * configured, the MPS field may be less than the current=
 MPS
>                  * of that channel.
>                  */
> -               if (chan[i]->remote_mps >=3D mps && i) {
> +               if (chan[i]->remote_mps >=3D mps && num_scid > 1) {

Still seem to be wrong, this should detect decreases but instead it
still flag as an error if reconfiguration has req->mps =3D=3D mps:

https://sashiko.dev/#/patchset/20260413085600.75248-1-phx0fer%40gmail.com

>                         BT_ERR("chan %p decreased MPS %u -> %u", chan[i],
>                                chan[i]->remote_mps, mps);
>                         result =3D L2CAP_RECONF_INVALID_MPS;
> --
> 2.39.3 (Apple Git-145)
>


--=20
Luiz Augusto von Dentz
