Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5B717BDC
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2024 14:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807002; cv=none; b=Uqkx5Yka5d8HgCbQd368tzjNhc6ApusoAcMAud6y8frAQTixfBWKwYyrtbxuehZCm8vKVO/IS6WIQ2u+Ah/rLnCEC6TsDZgh0OFGc8CcI+j4lqTbVBoaFyU63n7jvSJ8grzSXrLmXIn24vcQ+t/Ca4LdJsH+BXzP+Bg10UvoaHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807002; c=relaxed/simple;
	bh=DGl5PT+0Fs24ksD5bYl/Tnl3htLKHxETlkqeY2NsZ2I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=G+Zyow+tLXsAGg0wXckwQHvWEVukbOMUqBlcTYLvs9Vv7GXtJmFpj4MHgHpQ3xmYlQkXerd6th9Zm21qetEJLlNF1fkiyZyFcEDC6xu2TuVhWE5XAXguW5LHYkbtJobELirMSfwi1VGwiZVcG7bKqLibYlVgnQ4GuAoiCgfva7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T02mNFoO; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T02mNFoO"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b4fc2b5277so7025416d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2024 07:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718806999; x=1719411799; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TOtnTyUAHcnhkPeQRFJkUtsv0eMM+4okIErCY0XG+lY=;
        b=T02mNFoO1doo27BUmst88tw3jWoHRWC+9tDmDifdx6DC6hT+Dg734E5/IMpJKiOL/+
         5Yp0N+xInvWBBciiULkAn7XGmeq0ocoOCmcQmOfBRUTEcxNw6YhZNDE5f5K9oYp60W9f
         iGuDTe/h+RSCOkKK2bWIOTAD87HKcP2GIfegNfk+EgxaBP10STV2NhRPwytsOn4XK6ZH
         c74Rz43MiuZZmEPNygbecTkVZll7dIj57RuUzKBWTRxEQEVwvUMEMe3y2UY0rO399+Wg
         5Sd05pTNDGqCC9HFn7YHFEnHKLXQQfO7xVcRI1juxi47QdTw/RIZ3f6e/aCALK6ywG20
         IujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718806999; x=1719411799;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TOtnTyUAHcnhkPeQRFJkUtsv0eMM+4okIErCY0XG+lY=;
        b=mwycK5YfpufrjcLAA3Lzqd1ml7AJuvZ0rSYe9qsegQjm90DT8g/NHpkpenO1ChWrwN
         YlcQrRz8KWUmmzGcEKouyOBwJ9MofiZq+wRKpkGqqz2XOo4lo9Us2DrsHlbfA6ccwcRm
         9UQrwMkAHVfDThoG1mUdD4tpFgOlEsKrvGgnhEhMyUXeX25gAYD9DJINHQZSqnazoGf5
         SjRdL6lkhZDfCxxEfzEHGM5ZNmbqOsY7tIBuruy1PQUJKmc3tlxgQ393cKdgnlMDg9w/
         WbcrqnbleSmy8e1OfTwiN2UTjJKNpmofJjPNmbcbtp40wGr6KJRbiPNV2O+HUVN+2ghB
         gk3g==
X-Gm-Message-State: AOJu0YyXOquPe8J0GuNWL+H4OF1AIMfKfaPBMoU2RJvz0NzJ2+g4JsRQ
	9GLTN2EwCN7iGMbM1zjeARTg17fdEvEzUfyEVmhOCT9B3azvETN4JJA1Fg==
X-Google-Smtp-Source: AGHT+IEYdTBP9H64XCfcK4H83rU0rc7qNw8gGVZI8KntBhabztYKsH+LrUZlEDW+sjv8KzkVKt5T7Q==
X-Received: by 2002:ad4:4bb0:0:b0:6b0:77f3:be9a with SMTP id 6a1803df08f44-6b501ec7f4dmr25472656d6.60.1718806999311;
        Wed, 19 Jun 2024 07:23:19 -0700 (PDT)
Received: from [172.17.0.2] ([20.84.127.109])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2de9cac51sm26506906d6.23.2024.06.19.07.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:23:19 -0700 (PDT)
Message-ID: <6672e9d7.050a0220.f618d.9323@mx.google.com>
Date: Wed, 19 Jun 2024 07:23:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2265726778110433656=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yauhen.kharuzhy@softeq.com
Subject: RE: [BlueZ,v2,1/2] shared/mcp: Implement next/previous track commands
In-Reply-To: <20240619120433.3666313-1-yauhen.kharuzhy@softeq.com>
References: <20240619120433.3666313-1-yauhen.kharuzhy@softeq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2265726778110433656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=863418

---Test result---

Test Summary:
CheckPatch                    FAIL      1.15 seconds
GitLint                       PASS      0.80 seconds
BuildEll                      PASS      24.92 seconds
BluezMake                     PASS      1708.96 seconds
MakeCheck                     PASS      13.42 seconds
MakeDistcheck                 PASS      181.15 seconds
CheckValgrind                 PASS      255.98 seconds
CheckSmatch                   PASS      366.72 seconds
bluezmakeextell               PASS      124.83 seconds
IncrementalBuild              PASS      3141.47 seconds
ScanBuild                     PASS      1103.64 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,2/2] mcp: Implement Next Track and Previous Track commands
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#92: 
Add implementation of Next/Previous Track commands to the audio/mcp profile.

/github/workspace/src/src/13703755.patch total: 0 errors, 1 warnings, 29 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13703755.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============2265726778110433656==--
