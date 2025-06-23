Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AC4262FC5;
	Mon, 23 Jun 2025 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750699829; cv=none; b=qNGCsmEQlVx4E4U2vLDr4XACWVfNMtBSmnkX971iq7isPnf91mVgdrTGEhwcGnukcaLMp0aZQVdKYI8w3ZRl8X1+wqTLeVRBPGgymUWtjYv3QLNcObzPVya8tnZVuK8VyehrekqdcD3Lh/HeqwvwW7FALQCp4Vo8ixrra1Cg3u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750699829; c=relaxed/simple;
	bh=8jl+9cDrnjJOF5ucS1DvOv8ACv8p486jq1+0Lhyz1t8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsJt2i0XuT4krjuI8ifabFMG1zkveI9kHDS/3S5mnYLKgwXcIPlhjy2lwUeNB8/XhIWcgqRZPcxBA6VBIdqnQ6mEZzE5/MtTQq3alDoxiuMbPP68QAtZw1UBpOXIGst94JMVqt/e2YBTNHKkhD5zc9YqUpsSkC+oXPy9ryH3rtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0VhGfuq; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0VhGfuq"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32ca160b4bcso20746141fa.3;
        Mon, 23 Jun 2025 10:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750699825; x=1751304625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRx2ygGON68DaC/gtiwKh8VTYLOnLvGNtc5thNaQgcw=;
        b=C0VhGfuqCEtW3FkltsI9mFA4APzM8H8kyqV+mJSpQVZJ9DPTSd0oNQNSt8zCqs8lMj
         BDZwmdjNeLUT68ABTVZONxiWeULml06XDf8edqAW7CGvO935Gx5ojw/QM6vWhMzLDrMQ
         /xWH3iJDhQkn0oTfNoXWb6QOAhQzV4d0jCGro/TwbnWqGUjcrfWdwndhx4o1YKWn8ReK
         MjmS1y9RQdSsjluNccGNdeQpwiLFQ0PWeFfvMKN+RovVB1QViBi98w7yJOD4vdxLgviX
         dfpGtvB58o12guttpsTnCQyY9mP6R2aB14uLLr0/OdRlgaZkz2em2u1wa421bjiWllOe
         whfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750699825; x=1751304625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRx2ygGON68DaC/gtiwKh8VTYLOnLvGNtc5thNaQgcw=;
        b=I3pmocNVhMninZNtVc1MUEGDd9aa7aLXvmRVwmIlrgXXQ6K+yFA2OM7RKWsQCz2lDA
         +sFQjZRXlSz7xAGgNcQy6Otl7By2edXnZWwl9w2jitkW3iNqpGcgB4068OlMpp0tdXBc
         ojfTm89sDQxhqTR8crXqB+Vs+hpRTRh/nEJxmfcfHKgQtYFrZ6ugarXai3kDbBJLEd66
         DLgIhFCulBL4Oog69+LmszeTC7lb4PdfWSdD1pJvtBZLHAcpXL4IbK0se6n+c84m9vZQ
         6eWdufnnpO7ICx7F+En6rJt99RbzIInqjwk5XSTVQvR9RIjq+TAMfIWVT3w8flNPRaHF
         YrXA==
X-Forwarded-Encrypted: i=1; AJvYcCVZgyitISHUacGowx3R7IYvX1RG7zLztYszG5qE+5+Rfv55ylBRq68Ggm4egb7NhKUOOk4tFWDILCHk14nR@vger.kernel.org, AJvYcCXciE5SRowsberDqSI5Y9mvydRhOQV0+ZhVp1sLWgRZYi/dYHTNL5+Cg9PtEMvHgIlYx/iU5BAPD9KIkQYR2ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMkbWjTGjaAqHsvo8yypDHpsKF/belr/aBRzGjjgmOohZmsL06
	EYbZc9+0WIUJXYK09a1t1h6h3xQjwbiin169r5vdJqy+yD7OKcSOhF5rogTuAOmOA6raeZ8cpGU
	O/OdLseR+ksfmqMB17rpVyjPZtmDo3jc=
X-Gm-Gg: ASbGncvUWGRD8N+NVKwB/CNS5av48V5c055GL582tNCC69+Mq0e+jHKP/oVJ20ih6Zk
	Alw2Zp2SCRs5ShFMWNYWcVEMWmN7+aQJ+LxiLuq/qAajWahtrsjNNAXqjJaiX44a1jsH+B4dRUD
	SLJgXpvnAMiUJYhAjXI9JNfBqNR5Hx7xKlroNRH09NUg==
X-Google-Smtp-Source: AGHT+IHyqF/zUWPtp+0ZEzV6kVohh/dVuHVOrwyoaqqRb8CbyietJFOO8QAtGYViBm0uTfYLshN81twTdhq7CL9TmZ8=
X-Received: by 2002:a2e:bc05:0:b0:32c:a006:2a1d with SMTP id
 38308e7fff4ca-32ca0062f65mr19202371fa.4.1750699824943; Mon, 23 Jun 2025
 10:30:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623102359.2684-1-ot_zhangchao.zhang@mediatek.com>
 <20250623102359.2684-2-ot_zhangchao.zhang@mediatek.com> <3df0b3f2-0d73-4116-8bbf-37020892e773@kernel.org>
In-Reply-To: <3df0b3f2-0d73-4116-8bbf-37020892e773@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 23 Jun 2025 13:30:12 -0400
X-Gm-Features: AX0GCFsnpLQwwKtnijqZGlv0tstZiyS3XM4yXHsIdV3Lgvijxwc-1eNX5GxkkhQ
Message-ID: <CABBYNZJ8qJTjyzfZBBCbYCon1zinRbxOmUvvPbheqUNSTh13_Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] Bluetooth: mediatek: add gpio pin to reset bt
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Sean Wang <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>, 
	Chris Lu <chris.lu@mediatek.com>, Hao Qin <Hao.qin@mediatek.com>, 
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 23, 2025 at 7:55=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 23/06/2025 12:23, Zhangchao Zhang wrote:
> > Makes the platform Bluetooth to be reset by hardware pin,
> > it provides two methods to do it for mediatek controller,
> > and it has been tested locally many times and can reset normally.
> >
> > When an exception occurs, resetting Bluetooth by hardware pin
> > is more stable than resetting Bluetooth by software.
> > If the corresponding pin is not found in dts,
> > bluetooth can also be reset successfully.
> >
> > Co-developed: Hao Qin <hao.qin@mediatek.com>
> > Co-developed: Chris Lu <chris.lu@mediatek.com>
> > Co-developed: Jiande Lu <jiande.lu@mediatek.com>
> > Signed-off-by: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
> > ---
> >  drivers/bluetooth/btmtk.c | 69 +++++++++++++++++++++++++++++++++++++++
> >  drivers/bluetooth/btmtk.h |  5 +++
> >  2 files changed, 74 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> > index 4390fd571dbd..3e5f3ca6f0d5 100644
> > --- a/drivers/bluetooth/btmtk.c
> > +++ b/drivers/bluetooth/btmtk.c
> > @@ -6,6 +6,8 @@
> >  #include <linux/firmware.h>
> >  #include <linux/usb.h>
> >  #include <linux/iopoll.h>
> > +#include <linux/of.h>
> > +#include <linux/of_gpio.h>
> >  #include <linux/unaligned.h>
> >
> >  #include <net/bluetooth/bluetooth.h>
> > @@ -109,6 +111,65 @@ static void btmtk_coredump_notify(struct hci_dev *=
hdev, int state)
> >       }
> >  }
> >
> > +static void btmtk_reset_by_gpio_work(struct work_struct *work)
> > +{
> > +     struct btmtk_reset_gpio *reset_gpio_data =3D
> > +                     container_of(work, struct btmtk_reset_gpio, reset=
_work.work);
> > +
> > +     gpio_direction_output(reset_gpio_data->gpio_number, 1);
> > +     kfree(reset_gpio_data);
> > +}
> > +
> > +static int btmtk_reset_by_gpio(struct hci_dev *hdev)
> > +{
> > +     struct btmtk_data *data =3D hci_get_priv(hdev);
> > +     struct btmtk_reset_gpio *reset_gpio_data;
> > +     struct device_node *node;
> > +     int reset_gpio_number;
> > +
> > +     node =3D of_find_compatible_node(NULL, NULL, "mediatek,usb-blueto=
oth");
>
>
> Can you finally respond to the comments you got weeks ago at v1?
>
> NAK and I will keep NAKing your patches because total disregard to
> review is not going to make this patch accepted.

Can someone at mediatek respond to Krzysztof, he is the maintainer of
device tree, so he has the authority to NAK patches so you guys better
start addressing his requests.

--=20
Luiz Augusto von Dentz
