Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC1B3E6385
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290641; cv=pass; b=h7tHppTfdjBDtlrG5YLp2nVG2Cw4/P6hTTCcHKAcPscSEm4WLZyVqZtDAFM3oLJfbrgWcdVjhLk0NA0/9Zvs6h+MRm/aBvoZ+AHAMLFpAlSjmfaNEb/PAfOwsgfKL0RgTIEBRced6z13ArmaavbMo2JVI+XGe5Qt4HhVipbFLmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290641; c=relaxed/simple;
	bh=nhJVaTSldyj4EE0+Nc297Wmb3CYpNc63fxJzjQnT2yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nnXs5liqQ9yDNNvEtagrDp6Rb2JRgXptuvRN+1tfXwyxEtrAqJeQX9bBk714QjruLWVoJpGolNTCUIy6N/mt5AiNynkrZiELHoQeS+Voj9jy2vkejnCuu9PTfQ+/jvTq6BaWBpTnTSq+15HumUYThKz6VEPgGDdYiPy84fEVnwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTJOwU5A; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTJOwU5A"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7bdaa68cf81so44984857b3.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 08:23:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779290639; cv=none;
        d=google.com; s=arc-20240605;
        b=KiDGVn1abh5ColK+Bdd9ZrAOa2DVuApVFDGkZrPiraKFH1g9DKBw9m0rPJEiw3rr7j
         Roqd/V4V9mP6XSyHun8I1w8nLU6zRVLH2Ohp/0EUEJoWXDsjyNR42RzHB0UAvZjCa6Lu
         AUOGIYIUxPh/CHaNJSQpyXOzz9p+jb2Jl3cqTg4H/iAV/V/geV8rSwp1TM3FZLceeHhi
         lJhGnjYgO/ex6SrkJAgGW3TM404jIzfMhTm7IgRdybLI8pwUIub3RwmJJWIhBG/50FDF
         NBIT9sImYda+trSlVKMYTvqPAYZ+Q3GS/yTVT5ja9cTE9XD4PQ7ZNYKKek6egwuGvxuC
         b1Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Euxc0H4BAZhBGnIdmaTMWo+RLwIiq4MS6lUzgVBLZco=;
        fh=6tcJVQPfPhyDP020ThslWC8VCYBwIa1GqLKuQzl5CQI=;
        b=Hwc0IoFQIWQaMIuD6mUvCG5a8kA90Vl/rrbuICF2J5WqWUQyxuMjFGYQ7tlxMdii9v
         xV8fKSvfctpuUX6rlkFMra1kAqtB7HVVcrDO/SvlZWPJms41AU54CDRO9km4ta6wy9IU
         IUM0nN5/rqWye+Kyy55uSu5esCivnebqlOcFEl8dALj3w/s8MYFW8zyxurpX/PH/gg3P
         dI8FhDxRkC6GfetRHooQCIUBEocQti0HwwL5M3AdTX4khk23Daa2ebXXFy/Zh0bbF6Tu
         Okk0MhKitFVbuB0vuPmLfNKIsRdOPON5fcOQXbPzaARpgb3UYMS7EtIbAecosx4ZfTMg
         syjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779290639; x=1779895439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Euxc0H4BAZhBGnIdmaTMWo+RLwIiq4MS6lUzgVBLZco=;
        b=FTJOwU5A5aFXGnZxjaBSE9HvcqwFUBXOmY0yi69GJe9N+VZUCmwwR3E7hBvW3MpGZp
         6qNpD/C0rZDRwPpJoeyIQP5znrZ+m5nUInBh9ywRIO4F9S1XVJaUMKdzBpqJIds0Bwye
         NZlXEi1PQl3yk+c8aFezB+4jLYIm0YDCocz6RKRWeMzDaP+v7WmXtCBmTWOJFjOgivNh
         ibg9tPh1ZavFmDZLl+R7gzj4QLqiBSWz6OeSW5INrcJE2RsAdCIsTlscWEAdqPhVeZ5v
         qpqph2ScaSicUqQvqhywPKeyTM+GYXCEW0lShPb/CdCAo+ChGoHvKTDB16MuuYNJTOFN
         hvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779290639; x=1779895439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Euxc0H4BAZhBGnIdmaTMWo+RLwIiq4MS6lUzgVBLZco=;
        b=Ff43jG91qeKPdkHzYwqmG0Ty2IDisNgqaFrG1FtYfX9brh+84wyjfrU4zb3HVg+73U
         rG40hqLlBxyEn5WldAL0bUuI8bqmVrUuaNizmafBH5059bRFm86E+XUfgdOv7dfa2Ixf
         2d5K4pbquPQe2MTxHKM6tuaAYCey/nN0Mb0WdWhLYnQtsmO4xNLXvWXkDmOvDmMaQysG
         WDHE11bnaAPdz5uHbRAys/1QzraHXXLkSuD78Mhh6aEQsfzcK5IrTN9U8NcM739ezViZ
         ozySkcaghaNq3hfyzjTFnoqe6W+wxOc7eVHQ0+ZZyLMYw6NltKjrLHIepDR8DN0hrRjm
         6iJQ==
X-Forwarded-Encrypted: i=1; AFNElJ+E7O0f/Tp+EzRSWJOo/TRML1cqUVufoazajQCZeH5wqgnvnDx/as3iLkqs59OAOruZ5ZqgmjV9blA/EQ92ft8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7r0VRfDAgVX4PiIaDM7Br9Qo+8jZVF71jPEa1v7KPjxHgTX4m
	7NozjK3WbkHU8du5IqKXW4YqGpAaJ8fnvfOJeW41IF6f4zNUIdAYbTtMf/8zHvpfVhkDQI86w+R
	H9Fi3LW+3Vnqio3sCsA5ENjcKt+KcnJM=
X-Gm-Gg: Acq92OHWAMO3YqXdYpGJDK9vq1N1HKDKFNaQ2UEIWBDf2GnQwPSEpR7AomzVfNtfsTQ
	MoMo5KkwkBQTmLQid5fygjPzPNFM2yZpWNWlUgU9tuZonERSdpCIsvYGJtI25ON06yC73qtLSrk
	hBc9wDY7E2XJwyEYmZ6Rbd0ogQSa6Ta6h3SHKKLvIxPiHwiW7MDmi1RhdgdMJYbXHW+pHI5BCUX
	7ukq2PGTPpHvX1VmeCSu+PIvoOYVFIjZEbdKUYT6w9Dwgc6IE96Q1jiPIIR6ErRbnFobfFFJNva
	hhPFcUS2mhVaNPmFYJBL0A4TBTzGijKiRU7Q
X-Received: by 2002:a05:690c:5c07:b0:7b3:edc7:9b8f with SMTP id
 00721157ae682-7c9561735f4mr253587467b3.0.1779290638916; Wed, 20 May 2026
 08:23:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520135034.1060859-1-michael.bommarito@gmail.com>
 <CABBYNZLLw=VFfjaF_TXA=5ZgDt7rw=XgUULoc4JudMpUBf_BWg@mail.gmail.com>
 <CAJJ9bXw9r2XHYMkmjbJ9XAiGEG3VEWK6bjKHbHgwJqnOBzTu9w@mail.gmail.com> <CABBYNZ+q1c+3Su_3_ib=zbVMD35tgwMGjdV3OwM5a3GXOq1aRg@mail.gmail.com>
In-Reply-To: <CABBYNZ+q1c+3Su_3_ib=zbVMD35tgwMGjdV3OwM5a3GXOq1aRg@mail.gmail.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Wed, 20 May 2026 11:23:47 -0400
X-Gm-Features: AVHnY4Ly9EYVafSVpHEUZjoh9JHHvcwwAHH-2CuJLkG1smBNZ9aE0PeIcKBo8bo
Message-ID: <CAJJ9bXykBr1FQP8++kUL7ceXKp2u92+zySCqVEQqCm_+KLXj0Q@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 11:19=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> This coming from the spec is priceless because silently discarding the
> packets means the remote stack won't know the responses were
> discarded, causing the stacks to go out of sync. We also shouldn't
> process packets beyond the allowed MTU. Therefore, I strongly disagree
> with the spec requiring an identifier on the reject, as this implies
> that even if a custom MTU is set, the packet must still be processed
> if it exceeds that MTU to find the first request command within it.

Should I keep a verbose comment string about this rationale in the
next version?  This seems like something that might trigger questions
in the future if there are issues between Linux <-> noisy/buggy
stacks.

Thanks,
Mike
