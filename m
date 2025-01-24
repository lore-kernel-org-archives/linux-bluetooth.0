Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206303C00
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 08:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737706071; cv=none; b=gx6xnAOeqwT8kYE5H/h6ZgzMuIBZ2pCr0eM2FnIsGFMHiMB+o0BCtMscKYjf940h7y6qV6TiFjXovJ8yY176VGAK1asJmLrybRPyUF0MiJCnQ6Vd9pfapUXiu2RsiAbVKWOiV9MfkzQCsl98I2/NjVfPlWbEqDmC/c3DMB34yck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737706071; c=relaxed/simple;
	bh=3elpyIs8GtYV9JNnivALtIe9qziW0+K76citrutgYrY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nQWU9huVweO4WOt0nXG4l2jTfRMlAMVHl1mwM0fIOwkkuZ8MqfUuZhD8sGPyJMuccEruCINmChY9dq92+QGp7O2EvD6d96aBpQCD+/5FpfAYBGTMHwdq1j/HJtRk5lfCOvXkztg/SnfG46FgWFJ0/lnKNLbkosTEF5l618pgT2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9wrn29Z; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9wrn29Z"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-467b74a1754so23942671cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 00:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737706068; x=1738310868; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yHdtaZA32qC5qBuB627/2nBS7oQa96mQDBDpofJ45eE=;
        b=E9wrn29ZyKk+/1Ia8wp7DBU56kXfetDjCBDw3AismGAN7MA8rRxcNeYdQd2yXjByXy
         CJ0YCO7okpEbn3553wBK/127YKlJ4yJSKrEAAEZaHe0lf5I/g58b50eNaUe6CJmZwm7A
         kfhJn888NqJ5Cw7uCp9xkulHv7jki95TzFo8FExMy3oiO0f9i5Wf7bCZcI9XpBpUZ+Cz
         0cd7M9DhY2UKmVbZ4UMh5647rU+HF78awF8PTiVzaxrEI21aormZIoHlKqI8jK5EAHAC
         GJs8YverF9thnLlTQDbQ6bpNvJqSVbH4Tc0NaubjLp7BRp5gz3EQ6CJNOfDvFmIAb1Do
         3pyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737706068; x=1738310868;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yHdtaZA32qC5qBuB627/2nBS7oQa96mQDBDpofJ45eE=;
        b=nE1vGZap36k1fyPI2MJmzgM95pSIhtWA1CE6SqQ+Gj05h5pCV1MdripHi1fify+Xbu
         4VZytz9CZ+zXXDNgt6sgFlyZMl7vwUVMSV3vMPtumGxzisrRVykx/yO9rMwxVpV/rHJN
         MInMULDZYrzeV2qz4jmS471hFkgMj6k0ur+9nk2qTqIeNq795AjvwQ8N/nCmmrMDkaNa
         nU79uHC6YYvYM1T42xK/3IjxrEQwtrB8PLsNvsHEr3NxqicAnmsTcMa95d8UweSp5hnH
         +EBv1wWo4fJezYQo8SrlTJMlT6kURn7YmV38hdfbKLC1OYxtx0Bd6W0/+HshN5MXkm9+
         7G7w==
X-Gm-Message-State: AOJu0Yxr3Xq35q7JHiFfbb3C08MnKLT1cAsZ0F8syh8XIKXLlooD0cEb
	MRCbmUM8razjRfZ/KqMu59aNxGrX83c27TgblHVt2R1f/4lhvVVDs0rwRg==
X-Gm-Gg: ASbGnctivjgEV+AeBN3xJQTRSqGkrPZvCSZjwE6xinmM4N8fqC9L9VROLrZh+YcCmgO
	uTczPQNAtkG559FsAGjXiLKgvtOdHuEM5AWM85yNIXO8wVmw3yMU6l5dwMiy9QNU9rNEUCE++Li
	qz2gAWC9IwLSHrT/f+ZL/VrtexjrpxNGkEhm4vyZlMNqgW5DsGv02qL/4nFvl812H8EsgRoKgWw
	TlXM08zw4YAjNKE3j6T6MaCJa1oLnSdIXRK7m4vlhux7WdIIQ5+Yfu1eV2DqmvAFtJ/ChcO4E4r
	jhdqXP9n4A==
X-Google-Smtp-Source: AGHT+IEtW6Ommod5SAJVvaI0hLbUMUH+mLgMXy66J/Enhyb0tcR3ToI2Ne9Pd5e5kjqDvTYgq1e9oQ==
X-Received: by 2002:a05:622a:1806:b0:46a:3709:6780 with SMTP id d75a77b69052e-46e12a693d5mr413193801cf.19.1737706068549;
        Fri, 24 Jan 2025 00:07:48 -0800 (PST)
Received: from [172.17.0.2] ([20.98.37.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e205136b24sm6469526d6.21.2025.01.24.00.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 00:07:48 -0800 (PST)
Message-ID: <67934a54.050a0220.2971ab.2aac@mx.google.com>
Date: Fri, 24 Jan 2025 00:07:48 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0814988812172738430=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v1] obex: Update the MAP Client version to 1.4 in SDP record
In-Reply-To: <20250124064105.1071400-1-quic_amisjain@quicinc.com>
References: <20250124064105.1071400-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0814988812172738430==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=928029

---Test result---

Test Summary:
CheckPatch                    PENDING   0.20 seconds
GitLint                       PENDING   0.22 seconds
BuildEll                      PASS      20.26 seconds
BluezMake                     PASS      1473.30 seconds
MakeCheck                     PASS      12.74 seconds
MakeDistcheck                 PASS      166.82 seconds
CheckValgrind                 PASS      212.69 seconds
CheckSmatch                   PASS      270.84 seconds
bluezmakeextell               PASS      97.74 seconds
IncrementalBuild              PENDING   0.31 seconds
ScanBuild                     PASS      857.54 seconds

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


--===============0814988812172738430==--
