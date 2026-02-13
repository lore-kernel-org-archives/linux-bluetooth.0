Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB4D214813
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 07:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770968909; cv=none; b=WVy3nyW1LrscYvWBh8xUjnYoxh5npAGt+5SSZzc2RrHMCOH6LWBSVTNWG2cMnL0OyHLQaHnKZpYajwOCIsupYoFT1avWYWvKmAXKsr4PBBLwAtjZer+89bJ3MpBNnT9Fb1lYGtB45c+nAoA9iG+W9moGYIxkjzFvjtbEFOff/yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770968909; c=relaxed/simple;
	bh=yXa5RalksN7O4GJuY4DqPqJWLhb098jI6bDcQl19ni0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dxqHSI6XQGVh57mgT4yMIrDXFZ/gN0N4Nebd3/rN6Hr/wRxcm2T/pzBOc1Pz5upMHCQ20cASx2vZREo/mGHPEcf6ikNQFdPasFBzPk8ZG5i+/SQG/Bx1KNYPIoi83B2jDa/SGhfqqtTYEfPgYF+P+y9U6K9NrhYMyXkFQ8BT3XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3H4vSF/; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3H4vSF/"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8c59bce68a1so51572785a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 23:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770968907; x=1771573707; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yXa5RalksN7O4GJuY4DqPqJWLhb098jI6bDcQl19ni0=;
        b=E3H4vSF/LSQXBex7MNPH6dJJrYmu9KXOvK43za+kQxpmOfPtJFh4YCNj8VnQJp/YDR
         q0TevzTpirn8+7l4xc6nn+3lQvRYFy6VkO4pdOVOym/VuA/bL2IYw7izHJo+HbxF3TnV
         qXviQV59VVtCfq9jv3NaG0TYZ5sMPkR2YMp3d9IEZGzNfJGxgreF+e7OHN7T68leTJV7
         r7CP2L9XnLCPEv+Cs5wITJEQkPI3ncEnVEeid48yim1mAPLWVYyYW4AeJhDINzSWSR8e
         JV8AxMDxN6nuzRCr/0D3aYKkVC0j0T3saxoV20JYbuVP8GVJT/ut5dijxUgWX/lU0YOS
         S0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770968907; x=1771573707;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXa5RalksN7O4GJuY4DqPqJWLhb098jI6bDcQl19ni0=;
        b=e1z0Gpzq0CZDmzIi49xEuDMVYsQJ8OLQ6LprbhiTBpXsvqS8atoXiWxDA15Azmkf2i
         nGZoYRGBFGyHQ4JMfjtc84/aaXtjdZiEEYlhDYniGWNWAd03huj2dh5x/XQi5sibuaQ9
         YPf5r0pa8cvkE9qMvmEgBVxtWx2XtgVlPMFZw7mELrjjHYVCIbh3sE0O9jN670mfw2Sa
         C54Joon5DELVYx2U3Azxw6HttgPH/sVOw8ws3jH4PZEZFQsIbaT7xDstJ1D17up4W8DX
         Hn3mmswhz6qttSXjjWfmHVJfOdlyVLKHhDfUJNMLrEpPez5W0iegUOfOyb6XtAHUfqYp
         wacg==
X-Gm-Message-State: AOJu0YwSQb6O2Kc0T9LE4JBKRY+Kj6cHGnbN7SDxaaa7pmQW9/Xp5btW
	vG4V1bV8NziyCuexswV244SFPymm/cbxBLFPYLfdkjQbqDXVZ/d4leY7P/Xh8b3n
X-Gm-Gg: AZuq6aJfmXeo5r40SGMOcVNDMgEaYFW4u49hhgcZtL7RsN56DJbsge6JNXSyNzomuBf
	3mFnTlkNmyCQuZqOPCUhDcLqaVB4RDxJXUSWqLVlDKluUHtWTyhCkzPLVjFlcB0ZJ4PrjOmvBNf
	oN3rqbtofGVYHkVd1xXxs+TFVsg3rn8QmYWHZbREDVm0I3jUz1uI3M9O5ChIj8/zAOIz3n3ifXe
	RPdSakebHMpG1HyuOG1vkgAAVIv5ub664CVhJGqvG7pPFpofdsmh9Gn67dgXXtEEwHaeGn8sBnQ
	vDz58ZkVYQq4Subbu6Passkhbte9r9Z3rh2vAeurfvY3aEav+eVZQ1uQcihsDM1In3jJx1TfnIa
	awOz0EZVLS8dLwmlkQNwxDhBi7kupupxG6rvdk6+vxXIgRrIc5ub3o9sUddWHNm1kry/Qze19vo
	Oaa+3pQGLCsknXvU147u1zXXIW17YXl1SvwXCgvik=
X-Received: by 2002:a05:620a:711a:b0:8c6:b315:1452 with SMTP id af79cd13be357-8cb42264528mr112197585a.7.1770968907473;
        Thu, 12 Feb 2026 23:48:27 -0800 (PST)
Received: from [172.17.0.2] ([20.161.68.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b0bc2d5sm545728885a.10.2026.02.12.23.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 23:48:27 -0800 (PST)
Message-ID: <698ed74b.050a0220.ef019.959a@mx.google.com>
Date: Thu, 12 Feb 2026 23:48:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2797257652557033315=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, maiquelpaiva@gmail.com
Subject: RE: Bluetooth: mgmt: Fix heap overflow and race condition
In-Reply-To: <20260213072205.18404-2-maiquelpaiva@gmail.com>
References: <20260213072205.18404-2-maiquelpaiva@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2797257652557033315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/mgmt_util.c:413
error: net/bluetooth/mgmt_util.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2797257652557033315==--
