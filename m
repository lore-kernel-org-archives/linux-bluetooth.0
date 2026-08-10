Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E381332EDE
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Aug 2026 08:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786349767; cv=none; b=aXG7pypEw38a5u5TVJSAUA1pB/F2df02QyoxPQfYBOjYojz0bo3HvdyxvSiReAM+GoS1ORkPjX9iN0bag1tcSElNr6ui2O3vi+y+Cl2pLmd7P95iLiYUrC7jGV4o0T1RcW1xK8CDcDQx+7ifzWW4LLZkmkXPodocgb3TgzNdYm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786349767; c=relaxed/simple;
	bh=lVs1o2ndL6Z9+dU203wZ78CPIP8OadPfIamUjwCfAxk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dvrOKXwYafgZl6PRLs9XWLPCJCwMSU17ipx8zfGSMjS61+mhKlHgqvPEPO7VDvxQ3QCIGsptqdVvnqb3kLlrQ2OWlaNPoBgKuhC9zeH7UOlkl/61RMmAmhA6ooX6QsbWdDS1HnquN+vX41hjOSIWMyEUSkvdNNUpo7fvuRNk3NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rx7sqcKm; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rx7sqcKm"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e50979c71so150291485a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Aug 2026 01:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786349765; x=1786954565; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lVs1o2ndL6Z9+dU203wZ78CPIP8OadPfIamUjwCfAxk=;
        b=Rx7sqcKmHGpnwbC1JZDsb0hycz6q+jTK8LoButdYTXMjIQBywkxNw1csh1pESRzhxk
         S8yVHPvF2ntBFl4bPfQZYnme6VYubAZN3H3rMTkMlT6I0b16/nUCukZ6UjOzjNfjsoYR
         UhEfMLcq2dpLpOa+g6occGsNzNoFvpAJUcJlKhzrOiax1sr0olBSlEf/qFH/NchGSWMf
         ypirZMpLj+TuG9OpxCtM7FvuNaVAWsYZEyoJlhMG6oqFz5aXHW8Rh8HtgSa0+WM7lC5o
         uvCp2RR0o+GsMrFTpR0So8onwnlVuwpeTeu2Gt6igItEb3g8pXlQ/53rIIpnkNE7uoMa
         p6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786349765; x=1786954565;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lVs1o2ndL6Z9+dU203wZ78CPIP8OadPfIamUjwCfAxk=;
        b=N0ghvVhHCqZewETy9vTnzYR7TVxYVH9BnA/qqDr5BWQtyIvTS5M90KAjsAX+5+KZ3+
         ZsCStNXR+9qo4vxlqf62purtNHg2RoydzxwgOItrXKvoO0Lo/EZ5Nm5+qrGZskmr9T+R
         fsYNJYHZsi0B9PtbPcwu2k3doA4tjFOdGJx3TOm+nZ6TVvPKJI3XGTtVKOyNjx5kr+YQ
         EYjGxYm6E3TM1Ur9VhMuDjH8Du8YYSTzHN7dqxE2mc6Cja9uLOqYBcKYs058BZ9ZnHFE
         +cPTDnrRaERTu2Tk6yqi9VhYYc7MImNDl976Rmpyq3gR3Kc6JUFon6LqI20GC5VaqW7M
         cJ5g==
X-Gm-Message-State: AOJu0YxOXov7tm+c8yFzl8clljbVbz6bs+MN06kdI/+iVwl9Q+X5+xWU
	ApTR8nVA8m9pKOs5+B0ophNt015Qg6Mjtegj6q9mylV1pAhgwQVXLofiCwpCPg==
X-Gm-Gg: AR+sD13ZhVNYIMJElxkfzW+i/jnlV0PRjnqsRgl+LALbLAVMbzHDbKUHxC4COWnWQIm
	aHhxqHok1IQ3CIEnreLe7I25YjxLWFH+fKIwTeZkZ+8vcNqlvqjETSfkx6v/TJZZLJ3Gaex5HW6
	Z/4hGObv2Xq7vSQ50rcKdG0zxHMsYnTYkNDfo1+Z6K8JGl6mVTkjpAHWuyA2GYSWYYwCSLtvCXW
	7Js4w2FbZ2mKXeuWvgUFE2q64azwRJzYSgCwakYs5hCxFEjkNDmw0rd6vDURl0XIaE8v0byP+gk
	GfUeCG8BQO1KGUiG6C+V7jQfhUvcG7O911maT7gEJH8Vtq8pJjfBD4Sd6cZ7qQ1C93dH0OV1n2f
	N5yZNITE56WowBsDNjjn5Sy6Vy1Tw5q8JftuOo31wFmLzTuvRRigWFaAw6ILsoIwj8eWY31nQut
	GQ84ciBmBCUBayAWNPAkxtnVFAKB4cqBj40f/LnLYfhfRNVqpVQuEZ8ZBx4He1vCeLCFok
X-Received: by 2002:a05:620a:294e:b0:92f:e20:8c07 with SMTP id af79cd13be357-936490b3e21mr3933913485a.16.1786349765294;
        Mon, 10 Aug 2026 01:16:05 -0700 (PDT)
Received: from [172.17.0.2] ([145.132.102.96])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e229848sm730521285a.24.2026.08.10.01.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 01:16:04 -0700 (PDT)
Message-ID: <6a7988c4.4567b959.15d89c.2432@mx.google.com>
Date: Mon, 10 Aug 2026 01:16:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6111994358024559389=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yaojiale02@163.com
Subject: RE: [v4] Bluetooth: HIDP: add missing length check for incoming frames
In-Reply-To: <20260810075740.33419-1-yaojiale02@163.com>
References: <20260810075740.33419-1-yaojiale02@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6111994358024559389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hidp/core.c:560
error: net/bluetooth/hidp/core.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6111994358024559389==--
