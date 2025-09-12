Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39F61114
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 00:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757635847; cv=none; b=BOUN4wqvrazZSrXF1A0fLhl23DGLsfn5789W2/0e1AVKNuhiaRREYxkBU/Sc8etPmXFJB59aOp8yfbWfFklpuIJyS2PT1qVM8jazmNm0PPx99N5FdeVzQ6lf0pMObatF/7rlcdXOUKfq58dzjin9j7ZDicEbWxvdQcE/VmVIgYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757635847; c=relaxed/simple;
	bh=As0st2mk2L0Hyv308eIrHbtQh5TjekLWLPV+ifYiL5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V9PTypFnFMMNN+lOiKGFZrTylG4aaKCwSbrSBw2HDKbXR/gtgwI1MUDE6Tq7WUJzio95IJATqcqZhxSKZNiws+iKoqox1gb97gUiJ1425BcB7TGJSMXz+drL0XjqcOlbFJC7RJI1Kxbug7kT1MagNO8O3Mz3+HkrXZqVx8D0/KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMpIx4Ig; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMpIx4Ig"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858AFC4CEFA
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 00:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757635846;
	bh=As0st2mk2L0Hyv308eIrHbtQh5TjekLWLPV+ifYiL5s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qMpIx4IgtVLlsi6LiDk9WM4G5NIXqk2vJMlQcYqfNyIG0UhdfRyvChYLEJqj5snxz
	 bj3B/Q3dTu6d2YvnXim26H63nFoGrtEM/v9se8CDOs+Hy9pBdd2tFXz1OD6/bVcLVS
	 WNhcKqH1ifK6Bpw4omCXCt7SiuA2uUwlJUnvDn1bpZXXZM9eXJSMR2pM28+Im41D6p
	 XHOGIcdrMSb4yG7mmuQ7wORO2ehoA3OKIXQVaqlECxI6EfjdAQ9x2T8vKfIcYGftjE
	 Dpm4GWqaKbbHcreuu5dx3YCeDplTMzTkWpG3wgVIOUggX7s81pzqkDmCrld/jWxhNb
	 XCiyGWaNOoCUA==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b02c719a117so228740366b.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 17:10:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXL1eAOFBlC8n43o4mGDz4HFWC8OlczlqIBIL+VzM/I/3UcFTdXymLpX6ybUNllXOBJbyzkTaSt4Py9U1hTgUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj286I6cfq++oQRYqgghUpmdbJU7755l9Dw96ubNFryuXEfaJj
	S/MbEsiTW7c3mKVMDVZM0bkXinM2VBiNQdCzXvgOuUin/brb8jJKfsUFX7DIy1InMM07ozqmPrD
	S0YXt6nJ9G46PUlwUGnoemtJydfPCwDQ=
X-Google-Smtp-Source: AGHT+IGlZB9ve92AUsjeuNU1Q5ZaXqNU8y7VQEYnPyGvDio1YpPC6YK436PmiT1NHNvhnGHWryG+F5/8KZPOgJm7JoQ=
X-Received: by 2002:a17:906:478b:b0:b04:5435:901b with SMTP id
 a640c23a62f3a-b07c3a77fcfmr91410466b.62.1757635845021; Thu, 11 Sep 2025
 17:10:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905084059.26959-1-ot_zhangchao.zhang@mediatek.com>
 <20250905084059.26959-2-ot_zhangchao.zhang@mediatek.com> <a7589659-0352-4d47-a3cf-f2433cc512ec@kernel.org>
 <CAGp9Lzrp-cfn_GiLrHCU629wEAxWy=egOMrRh6thYbymu+QXjA@mail.gmail.com> <0760036f-db69-487c-94b9-a6e405dee0e8@kernel.org>
In-Reply-To: <0760036f-db69-487c-94b9-a6e405dee0e8@kernel.org>
From: Sean Wang <sean.wang@kernel.org>
Date: Thu, 11 Sep 2025 19:10:33 -0500
X-Gmail-Original-Message-ID: <CAGp9Lzqk-mXiNq2iSrTk-Ed40_2j3GSuLMJcWoE1_iy7yY9-qw@mail.gmail.com>
X-Gm-Features: Ac12FXz8IhbvaLWT27HxTo9duYFHYYWRiZ_PiuVbsnFzUeOWnt4swjEH76TSLOQ
Message-ID: <CAGp9Lzqk-mXiNq2iSrTk-Ed40_2j3GSuLMJcWoE1_iy7yY9-qw@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] Bluetooth: mediatek: add gpio pin to reset bt
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Sean Wang <sean.wang@mediatek.com>, Jiande Lu <jiande.lu@mediatek.com>, 
	Deren Wu <deren.Wu@mediatek.com>, Chris Lu <chris.lu@mediatek.com>, 
	Hao Qin <Hao.qin@mediatek.com>, linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 1:07=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 11/09/2025 01:29, Sean Wang wrote:
> > Hi Krzysztof,
> >
> > Sorry again for the confusion. I believe Zhangchao is still new to the
> > upstream process, and we=E2=80=99ll work together to improve this. Sinc=
e this
> > series has become a bit hard to follow, would you agree that it might
> > be better for us to restart with a clean patch that addresses the
> > review comments? A clean version would make it easier for reviewers to
> > focus on the current issues without being distracted by earlier
> > mistakes.
>
> No. If you cannot send v7 of patchset as real patchset, sending again v1
> won't change anything.
>
> For seven versions contributor did not bother to respond to feedback and
> did not care to read submitting patches how this process looks like.
>
> Effect is this totally broken v7.
>
> This patch introduces undocumented ABI which kernel tools, if used, also
> point out.
>
> Best regards,
> Krzysztof

Hi Krzysztof,

Thanks for the feedback and for spending time reviewing this driver.
We=E2=80=99ll continue with v8 instead of restarting from v1, and hope it w=
ill
be improved to meet the requirements.

                          Sean
