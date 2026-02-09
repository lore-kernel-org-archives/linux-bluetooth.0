Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210C526ED48
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 21:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770673356; cv=none; b=tWPuuXut1qBOiwGZ6P7q0IP5AQXtS7uND/vxKxqxDe0JbsH/jnYnldkB2R6nnApdB4KlN6huo9myxzyQCL1hUgUWBH6Gnm8oSqN5MuZ1iFu8FZHgdhKr/0aMKV+VR5Vi06YnnzlB38120JBd6b0xdIumhrOfafy9nexzotetroo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770673356; c=relaxed/simple;
	bh=SUMmEpGMnpAsayKOq1c58R5JoUXQ7PSUWqUlZvrPunY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Op9d5PJcnibpDsUHHOsSbBFAX7yAn//hf6HLDpxQVHFh5jNJiTKHmCkhkTS1XfmM7adZdIu5ar9mik/V1hV5Yx83CVtBISxFDsq7Bc3VpIodaQMgOlWsvrjS3m/QPuLkL3ySHIF0c+KJFAWC4Q55fWSIqTfdCQGvfHW51t/apJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdobQ/62; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdobQ/62"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2b4520f6b32so293242eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Feb 2026 13:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770673354; x=1771278154; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WJBrBoWF1l0BVM62Bq/gcMdbUe3LV+9zJYZ0UuL8DgM=;
        b=CdobQ/626NVC0wSxVl/i5095hb4VzEfjhOuY415Wt5yH3I9YbD7RaXl5SkrWC8jKCc
         KyIAIkE+1eQhXNszx/Qo4MGf171rB79knCYxiFXvVplyy+aCNm4khhUu0+dtp1F0FBOs
         YifRV9C7sVMURam/krJMUAlGJjmeAvQaeebfB604zOgUbHp8jQSvLNppR9e84mlme2BK
         WL0SO8EosDMQSOPl2skjrMIq8zUdTgFY5f+8+P0J/+DwzBgcp5DbKliSfRPE5S1uyACh
         53iGyK1WAqp+EvXYCcNH3vTwuqt66DDLJbAPcofliNsRVNtG9nhoRinwUqtWd+pYUjZ1
         ifqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770673354; x=1771278154;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJBrBoWF1l0BVM62Bq/gcMdbUe3LV+9zJYZ0UuL8DgM=;
        b=lqhdaQOS2tyhjSD3uFoMtBu3RlFPcSB38uZk3QxA6navR1UtVpSPeyJh7h6wgsa9rL
         OvQMqfKKXC2q2hc6S/iMbjueuWOQTRcVLn+pdHqHUF5T1oNI2MHTVIk0SODo5a+e/YGo
         1+I2VMQoOjuEwishNClLiFahXAbEiuYc+Nd1jeuTg16lknOkY1sN7spdM8CjlecuxWne
         jJPd8qKmQORaczQwAxawwpfW32s/P5TH/Pn4908vPuZlk/m0mcDeFL389eVDpKEBoQj6
         qgaJU4sCdphutPWXWfkn7erXyZq40J6tAWDJe4iqwaGKJ9RY929eJaJTzqJIeToEh8Jz
         6HpQ==
X-Gm-Message-State: AOJu0YxA8k2+gWHpgRKkV5UUvJ6B+9oMWPwK71TF8muFLG0ZEJE9mnqy
	inBhDmMazxH2rneDT+07voTPiXiEHzK5vLNN1u7K/vanqLCJym0cd5WR+Kk74Zcu
X-Gm-Gg: AZuq6aJfRefLSD0e98IGsvIDDGZw7WwHe3x/1hm2fQN8UdKOd+GFTOY15BhmcXBQf55
	CcwUYpv3jiuacbHvHlLfpCNNdHbOmow5vCSCIJ1ZGo8F1N26Tcy5mkNO+/exCZ+1SheTdfqI+IM
	hL9yAj2zs17OWRNjNMtqwqDG750rLqkcmoLA0Ij/wDrLVZLbQR2AynpZzTDJowt4N3g+ZqHDifl
	CZG3OBIx/sYsLUZ7eKSwDTNmAMS+XpXO2jt1tLbzx3zNVS+TAyBa2QaZZHvX+DRRD33DV0RGLjA
	dZL5rGK/CqUrME5/f19L7+kcv1nnpNTEqRgAGUfrD33Rk5ZLXAKNVD25pF1fFygJhKecziKEPiV
	RFyLU/3HWe7YAxG4whKVrx9sPHBsjjyGDgvUfVIwTd8tkExWEcOKulSm5yPqAcHc+FXTZYcrziq
	/GIntq4A/1u9uvW1g1Hg==
X-Received: by 2002:a05:7300:7c09:b0:2ba:73b0:2ea0 with SMTP id 5a478bee46e88-2ba73b035b0mr1671488eec.11.1770673353839;
        Mon, 09 Feb 2026 13:42:33 -0800 (PST)
Received: from [172.17.0.2] ([52.190.140.136])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba6c1bdf49sm3727909eec.2.2026.02.09.13.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 13:42:33 -0800 (PST)
Message-ID: <698a54c9.050a0220.2a7f8e.3a69@mx.google.com>
Date: Mon, 09 Feb 2026 13:42:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5492315934082669579=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ,1/2] shared/util: Add byte-swapping macros for constants
In-Reply-To: <20260209203316.3050687-1-hadess@hadess.net>
References: <20260209203316.3050687-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5492315934082669579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1052425

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.51 seconds
BuildEll                      PASS      20.62 seconds
BluezMake                     PASS      676.16 seconds
MakeCheck                     PASS      18.46 seconds
MakeDistcheck                 PASS      250.39 seconds
CheckValgrind                 PASS      299.39 seconds
CheckSmatch                   WARNING   357.87 seconds
bluezmakeextell               PASS      186.11 seconds
IncrementalBuild              PENDING   0.46 seconds
ScanBuild                     PASS      1046.68 seconds

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
emulator/bthost.c:700:28: warning: Variable length array is used.emulator/bthost.c:701:32: warning: Variable length array is used.emulator/bthost.c:918:28: warning: Variable length array is used.emulator/bthost.c:952:28: warning: Variable length array is used.emulator/bthost.c:953:32: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5492315934082669579==--
