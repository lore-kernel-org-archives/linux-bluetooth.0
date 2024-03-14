Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68636BFAA
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Mar 2024 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710408756; cv=none; b=qdeQVO777guBFvw6uFguORVnzf/uyXbDZ82Il9IqSDHAbqFICoa6M9QXEZcjJYz7vy8zfsumhb9MfXaqYrx4hk42Y5/sqUubi+tdJ5fepgZtugIWJoHo2LrBR6dI/tEL68tZMynshmyZFqGsv/BCkW1wt15A+djDP/XMhC6O69s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710408756; c=relaxed/simple;
	bh=XDYMK4L0FaluwQ/I1KJAfgLi4iboneFdcC7uD0AN8Ls=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DSeGtZ9o5leR8oOj0XyixJK4w9ezQx9z0X2N3RHDh+xV/eiRtvpVIp1/PMaEi7rMr1HED8uT5xd0qbdZcj/brRBqO28uNY3UGpu7pCdw4MAripDBsKwHzzVJP/QR/OA9aQRZNRIyG5lHd2LP91sMMsIuJBm6xj+m1gkYQP19wvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCbaMmHY; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCbaMmHY"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42efa84f7b5so13080561cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Mar 2024 02:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710408754; x=1711013554; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Fex833tKsMrWAroQjGucXvHTrppzWUaMFo4bScu0e4Y=;
        b=bCbaMmHYfauYuxeu6Zv3BfezXfucB5coTGBKpiJqc2vbAKpiD8BUE2Hsr/0RB17kYp
         V7PgSE1I8lIJQhVRiyUeha8Lxbgz7fwfjUecPhuuvj36CMKipLPNaetg4RMxG8EQGWQk
         cXU15wIJXio3bv8kDLwSpDiG+dTbbUp6SxUViCI/t9zrz1IFGYZ4UNJv/GpZRsfAPbSe
         TRd+vK+psmFI+cO8ubChkJCzWenE8SS7+YqmzZPn27dQ0ZQzzyH5N1HAvcgddDTXS/V8
         CfHigQpYKUnYasyYgtx232TrnqF9AgDVgEa8TCxqob/HwBEgdEsK8aswK7pZBreS7kLG
         RmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710408754; x=1711013554;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fex833tKsMrWAroQjGucXvHTrppzWUaMFo4bScu0e4Y=;
        b=CaVJYB13V268nyxIiXuHS5av6KTBQopqg+yY46/X9LKjuliAHhY+0UNESgDrE9r98T
         tc7M4yVNxPEycqDu7DNxmfD7oNOyeC/C2+TOvmxoVhgwV1N/0qryhKp8gjzXy/rnMM/r
         V9uYmmmWJU5WL6Mj+Y9hTO2IfhD5n7a27Jjxi0nhfQrvUoMGTavFrLuHrTASrjumfBGX
         b+WYukXuPwoB24CrGewpeEZxJ2agp9osMzeHOYeuNLyrcPOGhb8zJzYv5jsR8lMClgdy
         9ku2vlndOAD+nOd6X7ogvVAjQ0B6swkHOoX7kne91HEgqjet6i7rQfzfKjibZ0Q6U84a
         IUyg==
X-Gm-Message-State: AOJu0YxXHrwBXldIeWAWx+jDca+pwdILrxAkFZmTdntvh7jtXH3KxmJ9
	42c0qNWWpRuK/sJAAb2GZO33cm9YzInyPM+ltJkrn0vxgCI1dRF2K8shKYff
X-Google-Smtp-Source: AGHT+IGnVxMMtFkwc3CzHkLUqloRN03Yx3qt/YtbJqNTf+2ghQsdMHG7mO+uBwX4yBbCuy4jnIQPHA==
X-Received: by 2002:ac8:5806:0:b0:42e:f7cf:369f with SMTP id g6-20020ac85806000000b0042ef7cf369fmr8257927qtg.31.1710408753665;
        Thu, 14 Mar 2024 02:32:33 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.46.167])
        by smtp.gmail.com with ESMTPSA id j13-20020ac84f8d000000b0042f2130cd0csm568156qtw.34.2024.03.14.02.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 02:32:33 -0700 (PDT)
Message-ID: <65f2c431.c80a0220.8627a.0fee@mx.google.com>
Date: Thu, 14 Mar 2024 02:32:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4346101322838610644=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, johan+linaro@kernel.org
Subject: RE: Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT"
In-Reply-To: <20240314084412.1127-1-johan+linaro@kernel.org>
References: <20240314084412.1127-1-johan+linaro@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4346101322838610644==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=835223

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      27.60 seconds
CheckAllWarning               PASS      30.36 seconds
CheckSparse                   PASS      36.00 seconds
CheckSmatch                   PASS      98.23 seconds
BuildKernel32                 PASS      26.97 seconds
TestRunnerSetup               PASS      507.94 seconds
TestRunner_l2cap-tester       PASS      20.06 seconds
TestRunner_iso-tester         PASS      30.00 seconds
TestRunner_bnep-tester        PASS      4.83 seconds
TestRunner_mgmt-tester        PASS      112.23 seconds
TestRunner_rfcomm-tester      PASS      7.45 seconds
TestRunner_sco-tester         PASS      15.00 seconds
TestRunner_ioctl-tester       PASS      7.73 seconds
TestRunner_mesh-tester        PASS      5.90 seconds
TestRunner_smp-tester         PASS      6.85 seconds
TestRunner_userchan-tester    PASS      5.62 seconds
IncrementalBuild              PASS      25.94 seconds



---
Regards,
Linux Bluetooth


--===============4346101322838610644==--
