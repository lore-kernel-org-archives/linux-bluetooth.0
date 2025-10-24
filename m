Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C81F1DA62E
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 22:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761343650; cv=none; b=pLzixnorN4jV+4drypzLbnCvdhKJuBYSZ1a8xFFwkJS/t9LBEkf828w5YTxSDzd/qiW4nP0MyIraw19tK4nstR8HzaJtW5kpprm3X/cOFwFxRvWzqRT4JKXBkpjCkqRrqqNsjXFbgFBawkb/Q8MTlRlXHnTbvoiHXTo2sxgY50s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761343650; c=relaxed/simple;
	bh=6q3Ez++GFIelpgsLgfkuBn0J8O9f3VG06ldKUEkC7DE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qvMKik1P/zVOPg4/Cg/dseb2xT25oZP2GBFswmaoE3YKmj1Syssylf2hqliga2WyXZZmUBSqJ+gMAuL6B67sN6I4Kc8AzqaEpf9VbTSFn1D6kTAkggfPWbvA1hAsye1tDGX/MHtHubvJj2IWCiFoXUUDev0sG5frsuxHQ93HGG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYgxgj5w; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYgxgj5w"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-87c13813464so33558906d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 15:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761343647; x=1761948447; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4YudlxwpGmlO5/sn0hrYGeKgdAhh+9K+VU8DvPc4PpU=;
        b=KYgxgj5wXbpd8l/tDdZDwg9pINrKoV7W2m1rysFCaIFTQQhy/C8VOQaDUjApA6lbiv
         loK4dkwyuzzkRA1rJVEfjSoG4CvJTPjMRA+I09DQkRi28+kfmhlR+PyYi6Vg+rqvTV/M
         FMU++EvyP47Aw50dkdThrL/z95SdixRW0wQXCjRY3WpSNbS8JI+/Ak0jrQ3Wk3ovX88q
         rW3CQasy7iGMLXzzEMhmKvqeL9fH19q0TZo80AqgT9QGzXNeO60zriDIMOsDRa2wGyGO
         dMKj3vhZcnc69h/xMH++q6Zf+pmQ6X8MiY1yyOxr7ZhhEMFx3TYfjXR+ibPu6GH/DW2L
         r70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761343647; x=1761948447;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4YudlxwpGmlO5/sn0hrYGeKgdAhh+9K+VU8DvPc4PpU=;
        b=FHd802X1emD/fR2RHYxPYfKIiqhAbb0bJ2tzLYyigIdoppFkR5Ls6THim4zxrNAdkP
         2mDFPoKfirRkZyKTVbdN5LlvcMU6cjuCeL4utNUCwCPknTFBHsGEAc0dOjK28T9uSaM+
         Jb8qHHMYH31bIK4qevYCCSqkwwx0TLGBD4ZF63rntKfoXU08rfEK1idFlmzJ1TfyNWaX
         bWBi4qFL6XbuNRx1poW7SSxdU8+A4QzXIIcZIoleZlnRD9igWhcV7Ce6c381hEowZEua
         Dkhpml4WDfhrnNTGAdNYJqyJmqw2B2BM00ycbV3pY9isVSugfi/fYbV3HlrT7OL2ilhq
         1jNw==
X-Gm-Message-State: AOJu0Yym3LwqQJMZDCkKl4a0muGObHFWBO2sSgE1YjvfV6RE835PhZGY
	gflhBxqNCcryM7uu1hQwt9g0/XxYe1G668Xu9/EgFrZjpgcCk3SiPL4S1niMHQ==
X-Gm-Gg: ASbGnctny7HiOdSLU+qapMgnABYMyKa3mQdFL3siz7rsLjHCV4YiSNLwjOcbTpXqo52
	Ctz1raQADF1Oo8xHBXsFpyvz/IBFmQl9gNpDagv6/JJRLVjpxGAKleZiS1lU8eZySPfeMUHFWw2
	90DBcLvo21ysL8vvOnOj9Rh86zAaX+SgXbJfkaYUezfGsKMpHXlmPS7IsUxb2pecYu9y3SPW3uz
	3uqU6v2jQ9PvNDosgwBxfC/mkxVPTd5t6ZX2TywM9AXIOPqeIf7ci+861W/Uky2vsIMq18h7CiH
	k1IeWC4L0a0GoTWAa1nABPopkkNoQnDPr1M1XxpUYPYmoUlEetuNDIsqoiWHyMTRZBZSB9fC8QL
	HZrKF5iuzcVaRsm1W9WJ6VsK1skLQw2daSc0Ji0CtPv71mjAbhtgwpCW9Wi6X0YIo3fKcJOdqGJ
	RN5GRQ54KAHnAhgRRs2A==
X-Google-Smtp-Source: AGHT+IHDSe1gIA7QMKxUHL96JWgFIvj2OBsfuRdV1mu9VQ5PE/YqlvboIDZJyzp3Vb5tnm6WS3RYqQ==
X-Received: by 2002:a05:6214:2406:b0:87d:e77e:4df1 with SMTP id 6a1803df08f44-87de77e4e55mr191646816d6.60.1761343646903;
        Fri, 24 Oct 2025 15:07:26 -0700 (PDT)
Received: from [172.17.0.2] ([145.132.103.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc4934fa1sm2186686d6.32.2025.10.24.15.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 15:07:26 -0700 (PDT)
Message-ID: <68fbf89e.050a0220.1fcc29.0dbe@mx.google.com>
Date: Fri, 24 Oct 2025 15:07:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4665709264732576748=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,01/12] device: Add initial support for setting DEVICE_FLAG_PAST
In-Reply-To: <20251024204039.693918-1-luiz.dentz@gmail.com>
References: <20251024204039.693918-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4665709264732576748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1015647

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.24 seconds
BuildEll                      PASS      20.34 seconds
BluezMake                     PASS      2693.38 seconds
MakeCheck                     PASS      20.63 seconds
MakeDistcheck                 PASS      190.09 seconds
CheckValgrind                 PASS      241.66 seconds
CheckSmatch                   WARNING   316.05 seconds
bluezmakeextell               PASS      131.28 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      945.85 seconds

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
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4665709264732576748==--
