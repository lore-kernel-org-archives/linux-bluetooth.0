Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FF35803AC
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789064826; cv=none; b=P3W5/hzxjTN8UIrLitdOl8O3r28eKtfVrtG9Lp0JcnYBMLJBpLF63erCBOC9xjBZCFECSimtUWM1VS4mZTYq20oJ+hDEot2Lwr/Sv0/GzUiUl+g6ZTTo90e2fYfg/jIVLzNIzzB6IKGit5w3hJRRojps9obwzMVmFaAD2mD30kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789064826; c=relaxed/simple;
	bh=ZrH2sHilRdj8lo0BuuuC0ZQrT/Wk1QRmDYrB3LW4+78=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VYuJoI5t5gBrtQFfZNAlqbFBbhRbN4dGiQLleE7DA7P+byZ0K8bP7ivN6k1+KuldyC32bV32dk8EcYLP7MbKKB3BoqFn386u8UHBN4TTkX+aN9bvSx6pWoOQz3aN1gs+PNTqxx/pBF+YHpiClucjD4xzPYmiJjREyzWVXqLrA8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftPDBSKe; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftPDBSKe"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939109fafd7so144889985a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789064813; x=1789669613; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gRuZ8O5lHqfjRduF03dxtbN2kW/HOtw5VBVN4Iy2wJo=;
        b=ftPDBSKezCDg/eMkR5MGELn8axbRaE9O6o0edU5o1hvQjqCfMB4A0ifBj8b6vQiDk4
         bWN7xnBkEUl17hZtXSvYx08cZPnnvmEULjFj573uTonwhTjvA/MMKaa6hn9fXMuDXZPU
         4cRI25XWc2WDfCXLFsouaBqX6/QMQt3ENFIMRPOc6AqgSEOL1BXbt/q5w0H5IRwpmchH
         uUiD5ZArNofo6JYX1p8FnMGMaw7YvJNdgSnSe0tAkhqyZDDR72LCQ1ehzh6gOaB+WuWa
         Ldk681katDQTzjZGFH2Oq0WSG5ogktHGdct79IyUwGdghxKW77x9j63Fv4SWBcwwb8FH
         OAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789064813; x=1789669613;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gRuZ8O5lHqfjRduF03dxtbN2kW/HOtw5VBVN4Iy2wJo=;
        b=c4Z91MD+UGcZaGS0ugq4jNGGx/aZy5x0GqWGJzqc2qaz9GFKoIfagLzv9zM1lPxTy2
         pknlreRvD+UlIJLF3KMYoq1TCihk+nAtuwUIF1egjqpoJ7lEuUmmnXMai6uHx2yFsD6r
         ezWw97Mo4gqzDXNEHsRTNUAuUZ3eWLubVa+a4NONYzhg34rtn0uUjF3Il+iS/45NAoXb
         JLR50vvgNfmv6lWQIAsTjv+6bsRhffKDuetYM3xV29ioutkJ0U/pvoRulV4WWr7JfVeQ
         fcU4aF7E3XQKWNicP9IaPqU6XKUh/FzbbVdsMUBcS9psNweadyYSwngY/scKp9JETBgx
         07Qg==
X-Gm-Message-State: AFuF++nZL5XgVgcODTNwJwDHwmCJSOUE60T8gcTBYGaciJRv2piyflKk
	4bj4Wtk6wOBT+S0AH4eN6HknhiaDzm5DTXz2xcD7/AXLgcSPNU3Gtt6e5GxSUw==
X-Gm-Gg: AYBFou1za9ijWflfpHgAIym4hhV5Z6ZNp9NocnBW1OzBsS684h/5odom0EKssF4Rl24
	XQ0FgXn1UggCYjDxusGn5A44dm0hU/1yqvNhrm78ALa2ZUzjVOZ4v0I0HkJSIDJ7ZHKdV3GeWqZ
	9LBmzzF8ZfhR0aAXVBpH3hDkbHuGWkQGIGSRxYjlvGyBjFAMZcnTFvh1tdctQyCQS9m8Jz1yga6
	XNoXpOrp59FBUrhGbtUG5Bdnmhkllpe6WjAtd/ao/kRTF0rZ6mwzcYWUXOpIYCe+XDyXAFvQswb
	JBHRkA+WQ9d6AQPrSe+mGSWYuvhBJu/s0Y57R72gSdKVEYcGnw/qoDLRouWzHXiBIsk1dCeQTRh
	QaTRNUX0JaBKSqGKeclOyZZzI5jtzhwclubuvodmY727zu6ZONReiiUmO1l8AZf6r2OfniQOokg
	h/jLisvxnBQIdUvjLRQ0vBof3rYwVz5S5jB7EJoLnOoe7d4VSzKKfmDw530NpdM6RF0ucI+ieI7
	0Ubmw==
X-Received: by 2002:a05:620a:1789:b0:937:2c3a:4b70 with SMTP id af79cd13be357-939ea17763amr6155685a.32.1789064813234;
        Thu, 10 Sep 2026 11:26:53 -0700 (PDT)
Received: from [172.17.0.2] ([20.62.207.247])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e8047a4dsm44597985a.23.2026.09.10.11.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:26:52 -0700 (PDT)
Message-ID: <6aa2f66c.84cfb2d3.30b313.0aa6@mx.google.com>
Date: Thu, 10 Sep 2026 11:26:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5362804526281203098=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ] bluetooth.service: Fix ConfigurationDirectory warning
In-Reply-To: <20260820094503.1779779-1-hadess@hadess.net>
References: <20260820094503.1779779-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5362804526281203098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1148981/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.43 seconds
GitLint                       FAIL      0.33 seconds
BuildEll                      PASS      20.42 seconds
BluezMake                     PASS      389.23 seconds
CheckSmatch                   PASS      297.73 seconds
bluezmakeextell               PASS      94.12 seconds
IncrementalBuild              PASS      376.80 seconds
ScanBuild                     PASS      1131.09 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] bluetooth.service: Fix ConfigurationDirectory warning
WARNING:COMMIT_LOG_LONG_LINE: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#52: 
systemd[8067]: ConfigurationDirectory 'bluetooth' already exists but the mode is different. (File system: 755 ConfigurationDirectoryMode: 555)

/github/workspace/src/patch/14758855.patch total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14758855.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ] bluetooth.service: Fix ConfigurationDirectory warning

5: B1 Line exceeds max length (142>80): "systemd[8067]: ConfigurationDirectory 'bluetooth' already exists but the mode is different. (File system: 755 ConfigurationDirectoryMode: 555)"


https://github.com/bluez/bluez/pull/2511

---
Regards,
Linux Bluetooth


--===============5362804526281203098==--
