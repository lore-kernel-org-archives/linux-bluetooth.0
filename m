Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A96222569
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Mar 2025 08:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741681298; cv=none; b=Wh+0yRI6yBtZpkXP80eLQ0f6SLkPlWo8I0AIGEv8wENo+7ZAW5gqEF0k2udqnQaulGRgkfAXW1arqMpxEIqhWf4oPqvYak4W4Qz0aqiKaAp/CRQeOh7wUh5FMFE89iyLRdq39VB9GA9w0PL5NWwFj+nMQfo98zKOFibijAem2Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741681298; c=relaxed/simple;
	bh=gPbpKAVX5EKD+3gdBrwkZ8qklt9RuFrHoeLWXdpdIoA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SBxYPC4gJ1Rkf+zlo7nnnsiBApKcigZq+SbV8gkHthLfib01TmRuHzqRvGWPP07KVbaTHAAchcJoXFMbNE4S+MsP/lWFzDHfMsxf0bvS3D65UVYABE61CQPKP8dFzVSFLbzx8DgxIqx1qa8da5jSTNw/4mcTVMTqgjqkCqTfWr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZG6J+ok; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZG6J+ok"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e8fb8ad525so44722886d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Mar 2025 01:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741681295; x=1742286095; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gPbpKAVX5EKD+3gdBrwkZ8qklt9RuFrHoeLWXdpdIoA=;
        b=BZG6J+oknGemUcfArpf/hwN9Z/hbzjK72a/7EMeM0mYLu9AjR8FzADjh+K9QxQPK1D
         mH+ngR8OoHVnQsIVBzbVddfnKi0PUR4tkfd/P/nOhrSqkc1cd1B+ZfPBngtaXzUBJeob
         56+BFqR1rBJLguJz7XauNRBZuqBnuBwZZv7Py5kjNJuKQb5tyv7r6mCz5AHJN/Mayo6m
         7iWqPfoeUeTGSnOC/jRcfiG8QJHpcX5xihP8nHbe46L6aIulcLQxIKj8krijgDeqSke/
         judg9biAo9DNsfnBEIqwdjMskIv/VfeWoRxUMHVWV0xn1inqWiAjz2/WIRrMqed45bNu
         P9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741681295; x=1742286095;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gPbpKAVX5EKD+3gdBrwkZ8qklt9RuFrHoeLWXdpdIoA=;
        b=INcUECRh8dYOr++WL2RozLd+ZoYdwNHZ6fzNZTL6bhm1dkza02gcQZn8etxc7dNlNx
         kLdNPvfDd/AEnKeXgTjmt9zooOVL3DFroDFbQfuex9Z5LWvCBL2H/kKtt/GqsZILu8pD
         9Aykftb+FsONNYYR3Gl1qG7y9YIgpfoh5A6TQIUQtMAIRtwguVyoj1jwqLFjHOr9yAy3
         FswHGhAEMG1jolXkqR/UqbUzuqYoZWXKj9Ud7+WtBHoIQYnb7yvjpvsCM3odODvvecRK
         FVWq6KKKSi5Dd0kQoUHK2O44GRLIZeCQVoG5PT8IGhRHm3YFYxkXDa7vWl38E7Qgxost
         5O3w==
X-Gm-Message-State: AOJu0Ywg7OJ7Ma+qScWoXeIgaS25G4AN3syS5UtF8acyPYM5adlOi7Ih
	jXJDn/SiWm42nTHujMkVjuxhuXee95tLeycATCXHR3M4jSCRNP0npHzMQA==
X-Gm-Gg: ASbGncsfLWL7Ps1ixgwOFq2hd26FDJbLtsTUMu0o6aW/NuUx6r2GKpbMXbnTK1bRy8T
	sIGyAR/9AeGldQ3CD512LG1iRth1MXgxou314DkloU0wdpGs+VvLjtd5j594IYjz5GLOhWkXImE
	lb8VJGp5vcDgVcVJV+zjtgv8Pc+7esC6L72ro2g85Sx4kY7FCdhMQO2ZyNT9XMAFlkehrDid3iv
	r0pE4mXKGky+OS8aXjjw4XQnFVinXVMyAJk3ZwHKmPBtl0ij1BS7OLyr6IjqC3UffQP7XoELn1t
	AC5Eqe/AQB08Y5+IbspxRqQSNAib5hZTn8pQbE6bs5lqds7biSP6pJvZe5Iv
X-Google-Smtp-Source: AGHT+IGGuvh6q9gGiYOK2lnmqAzQDkblHp8Oj490kdNcODNEdZEsSR2Il47iomCui0Dd1QEeaEJo4g==
X-Received: by 2002:a05:6214:21ab:b0:6e8:ea17:8576 with SMTP id 6a1803df08f44-6e9005ea28emr161976566d6.12.1741681295568;
        Tue, 11 Mar 2025 01:21:35 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.14.171])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f716eef8sm69463366d6.94.2025.03.11.01.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 01:21:35 -0700 (PDT)
Message-ID: <67cff28f.0c0a0220.f76c7.6091@mx.google.com>
Date: Tue, 11 Mar 2025 01:21:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3275241584505838698=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kx960506@163.com
Subject: RE: [BlueZ] share/hci: Fix data type in bt_hci_send_data
In-Reply-To: <251a4eaf.77e9.19584346ee6.Coremail.kx960506@163.com>
References: <251a4eaf.77e9.19584346ee6.Coremail.kx960506@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3275241584505838698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3275241584505838698==--
