Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D74E3A1AE
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743794; cv=none; b=mgY6sWGPE4mC0vpVaS6KabQxYAtQPSI5cqWrDNVuAJnYVOej0q9FvS19onNPby+1XTqrmOAOHRujY46rZLR968xGi+KVdJ8caHYQ9cxmKzcRfGO4cPOH5eFGQhrNciC5rKQNq3Ug9r1gWpd0RJwFZR+HDSUeyAMHA4JRnAk8o0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743794; c=relaxed/simple;
	bh=wrBGtcGztR0KQPctPu9ijSK+SCO4wwg/6Ix3IGVoBAA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PK6yrZCSnqlP9mIXUKn69AhbAJAB3WwLxVwWbhwPFl30fGFXfQPw3L0TNSNEQmvdKq7F6JVwYdAWamPyCX/lkdR2PSk7QfcvPZJ3Jkrv+MTnxUVUvjxAcLVxBSWzhbCOwrFSItVM0DhVvj1j8zDbg26XuFG9wxbXOqKAzeDtIRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDwwck6n; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDwwck6n"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-783f3d27bfbso144050885a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 05:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707743791; x=1708348591; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rOsP3fzdtRmNYsoYoy77ZCZFjybg+oT2HKXz5AfqrQI=;
        b=UDwwck6nhOANjfKWU2X96llCtAdvKx7mbY4qJtWP1g3ZgeCHDIfHQ+9qxemmGlKdiW
         s2BjBt35MNFxN5EJICyuVJqxwuIeliayJXqyDv6mkqua7tl8UXY9CF9dT2ep7zkEnp97
         UZ5E6DVpVYbjjYm1TrMJwWfO4T3t6/63S6CgK6+2c50ljV1ZCGLhHeu13kLu3j98tfQg
         7OoufkhOxAUTS00XrFmKz3WPZalP8VfpltMYZKUEJAHl6XVYh9z/IAa4NVJNUHaEg4SZ
         gE22GL0hjB8Cu/vTJzG6biYvsz4E4UXgeQPCA47tbEmZ3uWi+Ofn/OLQmWNsutAF8N6N
         CwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707743791; x=1708348591;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rOsP3fzdtRmNYsoYoy77ZCZFjybg+oT2HKXz5AfqrQI=;
        b=DaMrKW6eWKFLRqmzxEC8TPWUVtnfJ1OuUdgtS7niG+vPxGrg4SJ+qCpi58APSrWJm6
         /7WOV8ojOaYU5kU2YyKQvHXTnj5XnpeQNcj57MUhg/MrPdeaZYLguxCqDqUhSEN7Byum
         B9s/w4JpDPw3ay+OZwoIAqDcQlFdTBqTZleuUJ0P8sklWhliXVQjY6TPiHTn82FJjnWr
         AbNdZ2XeqGKIiNI0ILMO/7ZmosVf9HT5BwmZn0NoJdG+UQ73oC/CncpknC+2hdSundjS
         sxyf9bj2x9+04idqQPevIJEMrAAlWROW+76omW9Xe4K0gjfakhndqoet5ghsjwAhbHe8
         tncg==
X-Gm-Message-State: AOJu0YxS922XGHmx2oCH3rxd+qheUNSEQPpix+GVqV/rIhu6F8rMDOHK
	TwIdZCPD65XfXEjrwhfPNLLHptBju1f4RFT6iJMtdQbNCiFYv0igO+pnY+Da
X-Google-Smtp-Source: AGHT+IFP9Y8WO30RCfVI6HNfnrS0NRZfXTq2dSLvnCSttpWw9cTK/2153UglZArOIXrFxevTAkPvlg==
X-Received: by 2002:a05:620a:7e6:b0:785:d82b:784d with SMTP id k6-20020a05620a07e600b00785d82b784dmr1934458qkk.48.1707743791326;
        Mon, 12 Feb 2024 05:16:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXUwX3dXHMTPX9uDMNGD010r+eHq6QefNDCpHUCdL1v8V3T0IGDFC+OjEA/Wr6zw7ccXp25+3CAPM3izz3JgQzBTTkzoooC8ldX7gQ6JWs=
Received: from [172.17.0.2] ([20.102.46.180])
        by smtp.gmail.com with ESMTPSA id i12-20020a37c20c000000b007869b745e2dsm204674qkm.100.2024.02.12.05.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 05:16:31 -0800 (PST)
Message-ID: <65ca1a2f.370a0220.b5521.0c42@mx.google.com>
Date: Mon, 12 Feb 2024 05:16:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5319504191813825492=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shahid.bashir.vichhi@intel.com
Subject: RE: [v5] monitor/att: Enable the notification logging support for the CCP
In-Reply-To: <20240212051410.693561-1-shahid.bashir.vichhi@intel.com>
References: <20240212051410.693561-1-shahid.bashir.vichhi@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5319504191813825492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=825193

---Test result---

Test Summary:
CheckPatch                    PASS      0.78 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      24.20 seconds
BluezMake                     PASS      709.68 seconds
MakeCheck                     PASS      11.76 seconds
MakeDistcheck                 PASS      165.28 seconds
CheckValgrind                 PASS      229.29 seconds
CheckSmatch                   WARNING   328.15 seconds
bluezmakeextell               PASS      107.22 seconds
IncrementalBuild              PASS      658.17 seconds
ScanBuild                     PASS      940.32 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/att.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============5319504191813825492==--
