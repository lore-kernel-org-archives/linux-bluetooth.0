Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8D91E282D
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 21:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745874897; cv=none; b=sRqnZVads93S1LXTUiTGcXteAFLo+nd7cLVn33KxsAXoeHKVKVUH9VITdImzWZY9RVaCmnV7XvbZdUG5+PllxuUQ4ELZHlhNqQi4bTIpUGsBQaJAEI+vu/RjrZyZRaC4wsolBvtbaxvQq3j6ZjdQnwQPlwACdFuoCp2Ykh1bca0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745874897; c=relaxed/simple;
	bh=qAa2h3U9vPbeL9AEn9W6vhzcuSG7c89y9zvHpNrTlfI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IxRvEmNcr4zZrXaIx5Sa44a2X4HzF0SicxRN1jCxqQI0azUVAsI79lAaHklwHA3ScQo3b3kEI130rolgPIGu6Hds2655l5s6pegIj5ccxmVKkwsLa6koX+t1CXKaJYwjDAVQod9PhSKoIn6wd14UJwE0Td4Yy/a0i6HPof5zLMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euXEepmM; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euXEepmM"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6f0ad744811so39839316d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 14:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745874895; x=1746479695; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C6yHleMZSRh9N7lKs6YtKPpY8FndI8Hv5n54TQ+PG5o=;
        b=euXEepmMrKqZtkBUJldiKvMG5Pyo3Vum59Fx+FvtwEg9Ioarqte5CQLfnKH9Jzxc+x
         ca+264EpVTmO+mao5bYcNVRVcy7OjVNyJU9GPq2ntS5yEetmz58XxzeVCSVChK660X6o
         djGJ/nynrRubpUgIdtkgPPfJSxO2FXxoQPBCWaK7jqMkm20syP+1QMU6VaZmrxq7FVg2
         IBaen4ICw4X7RcBP5YLvtBeCtoxmIVGpA1MR6cjjI1PgG694w8AgYZr/bNTaC7MaoL1e
         Uj2t++EYKWN5+z5AckrUxJLYXi/C3CYmDkQOU/1qqCVQPnUijz8hAgoSQn4+5sV55xHA
         mltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745874895; x=1746479695;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C6yHleMZSRh9N7lKs6YtKPpY8FndI8Hv5n54TQ+PG5o=;
        b=E5ZEQga/gQg0lZVB8XNKTpbA6SIEPCiKTRHUN8UF7CieTfQnz3HdnaMS1bQusl/LY/
         4mBT/eEk+UPn4yHpfn7toHh2yw5sUfJZgi987G0O1JHI2TmwaTFvBb8LcnnDmOjsQsMN
         BhHbLQYZzLGuyUTvz9SJ35vogbXPFRJNmb8ba9HDJHgrGAhBbF2wCHeyTAoTI5yN56oP
         Qh4vmtol17rY3q4rgZb19VwUwWOPjiX4+Lr98EDIlZnK/Qykr/PQMTS6DSjpr/kJL3uL
         mD6HaNWwgyHqF12srgoTk+QpaKriYrQ3MGYNcdvCljKli9QHjwqf0zYlMh63e/ZCbRsD
         s/XA==
X-Gm-Message-State: AOJu0YxpF/xtfLTvJmZTIWMnNu64sBy6EIHvwSgb8wVNwECM2HKKZ2Il
	BuocFTSb0HmgFeGRys0QKSW1U3HbQDe+EBwT8ZNmL9dnrda/YeCr+SMdzQ==
X-Gm-Gg: ASbGncs/TT7ZkUjMbfN6oECFPk/MAztIT+ugXv+eGDFrNA1cwNNmdAzZbPG5OHKXCqH
	G5janNFL++0olnUQ4+dY8L5t6a/zfgaRMgikk8K3V9ZMGQclbB2IBu8xsiFM3+pmBihU44PFXIN
	15LJwRGcLQIqrDELfN2Zl9kHSYuMgg5Ems1LfKRG5ozvIB2M6vS1C5TeS96V95PnlHaKkz6uear
	cg+WDpiYof1O2NHjt03E8lc0todZMTrT9hj65BYdhXVOvaBrvzQ1TOEjm9SWEAI1ZylV1fTluRS
	D4jkECZtg18jcLaZitD8MNhieO3abnZeVFuqYFYgTwJb
X-Google-Smtp-Source: AGHT+IEts4nVD+wN1f+Khhp0hcYmbdHCmhbblhQAXOxCqUfHdtAMs9j/E2F3yBNJicR+WDeFbc8zdw==
X-Received: by 2002:ad4:4eed:0:b0:6ed:1651:e8c1 with SMTP id 6a1803df08f44-6f4f0575758mr22937986d6.13.1745874894792;
        Mon, 28 Apr 2025 14:14:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.46.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c096447dsm65622176d6.52.2025.04.28.14.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 14:14:54 -0700 (PDT)
Message-ID: <680fefce.050a0220.34c10b.853b@mx.google.com>
Date: Mon, 28 Apr 2025 14:14:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4729527163603320429=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/5] main: Fix comparison of narrow type with wide type in loop condition
In-Reply-To: <20250428195122.2000808-1-luiz.dentz@gmail.com>
References: <20250428195122.2000808-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4729527163603320429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=957841

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.28 seconds
BuildEll                      PASS      20.36 seconds
BluezMake                     PASS      2696.47 seconds
MakeCheck                     PASS      20.52 seconds
MakeDistcheck                 PASS      198.26 seconds
CheckValgrind                 PASS      275.33 seconds
CheckSmatch                   WARNING   303.36 seconds
bluezmakeextell               PASS      127.88 seconds
IncrementalBuild              PENDING   0.21 seconds
ScanBuild                     PASS      903.97 seconds

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
src/shared/bap.c:315:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:315:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:315:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4729527163603320429==--
