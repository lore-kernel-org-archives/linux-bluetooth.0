Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5E63DA5AF
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776267090; cv=pass; b=ul0kRga2hGxFYmxas3DVopP0KXWErAXfkGEKgbknF4BF1rG6RpCZNgmSUO7GstluIoweDsZv4s+lrfNRE5x3xsOiReB+31SA0wR/5/ln+Grs+PkUte5+frWQ2x3EQGQM0+dOb7HtIX0modttI0pPnxtFYUiyylLxyOLFRFICI4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776267090; c=relaxed/simple;
	bh=eZZ9MBeGinL5cKg3LaYZTrFFidLDf8L6MNP8Brjr8zM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6+XO/bymNkJPjPcf3B0iAECYZtO0vgnygkdR4ql0y1c5EK5A10l+4aSjcNYeYHk+XRRtx2YVlQj1/0CKZ+dPYNxn5Ad531sFFBRyNor3xx3YUJi9iYthuoFVs6ZXB9jJ97zZzI83all5qg/JAcQVxqLvlA50hNZB+Qv4s0CRK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xh3vE5Ka; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xh3vE5Ka"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c70f91776fcso2877506a12.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 08:31:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776267089; cv=none;
        d=google.com; s=arc-20240605;
        b=iQUbE6VEGciF0MYVcMTSYeb0hH9trLofM4bO0oN0bzAMtEEwvNN0sPQZHbk2YRiKYK
         2NysYQuAMH+/xLXUrkifmGymEFlNbjY9hvsauC3CddqyyxZLTCzLgBnF0g4pKZTEbaX0
         M4JNLWpLph2qtpFwY5ufNOSkvKZ5Q21Yg9IUVN+NYuPO/DogGJJANbdVwymw4x8IOjAL
         mGrZVPiEcTD2BYpAkG3quUTDG/xiPJa8VZtA+VBk1BeWekABEdlr2Y0bbpSHIaX+QsUK
         T6T8j0JcJXWxSrJ7ZAlJQjzVt4RvFPA5mXNHo8U6+T1pjGQZ7rwKEENa9ZzFRe28LMRV
         WcJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eZZ9MBeGinL5cKg3LaYZTrFFidLDf8L6MNP8Brjr8zM=;
        fh=arJdGaw9/bCxNhVP2EWcgY7P9XLsigyVLhNR3P4zUXE=;
        b=CBFEHsnDYK4AZ2nvYKL+O5zdpKvaHbg1JAKgNcp0VDd9H7u2ZTtIl/HYtxgffDAc5C
         q1dM08CGJcDkcnZWS2hP1vmWmL5NwiFaNF1bxRgHCTwApTBZhVTfw+OkswvNg6+XnzLA
         uaeYlxQWmGoaQaFT0//fUQQuf6SF3Pbwyw583UEqkdYRFoPglmQYDnEFcrvx4ieREUdR
         RHbwHMjAGAi5RR0PKFrBTRF6KETpnAlKGKwP4SlRbk5BCBUdSLIL21t4YzW0Ao44R14+
         Z9ltiWvVmFD1SJ/2/cYsAeuRNP/2Y9xa19XPoDMhMladfsaRqRp5qscw31kcG7otPrZ+
         9W7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776267089; x=1776871889; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eZZ9MBeGinL5cKg3LaYZTrFFidLDf8L6MNP8Brjr8zM=;
        b=Xh3vE5Ka+ikHFYhtiWH88Gnvjbdgj77mPsCMci+y12a1lRzUub88MtgbVD5clye780
         QEvQxOc4RVKnxPvwkCtiwD6u6bkS1laWUSg4b+GN4gtAyggysNZeXfyWACq8/oU54zKq
         nv3kVnEpRXgk3nDRnsU/Ljg512hEAlUXA86Qe03v6D6t08238Uc1J7EtoR635Kro3AMl
         PziUR+AAS1X+IIm/lNCI+5cZx5s8kkP8OquVVxX01TZCUYxxQDr8P2eUv9U36nwHLGEC
         TXFW3T8IOx8aSt1GA0GdOClDXHVaZo6HzUuJy+sfPMJhsWPlRE0nI2hGnv95rcoaOcNB
         KpTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776267089; x=1776871889;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZZ9MBeGinL5cKg3LaYZTrFFidLDf8L6MNP8Brjr8zM=;
        b=Hccs/hSeNFHv+Y1qlb/vpkcJAbCWPn69nVkhyVYCB1ub837ZidVwshGrfVg3s4iF35
         ptzn95xQiSRtk4yp4VzWXLezl0PO8vWLVvArQyyLtfz5ZXXxdySKt3NAEaAqus/u/JJa
         BLAD6blD8K3ug5VNYaFTrWapwfj+Qmkh1PlRNdHBfsVKW0L5sdtkZecuYzv4o4+ujol4
         pu7iLxxNeS+Ij9CB+dLEio4qOb70va/zY9VhcEFDqcKKVbFdd5ntxPkrOomg8VDxLQgt
         xspYncl6gYujfvIy6ZIaNxmr9wr09kXsKCemPpehTckoy2HjMGoxMLAJuF74NOQ2pIki
         uFhg==
X-Forwarded-Encrypted: i=1; AFNElJ8aSPWVtLMjRch5EX7sVox4kFRFvmNWwFF+jjS7zlndD8DlTwyxi3AiKHo1ZduhJA1C1deRR88Nr/RLS7YdeuE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1LgFflaNrbKciIRgZO+MFBt6WFfVCX3Dj5/XZOwUHLGE89eeC
	75Bdvp5/Y0wXmQwCId0e/45fyoN++bCnotsGzR6TwTE55zTGJ6QJKTjmWx+xabunGTjv5B3v0te
	MRCikpRcxcTsRjNA2pR9LanCQWemPuVY=
X-Gm-Gg: AeBDieutGUPqFcAcR0F/T8za9VeGw+kH7ObkZP2PlCuuVAiY4HUCRffgHzULsC377w3
	Y6DBkDqYlOdJZn3teQc5EjjCfRPT6CQKrhblboqfjqD3dDe6BBpK3F2dnTVWzqWtMvhSEe8vdHO
	mna8w2XpeJ3WOq+PmckEF+VIskKxLRoyCrtoZ+azdaXja3+QXEmdYiRjvN/0AiV8mU3P0Jnp1sk
	P9JoXiYLdNqvKbNjTLLvceC+RmEoxnnZseypfNcRzJD060WxrclJi5I9uol5fYDNcSoFH45XW7+
	rC0OnE5ujHnqkBs/cuBc+tyqrgYqyQ==
X-Received: by 2002:a17:903:1211:b0:2b2:4b4e:e4d8 with SMTP id
 d9443c01a7336-2b2d591b8aemr215377705ad.4.1776267088525; Wed, 15 Apr 2026
 08:31:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407-brcm-prio-v2-1-3f745edf49af@gmail.com>
 <CABBYNZJAEqwfTuVqbFAnx97HBSjcwn3Hb+y+r4r2C=MMPxFoDg@mail.gmail.com>
 <CAMT+MTQ6orj5tpiGL9hz8m2TGiBjA-9D_0e1iLt=_dXBFHcOgg@mail.gmail.com> <CABBYNZLNR8hYS9jLLKeB=M9XVvtSFtf1wi4DmcJKBbQVvHTPaw@mail.gmail.com>
In-Reply-To: <CABBYNZLNR8hYS9jLLKeB=M9XVvtSFtf1wi4DmcJKBbQVvHTPaw@mail.gmail.com>
From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Date: Wed, 15 Apr 2026 17:31:16 +0200
X-Gm-Features: AQROBzD-Fi9TwOA2iNwLMvKH3PB5XbyRvKB5pMzjCowARYCArTwXFPUUzeFibBI
Message-ID: <CAMT+MTSdVnor4+3vXhyfhye2kVp5-UPgg_Fwm4rH0mJHM_FuAg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Add Broadcom channel priority commands
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Apr 2026 at 17:19, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Ok, then maybe we should decrease the priority, so it can only go up.
> That said, in a multiple connection scenario, we cannot really tell
> what should be prioritized if we cannot momentarily decrease the
> priority.

I believe that the priority is only per-connection and is not designed
to be used per-packet. On Android they change priority when an
A2DP stream starts or stops, by sending the commands from
userspace and are accepting that other things using the same hci
connection will also have high priority.
