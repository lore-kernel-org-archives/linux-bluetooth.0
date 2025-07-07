Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E21421ABAA
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 16:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906028; cv=none; b=I7keCjTsB61LxGN0xk/zLqkW8+00C0jsrlCB0s27GSeuGO0GGeCREBpOZeh3Q3bin2lHfVeD7hrOpxrX9VIxwsPayADWRHs5H95C9JI7gujFg0OsB/JFrJWl2NCxfPzOm2djyot+jncM3x16PfqzA2j9dUbQ/kjEFeAxIN4l1G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906028; c=relaxed/simple;
	bh=BtQhZQisICXz2SkPg9ZGUPUAbIUY9rOAU8Cz/w+rqnk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=S7t38JxGRvkJEgc3BcbiLcDMMNC6Y0yN0FtEHsvtDaWAKfIRKijTXggtL4/oCZ2Kj1OAOcGIAaD5KcAg969TRcLhiz4grF1wXzEGOnPJRaz3X5mq4i8Wil5OGiE8Bqdwc+ZeVDcNEiaJCjpVb/rEROBpnFt0aIDJRRVZ71D8+ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fn0PO4ER; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fn0PO4ER"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d7cf6efc2fso121172785a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jul 2025 09:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751906025; x=1752510825; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FZ4T9rS/Ggv+ppysKFMcQbYBxX+DMQs3ZpAYlTJi+2k=;
        b=Fn0PO4ER+rB5t4+YC9yyIgDCubVU2K8gACX10gTlxn8TBiHOsFrBPA+0+GIZm7BV0s
         BBxtttj5nodnKlSRiEiQCNIA0ytwkfaK6LPgLGFLwJzNA2R0L8DIN2V6Qbb/b//HyC+b
         C1F7jZ9dV0SyFDZvqTGRs7bIplnYudhqkuX1hE0cTSFMB7zzGrTKZ7oQnexYXTPD+f0G
         CSC8zifR5Lv5BXS1FWRkTzOFVBSCCFEBQnc9tdzcW3rQS5oL7Jyr8xLOnEdZV3IUX1dH
         U9naR9Avnz5HUACdfUoS83VY3sZVZUO5EL7/NKc0Dqwf432WTcU/yOPN/VYAOmu30Ed7
         /H6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751906025; x=1752510825;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FZ4T9rS/Ggv+ppysKFMcQbYBxX+DMQs3ZpAYlTJi+2k=;
        b=Wbj8kxjIERbBCDOsJUxjW4jOtJu1fXfGAH+8sUbUeIwKb5yQJWbugk9HTYgkJYowf4
         5J8eT7Of6We4blfOqoqywUeDBj9AWe7SdPxfzELeMqtcFuLMqh6IHUQ4k6OXWPq/3m1d
         TykHC6M7LWviaNcYR0TIl0JK9rOZlXDJEz0zFEbPBTdVES3ISCByh5z9oO4Z/dz3+LZt
         yiJUJ3aiRUsWwTsWiMqhdDBjs4lgDm8NfyAbGuBd0H4+PB3ZSRnVJXb4lCe5xAW3EG2A
         k5C1Cn0IaTpXlP+AQUKQ/94fDpmm7AABR1eCUu5bb4WqtE8TcafEvwtQrdi9iFZ8KD2n
         IXKg==
X-Gm-Message-State: AOJu0YwSXbPGDsOqJDyYwvhoEk7ikS5Xmcj3Mc4oFe7SROUiUPznunDA
	opc/I6xX/O2FuuBAcs/Cx4AXsOOkXEqXacpvvGyA2Rn9moz66mz5j6lqio24IW0/
X-Gm-Gg: ASbGncuHjYG3SPJAUwuVblw2I16vF1zMLYHOORkLyLxbQALHzPmkX7rzRKeGOhAUKBQ
	oTlj1eucZKTopzPWIbPbJ/kS6tFU4FkhJzSY8siC//Q3pgZno07Q5UWTx1BdfglAbO0kI6HOKe0
	9sgyAh0mDKe9/3/cGRbbisquv35eWinSSCGVZPsLRuajViz3b+F2Ia/IEKbNFB0vdTsXcn4aP8K
	XP9u0XpL2aD3ZP1ycKRkv0UxYyA8suTYv95ILqKUkSczu5b38xNSovNjvIyuVd0KDhBuUVx7DBp
	998L+cy1AOrQyOweFddquEFhz3Og3yr4ZJsHBbZdRXWLJSV9wxUpIq10hyrqxJ5yJnCc6FQnnn5
	UEeyK
X-Google-Smtp-Source: AGHT+IGE923LOJWcIZm0ZWWhXXDWiBHSdEnEZ/k2SsiWH6pJR4ONv9IGpmBgybpU+NiHNocTG00fCg==
X-Received: by 2002:a05:620a:1:b0:7d5:c317:f656 with SMTP id af79cd13be357-7d9eb4d6d94mr3047485a.18.1751906025066;
        Mon, 07 Jul 2025 09:33:45 -0700 (PDT)
Received: from [172.17.0.2] ([20.119.185.143])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbeb2052sm629138285a.106.2025.07.07.09.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 09:33:44 -0700 (PDT)
Message-ID: <686bf6e8.050a0220.1fbf5e.68e9@mx.google.com>
Date: Mon, 07 Jul 2025 09:33:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4374468282045721269=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, i.iskakov@omp.ru
Subject: RE: Fix double free in obexd/client.
In-Reply-To: <20250707145242.2356210-2-i.iskakov@omp.ru>
References: <20250707145242.2356210-2-i.iskakov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4374468282045721269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=979723

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      20.29 seconds
BluezMake                     PASS      2553.27 seconds
MakeCheck                     PASS      20.61 seconds
MakeDistcheck                 PASS      184.93 seconds
CheckValgrind                 PASS      237.09 seconds
CheckSmatch                   PASS      305.93 seconds
bluezmakeextell               PASS      129.42 seconds
IncrementalBuild              PENDING   0.28 seconds
ScanBuild                     PASS      916.91 seconds

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


--===============4374468282045721269==--
