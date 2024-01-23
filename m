Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA782C682
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 21:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046939; cv=none; b=p49Tx00AEC6zWApLc+5N0KerDmJW2EoyLcq8DeyOO5ToRoIreJYQ6xdVUTy0aAQtis35B3kYgzfuHKWNl+5aXIPpG1ntoOEpKxQP1e0HGE0Xnq8xz/uduer75MC7venjmwC+zuODB5cOLVRhd4YlWqukhuilSOpErNtbPe6LdvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046939; c=relaxed/simple;
	bh=+baKSuByjOwuH+pcPF5pJhMd1kOLc4Jf9S7KnS6xM/E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tbBcAhqhj2Gr9o5KrJcEyJ3NCjFyasWIQOFIdSQZoMaylBspc06hdfiAJKPzs0KWmF6ISHY8HGSxpllBgdEjfhOc0g3aRC3gSwxdTrmQntUHTE9cG4UAabuhvjOkaqwjbwEvjTSsbw8uray0EbP3G9xcHwS2FMXZYziBbyw7jqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKrGOGtX; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKrGOGtX"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso2513780a12.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 13:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706046937; x=1706651737; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vQr83bQMwMMMScbGn73T8ylmcY1OgwKMMy/Pp/76DLU=;
        b=fKrGOGtXJ0ke8dWDYnznD6/Q+BKmpgzatE0HBReo75XJC4+DHFkEfjKT9ZsBRpRvfs
         1WJYfW0O/i0vdA/fE9YMyATMxNJkATg8j4XLj+nL9jMHTD3O1BDSAq9Nqd0Owl24jK2I
         XnVS7Mx359OeK61EnykTE9wAfXBcZaq7wTTUrKarvIxbIBDslb+C1PmNT2u4ioDKEsC4
         BZyEi7HZIZHEhlmlXn04UrGPr3DrP2jDhya4yZDHV2hs2SkHkq4s+b02L8WNp1gbVi2R
         cI1eoVdFv8IxLUvDsRzpV/igRFOXgBLjbWYsV2GYw6d04CESpqcs7SDjee+pHDFu7tYQ
         a3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706046937; x=1706651737;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vQr83bQMwMMMScbGn73T8ylmcY1OgwKMMy/Pp/76DLU=;
        b=n44cUhmTyzfK0tU3gBXhW1AUbCv5VX6qv/czDYjDSDWKEholRuKWxW9ttFHAa2ddAR
         3dvZ9ijQ4rsA2sQBvTjsFv/Rc+tp9/dE1kNSRsqwOzXCP273Rn7IY3UZe/LsagXbKY/m
         p7Mwk905UQ66607FvxiEmwFMIhTQgt7XP0fRAadEKASeGgyEHbiGneYvb5H9neL+jSHs
         9FmdEw5hnF1hynxyWX8hfaPMCCG9CvilRT3QSLhSANZQcGTPBrSW1opqO+DLx97O4aTq
         rwo6+nXq8aKMh8pMGdUzLmpgLG1yVD/yvU/XWsM3coLsHnYAylC+ZA61dyycbF4aoQhk
         ZFdQ==
X-Gm-Message-State: AOJu0Ywo9D5vDUwJh76sULIOeCiTrQWl6vnn4PEng5pH7ZUeETZN8qjq
	Gn0+9JvqWN2zmUqWtwWDqAQXJU9h0jqbWvortaQYJvUl2x+I+fcu3cCYrwae
X-Google-Smtp-Source: AGHT+IGki3PGQiwIWL2B6tFwb5OtnkoskHXBcBVuJ/gV6pFnR8hUPm8k0Unj/fjn/2v8cTVpRbwGWg==
X-Received: by 2002:a05:6a00:9a2:b0:6da:dbd9:173b with SMTP id u34-20020a056a0009a200b006dadbd9173bmr4286080pfg.49.1706046937153;
        Tue, 23 Jan 2024 13:55:37 -0800 (PST)
Received: from [172.17.0.2] ([52.225.76.23])
        by smtp.gmail.com with ESMTPSA id i10-20020a65484a000000b005b458aa0541sm9063662pgs.15.2024.01.23.13.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:55:36 -0800 (PST)
Message-ID: <65b035d8.650a0220.8be67.e58c@mx.google.com>
Date: Tue, 23 Jan 2024 13:55:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8611613999351080265=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] bap: Add missing Metadata property
In-Reply-To: <20240123190427.3031698-1-luiz.dentz@gmail.com>
References: <20240123190427.3031698-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8611613999351080265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=819223

---Test result---

Test Summary:
CheckPatch                    PENDING   118.10 seconds
GitLint                       PENDING   101.29 seconds
BuildEll                      PASS      24.56 seconds
BluezMake                     PASS      790.22 seconds
MakeCheck                     PASS      12.07 seconds
MakeDistcheck                 PASS      164.60 seconds
CheckValgrind                 PASS      226.47 seconds
CheckSmatch                   PASS      342.65 seconds
bluezmakeextell               PASS      110.72 seconds
IncrementalBuild              PASS      1459.06 seconds
ScanBuild                     PASS      977.76 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:



---
Regards,
Linux Bluetooth


--===============8611613999351080265==--
