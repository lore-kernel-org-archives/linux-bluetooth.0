Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787937;
	b=Uwn4rZvkIOqtrHt0cXoFcn/t9cUG/Z8AfSbBnyH94o2mxreP6wJTKdxyIIeMQ4rQ2jl2
	 LDRRQQTbDiu/Psz1HG5L6YJj6wf94mrGMcrU44oJWmhSCgiPX/RxBBnvUbkU/mOisiN4j
	 rOdnATMco0DOl06eKyJ2k0+uygJTfcC04igOo1z2nmJ0zaAzHm/Hsy6WRxI92gZGi1Z95
	 c+zjdTFFqW4JlhQM28fvfJHf3b4zvUsdDxkNM6r39gbVNl0Vw8LxNa4rfOpLv3dnYWU4x
	 kgAEEOAmyEoaLDGpdW0iqP8EiPYSkKA/H9gX9hnAh5STu40ngHiY+pMPr5XmNVr+SLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787937;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=p+G6uA4nVDQZSqTU9EJqNIWcpWSepMErGLgFzEaLySw=;
	b=YazBbEW/zSv1XNeoqWEgaeQVq3LhnljhtOmUYZOG/pVCnGhW7buYnq4DmD8IRwk+vHca
	 Q1koP0RbDxjEXlShruAFGR5rZv1gnxHqdqEdQf3rk0NCZO5iP+pKqLC8UtkzENAmVvUKm
	 8EYcK2KzRMuduF9bpeCN0mH1WQ0e+F4PTMK5hSzvOb3Iy4p80+oonF7n2QRBCE+2b1PP6
	 CnuujVN5TNR/ejmu9W1rFyPhRXJyFyFe45yz+OXbZrY/qlWG8n7yTdsABIcK/0aBsnghS
	 DFO6ZaS2PMqvqOioY9rstY8D3crapUABe+ZH9R2z6GwQh3SyFJo7vyFelYmYUra3Qqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LonV4cGl;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84930606A324
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 13:58:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84930606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LonV4cGl
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-38190551625so15543956eec.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 05:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795787936; x=1796392736; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=p+G6uA4nVDQZSqTU9EJqNIWcpWSepMErGLgFzEaLySw=;
        b=LonV4cGlUCogW582XLu8WWwHw6d/j8a7R0OMV8shHqEz6TOgOuZ1DdtQL2+ofNwpSo
         DyQKRJqebxLKZQzb9BsAfbofTT0CJbAwvuXCruiTuYebInyj7W5bdjcd0Tt5QTCcX5Wm
         mgXEqCnRjbFKCixb6N2fyqFsgBVBRxWyujxEjXY1QZtxI86HX7oWjmJATFYz1SA8inXd
         Gkre0+CvT16z0RM8oV+cVO/Ht6Yy/PRG5lUmvNWkRHdmReNz7l0HQ3KF/LbDGQRddcLX
         Dx+y7D64Axd5WQM43MlWuWi5OE1oFMpOMXuXfVYkiqe6iWcAF9VPMmQEs2SpY2iasi1g
         KrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795787936; x=1796392736;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=p+G6uA4nVDQZSqTU9EJqNIWcpWSepMErGLgFzEaLySw=;
        b=GFwkqq7PBc7+sFDTjEOSDmTfZx5ediZCyt3LWt+P6z1Bhi8EerBRVA5PMOILuIH8gI
         61O7dY87SWm9taZDtRjvnxABvuLHEGUayvtCwT/WGjPL4O6pEu6X05VST6fMgLDWQ8Hw
         nuuqPyZ9+6nhc2DJp/tktPfAVIGW2dWhpDz3aCewsRne8WtbSE8G8QDyWN+SU/igrK/d
         6jTDkSrY95HaZ70LDtIEJSmfo1LircEQNU38fMkvvONNgDJPafrJc+2LAkNy8U23DSOc
         AP4KDsqPVygRkeLO4/0LU3nqAU+B5XHrDtH+UndIkPLsd51QwitdtBadiXvHRnkqGdUN
         nkBw==
X-Gm-Message-State: APuU4Z+U30zWjrTEvQ8LdCpH1RJfo+e1mvqh912jCOsVds59Q0UFbEwB
	XSDEom40cNKWG3hleQqw/iaeRFvwfnkPwWt35fRkWcOjISOHaoiefPt4t8u27Q==
X-Gm-Gg: AZFdTZczxVmpySqDeQSAivd1grQnAZ7YrFL7pJ1i/o0spYr7DWvMXtVNqaUrq1fKLBf
	kaU+IMkfK69tlS97uAZ/2ztfAywzvx/d2hZgdSqwAdWH+zJIa+JglQs0T+ouXmgQupJM4gpTrvP
	UVMnwXSVCuzN+t892pCdsYPaJZ3BFvUhZ/e8YALMVGxX6cM7/vBVjjjDQ1KMNwdRPhEuufXdPg+
	LyYzSssPq5YAlpUB5aj/jjD5NAQg+vzc/omGHZKg08Cy1TgxgHe5BeAnKVKbehMi/hDaMrx41CL
	CE7wVrqDZr8S5Vae5CIFj/JSb3z8VK159f2v315+oo1yGTrahKu1LFj4ENggcEgGZBN+Xnj67iv
	wMVPwh5ofer2ImrPIQ5S5cxaAlFAZTKRk4eTJ4SxWspEpUewvfUrG6Zzo7YpMUab/X+eaSs7JSq
	M6HpdREd0+h75qp6xi0U1C4dqH1tg4KqlgD6HF7sv6+UWp3Q4fBhb+ss25wnSS6bxSPM9o1tpp3
	On49IWL73XmURajTY5LajdQ5tPciMFa6r8LADYp/tPf8JOJYgmCIP2rMCTV
X-Received: by 2002:a05:693c:6010:b0:385:2057:eb95 with SMTP id 5a478bee46e88-3857073f2a3mr31373680eec.31.1795787935498;
        Fri, 27 Nov 2026 05:58:55 -0800 (PST)
Received: from [172.17.0.2] ([52.161.59.0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm61250322eec.25.2026.11.27.05.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 05:58:55 -0800 (PST)
Message-ID: <6b098c9f.4b6e150d.279180.84df@mx.google.com>
Date: Fri, 27 Nov 2026 05:58:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2480331292984710128=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, rolandschober1968@gmail.com
Subject: RE: Bluetooth: Periodic advertising and PAwR over MGMT
In-Reply-To: <20261127085401.263615-2-rolandschober1968@gmail.com>
References: <20261127085401.263615-2-rolandschober1968@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2480331292984710128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1224182/

---Test result---

Test Summary:
CheckPatch                    FAIL      5.14 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       FAIL      1.12 seconds
SubjectPrefix                 PASS      0.37 seconds
BuildKernel                   PASS      23.35 seconds
CheckAllWarning               PASS      26.54 seconds
CheckSparse                   WARNING   28.70 seconds
BuildKernel32                 PASS      23.20 seconds
CheckKernelLLVM               PASS      25.41 seconds
TestRunnerSetup               PASS      546.44 seconds
TestRunner_l2cap-tester       PASS      15.18 seconds
TestRunner_iso-tester         PASS      15.25 seconds
TestRunner_bnep-tester        PASS      2.88 seconds
TestRunner_mgmt-tester        PASS      84.82 seconds
TestRunner_rfcomm-tester      PASS      4.06 seconds
TestRunner_sco-tester         PASS      5.07 seconds
TestRunner_ioctl-tester       PASS      4.26 seconds
TestRunner_mesh-tester        PASS      4.15 seconds
TestRunner_smp-tester         PASS      4.01 seconds
TestRunner_userchan-tester    PASS      2.89 seconds
TestRunner_6lowpan-tester     PASS      4.06 seconds
IncrementalBuild              PASS      67.80 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[RFC,1/5] Bluetooth: hci: Add Periodic Advertising with Responses definitions
WARNING: Non-standard signature: Assisted-by:
#133: 
Assisted-by: Claude:claude-fable-5-2

ERROR: Unrecognized email address: 'Claude:claude-fable-5-2'
#133: 
Assisted-by: Claude:claude-fable-5-2

total: 1 errors, 1 warnings, 89 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15028825.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[RFC,2/5] Bluetooth: hci_sync: Disable periodic advertising before removing a set
WARNING: Non-standard signature: Assisted-by:
#128: 
Assisted-by: Claude:claude-fable-5-2

ERROR: Unrecognized email address: 'Claude:claude-fable-5-2'
#128: 
Assisted-by: Claude:claude-fable-5-2

total: 1 errors, 1 warnings, 0 checks, 55 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15028826.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[RFC,3/5] Bluetooth: MGMT: Add Add Periodic Advertising Parameters command
WARNING: Non-standard signature: Assisted-by:
#140: 
Assisted-by: Claude:claude-fable-5-2

ERROR: Unrecognized email address: 'Claude:claude-fable-5-2'
#140: 
Assisted-by: Claude:claude-fable-5-2

total: 1 errors, 1 warnings, 0 checks, 270 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15028827.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[RFC,4/5] Bluetooth: MGMT: Add Add Periodic Advertising Data command
WARNING: Non-standard signature: Assisted-by:
#129: 
Assisted-by: Claude:claude-fable-5-2

ERROR: Unrecognized email address: 'Claude:claude-fable-5-2'
#129: 
Assisted-by: Claude:claude-fable-5-2

total: 1 errors, 1 warnings, 0 checks, 140 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15028828.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[RFC,5/5] Bluetooth: MGMT: Add PAwR subevent data and response reports
WARNING: Non-standard signature: Assisted-by:
#139: 
Assisted-by: Claude:claude-fable-5-2

ERROR: Unrecognized email address: 'Claude:claude-fable-5-2'
#139: 
Assisted-by: Claude:claude-fable-5-2

total: 1 errors, 1 warnings, 0 checks, 387 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15028829.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[RFC,2/5] Bluetooth: hci_sync: Disable periodic advertising before removing a set

1: T1 Title exceeds max length (81>80): "[RFC,2/5] Bluetooth: hci_sync: Disable periodic advertising before removing a set"
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


https://github.com/bluez/bluetooth-next/pull/1241

---
Regards,
Linux Bluetooth


--===============2480331292984710128==--
