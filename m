Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAD633F8B4
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789753185; cv=none; b=JogTGOweOmX65d0r2X4f2k3c1XP/IESHPswHOAQFrj6+rpxuin4X/6M8xhdJWPwmXzs1p5b5Je+S3JWUv3CCMjDgE4Fo/xG6Qw+qH5mNeKBI7GpjcUd0eTAdXq6yV0WEEDasT5OXcFSpBolLR1a9CXsMRx6ahEFmYrQ0ehEjZAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789753185; c=relaxed/simple;
	bh=hpn1m1/C9tkZFeA0xu1bqQDRO2ElG8xiUt6Nfx7hSEI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ho+aLUUnCvn9XmpjXtcDvs4x0eZG/icV5x/1I6S2AZzezBT1IMD5qUU7zj5mxpPYw3wg+p2Yxj+fUe2qkVMFdQGzjgJ/+RiaKJdWzmlXlywbEzDowLaX9J58I2AvW6R18G55VGt4xPUd9gk40yIkBm/+13xm7vqVh4AP90ZGi0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDUQA0jG; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDUQA0jG"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6c8f6a53fabso2058491eaf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 10:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789753182; x=1790357982; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=K1nnYZENSOBZMLerrTjt5UDTsAoQ4RNuPPPGQzdlY7o=;
        b=SDUQA0jG2s3UyzUZqP4ELCTv2ECiXlDdVdkTT5p7eWD8TmVnpN4nWIjHk9P8MW6TFM
         QGMzN8Le1PH5YCpHKc6g2gGPBaq1FxP6IFRa8rjnQ7XOrzakPcdPKBeYOXGgvBPndG1W
         j7+GCQ7pLef58xRdneE7cxJuUQ6MluDqntwdMOmN9300g33vrXJ7r+QxCNw6n6fbWSFc
         bEOKPUK3kqJvYUdf+SDfaH1Me5qPNPwhBiyfS/mgJ+HBN1IJDnQPdmvnVo75aEXRcZ8E
         OP/pZ4RJSgSkyKwCay5hx9GGB7UGykTkOlcRfcPig2u5MsYxZUrBvdFImZAfnRqbpIQw
         iefw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789753182; x=1790357982;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=K1nnYZENSOBZMLerrTjt5UDTsAoQ4RNuPPPGQzdlY7o=;
        b=xaOim6XSpeCj/Ix4vnnFNzGYfGcKBLGYItYo5nsxKM3BhqeNT4GaQ6j97MwZ3qCpi3
         1vVIw27hWrBUHYjAaU5RmnmtpoU5ZF/7l4QpDrY68afhX7SkrD/7x9bhWtBdAxweY4UP
         lxXFFcaLb/sjIx4/dTyi1Z/WbT2lyRa7bmgOBOyOoGFRP/pycWcKc4uFPdB+WEDq5ofM
         qzMJeraxeuQGbYYXzpXzvt6y6zO62u9zAPmMZVlOu+W99utd8d0WtJJANR/kd6IMgHy6
         dU6pbx5ZNba+1JaVYF/voQzsx9vHTZlnwa6YQgATCj/odKcKKb3wLC7jUR9yvo0TjOBB
         ytSA==
X-Gm-Message-State: AFuF++nGCuWlDl8ShNNtnOWCbcpvwqps6g/bQvQhANM+6X8QOuCgFVW3
	z4jSnhq6UxBILX4L9XAT0WzqocV2oarT1zVS1Gcklyx+bNGrvJZJvtOZyatmbEEo
X-Gm-Gg: AYBFou0TzjSWwU/+9Pjx2yDrRqGRgHP78W93ldoV09lXpc1IibreB+ObzwGWlzT5Dmm
	9v7Sg5dNoBsdJiVJK7qTKMqHQUa3qxafN4jE6NeyRWe63E13cX0RsRLFsziY87w4vBZu4zelKUA
	VVwm6ND6Mrkyt4HrRy8sfPIRhDCNY2725Wx09oGRwEPWsvaMOVqwP2+4CZVVXmBmhWEFLsv+LtR
	d1LPp6CdF90IkZXHDmiPFcBYp/W6GcR43TmPIg3isKatIi7VzSqND2a/DRPgUXgCuBgK9Ifp2mT
	D485SqtJMFqvTwoWaVuwWb+8gXOfh4xNf140s+hGEsjgWxrS+d+8GGofyohLyBShk+oTqKkN+uV
	zXQG3HTj990Cy0GcNHcbz3tYilypttnbWoYI0Q9yRabCcON8pNDGqEwJEIXUCkMAQHDhb8zsIX+
	NN7SOqFeWZzzoNF8uwP81ciauFCxgdCsTGLvLU1XY73lwKCkeSTM9jTBnDG1QLHm6iY/kCwSlez
	ztjnOT+gU5C6zFBFg==
X-Received: by 2002:a05:6820:2908:b0:6aa:e367:a3e2 with SMTP id 006d021491bc7-6c8fcbe8c0emr5883986eaf.19.1789753182052;
        Fri, 18 Sep 2026 10:39:42 -0700 (PDT)
Received: from [172.17.0.2] ([20.118.221.216])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4873780b1c0sm1806773fac.1.2026.09.18.10.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 10:39:41 -0700 (PDT)
Message-ID: <6aad775d.f7f62383.8f14d.ce19@mx.google.com>
Date: Fri, 18 Sep 2026 10:39:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2642038800954727470=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: input: avoid NSP1 disconnects caused by Sniff/Exit Sniff churn
In-Reply-To: <20260903114849.777525-2-frederic.danis@collabora.com>
References: <20260903114849.777525-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2642038800954727470==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       input: avoid NSP1 disconnects caused by Sniff/Exit Sniff churn
   Pull Request: https://github.com/bluez/bluez/pull/2480
   Created:      2026-09-03 14:59:47+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============2642038800954727470==--
