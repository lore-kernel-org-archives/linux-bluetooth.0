Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C723B7A8
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773232481; cv=none; b=upwNXSxz4AqNcut31jTjWX7OmnMrCHZPZHuUnKPV5gzD0A1FXqBhjSKDB9N2THfcKIpPneNn+LQc35g/nDrxxld539kfHsUIP0711wwudf/wEAWUnf/WPpNghuCanh1jTiraR0qtgQif02JsIfVRoio32n8S041ZCcoX8qugjXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773232481; c=relaxed/simple;
	bh=SwaCxucgjYGkjtv4htq6rjY/UiC5xrRdPicms3oku7U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lQEkP/bZSwqRMxbvSpr/1YT8L3zk74+jD6Mp8e+vDWfcR6/3GESYEPiQY+Ff2FlNXZ0yOpPmwRnZAPuYw9OxUM1Cv7NC4hJOyWAfGDisi7QxqMpzAjfJknZQWBDMdAnBFn56oKyoJNjJ/G9/aeNxBFGj3VrbKjAm3TqJZwkd7LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5VLTw2n; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5VLTw2n"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cbc593a67aso1340860185a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 05:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773232478; x=1773837278; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=11fY0q69ksUnmzK+O+9ndIcbCjjIzsa3uWsgRypI95g=;
        b=d5VLTw2n/PsjQzWXfVbIm77zxXgQxvVKGaxFq3X69CWJ/bmVkrFo+ToBVDEs1e/yjO
         rx5vIRqTDZvvzga2kk0J6BKL5orILfi8efJf4FQGridGcLaY2DHKT54k9ZeHJ6C2rCOc
         8ZCy6eo9Oy0Ms35VeDwWLlTQTM0sYqDaxzudDwWFz90VRmncEGrzLaCffPMizwkiIZ5p
         0Zt6D5l5SuCZDYDayTfvEhu+p4X0Yeopgq0pav5a+Fy5PpiWUfwekCIg3CMJiCwLRh4z
         LieX/TUB/hBuAJoGw/Lfo4vl5yVh+gg7p9aKoDgx7f4ZrzUGocppR60G76/3VF7xiK+M
         Kkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773232478; x=1773837278;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11fY0q69ksUnmzK+O+9ndIcbCjjIzsa3uWsgRypI95g=;
        b=XeewojrxhXvurYjFpLtWV+xr/k/p6VLYJZlEFRsziWy0g9OwFRKZ5em4UCWTozVnEG
         Cn42lAKJwVAH4rU4j72h9L7IbxqvIzDK1R/1dMEVRQyLCv63Ig20Npg1SzxWOTC51oUU
         0p6rahqCY3Bno16gYOfI14QEIHAxmFvswTOCtuJsNk7/iUj5oYO8q+vjmTDVzy6kg5OV
         bgcjNx7DCaJ6fvp4HCXqYGGh0Ef1FoJoNSB4Y52vaTDMeeR1xlDqcSr3l4bpvI0CCq0+
         18Rp1Swe2FnRW+i7hlGkgA2PfpPq9fmXji4Jy5bSLqjX8WF5ZK+bHhNcahSxUPvXuc1A
         bt9w==
X-Gm-Message-State: AOJu0Yz42Dt5qPT2s+VrudWuBX1NNv5Ii2i8Jf5TX/pa4G2qZOkN0lOr
	/eck6oQ8qz4FKxaaqXZHQqRXWsecLQPgZ1UQtL2O1jgH9NY1CsxPABfP3e0zow==
X-Gm-Gg: ATEYQzxnom+rJ+CSQA02iue1D7rGn9GdBY9y5wupbKG7iWGU9EEXnlK9nwynFkuaXBe
	5TRIHglPAgtRx1t9FJ55YzBS6k7rs+xrOazAKFJZ3ePK1mPaWw9pkuvBolRHFm3xonoIB2DHym/
	f9oO9Og3STKxZ9GJ9zZjhnmAQbq2QUXp2ibesxChob0RP7jj8257IZGkkQyrHr6o8yNlwUT/3XK
	fIq8aN6dUOuyfo9LieGrUlTYsM3vcRGoDKuUfe3QQqgc6i9EogrGk/+b0DHxwjGyTooTayC+aOH
	G4l5VgPFgB3TmUYBJY3Ic68r3Xoe3ukOmEG/LIn2tWNkfNOiK0Ljn32JEp40DbkzQQVFXPzOj1x
	DHuUtfiD/LfV7NnTqXmAThFFmtrCh0dPva4htp3m/Ixpx365t/ucc7deJTurGfSTR7NRKPf4r4r
	f3WcslzXFhx6u+3N4NPCC1DPhh0h4=
X-Received: by 2002:a05:620a:198a:b0:8cd:9938:9810 with SMTP id af79cd13be357-8cda1954688mr287248885a.25.1773232478479;
        Wed, 11 Mar 2026 05:34:38 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.91.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1eab31dsm125688185a.0.2026.03.11.05.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 05:34:38 -0700 (PDT)
Message-ID: <69b1615e.050a0220.e403c.cca6@mx.google.com>
Date: Wed, 11 Mar 2026 05:34:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4133029954781524542=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: tools/btmgmt: Fix btmgmt --help hanging
In-Reply-To: <20260311111540.2170373-2-hadess@hadess.net>
References: <20260311111540.2170373-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4133029954781524542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1064985

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.44 seconds
BuildEll                      PASS      18.09 seconds
BluezMake                     PASS      616.44 seconds
MakeCheck                     PASS      17.79 seconds
MakeDistcheck                 PASS      224.98 seconds
CheckValgrind                 PASS      279.97 seconds
CheckSmatch                   PASS      315.68 seconds
bluezmakeextell               PASS      168.03 seconds
IncrementalBuild              PENDING   0.39 seconds
ScanBuild                     PASS      932.64 seconds

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



https://github.com/bluez/bluez/pull/1955/checks

---
Regards,
Linux Bluetooth


--===============4133029954781524542==--
