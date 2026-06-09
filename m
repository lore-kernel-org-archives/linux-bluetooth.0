Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F4C331EBD
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 19:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781033427; cv=none; b=TLvihksMEAJqiWpw/UjKlT+65zgYH5AUHYuyyHhmJjhnQq6G55/5/dT3G3GlJxqLt1yE8JJZLQbrDTcc8IV0hI2RCvy3lVd637F4P20o6mZyMVEsFuJIPvlrQQJbmOGH4fqKkcGW5OBC6AV3SBexq+XHJs1Up9FPnuBGJFSozmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781033427; c=relaxed/simple;
	bh=dm3G9GRiKlASt96DYe3gLDaYWWKDjsUPtnXIAcGzRkE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=APNbcqPkLHy7UbL9sClooRXzG80IiVA+MAR/gfoDX4yBq5Ufkc1zoQwDslUD6V4fJQt1narQeMmNNyTOBxqvXAmP0KIOfjkvYuuRBDQTHh/0oEKQL6KADDSrDkWPzZVeRSua7pfwTFplUuIAH2kjf0QK9/e8kNcsJV4cQ5ApYiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOXQ5wu3; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOXQ5wu3"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-915c48e6ae2so263242285a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 12:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781033425; x=1781638225; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oCpplwiw50elwFgnVApXoDGm+FGobgQNlb4H9utyyCE=;
        b=gOXQ5wu3nKHulXknLnyxkuJP2E6nv3FdbwcZkfpV1zxsvEY4COmSD1DRVYFJzDbtL4
         UIzc4S/6JhOaKwl2cd5rc5Z1kuFGqU4ardRRODbdxY65J3/z9zVzGvlXuZ3cQR1FeL5m
         qpxp92nJl/ADy9IWyY4XtImZX6MeMFqGwd+dd7n6TZyNK6kAjIyteFNPTR96hhgR4nyq
         yVCZID00QNw9+df6k1IJ7IDp5KWrN33SIYtozjsBLghaU+EIWe5D9sa3hZIC+O1ELMJc
         XG2xs1ULOQnCMiBuz5G1k6VdveluBASNtspsCtBt00/ZDVV8gTBTggSH+4sr7Up/99Qp
         tldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781033425; x=1781638225;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCpplwiw50elwFgnVApXoDGm+FGobgQNlb4H9utyyCE=;
        b=k3U5+tCA6EOV9s3/TJmXuyU6Beh5cWWlCdl4RhrHSB23teIreE/MTCeOSZvKgkx8l7
         r5ZLu1XqwE4wRfEhUvZXMBqIVwTwXtU/5D1DOhPNj9xXNttCs4f7WdyWvComa1o9JzVO
         kNR+DRqt6yyA0dFT0cnhrbQdAQWNjBqanulKEyK+P64lcSDWxE/cVzh9eY8tNmmamlV6
         u34eeXOWZ/KKhNWqEOJ7oscwhycmXJnhvy1dcLtjhdVjz3xy3fxG4WtgrB7Kiby47hXP
         Jz5O4rKPDoiIXRgblLcdZITnyZOLzGylKwy+iQsZPGSYFYbf/HO2RU7ukEF2XRMjH64z
         7nJA==
X-Gm-Message-State: AOJu0YyLCGn8zcgnAkbUOF58zEAOCUA77aZcgxU82UbJg7TFEAcKjzPD
	yxGedli+5XiRlONxeLpIOBubfFLydXuHjIjT6QSVf9dSS1YWBliipq+ySvdClA==
X-Gm-Gg: Acq92OGJA/yl+9rZSXlZ5SIBe8XN+eWNd+jwj3ip7c4ro9qGs/z2YMCp+gqhsDlTZ8I
	xqF8yhoCpXBHZGA3ek9i4fufQQwK3mY677NVCbIGs300BR3x2Nu0COIqt6KUEjnfAvOz9whsffz
	98XxHRY6crDw1y3moY4j5jphIpCwVr1EUjQZv4VjGX+BiFydinPT6SeddWcdfiPjPgwT45KI9NL
	V4/RcZxOiMP1oztn6tVlxXvJK38iKsVwqt6uq0ZToLS/HYJ/Knr0Me6gA/IpQ5ISyNhOUGD5zAJ
	4eGFnvGKka6ab1UIa3yFasl6M7n23xNoBjm8PhhJBCeWgCH2l8MVnzMehcyE8gsjU6kk3YJOVJ7
	3ZrC8G7tReYC+rRPSwTuAVdqk3/Dr0nEcucc77gpqIPHe12d78QmyT2YKl/V0fvJObNgCqvBh3P
	QpthAJ9aagHI5CZIcD6UHvg9o6mMhmwmzeNyIfNO/DCVgtsVElHuo=
X-Received: by 2002:a05:620a:1992:b0:915:d5d6:f1f0 with SMTP id af79cd13be357-915d5d6f4a1mr1517880085a.24.1781033424853;
        Tue, 09 Jun 2026 12:30:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.44.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915a6935cd8sm1869869285a.21.2026.06.09.12.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 12:30:23 -0700 (PDT)
Message-ID: <6a2869cf.f14b93a6.283cb4.1405@mx.google.com>
Date: Tue, 09 Jun 2026 12:30:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2430899300767976744=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ,1/2] media: Add Mute property to MediaTransport1
In-Reply-To: <20260609181108.3787224-1-simon.mikuda@streamunlimited.com>
References: <20260609181108.3787224-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2430899300767976744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1108770

---Test result---

Test Summary:
CheckPatch                    PASS      1.16 seconds
GitLint                       PASS      0.64 seconds
BuildEll                      PASS      20.17 seconds
BluezMake                     PASS      613.44 seconds
MakeCheck                     PASS      19.16 seconds
MakeDistcheck                 PASS      235.40 seconds
CheckValgrind                 PASS      276.40 seconds
CheckSmatch                   PASS      326.72 seconds
bluezmakeextell               PASS      165.83 seconds
IncrementalBuild              PASS      625.23 seconds
ScanBuild                     PASS      947.04 seconds



https://github.com/bluez/bluez/pull/2204

---
Regards,
Linux Bluetooth


--===============2430899300767976744==--
