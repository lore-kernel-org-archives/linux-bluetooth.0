Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79DA247284
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750364483; cv=none; b=ko74SBpd2U5bYjPYtav4PScdUepCmObDP2LTniRE136Vj8TDTUqpOIwb17nUuYdR3DsidL3CDKfjpxN4LiCOmQLzLo4DG6FuzkvYfhIuC97C7o8cK20cvPtPDH7WdIAROFwDIPq7oLOXA65j/JeN8w82z1pz/otu6UXetZieVJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750364483; c=relaxed/simple;
	bh=8T5xRx/0Lfh7BnaXQb7CEi5kAOjP9x3OoVg3bvYexek=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=R4BcdTptl6d9GhMSM+nLPW4eKqhbGBLUdsMKWENhNwe/g0E9nmI2xklWyg5DNd7i66RMObwxSum7OR/aOpC6fFf+YExKQ+WWkmoBCcB5rE4nLPiYoBwAaGvPCkuUlp4lkONKMIwKFO21Hca1JRHfk7K2Ffso50GZGhlZgqeZgc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAYVWA2z; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAYVWA2z"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-748ece799bdso693912b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 13:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750364481; x=1750969281; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d2jLx/hVTc1t0d+pNKyT5Xpcz+rXvopf61vwCyZRr1o=;
        b=lAYVWA2zHXqtnRhSrX6sZpLiGGsi6w8aoFWHm1q/D4c4eRnKoKIah0qPtyugfcvtvf
         m8l0EAi8qeHkBu/vRp7CMp44E/IX8H8ywDdt5V8lMenjev2qRaG33wedvWOX9Thry3Xl
         qFEAaTnAS3kR0FTzwGYEJSvZATDjA2ZOkIVWEnXK7XSN7bqiJV3aYALxNsL6YW5jpcl1
         6oqDLmzRuDlNalOK0f/Q3KbYVx67FQ952FuCmwTqrP/Vf4QYFZFDnplClitSZIIlw+hJ
         Jp43DvHsxGhBIIDFQXq4r0kjFjCZ7er+LiPeaIfzce7uJNu3hcNWn+cTuAgz1tC7E/MX
         xD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750364481; x=1750969281;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d2jLx/hVTc1t0d+pNKyT5Xpcz+rXvopf61vwCyZRr1o=;
        b=HafP/iLhfUncPeC0jPu0OV96S3pwYcl0vvBLOlUwuTkBYBoU6z1EqSld1Ib0Uz0LA6
         Sa4fKqTZksmolPv49mkMXxX5k0TuV7cgiwgV9rz1a5DdTcE0dVUvDaOvDPjj0DBBmg8s
         eDF0sFe1GgDpWUkPQrJDMjU7Je5rPJ4iP7PZLhS/IoK5U41ZZdmPxZzJecCkIbubzvsQ
         0Q/QQTycXcNPgNdIYBTWhRsyrG7W2CEHpAv3jQC/+ZPBoDpA95EgRaa7wdSaGU1Cc+Nd
         PmGCX5n+NeeYfJKU4z//9xBI6YiZArUrXKjmjxIjBtONgrEOPjZjzsxr1i8ztdaABVO+
         6baQ==
X-Gm-Message-State: AOJu0YxOXl4RtYIVhq1rrU0nQxrRjZE7q6uMSUdmyumSaNNOcp7dDUGi
	r+698xY3HlgNyeY7tL3WpjBn9AwYnaFsKmu3vcNZuN82UBZJHpRsNI0YuLYdhg==
X-Gm-Gg: ASbGncu1/UrxWp+UdZVPf8xXAvz/mciTVQcpqRmY5E+o6R37BcXq7TdlT+w7e6oyuLP
	AH9H4UjRCX5zQBA9wyIpBizav7bmf6R1MySwATEZSQ6vT7vHeHMUqMBcGQQwK4CQV/fpkbVhsql
	yVHjouGNlYuLHgxo1r3AxP44IcudyUh1PdBflylvHvXK9PhFK9q4waDR/K6zQPilpypNRGcm14r
	tvasgxv/Wg+Wtka139o5xxAr1Vt6sRiWL69VFMyZ6E29XtRRzH2PLyStqgDwLJ+HcJvRiEYxF57
	7k7OFJOA9XYolG8wd9iB/DBYjbINXsFoka+siP29n/CKS7h68ht/Le00wkCyPerAthMYkzFOy8g
	j
X-Google-Smtp-Source: AGHT+IHpiElFEP8uVhOMOeGknkzyDo9pJMUOmiS6R8p6U3qJzm+jn+XbVCEt/qWFFIjTaMKj01ySYw==
X-Received: by 2002:a05:6a21:9006:b0:21f:545e:84f0 with SMTP id adf61e73a8af0-22026fe8079mr387799637.40.1750364480784;
        Thu, 19 Jun 2025 13:21:20 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.40.22])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f118f7d5sm151277a12.12.2025.06.19.13.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 13:21:20 -0700 (PDT)
Message-ID: <68547140.050a0220.3aca6b.04d3@mx.google.com>
Date: Thu, 19 Jun 2025 13:21:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5481757301778444846=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] src/shared: allow passing in stream's own metadata to enable()
In-Reply-To: <dae73d42711856e8ea1100d0703cf861f8f5624c.1750359087.git.pav@iki.fi>
References: <dae73d42711856e8ea1100d0703cf861f8f5624c.1750359087.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5481757301778444846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=973966

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.40 seconds
BuildEll                      PASS      20.79 seconds
BluezMake                     PASS      2860.68 seconds
MakeCheck                     PASS      20.10 seconds
MakeDistcheck                 PASS      207.19 seconds
CheckValgrind                 PASS      284.44 seconds
CheckSmatch                   WARNING   314.53 seconds
bluezmakeextell               PASS      133.12 seconds
IncrementalBuild              PENDING   0.35 seconds
ScanBuild                     PASS      951.32 seconds

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
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5481757301778444846==--
