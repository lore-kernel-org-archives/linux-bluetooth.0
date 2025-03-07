Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD852561A0
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Mar 2025 19:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741375076; cv=none; b=sHh4bZZ3Ram0G1Imy2svBBWM3EKkvwNXnTckHjNt4+HvlXBSAaiHPvC66235gyKWpyV7guxmSvUKjp5JVmu6hj9TBi4coXth7rubMlgQcQ98mSddNo7RCFZG0jcOtrktcNwWx76y1TvvCORXv2QDLefgNBATaD3dmv9EKTKPzpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741375076; c=relaxed/simple;
	bh=OhA/Wo4TWjWufboM627nkXJzJqnZVyMyWPEXo4XkAnQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=i+WvSK+vsbbHbZ/LvLuxKhyyYGQQYaNBFujtluW2btR84PXwY0ai/fyELrqAbkLEtXqT1vb4XhNwcEfGI4t0NTbYpDkDuSCyEpulwMrnZH9dOL1jc+3tIWVPVLZpbia4gyaPRyW1POjNI9xGYcvgIFkOwBbo9DOe5af6AIEJRGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzQWIUFC; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzQWIUFC"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6df83fd01cbso10551096d6.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Mar 2025 11:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741375073; x=1741979873; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nUj3vDoxfaGURJlXmRW5qt9tM490sbjuzImSKMbj6NM=;
        b=BzQWIUFCTxW2CkmyI2jSFgm26UQyTJ6c1cutqOUh3RELs57UyyC26yZAcoFlahfzlD
         E/nS2f96HlieHp2DpOISHe18ZizcVCm3ibeOC58UgGb1xnZ1s+eASUdBHu+FkB0lzmN1
         OtKtSwBxw4HlBijPxMF9jm4EHa66cIT/Kg6oVgwvUP4pDnpsHb8gj5B8k1ayTrJUJa4a
         BK4rQdPON7WEm6DdiJw43e2FyMNSdm5ilEpYnR42LVeDJfTlsiHRFSoxkKDqhoL5sQGm
         KQw88x3MRlZPbX7nL6c+TLUUi990NKz4Xb03p+Qq3pDbPQawd+siQASGHOLqbS+vAJWX
         zAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741375073; x=1741979873;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nUj3vDoxfaGURJlXmRW5qt9tM490sbjuzImSKMbj6NM=;
        b=oejZU57RSbgrG8PWXnWljHuEvcmqkCUoGdIe+rBgxXdTWgYkDBt3Av6A05yT+np8o/
         srKYyna5c2WnS8gp+eIcXYrKvgzMt4/KuE3FD/TpvrN36w4d8/CYsyQdad60naMeT/m9
         kNzD7ePDmB7wMfc76Xy+CK0b8BOU9DiV193VMQhk6KDgnqxygTSErYGu3TD0ScVxEUfM
         OTGBOPOLMdTntcdji/WU75gMN0gpjmQygg7cXMrzv22qqQdjG67URG7k/8KxMa1p2tie
         Paj0Pc1SwywYErFVUDbAfJ25RmKxKdheX3fx7JUlkPmTP6dylGva3KbUr2bo9kSKhJac
         g1+Q==
X-Gm-Message-State: AOJu0Yw01NlTB+jhX+1nQdeFvPULT8tP1hEZeb2HcFm+TvCVXuQBTPH6
	+Sv+NlwzV44+MGRUqaK2h6Hq8JgTBHHC05bq/GuLAN0MeJPYClCrRvddIzd6
X-Gm-Gg: ASbGncuASNH5oNNvwMVhLR/VaY/1q/fmQ4qRSFgdve05Wv6zV/afEZm3rmgZ/b+x5p3
	k8nnsHsZckTlGdATxA9114nvlrvGGOxYNq99RwqgrlZ93bs2O9RtDrv1DTVym8vH7aK1QxmmKBs
	DSO6+CGd4pT5oQgLjDEzTLb8L2ICNVP9AAltpt8HKb9oqlzCxK3F0oAsfwRb0mzuAZL3kb2/Uzj
	ZkIS/eWBTQr2JkhieiPrENEEu1iyW0kUSzSdt7pfJOKwspQ8otSyBibtoysqkFFRym2qWMAazo3
	DbAE/VDk7iUW6RK210S8sTIs4zBjYtQALtn/SF72tLtjdsEXBH4S2Q==
X-Google-Smtp-Source: AGHT+IFNWpQSecDzy/WBwTItZKSreyGM/KWy8cRcZKI820vsPYTVZBZohMx0Mgm7Cdi6Gfmr4HMG9Q==
X-Received: by 2002:a05:6214:230f:b0:6e8:fad6:7104 with SMTP id 6a1803df08f44-6e9006ea033mr47730526d6.35.1741375072968;
        Fri, 07 Mar 2025 11:17:52 -0800 (PST)
Received: from [172.17.0.2] ([172.200.198.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f715b81fsm22663496d6.88.2025.03.07.11.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 11:17:52 -0800 (PST)
Message-ID: <67cb4660.d40a0220.321de9.9053@mx.google.com>
Date: Fri, 07 Mar 2025 11:17:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6039194006897286828=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v3,1/6] btdev: Add support for Sync Flow Control
In-Reply-To: <747adb1a5f2a6b7b25e823bf22f8795f4c7c6322.1741370367.git.pav@iki.fi>
References: <747adb1a5f2a6b7b25e823bf22f8795f4c7c6322.1741370367.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6039194006897286828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=941624

---Test result---

Test Summary:
CheckPatch                    PENDING   0.19 seconds
GitLint                       PENDING   0.19 seconds
BuildEll                      PASS      20.73 seconds
BluezMake                     PASS      1566.30 seconds
MakeCheck                     PASS      13.29 seconds
MakeDistcheck                 PASS      162.45 seconds
CheckValgrind                 PASS      218.72 seconds
CheckSmatch                   WARNING   288.73 seconds
bluezmakeextell               PASS      100.09 seconds
IncrementalBuild              PENDING   0.24 seconds
ScanBuild                     PASS      895.97 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:451:29: warning: Variable length array is used.emulator/btdev.c:451:29: warning: Variable length array is used.emulator/bthost.c:628:28: warning: Variable length array is used.emulator/bthost.c:826:28: warning: Variable length array is used.tools/sco-tester.c: note: in included file:./lib/bluetooth.h:232:15: warning: array of flexible structures./lib/bluetooth.h:237:31: warning: array of flexible structuresemulator/btdev.c:451:29: warning: Variable length array is used.tools/sco-tester.c: note: in included file:./lib/bluetooth.h:232:15: warning: array of flexible structures./lib/bluetooth.h:237:31: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6039194006897286828==--
