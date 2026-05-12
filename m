Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FAB368D55
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 08:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778573054; cv=none; b=TLTay2QZWhCe03IaP6iuSU1ZYfVoIOU42vMei02Ktzvow6JnBz16seeaOO6EL0iYP8liJrBBg4I0vmpf+EyAXqtJtAFplDNWLtDjh5vycyQjVVnxJ3Dq0LPF0Fu/80IQmndwD00bQ6rZSKe47NxNFpJXuO542/X/gACX3Xhzdy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778573054; c=relaxed/simple;
	bh=+nYxSaNQxiLsvEJfmCZZ6h/SSs+0fWhakB7M4zFDvy4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=g3kM3IwmTnrNThKLXBuaqGg2FmIbWndQ++NK43uY5ftcqa33HBwxkr6UOy/bJubErssmgsIeKP/s4BE/tuSRyrB7UBETsn+FxkCaPJDsiopnoq4ELPoxnB6RX7ILG53Dfw7JLd+NUFdfgUU26M+VWQ1J6xYLFiZUWdXxQKsxKWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oQB5xUVk; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQB5xUVk"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50fc496c8baso50589991cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 01:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778573051; x=1779177851; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=95+ECxFMY3Z3UcFFZdIg0uPWITqcDxRwOvVewWkWZzQ=;
        b=oQB5xUVkRfWCpq85DAlGeGWkxW333ettwj60DAi8VwyjGaKiwxTPS0wWfbYVT3PAc7
         2b4rcbevpvrGwOp6Du3RhSqbM7tTcSNRBWhSX5E/TaZ4KeoEvNRjm68ctSCzBUb09iko
         A9kI5D24glX1B/YG1r+hW5l6q/1eMpeQFI5xMec8nVk+pJcX0BLNvjx+9WrNQ4jHz91L
         RBCpFCqBWLIBr1sFJQpc2oIbqptheq/eSySVHiHvqUp5Z+wea/cVt7VcOkq9K9/qXaTz
         2K0hINp8dTSrg/+HNQJXr4jqz59t5sB8FSwd5nFabI7V80I1+Lm8Y0G1tYNLWiGkkeon
         mfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778573051; x=1779177851;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95+ECxFMY3Z3UcFFZdIg0uPWITqcDxRwOvVewWkWZzQ=;
        b=jG6pvtYqHXGs2PaPN/cbHEm7OQlDbMKMuTJhpYQpZFkKMUN5uFVFoUja4ZMeRwc5GV
         vPcOZpb40EA1ieEWHxj9j4o8FBhywjS2K7/wBNz5yqb6dVU2F6HYluqweV8GAfdjK8Qz
         svJXfDnM8vymTU2APQqtAqhWNQnYqJzQpk1b0iklob0sHbioy/DyDl+zUOOUeEiGuc6T
         V7QR35dkbOeRCVve8JFVN/gpBqskHXLlBozNdxo8BSxEymuuKdcrAspJenB8yO38kK8W
         n18jpmorH0afUBkHRIwdwC9az7MrAc80oA74iy9NQ6yFfs4fpgfxmauSTRCgCB7Vjn1C
         drCA==
X-Gm-Message-State: AOJu0YyG+0LksHPz61pYlCWQdzrUM+aNcnb+CpWYLAuAtzWVFWM42Ql4
	W8aNPtDxfKmVwwV5QONtqmrq+HjeZ/UuchMoaCp0nqUyL/eJwxjHjfS1ybP5hA==
X-Gm-Gg: Acq92OFPrOy3mC3JF2YsETtniwGIXyMQXRFpO0/YxzutvzQL527eSv9GDnRoAMTxxsu
	cFsl4I6XJOm+eVF3yG1dwchoDhh610rJ6448rYyvyrwdQUt6OvjkOLxqEoqjxtebeXLZu+Om6sd
	wWuCcPlMIJo93BZt85WDIlnSH4muCynSQ2KLoZTZy8MBYMuGJnlGiP6+CsyHSW2fKzmgjKdvRIY
	t4MAV5MsZH3zh1AVMkzWW6y7H2GPibAByAIuC8mDhqpnLzodSDD3nnt6S2hB/wyj0y9H7rYmuWU
	mCp50vLdf0Tv/0m5H9Jf9LVbBn0Mb5vTuB9r9mb7nIAR7tNAo4EREy4RMBlzrYCaWNAgnENjb1i
	dKTrdT6PdbTdOHWayWiAjj6GTYdmfUszrWcGMr2yYGzWatin/eiyaqjdrpTSnQGeQ78FDuC1Gdd
	Ap1cN7zqgqrnU4Orf4/PsSXI/8gwo=
X-Received: by 2002:ac8:5fc2:0:b0:50f:b260:cad7 with SMTP id d75a77b69052e-514d22229f9mr27504531cf.41.1778573050819;
        Tue, 12 May 2026 01:04:10 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.86.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e62eff2sm120912511cf.6.2026.05.12.01.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 01:04:10 -0700 (PDT)
Message-ID: <6a02defa.050a0220.f085c.49fb@mx.google.com>
Date: Tue, 12 May 2026 01:04:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0587007090862599434=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luke-yj.chen@mediatek.com
Subject: RE: [v2] Bluetooth: btusb: MT7925: Add VID/PID 13d3/3609
In-Reply-To: <20260512060318.3288273-1-luke-yj.chen@mediatek.com>
References: <20260512060318.3288273-1-luke-yj.chen@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0587007090862599434==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1093276

---Test result---

Test Summary:
CheckPatch                    PASS      1.32 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.01 seconds
CheckAllWarning               PASS      29.57 seconds
CheckSparse                   PASS      28.09 seconds
BuildKernel32                 PASS      26.52 seconds
TestRunnerSetup               PASS      588.49 seconds
IncrementalBuild              PASS      25.67 seconds



https://github.com/bluez/bluetooth-next/pull/175

---
Regards,
Linux Bluetooth


--===============0587007090862599434==--
