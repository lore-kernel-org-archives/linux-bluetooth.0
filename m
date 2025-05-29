Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3959F1A5B8F
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 May 2025 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748538449; cv=none; b=tXocBHLl+8QM6XNhi/PTSCqRkf6iwsvOut6TH7ir0HZeUMKX/0wA1Di3I4Z2hJbAs//zjn4p+tYyzwzPPh37TsF/wnT/03UEWyJKJEYRDq+LQ4Lj2ksNxvp7xCkx+aWXhJlL5/UyXMBGyGCH851evPmEdQ9+PkC1/azYQQ7bsDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748538449; c=relaxed/simple;
	bh=kx0oQ3n/FzSvrV03CXrP41ncsUraEAeJ8ET8ZcwYEvo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YsUGh+aI22iwnaXdccOJyI4vB6doEmzVu0h6CwQ7avtcu6VyeOvLfkrHAACnpT3Ae0j/T2fDKD2FEZjERp2o4wWwM9merCPYGFdCpfekrVuZAtUr2KIEyPwInzDKjO9vvf0xivDby97FU4L9NY0D+0wSkscXqDvlv73J5jkgqKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ct3rcgj2; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ct3rcgj2"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4769aef457bso14963091cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 May 2025 10:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748538447; x=1749143247; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j6tt5aR7+b53PF45NjDz8pe2WX9ac7PjZ6jQoRFLMDw=;
        b=Ct3rcgj29Z2FxMLNHx+h8K+z8PFkIyD9SvYfB7fgnjG7F1mtbPPtH3L9v2POEtVxIC
         oF/1ctKcUZlK91ehK7FCZ4xecOaNsx319rxSQm3yF9Lh1ztaa5+2i2tBvqATpKWGiCpf
         qLe+Uli4Yuu2R7vjmOCRTqEHtH5gGBPr7/Zn/G9l57wDdvGYF8tWZkW9xQxAbmSQkK2e
         Z8nUwstll7jWgwEMPafrhGfV1yDilnRiU3E6+gRHH/w2/H2Ihg9cogvZ+0qUFJtyxSGz
         5TkCxkb9dFgVJKJ9Iu+fMmCZlG2DxHCvDePND9SjNw8eHDfOSkZdA7ZW+yfyC/LbsAcW
         KyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748538447; x=1749143247;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j6tt5aR7+b53PF45NjDz8pe2WX9ac7PjZ6jQoRFLMDw=;
        b=NOQOKQZvwkwMr8u0NEGM+RLdGXq+t2/OKXir+gEJWnV1A1aNp2zWLRvtTD9dLVDwB/
         Jd7Of4QAA3qHNh2NwPLhk37Ep9ZIA/IylCfTAjM6GFeF2AM4AvYQ8W1QyE3exvJp7sqk
         HHMh0ZdwOgXoRLEJNIzhO2JgVtYh4mwPpvu1ndadyFEzTTdApK5oKqWVACPHTLurzfyj
         oe+EvkYquyUuuDtY5ian40/rDGRdr/EOMYqpZpQiKDXZ5uHNZVWYdskFI53wKqGz5V2t
         tUZKwBy4ZeYb1X41pfKh3/OHSWcAlFbOPVO2rhvVAzcbuZybs33N5DNRuJ5FXyNsbxEA
         +NgQ==
X-Gm-Message-State: AOJu0YzvP0gJ0TYPacbg3IRUM/lr4rFtI4GT9lXoIcrJ6Dw7EFj8B+z7
	zg8bts+BKFiT6n5VAFCShrO9iryEL3EPMPzTnZf11AX45KEY+rvxnFF8e78wmw==
X-Gm-Gg: ASbGncs77KqazvYrOwnvya/UjiG8lrv5AkuIzybHwueE9tVTDLbwEkqkdeg7sbnovs2
	Z1fgbewY7VVwPm0l2aquuIivaS7gSuOItTiEw0XEITXAbSSfigYCY9sXVmoy5bHVHhRQBrDWb3K
	fIU+a1gjYnecjjcgHzeuNp2jgH6Fgee2Cw4QC64TtQeGDa1p7o3hQTzVOR8O7LkfRcsH23+U00P
	9jYtjt+VzPh3tFyogKs0/5gcMODRAQsSjuJ+cr3rMpuO/v+pZJe1oXkAlRGhS9EYOvCNc2PV/Qv
	n3ZJkabiAQNE482TqaGXW6uOzZqIW2x32DxiR4Wm/5Zg/pykzWEvLLx8
X-Google-Smtp-Source: AGHT+IG/0O3GT8VAznbZzBdjFavq/VjsjTJmvhAoNgtNWCXgjxWnVEaCWAexqUJ6e/uh03FgM00lXA==
X-Received: by 2002:a05:622a:2b44:b0:4a4:2f42:a668 with SMTP id d75a77b69052e-4a440074ea4mr6988661cf.31.1748538446506;
        Thu, 29 May 2025 10:07:26 -0700 (PDT)
Received: from [172.17.0.2] ([20.246.78.55])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a435a371dfsm9749191cf.63.2025.05.29.10.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 10:07:26 -0700 (PDT)
Message-ID: <6838944e.050a0220.a5dcd.3b62@mx.google.com>
Date: Thu, 29 May 2025 10:07:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8383926425107015543=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ukleinek@debian.org
Subject: RE: Bluetooth: btusb: Add support for variant of RTL8851BE (USB ID 13d3:3601)
In-Reply-To: <20250529162333.462753-2-ukleinek@debian.org>
References: <20250529162333.462753-2-ukleinek@debian.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8383926425107015543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=967387

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.57 seconds
CheckAllWarning               PASS      26.48 seconds
CheckSparse                   PASS      29.87 seconds
BuildKernel32                 PASS      23.76 seconds
TestRunnerSetup               PASS      452.54 seconds
TestRunner_l2cap-tester       PASS      25.20 seconds
TestRunner_iso-tester         PASS      43.47 seconds
TestRunner_bnep-tester        PASS      5.88 seconds
TestRunner_mgmt-tester        FAIL      133.87 seconds
TestRunner_rfcomm-tester      PASS      9.93 seconds
TestRunner_sco-tester         PASS      14.59 seconds
TestRunner_ioctl-tester       PASS      9.85 seconds
TestRunner_mesh-tester        PASS      7.30 seconds
TestRunner_smp-tester         PASS      8.41 seconds
TestRunner_userchan-tester    PASS      6.03 seconds
IncrementalBuild              PENDING   0.41 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.206 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.173 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8383926425107015543==--
