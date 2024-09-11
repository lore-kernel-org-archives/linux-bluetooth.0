Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14BC42A94
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Sep 2024 17:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726074487; cv=none; b=OyZ3taEb3lyiKM0QTQ3T1JqjZfUohDFmA1QdSFh7w4byeFOHQXicJTSdar5JrrQIJtklTwci2kdOsQxNWczYXFQb4SBuCFbpcudrzFrpWrmIcyWStUOGUH26KD0sLxqICit1hDd58kVUuJpFMWT5jlmJhPdyqCM5KyPWASKaXZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726074487; c=relaxed/simple;
	bh=YuchDm3FMODUYJuD/oA1U6Yme9HEwVH5T25OJmb9eeo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=l/3jNMGnRsV24LZmS0FDZYpiL/1bFkC9tKMWlHO99HCL79mD/S7fCdiGx+EZ9gn9DFOHyRO3zcIkH34LFEdz1HnVMyFNs6MfLTVtoNimdsZc3zQewOI1Eg9IyUvt6kwtMj3uxDm1lOv3fO1osHexCMq0q72Z/QD/d57HzD1d2Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOie1jwC; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOie1jwC"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a9acc6f22dso5852285a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Sep 2024 10:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726074484; x=1726679284; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F6Fzf4WHTG4DY45ToW9BKoVMh9qG2JYGY51BR8t1P+o=;
        b=IOie1jwCmwM3Asxwlc9gpemAxyJh1KoOd55Z01j8rrdhyJKlFZlB16XYbx/ymC7r4A
         8aWQjSMVBFQ0OochsVpVZe6xEQeWzPiAGX7bi2KXppxM5OZBusFlgicY+DtdcZLjGNja
         IziLshd8GQ4ijpjWVMJnQ2B9OIkhfJwiXXmDCdquuCux1wh87Sk2zq0Bv8eM1bUWj/U8
         sbuhkoS9X+p/lYGApMTRO6OwLAmZV4EzBPjN1BpkJfYLyUnKyRAcdpU+QOhv3JevpJh5
         6VVnmEz0XQJeo+GU/hZh+Y74RwLIvfWFiTwJtncB0lUviyK/q8NnIcb56xJYYxlB2met
         2wwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726074484; x=1726679284;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F6Fzf4WHTG4DY45ToW9BKoVMh9qG2JYGY51BR8t1P+o=;
        b=xJ9WzldGAYgjJjYjyYa5NuehnAbVq3etDyzvEZMbd1dVCdOLqQrl02dbUCWYsuZp0a
         0mCt7AV8LvFmJ7A025nNB/5IzcFH7oL4pxLPAmYgA0V3l9UZZpAkewFKpheVLlpj+vcf
         vjATLPz4kmsOa9v9CMth2S6zgjy2xM3/FKsTt3bAIAfrIEYEj0jQtUqRhf0eczhJDPtt
         ASwSPvZXV9j80qDV13icaoUuZBz2y74sDk7tEZE6mYe1CpAjv//MeR6kLFCQ8DDuVByz
         C+OYMu1C0imEWp6yW7xEtIL9Dn3OQcOPxG6+KhlKuMb5bmvS61XKHRUsCkMgBqK+GXcL
         yxKA==
X-Gm-Message-State: AOJu0Yx5StsAf7pwELe3m5uCm2X4tIVCwQFuE1YrwO495F42En8vqgl3
	pE3lR9pm/v/XkcEp21vp2SCFHtYJJwJ1L9BOt2Pu0jeB9Rfbn8zEPzL9+A==
X-Google-Smtp-Source: AGHT+IEg/OWOuNO4KtyllHlt/x3IxilZwD7tDk4+K47fCVHczuzyA7+zBjUTyh9LxFDXU8n+K3+JxQ==
X-Received: by 2002:a05:620a:2a12:b0:7a9:bd93:ac3a with SMTP id af79cd13be357-7a9e5f02dc2mr9638685a.14.1726074484427;
        Wed, 11 Sep 2024 10:08:04 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.79.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7a1dabcsm441011585a.124.2024.09.11.10.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 10:08:03 -0700 (PDT)
Message-ID: <66e1ce73.370a0220.17e41c.124e@mx.google.com>
Date: Wed, 11 Sep 2024 10:08:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6954341980659418452=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vibhavp@gmail.com
Subject: RE: adapter: Add (readwrite) Connectable property.
In-Reply-To: <20240911145114.103340-2-vibhavp@gmail.com>
References: <20240911145114.103340-2-vibhavp@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6954341980659418452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=889389

---Test result---

Test Summary:
CheckPatch                    PASS      0.86 seconds
GitLint                       FAIL      1.06 seconds
BuildEll                      PASS      25.37 seconds
BluezMake                     PASS      1694.59 seconds
MakeCheck                     PASS      12.73 seconds
MakeDistcheck                 FAIL      67.33 seconds
CheckValgrind                 PASS      255.06 seconds
CheckSmatch                   PASS      361.85 seconds
bluezmakeextell               PASS      121.00 seconds
IncrementalBuild              PASS      3030.42 seconds
ScanBuild                     PASS      1013.97 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,1/2] adapter: Add support for the Connectable property.

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T3 Title has trailing punctuation (.): "[BlueZ,1/2] adapter: Add support for the Connectable property."
[BlueZ,2/2] org.bluez.Adapter: Add documentation for the Connectable property.

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T3 Title has trailing punctuation (.): "[BlueZ,2/2] org.bluez.Adapter: Add documentation for the Connectable property."
##############################
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

Package cups was not found in the pkg-config search path.
Perhaps you should add the directory containing `cups.pc'
to the PKG_CONFIG_PATH environment variable
No package 'cups' found
../../mesh/mesh-config-json.c:31:10: fatal error: mesh/missing.h: No such file or directory
   31 | #include "mesh/missing.h"
      |          ^~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [Makefile:7857: mesh/mesh-config-json.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile:4681: all] Error 2
make: *** [Makefile:12233: distcheck] Error 1


---
Regards,
Linux Bluetooth


--===============6954341980659418452==--
