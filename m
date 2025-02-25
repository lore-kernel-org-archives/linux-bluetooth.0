Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12095260A53
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 10:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478281; cv=none; b=rlx4n/eVD9ANkKV5bsfIY/qGhG0LRs9Mqy57QQxXT7aPYsP12HCqskTNzxMbSv/Hcoctb0+uPN/80tKF8adOswv2F2+Iul2HpTwY0l+PezvJfk6WrlRTh8cYlnGIr3B59HnBCIdmQj4RMJxXFTivOvyAEgPpGAQULy541cRvFSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478281; c=relaxed/simple;
	bh=bfKlz2d4kCmbzMLG8Sg2ISJ/jya0KNZ0XFohr84B+OY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jAojelOOLSzbxJlg7mGA1Q1XNftxwQtNzukc7KiON/httccQCVvP/5X3qBDJ3CSPetHCgsTQHszLYNCV1WPRKpBpA6GJLXYJ1n0pInegxLmbXaz5BtQb4qLc0e9wfq9sbOel3sgfmKbi+CXdnISVyaXedQfDI4isl9w0+NcsJ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jivs514U; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jivs514U"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6ddcff5a823so43385416d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 02:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740478279; x=1741083079; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GA7P5pm5ksunnrSMtK9YDAB3ikIRF24yevKRsd1LO7E=;
        b=jivs514UkrqlCYJ2O680qL2XxmT51vd73oeo5Pk0RE1iWsPJUYX+CKUpyh9BQc1U6I
         rVF+vuRNnqThpo0D2OH49P8sFr3r9R32x6nt5kGAdGw0QtQqLoedxYjL7jJw0/UWnAvm
         F41bfB0K0NnnnLN1LI+AISb/Zpeluenxq3c9dUiTrMFJZRAbRlLH/Tj/nNNl9Aolu6ou
         KVGuK+E9lzSpGCmHCHFr9wp1mD5xZcMLbShpIbENXQhGsA5jgp/1O+uOZL14hvuS6AZP
         BWz52eFDOdkKwsMcae1pzQoBOugO04NmAKR3/CSI3yksJWj+SWEjRxYtwDmycH08vePo
         JDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740478279; x=1741083079;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GA7P5pm5ksunnrSMtK9YDAB3ikIRF24yevKRsd1LO7E=;
        b=uqryvbGYLSsXHKE/uVG4VdV+UR8KnfnMM0qbkORWy/6/Nkm6JFMieNxqFYHGd5cSYc
         7Nvf9upI5FfDeSGOpoedH+46dfVwOkaFNA11i0PX5fzDTZireke7ruWF6XDF+kjOFrj2
         UetaC2RX25XnML38VLLAVhSBuXnI9pXmACbUqAP2mnDuqTECqKpXGYhiYCLmWCQd/jP+
         6WTzvc632i39DmXVpWNL8CqOqWA2JHm5Qqt/3t2ZUW/JOjJxQvTo0z4BABBVW6DhEfYb
         ON/MUoYQQ3bkNmrY+HKOKmdCWyOYoSj9aRKSh7Qsg5GTPTPlD1F/NWd2vKrkz7iiW5R3
         pUVw==
X-Gm-Message-State: AOJu0YyNTEsa6LbvQDAoa6UCcRE5+ijTl2BhrqRKyhzLFeoBsUDOKy/3
	Q+r3B2AjXMyoPfGoGwIyPLUqZKYKcxT+9v0wrwBIfW/5h2LkVpz3JkDRlA==
X-Gm-Gg: ASbGncvi89ffyWXOejpXjx4BQVByNXhB4PVvmGI7qFvVV6lfv6+pvxfiPS2N4k6Z1k0
	XzYKgGBQkxSBPvMAXcP/+RkR52ZhJcco8YJZZjZckgCeP2rREdEPSeDCmkDxtjjOVSvraRb0NOT
	Gqbn8uUzn/M+bZsVViOYBPWMsW99vbNkFlJyhKvUqIWvxVcTN4SwNj2bCJnk9Hz88Rvz83pxVRJ
	ePo9U9M65h6xkZTPiKD2oT7S3vuDc17sB9ymLsF+Q45DI+A+6RtDtcqoNJib/fwm/y4UD08KH5w
	43ZaIx2idaQENIxGBsxmT6pCHzcrK736
X-Google-Smtp-Source: AGHT+IEYbf/RtsHVvmSxoN56F17oRRtmYbw5VLV8MLQH28IbzmuG3Ekc5Bi3z50GS/AwnvUwrsqImg==
X-Received: by 2002:ad4:5bea:0:b0:6d8:ab7e:e554 with SMTP id 6a1803df08f44-6e6ae991541mr249704526d6.34.1740478278817;
        Tue, 25 Feb 2025 02:11:18 -0800 (PST)
Received: from [172.17.0.2] ([20.161.78.214])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c2a3239sm90948885a.37.2025.02.25.02.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 02:11:18 -0800 (PST)
Message-ID: <67bd9746.050a0220.393b42.3531@mx.google.com>
Date: Tue, 25 Feb 2025 02:11:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4285818512785617130=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, devnull+ye.he.amlogic.com@kernel.org
Subject: RE: [bluez] adapter: Prepend the new added device to the adapter devices list
In-Reply-To: <20250225-leaudio-no-media-v1-1-6da9454067d3@amlogic.com>
References: <20250225-leaudio-no-media-v1-1-6da9454067d3@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4285818512785617130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=937409

---Test result---

Test Summary:
CheckPatch                    PENDING   0.18 seconds
GitLint                       PENDING   0.24 seconds
BuildEll                      PASS      20.30 seconds
BluezMake                     PASS      1519.90 seconds
MakeCheck                     PASS      13.31 seconds
MakeDistcheck                 PASS      156.26 seconds
CheckValgrind                 PASS      211.94 seconds
CheckSmatch                   PASS      281.87 seconds
bluezmakeextell               PASS      97.31 seconds
IncrementalBuild              PENDING   0.38 seconds
ScanBuild                     PASS      849.10 seconds

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


--===============4285818512785617130==--
