Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0541C5D62;
	Wed,  2 Jul 2025 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751461560; cv=none; b=o8Qlw/2Dz6hbIqYurcl5/mm5/IOxdFbbR9QLcVAWYZG8XRLkfOgql3VC6YwEucrfJj5IUTYne3K5DogYSxmTNJUf4slCZGSjLAdEsnbtZDDTEIGbVK7Xlss3jJRDS/BfC6Z8WO8eA3yDMBiaSHyia+xBqnzApMVzUc8JF9z6ktY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751461560; c=relaxed/simple;
	bh=HdgdvIsErRYB55Bx2nUsDKO5isYMPC38e3HOD98FCCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FwVTGh6+llEYo/nRbETcL10GDur2gaDJGOpLxqkiaijlryBpPiCUrviH68CofDyEP1BH75M4qk7Ve3Upndp4lNa5DtHoDtx4jZ0t41HWp3VvU0CEWea4GvGAEsxBx4zBx2Rbc6tjYX9aGUOFxSq3CbzWUZz9VYo6iwG3mSWY2EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXPfSYmP; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXPfSYmP"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3137c2021a0so5846987a91.3;
        Wed, 02 Jul 2025 06:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751461558; x=1752066358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sl6m6l7WchtXeiLO8eyqbnD5skRu04k6LyNWNAViEc=;
        b=WXPfSYmPe0geVK8nvO5z1wJQc7kj6p288uvkNqtp5857LDWMzFGn39aL8Ss21hwHlz
         VCK89Olhkw+qdeF1mhroyKbzzY21Ikwvv5lRYCvAUnW0FU0HE5dYkbrC5tsESnqWOEh+
         QoPzsSzUrf1BnoAIQ+YIm5wABZOzVTjudeplbnPlLK6WaAaycRRuIJx7qV1yNk0llri0
         R0XMrIDeG7Ks55lrAclCA7XcYxAwT8C5F9i2LC9APbuA+sC0KKuJbhpYP9pDFJ+iicRy
         akRz0vwViJ8QnjVmFyZCJ0+rRvTsVzH1EfY/k2I8ye5crF/HLMHGHpSzMn9iTbBMkZrG
         UCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751461558; x=1752066358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3sl6m6l7WchtXeiLO8eyqbnD5skRu04k6LyNWNAViEc=;
        b=Q3xU0zpiDlhxjl1mUHUYv0lnzFEr7upZMoyNKCxk+Tc/QCPdHLAJEilliC733eY3S3
         +ppeMrf52DyRL+dDSmbk/NR4hTatXkNwmbeRQ0f76L5zj8JO5hMghmcU+AAIkO7yuJaB
         Nxt4TKvPAs9/klo6+hxrSFMFcfvV9oTd2asOcMOKQnCWjsi+AY30WnOIsI1fTExXzIB+
         czOC77gmtd9icpnRYGtseW4dKKE7pyU+LFWZyycIMj2Bj34vEfsbgZT+3PhW2PB7CX7+
         uZlUPWMdQ9Q7wchrUUcX4O+6DmscoayagpD24tgbo/WpKr8fuLt321AIJmhn8UgcmnDx
         MmRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP7sc5ntcdeyz8PN760P5J5ZDm27j8zfuYNj2VHFh7I/V5N8O0z1pnYNXK3xYql7fJRsTB9kBE/vMIEFl2@vger.kernel.org, AJvYcCXobmATV5N8JlyxipjLZDWtbvFn0JOjiOGcvsY0J1Jn6oNhlF4YT3AqwCkQWXLd/WgDpm+gTa/+RaiAtEwCBlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YygDfG0soiUCoG79Kx4r+2ZqHgS5awAbCq7J3V+zcepkllQoCBX
	PsFRLHFigGr8+sXg6REW1NbmOPJadx18/Bx93Swavx4tG1Bpw4fY+aUbidpzNrW5Fif+CAcgBug
	qGuNA6ugp0o+t2HlYsVjr03+H7bg8rhU=
X-Gm-Gg: ASbGncvHoFYgC0C+lNgQDnz9R3YjBA5+PPosExoMGJ8loswhDrrLtgu9+nQrWKEx/JK
	2b/YqAxKVgrd1WijNWUV6IFpRvCiAZn3SMrLaC5fgUd+xPRrhyBGZBCwD78TKbELNyuaSZ3xYg3
	Ol0gf3BMCET+oALS3eZtD65sFxDhskI+5OaKLAOkS3JA==
X-Google-Smtp-Source: AGHT+IE6oAo1JpcGKMDAjbhxBaddxdPQrbeSqqDdlGEg1cIFpEnuZo1kj/DTMX7hU11oivcuZ0mdaYInt5vFda8BjXo=
X-Received: by 2002:a17:90b:2f85:b0:311:c5d9:2c70 with SMTP id
 98e67ed59e1d1-31a90bbbc58mr4844308a91.15.1751461558139; Wed, 02 Jul 2025
 06:05:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606090559.896242-1-hildawu@realtek.com> <bb5d83c2efa24dd8ad271ce812581d02@realtek.com>
In-Reply-To: <bb5d83c2efa24dd8ad271ce812581d02@realtek.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 2 Jul 2025 09:05:43 -0400
X-Gm-Features: Ac12FXxK5DRKSYIh__84LUfk7KyFThl1pvNIEPjiZub5MkPnhl9voiddthWtZi4
Message-ID: <CABBYNZK4a15mEDuRtAaSj+y5WzpP751shTLGi1FJg+0eQft+BA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Bluetooth: Add support for RTK firmware version 3
 and enhanced ACL-based download acceleration
To: Hilda Wu <hildawu@realtek.com>
Cc: "marcel@holtmann.org" <marcel@holtmann.org>, 
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Max Chou <max.chou@realtek.com>, 
	"alex_lu@realsil.com.cn" <alex_lu@realsil.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hilda,

On Tue, Jul 1, 2025 at 11:35=E2=80=AFPM Hilda Wu <hildawu@realtek.com> wrot=
e:
>
> Hi Marcel, Luiz and Maintainers,
>
> I hope this message finds you well.
>
> I submitted two patches for the Bluetooth subsystem recently and wanted t=
o kindly follow up to see if you had a chance to review them:
>
> - https://patchwork.kernel.org/project/bluetooth/patch/20250606090559.896=
242-2-hildawu@realtek.com/
> - https://patchwork.kernel.org/project/bluetooth/patch/20250606090559.896=
242-3-hildawu@realtek.com/
>
> These patches address the future chips firmware format enhancement and do=
wnload firmware improve.
>
> Please let me know if you need any further info or changes from my side.
> Thank you very much for your time and consideration.

Don't send reminders, just resend the patches, also the kernel test
bot did respond with an error message, please fix it before resending
it.


> Best regards,
> Hilda
>
> -----Original Message-----
> From: Hilda Wu <hildawu@realtek.com>
> Sent: Friday, June 6, 2025 5:06 PM
> To: marcel@holtmann.org
> Cc: luiz.dentz@gmail.com; linux-bluetooth@vger.kernel.org; linux-kernel@v=
ger.kernel.org; Max Chou <max.chou@realtek.com>; alex_lu@realsil.com.cn
> Subject: [PATCH v2 0/2] Bluetooth: Add support for RTK firmware version 3=
 and enhanced ACL-based download acceleration
>
> Dear Maintainers,
>
> I am submitting a patch for the Bluetooth that introduces support for RTK=
 firmware version 3 and implements an enhanced download mechanism through A=
CL to improve firmware loading times.
>
> Patch Overview:
>
> 1. Bluetooth: btrtl: Firmware format v3 support
>    - This addition ensures the latest RTK chipsets with firmware version =
3
>      are fully supported. It includes necessary modifications to
>      accommodate new firmware structure changes.
>
> 2. Bluetooth: btrtl: Add enhanced download support
>    - By leveraging ACL links for firmware transmission, the download
>      process is significantly accelerated, reducing the overall time and
>      enhancing performance.
>
> Testing and Validation:
>
> - The implementation has been tested on various RTK chipsets under Linux
>   based distribution.
>
> Impact and Benefits:
>
> These enhancements are beneficial for future firmware v3 chips and compat=
ible with previous firmware versions. Users can expect shortened initializa=
tion times.
>
> Your feedback and suggestions are welcome to further refine these changes=
.
> Thank you for considering these enhancements.
>
> Best regards,
> Hilda
>
> ---
> Change in V2:
> - Move structure to btrtl.h
> - Fill in the missing symbols
> - Fix build warnings
>
> Hilda Wu (2):
>   Bluetooth: btrtl: Firmware format v3 support
>   Bluetooth: btrtl: Add enhanced download support
>
>  drivers/bluetooth/btrtl.c | 857 +++++++++++++++++++++++++++++++++++++-
>  drivers/bluetooth/btrtl.h | 122 ++++++
>  drivers/bluetooth/btusb.c |   3 +
>  3 files changed, 974 insertions(+), 8 deletions(-)
>
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
