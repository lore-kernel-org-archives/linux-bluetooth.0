Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519851CD29
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Mar 2024 17:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711474072; cv=none; b=f07c117MSzeNwMCRRr95K37BfeyTw0E/GMJYC8kcttlLqTTInrlawA9/RBD11EyfogA8fYTJerb9iSNF34FYlq5vdOB7gzvRXqWkUAsKKQjE1puXJT5l401ZLyAqS4Qj9S2re7fohjsbfo2/u+aHdXa1Eo8M7sqGfukteAQTP48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711474072; c=relaxed/simple;
	bh=8FT+Mb1xC1k+SXpTvCi0In83owOVPi9NGQzqe/TQH5w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=C7V0DP+WCQrJTdfgP8QbDrP/NRZeuLG13Kj1SUfCkLsDob8n3iQdJ3jLbE2PjSjldwOh77857D38ysf16rjKpMPcf0F20Q82DXSuU+GFpKzPPd3/a45PtgBbdzI4Pm0BoeztNVGDOUcOA7iU8mQgDudVlsSMQg3NmshiqkLyEYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RklsLomW; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RklsLomW"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78a16114b69so4682685a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Mar 2024 10:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711474070; x=1712078870; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J1/avMI/XMQvsnnm/Kfn3WlN5OOHnf2HLY+yJmV1MH4=;
        b=RklsLomWlSWN4ibqGdBxS4efF2yk9FLp5xKaxSJeLu1eKSU8q3mV+MMQQoLCDwKGzw
         YmxqlaNQZLO3eNl64VjLyO3tTZqSSwxo/SiDEbSGCMhatZ0QAMK2XVtvINT273whG/Ns
         0/uZKsNTYYT2Mw++scVFgbREHipN39om0+mr8G8wKoT2EYASdwrPtsZnrOh4uteAWTiV
         +FoXZLmeilFweP4bOY3AqxlppcWvg854+fPce7+pw1mY/IDzDbCySUM1L5da/rZwdmMP
         47TJ508GxKRaNdMKeiQStBRX7w+IRMGgXxPc+iPYTSV4y5msfl3clPMoXFAVqMarHvq6
         X6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711474070; x=1712078870;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J1/avMI/XMQvsnnm/Kfn3WlN5OOHnf2HLY+yJmV1MH4=;
        b=kLy+SzXple1f5yNsuIeC1BUFbczPyHH/MyB5NNCTNR5sTEKm1EX50lrevdsW8b6mDK
         AjyWMskDp0LH/XamW/5R8vr218k1V5c7vQOzENcyfjEyOcI6StSNor3xKWJ3L9PjbQG4
         u8JBmHsygzd0V58RGL+4ZNwC7iLdV70UMVMQy/gZfTBpTh90+Nw2dEj7grkdzae4vYvF
         FfxwJ9l5p6hpdEE/7QxYSsvGrex35AL5Fv0nWFwJlxcEC0uYunHIRuWHI7j5NADo4Mek
         BRb4mMd1CFjql5P3YV/ZCPjsQa/l81dh5QlKhHr9oUzk4VdfZ3mjdHNgXim8tEf9SqE4
         uEJg==
X-Gm-Message-State: AOJu0Yy89NDtop6JOjioODwgrOQTkB7gkBCsohjA1oszuVm5XhSK6DC8
	7AK0SDoIxDsA9qH+NEMfp9lAKK0hg3RdipZyTTKBnD0ImBk/tiVwpt9jKHPH
X-Google-Smtp-Source: AGHT+IEDc5hAhXhHlo83/mmdvqYi9w3A07U+vMOuCF0fVKhKgewKH/RGiQq/ZySypysMlM0PF7QAcA==
X-Received: by 2002:a05:620a:f0c:b0:78a:5973:f34c with SMTP id v12-20020a05620a0f0c00b0078a5973f34cmr3046758qkl.37.1711474069824;
        Tue, 26 Mar 2024 10:27:49 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.159.137])
        by smtp.gmail.com with ESMTPSA id x5-20020ae9e645000000b0078a4bc3a416sm2703063qkl.72.2024.03.26.10.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 10:27:49 -0700 (PDT)
Message-ID: <66030595.e90a0220.665da.a8dc@mx.google.com>
Date: Tue, 26 Mar 2024 10:27:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6985813491298527580=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] shared/shell: Add script command
In-Reply-To: <20240326152012.1432957-1-luiz.dentz@gmail.com>
References: <20240326152012.1432957-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6985813491298527580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=838446

---Test result---

Test Summary:
CheckPatch                    PASS      1.02 seconds
GitLint                       PASS      0.67 seconds
BuildEll                      PASS      24.25 seconds
BluezMake                     PASS      1633.53 seconds
MakeCheck                     PASS      13.72 seconds
MakeDistcheck                 PASS      182.99 seconds
CheckValgrind                 PASS      252.68 seconds
CheckSmatch                   WARNING   356.81 seconds
bluezmakeextell               PASS      121.18 seconds
IncrementalBuild              PASS      3010.22 seconds
ScanBuild                     WARNING   977.78 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/shell.c:1331:13: warning: Access to field 'options' results in a dereference of a null pointer (loaded from variable 'opt')
                        if (c != opt->options[index - offset].val) {
                                 ^~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============6985813491298527580==--
