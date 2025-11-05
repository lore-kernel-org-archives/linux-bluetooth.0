Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C527A3321BD
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Nov 2025 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353618; cv=none; b=tsUPkwFXCiuWG5kslvaxgdeNMX852MKu8wwWFAOcKNLCQ7VsmG9P3FwHwfoyawh5xzJGSzQiimZ1E+wobIkg4wabn6c7f+cCSnA7rOcYIvYbO2xsdoWyudpAJ2nxHdvVYIfdY8/voWboWu0fFKnnYznAnM29D+5AqWS/N0/Pqgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353618; c=relaxed/simple;
	bh=Y/lXGHe+gqUlpxT/2a3TjBagE2nj98BAgLlMkCD7yn0=;
	h=From:Message-ID:Date:MIME-Version:To:Cc:References:Subject:
	 In-Reply-To:Content-Type; b=XP9zPXQCW4UDazk/bOIgein+VOMi6nVNn1mBqjR6yZDLTmcO5/EHiLJ8cK+1hjY07jRSi8l139siFkcdCaimRCdn0KFhRJm/MY5OFm8AL8Yazc6afrnWSGLPloZqekLCw/09ug4pcdOBqDYGm5aSTDpn0SXfWYKf7grh9QzAat0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYqnVyTZ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYqnVyTZ"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34077439166so6009888a91.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Nov 2025 06:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762353616; x=1762958416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PIHawX58BbfIVMXiDfSeiVcNH6WdARDGxAqamzICfAY=;
        b=WYqnVyTZciwYDUG/6x0LrKqz6+sx1H0hwTLPhVTQ9QEQImumRcQdV/b/XgbTBRynSI
         hqKjmd0gVnz3FSUbAe/steBMdcB5FZS3SOPP4WuRpsxSPmnVUUcnnI6by7CUDKbymgHi
         /P/aiqr3saG1hd6J8c7Oys3sFB6L483B7m+QZG5LSn26/VnOwS1OO4LwQQChRbHOQPgN
         hd5gy2UBSXBRBrwtl3fh4huwBeygAw2M0w6KstYNuTQjl46qw/Q+q79JP8i07xiAqWr7
         4DSmWTOFv8IKRZ2In261wB4R5oZH6mcfbSc+LV6HabtXWcCKIR/Er17yM8M/H76qeNPH
         fBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762353616; x=1762958416;
        h=content-transfer-encoding:in-reply-to:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PIHawX58BbfIVMXiDfSeiVcNH6WdARDGxAqamzICfAY=;
        b=nQexYHeaE++3rxyGLZhy7pvf2OAdNoq8lyLOJ1g7CYWBmy3XLwwB0HpXKYJTn1jpMO
         iPT1o09dOyBJ06YAWp+WaKDArR05MVpqem9Ojkr34YEd8LjMarDZlY8P+2gztDUr5boM
         TcZQ+hy39UUzfh2Rki+KaG69dv8DP4HF28LD/+I2ZDyM6NsY3DMCteYWfK7lZiwScYgq
         qO7wjlnSLzz+qa1SSQ2lIrGqYDxNxz/3OISp0XR+qU76NpqM6j5MVtiQPbmxbGY5EBS+
         bEDWtLBJo40+0AXmVci3Cl7f7+Sy/8KAtiSM79vBT0G0M5qwbDL911fOpdmz0vdse1z+
         +xxw==
X-Gm-Message-State: AOJu0YxTJJc9YveJ/CeVIQIlvXTjwMT118gBDzaByLklYjgY+vOnH+2v
	LJNZ/rjMeQJy0wWgTYIfNVOSrxP+zbyA04wrT+ScB6nBBA3PWljDlHhCyIYihw==
X-Gm-Gg: ASbGncvkjN5E/4kZHpKXXQC0jjzQjUo9UAZ6YyjHhUB/bXVtWnm9ufP1T+bgVOFaQyE
	SpjKrZNiHMVj7F0ZVnq9D+J87SM5UB4K1IoJfUFRjU4a8YQTek4xwsE24lcHKnrrx97OO86Y7y1
	ed16/wRydXh1JWsu3iNJF6IbBJO8F2Aj7+p4AAu//p/0V07FJhjKou3DBVOQxelnLDpdbft6lwA
	FEl6l5qOxRJx1dOiIoa1NDMXpKQU1HTQ5RfUG7teuVSKKXjzoakS1AKa4Ugpy+fwum04F+D0ugh
	+ikkszKX5Nf7UDfNejIe4jEEKOJTFXJPGeiiU7tz010DzEsMj7Whb5bvk8tBHtDwtbpMWhQz4Pu
	J0w37BBjugSSeHBk1ttlClBJfr05Zoj72Jf2tHcEkVJ/m0xYcSoAe63LMuacNo55klR0uwjPWBR
	ypzLViyeQ2LY0=
X-Google-Smtp-Source: AGHT+IFiVvhf3hLDjIqWbHqpdiOoG6ANOIt+yMe1ih3sPzpT24zI2pgxC199608O4JP4BZYtMwrW4g==
X-Received: by 2002:a17:90b:4c49:b0:340:c261:f9db with SMTP id 98e67ed59e1d1-341a6c43e0bmr3903319a91.10.1762353615512;
        Wed, 05 Nov 2025 06:40:15 -0800 (PST)
Received: from [192.168.1.13] ([110.226.177.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a69b626csm3187039a91.19.2025.11.05.06.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 06:40:15 -0800 (PST)
From: shaurya <ssranevjti@gmail.com>
X-Google-Original-From: shaurya <ssrane_b23@ee.vjti.ac.in>
Message-ID: <5ff5d1d0-192d-4aaa-8ef4-e1bfe2fdf6bb@ee.vjti.ac.in>
Date: Wed, 5 Nov 2025 20:10:10 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-bluetooth@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 luiz.dentz@gmail.com, marcel@holtmann.org,
 syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com
References: <20251105142251.101852-1-ssranevjti@gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix use-after-free in
 l2cap_unregister_user
Content-Language: en-US
In-Reply-To: <20251105142251.101852-1-ssranevjti@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test: 
git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master

