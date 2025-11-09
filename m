Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5BA26B760
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Nov 2025 12:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762693121; cv=none; b=R7fXXZspgOpdBlS8z/xq91/cWzbjB0TqH2sGHONQHi3ZNubGjtoU/3y2Ct6SB7n7glnGGN637ivnWhDiejYRflq9luOH82WWUobqRVHyj2zl4FOX6/o1XSCnBGSj0flDunJWu3LJYrSBGTF09Xh2w6i6lM2IntvIKcT7yRTktB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762693121; c=relaxed/simple;
	bh=P/yc3On1UVLUETckf40ERkzQ736Zf4oMv7bSw4kUrQE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tk7Vg0jThILZwy9fmcVSbzMHr7uxRFSPePuiOe8c+4XvrU5k9icoFWgZQFQ9atmkTLEEUvkHOzG9YN04Kq5ynmI0muLHS7OGFJ4YraXNWWtdmO2UobJG0gGEMT93ZTP5Fl7uSeCCaXvpYvOvU/vhIf36Wu2MjA3RWqcXfoJVZgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8/H/mbU; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8/H/mbU"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2980d9b7df5so2011095ad.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 09 Nov 2025 04:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762693119; x=1763297919; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kQWlW2EsFJRalZohWeuJvRTJ3kuCM4bipDRZkWHClts=;
        b=l8/H/mbUr6CoyJDpRb3HkYxYlMAa7IJ12WpfXXEYFNsf3BRF7KA8QXJhmXTgFrSwnq
         /A0xVES2jcUNoq8Jhscw2Udk6jTSkqpLLWUrz/S2NZXddIYG1ClJkfgIyKz3Ivj9+0oM
         4cASJjn8ma2hvkPsIh/CmKFZ8Yfyvs+ZWebZFZa7fFxwcaA54x+bNq9j/kA17pJAWyAb
         kblczlMBLVxJVDKcGxfbFjPW7RgbPqMy/QzcopTQqxm2u7B7Ono1mS4KMZCyXItz3TFk
         NkM6j5ctyP1QP4GJQnNRK0IC3BDd6L3KZU4nNcFUqNA0cvHMCoHJai3oVBt2EHzjcAtM
         MsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762693119; x=1763297919;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQWlW2EsFJRalZohWeuJvRTJ3kuCM4bipDRZkWHClts=;
        b=IVEPoefwrpkALQVCtp94nXkv2BVFc9ArPFtT5rmbqURQiBO63rnQCbYxlxYRGh4KuX
         L81JJkO6tM8yr2lQMVngsVDTIFjWKkkiRi1L4uovGnUA77ql1n0okzfDryZe8xjuVmrf
         IOtLT3VFfMaXnl0PKuVkwL0VIO+miA4Ucj8bVqVgIUgeG6I77FleNQ5v6VlNYa4pD2ha
         Y8wX1AuDbPL9xUw9yVn/xC+Z0hECZTxTIvFMUOTbzRfhOJv3/AXVwzRT7BM1IJUlsK1W
         KG/CC++nZ9oMnupmxeNuKt+UWwxGeHF85v66yTk8kjC7J7eTSrPg5WZGRKI3uOvjJpU7
         mB9A==
X-Gm-Message-State: AOJu0YwcDGncxXG4w4lHRApH2t4osREYfkKjnDc0ry0iyDnU1fWUU6gz
	Aa0ey9fsA9x9Pz1ZrW6zpYk84B2fnWZ/jLAIuaxwztBeA6uvP6fV7LNu0+RaiA==
X-Gm-Gg: ASbGncvXejDyX8Do0L7SuXJQ+bTY/jfAXudgkF8ptWhOsmLo0KjAeDlBRw7yjSaRu2L
	WwdmEgS4y92qULjGqTcrtPgukhjqXtuEeIOrD7mtUhHei3qpDLvWRjbeSj/B6tBfPYJSZmjzNDO
	SESI6smwpvl+VcQdexIIZ3+qDe97UFVicGVxdaAeSUYfEmuW+B6qdx2lTO2IuxhbI/hHyaXUQ7I
	r97/ONsTOffgIyR8aOv6VYBEqwXi8rMTS4zGJlB3fEjEKTSPFHD5k9JEmZ9rIWXXZSZ+NroC/wY
	ez+DbTkPuQkdx3Djt1oqOq4JrO2O++BrCS2Zp5TPdNJc5Q0mEpRdjVZTdKEM/g08yfW5PUWKs6E
	5jSzZT8aUzKTaCTgFVLDmQBCsaZSgSPkFQEnY9yenHRnG5HTF+C7AyoLJk26EJ/93AWkgXwsWDs
	Y1G2SG7ByGbyDoD06p
X-Google-Smtp-Source: AGHT+IHBNImCzozfhORcosDzu9u0X8LsIkvreSxs9MkiLvwOZnUO9NwHFkofOCJtRGWNb320N2URag==
X-Received: by 2002:a17:902:f68e:b0:297:ebb2:f4a1 with SMTP id d9443c01a7336-297ebb2f73dmr50178175ad.38.1762693119489;
        Sun, 09 Nov 2025 04:58:39 -0800 (PST)
Received: from [172.17.0.2] ([20.168.111.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5d66dsm113994995ad.37.2025.11.09.04.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 04:58:39 -0800 (PST)
Message-ID: <69108fff.170a0220.33a934.96c9@mx.google.com>
Date: Sun, 09 Nov 2025 04:58:39 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1188653032825570501=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] bap: make SetConfiguration() work similarly for ucast and bcast
In-Reply-To: <e22984df6d0f3bacfa58ceb2ce98eba115d81db8.1762686379.git.pav@iki.fi>
References: <e22984df6d0f3bacfa58ceb2ce98eba115d81db8.1762686379.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1188653032825570501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1021286

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.41 seconds
BuildEll                      PASS      17.75 seconds
BluezMake                     PASS      3929.27 seconds
MakeCheck                     PASS      20.04 seconds
MakeDistcheck                 PASS      170.39 seconds
CheckValgrind                 PASS      228.41 seconds
CheckSmatch                   PASS      270.76 seconds
bluezmakeextell               PASS      120.66 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      831.00 seconds

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


--===============1188653032825570501==--
