Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820E321A06
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 05:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712294972; cv=none; b=acyFo7gFKAOLrrfjnIZNlijuhe1YI9b6yS3DKGY4OIu3rdRa6G9txvEvJGbb6o+Lb3rXG42+8VlCmwLQ2OGBdDfJzPdcGojU/4LpMywiiJzG/DvWr163ErvFkI97ZL3/7j20uU2gAf4VvUWH2oC2eq/NltePyXMJ6MwYNKrrL4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712294972; c=relaxed/simple;
	bh=By4YfxMx0xLCKiVl3YLHSwavXB7v1ZtvNWlRMIkZ7zU=;
	h=Message-ID:Date:MIME-Version:From:Subject:References:To:
	 In-Reply-To:Content-Type; b=YM/DXCqGC1b9rfWmlPdJGmxypspmdYoCrR2JcKpfP8P/oXerIBfn+q2XGeKSoSR9WYYCsTm1Umjwgif/YVlfvyDtJosHV4YXGO1qPy56fo08CwrbOGM5iGxX6IS4AU2TBLU+3H+wF8gcWoKhv3Car62p5Iq2VaN75Q+R3amfb44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=E0LjyJKL; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="E0LjyJKL"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c5db6797deso457198b6e.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Apr 2024 22:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1712294968; x=1712899768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:to:references:reply-to
         :content-language:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y5P7Q1uPkCydZeKXyEezlbA+HvcL7kOZ1jSOUguH/mE=;
        b=E0LjyJKLFqPjj+BbbdqNs6lwSA5ydHxqpDHXkG866BU8jv793aVJFZusIgJwV93B3y
         DnChOYDOrM8h6A7Ll6tv9yVli8Tgf68zYGspZA5Ou6gAxj/wxSiQ81fVp/w9dHy20k8L
         NV3K8wM54/f7fmSGm/+r04OABRDC5YQe0oErI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712294968; x=1712899768;
        h=content-transfer-encoding:in-reply-to:to:references:reply-to
         :content-language:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y5P7Q1uPkCydZeKXyEezlbA+HvcL7kOZ1jSOUguH/mE=;
        b=XAcg1wZ0K0sVBwtbfk8HlmSYg+yyfm2XD/MS4ykAcvpLHzU7lXhYBDw+K0n09Yjckm
         h+bAMm+FPsgvJz9a1z/eq2+nlBwVE+s0IYp1KqGHdUwO8gnf89fip0qtyjSZTtQp7LZ5
         oGcjX1nDtRoEnX/tGJBRlWV48kI0LtelivhEHyH2ALiH7b5F/ylqMZXYOLw6MHkqvGvv
         +7ZiZUnwo8JlxlG1yH1kPAG+bK+blz1SyINfJnD60lz2KrYxw5vv+fuRBvhvGiqVbwvC
         S+lS32mlNyKm9Gd0XKjI81HLc9MmoAylJcOql5/0VKp/+7pFehuzZtmNCZXnNbwKKtjZ
         /3Jg==
X-Gm-Message-State: AOJu0Yx3j0VHVMMFmxmiEwHINfX/Esofl1npWjQAk7/Rq6onEyocBUqb
	MRTqKwZWGxpaJO7Jh2+jKugT02IjqdDyPZ+ad+ZY5liSVm6a1S7e50JlOMK4hTFaBzJKV/i60Ik
	mmyGK
X-Google-Smtp-Source: AGHT+IE6/ACFrfDEBUjYGTJ48cAa+NcNh2+fdm1tiCi09145PBjF3NFawrLWegC9AR+hlgtyqUHXJg==
X-Received: by 2002:a05:6808:4a:b0:3c3:e7f8:be73 with SMTP id v10-20020a056808004a00b003c3e7f8be73mr435941oic.59.1712294968554;
        Thu, 04 Apr 2024 22:29:28 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id z14-20020aa7990e000000b006e664031f10sm617847pff.51.2024.04.04.22.29.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 22:29:27 -0700 (PDT)
Message-ID: <9f55d62c-f2b6-45dd-9ef7-e52a5bb475e9@penguintechs.org>
Date: Thu, 4 Apr 2024 22:29:27 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Wren Turkal <wt@penguintechs.org>
Subject: dead link for subscribing to mailing list on bluez website
Content-Language: en-US
Reply-To: Wren Turkal <wt@penguintechs.org>
References: <980ac002-efb7-4ed7-92ac-fb0caca41b59@penguintechs.org>
To: linux-bluetooth@vger.kernel.org
In-Reply-To: <980ac002-efb7-4ed7-92ac-fb0caca41b59@penguintechs.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


The link to the mailing list subscription at 
https://www.bluez.org/development/lists/ is dead. I was hoping someone 
could update that or point me to a git repo that I can send an MR for.

If someone here wants to do it, the correct current link appears to be 
https://subspace.kernel.org/vger.kernel.org.html. There aren't html 
anchors on that page that I see on that page, so I can't find a link 
directly to the linux-bluetooth list entry in the large list of mailing 
lists.

However there is an option for a link to directly highlight the 
linux-bluetooth text that only works in chrome:
https://subspace.kernel.org/vger.kernel.org.html#:~:text=449-,linux%2Dbluetooth,-Linux%20bluetooth%20development

Firefox will not jump to the highlight with that link, but will load the 
page fine. Maybe use that link instead of the bare one to make it better 
for those that have chrome with no apparent costs to other browsers?

FWIW, I am not subscribed to this list. Please keep me on any threads if 
that helps.

Thanks,
wt
-- 
You're more amazing than you think!
