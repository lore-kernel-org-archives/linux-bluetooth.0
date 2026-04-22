Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD8031B838
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776869729; cv=pass; b=IHaPJ1M8V3eu1x43VnopAvtlA2fsRgsTsB1Pi/qFfuy3GUHTMYUwfLFbf+OYbqkvbdNMcqBiUo8SfGvRLv3DHCqezIvAFz+LDkO63dofxQqOgO+0b1Fe01wb5p7hLOaMFOpTetrzvp6lXceYPLBjyezuFbllXf/NY2bU5bnaCUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776869729; c=relaxed/simple;
	bh=sxWNNNm4OhjEBvqkCd6cvqvp1L0Ly+3oFpjThcfqews=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QKmrE+9hFwEO0u6nYnakZPtB9+f6GQeBsGKcyQ7c3qheq2oRHGDXB7WL1VeEMtnTCCxBT1QjvGxWy0KnS+0khGR89T/l7xsa/Z+QdhMsVBZpwfwyaKrn1OGabEFdMkreijPNsTlKdSBgks47+h1l+aND0sXofRxO7phmqND2XPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Afd3tI9s; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Afd3tI9s"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7dcd89701acso1481778a34.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 07:55:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776869727; cv=none;
        d=google.com; s=arc-20240605;
        b=h/RAK1Jte1Gyk9H64/pUkpIZQNNPfl1jfKmqzINoMhVS/f3hvAMXhhCi0AzEHnyYE9
         4F9j4vhPOqhksnWqPVtpfXiy/lvq1u/BrnsH/1h8Vh1TLXE7cPvgYpXMIu7ommafd6DA
         9Z2GtQugUD+K6LS0uXzuPVnrv54CL5vycJLcrkyTCvgAUsv0fkfr1GX0zmPbFi8KWGFg
         XQzQIF7oYa46aqpmOxp9Y927aFQpJHEyc0uz36TikLOTC2jMkVoc0VxggSizZtK1EU9p
         ovWzxI2iVjLeLFJ9f/oce7ouxIgc29tid8dG4Sg17549bt3FEMefAgdSfJozDI8/whnH
         BxkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=skiZtCI+2ukMSBQXmgFrdEr5KIKxacZ9t3hVb/L8kz4=;
        fh=DoFTANPsovvNqi36N2SffNZSwrczNwsb5SJEyrVPSBI=;
        b=YWsbRzRf0NVV+TEQCxgX1teImizlAfGdmsK+DRQ3Y10TvydrQDjCOsPQ5s0i8D/aH6
         SaFgJQ4k2bsm4/bV8iu7KrpVBJ40gRghBCCwg97oblFrKrUSgRUbuPK4KfmkkLDwHJCh
         sBW7QtDt/7stuhk6IFarAKX1h/QXeFFjKOqdVO0pq/SWcvqYi7vK3/cVPrvTxyfXsn5B
         qrQucEb0+2Wzim/FdnL9z170fk2Oz5nolyXt7zZmRtVYec3HzHAnDNGEGiADxLjYEbgw
         n47Olj+p5EPMn4wcfgge5VQyNJA1PgsYd1piwlS6YsEgT0nzfgpbizjI+VF8STM+VeqG
         0A6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776869727; x=1777474527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skiZtCI+2ukMSBQXmgFrdEr5KIKxacZ9t3hVb/L8kz4=;
        b=Afd3tI9sr4D60WFRy/WRpiryBuSz7IPdTuCCqPYofTNy4jICYeBybD8WAFYYTLRdr8
         P16QLNkjQftyyEgZ1TvngEgPaIrLZefsYK2PKMf0kbSamjfXllnWK9AmKQdAdbyMm/9f
         q4M8U9aZ18a8HRvLOewdGFKoVyBQurMVs+7p38drgNkIuURmh5966t5F6gH5X4iBTnwr
         IPCZnHvH+ZINKWeYN+bgxup8pC7Al6g6hDQP5ygkCG0pOGQorm/sBDl6ckHmV+u9LOoj
         LIEmMVbek7vKN0vx3mLs5g049E/Drj4biSmDucx7ojUyfAa+8RUYFhsYel91wRp0WY4J
         IDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776869727; x=1777474527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=skiZtCI+2ukMSBQXmgFrdEr5KIKxacZ9t3hVb/L8kz4=;
        b=pqedm9AtvLNQP4yApjjM+XZ/3e4D4uRMFc11ufP9zPQk8AwWAnjwAR1Rb0lJ3VQj9s
         MKAgf5bi1cHW/efZ63i0J6YFfxRG68QXAHmvU0I3w4En55AxPEi5LuDeU1WyRQlmUMYn
         +QXmrK7GaIHycY9AkroPU6O6HAoewuQmKAQtR7vDPhhyDSTKG1FxHawtDXRrbHoQIyWe
         PRXeHOU/jCMeTnAGURl3pRyYg6IkwBdyYSvCz3QtHims5bxUK1N5VdNrCo32FqYNNOnL
         bqiaKfbVuAbHAVoDEwx3bl3vo935rX4nkc0RRjUamuG/0K89ZtzdOwKQqgD8luVTuFhf
         yRqQ==
X-Forwarded-Encrypted: i=1; AFNElJ+X6Ajy0uHX9TZCBOlG3V+XCVMf7EieLG0UvWQqxuwQCmolc8nnP3smbKx4fN/nLDakftCBYoIr1KNrmUhBUbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvpqNdsGEgXWRZL/cENdI7/KWrDyhCtsrQbzzmGoQTdsozLnMA
	RT/dJRFkVrAzZ9d4b6PfyTHm34CUQjGlwxpK51Nj0HZipCsDaRAAb3KS/juYF9ORXSSRqco/G/3
	YZDr4Nw2T52vgnxt5sdZNcH3zgp5bG5aobRIIjvmjDA==
X-Gm-Gg: AeBDiesDydftDEv1hEV+dOpedt2SVfkHmp0NQ8CkEwh7GGI9/viVmAEioYGu+WzNbGy
	2S7/a0gI+Wt/61EZYnFFLwbSjdlOcGHKdh6XuDnhpWa5yl4jupkXwa9qOWqv7lyuwvsoIgn9D8G
	mcgmr6jWBy+lYpDi0MoegmlTofyJ6CMoj7/bRvGL6dLNjiXFORWb/Eoy0Fd5XJD546HyavlGhor
	epnT3gRk32fhOU2LIsZ3+g7iIZYUR1Gx2CKL2o8YEZCFdyeEnSJzSqp9pppUvsVKlmLWRUtUjWQ
	qu6x3BUG5bmx3Sx71Pa89ZFCxY7TjXpzw/InM/9iqcSIfDeEQRtfhIefT1q2PGJSLtDz9smKXW0
	0dg==
X-Received: by 2002:a05:6820:f02a:b0:694:8ed8:e59b with SMTP id
 006d021491bc7-6948ed8ecedmr6383186eaf.54.1776869727165; Wed, 22 Apr 2026
 07:55:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306023155.554597-1-luiz.dentz@gmail.com> <20260422011437.176643-1-michael.bommarito@gmail.com>
In-Reply-To: <20260422011437.176643-1-michael.bommarito@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 22 Apr 2026 10:55:15 -0400
X-Gm-Features: AQROBzD7LKT2sd3J2zt5CIV-e4_kPLOQbPX9_xZOexsCmxwtxczbFFiTb9BNw0A
Message-ID: <CABBYNZJu6bGZadWc10g=ZJPHoDZ_RKDosCgasow3oRpQchYZvw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: HIDP: guard session->conn in hidp_connection_del
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Tue, Apr 21, 2026 at 9:14=E2=80=AFPM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> commit dbf666e4fc9b ("Bluetooth: HIDP: Fix possible UAF") changed
> hidp_session_remove() to drop the L2CAP reference and set
> session->conn =3D NULL once the session is considered removed, and
> added an if (session->conn) guard around the l2cap_unregister_user()
> call at the kthread-exit site in hidp_session_thread().
>
> The sibling call site in hidp_connection_del() still invokes
> l2cap_unregister_user(session->conn, &session->user) unconditionally.
> hidp_session_find() takes the session refcount under
> down_read(&hidp_session_sem) and returns; between the find() and the
> call at :1421, hidp_session_remove() can run on another thread
> (driven by the remote peer disconnecting or local teardown), take
> down_write(&hidp_session_sem), set session->conn to NULL, and return.
> The HIDPCONNDEL ioctl path then dereferences a NULL l2cap_conn inside
> l2cap_unregister_user(), which acquires conn->lock without a NULL
> check.  Result: kernel NULL-pointer dereference.
>
> Apply the same if (session->conn) guard used at the twin site.  No
> functional change when session->conn is non-NULL.
>
> Discovery and verification:
>
> - Found via static audit of every session->conn read in hidp/core.c
>   after the referenced commit landed.  The other reads are safe
>   (creation-time in hidp_session_dev_init, already-guarded in
>   session_free / hidp_session_thread / hidp_session_remove; the other
>   hidp_session_find callers do not touch session->conn at all), so
>   :1421 is the only remaining unguarded site.
> - Runtime A/B confirmed in UML with CONFIG_BT_HIDP=3Dy + CONFIG_KASAN=3Dy=
:
>   a late_initcall stub that injects a fake hidp_session with
>   conn=3DNULL into hidp_session_list and invokes hidp_connection_del()
>   panics on the pre-fix tree at __mutex_lock from
>   l2cap_unregister_user+0x2d, and returns cleanly on the post-fix
>   tree with the new guard short-circuiting before the deref.
>
> Fixes: dbf666e4fc9b ("Bluetooth: HIDP: Fix possible UAF")
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> ---
>  net/bluetooth/hidp/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> index 7bcf8c5ceaee..9192efd1b156 100644
> --- a/net/bluetooth/hidp/core.c
> +++ b/net/bluetooth/hidp/core.c
> @@ -1417,7 +1417,7 @@ int hidp_connection_del(struct hidp_conndel_req *re=
q)
>                                        HIDP_TRANS_HID_CONTROL |
>                                          HIDP_CTRL_VIRTUAL_CABLE_UNPLUG,
>                                        NULL, 0);
> -       else
> +       else if (session->conn)
>                 l2cap_unregister_user(session->conn, &session->user);
>
>         hidp_session_put(session);
> --
> 2.53.0

We might need a lock in order to access the session->conn:

https://sashiko.dev/#/patchset/20260422011437.176643-1-michael.bommarito%40=
gmail.com


--=20
Luiz Augusto von Dentz
