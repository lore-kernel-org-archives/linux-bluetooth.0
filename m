Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335D6379C45
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920935; cv=none; b=ecrkeROpZX13mVBQ836EF8KEBkIxRw4EfmO+Vl5mKb20zTufdRQtKMqHKcVAM1pbTFNPxLBb0uvv0G8+3qLNUZ/p5uwWN3XDrxtV8zk9FU4WQI6r4thTFkR0rIZ1PqZ/ZMVOXQx/RmtPvl0FGdpGjF+9iJIBQJhe48q0akKqHns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920935; c=relaxed/simple;
	bh=bxsXPAX6bftzFTymDGx66ZRJAeIqgFUn1dgyjTIrknw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rEet1UuaAvowLUvTW53J/cgJ9Y0rJu8uw11zbMc0HT1jZ2i+VztVygp/VcuR2ZWkvczT/wWC/qnqavKjelTaeCdVfCPN/+e0XglS3ZRKUg/oKOyEckTmukxL9c540aqxTpC6uXdFCGPaSb5UczXUZs8syF1nR3Gu+7aid85/bOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/iV7r7J; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/iV7r7J"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ccf18ef922so61883736d6.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 05:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780920933; x=1781525733; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eQ2qxCJMcbkSdzd4ZFHHowcV50T4Pz3kgl8rrsj7gys=;
        b=m/iV7r7JHE/cgxkiXcswMBnCtrjM2C3lmoIgSVarRcD0dobFbOJIJa+oK5xYT9+1yC
         u3+tAssjZaSC3S4zeQciKY+/yyqTAO6XOdVeJgKmUmBdQ8SXficLlBRBVOuNn/5qKAqg
         FQI2VTcGxveTyOEG3OpWX80PgcPrLDlAJDsm9riyAYs0E1aUm7ZdcwQmEwbKBW4kMjQE
         X8vOi6cC+Zc9XACcya1eH2SUkrLNC9vkgKVK4bA+OdDGz4l1bgJjxyTluf/rxs3J+cTh
         ZkMLzsJ+u2QsqC4Ux/atzbKH9mVH+Kndtwl0scefWBBOWwjTlHnSJrSJvkqsja5jkIau
         T2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780920933; x=1781525733;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQ2qxCJMcbkSdzd4ZFHHowcV50T4Pz3kgl8rrsj7gys=;
        b=Id/Ard1a4hNxBnLRWZPu/HZ9NneEQPnDdaVDTA23/b8Ah9gF75c9/jNWSgtU1Q/da7
         Q6Bt0KDjo3w1uYXjKZnS5PLH4CGzPj8ImS0IblagKcg9IPOLjEVKcxBP7KhPdGdD1btz
         9ZgeURmA6/d0Tnn6HICgD981SfUzpIoBgXSuiY55hHGLYKJ6qXehNbROYwVGKnN1o9/1
         wCKGH53BMj6cPkpl2o6cIx1UxLSpWi/iDBPTpXaGmlGI+cgQ4nMIgZRUaiC6SHf8NCbv
         jR9qgAob2tWBIR/2yI2QpykXEWnYHNDU3720O3OVcxo3PLpk+MvtNC+SOk8iLI9VVoc5
         l0EQ==
X-Gm-Message-State: AOJu0Yxrbtps4A50z9mfyv3j1gOAgdFoA7LKTYhfhf+U1VNJ7zYj9d1y
	MJ6qj5b1v+iIfp6ocT7IoFEX/0BFyfjTjju08Lr08gzqdo6erV5U3DKTTkNLNg==
X-Gm-Gg: Acq92OGnfhvnuKtOfa9srTMbgyOCFmFOkxXGR+PuOYgpX6wJcybOctSyoB3hgOB0zl0
	yGo2wAT4x9SXEuwrLhQ/nNdHvVwK9pVd0LmuiN4Owp1pr2R7weosJ8Ny0YNXJvlqjIuX8BGueOx
	aIybq7mHwMzM2oMoHXFAKIazMmDnO3xKBWUrfy1TTnafWR3OWI/RGpqmCYx88s4EBbfXnZarPde
	sdhEZKqwKrY15HD2CWVKZvjZOyQOWdTlghIJZ8n0zPITKz3/EE3YAtYZEWrMZPkg4QfNJ0Qh1jZ
	pzJdkVozv1wK0nnVcncYWbFnKgE9V2e7RIpXNHSs/vAZVtwj8vj+CQsP5YJIAsl6chOmozr8aRw
	CpjjG9Fr24a6fKIh2TQN+2TpzgnM38w0akUNpR9G2u0w7AqmBSHd/lS4IJ6tMfszpJpT1wttdyx
	XMSbhNeHuHKNRhavmVDAiiX4QCAXC7wJTFHqM8msBR
X-Received: by 2002:a05:622a:258b:b0:517:5d30:3c3d with SMTP id d75a77b69052e-51795cbebaemr236042711cf.50.1780920932999;
        Mon, 08 Jun 2026 05:15:32 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.213.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd0556c0sm164391286d6.25.2026.06.08.05.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:15:32 -0700 (PDT)
Message-ID: <6a26b264.7f7f1747.378f3e.8798@mx.google.com>
Date: Mon, 08 Jun 2026 05:15:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7994474747426039332=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ] device: Fix auth_retry timeout not being removed on reconnect
In-Reply-To: <20260608112403.3720840-1-simon.mikuda@streamunlimited.com>
References: <20260608112403.3720840-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7994474747426039332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1107787

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
GitLint                       PASS      0.35 seconds
BuildEll                      PASS      20.81 seconds
BluezMake                     PASS      613.43 seconds
CheckSmatch                   PASS      326.66 seconds
bluezmakeextell               PASS      165.44 seconds
IncrementalBuild              PASS      615.34 seconds
ScanBuild                     PASS      932.16 seconds



https://github.com/bluez/bluez/pull/2191

---
Regards,
Linux Bluetooth


--===============7994474747426039332==--
