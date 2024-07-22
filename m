Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37EE2CA9
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jul 2024 05:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721626702; cv=none; b=JfSMKZXDbUTbv5QIQTM1Wud8fmQpD5JaSfw3DxpywsXLgMYlPCgHAJm3UchcN0pgCr+ZObIY6A3AW42qEQP9c3c7em9cZ2NxOD4YP7oftIAYEpQg5uCgGuRaC8xgMC3pSTtJIs/5XgC69CJehFxTY1Oumfj6k/8+GxOEr1YXFW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721626702; c=relaxed/simple;
	bh=X9SOryOeSDc9jV9SqrRNkk07phaSYq+YU4biCOBGc1E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=d39br/8uLmx/xkXu3TjR/C9D7IBkcx6CuI7fn2I3sIMHDz+NJxk8XpxCiu1osIKPGjHpL8J8CJzHQSQvKkP1+17Ov6nCOaZ20D6hjlnx1X58xzn9GiFjfehmYGsAzAi7Lo2KLwklRdyv1RtYpJuEo1ibp3XZYqAwRiKCq7MR7Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iX5inF29; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iX5inF29"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-49294bbd279so377083137.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jul 2024 22:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721626699; x=1722231499; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X9SOryOeSDc9jV9SqrRNkk07phaSYq+YU4biCOBGc1E=;
        b=iX5inF29qkYk9TUt2EXN+r8sNRShyvAJ2k6/TwdbQnLPFqewijkX6hpImy/9XYr19l
         WpYHCwWoXo2m3sKbH6x0mptFFzwIbsEYAUK521OP4qrtHY+1mx9TTGwUBzm5nKNjdKyA
         bq7ivvmek/0tH2rPHq4kk6A0ba4tsM3g25lwA1+CMXx+R/E17Zcmi+jf0HuM7FqXkpMq
         mEgMVz/xlfBDpS+Dd+gWnIW40LUCDmc/Z1z5GKJcCrSe/ab2B7Ex+BdxKxd8/9mc/X0Z
         Sd0yLeMxFXdN0Wb6k49kj2BK9OMtNc6T5ZZW4wf3tXWcKZSdxUXUeA6XqNuL/dXTjfm5
         T5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721626699; x=1722231499;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X9SOryOeSDc9jV9SqrRNkk07phaSYq+YU4biCOBGc1E=;
        b=PT4ncQ5qgNHdmiXrJ4fHUblNpXHNEemmMl/H9o7Iokq6m1PQ6GSjoggGEVJQgIc/E9
         xL1WcEgeGzFUwHlb3o55b6m7ggKXCX6rJAoMIlRQymCSmt6RGKxtsYs027Knv7Hm943O
         hayvsaMVBq5hoF8VHAMI/1G/G3wOxWu+0bfVQrS//UUU4d77MnxuPv/4ev3iclYYLrwj
         UKOXQZT4Hi6u1wAddQj6hSsYqCqJ/cdQJhli3pjE9mA60NeSEy2GDNgmdVWYNtxWvUiU
         WWUGAWkFs6l/xr9R+pjaD1KbwVbPUIOIRq97eWj9s0CFwaZfWEVz51Rx2iYPLoYvrHOm
         CSLQ==
X-Gm-Message-State: AOJu0YxWGnaN7IO3465EXdvb//oO3dYi5E82NQTLuagQ6Na3Y7HbzKMN
	0p4YisqiMfcX7RW53ECcpYO9cLN+Fix5Z+MXZJTMhRCS8e4k8ATSJ/l7MA==
X-Google-Smtp-Source: AGHT+IEgSNiOD5Rn5edXBhCkCIYnkwMMsYwawGqmDqj7YecSqtAy9AREPOy3bZAtiYtVidTXLHnbYg==
X-Received: by 2002:a05:6102:3389:b0:492:9831:d2b9 with SMTP id ada2fe7eead31-4929831d41amr3838924137.9.1721626698265;
        Sun, 21 Jul 2024 22:38:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.46.179])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cdbe765sm29508431cf.79.2024.07.21.22.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 22:38:18 -0700 (PDT)
Message-ID: <669df04a.050a0220.ff633.8ab9@mx.google.com>
Date: Sun, 21 Jul 2024 22:38:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3218326059204955538=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, clancy_shang@163.com
Subject: RE: [BlueZ] adapter: Fix execute "LE Add Device To Resolving List" command fail
In-Reply-To: <20240722052723.3031061-1-clancy_shang@163.com>
References: <20240722052723.3031061-1-clancy_shang@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3218326059204955538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: src/adapter.c:8978
error: src/adapter.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3218326059204955538==--
