Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDCB449B26
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 12:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787919138; cv=none; b=t5se3Q/O1zxp95KJcW+qfGbuh+nfbXJwLjcI9QkCQu3WpAmvd/C7SmWO8sHm4cp0zmbcF+G3uweKveN8MHGZmAk2NraWlztD0VbzvwbCWMzyuoSNOeH7jNMrXYqlVdSTQzXy9GtKccdNZYLWZwx8Qj6HxfjNhWxjCwl6D0OqvAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787919138; c=relaxed/simple;
	bh=NwaShRvYk48LW0zqwtqom8Daozq5ionsoQu6jaQPyv4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SjDDTO0zWe3fkp29MMawGZP5ISteggg31nXIr87FLLDNPOO3831lrf6XTwHkWR7lL0sNOeOgNRQXj2iEL5qWF8ba0nUNUiac0BvZ+PR/egSPARkX5H+6qj5o4ngH9TatHgvJk78XnfgrN7BqOovAyx2WaGOG/1d5pWLOKfOtbR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoNUCdaM; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoNUCdaM"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4af173320f9so859661b6e.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 05:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787919122; x=1788523922; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=60M7arqgK4CzgurfD/NokuVOdtUk/FNSLtV37ITPSLI=;
        b=UoNUCdaMQzVDeFNcUQfZoKCkL4HNKODWeYg+puT+zIDOAyfwc1R+NHd8Lsoocx1axZ
         5ccTrc497oFaSjfwvgyKvpHVZlJdUAU8FRb8W4zxSu8d7rDEXuwuhPMdPnQZJMyg/goX
         9fO3Nb1peZUZIHzr+nOn0W4u+17WgPiaCfB8Pl4eYBFmPv5E7WEORFgKK7c4GU0Uaof4
         S7rseyXc34tygBfIw44mgwd9dPzKgtpZGYEqzAAnXzg1IbingNnLtC4PqwY1z3Vg3ZbW
         JhgzgULGsDGkmz8Jw9x21EQgLF3p6t03AlL1mRjq0YQCYl+6e19Ev2EfANNaMZMD5w8O
         0hFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787919122; x=1788523922;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=60M7arqgK4CzgurfD/NokuVOdtUk/FNSLtV37ITPSLI=;
        b=bkKoGvQPiFbPbRXdzV1rg7Fh1YWSspgsM4lqfvdjUPXrS5q3vxd++xlQ3s8fXLxxpO
         qeOyZqLOweV6f/vD+CheRTPABXqJHBL7AQZTz4Qh6iPTGjFL9Qm+D8spp60yb444jLvC
         6FAPDgFtrNrcRKGT+sHYcIeyPEfymSIua/xijRAIHc6Rz49ne13D8eU1Lxc3yU0FCSj+
         96xqluyGXZSFlnTwCQED8fjsnAotZT6lEeNH7CLHzSSRUAuyRqicS1FYzFqeluoSe48m
         WTGvWeS19RGaXQcCZLnuS5JRvN9sSRAFONOTofotMyJShLgcvK075K5z0hzToOqVPvGq
         pEUA==
X-Gm-Message-State: AFuF++mIKLetVQ59Ez4ELxh8M3TGvWI2bTmqEKzSaA9KSCnTONCVf5zN
	v/ZFXFZnPEQ2GwbthQ1LW+UgA34jqpOpg7uXmNCJMVIVCEl0tkH7rQwau0C8Rg==
X-Gm-Gg: AR+sD112COQMr74lf/hTQDovSjBJs5bYwquvXQovMh8cIOd+TdZOnF6VdffSz0qlyvV
	XBz6bMcNd0vxtMlDNKyG37N2O836DYqwZqOMnY71qm0T6nDoIpSxfQUBg+uj3hceJa8o5WGJTDZ
	GyjgNymnHrxRiO9nzi8/lWPJK0awszaXpT2q+B8FqAQruzm+Lnsw1pJfgym3y0ICYHNSNgGmjV9
	6bMVEqBWQj7ru+JwmvnDdf/9/egxr25r57b4SvwqSOrCp45eg0H474Y9WOHpigPUhbt1i42lX4S
	ElT9v6ua5WIz6wu7HdQRi3c1E+VCn4qJ30ojOXq9YED24iCUPnTzIOlrnnMmmUuCakEGJDBhzp1
	LBBQk5hHRmWI2aoMNJllro7q1y2quvuUAUyjF/JQWlBihtLfHa/548V+DspSRNob6Mag1ua2QWt
	9DM+JUJaZP4TZNKawMGXchcMmt5R/HCw9pkbPfD4Eie5bHkX3Mmj3pAEFspdjxg6QATQ==
X-Received: by 2002:a05:6808:6901:b0:4b3:17ae:16dc with SMTP id 5614622812f47-4b3982aa644mr5689472b6e.9.1787919121574;
        Fri, 28 Aug 2026 05:12:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.106.21.67])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b3a19e693fsm1110483b6e.13.2026.08.28.05.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 05:12:00 -0700 (PDT)
Message-ID: <6a917b10.dd457072.6eb25.ddc1@mx.google.com>
Date: Fri, 28 Aug 2026 05:12:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2969396055553885520=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dayou5941@163.com
Subject: RE: Bluetooth: hci_ll: check clk_prepare_enable() return value
In-Reply-To: <20260828072349.217999-1-dayou5941@163.com>
References: <20260828072349.217999-1-dayou5941@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2969396055553885520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1153025

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      22.57 seconds
CheckAllWarning               PASS      24.55 seconds
CheckSparse                   PASS      22.80 seconds
BuildKernel32                 PASS      21.37 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      385.01 seconds
IncrementalBuild              PASS      21.53 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/659

---
Regards,
Linux Bluetooth


--===============2969396055553885520==--
