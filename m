Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE4D2DF155
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 09:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776157236; cv=none; b=MnJ4gMVPHroGfe0noMYmIq3e+ZL/bsdbVVSAYZA11oJwdMUWo8YPCe3F54mmtCMvW42y5q8w2rsZyrxtWwx3xQZ/NoKE7bSL1XT9RgVeyhD795lQMmZScKVNixPkjedFTWIS0zj5cShTdAjvQVwpAtX2LJ4TJsreKSbG+7yadCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776157236; c=relaxed/simple;
	bh=7BzH4l41ivGVwJZyLUtzjEKcBbitAg70COzuLd4I7K4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjlP11dl3aPeS4Q8+zxnd3sD8nlCcpm77M6BVutpTLXifxyUZBL+ngseV3HQZU5d9uPUdpIfIRBxPXi0BKWWcVx2DTLaY32OVzSPIDIqG9bbuNf0vAEiib1XXqMKh+ak1YU9c3oljqax/eDglM0N+CCjWPPJxsiU9k1iyoTPU6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-40ee9b945d5so3923448fac.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 02:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776157234; x=1776762034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7BzH4l41ivGVwJZyLUtzjEKcBbitAg70COzuLd4I7K4=;
        b=XVhpLbABS1DBygwmUeVb0WtY6Eq2hybmmspkHUXYaQVyVu3xFa9sDnazT8r9oNKM4O
         tkq7PtUKSbc2QaXk5C0MwTsGQEIhaifbp/hbgib98zdp5K8kzrScCCtVgd5Bufwr9SFr
         ifyuWJKoEMTgslNB0+IlYhB8qgywI12eQ9/cv4O0Pl3e52hI9NlwxwtzYvNaaye+BFUa
         Wd8JA/7nzek3aRhElEQwYFYZnC0Ts9tIdHupF1cvHOb66G8YAZWWSShpowHzMlDHVl2w
         LSsaYUVNWu+lj3/FCFMKoYq6TSsDwRIV1cQTX5Xl+S1bIy0eF5S/hmk0GK1CjhUi2Qpr
         sNzQ==
X-Forwarded-Encrypted: i=1; AFNElJ+AcMZi+0UpCYOjKBAy4QL/HPWBvu017fZONLEsJrUG8pdgllsJgntCDCsXXBDi7lYNH/nEyDgCpT0QF6lfjbc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5/4ysBhAvEycqvj3WYhdxQD0SAGY8P7shqr83bKEqXpAihOlN
	FSHGX63Ib2BOM5RhUsnNZ3Y7u2waJJUY8l+G9sqIp1VvtRETmnahFVOm3QwFKwYC
X-Gm-Gg: AeBDievWwmx6Zf9MxoyFPr0r/faDjpPiXKrEKzFLmj+gSZs2DI1iMekBONG/MZRVbEN
	KYkanfPxSdOvgrye4zPX42YrZWacnykvR9QaNniMweJQcCxtU/q0bLfwH65ueZmgw7dH0rOqcII
	G/dBSdr5EX75wyOmjJmz2IaIYty4hliwIr4lAIdCScUW+Zqop0HpSn0NNUCOWH60Qzc+5SoCnGD
	4Qkmjs0QrI0oks+2wohmo4S4ifsCkLvjO/kUTlz/EiUQsUQ8sMfkEKoFXmqz5saG5cm0WZUX0M+
	LnpHp8nvn88AlVkPx8HgJqybnEHHbliaGMQzHBo/b/zyY4YDDh08L8/IlFBWevIb67LPHJI6z2V
	GRsINtIkiy7xF4ZiGWv/rEi0+cJnGxwLcAiJEaj5GZu8IHVX5bJ+M9oHMXkOSdphd/ZinJ3ICZW
	0ZZjCz7HjRTP5F6E83mFqH4zggSDQpZSCrhfCmIBZqSmlRTEZYNA1oQd78zHB3wnvmHpAl2dRn1
	58f+XKZQztlVX/uB26A4L0Q5EhDxMSMXBNcO33O0FdNG+eWN9bDclZbXN01T0VN32xreWOQNg==
X-Received: by 2002:a05:6870:8289:b0:3e7:fa5f:7269 with SMTP id 586e51a60fabf-423e0e6f00amr9085147fac.2.1776157233559;
        Tue, 14 Apr 2026 02:00:33 -0700 (PDT)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-423ddb80ccesm10338802fac.13.2026.04.14.02.00.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 02:00:32 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7dc3d28e2f3so2495940a34.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 02:00:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8zLKqoStQbAKV5brhkgjWkBYIAN8pw515f7Z0cmkLTavkQSrIwvM0+4V3XgsUVTFN/bKbix01i0+wwSjz4DXY=@vger.kernel.org
X-Received: by 2002:a05:6830:6d44:b0:7db:df4e:f937 with SMTP id
 46e09a7af769-7dc27ca49a6mr10107828a34.7.1776157232558; Tue, 14 Apr 2026
 02:00:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407-brcm-prio-v2-1-3f745edf49af@gmail.com>
In-Reply-To: <20260407-brcm-prio-v2-1-3f745edf49af@gmail.com>
From: Neal Gompa <neal@gompa.dev>
Date: Tue, 14 Apr 2026 04:59:54 -0400
X-Gmail-Original-Message-ID: <CAEg-Je-dvJA4yLJxwiJVg2S585Dihg4c7FTyf0Gv8iwahU0ifg@mail.gmail.com>
X-Gm-Features: AQROBzBGriz3oUw4obwCyMl6uueqnkEVGw3CzezDOXXcUajBdgbMcTOpUgPlHRE
Message-ID: <CAEg-Je-dvJA4yLJxwiJVg2S585Dihg4c7FTyf0Gv8iwahU0ifg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Add Broadcom channel priority commands
To: fnkl.kernel@gmail.com
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 1:46=E2=80=AFPM Sasha Finkelstein via B4 Relay
<devnull+fnkl.kernel.gmail.com@kernel.org> wrote:
>
> From: Sasha Finkelstein <fnkl.kernel@gmail.com>
>
> Certain Broadcom bluetooth chips (bcm4377/bcm4378/bcm438) need ACL
> streams carrying audio to be set as "high priority" using a vendor
> specific command to prevent 10-ish second-long dropouts whenever
> something does a device scan. This patch sends the command when the
> socket priority is set to TC_PRIO_INTERACTIVE, as BlueZ does for audio.
>
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
> Changes in v2:
> - new ioctl got nack-ed, so let's use sk_priority as the trigger
> - Link to v1: https://lore.kernel.org/r/20260407-brcm-prio-v1-1-f38b17376=
640@gmail.com
> ---

Thank you so much for this!

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
