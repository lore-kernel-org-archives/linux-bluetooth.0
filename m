Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99221CAA67
	for <linux-bluetooth@vger.kernel.org>; Sat,  5 Apr 2025 11:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743851608; cv=none; b=ifxk8BvwPDIqcToQGz10FSt26m4pjs0Wa2CGDXpJhWFWkTB11l0LuM7mhRtSCD7T+Bn/kNCOeQy1VoLYfiQ2EfzDdKDHRbFan7Qu8U/9aMSvOd+HVySzNx3Ra+dTGMMQbDrENeH/VJJhsaXScPLePtG1Eh5aU9PsRH1UFQAvVQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743851608; c=relaxed/simple;
	bh=OaZVfjgVrlPok3vg7AvUCyAYw1EXuk4MnqJbpg5xuqk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Mwf/OSOYRWxkUtzxb5VW+F/2T86QrHjw7VDOOPxPF+NWT99+sAzRMyo87ecmywgs+r0h4QknkQuBVoDX8Cm4GRo0uSMAMuaR0vA3C4wrWKIoaflZ0RpG/MYsqwJ6IUZnhISmDO69XPaOZd2wuI+5WiN4VW7nEbhfWosRcpmfnZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YW0kVTk1; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YW0kVTk1"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c55500d08cso266748185a.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 05 Apr 2025 04:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743851605; x=1744456405; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lhzOxRX9toAbVBaNHWlWNcJULAhBHvhSIi4HYzqAl/w=;
        b=YW0kVTk1PJ4MpV+ZS/0NuTVR81AZ60nqjKh/kEVaPLHhGnG0THQeP6iJyRgxLNmnJD
         Yz+Ce6S3hRJxRQMp8LjR4L4Vb5MtP2O+jM+L/F/WsuYoXGtsDm/+9WQWguUpCsDHZG0d
         K11A9J/UVUAX9qdjvcyxKVyPhurQaTWUkgSgGdSEZ2CuTZxJCg27ux6ItBKOXg9laF89
         XzczhPzE3AyR76vD5a4kKjpezlUaPmUfqrFaXbyhN3R928aJitDODBs4T4pNhWZgyEnY
         so7FT4ff+3QVAKob3x8rl6keXVpF8BhPjo++DQeXFDaszn0jUugxf50PilJ/qMaHqrQ3
         O5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743851605; x=1744456405;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lhzOxRX9toAbVBaNHWlWNcJULAhBHvhSIi4HYzqAl/w=;
        b=lq9uvgczP8QU4WjVzvwkZV8xG7XQfadI8JJOiiINMV2RQ1nDfE4sHlCWkfYhDHY7W5
         6siTyX187WCOa8REGJXTb1vNTcMZeCkN+8vQwsRC2cdaCBNmQmzdBuSwvnOsz30rKHZi
         EiOmBTZSzXfyGfkKR51fEstkS5AuW6UdnRAaawa7tqz03naEfg2lHZCBmDXRPXHwpBxN
         2PFFpe03x3muczKJVb2Kzp4w5CKkQcsQy+sYOFFOI3Y7k5FFV8m3xUT+VyEXdiIvyXpj
         JJgIYMbI4k9Jlu+G7g0SOdl/FJHoTnJYAk+HdmxT/UX7KkcJmiuLw4NzJN+331OoEV7Z
         IjsQ==
X-Gm-Message-State: AOJu0YzYu9nxZrDwUUxlSR7+gvOLUsd58toU017NeVEIyTFNwe7G0tjg
	pP/6HbVzFDHEuJ1yyDCj84BSMIKRpdjqVlX67CfJgzMJx08sj1uU36TFxg==
X-Gm-Gg: ASbGnct3UGFneJML32Psrit7INbLZmz/8vuY45UFDtEmrRCsJmn+Py5JSLYrZF+8p3x
	GKRFDysYGbKjaPtDiH3hLP2ldPf3Sooegqq9HzbCtK2hH6sfaf0lpAT/oEkKGjrFs+vP44zWl9f
	sCfNdevEvrVf15LUdBlgPiaoiZg4H5wo++HDz+e7yU3PCPMNB82YC5PnHXWhgCk1o+aIuT42gKR
	pYJxCWuJK/QLT9cwmK2Ifs+oiGQKbVk3sKVmwM9tHXpQHd9Mdq5bvQjNXnik+A96er8DPDm0Eg/
	LTVQ+f8MlXUPk6yCwg5oYzyd8exDZUreLbiPM1ac36Yrku/D
X-Google-Smtp-Source: AGHT+IEQzhQnscs5cSYczotW3/lucUNJa4InBOm30vnc1w4Wp69Q3vztDQXMpv8MUaolfQUjVbG6Uw==
X-Received: by 2002:a05:620a:298b:b0:7c5:4caa:21af with SMTP id af79cd13be357-7c77ddde0eamr436442885a.53.1743851605399;
        Sat, 05 Apr 2025 04:13:25 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.17.68])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76ea857f7sm322955585a.106.2025.04.05.04.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 04:13:24 -0700 (PDT)
Message-ID: <67f11054.050a0220.111dc5.a3a1@mx.google.com>
Date: Sat, 05 Apr 2025 04:13:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5435137890010973630=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2] tools: add BPF timestamping tests
In-Reply-To: <632807049a6b64e11103b95163ffa5de8f18a4ed.1743846534.git.pav@iki.fi>
References: <632807049a6b64e11103b95163ffa5de8f18a4ed.1743846534.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5435137890010973630==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=950146

---Test result---

Test Summary:
CheckPatch                    PENDING   0.20 seconds
GitLint                       PENDING   0.19 seconds
BuildEll                      PASS      20.99 seconds
BluezMake                     PASS      1631.60 seconds
MakeCheck                     PASS      13.98 seconds
MakeDistcheck                 PASS      163.79 seconds
CheckValgrind                 PASS      224.03 seconds
CheckSmatch                   WARNING   294.82 seconds
bluezmakeextell               PASS      103.18 seconds
IncrementalBuild              PENDING   0.18 seconds
ScanBuild                     PASS      886.40 seconds

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
tools/sco-tester.c: note: in included file:./lib/bluetooth.h:232:15: warning: array of flexible structures./lib/bluetooth.h:237:31: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5435137890010973630==--
