Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656691B424E
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Dec 2024 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733756061; cv=none; b=fHqPm83LYt0MsgMo52juk0McMm58kI1bx5GQy+7j7lT2MciRv1h3CKkb0Hnm6Cu2ePCAMqd3rVbifvg2ob+rkFkKBN9fZrm3m/C5Flw1I6fnh3V7TUc6WcLWmKhFnCpHFbCmPGSIaRNsa/DZLK6/eRKJLSlCA/7M3RI9oFe0JFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733756061; c=relaxed/simple;
	bh=L3uPqYvqbgHQKbRYysjnG8NJRJoMHAJpo1X5a/nsGbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmoOV05ydsBvRVJtSDZ6Z8FwFPCJNLmoq+ZTpVMy5DEkF6ea5J8PFMxgscn55apOevZJUeH53r+60kRleaWkr5tOgR8WvIKAxjSAMGbE3U6sPAYXAU3U1Ivd38NgXXuthuTxQWKW6VRwOs6aviRg7D6sjXRY7ihGkaSwPfKvZ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vWxH0/h+; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vWxH0/h+"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5401fb9fa03so861087e87.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Dec 2024 06:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733756057; x=1734360857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3uPqYvqbgHQKbRYysjnG8NJRJoMHAJpo1X5a/nsGbw=;
        b=vWxH0/h+qrNQJBz4YdxyKiuKZte7A0qFI+1Js97zehJPYd4oKZoCWjMGIfJ6gB1PnF
         n/jDM81eeDWT6XzeGAIEWi2dOef+8L6VnveKxrtK2FB8SG9ATFLuAlquW3Et5+e54cEY
         1d6rAvEzT/EJrSAwrhAu6qgv0Ah5bDw4cwW0PQvqI/TTbdHUJ/vGOyzE2mjjXDUeUgp0
         L3TpyaZpz22PvnnnZHDgjTsAmgTulnKC7RygtmKnD0XJd/jMbg+abLJNridYhbONFOTZ
         qLFRUUp7xtIJBAjKrUTy2TIuPB1g5zj6HON2vKgZmQY73hENXpk9K4wdJHa24lSMFXMS
         lqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733756057; x=1734360857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3uPqYvqbgHQKbRYysjnG8NJRJoMHAJpo1X5a/nsGbw=;
        b=fyq8hLKECpTKNrSbVo+U8CxtZsW2n0IUwQB/C/frRlI1yhv/6/zHLeKrdBjlaf4FyU
         MYISh+c5JSbezQWBGbSfMzITcDPrLy+xp0IJh9/KMmvFGxP3YEPjX5FNpN0FvuMWXVBB
         aHK5/gxY36pwbDDXrzaJNghsSl9WIXtchb8qk9VK4nEAxEstEXQa1xD35bmo9/3mMAuH
         tFkfCyJdddYr6VkdN9uU+0i2GU5yQlvf/eTnksE1bZILqRgX/PLi4r4izUL/pEmn4Ipa
         +41+LOMAuED3Fn5lbk+9xUBFFcOfxWXhC7aDlrzrx1eClBvcpYdXPyYVILSauRPqe2La
         iSkg==
X-Forwarded-Encrypted: i=1; AJvYcCVg6mlZRWeBouGY+umbTzBXfpvXfqSg+gCAgxsRt2pthdD00pDQls8eFyAccUfb8i9ih52OiBZQKmGF5CUmUos=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyTAF3l5XbGkPJHkwujE556vq/+Hb/CtiBOVSv0g44BSDcFQmp
	OeyoWi6V0gHazZBQKNRHlAPw5HY01PA+jIQALtF72qNtQTgQf4RlhE4DNnUyRCHTwB4Anm0wzwU
	kMCdU1x0cyfdb7mANf07eyT14bXwkNolNDDXtBw==
X-Gm-Gg: ASbGncv9azQAvlJPDYF8a1kkU8uNthDxJnQtNgV5nictBU31KMKM34uix7Tk8hC+aRu
	ye1N3TFCrecrqRSDA8SYuJjEs9pj9l06P3nrW2fh4puOtfB1iko8EclNg3FehGc0=
X-Google-Smtp-Source: AGHT+IEznO0uqtPL1COzvxGwq+VZpn4uiLON1EYzg8NJIKAdwzxMATkws3UccavvSGGamvwnW6zKLVEwbVjxpooMKJo=
X-Received: by 2002:a05:6512:6d2:b0:53e:16eb:d845 with SMTP id
 2adb3069b0e04-53e2b7328d9mr4535052e87.18.1733756057474; Mon, 09 Dec 2024
 06:54:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209103455.9675-1-quic_janathot@quicinc.com> <20241209103455.9675-2-quic_janathot@quicinc.com>
In-Reply-To: <20241209103455.9675-2-quic_janathot@quicinc.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 9 Dec 2024 15:54:06 +0100
Message-ID: <CAMRc=MeA7vFiWFN6RExmiBFhrcRwfVdz07YdQJ=c0trTbeztNQ@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2NSAxLzRdIHJlZ3VsYXRvcjrCt2R0LWJpbmRpbmdzOsK3cWNvbSxxYw==?=
	=?UTF-8?B?YTYzOTAtcG11OsK3ZG9jdW1lbnQgd2NuNjc1MC1wbXU=?=
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 11:35=E2=80=AFAM Janaki Ramaiah Thota
<quic_janathot@quicinc.com> wrote:
>
> Add description of the PMU node for the WCN6750B module.
>
> Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
