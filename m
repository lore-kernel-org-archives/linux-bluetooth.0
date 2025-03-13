Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43715265630
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Mar 2025 10:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741860601; cv=none; b=E4Ui3hUHUlimYDiTnDAP51sLJLB8b7pFtv2QMLirIl9W9IRaESJ/hJPfsvvdg3+HySEyvfT7ydsl0MHiQS2wyl1CqQBL8DJIgB7WMQu2UyWnRtET8axkDHsYBTCXQ6ed4vSQpdWTAyyGEnjZQ/pJFApgQBByw1OD3N08endHZTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741860601; c=relaxed/simple;
	bh=55No/iljNjui5Q67XoXtkaZycRnB8r5qx55pl3mbgE4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=L5Gc3dDLkmZruJEv8DjJIRbkMr5WScK/GWD29DArEjJlYOpG5H3ray2F2mL7DQRPLzwX33qQ7bCwXGJ/cUXRMSTjLnmGx/vpBEsj2dUsQ34Tm7UATCoU1hLEghsw2maYi1QeiNby+E8qq3ZZLMaPS73sJ2M11ENb4MODZlPl5gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMjRoKk+; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMjRoKk+"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6dd15d03eacso8666816d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Mar 2025 03:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741860599; x=1742465399; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a9gVwtiDGYvabp4d/3NSn7eUpdTabhkYC6VqDDkd9x8=;
        b=GMjRoKk+ASNkBSm5UO9+BtMpeffDnQHKixjXD1yx+8+tLS3OzhI34dMW2G1e3WWdj8
         EU7kASmErRZpSeNKNhc8a/M2skd2v8wORNvb7QJIKtVSxTX/FZXeXN/7DdL0Ki1euWVE
         FkLEPzuf91Qa9CQoezzTkPoL9bhI9Hgo2UcHHQFVGUv0hmeeOy6Je32AVYu+koSXt+Mn
         /YipnzP/a7XKwgxp/i93saqGhXdBIzBsibxO9qfthvZTJxFVI1uRQemHCDzH4WqPAXj1
         ptndHqM6xW0Cppl1zIQPWICeHNAgPLACxqcAt/WI4F9r8NqioUTneMMpZD/t0mUGsLSd
         wl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741860599; x=1742465399;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a9gVwtiDGYvabp4d/3NSn7eUpdTabhkYC6VqDDkd9x8=;
        b=WGigA70FbHwWtFjozDFk0cKF/MFm35YFmOPwezStYl/0oPES0fTgqx3cWI91bO9yIA
         D68oKQ//I7JIKt+93Y86yLqYT3P/2s9lhHJ5QQh1a8y2YejYWhtAx21+TfIzEGU7EvDp
         +lgqN9fF3el07k+VEJKjvatj3WQr5NDg2ikx1myhZtlA7TwAvtLIV4NoQK6qgHFw93h6
         MHdf5eIqIYOuupP5X+f1Vs/wk5Nn8DQjMgU0M4FRcm7s4zuEsRhLUTkSIAdkguFhoabI
         baIMxw76W1X4ShlR8TFyCVWvMKH+7jDI5vCQOSkDHix7mG4pvhneD+xFURGpexLcwL/6
         Mmfg==
X-Gm-Message-State: AOJu0YxodLiBMkLJ0/7B/8ikAAJoAwpEYImLeuKno6X+fDRA/4EWJASZ
	Qa5eFb5m74ea/2lJ24yismFdFscbmqAu5u7NjndBPrcZgecrREEJLZQv+Q==
X-Gm-Gg: ASbGncs9jQyvQvTkDjCZC+gKM0i2cnUbag4JcFgPFvezWU+deKnSFa7I7V62shA4k3/
	2vGwNqOdTT8DPUFLb25NGMTF2YajP6xNNJMTKT5Rp+wHXc77Pgz7dER+zvIkuFjzNSgXBxpeg/1
	GS2fVZMMGf0iAjXxk9hooqheYhHtufieLUXDUSuLtT83TeNJfrjkU0OHgem5AVDDpBpzBvDpm8G
	ZYBx+M+3KMj+gGfLswx6nhdMQRYi3JR+Z5S9+INtABs8dPuIURYceCuG/mB/8hFJPSBg1GMLirW
	Zk636tRuGH4nGL3YjrSOmhbYtUO4y6E+4IAh7l7k+iKgAf4LGW9p
X-Google-Smtp-Source: AGHT+IFYgEiR50Zh+9fsfgAHmgb5dWWDyfJZBNEq3/zqn4PUzI9z+fjCFUraMNZB+kiOuUwwsB17IQ==
X-Received: by 2002:a05:6214:5c47:b0:6e6:5c26:afe3 with SMTP id 6a1803df08f44-6eaddfbb91cmr22183966d6.17.1741860598802;
        Thu, 13 Mar 2025 03:09:58 -0700 (PDT)
Received: from [172.17.0.2] ([172.210.84.237])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade3353afsm7806836d6.73.2025.03.13.03.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 03:09:58 -0700 (PDT)
Message-ID: <67d2aef6.050a0220.e3446.150f@mx.google.com>
Date: Thu, 13 Mar 2025 03:09:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3717818818962875785=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yao.wei@canonical.com
Subject: RE: policy: connect HSP/HFP when A2DP is connected
In-Reply-To: <20250313090511.57938-2-yao.wei@canonical.com>
References: <20250313090511.57938-2-yao.wei@canonical.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3717818818962875785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=943441

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.20 seconds
BuildEll                      PASS      20.38 seconds
BluezMake                     PASS      1418.22 seconds
MakeCheck                     PASS      13.30 seconds
MakeDistcheck                 PASS      157.65 seconds
CheckValgrind                 PASS      213.98 seconds
CheckSmatch                   PASS      283.63 seconds
bluezmakeextell               PASS      97.87 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      867.17 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3717818818962875785==--
