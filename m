Received: from mail-dy2-f24.google.com (mail-dy2-f24.google.com [74.125.229.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E433ED5C3
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 18:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790189101; cv=none; b=WKmW+l9P8myOL5EZv2WHBr/f3Xu8wIRfyvP8WvQ3CYPVGXHA6XgaJr0H5Z78mxoHJSgbiNKPGdrxDhYDGjhwbzl4Iwdyu+JAu0VMXwee3lo1sjbr2irDHtwzJ2j7C+HlYwN4OIYpBfqF9sP9zpe6lt7JZe6rJ3S25u5vAEE2hpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790189101; c=relaxed/simple;
	bh=ODIeAMZgKXTTgbL/Rh4LqJ8uuq9f6U9Lge/g9uhL0L8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XBvF2PsOntL9xrpTdsmGCoxIkmq7oAFXbH5BEnEfvzFvHOSnRhvOoKhj+INguMuSbDeDDQRaBMD/D4qAScb2K8ncBU7sqFkVbCqVGGaX+xzBfmPuCxcelrGw5BWobNPSnrWQjepdgSIOJIvCEAaHu64JHOEt0q9yIcopo2P5xcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVgcu5wW; arc=none smtp.client-ip=74.125.229.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVgcu5wW"
Received: by mail-dy2-f24.google.com with SMTP id 5a478bee46e88-328664dbdd2so422717eec.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 11:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790189088; x=1790793888; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=q9MAQ59/hCcbVBH4L1SMsmZuyeFLeZjiHw+7bt6iZS0=;
        b=fVgcu5wWJMYUYXOoY/E1xn7bEi7WkfOMXYBFELvVUwol7ENhA7Ysm/zXWRXz3j4uKz
         SwjmvZSENmufdOVP+btDBXIyv21BPrZKgJnDfLd/tDDShERd5DlR6OssLXmtdCst8vyN
         9odRm9QCszlhAMuurtMAYLBJclGjANPQ7kB0lELzNgk2Jy+9P7E8lg+S9KNishgh4VRx
         E5cNYhYIDvNEd7niMsxXcpWKi0g9Ai4tdBn4NFqesxy9sax0s5psINIuiKdeXvR6St77
         ++8Hr+R6uorgiccIw6ZgcNax5tF9/1oNuPbIdic7jnU7Rb5M+BbebDJqt21uEQ+zGxYt
         8F6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790189088; x=1790793888;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q9MAQ59/hCcbVBH4L1SMsmZuyeFLeZjiHw+7bt6iZS0=;
        b=SVXlsNXmTy9qILJhtcSr1QVDnNdz42+sodlzVxqYj0Kxva7oUfg4T+PXLSri2GCK4V
         iYmhfcJVWHAMjTCBDR6e9T8uYKsvkGyI6gkDyxLKNCH+rl+MgiupsIM9uMlyjCkd+BpA
         CP7tm7DtmC55gX9oomEKJhaMh1w4EN9f9TtA8J96FBVIWrAKq8y7R0jZQHFFUj59jevU
         Whk8pIKApv64SeKscvH1JzSP0U/j31oVwpeU03LQdi3yAHygzDz6f0eQZnKwzLVxcy6h
         ZN7y8ewr7kvtX5B16tPn6X59WzTvUwMlz6iBKNH03zzKRmgxDbwGbTmNdgzf2DhB7vH+
         2X0Q==
X-Gm-Message-State: AFuF++n2W0o17g5E34ePJm2EL+32VejrsG8wvyrzoMeGYL1dRcgWkJ9e
	TPOs5pU2Pa+AuzdGcgOgZCRm/6vN2JMRlrXqRvGVTYTwZkFTkfkDhPElycOzNw==
X-Gm-Gg: AYBFou0EQjozlkCdf0sYK98duN2LSvmvZ7K8O4s/g5rHAaBF2qAPuVrHY1tK0EpNP+m
	kNZKHxRp8sq1ofFivfycg5QsPrPehemcfVUKQp6GaDFsakuObiHEfQt/vVVE51QCfSJwjJessgF
	grQkHTOX+a53S2hsMIh8+nNqD2xdahwvhBiwxSVlF4fBEIcYM1TifP3EBtCR9uhwWiJTDHYdh/V
	l0krvhQtWcNC4lHx25RmFDkuPcbmhUnUAMluArd9oWPx7ubDFuW1yLHy3i556maZ+XGqxcwaz4P
	2YH5TVLDtmKauAZCAn/uxENZ8/CDI4sxwcC0oogX1Psosne3JSuWJ7JlxqJHmT9zC6C5oy3LsTF
	JYOPujyF/ZX2YDaGJuTDx79PKzYyScpk7fE0NSvrn3dbOSmaSJ9vvnCNigjsF5RvWvv7AY3Wpi6
	Z2pzDWNXyRjYrAQYHwngqusOJRfVSJQR7Y7lhjfCVSdMBFVDLtJwATO6Uag1Uv5owqZ4d+KOuf8
	NZHfSc36UdoOVJaXto=
X-Received: by 2002:a05:7301:e0f:b0:33c:29d8:bc21 with SMTP id 5a478bee46e88-34004a89af2mr26104eec.10.1790189087559;
        Wed, 23 Sep 2026 11:44:47 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.247.165])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e97236754sm6270714eec.29.2026.09.23.11.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 11:44:47 -0700 (PDT)
Message-ID: <6ab41e1f.c121173f.10612f.a325@mx.google.com>
Date: Wed, 23 Sep 2026 11:44:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4985839257616427306=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jan.brummer@tabos.org
Subject: RE: [v3,BlueZ] Add cover art support
In-Reply-To: <20260907193404.124504-2-jan.brummer@tabos.org>
References: <20260907193404.124504-2-jan.brummer@tabos.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4985839257616427306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [v3,BlueZ] Add cover art support
   Pull Request: https://github.com/bluez/bluez/pull/2500
   Created:      2026-09-08 17:17:43+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============4985839257616427306==--
