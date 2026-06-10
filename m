Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA52028FFF6
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781096737; cv=pass; b=MCeut5SlNVxxhIab4HRxkkrA8QsmC0hUvd279xBANu1vK0t17R5jJW16o7d78FXL1rTWk3pOGPK+VOHkYud01hUWGvgDulVD1xOqOOxOGjj7rzf/MM/LF0i/YvUEFJvkhHaxGRAPX8KU0rBphfXa20vwPKub1+0iXrgNgBS+FcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781096737; c=relaxed/simple;
	bh=QHUqVSv2KaaURqb9cPHR7aND7tqFpUEAhdFRJWdcb1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qt1Zbl2sby20x58LvtVcgsIAe1jH5vcIYvXJpPG/oJ9dGqbAvYafwQ+BH2HJC0fxpdiFhjw1buDKrAILJUVeXskiDwW5HW6MLPByypjiGvTKUyIEG8ik4RE5FelC44yL/q7J3mRn279bcW60Bpw2iUv/IL4cNfgaIMyCbv9fFEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iDWiPKVy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pbZMc/Xw; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDWiPKVy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pbZMc/Xw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781096735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G2D3C9qGXxnBkSiArm8IjX1qpS0bzoF+XigWv7ieCiA=;
	b=iDWiPKVy/VQNbsXOjKvEYGaWY8dc8b4PoQnAnDI6pGBB2ousEYSHxGYsD1jWj7MDnvWjcK
	65Hf5nhz2o3yq8mwhQJ5tJY2I7M/A+jfz0058G+K69sQSR4tS0PxmaMSVcsmMrUttBLOEb
	66n/fBIuMWoDIM5TvgM1vfA+faNuCVI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-VzosC5kSMNuIRzQ7z4tpog-1; Wed, 10 Jun 2026 09:05:33 -0400
X-MC-Unique: VzosC5kSMNuIRzQ7z4tpog-1
X-Mimecast-MFC-AGG-ID: VzosC5kSMNuIRzQ7z4tpog_1781096732
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3967754fcf7so28432651fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 06:05:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781096732; cv=none;
        d=google.com; s=arc-20240605;
        b=NQFUjej6MSlYex7APgS9eH+rpPBs6Xvq5tOc9LLUfDIBjBGo8Ub+8sidDIV6Svgt49
         b2WMczs/++7LtcWFVm4poGbVWVSO7eS/IxiVTMY75Om0JtY7173UsrFXeyP+vvcs11PF
         SrDJx+XeFP2o8ahnvt/BDQjPa61it8XQWydRfoaKZeE6HSypnVfOckEgG2JmxZySpwfK
         3S6s8xx/X1A0OfGz7AIMCWVrypSvz4xQ/du5BxlF7tFUuz4ifpKepNX4l0uh6tJFyvGO
         r7u2QMlc6t24BlfEmIbK/pvTdrda5aTPx9K0YYzYnMdGQJAaIUIY6bJFtjRPSq14pZQs
         3fvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G2D3C9qGXxnBkSiArm8IjX1qpS0bzoF+XigWv7ieCiA=;
        fh=ED00QSh55h0fJ4iyua95oenxdgMT2u2G3qCz1hcMnao=;
        b=X9BCYaU7wVJMJqTiE3iySBjQP4i4H49BdBB6fz8pMuu3bpS0lScEq9mp//tsIpiNQ4
         e9TlTXa/ZeWv4O6tvwUY3RKKB+ja/DfOsKtPjTQga8sEWyXJH/opdC6NiI5CuyyHwKwm
         qCLiyl8cJjZkOtyOeb1+7nUTTTURrJB/VN6XgZvIVYlvUjf+/M0AtCHcSKAa1uvamoF4
         M+YwoK3Ig5EeRRKf2oLnOLro38Sae0fm5lNLYKzNolYMQa6P5ijUl37NvxBGrmHTrLa1
         1FPZ0WB3XrmwPJCeEMg4qcjRuEep/FT6mmVE5eGpwTN7nJZ+Bq1Ne5jLUv6jKHr9PG6/
         pt8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781096732; x=1781701532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2D3C9qGXxnBkSiArm8IjX1qpS0bzoF+XigWv7ieCiA=;
        b=pbZMc/Xw+cPI5jy3mjU1SS2z8qNoejkT16j3tFJa1c/2w/H79vvfg1xiLjjrsUWccp
         ivurrxwIi0A/sIfXvtKNKXHGiXqO5lBB9sOtdMSfuQ99a9A9WxDgfzC8vX3+OJEDnBhU
         2onfxob1uNwfnPDYaSzG+EVflq4NYkhGtqTMVBfS0Gp1pZftiL/AHqEFahSnBs5RBlyk
         U+YFYD11zHaj3DqbGWL/0pVotQGTgcnJTZ068WANRNl8DFO9K1DAwziGLIU1lH9BpYhp
         TQOWXU+dD/drm/4OR9zjqJkkSBXzehx1OzEcFqMurxWDwRp2OQcAoCG/fYu73sUI0+R2
         3CeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781096732; x=1781701532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G2D3C9qGXxnBkSiArm8IjX1qpS0bzoF+XigWv7ieCiA=;
        b=ZY6YIFTJ1Ch61Ryr8jOBJ+HnBMIjsqBV08y56eBn+ZJBDKtEc6GBugQCH7fl0IqElN
         vi6mCpoO/7aK29xIjIcABF6YF6+mV2ar/8G21pM+OjeLylwzps0wOn5lsW4P3ZqTcQBG
         JPEL+TDHglC7WoqYW4b+LPrOJ5poV8yVcFaU5g2LcvZVexdQcmNfgZteV0CSji61Kz/u
         4zqYN/ddwE8QjivL6eH4hkvIgkTHGlaRVJmLJoEfcKWymJcmyJ3RD4nzx5TBA33hBfT2
         FNJRVzRSspeS8eLoR6mETqGWrfu3XxOFlNgvF+jPmYQXPtKCe/bEz2L3/CmLNYWEXD+Z
         R9TQ==
X-Gm-Message-State: AOJu0YxJ4vVQ5Brs6RFpYhBl5tpnaJxFdtSL/WnufeCLjIosre3jc80s
	6KLE6hrwLQ5YqIrsI9VsUYhyVHNhV20a5w3Q5u+EzU3VyX8yxXiGbLxcZLkCEsWkODCRHGFKvOZ
	LG1aBZap9PMHa0xI3KD77i3V+DTnf1aQsFlHjkHCraBcN/A1RsuZLtKhLcI7sZMNi5ht8YlGdWP
	MPDMlVM9Tp4A0FR/O3RY2s+zlbNl0tz45DOaBwbyWfgaNc
X-Gm-Gg: Acq92OFYQ+cYP4IKtLStaL2f1SBBtjBtYusvriMD0EjqZV04Ecb5xJTvtdxFttOwiSk
	YymEOpTdTVOy1FSWNJ2o9EgAJpwysYd4RQnkZL+GPtw2PDolyrOEZsvXzcKKNz46YMMOmRLEAYW
	wUznE4e5/C+bNDTwxHqsEXOf/3V/iEX82pKlZX6QO0/oJQD74WLIRKiBtT1YAnlYivE9Vk3WGFX
	AxmJ0bKnyX+fFhzAWA1WTG4tdvPj+JTaHspYM7ysjjcrai7
X-Received: by 2002:a05:651c:30e2:b0:394:987:945e with SMTP id 38308e7fff4ca-397f76b9dcamr15846041fa.1.1781096731867;
        Wed, 10 Jun 2026 06:05:31 -0700 (PDT)
X-Received: by 2002:a05:651c:30e2:b0:394:987:945e with SMTP id
 38308e7fff4ca-397f76b9dcamr15845841fa.1.1781096731250; Wed, 10 Jun 2026
 06:05:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609080054.4541-1-zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <20260609080054.4541-1-zhaoyz24@mails.tsinghua.edu.cn>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 10 Jun 2026 09:05:20 -0400
X-Gm-Features: AVVi8CdjmsGRE34cD71VHNMaCGfKHZ-mvsXk7Qa_Y4MIS1SxRudAtkLHluKhK4k
Message-ID: <CAK-6q+jL4D6cCwJYr3AMb_h_gVxCamNrG=bRrEczhN8PVRVPOg@mail.gmail.com>
Subject: Re: [PATCH] 6lowpan: fix NHC entry use-after-free on error path
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: linux-bluetooth@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>, 
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, 
	Ke Xu <xuke@tsinghua.edu.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 9, 2026 at 4:03=E2=80=AFAM Yizhou Zhao
<zhaoyz24@mails.tsinghua.edu.cn> wrote:
>
> lowpan_nhc_do_uncompression() looks up an NHC descriptor while holding
> lowpan_nhc_lock.  If the descriptor has no uncompress callback, the error
> path drops the lock before printing nhc->name.
>
> lowpan_nhc_del() removes descriptors under the same lock and then relies
> on synchronize_net() before the owning module can be unloaded.  That only
> waits for net RX RCU readers.  lowpan_header_decompress() is also exporte=
d
> and can be reached from callers that are not necessarily covered by the n=
et
> core RX critical section, for example the Bluetooth 6LoWPAN L2CAP receive
> path.
>
> This leaves a race where one task drops lowpan_nhc_lock in the error path=
,
> another task unregisters and frees the matching descriptor after
> synchronize_net() returns, and the first task then dereferences nhc->name
> for the warning.
>
> With the post-unlock window widened, KASAN reports:
>
>   BUG: KASAN: slab-use-after-free in lowpan_nhc_do_uncompression+0x1f4/0x=
220
>   Read of size 8
>   lowpan_nhc_do_uncompression
>   lowpan_header_decompress
>
> Fix this by printing the warning before dropping lowpan_nhc_lock, so the
> descriptor name is read while unregister is still excluded.  The malforme=
d
> packet is still rejected with -ENOTSUPP.
>
> Fixes: 92aa7c65d295 ("6lowpan: add generic nhc layer interface")
> Cc: stable@vger.kernel.org
> Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> Reported-by: Ao Wang <wangao@seu.edu.cn>
> Reported-by: Xuewei Feng <fengxw06@126.com>
> Reported-by: Qi Li <qli01@tsinghua.edu.cn>
> Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
> Assisted-by: GLM:GLM-5.1
> Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>

looks good. Thanks.

Acked-by: Alexander Aring <aahringo@redhat.com>

- Alex

