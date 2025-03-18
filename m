Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DA520CCF0
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307779; cv=none; b=jYMHsqMVqG5cuVC/Z00Jc8l5ieDCsFlhfYUIflBrSnD17vYZ5eg0h3Zt4wqC6KvSPuhnqgM5GpZxEYEGx4i+qE5USAkVMH7AIaA/RHD/GboNe3w01ercTwwJ+E9s8Sb0KgUTTewkSw+hhJZ/zvThoqP7rTdpis1QIkNI1J9IQbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307779; c=relaxed/simple;
	bh=YUJKXSivj4KD15qgwS1WlX8AqJoZtTAUhnNMA/laj6k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=vDLqrx68V96vKsD9i6+T+PH2GtSalt7FOxW4HRJNI2iYqJzcS04+B5ozmENKpM36TRC+HKHUr9QXc1NlnIV4CCStmHXuY0OrGmTt4cqiB9mYI2BRSOtM4/WXgJIO3yRinJfRiaQXh6VHIuTrFW05Zo6fH+4RE3DrM8Qh2m0CIyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfsEH6je; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfsEH6je"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6dd01781b56so74760376d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 07:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742307776; x=1742912576; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b+5mCcqC0Q3d5hA+JhNYfqrELfX4YyxqYYRXZWza37U=;
        b=VfsEH6jeM+661iQVFzDFd10qlrVmGU9yejMZJnj3yVCmVjQEXvTlK9rLNMiwaaIQi9
         nXaZYQkaSwbqSXqzVuF274RLDGpfn9WfL2yzGdawPGFIGljeCchgkhZZjPmEcYMF6/Ch
         AaJMOXFafyBdJf5BhkWJ/AGhRRZApq5rzNKjxiTFc8qTgWDHeph7o4sAwH0LGhaA9ycV
         RYrH/qqv+BrC0iUwupk96mXc8yls8SJNfq27aAMplpRLehwSZT1hG35kTJoShRfjGhqa
         0FsT0nRNHdr2unrH7Hm3W+wO6bSXXTIgnFjt4w1MvGehTp8SOxHYjHgsxprBeINHvq9r
         rgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742307776; x=1742912576;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+5mCcqC0Q3d5hA+JhNYfqrELfX4YyxqYYRXZWza37U=;
        b=IHPb+DXOCax6s6oYDpMxVHl2jFGfcB+jJq+aRrt31TFxYWFuV7nbzJRcwFHDgCji69
         SeQ+MNjZrApNLEqyJZRPz5C8Tc9n9uNBqVnKy2ZKIHr5ADmwYbxJffccf2bBQTxtQ8pX
         h4BctJdUS1kyhBa6mEcP6kzruwsdjq6GFHz9Ien+pOrBaQN+i+U+qAMZCBK+rX9dmyDb
         43pwlKdZwH35RC0H9hJNRPdGyKfDdnaQMdLb7RUkRyurLwNELvAj9vrrGlsOkiPKAxdF
         p7dSB4gY0X+F3cIb6+BDrbix0UJaHqHrQm03fAjVR83eQnpi3ItbzD59t/quK8ZFRT7F
         LelA==
X-Gm-Message-State: AOJu0YxaFV9LAOvHk5WYUzJsSvb4ctn/USyjpLsmgw5BszNPs0aKy0ez
	oZnbvzo7vIki3bproWbb037q8CkQ0fDh5wURnZ0T8UeRCv2XkYmZ1tIt/Q==
X-Gm-Gg: ASbGncsgvcv8QMG3V+FMbO4uqWqImcEtdEzyRmmnkgkBeXMOmqZh3gvNjegQVURgR91
	EAxBwIbEX9zKdEzkIE6AxrfEKL0gIsTeA6NCqJbMy85oURGUDPCS6Ec47VGr0kT6SZVhPiPfBEr
	pSRRHSmeJVBWX/E8Bg7RzkJGcPv1TMkOdu2CS5u9Tx59fuXzJEyr0bzyQCCYE4a0VoC24GTnjTX
	6V9hGwAZ8gshzHxkYWGGd46zLbIKTisuOCh4I6F1k0P7l7q2fded3tRbzawsfn5rpPUFYZYqfkV
	BYKaX3WR0OoXnyUNpaRwGkcGTzvEHlq59JTUqPG+1FoH4v1uGQ==
X-Google-Smtp-Source: AGHT+IFSipmJZyghdfnHuuEJxdRUQhmdZDXYR9ZR0ZZVBgywxtpDMxkEcCL9gp57XW1IxFBtpBe8/g==
X-Received: by 2002:a05:6214:76c:b0:6e8:f770:5045 with SMTP id 6a1803df08f44-6eaeaaa21edmr280353676d6.28.1742307776431;
        Tue, 18 Mar 2025 07:22:56 -0700 (PDT)
Received: from [172.17.0.2] ([20.39.61.168])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade24ea79sm68354196d6.63.2025.03.18.07.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 07:22:55 -0700 (PDT)
Message-ID: <67d981bf.050a0220.c354f.8f60@mx.google.com>
Date: Tue, 18 Mar 2025 07:22:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3574292127630770272=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: Fix crash in dbus caused by Unicode characters
In-Reply-To: <20250318131431.124750-2-r.smirnov@omp.ru>
References: <20250318131431.124750-2-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3574292127630770272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=945142

---Test result---

Test Summary:
CheckPatch                    PENDING   0.20 seconds
GitLint                       PENDING   0.28 seconds
BuildEll                      PASS      20.76 seconds
BluezMake                     PASS      1687.68 seconds
MakeCheck                     PASS      12.96 seconds
MakeDistcheck                 PASS      161.16 seconds
CheckValgrind                 PASS      219.29 seconds
CheckSmatch                   WARNING   285.71 seconds
bluezmakeextell               PASS      99.79 seconds
IncrementalBuild              PENDING   0.31 seconds
ScanBuild                     PASS      878.14 seconds

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
src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3574292127630770272==--
