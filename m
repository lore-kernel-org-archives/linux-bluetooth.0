Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBA31474DA
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 13:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712149303; cv=none; b=o5Sn4QtFDmUtjhxHgHH6BqKI5ypzInQvHYBKkpVtbHuj1M+ANBubSRWgCjVuJWMfEWSQHmXMD1ro3Dz1gjGsW/asjkYBsWvs2Hf0TqtBzNzl/B6fgG7gitXxi7TtEY3aeWZ8NPmG4Nol0UXCqhLVNKqJKAh1ZTuPW6qxcS92XNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712149303; c=relaxed/simple;
	bh=HkEJojS/kjkSge47vAWvsgAwaOvttg7cona/9gQERBo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lpzVtwFoqgiORLgR36fLixyy2MCYji68GDLqna3m5s5DeEhsP9OVytsVxhlASiUhz0jK8aChee3UyqQaXo9ZvkyO3287m7Tzf+rNSp+5/XnY8/8OWAviAnk89T9WgyAeZhkcMLgU4PFryQpDGpk55LxLWUUzuanpOwAB+mkTHps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gT3ROvG9; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gT3ROvG9"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-69107859bedso35011646d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Apr 2024 06:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712149301; x=1712754101; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ui8G7j52sm46eJUhw36uLL9J735syGV4oO1A4UImHnw=;
        b=gT3ROvG9nG/G+zE1o1vUdYfXsNq21Paxk1vSd+CkxyQEtMDiNH79sOwvdDdL1JiMh4
         z7XhlZhpERd1/qobyK84PfD/i0QfBvdXKZMdIUYTp4Be2UD77QnSRI+mfd8nVq/YL9zt
         KORNnjXnxEoagGRLOIEAlHol/iafDaKxzd46WyNjmeeiRFnUen2Ar0lkuT5YarngTEu/
         35ihHe4+Nuos50MOPUzhjlGOZ5Kna3w0hfXGlRUXCMgNl+IZm5UVfAaftKTomW3wGpVN
         Du+fBWk5mLMa3cMztoSSBQ15PhkZsDfAiTpZrNElhHEdNmCP9PmQ/IOhfrdhZWiE27wA
         CgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712149301; x=1712754101;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ui8G7j52sm46eJUhw36uLL9J735syGV4oO1A4UImHnw=;
        b=VO2GpLI3rhu5Kp67ArlNbEgiYvjk2FpblDXJ47eUHL3265mW/1H1NSnOTxjP6v9Equ
         PNhvLiQUsEo7/EpR0LPfe36XBXVNv4M1q+zXqVkTV/2HunCDykHRRqp8xSknvy9BT5fw
         WUvY2EA1sFBKJ7jWa94y1td51ph4TDCBo6ooT3z30m5Ppxp0RaM/+0JUWP/Gldgfh8F1
         sVu3T0EzlC7moVZ20s6/LS7XAATOHBwqQYowO02jxiQNhyB1hgDIf1X/BiuL3lAbtqFe
         DHLvpuY8RhXhZwswDzROXjDWyz+VFjSQlOKztaE6VTd2EuEL0eX7Ops1+qye6kBm1kOK
         JtYg==
X-Gm-Message-State: AOJu0YymP8Ct+COL428CR3ipbt12a49nqcjikQKm9liOxHy+QLEMErDq
	2/4csqReXb1EJVWrleAF0nS+JdTlOWEWZtzZeeYiwfC5zlPjVTqVwRlCYl7n
X-Google-Smtp-Source: AGHT+IGlFNb/bZrp/3eqZjvcbpXybfX7UVCclYWwUwcSvQSSZ6nkpMLyz+8QrXWNJSqT/gcO8rQ4kQ==
X-Received: by 2002:ad4:4183:0:b0:699:101f:c86 with SMTP id e3-20020ad44183000000b00699101f0c86mr6576014qvp.25.1712149300816;
        Wed, 03 Apr 2024 06:01:40 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.159.203])
        by smtp.gmail.com with ESMTPSA id qo16-20020a056214591000b0069920c1703esm1194371qvb.31.2024.04.03.06.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 06:01:40 -0700 (PDT)
Message-ID: <660d5334.050a0220.2eb8.7636@mx.google.com>
Date: Wed, 03 Apr 2024 06:01:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6786721132435778641=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] plugins: Add new plugin to fix airpods pairing
In-Reply-To: <20240403110808.805771-1-frederic.danis@collabora.com>
References: <20240403110808.805771-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6786721132435778641==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=841054

---Test result---

Test Summary:
CheckPatch                    PASS      0.55 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      24.87 seconds
BluezMake                     PASS      1668.80 seconds
MakeCheck                     PASS      13.49 seconds
MakeDistcheck                 PASS      178.87 seconds
CheckValgrind                 PASS      248.59 seconds
CheckSmatch                   PASS      351.49 seconds
bluezmakeextell               PASS      120.29 seconds
IncrementalBuild              PASS      1467.46 seconds
ScanBuild                     PASS      1018.85 seconds



---
Regards,
Linux Bluetooth


--===============6786721132435778641==--
