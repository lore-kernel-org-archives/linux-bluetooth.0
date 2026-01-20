Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D00D337BAC
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768928350; cv=none; b=Sx2KOunc8OjjPL923s8Fg9Soev4wcaAVZc7mmOjr0xW7UjlNVm341NlVu0tg7KDKCoKsAbiQm6x98rdbMatbQb+kNf9Sw0SGG8mmA5RfKm1F6JYDt0JpfG/3YoTTUEw7VbrKq/GgpwJ2r5apUzoBKOpjk+k109h921LCR0saod4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768928350; c=relaxed/simple;
	bh=QG8od9E4u0pSV6yZRzJ7d9i7oFHecw0D3jyTglZAgwU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gIHg3AlgNjZIJ/fSh4k5PNMnRE8Zx6DnMnpt44jK2L4IsCroH4NxmtEdklKlo0Yh4wgn6yCBU5LWnIkDwoq0pK3fxy2WRiBVW4XYwKZgs2bKIO+vVHv8hi3Xd0Y43WoCZS9IB9fK5M6mSsIVQLd8EO5rPQOezwtbe/Cd9ikxud8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOIGTnGa; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOIGTnGa"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-1233702afd3so7185823c88.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 08:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768928346; x=1769533146; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AVpmgujw6l2yj98k9G40tIe6fzrgFUtOdpHQT7QjBgw=;
        b=UOIGTnGaPX2DEDLk2UA6zQvR7iFbk0K6ImXjxwMCOtDQx7oCfZVp0B/4mr4vkEm4Tz
         ZbHRpaaUEVPp4LX3g0OKFpYU5bArwNLoxdKf+5mrE8mU421ODtNVNKyHMXQSWGnMZrep
         HqbFf01dRuSvV3d5IVROMeROVToB5rtxqKBmfzv+v64fian1DQPoq9j1E9kyKH/MpsW/
         nG9gz/qKtC4Uu/vL+WVodNCXkGYFQR/+Y/VNtevQVFLc9QoWC5t5+laS0/s6GOkkExuD
         rH040vYQOy5jRlR5uG0eXPbGopgw71SkpsOEOudFYpNO4LIiYh5Fis6IUYB5wSJhR+rS
         OYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768928346; x=1769533146;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVpmgujw6l2yj98k9G40tIe6fzrgFUtOdpHQT7QjBgw=;
        b=iv7lIXxXY9IfVWQvTAv/rnjhjnDK+A4f1kt7oWJsIwLbmxe/KrnLe5howy7xi4XGGs
         hIGuulkFxuyZdW3K+HWM+/Fm8cTfrG0XUIvTRieRO+nwr/f4LD4MNINx42vtjeEgpkZq
         79cSSwnjMf6lHvxks42t7E9dvEzf++YTY9F7dRFL0PIV2aiR5Xyv5on1Z9NgcdFff5Q1
         TnyLfvc4iNQVcGSwfzklJjDv1kU5VNkigfi2Cl9TKuNbp5kllcJ+4kx1bNw7yVsFkT8B
         l1MjtuvByAY99Iz/QrlqWbWkhFH+qWQiZN8R3jWbb7y7VOLZ/PMIen3fhdHvwHBXaQ5H
         XOYg==
X-Gm-Message-State: AOJu0YwvUzlRbN5rPUayeaLdKu9EODcspYxnHfhd3Fm4oN4O2LarPZ7C
	Vf1UYo/r+JHT7n7NbWf1JPKyUkDQwd9Hm4Eov3psiq++TvGupQuPuQFLnMz50C7t
X-Gm-Gg: AY/fxX48TydKpqpbpl0bmjlNoKDkULm9+wy+zJTbN4GYtTtbj2UV53OHH3qwaec8S8q
	VuoE84qpA3E5ixAs+6hOPRH7df9sYcK7tjsWFl7LsgixDt2RfGpj5izpYJ+u4wZGQHQAraWOE+9
	ZEvfq5fWxPDFo3Bvjoz7GZ64snLPTqilKp5OKQOvPBcNDm4goCq4DxDra53Zk0CHNuSsbLK4Uij
	tyK3n+bUROu5hjkAm9nBIxMOLxDubmMl29P/16EgeHZ9nQqJWXZnslgKBnjazvMCqu1hBA5APS2
	R52E6QLPDv4AR7H8yOfiICytTx1OJr1M89I9WRDlB3PvarHM/TCO9ReLu1m1xjIk9bhVw5aqyoG
	37rGEl/JLsHOSVpFMHRPUvX44Ws7GFyqbkt5Jpx6oYp7PpoIut++NyKECI6jk1AAk+JP1lLevgD
	I4FcPeC07owfbkNbsPiQ==
X-Received: by 2002:a05:7022:2397:b0:119:e55a:9bf6 with SMTP id a92af1059eb24-1246a9683d2mr1531003c88.18.1768928345550;
        Tue, 20 Jan 2026 08:59:05 -0800 (PST)
Received: from [172.17.0.2] ([20.168.108.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad7201fsm21178536c88.7.2026.01.20.08.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 08:59:04 -0800 (PST)
Message-ID: <696fb458.050a0220.1af079.9a30@mx.google.com>
Date: Tue, 20 Jan 2026 08:59:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8392137331350200262=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: Port text docs to RST
In-Reply-To: <20260120160811.3394320-2-hadess@hadess.net>
References: <20260120160811.3394320-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8392137331350200262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1044766

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.32 seconds
BuildEll                      PASS      17.83 seconds
BluezMake                     PASS      654.90 seconds
MakeCheck                     PASS      17.79 seconds
MakeDistcheck                 FAIL      6.61 seconds
CheckValgrind                 PASS      280.22 seconds
CheckSmatch                   PASS      318.18 seconds
bluezmakeextell               PASS      168.22 seconds
IncrementalBuild              PENDING   0.36 seconds
ScanBuild                     PASS      925.08 seconds

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
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

make[2]: *** No rule to make target 'doc/sap-api.txt', needed by 'distdir-am'.  Stop.
make[1]: *** [Makefile:10870: distdir] Error 2
make: *** [Makefile:10946: dist] Error 2
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8392137331350200262==--
