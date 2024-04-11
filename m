Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74045789E
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 18:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712860116; cv=none; b=X7NU2Z5B4FZjFUZeLerODkJ2JSxRiMwi6/CReUqnykeHALzDpdQqSxmf0gGqKWUCWFWxrWKAL2kjppmD96antboR3rLUV4SRuYAJhKq92YLNYXh0AVk9tuwwbgJScOZYPv9qyghgoYsPY8tKLAp7uwZBfWKc5GRhpatlXEqCj4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712860116; c=relaxed/simple;
	bh=oIUPR6TePrTRXMbTsCtY1Xk/LXvp5M/ByQGyMitGDtM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=o0lcxoVSXzIGfJ54g8komhfHGic9fsuqf9FVy5JVtoqx5PvNPFZS9KP4FTUkQT49T9pLtxQZf3GxPkNvvITNv3yU/8Gvyxia1B8hIlQz3vs8ZZ5YbnzMde2jmWyUZubGUn3nCYQ3I37leo0jlZFVqhE9JC7QD8XG9DaUSS4ui/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WzQdAguA; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzQdAguA"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-434a6024e2fso1264021cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 11:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712860113; x=1713464913; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W7m9hhlXoL5AGL5Fdk2FdEDSzSCzZFTAPZLJDSL9R+0=;
        b=WzQdAguAiheunh8ckOk52/hAQbhYspYPy9tGYVsBTYPP72QB7fHM7w7Jd6mYGLACUk
         riUIcZVvqwMhnltPjudQJmS0gjScmpcaH1zGuH6BKM+BOQdXX6TcvCazl/XspMUd6al6
         KhviXKdZTLVHB0a+Qg3kkhJaFDLzRzBwdy6Kcj/0t0ppUVk1TXtF3/EUXsHgvPPhpB0w
         1fKdqSghflQTHKczuLYDqvpANAV6QAs91gJ7vIOwxXDxVFK5xHeBEzn3Apmo2w4bJLZY
         C330I8IP0K1QN6nP6wzw6TLuKMoEaBJJEP0KTHu6Bi61qbdEqarr5abEyPdNECO1+KQn
         hVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712860113; x=1713464913;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7m9hhlXoL5AGL5Fdk2FdEDSzSCzZFTAPZLJDSL9R+0=;
        b=Cu5WU8wrdF27HLw+bK7z2krYNdXN88HKX40a0V+9vVbcaPSk1+hkhsdw3GYPYpL8GN
         634NDyEKLgMd9GUEMq1xg0XUgu1emXVmAoz+9+hqVMvFMwvFTYsvfTMT2G4RDmysyhFa
         7N/ZSAr4FcV/Icyh+MSsE/rguRlRg9y5zV575JikCW7J/h8qpMYYgDZ0EPnsVuSezGor
         n8N/zhXEqVRX7GjCI0n7Dq/jodpomg+Nh8LPglW4J+jiTRhYsjVB+Bh7g370q9bZEcL9
         jpR5W3XBkVf+cYnv1xlO/PtWyZ+OIdmwmO5Xpis95H9gMhKj7gXLGqw3hRzdds5Y4BLu
         qNpg==
X-Gm-Message-State: AOJu0YzebFBFRlIvNVPvkBPhffEPxzMHLVNR2N3KsymWU6d9lITnveAi
	pqsmu7HNyqSnIPVqsd6QVhw5H2uupsTyhYyKWLuCheROT7YtvWTFm9PprQ==
X-Google-Smtp-Source: AGHT+IEPXV5P2m7Zo0yHqWak5ltc6xOVRNKJsnYRMD2kH7StoBGw00DYOpvLSD3M9EscSsr56J/nsA==
X-Received: by 2002:a05:622a:1ba3:b0:434:ec3d:dbc7 with SMTP id bp35-20020a05622a1ba300b00434ec3ddbc7mr5955631qtb.27.1712860113532;
        Thu, 11 Apr 2024 11:28:33 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.46.246])
        by smtp.gmail.com with ESMTPSA id kq1-20020ac86181000000b00434c31fa60csm1202472qtb.92.2024.04.11.11.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 11:28:33 -0700 (PDT)
Message-ID: <66182bd1.c80a0220.89ee0.2d04@mx.google.com>
Date: Thu, 11 Apr 2024 11:28:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5459818635130473334=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/2] shared/bap: Fix not updating location
In-Reply-To: <20240411163041.130214-1-luiz.dentz@gmail.com>
References: <20240411163041.130214-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5459818635130473334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=843708

---Test result---

Test Summary:
CheckPatch                    PASS      0.92 seconds
GitLint                       FAIL      0.82 seconds
BuildEll                      PASS      24.57 seconds
BluezMake                     PASS      1687.02 seconds
MakeCheck                     PASS      13.66 seconds
MakeDistcheck                 PASS      180.23 seconds
CheckValgrind                 PASS      248.45 seconds
CheckSmatch                   WARNING   352.66 seconds
bluezmakeextell               PASS      119.77 seconds
IncrementalBuild              PASS      3011.52 seconds
ScanBuild                     PASS      1027.39 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,2/2] shared/bap: Make bt_bap_select fallback in case of no channel allocation

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (87>80): "[BlueZ,v2,2/2] shared/bap: Make bt_bap_select fallback in case of no channel allocation"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============5459818635130473334==--
