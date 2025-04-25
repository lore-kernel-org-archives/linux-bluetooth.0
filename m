Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CE88528E
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 21:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745615247; cv=none; b=Jq5GEDNPhEX1t+Sbmlza+qmRNZAPrXrLnaTh4zwON0hEoY9LF4i5GcMnsEDwTpQt3SQYFONxFW+DfT1cdDrCalvb/PPFW1qaHzeFZnyli0Jn0uydhW/xH/WHeqkUfJyyMuwBWMpgLHlutFsYD7qY3GboC+gLnclmAw0T4WzRfkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745615247; c=relaxed/simple;
	bh=Nymf/bxdFx7koo2GUus04wmYTXo2KQxDVJJjoLdAYSg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=huEO7SOou5ZR4kRH+v6JyBXHPQEQNA7K7gFF/fXSzlFdk/YSL0KXu1F2mbyeczT2VVHOxmTN3bEV/EwqNdj7ED9ba958rGIuIK2JLvG8M4PVJzAg/Ocw0nSq4mCKE0IO4WCto5rsTjOYLc1vPxjC8L+7wrKoT/H+B8Z4GYXxspk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdhM2i+9; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdhM2i+9"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7370a2d1981so2328770b3a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 14:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745615245; x=1746220045; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=37zpuMDBERA9ftKlCr4zmpVAxLK2pR3BCbdcit7BZHs=;
        b=VdhM2i+9EDr0Y9TKHTliwVWYfgMX1u8hHhwVXH6p30aEYJu4J5+yrkInXARLXGM9aJ
         tA3SNVnj8qnWQjJll2IyykIfHUHERq+C1cSdoSexvZK9jojx9M9We+g5dVI0aRVuHFYR
         u9A0ZZQfXOCBfY6T3dRPcBjXi+MwytIinxf7mxVc0CmhXY5LJQ1I1IiXO4p2AMityOMo
         Bev+CkrrIwXXfRySAsC6Vm/OiBpNu9TpZ114gDUkYgayRG3xKGXyNWVCWaI/mynb0Usa
         sltrozmJZTTgr3TScLyK54XWKhZtN+1n5AFiJ2gGA7pZ+2ta/BtAODHpNq9TexZ1jDg2
         1Anw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745615245; x=1746220045;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=37zpuMDBERA9ftKlCr4zmpVAxLK2pR3BCbdcit7BZHs=;
        b=jzJgQrXivMQNsmJqZWPl5I4eAqm7klGoV0PSGkn+YGCtx8aVXqUkGaAXrH/xL8WgAz
         CKMAXxiXix4jC3qyYg3wbNbv+y30QmNo9ANSF+ro5B0qLsbsMQkuKM1OD+L9ISwNH+Ot
         cFzZQgTeRLlnzHpIWKadaLzNELcMKy62JhqVtK9fTTrLHzvPSt6UYHgMpILakeJxRv6s
         JkHQp3O7TZoCWU3l6Z2XbH0Mm1kNq4XMmXPJjtUoJEypI8i96+oVSbX5mpZeY42ITO1Y
         OS0DulskIokucn77PweIsd4/Q8j8F4CQ9em0eOLkIMEkgmJN/c+Xs7lyjaOYts0P+ukp
         FDpw==
X-Gm-Message-State: AOJu0YwNhdxTpXJFU7wRfK5ESijULbMYPyJvN0QTTzM+0q3quEQLlzpg
	qBZdk9IR3X9pg4eDnIhVnLYOEKJm+ESnP15LCJ4mnsTFMtfzQnX16IbrBw==
X-Gm-Gg: ASbGncsfhne31xXCIGGLisugAMXRtQcDLHXrwXbSJ04JTba8yW5OToaJNiP50pzdXlj
	I3i9Ess3cYxgGv19MQrnyXiPFqbCFt5zTlGBwEwZMcSdluOUU0x1zR6QEat09JYhlTqvF1fkqJ8
	H9cZMEX6HK3+A9WFzLocYmPhhbS1INGen4RzExQ0szC01IuLqrZsvWTp5pnTEwW83MmzNXJenjq
	T0eNO6BsTpYe6yb+yOMDD3yqEUtgTmrWCBsn7k1taNjto/eiq1fcRM0kpYnjdaJo8OnC7mGB+8z
	uhqaOfwwvLqBnoU+XH1Oen8zD/8PHqaRrwKjMBvAkWD96g==
X-Google-Smtp-Source: AGHT+IHbxESNABnVuNU+GiVAu/cJKEVdlZJRHeoSmOY7modjog50oquPTjQw9dBH3g2CSaK6nIKDpQ==
X-Received: by 2002:a05:6a00:2e83:b0:732:5276:4ac9 with SMTP id d2e1a72fcca58-73ff729d9dcmr1018935b3a.9.1745615244900;
        Fri, 25 Apr 2025 14:07:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.14.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25965b82sm3646469b3a.79.2025.04.25.14.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 14:07:24 -0700 (PDT)
Message-ID: <680bf98c.050a0220.33d08f.faa7@mx.google.com>
Date: Fri, 25 Apr 2025 14:07:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7747299745165658775=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/ad: Fix crash on match_manufacturer
In-Reply-To: <20250425194531.1582203-1-luiz.dentz@gmail.com>
References: <20250425194531.1582203-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7747299745165658775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=957173

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      20.27 seconds
BluezMake                     PASS      2617.55 seconds
MakeCheck                     PASS      19.91 seconds
MakeDistcheck                 PASS      197.64 seconds
CheckValgrind                 PASS      279.15 seconds
CheckSmatch                   PASS      303.47 seconds
bluezmakeextell               PASS      130.17 seconds
IncrementalBuild              PENDING   0.28 seconds
ScanBuild                     PASS      911.32 seconds

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


--===============7747299745165658775==--
