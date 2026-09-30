Received: from mail-oo2-f37.google.com (mail-oo2-f37.google.com [74.125.231.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFC64DD3B3
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781148; cv=none; b=BPJbhCmm3vynDwjU79pKwoAy7ycQlemSyDEib2A7zf9aAy/vmhdnWyS/AooKMCEURUP5u+yozf5jsJ1oMc3Dqw2pZcWD9PbV+c9PDxlQDdsICSeerSBBOCBBib5EoAcNLQAUfzP1wUfP0KbEcwiZerYezerha8ytQMRYH3TzmDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781148; c=relaxed/simple;
	bh=DF6XV/EMwsRxizQp0WfKNPo8AjGNyPm9vKMZGz/pEk8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Dck1PyW61L9FII9FW5ivUpKyMd/m13brFGzCTOsq/9JCXdkM2hS6gVFVhkaf/DVuuHs6UeVF1+U3QI7pkO/oNCHXFxCi6eh30Dctw6xQtgIa7sTEaN7vWPWF34J2Gv2riUn4c/wdzhIlxzQJoHu8+ME/93L9UXdSJUjBocxJB5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxtCHwKS; arc=none smtp.client-ip=74.125.231.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxtCHwKS"
Received: by mail-oo2-f37.google.com with SMTP id 46e09a7af769-8137b129131so3612136a34.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 08:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790781136; x=1791385936; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LDpEn1mg9CQx1DLah6AwXpEybvchtZ1o+DY+S6qTC74=;
        b=HxtCHwKSj4TjaNTZqdB+yewvB72vAGn1pAAD/Dkm49Hd8FLzkUuaJj3+nsphba9dE7
         niy3DUwFl5KPxwT5Bi+wShZGyQTPgBme8pxqLQTNbpoIQEr/R4oQX0JpNWq8QbfcseVL
         zopO8kqDAt1x0+9M1GfgCBYhJisRHTXPrGBhPPZ0LhULSrdgUJHAVxIThZQ0S26/RtWC
         GizMNjL/25R36ujofFsWJUlxKxg4FZKaBgFAK3QdEUdwLln/9Qdf2Y8ujMy9CPxUuKvF
         Q+fcjpFOi2gAzFb+ukPxv3hA5hCb0DN8MDBdIMuxhJhNvAF2ftZnUGyxatmjweu8bMAO
         qFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790781136; x=1791385936;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LDpEn1mg9CQx1DLah6AwXpEybvchtZ1o+DY+S6qTC74=;
        b=yjum4VzAEJspnnJLXJcxJ03WquVtZH2oi/ItWRusz9yKsWqt1swvhOfLoGglxciXK8
         p3KEAMEGeO2V/htjV8yueOceYlrkvCWMtFtJy6oG6liwOh1TzrKycZUFe/kGAtAHqWEC
         28uXpIyNtRdbo4I6kJudNlAChrDV3ZKKp4ESs5kHAICczHo24j1CuxGadB/ggKGFagV6
         Hs+JS82qm9Q25FfdKOxAoSCRCdTbLJF2g3Oi4L4cbZTblxcTIQUVB9J5f76lI8+i0H8i
         Tbw6ZG1und9P5/Z5YPwRDMBlCuVOpUiMAu7S2j/cSx9YeKxSG5wPITJ8qcJORzdxsSUC
         ea8w==
X-Gm-Message-State: AFuF++lDwiFWmzK4z4ys0h7gbX+mg6usds+ZP4uHpjS+27y6+haILT3/
	vxon+sFE0UCozJH6ywQGLgyZ/ckeY8fqF5ZhFmB7U8VdD4cjJ1P9lZZkx/0LbQ==
X-Gm-Gg: AYBFou25Hb5pNaZ4H4BoNT/RexyMwQMmCTB4uckJuoEoHA4KkNhM/HXgB46hvPMrfDO
	9JiSXLyARWWRDElQocWgA13HLIh+UKDP1f1WV9Kd6xdGeDV1d1tGsGnpMJGOwtA+xMQLUvrieqN
	Xxus8+P8kABcYXJV5Ca8hJoizKgtcm3xXOMQfNDElKJlrAPpUuIs9Un4mR4Nk9RfHX1F8cVWx15
	FMGW7yQNGdvpXNk0zCVsGIi4dp3WSRl4XLjxbGbY5WfIwqYzlPi+M6fDqMqdSt82YUun5F8yxwq
	K8pcFYfHb1jwF4QblCMqmGZqOHlgAULlITubJyy508E43DBq2rM0kWqQaaHoBm4lH5y7NAmP+Nm
	b8Fa1haAC//AbWhcarEqGdqAljdcotRYjfg3rxftsPDIZZbSW14cFhuj2TB7fNfAAVpL4GztiAf
	jg6kA70A9q41D3wNVtkpLrQUlFBQ4m7cijM+Gx9lXEhbsOPvE6ocP5Pbb/5YSGWdhlDWGCRCBa+
	emjVg==
X-Received: by 2002:a05:6830:82e3:b0:81b:bfb5:26cb with SMTP id 46e09a7af769-820471c414amr2016832a34.3.1790781136042;
        Wed, 30 Sep 2026 08:12:16 -0700 (PDT)
Received: from [172.17.0.2] ([20.106.22.185])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82063be7117sm1138533a34.24.2026.09.30.08.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 08:12:15 -0700 (PDT)
Message-ID: <6abd26cf.5ed50510.156bf2.f064@mx.google.com>
Date: Wed, 30 Sep 2026 08:12:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3147048015151878770=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, aluvala.sai.teja@intel.com
Subject: RE: emulator: add generic HW rfkill test tool
In-Reply-To: <66971d6f85d714f2728b29fada7136d5a2fbb3c2.1790752800.git.aluvala.sai.teja@intel.com>
References: <66971d6f85d714f2728b29fada7136d5a2fbb3c2.1790752800.git.aluvala.sai.teja@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3147048015151878770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1176664/

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      19.69 seconds
BluezMake                     PASS      354.50 seconds
MakeCheck                     PASS      14.61 seconds
MakeDistcheck                 PASS      143.54 seconds
CheckValgrind                 PASS      233.08 seconds
CheckSmatch                   PASS      280.96 seconds
bluezmakeextell               PASS      91.13 seconds
TestFunctional                PASS      1078.06 seconds
IncrementalBuild              PASS      374.27 seconds
ScanBuild                     PASS      1043.58 seconds



https://github.com/bluez/bluez/pull/2612

---
Regards,
Linux Bluetooth


--===============3147048015151878770==--
