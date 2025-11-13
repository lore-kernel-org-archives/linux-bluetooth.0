Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355CD342CA9
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763056034; cv=none; b=SnK8Ad7cJG8tghHDHVcC3fadWQtFPuCpqbUs9UyWGlwKy48WealDE5HISJRxDOlGNz2vzzYirlPbn8/cH66zmhnGgUm2KzFCj/TjmgqiwIe00+9EL0O51pQcOHdOLjSq2nvyQeGkw1D7E7GaRYCsPmvRnqMkgtm8a95NoWFg/kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763056034; c=relaxed/simple;
	bh=JYaVx6vTjzhqcXYaKW2hxzSgFo7l8Lr94ey9SKNy8jU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUx7rAIOcXlACYcFchiwW/yeTM1DoLS2zioOFaZj6aq3c32w7i+feijlzaYDrE1rdSZkT9pX8kDROnAjweKEdBfvQHq7nDHqro8dDmC9sr/ZiHGoYegOXWh8vmESweQlsKRlcMptZ1dj6J6wqAMeYUPANLYLh7SdUyQ/3kDCZgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRGd8D1d; arc=none smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRGd8D1d"
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-376466f1280so13439401fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 09:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763056030; x=1763660830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYaVx6vTjzhqcXYaKW2hxzSgFo7l8Lr94ey9SKNy8jU=;
        b=LRGd8D1deWmppUdPpJrCsZsitqW2Cp6zpU1SGfrYKhAx6H05hQZlilfvqaLSLjzd41
         wNVjAA+iRZ46yAKFY4FgP1rzVESHTISnxlHwX5qzplORRIJaGOzBiFOMfJT5sFnyyXNF
         vjxKTtC3Qq64/kFuHnULKohilnkDhw99l+k0NhrfkfTYsz2rS4FLv9HK6BTvzTackTZs
         e4yEciic9F4FQHpNEKj4lljaNbgJ/jUrPVU/UsS1pCWLa7B2sI7qY1umtBAqOg5HXPje
         CdnQ1BkPRNCiKcvWGUWEDIv+FEP4Y39j2wSUk5UOB+Ss1EEu8pdurShGDj6fGXE57Jl/
         TJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763056030; x=1763660830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JYaVx6vTjzhqcXYaKW2hxzSgFo7l8Lr94ey9SKNy8jU=;
        b=TolNhL1UeuE65LdpRNO0/YcgVpxuXWtZt2pD49aWMP1bBQRfY1vxEKMUeHm4S/+stK
         BdeYlrRu1MX+H7FoYz2pv9hqS+ulBm1RcpJJOGCoSHWk6QbW1CJJfi6VPLe0FHTnqjWD
         /mGQqQnHv5oQbGsCqWKU4Y1AZauy5Vw3UmcmseprIUdBuUOyCLXWRsqwxB7Npt2c6lon
         nfQlhOw2rVWnFp7gN/98LwWOr1677IC2F/97QD3KQnwofPdFBlw0Vm/gf6GP0pbmFJ7h
         SF/dD8lTuEY65hxBjNM1RYZ61jxr5BrOTNvSHJEW1QYpj6VovexjscOMzaINysifuXyI
         huAQ==
X-Gm-Message-State: AOJu0YwXCzW6ehoStQXA0oJBB+6+aqwPgCLLNxDFCMHqDSD6JU9flEwJ
	LY42ya+XwsG8LNQkyIGfTiAtcpKQt2eAlc2pIwEop2wa0smk2qhLXohRfDhwjNzshf5+X2KCMEC
	s8XKYSE/DHpJLjYzvEZ4tiikLqe6QQRY=
X-Gm-Gg: ASbGncsyL/VVEMOu+wepH3093yufTabQWzXyjZbTMWZgpGLdGvB8dESvZKOxyEDwms1
	Bn9BkFpd7D6Iqt5yK7peHbg3xyFDMjyNKeAfPOwpPj8gDT73/osnSuDk9sKxEEc/HtkmScD3y+i
	xoPoHNyW2kKi1F7xFw35AKvqcJ6i4j/R0xzGvIeCNV6wVdt8HsY5eQBJHapHWHEl2XcuMWaLrZG
	I6M8F2kXQ8hhVg/asQsOB9gJmKcZTI8e0AS6033Q3SKh6dVgpBvf+vhHz+NJz4cRgCgGEqlA4wa
	fDXU
X-Google-Smtp-Source: AGHT+IFgB0kjuMORkTltHirHFcCnBJRgvsiK/Z/+CjneNP+gh7LvQ/Gf8vYZ5usaLeqdqcUs2vx3AZBYNtcINT+3isA=
X-Received: by 2002:a05:651c:25c3:10b0:37b:90fb:9caf with SMTP id
 38308e7fff4ca-37b90fb9f43mr17097651fa.41.1763056030026; Thu, 13 Nov 2025
 09:47:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB7XQsFfTn3gL6TksbTNnC3E7SRPt+odtkVUJa24b=LmP3615Q@mail.gmail.com>
In-Reply-To: <CAB7XQsFfTn3gL6TksbTNnC3E7SRPt+odtkVUJa24b=LmP3615Q@mail.gmail.com>
From: c Z <rollkingzzc@gmail.com>
Date: Fri, 14 Nov 2025 01:46:57 +0800
X-Gm-Features: AWmQ_blavjoBc_Q4UMNs19jvBo28Xq4bnE-KXgrDVxv_yz96--bN119-JfsCxpw
Message-ID: <CAB7XQsGB5nkTnCbbzmEhZ2f7P2mYixiL286f_XT4mEBQ8qKTUQ@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: SCO: make locking more systematic and fix
 missing locks
To: bluez.test.bot@gmail.com
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi
maintainers,

I=E2=80=99m the original reporter of the SCO UAF issue=EF=BC=8C
but I=E2=80=99m writing from a different email address now because my previ=
ous
mailbox is having some issues.

Could you please let me know
whether this patch (or series) is currently considered to fully fix
the reported UAF, or if further changes are expected?

Best regards,
Cen Zhang
