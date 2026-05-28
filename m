Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCAD3431F8
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 09:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779961190; cv=pass; b=LWL5R99po32YROeVQw7RD0I4ffFvEhsNbi37QmHt1aM2QuiMEOKioDI04IxSaqu6NK+AWAuFbNqw29ikaEX4Gn59k45lTEBFqCo4Jb27eZE2EhledevazIIytOiQuZNWD2XlvM383CZt3StIucWLgIYOs3ZnEq1BG/v28fF+rK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779961190; c=relaxed/simple;
	bh=ZjoRZVOC3BiJ8sTFOvd7me4OSSafSXtJhH0XvqDUIN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVzQaBxAKg48cFTZTys7gAJJHvapgsgpWnaK9u+sjN1SHVJnabysuMLhkCg0BBCBGk67hi2BqQuY3w1aA876l4LeGIF7vJI5RKGSQ9977/LOStYBD/oon39DSad12i2mkSPmQBRsPjptRXT7Sr8c6ZpUoTHNMGAdN/IDSETRLYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDHdc7XG; arc=pass smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDHdc7XG"
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-393d07e8938so12249551fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 02:39:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779961187; cv=none;
        d=google.com; s=arc-20240605;
        b=POGtbPJjT8i5CkPib1nHfnbou+wV7B+10ZnMln+XUkFXpdMkifsfwWdpneCHTh93NH
         0cqljND0t5+W0B2zFOSXP9cr5HY7jIvlRSGaNqO77NcKJdndq74GGLYB+2e8hii3sEph
         FwLx0MOPU2Bw5g8RmuWUF5z2ihwSAR1dq/rCpT+flmPDh2DzpwC5Fd+gB6WTAruH4aBM
         lBUKJ1HEvAmYNJvGTbxtdeuHY8v/Mqa4EK4/shYh/wQ5LiF6viOj7w/8ftI2T67as2kb
         wMCNhNeHOWwb6S5WCNAIRgGn+DVE8UgEJhnCQ4AjXlCl8wGVR8BHQsRwgMl+o9TmER6v
         hzjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZjoRZVOC3BiJ8sTFOvd7me4OSSafSXtJhH0XvqDUIN0=;
        fh=nAzYHZTpvnBiqj688TMEgktk0ZSErdxM0icNo64Lyhs=;
        b=FUUbcaPKdVtESmT0Zm3QivLGLvz9DvnBlFDwYU6VeySWvo41biUTISwpU6GsW2gX5X
         pTx1+8WWcwhfUWAdcPY4oKrueV3MYfR8ccnFuTVmlSdfdnx1UbJxXxRr+lYkXG4rF4fn
         FROupiwUfif1+xIonRbVHUxFki0+NKu5vUDl5KfDC+omhc+j7InWpLYtl3JHdACnOWMD
         ViYv7ZvNBs82/vaiJSazE3GFZ6+Tkt6NcdDrBu7YtIR+CvkeCUC4rr0kVvWLJnLHRCB9
         koC0GXxk4RnrUeEa/T/zipmLXzjVCNDkZrrF2+VE2+6t+CAyN2RxAej65T29TL8emckr
         EOOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779961187; x=1780565987; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjoRZVOC3BiJ8sTFOvd7me4OSSafSXtJhH0XvqDUIN0=;
        b=DDHdc7XGVx4OFZ5keU1iCvVOHznYO77LBBFtQxftx4tklU3OdRCtKMIh1bCgJLEyaB
         3Xh0BBu1d9kXXyi+71Emk0J1X16MNIiFR9XbO/SoZHi/7vepDYn91X5IchvIZeqcBRFX
         +vWYgsIiqLoWeH+Tru8diUgA1EJzxCNOXGoXAjuJS9tvCbCaUXDXxT9xWdK5lCAFobCE
         bGHb8qiKG9DCNo3lvF/HCkikZ6sW86n2JDcfH/nQ+vNxHNrJm575x4KhDLTWKhv7es2L
         zq/hVz9oqo7sg6dJHZ1iAuoO6O8JRqkFw4ORS9bA7o39WAoVG1LnY+NZB10+m2JBac2S
         m6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779961187; x=1780565987;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjoRZVOC3BiJ8sTFOvd7me4OSSafSXtJhH0XvqDUIN0=;
        b=E44RpH3OUbZMUSqok4w172rpxhlLQ2j2kkuTgAhpCpd5++J7rKQWESCYN26BSCzyZG
         MCCZifW4Gf6ZICwbsF7/earScIwAq8rY+5EvUguMVZUpp7mVFVM7oQafABJDyjLfG4kG
         BVEi55INtmZFnIyZq4z5odKawF7qolTPB/g1pu8m5bFWebaHXvFElKlWNEohtZdgeczM
         pdlj1cjdc7NcFMewesJxW/rv1H2NGYaU/PoCgltBsPtUhnzwP5GihGpeRC/Z21zHzrGg
         NZ0Yu1nHLr4sA9eiClwAjaMbvkYALuOh9vhSIzD8nDrl/JZunzGAAIENs9JuufaP70a+
         yKQA==
X-Forwarded-Encrypted: i=1; AFNElJ+BSxwCoB4JqUDGrZFOcEl5hF+PHr0fPixg1KvITa5fHcmRu7bVQ1bHoV/xN44M1S4FRE5WpTsq9ZHjv4NhRAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLnePYC+ijCSlxP6t/QheVDazVDEZAHVytkUt4tBap8vB6C2uS
	e/sMLhvHUHequTIvVW4kWHAwqQa5UUw8EoRR98RanhyDUpMG4R5GHStjAiMjghLhG0HYGwR2rvx
	WzcMXfa+TLlI0aOnVmy0mdvqhC88leeY=
X-Gm-Gg: Acq92OHlTccZsamFFbCJHw27IL/K6kP+fRs0LdCAZBbh1DhShaxQOR0nDcZh8NXHZ5q
	keHU6c8eqMFH4SDuPza5JodLQiWBfEIpRrs/ZvdiJKi68jvO0+a6XgmwKo7xEVM0P/rxJJKqJ7p
	SlFTlF+BAzdnz+zlCoff647Xg8Uiuo4vnQD5mOFyLluhF1uSZhp+YWRXvk0dK0D778cRCWKq0+k
	1vstN2fbSjsuMHdlW/V7HL/R60zTONHSkFq3EYRmdPZc0W3mXDbmzBRchWiGhfQO+BYVUgdvcEo
	ee8VEegmatAaWn8c+D8ihqycbMIJHp7wdU3ZtGcBSA==
X-Received: by 2002:a05:651c:1469:b0:38a:aba:9bf9 with SMTP id
 38308e7fff4ca-395d8c55353mr81931541fa.8.1779961186579; Thu, 28 May 2026
 02:39:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528075701.3417224-1-rollkingzzc@gmail.com> <f44f9f90-e71e-4e92-8af0-9fe6f21b2989@molgen.mpg.de>
In-Reply-To: <f44f9f90-e71e-4e92-8af0-9fe6f21b2989@molgen.mpg.de>
From: Cen Zhang <rollkingzzc@gmail.com>
Date: Thu, 28 May 2026 17:39:32 +0800
X-Gm-Features: AVHnY4ImmLc7AHwPLPDSR32b7H4rLwppQ6GRt5u1zHxIQ764osp6JgWABXLO6gM
Message-ID: <CAB7XQsFN=5YnZdo4bRpdewV+vYtvpEayi6dj1o86jmpn1Hz3-g@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: MGMT: validate advertising TLV before type checks
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zerocling0077@gmail.com, 2045gemini@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Paul,

Thanks for the review.

> Does Linux log something in this case?
>
There is no printk or other kernel log for this case. The malformed
advertising data makes tlv_data_is_valid() return false, and
add_advertising() then reports MGMT_STATUS_INVALID_PARAMS through the
Bluetooth management command status response. Keeping this quiet matches
the surrounding validation paths and avoids user-triggerable log noise.

> The diff looks good. Feel free to add:
>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

I will send v3 with the KASAN excerpt moved earlier in the commit
message, and with your Reviewed-by tag added.

Thanks,
Zhang Cen
