Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE3229AAF5
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747931751; cv=none; b=Nii8oIJxRMzt2hB/kpWOJNO6XNXn98IqigmwZ70+tLt8puNjprXPAMSIgW/VWYl5ZnNfKLoABDNDtoDD+PuGQMFrAowKpDa9UvcglxGPTxlaP4bkLEuj+0Jduk1V3KeesQhIkAT97Mx32meHL6494XQd3ATAPwqvfgtk3fAVts8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747931751; c=relaxed/simple;
	bh=Kg+HDWN5U9O38xoVDai1FGoqqNBLmVaeZq9qpivDXRA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=K/ZJpIOjfvbpEPrxNledtTN4Nd1aoJUwAzDZzz/mal4o/BRiyqhGqhfH60fH2i9ghjYnV/U5dkcNvYACpICngwgweHON41qEtb5/T50Z79jnPJZDWBetKzQK1VChY+RIM43iLsjz/UvCRiIGfXHlwa1bJF86aWsDGATN/m19AHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlzgw4iB; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlzgw4iB"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-476ac73c76fso118048451cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 09:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747931749; x=1748536549; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dzQ5htiiHPDBUHCjXw67SF6mUuJ2T4VjyaJsvvu/aqQ=;
        b=dlzgw4iBnb7QsA+wFShBB45uVUEW4ZB/EFRGK2Bkjjdfr68MMITRzR4cx8CbS/0fAS
         5lxSW6VsbxvuoTCDXNgXijWPgMgAAK+E+urrP165f4BxZWyXl93ULyPtZKnAd1Y3abh4
         YaPfnW516bMIz2iTcGIp3zqZug0VJ9rvO/b+FB1sJwmSqHcFclP14QK+q9o0GWhqLrWX
         8C2U3CxL7LLWv54HxLuOtLc153q1G1AqO6cVIFNYxJvIAoOXpc7RSfX5qUJrJ4cMFKN5
         93z01oXjDynpXG2lylL6oXM9I8bTcD6rWR17JM9byQCI5Zk8IEmDm1z5i8b35G+LLjxm
         Kr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747931749; x=1748536549;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dzQ5htiiHPDBUHCjXw67SF6mUuJ2T4VjyaJsvvu/aqQ=;
        b=wH9L1xILo9D/oTjxrZ0lxl4+s/EAY1BwGoEi2uulIivfPtlHf9qqO4Xa/Ih7WRtMTb
         6kryF7Z75AQ0EqJAEzv8rzNAUDWPi1CGcjFQQ1AUSPMKE8iKNQPwj0zJ5P+Qb0wnzwOa
         dZQbVnboH7BrcLEuBq9k22qF1ZIN2W20IRx2QhBEJ27wtEzxemGNHsA2iwfTCdLcbkUF
         OLwtaYtdp731VGyvErLQBpnRoun8CRclx/EaxM1NAqZ3t4sfg74tzs8uEzODJrSEOBVe
         B/i4U3hIOjP5Qk9bcGi0qc3UeWJnH6wNO7fDmke+AhBBMnyVJQsQQA3lOrWOHK1EE2Yg
         +eIA==
X-Gm-Message-State: AOJu0Ywu/TUG+UCC2GCmG1iPimO2z64PeBDAQ7BSwXooqKHREHO70C6p
	troR6kPfuLxVYwdNKg4mCeywjUvnvh1gGeQfAQp9WRXd/YCnOmGEpBxNPljjvLGl
X-Gm-Gg: ASbGnctq0RMHWkL0OcCy20aYwjpQsKsMDpYG+VicpxU1wyZI+NIHMg2u5LRl/nFPkrr
	CxkSHjqS8B0IoWp/nZ5htqBmQkaCKVjIbM9NVZIPfPbMa9QWIFxUr1kpXD/0fNg2jWT+lbDhnaU
	5KLMEnJGv4InIBx8rxtDsIPhIkNzpH8A8bFLeM1cP3kHIlMHpbVi9PUzsKzMndB7sL/8BNDX04M
	9RMshomUBjaPFtt5bS+E7z+j8IKf2yKQgwjNmB1c3JVy+fhUpq2n/0neCo/1KCzWTi6SnjGRQuM
	E3QEn6DiJMSCl7ySxH91iwCAjZYdZBX8vcvMf4lHVYIlrBgBadhBF2wXUYw=
X-Google-Smtp-Source: AGHT+IGiNHNBioFQ//ne/+bkbUQppnlhWALbhHTmA97GScutcTlPER9pGWBLnlGcklWKH5gz7GTaZw==
X-Received: by 2002:a05:622a:2610:b0:476:6b20:2cf3 with SMTP id d75a77b69052e-494ae47dbc3mr454436281cf.33.1747931737327;
        Thu, 22 May 2025 09:35:37 -0700 (PDT)
Received: from [172.17.0.2] ([172.178.43.131])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-494ae4277a0sm103284671cf.43.2025.05.22.09.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 09:35:36 -0700 (PDT)
Message-ID: <682f5258.050a0220.2d68ff.889a@mx.google.com>
Date: Thu, 22 May 2025 09:35:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1116787161222749281=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] audio/avrcp: fix crash when NowPlaying changes while list_items is in progress
In-Reply-To: <20250522150359.634879-1-frederic.danis@collabora.com>
References: <20250522150359.634879-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1116787161222749281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=965442

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.22 seconds
BuildEll                      PASS      20.10 seconds
BluezMake                     PASS      2671.72 seconds
MakeCheck                     PASS      20.95 seconds
MakeDistcheck                 PASS      200.06 seconds
CheckValgrind                 PASS      280.13 seconds
CheckSmatch                   PASS      306.72 seconds
bluezmakeextell               PASS      130.21 seconds
IncrementalBuild              PENDING   0.23 seconds
ScanBuild                     PASS      927.03 seconds

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


--===============1116787161222749281==--
