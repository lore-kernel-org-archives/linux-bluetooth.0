Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3279A20315
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jun 2024 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718209454; cv=none; b=V3+GMXQEih/nTROhjjgnA0/AlwbWKyj0HTxL1OiK3pExudSEox6jll6L5npDO1p/FFARNQN6Q3sAEcDOTc6ADQW43Es0lPphVlS2z7phCswJzdK3ZQfBZwVK+m5ecLc4msjvCpQY1yoqZ5JH4pxa8d86BmAxq0msK2uaefIets0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718209454; c=relaxed/simple;
	bh=eqzjuOWyrEa9YzXQVerVJUHAaVhX4C+JqTNnvbWwryo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfTobDVRzNiZmCaoJws4yC8Z4R7ogIfngliWX+0SE4rEsyaHEpA/LTimrKD62yzVIhenBPnfK6YpcX09xoAv4199xb2+bedsQ8t0+9HOBRF0SMhsBBIF053R1d4xgVjP9bDN/L0U2GeGA+p51oaPOpyd615N62ju2pVrlUM1poM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=udcHaR+L; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="udcHaR+L"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52962423ed8so72637e87.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jun 2024 09:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1718209451; x=1718814251; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eqzjuOWyrEa9YzXQVerVJUHAaVhX4C+JqTNnvbWwryo=;
        b=udcHaR+LlWC0GQ0Oro2LIsD6FoEc47NN9ec+fuA7SX7Jrec7he2aLvjTYz0n9skpsL
         mYDxGAPQWsAkbr7MG/LNE5VC7Cr/dFTgpayRNjR0HRkUcvn2eRFI+lQIe8ETl6yKdhxe
         cOdEksXdQT0OPvEb6UXoiUqjIQn2eNmFkrqC2sUI6Gw4qYySrcW4+aNMxPsRrD1SxYvv
         D8V3WviDgRNXix+q4v6kT/sS3YGc00qNGas0dk5oauWC3bCHVvOtR83iLsC1aeyXEdk8
         rS7ULL+ivXgpgsUAoa1O9VBjlVMkEdc89NRXdiEqlpGudHAX6TLMmNbugX+ljNjjQkQx
         3WEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718209451; x=1718814251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eqzjuOWyrEa9YzXQVerVJUHAaVhX4C+JqTNnvbWwryo=;
        b=lchYj9vCHmbnqrKmNBuXN/eoFObOMiucDJT/knxMUg58gTfQPez7EXsU0QY4zQXfXD
         6ZnAIB3Pwihrz5Uuz1nbuvctLUgvI387HeQ2Lnr5Q+mikBC8zIyrrtQGPhgbc+Jt7hE1
         oRwLmnq38GTo4RBE/YH74xJ36kOgPpQRFyy9pw94dyMGMCojARqLVntJwM29sR11NrDd
         7tHolq9NwuFG9g3Osy9IDKV8PyFIumVoi3zHf1UyRoUox0YHLLNes45qe9278DGEn9AP
         jnbR7FkVfl0S4QTyBDLvfYyIOmPhAYUG4HVTdUgN1B+u88LrBWC9wzn1EA0JEQknTntS
         KNhQ==
X-Gm-Message-State: AOJu0Yy/w9ugj/ZiFcBInlVVt3kADXo8YKsf6oquhVWUOJ6M7bdhmjzW
	eZBpSp6u5QP3Y1+4Ar5GxLSsMtHFp0ipaqddqsBEj8pcYGeJj9l+m/pDFNFFteTEPWjhSQKKj/l
	cPQsJEk1bQlKASM9BMVqWyWK0k1cVyVhGkQizLA==
X-Google-Smtp-Source: AGHT+IENcj6zDyLkFY7inj5jGx3rhVvn/zu6z0i0nvNIyCYBZlSXpE9BcpC1dkJqApggspkKE/JhF+42lZlJ4+LUmVM=
X-Received: by 2002:a05:6512:33d2:b0:52c:8215:574 with SMTP id
 2adb3069b0e04-52c9a3df263mr1784728e87.38.1718209451524; Wed, 12 Jun 2024
 09:24:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610223601.378127-1-arun@asymptotic.io> <007d6587-74d0-42a3-9106-1ee3411bf15f@molgen.mpg.de>
 <CAN03qa_uSnT6XgaLfPog9FZ6uhO7s=OoPL4C0XhN+C_Ot1A38Q@mail.gmail.com>
In-Reply-To: <CAN03qa_uSnT6XgaLfPog9FZ6uhO7s=OoPL4C0XhN+C_Ot1A38Q@mail.gmail.com>
From: Arun Raghavan <arun@asymptotic.io>
Date: Wed, 12 Jun 2024 12:23:35 -0400
Message-ID: <CAN03qa_S6EpV3tVYMZi9RC65=N0FHA+EuCWs80uqk_88YQgGnA@mail.gmail.com>
Subject: Re: [PATCH BlueZ,v9 0/3] ASHA plugin
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Paul!

On Tue, 11 Jun 2024 at 01:45, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
[...]
>
> Could you add a tag
>
> Resolves: https://github.com/bluez/bluez/issues/481

Done.

> and maybe elaborate, where the spec can be found, how this can be
> tested, and with what devices you tested this?

Also done, v10 is en route now with these details in the cover letter.

Thanks for the feedback!
Arun
