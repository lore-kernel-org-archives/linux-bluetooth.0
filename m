Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F12927A907
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jun 2025 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749146298; cv=none; b=etl5HJVRu2Aya0qFyoV4zn3sKlc0qAW9VDw9D/QU/u2O7KOmqznE3jywpxrH7uGGFbkIa+NDa7XX+fvmD4gH0w/cPZ9862gto4j2jeVAmIaqpUTaX04XgDD+ejdj1YD43W3gjynDr58zuhQ9nvYdR8XK5gW9AWpQZEbuZxjYGgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749146298; c=relaxed/simple;
	bh=Z0I3htkPiI18KXwN3fR2DU4uXAqkHqTZk8OaPxH1IXg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lBFGb72rCGKz9enn7NMnDdDwQiHU5geAfBfghlKYg7bdfyeiPP3cnxY90cltvWIQF0aoXX65qD9RoYu/UbTkTr9iLV8wm85IQtbBANNrPtMPBdRJqcsSezBQD10yQlRKNdYqouVWBtn2LyvsO07OMDokw+cDDfhzcCn8xfpmvys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTcGtQwV; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTcGtQwV"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c5f720c717so267914385a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Jun 2025 10:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749146294; x=1749751094; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ij+Hdtv2D3QS1BFgCbuB7YGrSAgcmr5ocvROKYup72g=;
        b=dTcGtQwVEFOuEzf9HksBhNx4JmKE9uWqtqCThWgtHQ16ffnOlKDIwBM/qLdcGMo31D
         ugbYydp5y5elzGxz1LC0tJgIxmXjBvwPQTLx2d8tF8QG+yt0deqr5e6Ov9JrrgusbjUX
         Xo2kfRspEsZ0YH6a+V3Dq655BmYZqxtJVXevfdcmGO38wCV1eOlwHpW1LBKtVxhY5E0L
         I0h01g8vdhV3QtXST2Gxq1vap9aQygWWB0eFa5iB5U6r5iAoQYQ/+1QSZLbmw2A8RhDT
         Gakw91Rly7RWKP/iQhlixZF15cvU5g7u4upKCRuvpmxt5iOS1Zvp8my5sfKlDKLpNF8T
         pOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749146294; x=1749751094;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ij+Hdtv2D3QS1BFgCbuB7YGrSAgcmr5ocvROKYup72g=;
        b=ODO7VM6hTfz475U2rLC6EnQSOwB8oHrA7uuUgaD2T+Uq6Kk8Ivf7iIi9pVmAEcRGLZ
         scobhoJuPTnH4Qt+K11pc8j4Vq2JRmbCjEcskYdpLjUjcKL2+7yQb8486XstJ4M8qStK
         U9n84FMIrI72ZlfWIbtTKMRsa9JEKT69pi9WwgwOrRGNTCaHEgd3CKe8ltltX/D+kgch
         xeSPo+deQxsjaUsWsGwpq20Yb7SoKuAf49K6RTQmlZfgjPSrZwmcu8haLcGTu/MVFLIt
         bIqtBI3T65NH8QXdHcG/Uiy9zjz2xrbklKweOFh7ozkV1LNHRFB42WTlii8A/eWqZzp8
         5fYQ==
X-Gm-Message-State: AOJu0YxJ4ONKdZqW9YKQHygEuGu0Zh64BPNT/qgUlEcgshCmrNE/QpNU
	/PHGVtlDtEUlQEBIbNtbBQtNZzQ2CZJMaRaOyx5iRHAklu4r00QpaqIbQLgY7T9a
X-Gm-Gg: ASbGncvds4uwoUI2npmQYqc8wQTLoOyhAnowI4J5y09E66J5n08xOL0Ou35voJPjT0J
	BdYuJ1mDPO3sdqVxz3RUQSv1kze19U8sKJ6u2V6WWtnFfLGWynu4Yik9scU90U+oywh3ROk6eWP
	g0gXivttcdDleI43fLgT2TdZ+LucG9hDTbUVDmeEJRaUbSaHlzyjyIZLohkswt+ex4jvfQ1StIV
	7YoKqgderWd+5ZiyoU6XVmf3eTTklnd2UISSBcLjAaoconmgU86QldKoUfviNUfopeAHSj3NVha
	UKf+hdvAC+B8WuOVPmq+WJF9khK9ri6f6RexOFwKivNsMewPXOAgH3vjmw==
X-Google-Smtp-Source: AGHT+IElReH1hHAbvpPW/9D2UAGstapfSc5gR50oHcuLmk5i8wyeL4Dx6Z15PzwyuoI3x+Z0dzoyNg==
X-Received: by 2002:a05:620a:4688:b0:7d2:189a:5949 with SMTP id af79cd13be357-7d22bfbe0eemr15626385a.28.1749146294021;
        Thu, 05 Jun 2025 10:58:14 -0700 (PDT)
Received: from [172.17.0.2] ([20.122.95.151])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a0f9940sm1289744685a.44.2025.06.05.10.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 10:58:13 -0700 (PDT)
Message-ID: <6841dab5.050a0220.26674a.7c4d@mx.google.com>
Date: Thu, 05 Jun 2025 10:58:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6130335317063346274=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, magdalena.kasenberg@codecoup.pl
Subject: RE: monitor: Add support for decoding Channel Sounding
In-Reply-To: <20250605160002.1652091-2-magdalena.kasenberg@codecoup.pl>
References: <20250605160002.1652091-2-magdalena.kasenberg@codecoup.pl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6130335317063346274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=968983

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.24 seconds
BuildEll                      PASS      20.16 seconds
BluezMake                     PASS      2666.37 seconds
MakeCheck                     PASS      20.71 seconds
MakeDistcheck                 PASS      198.84 seconds
CheckValgrind                 PASS      276.29 seconds
CheckSmatch                   WARNING   304.60 seconds
bluezmakeextell               PASS      127.76 seconds
IncrementalBuild              PENDING   0.23 seconds
ScanBuild                     PASS      913.41 seconds

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
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1876:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3822:52: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6130335317063346274==--
