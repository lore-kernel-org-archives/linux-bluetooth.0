Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095363C0C
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Feb 2025 00:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739232655; cv=none; b=cVWVhHxbbef1mdJTAmbElnuSNWqqw9YStlegDcxb9TnUfqmZWiio2H3V7+NZ3LEGieDDPwvM1Y7VG0vWiMoR8ZxNbXI7vP8gKGRnqAFgQytCd9F3I/WNSMqVloCLYD3S/7mcAVS7kig+6Tr0KXujSalHbJNgVU7jM0+oBGsMbds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739232655; c=relaxed/simple;
	bh=jeMD7hGHtaxG8wNrks2xaANJ4JKtQNmkzzUIzIHH4+Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NdsI6o+JBLZRVKrXvWBwJsFdo+zoqRVwoKJ7k/u5tLX3cVsHSar7gTq8HbJE8aP1sQ+EBQcpTTSoWqwrR/CN5BEDmcsZXzih3pxJElvQaF3R034d8nwMXlQhsSd6KqJnkipha8b5e8+zbknbnMvzXghBNc0kUgV716iELq228W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sr2PkLtf; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sr2PkLtf"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6dd01781b56so59440476d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Feb 2025 16:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739232652; x=1739837452; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CaUHdX93xSuceEmSW+NLn2bloYsMIDZVNx586eGe+ow=;
        b=Sr2PkLtfVYZsBBSzIR08ce8DsiJGu6kmOqN+1TSLMilyrSN8cvW3fT9da20Ojma1I+
         R6aGA7/TIBWTN+SqU/ryW/5mU3lYbu1jg/FfvLuQT6uguS3bUz0f36/IGZfbPQRJoGv7
         zvcO6bTDsFgFDgkJIOcR1OABhS5LT97aX9li04in9vOLva6vVhWi/UBhgo5RouapcrMW
         nQbC/hml2Qvxqy2TYrFCtB3gswCtqF81OnK4tAljndWpCOQ0gwYvL3JBAopACsstOLOp
         mHkpQVSTbe8yiIeU/z+/S6MchItZmES8dWPz599CPryrZxHU4L0r+VTCJhcyIIa1Vtsq
         bb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739232652; x=1739837452;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CaUHdX93xSuceEmSW+NLn2bloYsMIDZVNx586eGe+ow=;
        b=NgY74fDMC8r+kAy8MymPZ5lNT7c9/IgdcCPKg1YmFUdA47h+5O4Vm0rfRBmH/K7KUI
         WOkfayzCHGQAtLchQ6Ki9cDXkIw2q9WlUuVDZp9z2jHN7AH2Pki7amJrRwSYUqGaBC3P
         SSmpIdALnAHhANBPgwGzKPwvxPU11vWQAXO6rKwf7HORy8r7mhuCTN9KXLwDXPuD7UlH
         BuZMo7PzNf4OIfUgRnxJr05WxMB7d3A2v5ouoHrM+aSrxSCebh8fMjrwKuDTUI7Kct/q
         Cp//sFNou/iYxOUE7oMNV9VzdGNJPxryhnLWVuTR6hZqb/lxaucrM+LALWx4dhn/XPok
         LWCw==
X-Gm-Message-State: AOJu0YxTr7MOdh0CSyA9+S6EclX+j7Ys+cADM0Dxd/BJ0NN1m8UodG1U
	EyibVkB//sZhlhj/hvnCwPHNLA40sNsoIJ8yDWaKBLKOP1V0KMxRqFhJiQ==
X-Gm-Gg: ASbGnctlROnqaap7chITUn3bhDFG7Gt4pQ31aRHueE2neSOBFWVIgG1eqxYptMRujS1
	GmWyImR5wCHKM+nsTOzaDtzcOkG5AD4pQAjrZBdldcEF+ux/frN+wDaEFmOlI4arpDZeyvrL319
	YkG/rR0Ao/507vAjnRPMNdpZWCGVA7vqFrLj1jcHsP92MZuelkWIq1unabw2TgchUqX2K4VANag
	27whuuZ61ihJ33Qe82G3FQnXChOO6eI6bQEpi0fzyo4Ah2V0yMASH/4VBtizaRzL6CQ9VEe7kp+
	fAuMzzgvgG6XCxVngCAnAgmY
X-Google-Smtp-Source: AGHT+IHDmHVhQKg0oZyJXx9Q7YyNrR9JtBEvwwFf9W3PQY59F6aPlkgX7wzBd7RgWHgqNDgdIxDABg==
X-Received: by 2002:a05:6214:21a8:b0:6d8:d5f6:8c75 with SMTP id 6a1803df08f44-6e4455e9fd0mr232546396d6.12.1739232652689;
        Mon, 10 Feb 2025 16:10:52 -0800 (PST)
Received: from [172.17.0.2] ([172.183.175.203])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e4556d150csm29385906d6.54.2025.02.10.16.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 16:10:51 -0800 (PST)
Message-ID: <67aa958b.050a0220.214f1b.9283@mx.google.com>
Date: Mon, 10 Feb 2025 16:10:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4968438923158545764=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Add io watcher to be used with TX timestamping
In-Reply-To: <3938636ceaafc589f6d12fa6fe50e1c6a1c76bef.1739097949.git.pav@iki.fi>
References: <3938636ceaafc589f6d12fa6fe50e1c6a1c76bef.1739097949.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4968438923158545764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=931991

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.22 seconds
BuildEll                      PASS      20.85 seconds
BluezMake                     PASS      1523.57 seconds
MakeCheck                     PASS      12.85 seconds
MakeDistcheck                 PASS      161.72 seconds
CheckValgrind                 PASS      216.97 seconds
CheckSmatch                   WARNING   286.41 seconds
bluezmakeextell               PASS      100.80 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      876.20 seconds

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
src/shared/bap.c:297:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:297:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:297:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4968438923158545764==--
