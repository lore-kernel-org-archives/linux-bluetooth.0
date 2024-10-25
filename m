Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6AE217F30
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 22:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895331; cv=none; b=bgXRkcH2Hjqg5+KNL42PFNETt06XeUgE2AXZmew76OV31H1n1XUrOVYh7XdzGsZEViPsEVjVVf+s3TImvJnTpj47vfwoNIZN3eheSiq5z2uRFcl1/ED4AzIpgmCQO97r9ngoDshVG8WlDK3vSYcL5LvxKNctmnJtRzN0FBJ9p5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895331; c=relaxed/simple;
	bh=xPHG6XzcxpORFyqN4b4UBQNUht9W8LkHM3QB4NYT1dg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gW78KQC+v31IUyM2ZeTVHfSy10ae3N9NF1PretP13wT8GRwzfFgI1BuTQRXg8LAtG6Fuv0KVl46ybJ/GzQ9PKC5Mnw63NH1fPsYJVZVFRsYyVaMyCpTQ3Jp1Trf24X0lOFb0/XjQkxlIueGBeWR/YvTKWwDIqT3VQOO3DL2FY5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWPaK6st; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWPaK6st"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4a74a77878dso773611137.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 15:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729895328; x=1730500128; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gdyhG8D44EpPSIpP3iJk+TiHNUd2vRWF8ZpdskP6xNE=;
        b=hWPaK6stJZRmC6DciiMDfjalwohWNeL0aIJBhFlpZPpdOxrwmpt7cKhevNFjT4kx8z
         omvAYbCPAaqOeWOl1ljGKcc0Gpsssqipugks11hOj5Jv2e4+dCys4rOAHG8LLh1kRLJi
         I2XoTAaJhkKc4Kbpel1Q1BacI5jmGYmCn1CGP+JegKneaj4/a0jDHu6voFgF0AbElM8t
         48di+7CyxpR963BJ9G5klvw/nljUyy32wUc6yK3ACFRh/g16whDXQK9xkzdjZqQKGbRx
         FPyr+V7PdSsByXphAkxIYRM3YaNjOghQGJCoHIdYePYFLQ26JkfCrAyevnLP4V9/h+El
         Y4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729895328; x=1730500128;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gdyhG8D44EpPSIpP3iJk+TiHNUd2vRWF8ZpdskP6xNE=;
        b=ZXsp0DPDKpC6Gr6GJzTXk/+HFOkj/+5tO7OoF2QjpxUyodv9YpEFDcSrH1r35BV0IE
         40Na4DakxpTttZQD4BFI5i9cUNdWrFYjRtaydfva45lGIShiFPoepnr03ZzDE6/Z4+i6
         Fhbug5PWgJ2DpOo2zYf+RrJ5v0yARmby2Y2ZUU5AUnFV/XRULGIzt/tED0JPhC3dyq6x
         8L5YsRlu88u5n7mjpPeE+Y2RJ95LsNeuuRwEwzQSiDcq2PbylsXVi4A/a1/0OpjS6p4M
         3covwu88fRWH08/Lk/h0OMO1KHppUHMHfRE86puxjF9UGl3EinTWxg+5NshuPPhYKnnV
         ADpQ==
X-Gm-Message-State: AOJu0YzNoxUqe79ItTVEIvC5x4HTVyqKWQSZBRVaRZXQX8A0o9iQz8o2
	cLr44yCuvRY4RsupjvMrENBj/29qWYLus2aRGI4e+S4HQa7R0A02pMitjA==
X-Google-Smtp-Source: AGHT+IEvZ4yAt+m3YvE2mHQsf5z7PXmsfY8OQcvsaw3PLj857FAAo1cIAOF+XnexCrKTfjXcYFNEyA==
X-Received: by 2002:a05:6102:4189:b0:4a7:4900:4b48 with SMTP id ada2fe7eead31-4a8cfd3d7fdmr948145137.18.1729895328024;
        Fri, 25 Oct 2024 15:28:48 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.46.149])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-461357007d4sm8333361cf.88.2024.10.25.15.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 15:28:47 -0700 (PDT)
Message-ID: <671c1b9f.c80a0220.1d3de3.3841@mx.google.com>
Date: Fri, 25 Oct 2024 15:28:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7029049843431922529=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, daniel.beer@igorinstitute.com
Subject: RE: [BlueZ,1/2] sink: clean up outstanding AVDTP requests if the stream goes away.
In-Reply-To: <20241025202141.158946-1-daniel.beer@igorinstitute.com>
References: <20241025202141.158946-1-daniel.beer@igorinstitute.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7029049843431922529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=903299

---Test result---

Test Summary:
CheckPatch                    PASS      0.91 seconds
GitLint                       FAIL      0.83 seconds
BuildEll                      PASS      25.55 seconds
BluezMake                     PASS      1648.59 seconds
MakeCheck                     PASS      13.47 seconds
MakeDistcheck                 PASS      180.02 seconds
CheckValgrind                 PASS      252.21 seconds
CheckSmatch                   PASS      354.83 seconds
bluezmakeextell               PASS      119.91 seconds
IncrementalBuild              PASS      2958.71 seconds
ScanBuild                     PASS      988.35 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,1/2] sink: clean up outstanding AVDTP requests if the stream goes away.

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T3 Title has trailing punctuation (.): "[BlueZ,1/2] sink: clean up outstanding AVDTP requests if the stream goes away."
[BlueZ,2/2] source: clean up outstanding AVDTP requests if the stream goes away.

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T3 Title has trailing punctuation (.): "[BlueZ,2/2] source: clean up outstanding AVDTP requests if the stream goes away."


---
Regards,
Linux Bluetooth


--===============7029049843431922529==--
