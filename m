Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64021AF0BB
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776786662; cv=pass; b=CmbQlIVV67l64iuEDJU6oiVSTaGuf2zA6El40vS1sHZhPNFx9pANOV1gZictPS4oaweRU4qo27ZYVOcHAAY6Un0g5pDmQ0EkCOLGoov4GzVoC8gjBdiaHpP2YubAtgzYkK2dNUNSPExYiNbv9AvxIkESlULWFS4318ICUgf2A7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776786662; c=relaxed/simple;
	bh=U4CXEOtSoYorkPvRqPYq8ArpjdquGnQvRmO5OCcs5+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oFA5ZHmI0aPFvnMBEX1SyEtXqqmBs0iwIoVgDJDHgJfcp27YOYF0XHOfWvch81CVJg1DVJAbxxE1hMP1rOslbUkGJFHe3eassbBailr42hq9+ZaBI/+eTwWNNqNgAyzALP8RPsmjG41Ae1uzHt+/atCgTtil3uvajkrXeM6WSdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlstgX6a; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlstgX6a"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6501418152cso4043628d50.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 08:51:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776786661; cv=none;
        d=google.com; s=arc-20240605;
        b=cAzs1UL6pwqUtfOoiLRSScfgYo085ysxLzIZp1kxBYEp+1SywIGjP1SaS+p45bg22w
         HOyqoAnQWPNLGKalu25GPtjWGuQ/wYDf5AKaURBMh5PCEHz1+5F3ubMfVQS5ZuRRK+ob
         cc6h9cfjkdDacSU8W4fPvo1ojofB8PnvGudO2m2BZPsFJLwpaaygX2Gu7UNWogsLMUUl
         2HBLwyAr854AF6ucCH98QaOmIX89XtqqdeplltvCAe2etuxU3FXykwLmPPzdC+4+vD5W
         PAG7ravgbhcjW14FzKUuV4rMeK64RncJtrVvPHNmhe49v/zID9c/nU8uBqiz4GG/soJG
         DYag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7gkwtsa9/SFlK3SjZgMHdS8ZwnKS7c0CunXCC3y5DHM=;
        fh=VJi4t3u06ETh38oTz5ElFszNv73Z+Y0P6aZMJvrJpjQ=;
        b=jL550y8Q/1O4mZJZMkTrM8tNSn4LPduvLBhGGzyzRyXNfS2Wcvovnso8hOwhCb+1hE
         2pz6zCSRqS9asTz5FbPJUPJ33GN9+0M04K/N8vQwwy1M4wVM69zlpkb6MObWTf8VRqmT
         U6UOJQprILYhyLzIp7VBKQIhLxOWzBE94KsygpPNcVNAqFV2vh+0J4KmDWdtZCaQwV1S
         HE/IlWKEXkCrbi6CjjWe2XpcXR6kx5qr19u6y4xR/HiiOPotfLwIhC4XFTNzSXtYtyfe
         qzvwXH+OmJ0itZcqxmJfDRIrIt2LXyTaCiCHuvnI6KAXXisXqs3FxFp/mfEpCNa2eIOq
         G4Xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776786661; x=1777391461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gkwtsa9/SFlK3SjZgMHdS8ZwnKS7c0CunXCC3y5DHM=;
        b=mlstgX6alPq82lbetvhESZdDm8EUMlLOGdncMWgbcIltWGamfTCFDbSrPJJtL/91Qr
         9hLzjo2qniqlJ4X9ABT4hjgrD4TLY+eJoPT3k46n62LxuJhzgMLXJgM9136GaE9AajGQ
         wU9cgFwC2oudzG91myJfZz+WvIFZEgHRiNMMW389pPl1t4cwNFZnf4rUmpMAX4VGcqZe
         YExxXwJKmZ9kq/ejeX+I2D3AFcmhzSPneq9InteeWw/BfglVWRC9QUOHkDv/Ds4vV+KN
         6D3qYfQBrjntk6PD6IVOSx7tOKTPXRV+6gFC0kLP4N4D5RobOKXtRU/jv/2cnwn4f+1d
         wxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776786661; x=1777391461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7gkwtsa9/SFlK3SjZgMHdS8ZwnKS7c0CunXCC3y5DHM=;
        b=Apsy+IST57KB1LbooXZpBWOB0Yzxfg/XmuPQith3WzCP1qA0FDXLdCZjQikQn66bVC
         YeobYBsg13u1McZFRH9i/QnAaqgYc3vEJG89i3S3kCYb2GI/Q1Bl5YUUD5ut3hKOw6n+
         rVu7Z1+Z46NNSZG5+5fMNzAUCUSk3dFDCKexux5SMhiXLdb8yxsTA8eJ3Ozd99Jm21A0
         +VW5pIZ7kE4LHjhDT7iGbizUjvkn6CuSU+h3oBijyoSDQPbMq1F7Hm483x1bhljHO8Lk
         fMQ4r5ag/V4YS0RSJMOWzgY1bxsTHwK7oOpiSHtV0nEQLmKxr44TwDora9pbA0OrM5WQ
         UdUg==
X-Forwarded-Encrypted: i=1; AFNElJ9NLlOAiycni5rJxwbg7Rcvqp4/KuMbz61DXb0W3DZNBp5UbGV6D80JMupNiN8rP3Pl5Y6e+JayO8t30gfee4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBoaiWXcbuFneDskknTx571i5J2vR6riL9pCwYbuAnFWCzjlHd
	JQvLR388460ZWidnBRuLZzoS0bcJph7hm9MVtAsYlBKIy7+vjRsIUPQ7dvk+efTEr+KhQiya0SH
	0NF2t1aZiifaWmz3i9BZFJvyrkSvPqX0=
X-Gm-Gg: AeBDiesF/qrsYdD3XN+Sqo7yjkblm9juPOOsPKsu3alhPOYyW3iN75xtOZmdh10WDH8
	qb3W8D+spCVrlUq+joJ1Telv+DKJXGjOYKEBmOAFkVfMluFa1cEk1IFDjedy+WK2dAgFTPqPTL2
	j/+R3q3YcRzRr6GX7QpucyIqOiCR1wnHyUIHejK6mUQrmOZvJgQ6WNnZaV/zIiUJgyQnFdp7nMs
	iyzvgxkkO1Rqvrb4ffL8Bg0X51rfuiPy0jcQtxtiEFdISaRUDCxCiO/VhBoYg5gkhYdVDcX/rAy
	I5UCXHLq12H5SixFofarOfgZmHkXUZzRjFvKptdWcVmlJh8tGWr6G2GwK5PPDgIgnJ8OaDlz8Ix
	Lcl+/
X-Received: by 2002:a53:4208:0:b0:651:9286:578a with SMTP id
 956f58d0204a3-6531086db46mr13066080d50.25.1776786660716; Tue, 21 Apr 2026
 08:51:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418000138.1848813-1-michael.bommarito@gmail.com>
 <CABBYNZKP-Rwumw0c7FHEsL5e6XpFZCBA-O2avNujtYgRHeVZhA@mail.gmail.com> <CAJJ9bXz0nwWsFg-B0nn77bn4dh=ob-F11a6azK+VV8sbLOBmLw@mail.gmail.com>
In-Reply-To: <CAJJ9bXz0nwWsFg-B0nn77bn4dh=ob-F11a6azK+VV8sbLOBmLw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 21 Apr 2026 11:50:48 -0400
X-Gm-Features: AQROBzATa54Ha7FaSQMWgwIrzto8qj3R2qU1Itz5IXioBc-FKFmq2bwcN19d7rs
Message-ID: <CABBYNZKqx4ureNbRGEghGjGWcmMQSoiY4oUCECme_Vgn8RvYYw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: virtio_bt: clamp rx length before skb_put
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Soenke Huster <soenke.huster@eknoes.de>, 
	"Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Tue, Apr 21, 2026 at 11:19=E2=80=AFAM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> On Mon, Apr 20, 2026 at 3:17=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > All seem like valid comments to me, first one is odd to me thought,
> > never would have though that skb_tailroom wouldn't be enough to check
> > if using `skb_put` is safe.
>
> Thanks, those were definitely gnarly.  Went back in with
> cscope/libclang and found another spot to guard too.
>
> Let me know if you want me to re-organize/separate these into a
> patchset instead of one bigger patch.

Yeah, let's have it split into different patches, otherwise the commit
message gets convoluted trying to explain the what and why of each
change.


--=20
Luiz Augusto von Dentz
