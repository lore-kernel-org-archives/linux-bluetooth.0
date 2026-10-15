Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4C952F28C
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 12:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068122; cv=none; b=cFJjMU13MJAZ642ZARzImVMpfL3PPDUlBt+nCYudrK6RoQPL4noltB6ulr3sCYs2oqI9VfoTkJmxu/ItSW1hJl1mLkGqLUJDLnwYMlery5Zvh4Q0uWnaArwJPRUQ4ihA5FpLhvcuN2yKQjxeUiizFgHfCcsh7jqODA5qkj+/d20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068122; c=relaxed/simple;
	bh=rYlDtLxamfZpnuEOT+wSGO7eScYLqCMC+iGmLbwAheg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jh5W9Mo0x7jgfz38FPRQ6aX2YT+90H8CDQ6dhsJYTAeaz0O/sobJIPI/Ip6gKM9kI1uB0hv/VqxU1lMeGTpG0nq1AkxPJFzVg1UClQUzRPS0p7TGkFwM1NjqNvvL9HERlkzyBba2jCjLFJke3Id84ilpIyikg64doaFcXC+hMNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrTC91fi; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrTC91fi"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so1135254a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 05:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792068120; x=1792672920; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dHjmKz6YRwhaSOJqzjWplHHqdnP/dQcvMbGV+CRu7UY=;
        b=VrTC91fi5X8sfOYKNWqkKw4ulgAHwg3ZrgK7fMSm4xIhJ+joqtFE91z7aYY5ZKKoZc
         HhJOZw7UTUY/nz2oKfaenGHdowv+ZQAVusdv85DV/NKM1ccMc/0AiA7vYkhbkbRMwgyC
         DzWPx386uj4GnLWcRgA7wlFbgK07XqE4dXVpzjollCA6hKBWer3k3lcIuH9RWYhVqYm4
         XFdPiAfrEyaZ6C0YTqHE9MMQ5onQGxgLhIzapU6T9I3GpljXLjViyvraaAqGk7UtkdT6
         ZABE/juDwCjNZi09lb4pRLD/lm0iFumHFiIxCV4tkplheyRPef6rE+Fk3Rs4/b1oAaSI
         +z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792068120; x=1792672920;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dHjmKz6YRwhaSOJqzjWplHHqdnP/dQcvMbGV+CRu7UY=;
        b=0Hlz77ishVB+uxIW9UdMGUfgnL7kY2iqRttayIQEXUBbCZms41BeP03vK0gQPrYFyH
         ZRhoD9K2EHigERZbSTLHZjo0DYh5IkBvJ9L/EnJDkCs3ioxm9jtVslSaFozpryWFzECG
         /aXP2iFNEvToP/O9DSGX971F2Qyq23+Dp+d4XyTdEDgw4BflmareULc2wkj1yCP5uYsa
         NxYOgelRGYilZVjzbOsOdn3FHA5sA7bORIWCmoLNfAAIOcbM8tdW0ZgzuD/J8203R8WS
         4T9mLsZ9Fo9s5cIPbJdk7wJTWbvBBe8V7tRzswLycJBoy0TprXEZ/OShmMql24utjGRg
         S7aw==
X-Gm-Message-State: AFq9FYLtshUl6Dlr5ppFXBgGpFN5xT3J+aCFmttm3vlx+KdVRkM8fUtX
	jh0SYtmvdSDqrZLYryxOJfgGMHXOkyCysiAtz2uTeyVzhaU4xrWQuncGssQg+w==
X-Gm-Gg: AYBFou26pmaX7XJjKd+nP3U22d/YO+SbqwTH9YJC3jIJgzvF/O3npAM652N7v1CBXEO
	XT7E8WE8Nx7iEMYyQmg0wxNL5pdnWEAp2X5U8LOPmmLCTxxnsyNBut4YWRknZcaDuSH/QxnKMvD
	4vMnKQYjQLqBoLzPo/f//AcJtMzEvBCqThwnvqCYfK9+1e6W6plE8aDYwFtPSL5EHzo0Iai35kn
	fOCKBKW9x3Nz1AAzrPL1+yR77FphlR7bZLfE1Iev8ahat8BDjYAiQocmrFIKcs0gL8N7fFpAwMd
	AMwpuXVXfcGxtKL5lQV/hL81vTIArIzpOCuZHpzfeai6ts3Kbbl4uejHKKUh8F+AFkDoo/8iLO7
	uUHzgn+NtVOAl0mQuNstnMZOP3+3A863K2jPR3gMAWLWuK3xhOKLn+ikTGYJ1UmGN9j5E9fr3/U
	lUF/qNgOjGPyMyjagZn1Nl+hCrSuZZTVJmAXqZozjs7BsFx3qn0fFDyddyDYVLpmMngWFmyBJdJ
	/rh3g==
X-Received: by 2002:a05:6a20:2587:b0:3e1:1b11:15c5 with SMTP id adf61e73a8af0-3e16bfce3dfmr15996068637.34.1792068119739;
        Thu, 15 Oct 2026 05:41:59 -0700 (PDT)
Received: from [172.17.0.2] ([20.29.188.152])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd635c8b9ccsm1234673a12.20.2026.10.15.05.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:41:59 -0700 (PDT)
Message-ID: <6ad0ca17.7ae0942e.104b92.931b@mx.google.com>
Date: Thu, 15 Oct 2026 05:41:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3444955376984237698=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: Bluetooth: hci_qca: Reopen port after power on for QCA2066
In-Reply-To: <20261015092224.262158-1-shuai.zhang@oss.qualcomm.com>
References: <20261015092224.262158-1-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3444955376984237698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1186314/

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
VerifyFixes                   PASS      0.06 seconds
VerifySignedoff               PASS      0.06 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      30.55 seconds
CheckAllWarning               PASS      33.96 seconds
CheckSparse                   PASS      36.97 seconds
BuildKernel32                 PASS      29.89 seconds
CheckKernelLLVM               PASS      36.73 seconds
TestRunnerSetup               PASS      737.85 seconds
IncrementalBuild              PASS      29.41 seconds



https://github.com/bluez/bluetooth-next/pull/944

---
Regards,
Linux Bluetooth


--===============3444955376984237698==--
