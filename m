Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244ABDF6C
	for <linux-bluetooth@vger.kernel.org>; Sat,  3 Jan 2026 23:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767482463; cv=none; b=sKLb2ar2muEvNyIu3wGfCMrGmf/tojfM2gRUgRwAzZldnCHewlzo/YllkmUUrF7pLiq9BohQ/Uf9YvGNwC9tCfYvUUOYytTUb8kz2KI3Q/rifaHlQ5gMosencZ9hGxGZ3mToQxJOxd/Z/TJILJTpOJ2PUv8OeKQSG19p/jAzlzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767482463; c=relaxed/simple;
	bh=zAbEXHUVPpQJwKG38Z2+WVBAaT0cfrma2nRR5GYtP40=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bnIXFbQyGaVl25vbwWQSIKFd1KAA2ldDhDBTJPXc/BFcOyNgqrJvbuTBY5ev2DvFpBGbrpdmhp8Tn85HgVo5KU4Z6aVHN/JNV7wIArljtxJQyU2xk4c/v3ZrpYrOwMaxJoe3+3PTY466HoEj5aPJqqpX6jXpnN9kKM2pCI29Kqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPA435Rh; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPA435Rh"
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7cdd651c884so659411a34.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 03 Jan 2026 15:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767482461; x=1768087261; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pRSpHiW7/cwHOUZfKtHYJ4USozyCyYCVbW4CdRFTwc0=;
        b=BPA435Rh/F0KnauscfjdlYBUqGfEMQaxb4ncjbayZkTCYGA0bUo+H85pgbR2o+zZV+
         UGxi6ulqa7n1N/YWBQJtSZhLUEh/+LTMH8HcdBL/HtUXILYhe6XZ1Q6W3PkRm5UXGq+d
         KOd6335ej2/pqYv1GaIECgfimhPi1p0bo0zMPTCQ1AtgZXp/0NJof4ux2/dLfprigLAR
         WSUWw57TJXQh4Br/a79w+dNyFjriCLMCvI2V5awaxizcP+pKOaxJJ4+LA0JKufPrJ8LI
         7GDyrqWGOaWAGzWbJoOsp0kvBTrJtRsKl93DGNqb7P1QU3kWNA3aVHUV39uOhmOHm6o/
         UDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767482461; x=1768087261;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRSpHiW7/cwHOUZfKtHYJ4USozyCyYCVbW4CdRFTwc0=;
        b=Oqgs2Q6jwPcjrueRSy+reWMp5GXM2nq7wq8eBJtv5DZ4DDR9NTf1uLnSPwpk626YFn
         AIOWHMrvp6vtNrlQmkeHkMnDBN6KubhalObWAqhCikNukvEX+PLDalflXM6/0C/gOXEO
         oUijfFVMNgFBoTZNKKXiZBfyFD1EAtpJHLfIE49MgMMcEKqnNkWPyK+3ckP5zer9jvk+
         25DSSOkzzuJuE6oWXdIQmbzRSjpgiotNgeCzFIB55d/rbyJMy3PMfgrUg85YAt97fhs5
         ZE4PE0DZ5UfWFsH2omhbtoxugBiuJ7BcJ5Jxio6rfopqbhmIPRP/uL69s0A+yNbxEigf
         Xk0Q==
X-Gm-Message-State: AOJu0YyA4PH8i3sBj82zADYop90CaawCzjGt2v+vdBu3sl2aC72USMw9
	QAmHNN0hVLrNnWijPcYNM79pr+XOVdL4oNswUXagg5QrjSk2qGRwcFW1d/clsHiW
X-Gm-Gg: AY/fxX4z6UpbN99Z9Z8ivPhh7TT+OYmm74Uej4gculBgelP8y91lQrKrs9zSjWY8/K9
	jarW3Dqfi0IoWr+Z+Im6J5yoiEzL6pwJq6qO5GMBmjQqI2lN/tKWnWOeOVdn2+i7RKdvNl4Ac49
	fZW6rmj4UubAAiq07wkaccipJSAcAihbb364uf9wrvbZ+Ud5pgZI060tpXbNpt+APbtMHYIFumO
	J9tqmzIWcXYdc7nBKILR9mtN9mTeKgcjTaAoCNO+15oKGhr8HSG2R/pXpzc5Ea2PYhi1jAwJimb
	AG+i74f1SHAq7XkCIBtbdUj4M4MrJDeAkQMISADWacaKyHCnQnAlL6FXQW819WrQe42A60P5fLv
	bJJOXt1CQ1mmhhXIJCuZ5uYs1NiZhesBx7zDDmGsAaEQqD6/GXJsQ3gfvhaugkdn9JZDq1+I/nj
	JoUhZzb3NClAMxE8c=
X-Google-Smtp-Source: AGHT+IGDGVgQJiovCHlBYboLQHOMHTjYnaSVUMBm4ymiHS7t20JkCcYrQlnM0Oy6N0CT0kXV4vlGrg==
X-Received: by 2002:a05:6830:6ed1:b0:7c7:5f86:196b with SMTP id 46e09a7af769-7ce2bf07242mr1896774a34.3.1767482460720;
        Sat, 03 Jan 2026 15:21:00 -0800 (PST)
Received: from [172.17.0.2] ([52.176.37.65])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667f9468sm30330678a34.28.2026.01.03.15.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 15:21:00 -0800 (PST)
Message-ID: <6959a45c.9d0a0220.347a8.856e@mx.google.com>
Date: Sat, 03 Jan 2026 15:21:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8155923745171324798=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [RESEND,BlueZ,1/2] 6lowpan-tester: add test for header compression
In-Reply-To: <d7f5c6978db76b58f9db1b6f93254d2f38c1e365.1767478380.git.pav@iki.fi>
References: <d7f5c6978db76b58f9db1b6f93254d2f38c1e365.1767478380.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8155923745171324798==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1038129

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      20.03 seconds
BluezMake                     PASS      632.55 seconds
MakeCheck                     PASS      21.60 seconds
MakeDistcheck                 PASS      241.92 seconds
CheckValgrind                 PASS      302.95 seconds
CheckSmatch                   PASS      351.89 seconds
bluezmakeextell               PASS      182.02 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      1031.44 seconds

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


--===============8155923745171324798==--
