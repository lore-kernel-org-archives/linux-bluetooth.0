Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568A7246797
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 21:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760476511; cv=none; b=HxVBqoCLQ7kJFig7fQID76wToyley9PqcxQzC18bWggK/GNid03CC9HWnGuUkgkFPNa/k1e4+iliVEkHsCM8RwyIS5iEgO/rdiXZTe3ftBCKFPrFBkqJicIPatnhRAwwOCQfiKI6Hd72nkLMfl0T8zqAbQtkjOW3EkqBMTfXTZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760476511; c=relaxed/simple;
	bh=AoKvyp3TMGmlrQg/wMQ8ZaoWElDxDJPScKT96X74tv4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=D74H4B+WUT0kAESyHL0S/lDyLOy0LwjlPA9yjS6b7pqfWE3KaZdRGgSO/nunSmlqrLB+rsxpvYReYwtPLgMOJTFhdWXMo91fsP3u85S+xr7INy6S2sezmOPkUC9Db6coB23b/TtakegDe3Vu2DDSKLnFl7KKmNzn7ARTSYJmyEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jj7NAhFg; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jj7NAhFg"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-86302b5a933so51880585a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 14:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760476508; x=1761081308; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PmFX+whmyvqo9oFLEMkQqRhuRWR+6VQVlMiFHIFQpvE=;
        b=Jj7NAhFgAT5htF9VwP2xZbH1iChfaqLNmEjpsL9Q8XGE1S1+kqZIhTI4GWlI5fxbYM
         yRdtN80QzFFMz9/4rOoqeWfmrKLVU21G2yRmEHNJ099+T41CYrqhXDOctb0iZDCFgOo4
         3FBrqg1LTnfPrP8vRj2tgHjFzPaliQ/v/Oxj1Z9oY1oDk8AbYAUwd6ArT9c/SlhYgT+/
         aUK7NK/4Hm020ucHoSshJIKcXajCG9sAH/UVSMKBB9Q2EaOgVWW4Aze3EM0ct4kZnaOA
         TGEV3SNJWLyY/EoGeTTCwJ4Vt6R4rxjdSJ/bfUYvZkqtghbVjymbQIcLxiY4e4ZAq6Io
         XFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760476508; x=1761081308;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PmFX+whmyvqo9oFLEMkQqRhuRWR+6VQVlMiFHIFQpvE=;
        b=SpVBju1zc+Tdwz7SzonwZnhtr3v0DsFnM/pPXgIN/SNOJKvAt+1UNYwIZ7I6zhwdFc
         QCsSIcRGGlBVKVX1MSBw6koOVgX968dOnaZIXFCsMEidYN9JNRR1sK5Cvd7mabd6SOZ+
         iE08sT6JLS+foUazG1enVoMCy9Ho6A7wXA8WBFD7C2E2wLMWjkD46UcE8FdS8w0wRTxW
         P5Rp9G2y0aCSN/LksxeV+5keLnG/GdRBCGI0INwET4+oq5me/OVjEWB5vbm7HprsyC0M
         WNLZbYlnPYOzAu1Xab2M34qvZgnuRZpcSPyZG8R8EVpkbOEXMXRHU4coU4XM+UICWVxS
         I2kQ==
X-Gm-Message-State: AOJu0YzdGBmlLuu8DT7RWM9JGaXd37stdUDZBrQcuwj83P32IZeS4Sfi
	lYtyzxyd0jcNCY033z0awtzyI992nTwcfFy62NPP0GRVBQkP6SRgZXaAZVkHdLKp
X-Gm-Gg: ASbGncuFuaNMz1jJhcyoEomhvGJAd4nZJHxCjxHmy9PIQbE4zAgNZ1iv1vZyY43o7+3
	4z854IJC/85eeMsyRxBgIEtLNjRy6QHoxElnGXIVDSirNaaJV9Vsq/a41sOOP/ZhNbUNXYhvnkq
	UdFp/dpQ4n7zAbHhwNt44HeNTU+KgdB3FRl6s3UQdPn8miaog49uMrDc0M1sB2OkE7h2d/2wA06
	qk5HX3or22eZPkAYElOn44zg83t5RR0FtgBmZ3Uj2Jn5Q1+3kKCkwFJbCpHWd/V90LWEzzqeL8f
	egv9+QKHOsYFO3o8yMaY20BXtOFMRHlCyZgxlur4ffZYOSm/Emra0xGKCqyjRmBhwCbytW8VviT
	ceIrv7EeXKnmdth/W3jKM2DRUAl3A7LkBZVFDoSLtpUN6wQ==
X-Google-Smtp-Source: AGHT+IEDfauom+/IB/o0yojeR4t8TxpizH8V84Qy1qL4TkOsiYy0x2EuQKFC82I8CcYHaSLQ0qm9Qg==
X-Received: by 2002:a05:620a:bca:b0:84c:65bd:2835 with SMTP id af79cd13be357-883521d7f84mr3572300885a.42.1760476507680;
        Tue, 14 Oct 2025 14:15:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.14.179])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-884a293bc5esm1272036685a.60.2025.10.14.14.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 14:15:07 -0700 (PDT)
Message-ID: <68eebd5b.050a0220.1ca2f7.04df@mx.google.com>
Date: Tue, 14 Oct 2025 14:15:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0057672000651239932=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] client/player: Add 'auto' option to transport.acquire
In-Reply-To: <20251014194855.384197-1-luiz.dentz@gmail.com>
References: <20251014194855.384197-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0057672000651239932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1011502

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.33 seconds
BuildEll                      PASS      20.14 seconds
BluezMake                     PASS      2768.37 seconds
MakeCheck                     PASS      20.77 seconds
MakeDistcheck                 PASS      187.02 seconds
CheckValgrind                 PASS      240.32 seconds
CheckSmatch                   PASS      313.96 seconds
bluezmakeextell               PASS      129.24 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      925.07 seconds

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


--===============0057672000651239932==--
