Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7483612B93
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445122; cv=none; b=CFcwbhN3BgJfVdAjZTGDV4bZzjdENkKGo4qPPcfl/qfe6OwGbZ6an0TW/eZ02WxgGJmkMgGsOq8G2NxxqQ/Zuzv1K26Du20pA7hFAkBExi5LPZWWBPOkmqEdQ77mKtwNkZQ2DhGiCcnyKDPxS1f+tRpabKpLmFwSp5kVEhSrjUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445122; c=relaxed/simple;
	bh=Ijiv9Nngakia70F5ZsKKVTsnGpw3cCcAOwewb1Favfo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ew0pIlD9Y7Q0Lc4a4aLoScRHOC/T6bL74xvvGegB1RgROrolX85gC6VVVlF8wIzbjXE/GgxqLOPdXTqS7jujSYml6zcgRwi9XQzs4ZIAHA2gQlFHdE5Q4HktGH2hJtoab9fzaJ7wMCk1/4Hy18FKDmQaG/hrHrB2xCIH6wt57bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/8VmJjS; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/8VmJjS"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7093997dffdso1982519a34.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 09:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722445120; x=1723049920; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=STQfvKFGUoutjeyktjTlDxJQxH17E69JShWvluOtnKc=;
        b=m/8VmJjSzFoo9pFkR55ow1imM32j6mGgPBedsrRGOltxSEUdzwRmsG7KOLFw4y/4KU
         I+Hp9Oa94Yqxj2etQXpcMGi0exbycCeVFvxHPGRaGXCI1P7jQR+gW8YmWmXLxCqda4r3
         1CZMiRrJ1Bp3Xulpk+PR2PRs1DF2oCbIwke+Lat/c5be7d1lgNC2OzR891gdQ/RZZH8g
         DkZ2HG5Tyxed/O5/Sn6XvHPxQcRCkTcZbhcFTpk7QymwsmM1XPvOkFMBDDotv0GQhp51
         rFzn3sfcI+REUNCAgwGQH2k1DZo3s9qy/vR/vZDLPh+uLmZAc3ppPz7Pu71jHvkk9xsl
         WpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722445120; x=1723049920;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=STQfvKFGUoutjeyktjTlDxJQxH17E69JShWvluOtnKc=;
        b=Uduyck054NnRLw1iAcvy0aDj/Ka49bEZxKALJnVVkRP4HULKCaRz4zuZ16layNvtIl
         fRctvZH1xYSSoksZTuPa1I/xola8zpIylg0UtZpBXwMoOcjxeGJtI9EIq4uaWazqEqBc
         9SnOWxjQVi8qNJ1yxiayXHAnR3eKeCHwrTXvJHM43BrGFfUVXdPNVYE0A4TIkbrsZqRK
         lwUr2apGwpcb4MfYhIn17y4iXCkzyrmbFHXwDp+tNQsmzQyLhgXTJreUUZVtPCdqvBPo
         0wLXymgCNNd8C9l/bw3Q8weJ8FToEA78nBVuk3HXIhY1guukFNdhWCNeDVaDhxaQTRxF
         JotQ==
X-Gm-Message-State: AOJu0YwoixttVda5RvVnLiSI9uRO+okK8fMxs7TY8/MXYOPVILWikSX+
	VfkkERyL7ZAqOgpY4GzjG4AP22Cn5pKxdjm4CpNmMkruWGeSukWvbDikmw==
X-Google-Smtp-Source: AGHT+IFeE00HUnAv/UU6iAevPSOcVD0X/rrmPjPr2adHLYRFE9Mg3jlsKpmWvumouUsHvlBEo8qP5Q==
X-Received: by 2002:a05:6830:6315:b0:709:5fef:c9a6 with SMTP id 46e09a7af769-7095fefce5emr5730110a34.20.1722445120434;
        Wed, 31 Jul 2024 09:58:40 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.14.162])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8187c0fsm60869981cf.55.2024.07.31.09.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 09:58:40 -0700 (PDT)
Message-ID: <66aa6d40.050a0220.f5562.457f@mx.google.com>
Date: Wed, 31 Jul 2024 09:58:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8894817956645275620=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/4] client/player: Fix not setting config target_latency with edpoint.config
In-Reply-To: <20240731135718.429604-1-luiz.dentz@gmail.com>
References: <20240731135718.429604-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8894817956645275620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=875511

---Test result---

Test Summary:
CheckPatch                    PASS      1.87 seconds
GitLint                       FAIL      4.72 seconds
BuildEll                      PASS      25.15 seconds
BluezMake                     PASS      1690.11 seconds
MakeCheck                     PASS      13.56 seconds
MakeDistcheck                 PASS      177.39 seconds
CheckValgrind                 PASS      251.75 seconds
CheckSmatch                   WARNING   352.40 seconds
bluezmakeextell               PASS      119.37 seconds
IncrementalBuild              PASS      6230.29 seconds
ScanBuild                     PASS      981.65 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,1/4] client/player: Fix not setting config target_latency with edpoint.config

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (87>80): "[BlueZ,v1,1/4] client/player: Fix not setting config target_latency with edpoint.config"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/att.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.src/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============8894817956645275620==--
