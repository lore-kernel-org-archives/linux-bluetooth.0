Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C0822B5AD
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537449; cv=none; b=Da0aU4RnexL631X7b2ATZCJkXS/luGiVZTfX3ki6AHOcYxzuT+aMbNntX5MVUhtrZQWNVPECNUrpi2UPfIvnUpHJV431T9wmzmQ77JLtimQftPCP0uXic/No46ULQ2NXnR5YmMOAsXN3Lu4ew0RHnw5/adrs9iK83sO0+6H75F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537449; c=relaxed/simple;
	bh=YATPyuO6KjnErd+tJQAXnTDahExCphgAnVRRB6k9JS0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Sm9Ogaehs0k4zc/3PZLrEq4j1gstplHl01TMKq58ACUchL+CmpfO7+cqy3laubRZ+TXxkPZ2+CfJMU5HnBoh/BiQf8BXnjjec/MJlizHkxxSTs3HDjA8NWd/tWzPQW3925kqQwTtdHkR2H+LgM+kp1mFQBE2RgXz49vBakSKCl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dohm7gHT; arc=none smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dohm7gHT"
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-894774491deso93677186d6.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769537447; x=1770142247; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J/ZFWjshkDcosmzLpwzm28UjmBtpEyj6T6pyTSjzqG0=;
        b=Dohm7gHTAm8VTlEE5+c39sbeehf9aBbuhxipfpkc6IX98+8TACjm4P3Ds7h4dH/G0f
         oXgHYFILahtN4aYbJTvOzOoc++bHSVjd9P+Y0FIfALgY0pMn7rQH0NeP9hkxQ1Tnk3ZE
         mvtDqHJlgX+HoGAif0Ler8dYbZsYL+mCTEWlCTCO0/jYIwcZeEnpdaz5k13YgLUrv1Je
         Hed6QJVULGvUrgwMlCjl7OeQ469aIIki4SOuILcVmXPnt+0R9ZTufXOb05f2MW8tMzP1
         foLnB3xC5mWLSp5gEadwsWzGBQHDbOFT5e7o81tScfqIZtkdL9RH3RsuNOGgUcK0fvA1
         inDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769537447; x=1770142247;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/ZFWjshkDcosmzLpwzm28UjmBtpEyj6T6pyTSjzqG0=;
        b=hx8prWCzQwrhXcKUNGM8JEigil3aaowz13CSnS0s1D9m8SsgToXQNk7UduLOQOkTFM
         Yy9Xzv6P4hzwdFjHxX3q/ievoGGbI2bCGYdtWY6spJJmYYSoOw920sc5/Uw74vwRnOmk
         XzgiTjmxnbXL874eWZgpp0e9TAzwHFrGINomOqYEL7erYCsgCyH22Trve/HbEA6P7J70
         q9hFdYUyfu/yjRhOEdROnFtApnrDimPtzCUppNkWAsWqpWdUy32Q7g2cCFqrDJE3eljT
         BFK2Euw9lF19AXQ9iWe9cm6kwojIFkl2kZKBhqrYrSZrk01C6en5rUqwPwZ6vuYtbXA+
         0www==
X-Gm-Message-State: AOJu0YySDOyJnlL/Y0qjgw1O4UWbFoPgrogi6t+GihcxvynTc2k4HbvL
	1I7u7FHOByRa8NdTPQoSZrUJOkgBDCYfZLto5yQv1GqGGx/+vVU9Qmrk6IfE60Lj
X-Gm-Gg: AZuq6aJTl2X9esDs64V1qPmKVZKo0Q4IqKfcBMUr3Y8titWEgIidkHzXsNN64l6sjCH
	lC24rsaH/RacopvLrxOZ6DfbVAYmhpoMKlbOEvzRJ+jYrQpeG3MuU5lGjc8yZEImV0wMaxQXNO+
	UXe2LCMwmjvUU2Bb6XRMwWgKR/b4BRUBcbI2HnWKl0GHl1guz3AfZ8D7wbM0PHcyBWAXlRj0B49
	V/WqmGEuKioXxOvFHOxxqL+kVLrsBQOQygSpMNpBi3ZwnVbLFk2ZGE+zJLi9YVexH/CnjHKqJAM
	VGd9S5ry02X1M0E5rKqbnJlQT4YClEZS4FGsfmjpvL4XszBm8SVWQ9NLPSwVJ15CM2II++w3kJX
	rkXEJ0nDMsogfXP4QBBQw17p/CzxGkJVi5wDM+Lo8OYhf2L5UBJ0F8co6KC7KrfpgbFvmkby+96
	+1hkchEnqM1+n2OZ2ce6c=
X-Received: by 2002:a05:6214:b6c:b0:894:6127:9014 with SMTP id 6a1803df08f44-894cc846153mr38659336d6.31.1769537447177;
        Tue, 27 Jan 2026 10:10:47 -0800 (PST)
Received: from [172.17.0.2] ([135.232.208.113])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d3740c86sm1710846d6.34.2026.01.27.10.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:10:46 -0800 (PST)
Message-ID: <6978ffa6.050a0220.172045.60ba@mx.google.com>
Date: Tue, 27 Jan 2026 10:10:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8534179026535862466=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] doc/qualification: Add PICS and howto for the SPP qualification
In-Reply-To: <20260127171455.151496-1-frederic.danis@collabora.com>
References: <20260127171455.151496-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8534179026535862466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1047699

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.41 seconds
BuildEll                      PASS      19.88 seconds
BluezMake                     PASS      593.69 seconds
MakeCheck                     PASS      18.28 seconds
MakeDistcheck                 PASS      231.10 seconds
CheckValgrind                 PASS      274.44 seconds
CheckSmatch                   PASS      327.54 seconds
bluezmakeextell               PASS      165.08 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      917.76 seconds

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



---
Regards,
Linux Bluetooth


--===============8534179026535862466==--
