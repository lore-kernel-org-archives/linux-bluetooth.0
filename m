Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C4515099C
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 22:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712959486; cv=none; b=paXrwHlm1aAzsZEsA/erG5hDDevv4uGV+FmrTCBjnuu61FFVS9Wu4QqpRShISuTaKe/kFnlzCPYB7/qkMuIlVMsCX7gAriGqJWQ5BP0brQoeGhsr3KSuhr+x4Evtf4zQzUX+SCo245kRXPTBhSmfswZIq0MnTYc/LPys2rv1wYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712959486; c=relaxed/simple;
	bh=ylG1ZNyDpQ9qN7ow1FQg5FKYjYKvxJg/KnGhGE9ieCE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=S9gUFexIUXTMo9IxoSMLgICl6gYoraYsd0eR/SpfDcVglITZBE6fNi2iBUJx+47nAR872uiWL6ZUJpUh7cnNEyFSvl1zZea7QhwCrpAQ5Q1zrKF/sq3ryEUtvS5jizzfTdvOj1jdooTNMBxY7fuGLnmGLzH1RXid4m7DP6JaeQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMwb+NvQ; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMwb+NvQ"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78d57bd577dso108749785a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 15:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712959484; x=1713564284; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8VZlYsDOuKRCzmHCZ3M2Eevh0flnPReGG5UFJZrphrE=;
        b=SMwb+NvQFtk3a1Uwk666YcAaOP4p9LD9MJy3l7tluxqpTbh+XI/9AvGwMhb2/Q9Xir
         X9e/a7X3uLR9l11sk79vi2m4pvEk05OGBAdWuYPVLG00/jiT70ERJLzDtLYm43YCq/eM
         RefOHTRekVg4ZfaroCHhiRkUJbos13lrcPf3Lcu5rrUr2YAmIMBbs0B8XH8QPBTTCBRj
         F0AoyBqPxB0d8Of/PZ9ZNop51N54GejPAiMbCycVLQsmioDvrkWcEdqLQlBbKmltdOdj
         1UNqBKY4fhF1hQutr3QgGdlZe2rhAw0+TXqDAk23xdt23IVf5PBsnbIdetvs2PV4wz9L
         WFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712959484; x=1713564284;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8VZlYsDOuKRCzmHCZ3M2Eevh0flnPReGG5UFJZrphrE=;
        b=VM7IV3zvlLmvnavWfcKBjsgDCVoK69iw4+XKm/19RggSqriaqxz8t6MzR6lu+VOB82
         2IdclBw/iEQV/gf01KCsOmAqvosW/JvDRma+k/ydDyTZxxh5OPAT4vODRWu7pgzkrq7O
         tcPpGXSIN4Obm5F4El79nsljVE24DHaoYWBW1xCSsaKXLKpGbOJ8cKWrzMsYi+/DMCjr
         ax8VQAEodBFQzipcL6NfqwF2kUCllJw+Nos7s7y0efdVirEIms97+40mALhbodQiwa0K
         ef/vlGIGSSBCytu+gHUCcNY3ZsHnLGO4WqY3jHwrbtBWYVYz/52dBzhBxyLludySb0pb
         /Dmg==
X-Gm-Message-State: AOJu0YzokGUXzKcqHmhiHIF78j+mC9Gy6a5DTZQgaAZdru/q0HdT2DBV
	Qvl9KmnZodEyn5t7gPhc2otm+++gnTAhLlejbI00PKZPYZGsSi1qvxkSeg==
X-Google-Smtp-Source: AGHT+IH8lCHmzqE/fZ7EUQ+YSl/0nr/MfzjEgDBwNTmpyA/d+vd/BCAJ2WSRe0iMOy6KsssyNdsd9w==
X-Received: by 2002:a05:620a:678:b0:78e:d54c:ebd2 with SMTP id a24-20020a05620a067800b0078ed54cebd2mr521987qkh.3.1712959484194;
        Fri, 12 Apr 2024 15:04:44 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.106.66])
        by smtp.gmail.com with ESMTPSA id m3-20020ae9e003000000b0078d4bca760asm2930465qkk.34.2024.04.12.15.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 15:04:43 -0700 (PDT)
Message-ID: <6619affb.e90a0220.ddf32.7a57@mx.google.com>
Date: Fri, 12 Apr 2024 15:04:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0517219152835958690=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/2] shared/bap: clean up requests for a stream before freeing it
In-Reply-To: <d52ddf4759720a2879677fca0129d3fd1a32dda0.1712951445.git.pav@iki.fi>
References: <d52ddf4759720a2879677fca0129d3fd1a32dda0.1712951445.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0517219152835958690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=844165

---Test result---

Test Summary:
CheckPatch                    PASS      0.95 seconds
GitLint                       PASS      0.65 seconds
BuildEll                      PASS      24.39 seconds
BluezMake                     PASS      1692.37 seconds
MakeCheck                     PASS      12.80 seconds
MakeDistcheck                 PASS      181.80 seconds
CheckValgrind                 PASS      251.55 seconds
CheckSmatch                   WARNING   351.20 seconds
bluezmakeextell               PASS      119.41 seconds
IncrementalBuild              PASS      2961.19 seconds
ScanBuild                     PASS      1021.32 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============0517219152835958690==--
