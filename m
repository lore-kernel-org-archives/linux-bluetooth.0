Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D51312DDA1
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 17:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763055080; cv=none; b=uufeqapjeFAi3719/3Kqk1iWk7+8IMXFvZzF7KSdLQG8QRcSxnjurB9cWr9LsBkNZPtbR13+QJ57QAN257eAzUvL5vhoK7cKb5fQSAbG+YArdNimHypwQyuffEO8RtzQGRDQUZPz/hzJsMB87g44uA27l4m8yCIz48dhgbV3GVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763055080; c=relaxed/simple;
	bh=vu+1KiY/ogxlJdSLZwxjQNF8vKuI3JEONW09G4AG+xc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KpLUcJ3I5o/YU0GxPk3tU4+RsRF5jpe/fMfQMeBG2iqV5dma2dXpJIwVvollBUgleyc2KymaGhOZ10z88IQT4VQEE9KeQ+nZ+7PhgIXpB8Yl2AxD435yOk7w2u+ApeiMDDPAIOtleveaATpQTKZnEwgfMoM+xrPjawpLxUp/f3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pe4xHv3Y; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pe4xHv3Y"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-948da744f87so23597639f.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 09:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763055072; x=1763659872; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IBhEK7QOCifNK6LXjVPdkKojzInwGGEkGm2ekzNOpo8=;
        b=Pe4xHv3Yx8nX4F7qf9YrvxNTJqcqbvFbEkkmA4RpfvMPKvjh4zsg2zH1EhmP6itXAQ
         HYFMOgfC+vU5uDL3bt0nJsu5bpG5/M0YklqOrGy6aEwNvdb2zIZfttD8qQJT0K5Li4t4
         m83v/42/TPhuDAu70FepOPBPKDAqIaCxlMRasefHfIDPCFaLMGR8HspeqOqBOr2xIL0n
         cH8Q5JMpyHgtfUtUMOio7Bax/BtL9zFoqkzZ7Rxtt/P+FkXv+5LFJ3+Y2bwQTQZdiQcN
         e2Iopk+sO3a6N3tZdRutDA7n8Mn+yYLWRZMxbXlO2vt41GS99DOauGnS3b0x08PH/xKh
         /rwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763055072; x=1763659872;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBhEK7QOCifNK6LXjVPdkKojzInwGGEkGm2ekzNOpo8=;
        b=KRv6Da3bja19iVWEvbEJP6MLNKifAEwMzCmFbiuGx85UeO57AZAjHCVAEIGVPlcmBg
         VHXwq5DKvXJneiynWFz1POqlCIrMesa4SQdyrL5SpG3gVrcZwr8ZIk5bBJ+vy4ExvyAH
         dbmjl9CMTK/uPo35RhmRr+j8af8eSiWQAQwkndM7XtgIoBYYFONXbNB4YhFHSh6sDnUy
         07cPCLpE/D41uRx34fmRhfeNzRXFmJDxeJbcCFdr8NS4pz9d722a5/fbnkLUMi0v7+Tb
         sXLJsaCdoXeVNL0HNNELi4rINK5MH5cQvyUJ6GaI77iUsYzV3A51SRHQ7gHFLZKow3ME
         ZTuA==
X-Gm-Message-State: AOJu0YzMQmH/qd1Vty9sH9chXWuINtBuUFJk7bqaxd58rzvfx715qbYf
	hFWd85W1pM5JuvwslV+BW/2Ow27hGHH7jGpMKHkhmORemavLG08rd6AWqiNYTw==
X-Gm-Gg: ASbGncsoPBXfquI5OAUlhqYt0DIotHRoAbPIJMqbytifY2ie8Lvy9L100gq88GICCkz
	7eC5p9WQlPUoXnAwIIbhp9NWTPuersATPxZo6ef1nu4XJOSISSDxy21xv2WnnAH6sVgPtKcYdG8
	ORryEmCJ2ABxNHgbpYihwbUUZ/hEQFXeTT92JsN1jhjYT2VN3wCj9LsWP7NrKjiQ3mMchPtf7jD
	7a57sL4ETlSG2Gnz1cIRAPWywNCSyvaNEJkv/z/NzC1+QuO+CC/NNc1AjCqwgpavJs0h5/mbvVJ
	49B+Dj7cZbGY9mllWC9YRiRz8zBmR+xW430ZqFi1JbgspOF9O+aPAG9fMd3vuVjjJuiiyuXNtea
	5rtTzH1+bGOhkKB9SQYCnHOFyeDBfDFfn1bkhqTmkDcaNXp6fl4RZxgkCMaP3IBfnY+1H+LMR90
	lSTkM3pqt+lAho/ycEBA==
X-Google-Smtp-Source: AGHT+IHKOeN1Z4SCqqrbUL8xAgb5XmYETb7jC+kRbaTb/L760IXmZli+wfZW8xb8jByvfwkXDaYlOw==
X-Received: by 2002:a05:6e02:3812:b0:434:7797:bdab with SMTP id e9e14a558f8ab-4348c8c2490mr5112315ab.14.1763055072062;
        Thu, 13 Nov 2025 09:31:12 -0800 (PST)
Received: from [172.17.0.2] ([135.232.224.97])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7bd315e75sm917974173.36.2025.11.13.09.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 09:31:11 -0800 (PST)
Message-ID: <691615df.050a0220.e3efe.1ed2@mx.google.com>
Date: Thu, 13 Nov 2025 09:31:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0365676240715780479=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] monitor: Add page information to print_features_subpage
In-Reply-To: <20251113155818.2628720-1-luiz.dentz@gmail.com>
References: <20251113155818.2628720-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0365676240715780479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1023061

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.32 seconds
BuildEll                      PASS      19.91 seconds
BluezMake                     PASS      2632.97 seconds
MakeCheck                     PASS      19.94 seconds
MakeDistcheck                 PASS      185.32 seconds
CheckValgrind                 PASS      237.67 seconds
CheckSmatch                   WARNING   312.46 seconds
bluezmakeextell               PASS      128.61 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      924.97 seconds

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
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1931:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3866:52: warning: array of flexible structuresmonitor/bt.h:3854:40: warning: array of flexible structuresemulator/btdev.c:461:29: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0365676240715780479==--
