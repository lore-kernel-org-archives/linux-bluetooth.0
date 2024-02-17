Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD1F6D1D3
	for <linux-bluetooth@vger.kernel.org>; Sat, 17 Feb 2024 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708186209; cv=none; b=Aaa6ysyQp9NX7jeNTxwjpw+BOHhuG2AiHwjhtPTd93AjUEDngs+kAtKnWkvEwNg5lIgr/3XGU8/iHX26FS6Rb/H/7ycPf8do/I9ku4BUXMXIwxnfpSSAgdlvuj5HhBYQZ3nnp0YovbDr+SO5ViAnx9H+YLlpWFZZJRFitV7qE+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708186209; c=relaxed/simple;
	bh=aTUY3fZNcBKr7hDfPHDDdL92Wsr5gM2pcBmKnrCESAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdjvLgJtgiKbS3o0LiRRDqSX83sslqn6GzHU/bGv77vEvZRoIlSrL5yB0Z9chnMrccR7MHvytElCvXmqnkEQf3BaLcpvsWyw+fMMVTgzx8J25H4KiHKVJn6GK+Xs0PK7vu5JHfrI42ew5d17dW/9WPrAMea/AikaHePT99wwQaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TiRUwEB3; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiRUwEB3"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-607f5395206so18826207b3.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Feb 2024 08:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708186206; x=1708791006; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2L8QVKs8uUl+dtAY9pUxI6hAyrjHAW4LkwFzduDsZXo=;
        b=TiRUwEB347WBR3idcEXsvEee0qsPGXqwDT1Io6mXNBJOo5kHJmZmriz91y8DIvlxVa
         zS3y1TfTYWmxIi0ZDtGlgTyascFTETRM1xgWzuwY1euApdmosP9cebBQ5IDiIXOnTzwR
         rFPVcUwaZ4YMSV0m6KjWIO05nX3f99ktjjosKkYIIGgw1HtY+eFPmFKJ3GdFf9PyT/GS
         6aIAmsNj3aI3wSgV2CyEVitvbV4NF7dnXgLJxOTF/l73qGv4lWjwvNNjNhx0z5C/bkbG
         uP0yAseLaI9U99uPk2Os90jI/yb/SICp2d7iVo4FRXBusRRKFu6vTnQnEYBe0RPn8kKN
         Y0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708186206; x=1708791006;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2L8QVKs8uUl+dtAY9pUxI6hAyrjHAW4LkwFzduDsZXo=;
        b=WlblG9apj+Pvee7A0ed/fzMyRsbFxFV18fXA6V2jua50xfUJY9gdiVj4T87lr8thHE
         zXTKUyeO5uFJQ9rGuFa59iXqAOaM7f2pMIMn+UB4D/GdOuhGdcenBC4uHic6FHYFa+Ek
         KZzE2KUvE/FCdNvWXD4AiRiJwaqmYlshvAzzsynrdSjb0A3vnplfqwPpb32V2xDiwVUV
         CPYlEzgE5osFZ9oxovCNV+P19G/nPuWbIZWeRAPl7odQnuQr2D5cKrl83z7vpAF1mfcF
         pD6fTxkp2JIwiQwUusTCDPFydgClJRg+37IsfUmGPvowJVM15uwt2YizpP3yYcoMX7BV
         EuTg==
X-Gm-Message-State: AOJu0YyGBfP9T6D3HBegYC7CkNhJ3G26UlTfWIkb4s7wvrYhbA54EX2o
	rAal1vvkiJpSCg9A3J+k8q521mX2A2HBC9qUApQXxHHy1dXdC0y+nahuh7PW3dyg7uVPmCTNXEZ
	h30JZtoGXEZz2FrdA9wkFa6BEci5zvq8I
X-Google-Smtp-Source: AGHT+IFCg7pf5wMaACGUP5QSEv6CxcMmYhjeJwFUFWZBE22blaftWmpmg5G+onFmkm9MUQXIn5aOE1PrfOT3H+T+2JY=
X-Received: by 2002:a81:6e46:0:b0:607:9c75:e249 with SMTP id
 j67-20020a816e46000000b006079c75e249mr8153536ywc.13.1708186206562; Sat, 17
 Feb 2024 08:10:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216-hook-fixup-v2-0-a6b192d1a6ad@gmail.com>
In-Reply-To: <20240216-hook-fixup-v2-0-a6b192d1a6ad@gmail.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Sat, 17 Feb 2024 16:09:54 +0000
Message-ID: <CACvgo506E_1skkT52XeXLYmKtyGDxPET8U9eH91hpGsObshTCQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 00/10] Handful of build fixes and cleanups
To: emil.l.velikov@gmail.com
Cc: linux-bluetooth@vger.kernel.org, 
	Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Content-Type: text/plain; charset="UTF-8"

Hello everyone,

On Fri, 16 Feb 2024 at 23:11, Emil Velikov via B4 Relay
<devnull+emil.l.velikov.gmail.com@kernel.org> wrote:

[snip]

>       build: drop %.rules make rule

This patch is flagging a bug in the CI and tripping it over. I'm
looking at fixing the CI, but for now please drop this patch.

>       build: move public headers to sub-folder

This patch is causing failures in CI, which are not reproducible
locally. Do ignore this patch as well.


Kindly let me know if I should resend the series with the above two omitted.

Thanks
Emil
