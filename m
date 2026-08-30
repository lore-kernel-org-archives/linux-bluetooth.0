Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C350125392A
	for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 01:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788053431; cv=none; b=EuyrC1e8delGq2rIh2jmvRG//EApW6XvLuZ5jDYEdW8dBUUFGeF47TtocNBG9V7B8Td5MX/p1SUKQiUspD3goy2VWSEbvNPVjCvuA/mB/H5srZAQ91sfSACnaZyad2T5fv58zGzBgX47GeKIC+mJaYlRP7x5/Hxj4mHFSQGnr8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788053431; c=relaxed/simple;
	bh=qDtj8gIVBh2My64M15gdmMDGqMZsnSqaI0xK/BPuwAw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=B1v9pJ3JLFL2kJDUuvObsvH81D84lWzjMLnao2CdLZ++7baQs3m1npV9deAsB546ULos0G8+y5eJjd6tam2E01wisAe15/NFUaALrVaAFIypJFl83wp8PYDmbKSudbjO+NLbCxbYoLABr+au7zLQpv9Bx1WoB5SCCuuqA7zjVk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGaxQAV6; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGaxQAV6"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6a168dc590cso718859eaf.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Aug 2026 18:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788053426; x=1788658226; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UceV9K4Wht91TIVonAqs8FxegCm4t28+T03Br6cuURg=;
        b=FGaxQAV6vJ3UrAG9nQX9DgVSOIKye/bY8Xfk9qnxzEgID7phokueLcKMwe58UNnrjb
         reKP+p3+/UZYMoLoWc/8DA8G47Lk5vidax+kbTo45RnfrMWDFWAqOUgCTjzp/wYAS3uz
         0pAsBBsmjgspRbN9/lBVeLjO2d89XzN90lGzbyuiu6Kpz1YH99QrNp5AJKCAUvbh+mRE
         0TM8RBGbo5jkL6PlCAvwOn6IiP9C80syB12qT1aJMRn7m/6W2T6OVNnJex2WQfLCcGVS
         rnEf9iyq0QOAaW1LBXe3XlFxgt7Hl2Xjuh0b9Lmeaa4PO16WmYsg9qmWd5sfRoddLl5q
         DMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788053426; x=1788658226;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UceV9K4Wht91TIVonAqs8FxegCm4t28+T03Br6cuURg=;
        b=edtTQR4d9qp3lHnJ+OGsgmAejGaFs1xsPJVDBpK/AURmgRmmQXqMJtyJZHpWNUFJis
         cp2o6pN7PYvvXmoyQyzWAm6Rx4aFaNcG+lynz6uWZteox5RfZOdq2CzRIkqF7GywGH9p
         i82WLJL/Cgn8aJSAZ2MaclfZBjwe54o+WEJOzHqvZY/aU1JdfME9gxQvZFBGDCKNiJe+
         w558V1AjSErGTtCM9zdK8p+0zE5MHRLOR/wjq7dboQO+OBAOzW8W11XTtiiC068VQWII
         F291okqbPuc51OoKz/cAsKcq2ORT4hv0rmxl8+v8My8Ekhhnq9mBfoO+x2fg2/NeE8vU
         s5uA==
X-Gm-Message-State: AFuF++nvI/6ZCsdjBGPYSlNjjg62wrmTJTu0BTj914HCtcP168GkSbX9
	m6DcOqTPBIUW67KINayZWlm/bntFNFYEqLaSuCadsGQRaoUE7q6dUsqvy52xTg==
X-Gm-Gg: AR+sD12WH28wsZJt+20P+qYOYEWW9Ix1jCsAhirBR/zh5ZaFrNBhUbUprkc26n6lDb3
	/5FMhnrOyaP8uy2kTYCz72607hau6Tt3HjwODrnpxvYrMwKRvU51uWrFcfdr0r3Z0UKuWSAuWwZ
	o1GXX7X9N0d2Ex0b5CfYjRFtExbz9G27phIcN8Wb76+JKBV5XrDm2YwO+MM+A67XOu6sdqyIWI1
	541M4EecEblLnxkCIVKjGUbBi7+cFhxzVeKuJI1JiN/nheFRQEAQqlETtXeryVKOXsB0TPl9Xc1
	WjMydBC8vCVU7fJKz7bTND7gEwJZU8GazN6c6odv/KPNUu4FlYLIKN0IMSMwr1pwZ7yV0sgM2/9
	t3sMrJrACg4ayeKIAXWnf6flDTz1rQctdtv9NL1dqjvD04HfEAPNJhVXtkc6Z5hkqlC9RaGqnoA
	E6WX3rADmGvn3OHBpIMM6AXYrjF+5Zt0l+fZPK/+crktWJq5Rpsde8HO5uIBoP4ZVbqfw=
X-Received: by 2002:a05:6820:6ae5:b0:6b1:3427:698b with SMTP id 006d021491bc7-6b1c66d5a0emr16866526eaf.18.1788053425674;
        Sat, 29 Aug 2026 18:30:25 -0700 (PDT)
Received: from [172.17.0.2] ([20.12.182.162])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b1ce0ea088sm5709385eaf.2.2026.08.29.18.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 18:30:23 -0700 (PDT)
Message-ID: <6a9387af.ad4f9334.35a8c6.b70a@mx.google.com>
Date: Sat, 29 Aug 2026 18:30:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2542736793325275663=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/2] emulator: bthost: don't crash on ecred_conn_req with too many scid
In-Reply-To: <fab8ccab695b50d726bdc00423d8ca915edcf11e.1788043574.git.pav@iki.fi>
References: <fab8ccab695b50d726bdc00423d8ca915edcf11e.1788043574.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2542736793325275663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1153725

---Test result---

Test Summary:
CheckPatch                    PASS      0.85 seconds
GitLint                       FAIL      0.53 seconds
BuildEll                      PASS      18.32 seconds
BluezMake                     PASS      631.34 seconds
CheckSmatch                   WARNING   272.55 seconds
bluezmakeextell               PASS      93.87 seconds
IncrementalBuild              PASS      654.04 seconds
ScanBuild                     PASS      871.76 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,2/2] tools/l2cap-tester: add test for too many ECRED deferred sockets

12: B2 Line has trailing whitespace: "    "
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/bthost.c:703:28: warning: Variable length array is used.emulator/bthost.c:704:32: warning: Variable length array is used.emulator/bthost.c:944:28: warning: Variable length array is used.emulator/bthost.c:978:28: warning: Variable length array is used.emulator/bthost.c:979:32: warning: Variable length array is used.


https://github.com/bluez/bluez/pull/2455

---
Regards,
Linux Bluetooth


--===============2542736793325275663==--
