Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C00542049
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 15:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768491515; cv=none; b=Sb9itiE7ejbLJ7B1hHUVmu8noiJHHvSIwf/uuOsBCVd5A2MWoHuM5MRxPJ/SSkD9Y1dsBBLPzGm1c0mvf/d+qxKR5Wwrhw9DhZs/fk36X4GAakXWD8Ejr91sVEd6VviwlrCH3LywibJM7n7vtDk0eVKKtmaYLDBAXGYl4IY5UsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768491515; c=relaxed/simple;
	bh=TJ+iaTTmtVUiKs9EN+AcHbLB/xI4sC5sfueeIW6F3xY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MNyzlTKRng+vZ9eO8/OezdqxDXzJJP5afftd9lrpHlo8/X4KXboyYQa5Sui2jr+7m0EBG0ED5/OiLEbf67mwumbtDfNJiGfc3/SYh9HbC0GjIJ1UYpgVIO15uCmt8WL+PY7iZPaxvBKGe3gVgNYsK9m7LsEQBN6lOShf/Lo1Tys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2Q/O/dw; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2Q/O/dw"
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-45c758f516dso624273b6e.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 07:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768491510; x=1769096310; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e/hPoIOX+z23Chp4Uxmw2XkTsJW9CigH6f8M3e7ipGA=;
        b=d2Q/O/dwC+qBxKTFxLaHJizxrYtLmZHkXP0RG9dAlcKbsZbiVPSonjW8EE8ffmgsRb
         1VEs63bwrnq2axdZCYVzsiE4a5lQRwrQk6EpYEMkd2UqtHhEVd0wlFM6owlQYdGUWkVu
         X2iYo79gHvCXa2xbX0B7weSzRbHF/ivDuTz5xmMlh4jRgLmH9BRtSXpSTh79oaU5pXct
         w9AJgvRzj3vKmmDaZMe8x2cOVv8GRt56bOcfFcen+RYN1cORehNFTXYBJe4N3ykIZfGD
         2Bnt2sYBN0SWCbUjW/vbDaNx5izK7P0sNu1DDAygp93meal66eOsu8+VKalLiozJK6se
         LNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768491510; x=1769096310;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/hPoIOX+z23Chp4Uxmw2XkTsJW9CigH6f8M3e7ipGA=;
        b=qTcV4mWWaClpCd6QJ0h3O9kZ2Dvtcv4eprCej4hOBbeAqRsC03CB5Qgfi9+pIhJmJg
         4DJ7nIxjJZWCGhV08nzobWYqYG0l3aV/rmFKQPe4EVB8nhWqyk2t3P7oe3u2Kh23gllj
         1TdJSWR/+WYVl4glPYR9H/nGyxIrQXeFAJFwLviz0wqrejyR42gGfXChoDe3QuDsuDg5
         j56yAiXR5+HAAdZv72VDB7j40cbRCq3vdp18uFeN6TBReo8vDNqNXG5u4jtGc8nUr6G5
         dTQFHQW7/EwDkGdai/HTStlW1fKspSh3qGf0U3g9F/uj46wACyg0pxdLdnS/b4kCTo54
         kIHw==
X-Gm-Message-State: AOJu0YxIL0LOqvF5e3gDNxkybe37xiyLHcF4HVwmNfbfmcRjQDrH9YFp
	iOy0S4fCEcvebUuAnHYcvbygk4Gdjgez0sAheFyRZuT5unHJYOG/K1J25dSdXhUT
X-Gm-Gg: AY/fxX7+sNCPG6Dus+dJU+r3Ypt1P0U+W0OiFlkooPFu1Ftb1DDOlOyG4oBfnp+Xgnd
	3I9IbCMWdxeLIDVJlZLHfERdH3Mg9s4lkXRA8V8UJX+mJWs5Asn0WlVAr14qUXmORSOv4FohZSa
	fctz+80wP5NuE6UkvZabXFDw/mz6YOOmoNqy59yDjIIGt9x1CnCQL6Ojg/VS7KLJpSgIQMeczGt
	2WJeU9aNtIvgW3sciJga5DvcuaUv7fuOzyw0J31ZUk1q2tO9prLtu6qM+mlqTc0xqkGzU8HGP66
	hJEUMSBKwniv2xgTJ9esix7Qe++VJSTNyqHgptlRmnpVw3l/XrJ3rUzDvef3B75oZ1wju+wGj88
	4y3uCPdkWS+qX1oJkAnJPebr6KOK0jQB0djrNsbLGy0vba1ciszBIuRJCCxR8uSp0IHlv2HanLM
	KEHWNbIgo9r8awa2vV
X-Received: by 2002:a05:6808:3023:b0:455:d5b1:1f94 with SMTP id 5614622812f47-45c9bf7e07dmr10591b6e.29.1768491510139;
        Thu, 15 Jan 2026 07:38:30 -0800 (PST)
Received: from [172.17.0.2] ([52.173.108.16])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45c729ca3b3sm2544369b6e.21.2026.01.15.07.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 07:38:29 -0800 (PST)
Message-ID: <696909f5.050a0220.7b747.9163@mx.google.com>
Date: Thu, 15 Jan 2026 07:38:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7067079158210573665=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] tools/btpclient: Fix eir data on GAP device found event
In-Reply-To: <20260115143811.12738-1-frederic.danis@collabora.com>
References: <20260115143811.12738-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7067079158210573665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1042856

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.45 seconds
BuildEll                      PASS      20.60 seconds
BluezMake                     PASS      645.73 seconds
MakeCheck                     PASS      18.16 seconds
MakeDistcheck                 PASS      245.29 seconds
CheckValgrind                 PASS      296.85 seconds
CheckSmatch                   PASS      353.56 seconds
bluezmakeextell               PASS      184.37 seconds
IncrementalBuild              PENDING   0.48 seconds
ScanBuild                     PASS      1047.95 seconds

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


--===============7067079158210573665==--
