Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0172E62D0
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 21:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764710001; cv=none; b=WM1SlFuxD+g65zSeCoyJXbieX2x+mgBEXDz3qmYE6ZSJA6IUXp2ZCyqZgfNHf067S5LYOv+zHkkXMWf0znhWOsvrImKhHctzKVG74X/40c5BwumpW7Aoo1VDX0pODJ1ZisAf1VsM/jjcCqfurnVLgJVOw8qsNisDjMAICXPfVVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764710001; c=relaxed/simple;
	bh=2PucVuPy9pa+viEBaPNG7Ryc2mU0mIq7cNSrNTYmoLI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jK9Eo35Si50oEeufcsa8R8yHrR66r4UHNcW9r+2bwuyed3atvTtkhQEQvM6AGezHXChIm/KOfx6pe4nAPs2/0DpB6T4fuGdiKm6oCVZNkVhtuEDHSKk9D+l5orD0+XZp84/4h+/yVtogNLRJWnet5rDhTJ0uydlwL/x6TKyf0lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPOkHIcM; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPOkHIcM"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-880576ebe38so63225396d6.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Dec 2025 13:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764709999; x=1765314799; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9dxvt22k5xerdRD+KIB2csstnrYWbVmkfd3QOk6FP8c=;
        b=GPOkHIcMDDKUvA0GyduSKBGfTgEvivYEUnsiAm/C/m3D+HT0gavPS7rw6ajzqiiHyS
         eHyd3X8WBmZQNcZlJCg/GPESjz0rqCLMszXKUpcRJMaq21fUp5JoU0RUAx0vBaE1aVXZ
         MwkKngUaVYdZp7Zs9wx/S418HRDTbpQ17pZYI3u+xeJBGF9ZZC5sm3biwmXLwTKsVTjN
         SYAJNOkX+d9VCkP2TVMsbHyaRk5zujPfaTR1aYcVx84kSSW0lxxm4lmnZtdTjm0czcEw
         JTOzkw+ovwY+uoaPpih6oXKXrf70Iw0UXizr2r/Faj1/bM6zMgbbZMlIyEMnBI3M9ZSp
         LIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764709999; x=1765314799;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dxvt22k5xerdRD+KIB2csstnrYWbVmkfd3QOk6FP8c=;
        b=wlM/T8KIUORhUUvuvEcCBw50xCFmuKJA17URBPIIUh1pgCEpyaTrfO6P+YrQ+wH8dh
         xZe1IlKhizPS9ysT5ApTVtqG/tu9pCa67KJJkwuA94K2+/8PjJP7eRb3gzilXyhbXp71
         5yblti8KFtH9UCyOYPTJUCoAhxd4LloFioDIn6PPuiRZ74uTG/++Myme/cLV6kuwU/uV
         +8nYNMVxCdh4ky+SX8fusjD8oZ++tsltC9YVtPxCiAT3P8wnvBI76EX6nF7xjqPZozwP
         N3MYmBHsWtR2+s1bnqcQfIS5QgxMERTcWO6cUhDjjgDe8usJHKYa0JsKTA7/RlNopVGR
         ttdQ==
X-Gm-Message-State: AOJu0YyKtCMg2fLqINJQM6wqWFbZMVdvzeZExSCUw9in/EjlAAs02EDp
	2a2MJ7pFIAZKTmuLcHrz5zrytH+6fH2YKsuy1slOzu0Pma6LJfVOlJHLekEL5zKi
X-Gm-Gg: ASbGncteRFLg1RN39AOC+seCM8jyH0NtRxtOBHLzrKw+wOesfHHKIENjeZKN+O2qPRS
	wkB9BXhx2JBARyDsVrS+xEgpmNikz7dJHTGdvNclOcxHAlGF0GoHTaXNC0ZRHCv8eaB+rF6M93y
	C7iYJ+1WAeLfexBAzbJHsqNIpnZwgfGcO9H8+FrKhhc5cYmblBgoxEiuUCw59RxZM6b8+VxM7Z7
	YxAC2fbdhA03jWzRxqt4q8M0q4IMHE66UqbL8k+i5IvEXty6OiTUB4Z/bsImiWOAZWUt5Nvvyjh
	TlPRs5DIAbS5El0Xa8jom1vhUhjr+V5BUfb2HWS14UiDdwifS8Su33Jld2bIba4/sJEcOrHu05A
	SXWVxIXt6z+vWZa5T9OsMB7fYWhu+PXMlY1EMzI+lTzqnFk9vLdd1WSsnD6GsgMSY1upn0Blh3+
	XhEUErWuUGLIM/Ft6/
X-Google-Smtp-Source: AGHT+IH5zalhkmlRtlRExlfEL1L+KSLltcGK//QM7uW2BbPIa/efeSxYzD4l5roZZFKXDvsad3t2Zg==
X-Received: by 2002:a05:6214:e45:b0:880:4dd2:1d15 with SMTP id 6a1803df08f44-8863af6de5cmr457309026d6.44.1764709998904;
        Tue, 02 Dec 2025 13:13:18 -0800 (PST)
Received: from [172.17.0.2] ([20.161.44.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-886524b0560sm113269556d6.7.2025.12.02.13.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 13:13:18 -0800 (PST)
Message-ID: <692f566e.0c0a0220.18c376.4bcd@mx.google.com>
Date: Tue, 02 Dec 2025 13:13:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7354098236498911538=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] client: Fix transport.acquire auto not working as initiator
In-Reply-To: <20251202201810.2022976-1-luiz.dentz@gmail.com>
References: <20251202201810.2022976-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7354098236498911538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1029860

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      20.20 seconds
BluezMake                     PASS      628.50 seconds
MakeCheck                     PASS      22.09 seconds
MakeDistcheck                 PASS      241.04 seconds
CheckValgrind                 PASS      296.43 seconds
CheckSmatch                   PASS      343.85 seconds
bluezmakeextell               PASS      181.55 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      978.80 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7354098236498911538==--
