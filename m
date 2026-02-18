Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45693EBF13
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 03:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771385862; cv=none; b=Y0w5hvdwzjndq8GW4MQgYgWiId9NnGD8d9vdr2IqaKERcArSe2UCV4uBptNX0LG/xgABqEs4+xgzkrm1FlHxvYtRCCIgQF+SSF1NVQ8T7ZqMqqrS1GKIXN3GtFuXOr6J5x+wPNi6KTf8vmluIFOVgZu0sTA3f5gVxo1Ahx8rqkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771385862; c=relaxed/simple;
	bh=2GJeltx0y8vnKukQexnF1BAK31TzMkR72xd+G1WowDs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XZnKMhvnZje0ScOY0HUU+4xKQ6rMSv1FUTvxhZTUecHMHvEBkaL3erd97Z0TZtkb96b/gnd1GlmACBHAR3wsqJakYSA6GUHtIZme2kSJaN7ZMwdeq51i9dinLEcudbjeJyIOx1AibzBqA7TeBE+rfhovGrJEtS8OczoCpb8F37E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RX2GSNpU; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RX2GSNpU"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2bd3b0bc201so1676620eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 19:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771385860; x=1771990660; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dQd2IqmR8yxO8DX3asOgTrMr9+2mXp5bNQDMtht9dxo=;
        b=RX2GSNpUlDvDkhq33VDteytrJf5ykfx3ZIT77Fnlh4N8r5A0rJcZ9KLKh1sCfTsAn0
         kDkYbGypBVPmNv1nHnkLl2wHCQfpvXl/O8dMPYjOcZFG2wtbG1sB0JgpAfsQLgeQXohf
         eciJGklcRyDDQ9aEY6iRFrtxGhPDMIXMD1J76g8fZtC/s+WPv6I+jRYgE/iC5a/BQiBN
         sLTS3kv1JLmWcar/cAiyMHLbmtf/h6Z3sIZlNhukN+a5mjzd6jGSR/A5kzsDQfoczZKI
         Fnl0KtKCtXl/Uw7eCWxn3Z9zeqFG37rNU6Cj1N5ENJ3pR2bBCcgj1A/3ElDb0JW490KM
         U04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771385860; x=1771990660;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQd2IqmR8yxO8DX3asOgTrMr9+2mXp5bNQDMtht9dxo=;
        b=m9ZsB9Ot4aO5emtWxrAKCPsDaqzapw34YsZltyB/IXyTtVGiJodNH79NuYzWQD4VLi
         C1Kd3FdWhyB3iL6D+ChMEjkMTtun5lAWJNL2c2Mp3tv3m7QlMITJ986uyN+0q5jb9Ick
         YqG1PY9cFwS4bwQ4I7QfbA84glZ/toLMLTgpUSKmGA0P5o/8rVHJT2VcMxfUfxWfULUe
         u0pVTB3xUur7ClQiuAPGpf+vYQ6ewX6GTfuy81Xy8GzH2hcTOkb4WQmdxY2VoQFDhuVg
         RS2uW2+mhGbFqvgz1Qxqzt1qvtndT8wtehi6YXNh5UEwq4J6b7ZaPLw3BnQqbU/YzjRw
         uMkw==
X-Gm-Message-State: AOJu0YyY3/+RrpWtSSMLWpSFESh0tDzYpk4knteMy5gaibq+COrCEX+m
	EBMcA9P1k0FpcZLuDff/QXKbfoXaOy9Ji8v9A8d/2Yq7m8nHU1dDqfgvyjttp7aC
X-Gm-Gg: AZuq6aL7iofaFfDLFOpA5OTKXehEBDH8pR7EY+WNnW2QnU0eVA3ze3JfNW1qOid8Qlr
	X4vIrdheHlvFtZGg87I2RqDZ2LzEndW1wFCxqU6Jlhw2s8xS4KuRyq4bdn/MFQs8ufRGOVWGKdR
	ZYq2mXmDlMTBqAYZpREREQz7ob1mk1H94J5PjqzxbnxzKlYeCxYeQtXgKgd4ermQNGxFmtg+G8M
	V3jRKQfAnmJp8vaswHOn0i8FtzXBboUrQLrqJ6OIsRyTmzTzDl9+hBC8aAMRVVa25Rpb3QnwF9m
	h9DGUK6WbOdz2iTFayzwJDjrNpADKkyBb67Dp1yAMnJExL0IZohlG722wSR1/n6CPaN9xt8JpRJ
	XBNT865Yn1wNntvQPq6zE3yXUGDMqTZ6SGSjuuCluMgzTQbH9uBOPHF0OWJG3qqiBm4qr7rgC3D
	5/FaN37siSrxdD86WhU6iHDPxVNluphA==
X-Received: by 2002:a05:7300:861e:b0:2b7:f809:9c3f with SMTP id 5a478bee46e88-2bd501871cfmr290632eec.24.1771385859610;
        Tue, 17 Feb 2026 19:37:39 -0800 (PST)
Received: from [172.17.0.2] ([172.215.209.99])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb6782e5sm16616475eec.29.2026.02.17.19.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 19:37:39 -0800 (PST)
Message-ID: <69953403.050a0220.328a5.9e16@mx.google.com>
Date: Tue, 17 Feb 2026 19:37:39 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1939201396470911708=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ronan@rjp.ie
Subject: RE: shared: recover from failed input initialization
In-Reply-To: <20260218024605.70890-2-ronan@rjp.ie>
References: <20260218024605.70890-2-ronan@rjp.ie>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1939201396470911708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1055060

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.37 seconds
BuildEll                      PASS      20.74 seconds
BluezMake                     PASS      644.05 seconds
MakeCheck                     PASS      18.38 seconds
MakeDistcheck                 PASS      244.93 seconds
CheckValgrind                 PASS      293.77 seconds
CheckSmatch                   WARNING   359.08 seconds
bluezmakeextell               PASS      183.92 seconds
IncrementalBuild              PENDING   0.41 seconds
ScanBuild                     PASS      1014.70 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1939201396470911708==--
