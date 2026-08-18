Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFD329E11A
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 06:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787035642; cv=none; b=ka3TZh5FwP3E/QhRMAkxcQLfwBZWUkUJ/DE3N+gafHv/JlbAdXDt0FKO6JyNTyqwD0PHmvyqj1dlVyivNzEpoZZlOswzuEql2IFVqKrlj3UsnAbpRz1G0zA9nU5xhshB8jnS4fiLfXXk2QUlPzR4xVGlKBaVw3FYG81OwXCvdlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787035642; c=relaxed/simple;
	bh=NZhF/naB63QrEmzhnIpkXVWDeQROTm5LJeK2bhvwip8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/psJUD9XvSQ4faWvlwoNOc0TdvOk514MzOyX8S62wRG+3kZs9oH6LTm8q7pShpNLlynWcRFefpc/CfGzqdhfN0QWjF1/jHnWVUncuOp3riqs7zwEwvHcfoqJ2x/dEnP4LoJbdJBo68i3qRQOVJca8B4oWrdW7z77cutI6yyOVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018B71F000E9
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 06:47:21 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b45f2e5f58so2671597e87.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 23:47:20 -0700 (PDT)
X-Gm-Message-State: AOJu0YyCW4hifExzcDZlLEXlObo94weCuiVzwz3mqVmOHQChI0AXygE8
	xXq1cwUJU4bAFjzY5xwkTDtHcH2rTWdnelcaB2dcF6XNLOTRANP9uZvl4ezzoQ9YXfqVldw4XWX
	Ui7E8H9HWDMqY05y1+fB+sqHdZB/Z0F4=
X-Received: by 2002:a05:6512:2514:b0:5b2:8c97:b50d with SMTP id
 2adb3069b0e04-5b4738e3f88mr677711e87.4.1787035638921; Mon, 17 Aug 2026
 23:47:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818014948.996739-1-kaihsin.chung@synaptics.com> <20260818014948.996739-3-kaihsin.chung@synaptics.com>
In-Reply-To: <20260818014948.996739-3-kaihsin.chung@synaptics.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 18 Aug 2026 08:47:06 +0200
X-Gmail-Original-Message-ID: <CAD++jLmzy+12y2Ae2z5VoxaYZSKkrsevLfw=xFZNEt9fesfYtg@mail.gmail.com>
X-Gm-Features: AcwNN1Ve8wmmhaAUbSrm9xegeFjiFxWol-pX6ZM7BHw_4uM2dhs4dQqQLBHfGFs
Message-ID: <CAD++jLmzy+12y2Ae2z5VoxaYZSKkrsevLfw=xFZNEt9fesfYtg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Bluetooth: btbcm: Add Synaptics 4384 chip support
To: Kaihsin Chung <kaihsin.chung@synaptics.corp-partner.google.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kaihsin Chung <kaihsin.chung@synaptics.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 3:49=E2=80=AFAM Kaihsin Chung
<kaihsin.chung@synaptics.corp-partner.google.com> wrote:

> Add support for the Synaptics 4384 Bluetooth controller
> by adding the corresponding chip IDs.
>
> Tested on the VIM3 platform. Verified that the controller initializes
> successfully and that firmware loading and basic Bluetooth operation
> work as expected.
>
> The VIM3 is a Khadas single-board computer that I used as the host
> platform for testing the BCM4384 Bluetooth controller.
>
> Signed-off-by: Kaihsin Chung <kaihsin.chung@synaptics.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
