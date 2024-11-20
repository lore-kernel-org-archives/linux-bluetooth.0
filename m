Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DA1156F39
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732112517; cv=none; b=sgoS00mT/Kynb82WQJ3XFah96PtClfabmIBeutxSMXWfU66pBgqVuaFdyE7dL6GhHLzbPqreAxU8TZXOzXQhst8Hlrw8SfZWdiyF9Mz7XEYYySqAvQaomaLqlXqtgX84EaeApKhobBUjyx30Afzy8MBtqKJdIc2bAz60l6LF34k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732112517; c=relaxed/simple;
	bh=G9kXSTVxGOeF95NtX7eISMZrwkrPqCkZFPP5temCld8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=R3PxZ+nv+3uIFNVkf6JlPHYyQHIJfny8nk5W2JtQ/qFH8JZ0NJKOTKl440BD6JBU+B8/gGoLPt/8FRLCGpuHUqKO7wFsd8AShG0wIORehPgmdoGS4/jXI6EyE29decG17gRiktgQyx5ihT4XFySxqpJCJMPPau1cJm4agj28W/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFJFkhGz; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFJFkhGz"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e3686088c3so5076802a91.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 06:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732112514; x=1732717314; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cM/xtoCc7EP3yA+2HE3nLWBUdyI1vRXl61ynk9ZtaDA=;
        b=SFJFkhGzll+HwGUCkukf7HwD+2c0V29qCN4FCDmPIi+029ZVwENYY9GakT6dYHqlt6
         u6OnlAJn711sXnm3TYGPGKtRbJv5czcZu25Mja7GDk0GcukcLFvYdZ2pXqGVq++bVCWD
         5fWIHSVBLb+no0uDiylzvmYR/5yTN3lq8fW4iEwJuVyGVXg2UppPrynVnMxv0+BJ929z
         myYW3lhc3mMzKLehOLiSyJXFGKOULAVtnREvvy4GKYKI/6mTA55ori5t0erwa9saIVEk
         PH2UdF60Kl2eDwF2z5Qf85zaJJm5TZ+mFUYtudiywh30BIaRpNpTlgfIqqtQ4EE1jOds
         qFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732112514; x=1732717314;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cM/xtoCc7EP3yA+2HE3nLWBUdyI1vRXl61ynk9ZtaDA=;
        b=BwPbtzmqgGKr3kpLdGTi6MbOXstMViakzIDpyoSwullajrb3SZao6+jeecpMAVrAst
         oyu7bH/y0eUpBikMQGeoxg/3yaztN0Fr0uQrCMm4jQ95goakeQFLAvNhfDow9sUo89p4
         4OgtkGeEeoY+Mv0Xjk6BWUn5ba7RWPkaM37/+OebttUOZ+iqMMk1EL1P3PbqH/30TLdM
         WkX2bjJYUjRjKEh7yX76tGhpuBivYt1pX393Z494uSh7iCwB4B+mUvfqbSeaUBzWRPtS
         mI03BhAhG+m4L6Djzb9TLtNsHjm025xD8bCCQXq6swNnYMPQdAn6j3waUzXWW409j9lq
         fLlw==
X-Gm-Message-State: AOJu0Yx5ueEzAd5PmpKgKgjAaB41u+/V5tiKdnfpHmBRNeR6GuyDLFhk
	BsWOwtczYNXqtEG5AfCY7mZfA8g9SJDAUu2f7Jmzbt7LOeoEVPjy69+/wA==
X-Google-Smtp-Source: AGHT+IEEfGTYGvDQGzgV70+QHZKbtQWXsDnH2MeQo08UQH3U0z4E6ruIqZG3OYuIziuLIQcueOlVUQ==
X-Received: by 2002:a17:90b:1651:b0:2ea:853b:276d with SMTP id 98e67ed59e1d1-2eaca737dfdmr3703781a91.17.1732112514285;
        Wed, 20 Nov 2024 06:21:54 -0800 (PST)
Received: from [172.17.0.2] ([52.159.137.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead04f0a83sm1353932a91.43.2024.11.20.06.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 06:21:53 -0800 (PST)
Message-ID: <673df081.170a0220.b0047.4bd3@mx.google.com>
Date: Wed, 20 Nov 2024 06:21:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7962556169190954872=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, rudi@heitbaum.com
Subject: RE: [1/3] shared/ad: fix -std=c23 build failure
In-Reply-To: <Zz3eAJcwA--0n5lf@c8d99ad60702>
References: <Zz3eAJcwA--0n5lf@c8d99ad60702>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7962556169190954872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=911278

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.31 seconds
BuildEll                      PASS      20.86 seconds
BluezMake                     PASS      1659.99 seconds
MakeCheck                     PASS      13.31 seconds
MakeDistcheck                 PASS      160.21 seconds
CheckValgrind                 PASS      215.87 seconds
CheckSmatch                   WARNING   274.51 seconds
bluezmakeextell               PASS      99.59 seconds
IncrementalBuild              PENDING   0.49 seconds
ScanBuild                     PASS      857.14 seconds

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
src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/gatt-helpers.c:768:31: warning: Variable length array is used.src/shared/gatt-helpers.c:830:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1323:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1354:23: warning: Variable length array is used.src/shared/gatt-helpers.c:768:31: warning: Variable length array is used.src/shared/gatt-helpers.c:830:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1323:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1354:23: warning: Variable length array is used.src/shared/gatt-helpers.c:768:31: warning: Variable length array is used.src/shared/gatt-helpers.c:830:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1323:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1354:23: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7962556169190954872==--
