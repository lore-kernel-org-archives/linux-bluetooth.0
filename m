Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D8531329D
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Nov 2025 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355210; cv=none; b=KCQf06ZuPhJDy7kBmprpRieoFREcN+pcB6AGPJHCQ81AQjgg20sFu8Iema6ICJHbEUganNteoSxwEu/sctfN3hDqi/9iuItPv5e4UANsM7ZeMRUDJTzwz/WROKCFczplR4/ut2UUt6/Cd4dwzST6oWap3UdpJaKbgD60h2cj5a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355210; c=relaxed/simple;
	bh=8l5nRp6bhAuT67SDyXqA24hfwl1tC6uTo987eR7mTl8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=K8r3wCbTmT/TcD48cfyxA4ytQYTgCifPeCr3/R3sp7/5fOTYcNx8skwDupBJENY5XjJec1PTfy3n8aZIBRN5nV93sYvJRYcOtI9RaComflIYuGYoDhRlVqFSa1ehb6ZBiMUOUxRj3fnB41KnWBYCKPy5pY1n0yzA9OTza9kpT2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kt3+JQZu; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kt3+JQZu"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3407f385dd0so4497600a91.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Nov 2025 07:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762355208; x=1762960008; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ndfypWv2qI/yEcs43IMOOjiChsR/iKZtAEYVuLNJVPg=;
        b=Kt3+JQZuWNonUvzBpK7qsNvNIwGNZdmKqeuCd5Hvwlg5xz/gmmj0QIPKCxNwtDf3TS
         HjnhCU4KtOjJyE15jqkBdgcrRg2niGyrNksqEshDUn3Zgub8pl4mA5pm6fQH5c+Wz95m
         8N+DIC88Wx74+E1rvYgCPAgFnqmoktJqPnQdqeGWiEi+FFyR/afDC8JYj9JCdRL0TdQU
         KBPr9pwQbwqMMouAGLQ+TemYdIPJVcKHstNXRuLq747Sj9tVOPeVAy5PsUXV4KK2xnGV
         jjxe9o9pRXx8CA8ZAdwsD5SsDPvLwPt1ng5i2iv+wmHTclPqNWDd8pL1ZD2UdWsTMp+p
         PsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762355208; x=1762960008;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ndfypWv2qI/yEcs43IMOOjiChsR/iKZtAEYVuLNJVPg=;
        b=E8IYzu+M4PCke9dFolOszp6eCOafvJhbQgW9HXMd/UfBdJc0688v/xxQRmraycgQyY
         wNN2TaUlskTk5lKhG6GsUwqE7k5N7gYdTQbx6GTJ6AiI4qhE/tnkr+qHzZiwwz2ErNPO
         euoVxX0GYbtDIn8O4U9x0q1xofmddFaFV/vaw05/HagBPIXpWwJzSxLDWl8nkk4AvTPN
         Y04FILeN5YxvBzr+9lrAl5tW7mOkWFBv5fINV3vh5Ox9u3EePj29/3ysEzDv7c4mwmCH
         4g8nbNYAmVqJDUe5au4IqzfMxcOU+2+Vr2Zb3kHYHBnue1GNnIAwCUYnspiF7AOJflvR
         9jFw==
X-Gm-Message-State: AOJu0YyGfPRIUjegxa2vuXV78Dh8OZEqn60Hqi/j7tNeZBlLMdjQlHiw
	boKw36JGoTPvggnXDYHxkRRVFXROnMh1A4ETXlMjAqRet8JN/f4fYJ+1ZE3Sgg==
X-Gm-Gg: ASbGncu9d78sRJbdxluRTLnk6v5wla4OobU3bn7+XlwDSeDa50RSVfLyIGb8IrB5A5O
	tXuPDMEc1L6L9rxTw9TLUYr7+L+TgEpWMgbIqVQJtru+HgYR8P0SeTFuK4aaX4e+87Xbof1PvJW
	2+GWARqoQwbkZnLTXXc1c84QdGhS9P6o/1UcQW9QeJzl74vGzgeYWU0PIy+gO7zv6Q0idxgF4WU
	YIYFTfzey5nkWQr9+51f/Lkrd8qMbCY0pT1p1ACiciF4w1aLJWTye3OKa2Z72g476vsaGEdsloy
	mWhA3OI2iAKiFUlP+1vOzVOp5PHyogR8YVba2NQxbidrWe3UGAgLEk1cS1p10RG+w65sJ9I88GV
	7NlrwlJn2MMSTWoJGRINNV8G+znIZ2aj4OL/aHp0MTYh4r2iYZRtmDW4vsGt0IL3yNtVscsC9Kd
	PGy5x8ww==
X-Google-Smtp-Source: AGHT+IEUnOiGwGBskQKQhCo7lPwGT5amX5dm5zKhYNamvnUld9AdrxBA5J6jX6rAsw29COfBtLJDcw==
X-Received: by 2002:a17:90b:2888:b0:340:d578:f298 with SMTP id 98e67ed59e1d1-341a6c010cdmr4457193a91.8.1762355207915;
        Wed, 05 Nov 2025 07:06:47 -0800 (PST)
Received: from [172.17.0.2] ([52.159.244.85])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3417a385563sm2735243a91.0.2025.11.05.07.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 07:06:47 -0800 (PST)
Message-ID: <690b6807.170a0220.37870c.e4a2@mx.google.com>
Date: Wed, 05 Nov 2025 07:06:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0120705896460776851=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v6,1/2] shared/battery: improve the display of the charge level
In-Reply-To: <20251105132414.82057-1-r.smirnov@omp.ru>
References: <20251105132414.82057-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0120705896460776851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1019882

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.53 seconds
BuildEll                      PASS      20.76 seconds
BluezMake                     PASS      3151.51 seconds
MakeCheck                     PASS      19.77 seconds
MakeDistcheck                 PASS      186.24 seconds
CheckValgrind                 PASS      238.44 seconds
CheckSmatch                   PASS      313.15 seconds
bluezmakeextell               PASS      133.55 seconds
IncrementalBuild              PENDING   0.40 seconds
ScanBuild                     PASS      944.52 seconds

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


--===============0120705896460776851==--
