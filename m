Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92428130A6A
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642573; cv=none; b=QPlBrXPibAZWA6/zXYiseIXvHGde3qemgNZobKCBqm81dx1X5PuHR/9to29lztR8qxaDEjpy0H+ZcKc8QCCJrlLzeRu/OmNQkzlTHoAiHe3YpgrcBegdeog07teXjn63a3BhT+aO+WAlp9JJVY3+gPmaTBvIx7z+yGhORiDNBNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642573; c=relaxed/simple;
	bh=MjXMA9Udrt4VM92ucU7VTiwYuuVaX3sTCgDghdnNFnI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EPdXVJjvbu+VzgSry3gpsD3EgYD/HudPxaJYc+vxiRNzwD8abv96WbrZWCDcDI5iAIf1/EwtK2k59QvYvEM8EnWpa0zle04IoVwocGby51/i2XL/SBMVU5IDaEUG/rFjCOJztIHxWWSltz9Rmu6ytVrebKqb0pCkOI8MHZekNOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhUtjYMl; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhUtjYMl"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78a01a3012aso69194185a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 09:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711642569; x=1712247369; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MjXMA9Udrt4VM92ucU7VTiwYuuVaX3sTCgDghdnNFnI=;
        b=YhUtjYMlQV56vr3sYEw0L3rRuIy+Wlp+ZuKw8RJhpZtcwJKDq8zNpawrgeqCQh8X/z
         +sKO5sjHZgSnq3nwIbq49wOGIZPy4zyZv4Qek5fqmg7pjOStNqeW+oA25NiQP9P7GGnY
         19Kl3NIFWIECLgCTeAyYxSYct/7g4JemVg22keEuBeaNB7C+7wDmSsj2XbQlffuooqnU
         gYSO5i2GhKAmXEzUpae4XKtNd5e5z6vcs6qxl2TqNx4PxcmVhwcl2SEn0/BdwkZrJT3E
         wx65GSJa1tmlBXRW/2BdE/iodPnyH6DGxjND0V1oZVSAy0yjvZ4KmeRzeyEa6OZnkSXu
         lbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711642569; x=1712247369;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MjXMA9Udrt4VM92ucU7VTiwYuuVaX3sTCgDghdnNFnI=;
        b=Dh6XjURECVkWKV/Qjq67rPMvrZJ/rp3iGoF/1+We/4TOBV1pc2z1IKW86vnZatvpBl
         wBdzsE6mmgmF280uJdNpOhBQ9PRC+IotecAYGIsm58KtMnAQNVC9M7CzCpwi8i+36SDb
         lHEKNSxv8kQI3SpW6EsgI4lRpuVxtQMfm4RME18sovYJN5VWtBU5EYLEiJ50BbSojupQ
         ZtK1Q/jrR18p0NJiXxM4HvhCYBXafWOS9jedrU4hcO6NcPJJWvdYwafui8UcD4Hd43vl
         WTE/w6EcoVyzH/vYcIS5ywHSvaMuxJoqRm6I+dwkwRHLELrkjxhE2QdQ7VK5uq/jud1V
         J5mQ==
X-Gm-Message-State: AOJu0Yxnr/bkZaz6MXMLzlN6evjeME92x/LEArNsgGZeg/fPMbg9kWwQ
	TPWfiWQ1p/MucVthMz9UMgyVHbN2udgQky6k4YRBtFVu3eYJETE8RXTR19fH
X-Google-Smtp-Source: AGHT+IFfrma+4nqQTXpOumX6GobZ7JPG0GG9LmJ+07x7Boo/y36NHfj7Jll7sEDeOt+gAMqjNwig1A==
X-Received: by 2002:a05:6214:f21:b0:696:70a0:207f with SMTP id iw1-20020a0562140f2100b0069670a0207fmr4009930qvb.47.1711642569399;
        Thu, 28 Mar 2024 09:16:09 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.191.56])
        by smtp.gmail.com with ESMTPSA id gy1-20020a056214242100b00698ecbc0095sm18559qvb.101.2024.03.28.09.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 09:16:09 -0700 (PDT)
Message-ID: <660597c9.050a0220.b8d0b.036d@mx.google.com>
Date: Thu, 28 Mar 2024 09:16:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1179314537393666741=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] monitor/att: Add support for decoding GATT Long Reads
In-Reply-To: <20240328153237.1752328-1-luiz.dentz@gmail.com>
References: <20240328153237.1752328-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1179314537393666741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: monitor/att.c:46
error: monitor/att.c: patch does not apply
error: patch failed: monitor/display.h:87
error: monitor/display.h: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1179314537393666741==--
