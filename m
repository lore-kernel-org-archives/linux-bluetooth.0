Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795667434;
	b=Xi9GiWVbdWSbD/dPtXoKB11U4D6CJ3wNWOdNWS5iDmpRoNi6viOI7zSyVxQq9t5q3zuR
	 +mMd7GccKLxs2mWY0LCDg6yq2vA7dxO78ZKzXLodg6NP30nY+VWmaIUNw9tfXiw9Kly9s
	 FbCKGD8Nd0mCM+0jwZPoEI/Owv+4iN08loCvS7EX0XRqS+FdedRqmwpYcPPd7IIXoGpvq
	 kTkS5YzzhBiZI3DLSSHy+0ZE5ejQpEFVgAbAZ9NqterLM1IsZtPU+ewKr6mE3hy3jqOx5
	 7RuU+RgVO1xVO+bj/Brmja7/wAWCOFS28Pql/rDzR+qvZk5Ct4AIYQ7AHrMiRJFtkYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795667434;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=6g4InJq1B9n1Lq269CYBaMZe7jbUlR8GrVq4LC0/Jdg=;
	b=3S054ZW7k8YdvxQnKehmxiRdZNS9DkvCh+Ut3SMLbkqcdfISv1Gb4prbQT0HkYDC+uKB
	 yfzRwk1llpYjGQzPXL5RAIYuXploCl/mUgfYQaDcpKhoA3WPIXH1X0wTab3Q7hIUQ6k5r
	 IZlpuULBUZnaijdqW9kYWjhj6MuIg7nUqR80QcfPC13d9loVFT5uAoBd215cuwtHum+gp
	 5i0NI41oc8CDmiqgQ+hH+DRpEdwcTXKrU7DT2oNGONAu3dPO7oN7F9sPyTq77mSaZj8Nm
	 BjiPIiALaE4X82SVRXbR3SWEa1cZtgi+ORtzFGZzejexLECUDWfjFRM0tcQ2OUvJb8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CNc7bROB;
	arc=none smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46002606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 04:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46002606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CNc7bROB
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-862b98b2e47so2590528a34.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 20:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795667433; x=1796272233; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6g4InJq1B9n1Lq269CYBaMZe7jbUlR8GrVq4LC0/Jdg=;
        b=CNc7bROBIWSWNXrxEqiCffryi/nUavXyqkxMcQSAWq6WwqEP/cxfT7R84tH76Ez/++
         QFIiLkYm76CQ6uh0/KrFePne4VOJW6IZQ+mnVYKWdGkDOv+iKVw6D5STNjirnL2oUful
         PqCnzWnxXhCEWJ12fHhfYcqPKxkvMW7yte2fUrMSJkgKTb6ICirJD5K/B7LOEkb5EG+e
         B/aMK0HnJOGRJj4LXooQqlhyGH0aPUpHARuskMyVnYBWDIgDvWmTKg3QQpzjEUFMBnY+
         +4k/3koS1wX58Zbwg+Q/OqKhinh4LcvvvxoEd7GQBxkNKf0ofwi745e05Z0VGjy9rs0Q
         bHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795667433; x=1796272233;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6g4InJq1B9n1Lq269CYBaMZe7jbUlR8GrVq4LC0/Jdg=;
        b=SoeV14JRZErsBJK51am6V/Y+gHlv64Rp6iJNwqWbPUzP3srWuijy2JDPHpM45VZ7L6
         79AvYin/vcCcESLVuffr1Exafk/jaipGsWUUCrCxNzXCkiy5hEmHwq5nMiYigWG+8nRh
         NLWLsmOHgEkT43kbPhpVAaKkGdyVRk9aMqojo0EYE0x1feIui7gcSCirtE1IFTCDTgwp
         xD5f5WwZJLMgJaUy/0YjWbpy4dGwN+NW3CVo1PIM1vZPnZ1KeLVun+ctgAigj+LKwz6p
         buG6+Bss2vfTijSfUA/l7QpSQ52YRChxM4XY6Iv+a4L73m305OcMVba4XS8i0dGygNNk
         GaFg==
X-Gm-Message-State: APuU4Z/EXRU2xjpY62pPPkT6SJ1JUmhjKpbU+75DuhzmEuzLja9TOz4C
	o6jAEpOQLJ6PkuBa3pjANioeC9QPWwkaV/8p8TBov7+nAZ7WHUx/uGckrW7Apw==
X-Gm-Gg: AZFdTZeiKN6ofAjWMsMCH9hMsxIUpGGcZx+k/1QO5xDJF8+3zi1cCLNWGUKNOSoiecB
	ssA15oeHCWgnceldwwcWHgo7L6Gfq6h3YTh2eQRxh3z4lWIYPxdtOKqoPK9UydoVm3y4qtZA2x7
	eELHJp00IjzY6Nlk6reFMV5wbHwFS5OypKVcFsNfik4yBSY4Ebg1rAMD+8q/TNBqFgKfmwUQnPx
	grBJsRHI3awms1itJfvpUi/BSa1vLTswu4kvaS3OQuNQ0D0QAlHHVYTU+rfJkCcUovsut/fNhgC
	fitcOo53vHEO3hZgYKPD7KqjU9rfM3RqfDYl5VYXkfocrtOtUgyXIBmyMWdN+N9v0WeZAaG92Ty
	xCfX6tShi/8wqHW+4xK0Bp35hIiSY1xPpcdfgBQUcllh1v9Yt1IiDLDX8yBaXLST/ALT6Wzf/U5
	DGhoKzQbrUc5wsFaCHeb48VEiAc8EGD2QMcpiAqfDjoIY1MbNWsQ+rCf2G5QgaVf4awLJ70PB60
	tfI8bqXEJQHxjn7xFiDEvQ1lfsasfFW2o9pHxGVVDoaRh8X9JLrBYx+V146ut53Xw==
X-Received: by 2002:a05:6830:924:b0:862:a48e:24d2 with SMTP id 46e09a7af769-8631563c004mr28393846a34.15.1795667432755;
        Wed, 25 Nov 2026 20:30:32 -0800 (PST)
Received: from [172.17.0.2] ([52.173.179.181])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863607d0f48sm4837107a34.7.2026.11.25.20.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 20:30:32 -0800 (PST)
Message-ID: <6b07b5e8.2d067d60.301d9a.190c@mx.google.com>
Date: Wed, 25 Nov 2026 20:30:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0990589552185369986=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: None
In-Reply-To: <17af9d8a3cdc45ea05bc4dd8f69d8cd0e0dfb8f1.1794349049.git.luiz.von.dentz@intel.com>
References: <17af9d8a3cdc45ea05bc4dd8f69d8cd0e0dfb8f1.1794349049.git.luiz.von.dentz@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0990589552185369986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       None
   Pull Request: https://github.com/bluez/bluez/pull/2792
   Created:      2026-11-11 03:05:33+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============0990589552185369986==--
