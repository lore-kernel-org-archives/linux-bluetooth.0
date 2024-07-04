Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C301ABC23
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jul 2024 12:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720094574; cv=none; b=AE2My5rU4unxY30/9GGq6VxAWIgtlAGYTXOWtZ3J+mO6jADZwY6/VETdgEUU4u8Gs215nEi/qcXeRrBBASTMPKTEWqECG4F3JmT3ISZ/EECQSSj8Vu1EMpmrmJtgjnP0MLJVYHutkrK4aD/HJQLskJEceUk/PNzi1CbD91sWlEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720094574; c=relaxed/simple;
	bh=7ZHdlDAJyMvG4ZrdsnSeZPMIMdGt+Vm0IiVrGmL6wuw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ncPgFo71F9Ag1FMQrzD/mhzLvAN7PaTnfdEBroSO4DKKS1M2ODP7jJZ0JoFggaTgmmonOopwl+La5rWnKG1QvKsQKUEpauTFzTDcZEExrcGDJIHN2dXPoKGhTABXWbzsWMprkKTk/7+k3wC3Bqamr2G/PkVHUgS+3pb3cGhZ5Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkXHK8Ln; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkXHK8Ln"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-79d6bc90b90so37910285a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jul 2024 05:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720094572; x=1720699372; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dgu5PDu2l1kR7aI45hT4dByMvvxksePEFtkOIngi9Mo=;
        b=JkXHK8LnQoXNxEdee7vxzrZKMmWLNCp8knHKLkBu2a9O8+kjcEwzS2yVk7yVfc0nmQ
         UkvUIsUx7B01JS9Sz5H+J10WcW1KooAAGXevTLqYK0t0Q5jMBJu429/aFM3FEQYnjBR2
         qWookqEVIjp/GABT/djmZASxPXNo65caaS4McPoQHq8rN1ITcH1nyVbLHgUwn4QNF1E3
         PRNPXF7O/UvqON6bZn+vXHJrtsbfSnfjWGhfnnZIhKaiw86KlXXHwH1/vDJN/2eLIXZL
         T2AMjovDYslzNCbpu5IeKrf46C+vFvKHKOXrD6usW7BnYmuivB5TJVGCqedy/LYxnjgI
         4Xow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720094572; x=1720699372;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dgu5PDu2l1kR7aI45hT4dByMvvxksePEFtkOIngi9Mo=;
        b=jvLV9GAV62jv/+fu/p7o3PBjNkSeZQbO6MufVAe1J7jtlXjDFCvmZnX7kyFfGzmcVm
         7a1+FHRnPv8ZdT4vZMUvDlRNwk9KO51ex2fSF4k0fheZmi2oLZvLbVh+/OhXe86U1xVB
         rS6FcK9fFPYdBlgCQaAZqVmO9u9swXRp8Z55jutVJTa46LaHjBDjLGmWovkiHyG3hKZh
         49hVMbeLVIYsiwdE0qyTL26nn/LDUX1xxj8j16X4dA9+nzGvyMBhCgoBPXWC4hNwiw6K
         XvAxIGb+Dl6R77WRztLNHFbsm2cmik1lEaDAJqsUAKbGuHTzQE0o20vpqBTvs1kcN928
         w7JQ==
X-Gm-Message-State: AOJu0YzC8FYaOMVjPoXt/y0J6w0nGNJWMOygNP+ucp7kSH1+NOl9mik3
	31ZMj9RDZ291uBoqNjJ8Iw4DXhCB+8qtiUrXJ16ld3DUMGUThP9X8+Y1pA==
X-Google-Smtp-Source: AGHT+IFXb0kdnmTXHps01MFWPQnQJXDDiQLTZB39zQAlpri/nNDvJhjsAt8A5MlTzZs1JFjvdc2dVQ==
X-Received: by 2002:a05:620a:29c3:b0:79d:7d71:1850 with SMTP id af79cd13be357-79eee1de193mr158876985a.35.1720094572273;
        Thu, 04 Jul 2024 05:02:52 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.51.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69307730sm669445885a.108.2024.07.04.05.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 05:02:51 -0700 (PDT)
Message-ID: <66868f6b.050a0220.7acf5.b7f2@mx.google.com>
Date: Thu, 04 Jul 2024 05:02:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8208869587435966448=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, antoniovazquezblanco@gmail.com
Subject: RE: Add Cypress support for bdaddr
In-Reply-To: <20240704101123.51164-2-antoniovazquezblanco@gmail.com>
References: <20240704101123.51164-2-antoniovazquezblanco@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8208869587435966448==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=868397

---Test result---

Test Summary:
CheckPatch                    PASS      0.36 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      24.66 seconds
BluezMake                     PASS      1645.12 seconds
MakeCheck                     PASS      13.04 seconds
MakeDistcheck                 PASS      179.89 seconds
CheckValgrind                 PASS      254.55 seconds
CheckSmatch                   PASS      359.07 seconds
bluezmakeextell               PASS      119.80 seconds
IncrementalBuild              PASS      1454.13 seconds
ScanBuild                     PASS      1046.56 seconds



---
Regards,
Linux Bluetooth


--===============8208869587435966448==--
