Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BA21EA84
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 04:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739419927; cv=none; b=eFBW7S1GoH5otKgoXuiaFtUR5gb8MFlTvM2a1/XmrPTqf7gHbDRhBICdJcUWa5eFiem2LWlrk1RnNFlNVGnLhmsOebcutXfTlWJ4Ul6ZUTEBFGs2CXhx5Ny8jCevW6oY335i+zKTouNekccZOFfuWLgOduricLex9Me+ZRk1z54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739419927; c=relaxed/simple;
	bh=pUkjfpCk2wxxCKsrYZUUoGbHnfFHE45JdeZUkd6HUd4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mm2yV7jW/SwbkevTf0TC6DJ35UtSdH+M5YjnVqGZ3Ev2rxJvc3swzpJkEUBLfJZ7IwH/ucbCQXXFLV/fe0MHL16nmR3pvtl61yLTuI+F9VKUE2QoEmX9l3balkTOPxB7cLXm4GM1EXZr7KKvKMhO9bv/0ocRIxgD7+95Im7wUb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkOaW407; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkOaW407"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-471bb02fc88so3005251cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 20:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739419924; x=1740024724; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vR62XiBJvkYgPHYBCICT3vVmrfq3ySmKNy6l8htTA2s=;
        b=CkOaW407rA65E07WiPe1tMJRsW4HRnEtZWlxtSj4jYLF2JcaFBOR/ibGerlXQaVXmP
         iDp+HaUUrUODybcj2glPoLen8Bkk6ghKthhMz2YSHDhaGs6kvTu5ghBNhSIJFmyvZfFB
         cz2Xl2iVdpJX2Cb9E6FiB59qwd2K7jDr9WBpGrZJgDVpwmojWkXPLvuHcJ54MzAMR1VU
         SKEEXJ7esO9B8I7ADefYsZGZbbeIWeBWM335e9+Zun9KTzxJPldrjyFkheY8/tjsWbKf
         oInAcqX07JDciEZDkKIRS0l0F9sCZmWdbc9w0xVOoJ6oAGa0H6GABwOIDliE4Km4YXyy
         pb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739419924; x=1740024724;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vR62XiBJvkYgPHYBCICT3vVmrfq3ySmKNy6l8htTA2s=;
        b=QY/pjxkWgGRqc4Q0OBM7UYqyrBJGiWxUDw7vbHp9wjw9ZozeoC90U8Sqsi7mpNXr/i
         N+xAB9QgnwtygrqlxsSXToUXrxbTMsCs/+tQThuhN3hpgGUixJP4sdthMXnPuqet77mW
         llJLUHlYT658zxCkJ5YykGIXwh+za4fgKWisxfnC675E3yWYIDx0lincJAWU9QQE3cDA
         BzTe3sDZQPwj7PFKZIvnFYu76wBKr7w33S4Y/EUmi1+++/TZ5UN3DEfrysh3CZzX6s49
         zyXxKedzQFblJv/sbztDvie9WuLqL/uoEm2K81okQ7ZadMqs8GybIqhzyF3HgeYmflzx
         +w9w==
X-Gm-Message-State: AOJu0YxxTJil4GYHoiFyyVmjdkH6CVQD/zbTPakx2HIFFk4STrRCj8rX
	X6hrabjwbq9HCnYUnv7OUFci+H7rP8p+P0OIVoNaet6HeAQsX06+p+xh0Q==
X-Gm-Gg: ASbGncsm0cDaEDwW/Y75KVUvuHXvq1tTMAEtXeVVD1n4CaP90uRk7/nA4zQg7eAswG7
	GQHqXFdpHEPPDjc7rs8amuDnCPcg/we2P/mDLKM5ORhQxxcvahpyOmVze9NO3n5iMtvtGyRdYo6
	GL/6c6ZwjByg+t0x/7Zjhd/7jAFpgYclj6QSwkXZUWElvGqldKu20hzUkYC2wg3j+IB0HQaTadV
	7SS7xMDEHMZauBGZSKGj2aa6uieKp/H2djqeRVSWhiCi3nds7ISzGW0aQ/gUjQIVB44Mx7SPPhP
	jL+UWNSem2M4gwdRtA1e
X-Google-Smtp-Source: AGHT+IGVJp5WC7txEOwYEkUlSPOufWCmKuAdenemsuA4yiqawFtyiUbfPLRDr1nGM90hTEV9wal1Ww==
X-Received: by 2002:a05:622a:2449:b0:471:9774:5f1d with SMTP id d75a77b69052e-471bed134admr38687711cf.19.1739419923800;
        Wed, 12 Feb 2025 20:12:03 -0800 (PST)
Received: from [172.17.0.2] ([20.42.10.161])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471c2af3afasm3287691cf.62.2025.02.12.20.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 20:12:03 -0800 (PST)
Message-ID: <67ad7113.c80a0220.e69ec.099c@mx.google.com>
Date: Wed, 12 Feb 2025 20:12:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2174171267534189983=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, devnull+yang.li.amlogic.com@kernel.org
Subject: RE: [BlueZ,bluez,v3] bap: fixed issue of muting music silent after pause and resume.
In-Reply-To: <20250213-ascs_bug-v3-1-d5594f0f20c6@amlogic.com>
References: <20250213-ascs_bug-v3-1-d5594f0f20c6@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2174171267534189983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=933440

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.16 seconds
BuildEll                      PASS      20.20 seconds
BluezMake                     PASS      1452.79 seconds
MakeCheck                     PASS      13.57 seconds
MakeDistcheck                 PASS      156.87 seconds
CheckValgrind                 PASS      211.58 seconds
CheckSmatch                   WARNING   282.02 seconds
bluezmakeextell               PASS      97.73 seconds
IncrementalBuild              PENDING   0.23 seconds
ScanBuild                     PASS      858.21 seconds

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
src/shared/bap.c:296:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:296:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:296:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2174171267534189983==--
