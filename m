Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1D8482C1
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2024 22:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719266471; cv=none; b=KFDQGI5DE/86kZ6VXEfNvozBmJxcpnhbeyA4Q8TE7D8znuFa0BqSPqv0A37ikLsW2OjaeRhhAe9l9hhLV2QWTvroSHxyJ9braub/eQnFrpH/haUUzz3XWsEZ+aMM+AW+FahAw6gdRX/KWyvEXyX/bnJEbxx1BFDyzaQwSdZpZE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719266471; c=relaxed/simple;
	bh=nZcPkhStMKYOy9nPJYJo+mNRGlMayb/AxqYunMXa+h4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=b7kLjMkcx5puQd8pfMhZt86/84ZMz2dXISUVuI9TvcSgJHKxrAdBaLMvYhKUoUKI2W1NXdzA/RTqRwIJznq/UqzMGTUrkCKFvuaQDWh2cs3PRB/ZTWM3JIgYTK8nDjfKUhh3C2kJBleQcKWBOvnjpFw8WNZsncBwUK4rpXNRUnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kp803trV; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kp803trV"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5c1ef5ac47eso958651eaf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2024 15:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719266469; x=1719871269; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vs3t3oL/ZO8eCyzRoHQfVrVs+moSU02tsAlG1zvfafw=;
        b=Kp803trVdYPRLHG9YFlat2dgBrK9gTS8vNF0Cp86UNhNltM+b2GyDZ4lUE1ozhF/uI
         sIa+WFhIEdNFtYqMG+0iIL2f2+/DlrtQbH5ABkShY4s/fEodMHG4dZ/KrAxYckPPZwuc
         YDi6CtW5QiAUAuMVqD9z1XFkEb5XXiI931UldUqf+BhzYRzH9GvCGRoXW8v0Eo4GpJJ+
         l6SYzwhpR6Gy1vx25C60HmWFN76svq9MbkGoyWD62D7H24xV59yTHXXu/7RVwuvQiPG5
         Q6zPktl15Yi/k+oFqoddu9wE5Xv5PwVA9Vo3XsN2AAK8TS46aVj4ouWC1jEgCRfr/bfh
         6jjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719266469; x=1719871269;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vs3t3oL/ZO8eCyzRoHQfVrVs+moSU02tsAlG1zvfafw=;
        b=MO3Y/LCzQO4/zpnyxxV+xrOnKBO8oqqxD6poZxLYz0GvUIyPnigNtVqdylJtcbR50d
         I0BKb0Y9/+4iZ69mCGNQAU16vs6MhAvh4phbA3hU7KZNjH5LuiQp8LWe3S4fTSGGhBc0
         fZoYVn9yscQi+0nNOzdAwnc17Z2j6+J5ncq4Y9dLJhMER3ST+qpfbdfLsz8qJ7rSlbkM
         49DWGH6I6zpwz2nSH0qsbkb5mzBkf9WXvY6kow1Qn9umuEzgL7iBeX81fDVAXbfeE8eJ
         cqrm875K6M+LSpoYr8m03a3cYsvwqaOFS/VzV/lukVhfH/AwIbkH7OO/51gSUMCMancL
         HiAw==
X-Gm-Message-State: AOJu0YwMGCHlkuwJaU73P0+o6Ivq79essiH+a8ZvzEJdeRYxTWyey4Ry
	SH62MFm1uQl7fqjEuwqIcoZ4sPqnTO/jJwcu5n20rPqC0cspq8PoKsePyg==
X-Google-Smtp-Source: AGHT+IHg+AnQp/9MQPf0PzAwUC2oInLdFI1p3XivdTspdPnOYHE/a40N5+Mv1jTa7+F8LaG2SIFCmg==
X-Received: by 2002:a05:6359:d1f:b0:1a2:38d5:aa39 with SMTP id e5c5f4694b2df-1a238d5ab67mr602343855d.27.1719266469412;
        Mon, 24 Jun 2024 15:01:09 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.58.163])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef6807bsm37948756d6.133.2024.06.24.15.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 15:01:09 -0700 (PDT)
Message-ID: <6679eca5.d40a0220.b623f.c5b6@mx.google.com>
Date: Mon, 24 Jun 2024 15:01:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0525204455746400757=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] hog-lib: Fix passing wrong parameters to bt_uhid_get_report_reply
In-Reply-To: <20240624201324.3891633-1-luiz.dentz@gmail.com>
References: <20240624201324.3891633-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0525204455746400757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=865048

---Test result---

Test Summary:
CheckPatch                    PASS      0.42 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      26.02 seconds
BluezMake                     PASS      1663.87 seconds
MakeCheck                     PASS      13.46 seconds
MakeDistcheck                 PASS      178.03 seconds
CheckValgrind                 PASS      251.27 seconds
CheckSmatch                   PASS      354.36 seconds
bluezmakeextell               PASS      120.09 seconds
IncrementalBuild              PASS      1417.64 seconds
ScanBuild                     PASS      998.78 seconds



---
Regards,
Linux Bluetooth


--===============0525204455746400757==--
