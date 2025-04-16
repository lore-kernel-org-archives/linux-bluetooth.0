Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ADD221D8B
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 17:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744824994; cv=none; b=BKgimAWPqOGEZeR8O0nBvo+3aJeJDNla4EntntyOODahz9u4DvGOYgFEZf8/OAj6U+uAjJBnFGH8BrOiizjrXYU3QcizAJ6DAgXriNIoQAquvlqL9/OOmTLItNqwvsF4ji6ozHAytR+l/Exw6m+ecq5vqm3+Lunbt1rCYgg/7PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744824994; c=relaxed/simple;
	bh=nIFlj++gx3WYR3bUWXKnpfxCZXQ0tQv/m3EsDloJV5c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JRpF9wHS4pm3OFPON0y6lUIDsT+nxlpOoyBFWLOCwW9EADR4uFcY1psYzqhMHIPk1Ijtq2BOjR98n3twV0+Q3YAuZPWUdHsCL/3P0/aM6pC2RI8f3hWuT28XuBeQMxS9XXpjKhkonVk6OGKF7L5R/b/gR4rZa3BEXfxVs7uqF5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgGFB1fF; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgGFB1fF"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c592764e54so821763485a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 10:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744824991; x=1745429791; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UyWGLhaNmMBLNxV/nB6OvfsuwiqjJYx4HyYIzn6wSHM=;
        b=EgGFB1fFJTxX1dksXEPO6sy1CFeRmeA8xgfZ0yRG1FXxUsMUltOVV5CYW+KrTZTYUq
         AmNXL8Ft3XthRKxP3+I1BA5ORdiu4nP+5ca2zPm7dsM8X6ldzg1/9sJq6aQte/dqf1f0
         oVQ8UKPt6FNuzjR7Ah1Qr7fvlRdmHbjDg73POfGNFpkDS1oSsWTHxgfBPrXYum2xm0q1
         N7cosJDPmI8fKxL6uEXoLCHGjrtEYoNgiahQQn0Kz2CMvPL5X5DqS+YiwIu77M5Mwmi0
         jlgaqg+n2nZvvbAzC34EiDTIOiLr1yV10XJ3jmaNHYtZIZJJd+Fk7X+9H2RQNRm5TIap
         9f8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744824991; x=1745429791;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UyWGLhaNmMBLNxV/nB6OvfsuwiqjJYx4HyYIzn6wSHM=;
        b=cEMXF13OcpsnDTQMZExX9p17CO6RKL7/pzAeWfzW9KyghF8ZLuZYXNZHRMBIw96jxM
         MDNJY6q/6GdxYchJ6zLRGckbDgqmfZckgMPO3ra1me1StCR7HDhkq0uoAUK0nq95r1M+
         BB8/qhGC/oANsxBTseZXYxgsu+/B/MRe7WeiPgsQ2VQZm8ybKA9wwvzqC3zx0vcPdtde
         +hiI3nBIuzM8kVHoSEI2rD7wUM9WGc6waAxkjmWvmV0dsv5ZmUxjf2sx/LJFGl+B8a9d
         Q8lEzbZEXXwUso39KaJvSeJSUeivFJ9o/4lMgIrFUx20HGYRfuWWE2DQgzW6kzC0OwBK
         Pcdg==
X-Gm-Message-State: AOJu0YzfsCHcfZPaucW/s0bhFKGoGoYqWetsYZJTnhwakqnF3Vippyec
	O+AoG2x9qb4OGg/Uhi+vtaCXZroOpKVLlnQ+J+cDKJwMiNjyNRp0mwDrSw==
X-Gm-Gg: ASbGncuY1fjJ0nAUTx3CZ2e+rNPQO2h1D5tnQh7tWxN0157vm6dpcxfxAYIYJ70aRXQ
	Wx/quRkwqry+x6sCar7lUzYnrMmmPMClV+347tG7MPY1WPXkq/4vm0o8Y7GsqIcyUglXU5hYF+C
	XHW4qhJuvVtpPbn5w7OQXk9I9lzGJ7G+bCVY2SDvmUT5KQNn8Tn4M7Kx4nNIuOnrOjOwohkdNy7
	sV8Vlyn1F4FW6r9nZmfGOTcuA9yEVz7ZlGYQyFxCiRFN5+JAxSNEY+wiIc9cRifgJXFe7IaqN4H
	EMh+WHdoLrW96SEbCv3P5/VwKx+JFUhsfbK35O/OWKvxh9Q=
X-Google-Smtp-Source: AGHT+IFmtK9WFhGI6HWEwrATm1bpsZKwRx5mFWGB61JGppnZxYpn+d+FmoZds6mCvx0U5QsjKvu+/A==
X-Received: by 2002:a05:620a:318b:b0:7c5:42c8:ac82 with SMTP id af79cd13be357-7c918feffdemr380653885a.23.1744824991051;
        Wed, 16 Apr 2025 10:36:31 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.77.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a8a0ed44sm1080623485a.106.2025.04.16.10.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 10:36:30 -0700 (PDT)
Message-ID: <67ffea9e.050a0220.12371b.b1f7@mx.google.com>
Date: Wed, 16 Apr 2025 10:36:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6297075234045123675=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v3,1/7] bap: Fix not setting SID for broadcast receiver
In-Reply-To: <20250416160433.1822263-1-luiz.dentz@gmail.com>
References: <20250416160433.1822263-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6297075234045123675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=954078

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      21.79 seconds
BluezMake                     PASS      2550.76 seconds
MakeCheck                     PASS      26.52 seconds
MakeDistcheck                 PASS      204.78 seconds
CheckValgrind                 PASS      271.93 seconds
CheckSmatch                   WARNING   301.07 seconds
bluezmakeextell               PASS      127.49 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      891.94 seconds

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
emulator/btdev.c:453:29: warning: Variable length array is used.emulator/btdev.c:453:29: warning: Variable length array is used.src/shared/bap.c:314:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:314:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:314:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6297075234045123675==--
