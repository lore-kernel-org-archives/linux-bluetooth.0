Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0A65B20D
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706190514; cv=none; b=XZzp/VXLGpAdVg4AlBIOMQ4HIKZZGHXZoyXevfqsWJQNOOI/CvdUvtfpEaCQLR5mHZPb7PVg3UBREEqQPQwvRPphIAVppc0/OWQSs1afvwaDlzELhrD/whjkSDnKozUHFp/79ONPcSIGdGLg8nGJrgN0yvQfDh2vIywpydFPnjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706190514; c=relaxed/simple;
	bh=LnASAZeAUAbnKD4fZJSYqO2AzRjHka12L8H7Zwkru84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nuV5xToiUJNnJIQk0KcGMQKzoFLB6PZNae0pDwBx5kab0F/+ai2j8M8L8qPlLtdlT2BpGzOJqT3UIETv90lUuYneobgFYajFnwMnaoUPzlAp87gw29EEgpG6Bt6YjA0VljKoCN8eTegQWYRls3lHoTBFu+BioMJBObx5lf58uyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQX+VNVQ; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQX+VNVQ"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc22ade26d8so5417331276.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 05:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706190511; x=1706795311; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LnASAZeAUAbnKD4fZJSYqO2AzRjHka12L8H7Zwkru84=;
        b=OQX+VNVQjyxCbNKmlUehE7+DLcmIEH2GhHDfCGsAnNCv+QhlnlhrbiS8ebhEXGzZZb
         +aZsqWMgKLDdU56sPWxirRWnsdT1e3CADWnD193vRfs91XD9AsnF9DqkdRQgy/qcXoT3
         BiECBedQO8dsN8HbkyZF4w1ckMs9PdL6SSAj77+5cv0sOr/3OlR2GVk6YjFdrHj8pzlN
         Ndp6+EpCPG/hL0NFH5iXpk7wHgkytEQe3w4g8XPD84yrY7YMOoTXdrzWJAGwXmHRH4WI
         ruE5CwlHWy19LvyyLhLbr9u9JFmZnnFW8Hq4Ns7YvIMltR/nUej+AxcCRRQv8NFghpPw
         ZqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706190511; x=1706795311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LnASAZeAUAbnKD4fZJSYqO2AzRjHka12L8H7Zwkru84=;
        b=VIztzDqP/6Y5WRBNtYmSGedmNFT8VWSD9hlgDn7mEVsRlkJ79zz/HtiU58ZQX7En3b
         Zbaox8GzX0suSe4kfTE19gGNOy1P/0gJCEIokf/kgcRh2aU9zUmuuYYLcAuGkiPkMFah
         voc605Q9oJufEdymrndhrgB+dbcKN0u+DNYGmBX241lxo6tZio+O2w+hXp1Vub3fTM07
         lMV6bEPtOMCqz+2VIU7/RSNAEOm1TFdikgkGpjrHtz2BSJY54Td/ydnO0wU5XwpsDo7O
         4gDv5H6AxZzN4ea6D1pnUGTku1OK6F1tg8IuqEHIEOBYreC0CbtTpeX4RE1KUVZ+x/bf
         FiWg==
X-Gm-Message-State: AOJu0YzKjU02L5bgl23zrC8Qk65BknIemVIuUEklSi0OCR0nYmXvzN+s
	atlv2Kk1jz7pYJXIWVCkaeJzQJDr9hgZBPH9s8qEMRR6jQM9tqy8SKD0aMCUeSkQvq6Sj81ZaC7
	AtXgEDIj9v1jkTj6HdN7boZRGLqLLm5tX
X-Google-Smtp-Source: AGHT+IGZgPRw+PRCdYnrUnRbG56+Imaa2aQ6edaPaCx/iMYC3qtP55pWSbguGXB8C1IiJ64Ka14NNAgSkLEbrkQ+9zQ=
X-Received: by 2002:a05:6902:14d:b0:dbd:2b6:6cfd with SMTP id
 p13-20020a056902014d00b00dbd02b66cfdmr651914ybh.2.1706190511568; Thu, 25 Jan
 2024 05:48:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125-rm-ext-plugins-v3-0-d141f7870bb6@gmail.com> <CAAEJBhKW3XZCZiz6MZ8NbCW61iU0gxL_LGru5y0Ubb_hbGAt_g@mail.gmail.com>
In-Reply-To: <CAAEJBhKW3XZCZiz6MZ8NbCW61iU0gxL_LGru5y0Ubb_hbGAt_g@mail.gmail.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Thu, 25 Jan 2024 13:48:20 +0000
Message-ID: <CACvgo50AWHGmYdRRLjq7ki=+FQ2J_YQq4JDg0PZATxorEjwccg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 0/8] Remove support for external plugins
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org, Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jan 2024 at 13:02, Szymon Janc <szymon.janc@codecoup.pl> wrote:
>
> Hi,
>
> On Thu, 25 Jan 2024 at 01:07, Emil Velikov via B4 Relay
> <devnull+emil.l.velikov.gmail.com@kernel.org> wrote:
> >
> > Hello everyone,
> >
> > Here's v3 fixing a small bug with the previous patches, which was
> > tripping the CI.
> >
> > Link to the previous revision can be found below.
>
> Just a comment that external plugins support was added to avoid udev
> dependency (from sixaxis) in bluetoothd.
> (not that I have strong opinion on this, just a note, I don't remember
> exactly why it was done, maybe Marcel recalls?)
>

Thanks, I may have some ideas why.

About 10 years ago (or so) some distributions were shipping
libudev.so.0 while others libudev.so.1. The ABI break was minimal,
although it was a thing.
I remember us doing all sorts of hacks in Mesa trying to pick the
correct one, esp when your system can have .1 while the game (or its
chroot-like environment) has .0 and vice-versa.

I would imagine a similar issue was observed in bluez - but I can only
speculate.

Over the last 5+ years, literally all supported distributions have
moved for libudev.so.1 and the Steam games (and runtime) has both with
some compat quirks to avoid explosions.

HTH o/
Emil
