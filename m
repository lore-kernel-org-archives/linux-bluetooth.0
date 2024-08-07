Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7BF145FF5
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Aug 2024 23:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723073076; cv=none; b=VkGpdYH4wh39SK+cyRhhG2D/71E/UbfEF7Vmg5SGA3CTtRJ6hOV5BooOivIUYT64xDmG8xQhelUO/o4GStKwu7WGWmfYydwFyh23m2Uf2UZIdJafV/OZ67jvRRh13kYrn4ynrWTAcB31+MmiSBpCSSLPpLNyGXLH5CwCH4r/09I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723073076; c=relaxed/simple;
	bh=guP6xqs1y3IvxRmu9q61govp4k98P14Dox9emvUbuEs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OQKkUZv+lXEtOYnrR12QEMflFVmBGiYy7BBKwXIPpw8+8+1XPNTJj1hWKFzqs+6qks24EUJno6rh/R2Ei0n9MQIHeBcMuA/uvEMLZ60QlIiDp8E94vj504qrcXPXlyz1puzsW8n/9ca0bLyUrZFpjEFUXXynz+C9SNu4ZridOuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bnq78Rhd; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bnq78Rhd"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a1da7cafccso20175285a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Aug 2024 16:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723073074; x=1723677874; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kYd57YHeei8a48Q4v5T8Kka3CcIJ+ugGNg9A2Ly/bYg=;
        b=Bnq78RhdcF7J70VGO2vSq1OlzX3JV7SyQGarZEs3OYmsswjr/FzJb08uKulTqaziqz
         RU4Mn7H1bYZgsKjnC9C9rZcU+3LZ74zEwxVQY48Xxtz2PkGcPligtGE4MEQKd9IB8Dgs
         TbQoApDg+ePaj4YST3WQ/8lauN7XPdb+QAPLjtqnHPwBQVe/VfWzPCEJZEYWNX//o7tM
         8lBq9IshpqTwks5dK26vp2gyq/K2ts70fHWw4vFghvQRCyNdugYXorJDobFP/w9jsqfD
         u6il5SzYNKhUMKsAJ0JSYSq1wLhWoCbREkNp/FeC5lMz2IZWO8tF1/9hfHYzPFRsaeNZ
         ZY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723073074; x=1723677874;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kYd57YHeei8a48Q4v5T8Kka3CcIJ+ugGNg9A2Ly/bYg=;
        b=IncFtdI7aTObjvah+bFxwWQZYJuk6OSL8OONMKd0C9QjXRqen2YtkM3AkBbhtnLPia
         mYEf2iDms/+riIsQyo6FALODbcuigQRWP2MdEUjqICwqZisciztR5lTwTlpWQEnCTM5A
         GjIOUB35G0V2Im/EfSuonhENU8CEbwWEN3zU/30ARWwHxIOtjODnAD9ETXnHSNjYOMfE
         qjeYBwUmWXUKomFre8gbg9gt2wfUfND6boSjndUxfpeEpFV6dSHuTR+7PPXWDwJUcjE9
         8xWhLB8yIr5axrsOr766ywO7V+J1xCANP3p6IDYHZXaXjBxCA9iq3Y/fNbPbuhlH8Pki
         pAlw==
X-Gm-Message-State: AOJu0YxYTIgegF2IxAeKbRqdUOrxGbG7UfhCKQwhLEFp9aArTvEPhN2+
	FF+tefMgzc9HcgQiu028Zv/3Z9enQvWiwWnCUn9fuwzZ8OKlvMVVY0u0yw==
X-Google-Smtp-Source: AGHT+IF7juSB0PuZbhMmy9aFOu5q7xE9DY8XatRDVh+MBRdVPrgn5JtqytKEaLiLU2EG9WHLIFTCLQ==
X-Received: by 2002:a05:620a:371c:b0:79c:4030:d891 with SMTP id af79cd13be357-7a3817b96cemr17131985a.12.1723073073877;
        Wed, 07 Aug 2024 16:24:33 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.106.76])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a378693d2esm101903785a.82.2024.08.07.16.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 16:24:33 -0700 (PDT)
Message-ID: <66b40231.050a0220.28a709.4365@mx.google.com>
Date: Wed, 07 Aug 2024 16:24:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2190931496348140470=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] shared/shell: Add support for comments on scripts
In-Reply-To: <20240807212818.193908-1-luiz.dentz@gmail.com>
References: <20240807212818.193908-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2190931496348140470==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=877581

---Test result---

Test Summary:
CheckPatch                    PASS      0.96 seconds
GitLint                       FAIL      0.81 seconds
BuildEll                      PASS      24.48 seconds
BluezMake                     PASS      1618.00 seconds
MakeCheck                     PASS      12.90 seconds
MakeDistcheck                 PASS      175.25 seconds
CheckValgrind                 PASS      249.80 seconds
CheckSmatch                   WARNING   351.45 seconds
bluezmakeextell               PASS      118.40 seconds
IncrementalBuild              PASS      2856.06 seconds
ScanBuild                     PASS      985.78 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,2/2] shared/shell: Add support for running script command as part of script

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (85>80): "[BlueZ,v1,2/2] shared/shell: Add support for running script command as part of script"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):


---
Regards,
Linux Bluetooth


--===============2190931496348140470==--
