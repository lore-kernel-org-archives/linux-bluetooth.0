Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C222472AA
	for <linux-bluetooth@vger.kernel.org>; Sat, 17 Oct 2026 21:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792273606; cv=none; b=Q0PfRn8Nb/ulDFYf7AOAbYQod3knlGnvgMBmuYXpiBZJdxkA+8mszZXYQStMRVlbrSRO2jzDwDo3eKqluReW6tzUvq9UCEw+e8z7BLs+5ydGQSNsNu3XBAKydgGFzfQ7hOkFCmugRAqypfkpYDwE7P45FEdi0DlQNgoeghQiKwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792273606; c=relaxed/simple;
	bh=/oWTQII4u3inC5LkD20f6l5k/0wVUGz3aehIwCHX9bM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BBYqzx1dQobz+vnT9b4118GZCQYhk4SUql6WfUvRowg9nAS/Sqnf8UyvULYRj4LzzCsnFc1x/J5QvTHIcfGsSlQc8gQk33o2mF6IcQZdnjUZVeAqz1uiI9DSWpo+SuqT/nsw/V8YuSvUSfdgXL6hOpXTGClhD8vdw1MRHd36+m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8ndQiYt; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8ndQiYt"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6de2f213b7aso378055eaf.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Oct 2026 14:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792273604; x=1792878404; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/oWTQII4u3inC5LkD20f6l5k/0wVUGz3aehIwCHX9bM=;
        b=Q8ndQiYtWdhHGGcAsdHvupVdVGa/n6gZJtIwHQpPoUuOibhBbM+JyNTHazZMcWgBB+
         v12odTlOG7LVY0GzbZnB9G8lUk9qVLvfKr9NfFsrHIo+CF7unwleKm4kDt8xtsBIMDX+
         n2HAxPLJS74fqQp/e/pYCmkf2QIDlgKlI7KMvNUlTE//NW5bYfwGIkDR51dUG9fq2VPZ
         99YB9ygkbJAaL5dixVwi5VzK32LmJ8dqMQh/gll3TS7vdA8NW2RgEalzR9sFr+etta8k
         V3Vvtk97xbsjkRZYRHLcw8KZyteHQiNDG4syMAfc79PjFvYLRYnbhtpH06jW0XImJMyd
         DzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792273604; x=1792878404;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/oWTQII4u3inC5LkD20f6l5k/0wVUGz3aehIwCHX9bM=;
        b=KrAzG30nNNtVosGV7VtCTcyLHOtRU+x/rWf62EAu+BVLWHXIFtv83gEpWBRiRKh4Jl
         cKNjCNipFMNGBZrC7QBcEAdBbsyVXf2dn29A++ZRnj/sUJceyJNWOVskuXC4LXhWKDsO
         HWwbCWhXw6Mgupu0RgOg3xu6bll3KcIMR9Bm4mp8UYbpE4JGCHaWbsi3fXdVh8laRtx9
         Z3MOzhZQJWE51IGlR9ThyNbsCGvv8lTnJcB/3rmyJGo8GiVLLtpefjD8rJi5fYKKIazL
         JO+tXm9ESc/6vTThIcoM0HY0j2qpOcl7xDSppG7Vj/sYHHtuvd8kSHHsXJLHKwaAmJuL
         K5hQ==
X-Gm-Message-State: AFq9FYJQuUB7Y3uUUYT1baHNp3OdSGhCGQtB5jcdeNaC+QSQLdazhIt1
	IC6FStdorcmjWR9I3iyEwxRnPSdVwEu4OAWJjVvfh+QCtgZr2kotydIVmAIs1Z34
X-Gm-Gg: AYBFou1+Q2mQgp0yw2pEfqxEID1KA5D5jl2APuSTlmsXWDXg1YCcqKIPiqog+hTZnsL
	CeJCisek1Vp80/Ke45DLC/KfDO6WI2acwaBohcKWXJYQjiCaECssmnvZ5OqlP13obJwY1t4N/FK
	cFN7Ms0JmZXh5iivPXWBN7CdFf/4Y3131jmClaPMd0IhTwGl9HmqqCNC9jakGKLDESbiiuHzm0y
	PtJU8JE4N2Hxh8xjLjKRLThC8ZHvRbutEh5BByByqayK646Ec4ZOwNDMz/TchE5JDt7gskBfFXv
	lEehqp8mQ3TNBgVO47PrAV80Fpe/5uFQTEzWJEYPCtyP4rxRwSvo3BMMG+fi9Hk/WJtied2hTic
	hb9Pv87gZ31XTlLPlGz7DBmaKXKEq2ccVCkiDw5TPYJAU3PdFX2R1RN8zsebVWVBM2VcMn61Pvn
	WKQ5fyxMf8rM1Q5tBvhYdGbw9DcGe7r2owBQNrtb73o7q9d7f0z8wdqahZ2LdtOzT1nhopKkluc
	gQktfFL
X-Received: by 2002:a05:6820:1506:b0:700:5251:43f3 with SMTP id 006d021491bc7-7035789ecf3mr2334542eaf.78.1792273604274;
        Sat, 17 Oct 2026 14:46:44 -0700 (PDT)
Received: from [172.17.0.2] ([172.169.254.169])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7018fd92933sm4956115eaf.9.2026.10.17.14.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 14:46:43 -0700 (PDT)
Message-ID: <6ad3ecc3.00622f29.22d26.5174@mx.google.com>
Date: Sat, 17 Oct 2026 14:46:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6114338513449291720=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wonkru-dev@proton.me
Subject: RE: [BlueZ] build: Do not regenerate internal ELL headers with external ELL
In-Reply-To: <X5NYZHGSaimprKHVFhopOLVmmlI95TooO7oJcNid-yDh-wyxZ1IYeDg9TEkt28iU6_I4njm0J8b-Yq8NXxDrbWaAx1fuxArrEm5UgwOVJ1g=@proton.me>
References: <X5NYZHGSaimprKHVFhopOLVmmlI95TooO7oJcNid-yDh-wyxZ1IYeDg9TEkt28iU6_I4njm0J8b-Yq8NXxDrbWaAx1fuxArrEm5UgwOVJ1g=@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6114338513449291720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To record the empty patch as an empty commit, run "git am --allow-empty".
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6114338513449291720==--
