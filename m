Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1398C3B6C01
	for <linux-bluetooth@vger.kernel.org>; Sat, 29 Aug 2026 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788018334; cv=none; b=XYnJqR3j7IqLvvJnZGaEKkmUYFbcz5nFXTxY0Y2z30zvx4q5MoKoivLWQNsjxpjvrRNvskWEbA+m/uSUmLUrI0xxqSLpUOT42ZlCTHAcnm47cH5+2QaCOwzX+tARLJsyDE9iTt64UbaWUWE5+Azn5J6w1VtbWZc1MBkFsR1CiB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788018334; c=relaxed/simple;
	bh=35Lvbnh9dWnsopeGnv/+uDgQIKaeUoM6CgNE3ESoZI8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RgoLFa1WwIqRWqiXshBF3hNX31e0uw8QiRPSDQ0FWJ4L0DSpj2uEtpmXzouBONGSVPhlXaTN3DFJFAUKdwfLykYuNO50pHobENDTQQy0neOry5ROcqjt64RR/7S0nBTKuGMAj1EFbmEZl7t/kQgoQ0zSFyNpQmU5gHYNC2iPQm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkY7I8S+; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkY7I8S+"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d72ae08fa1so17064125ad.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Aug 2026 08:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788018331; x=1788623131; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Kqn2Dx/aicUuzf5QASjar1D8PolcXl6NlxdWFH1ZYT8=;
        b=IkY7I8S+gJE3H17gqYP/qX1+FyJWhrvLGgCr47AEJ6xXuq1IvIXimd4eiWIIugsXlW
         CNT4bGZ3ZKVn0r4Lx3SUoXvKqbccfi+VKhd+3Nmo2ZOLl43uzjWoG9qZ4YBlsVGoOfbb
         vIdDXu7rSqZfjJAm1M/TGr3u450nwbj8+8xR1xeGipSOH8ajeQYxTH5DkhubsOvdVlZC
         //dhrKUJ5PSZn5CHpPMpicipXvTgkP4YQaPcBcm19ylwNEjCDWJo+Yth+DnDInS4GRL9
         inEgQzSoRdTzeubL8+fd9kH5g+LpusCTy39S3VazzRLomeUau+Z0plN5ruqVAuc/m6Hd
         OuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788018331; x=1788623131;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Kqn2Dx/aicUuzf5QASjar1D8PolcXl6NlxdWFH1ZYT8=;
        b=NUXhLsCD2dG1IzrGotc449m6AWcN9J7eEWRcTYrAoMMixjFhg6F7Vp9mOdSaR9H6aj
         JvJVbNzGfea9rhzn5kO0NQGMTnj+COca8/WGwd+0CnjLkJ3nRaPdzP2Tr6GwHpUSZux7
         7iW0abZxCv0+oKPZYORvnzi6dFKMtjQ1W5uv6lmoHmFTYkPS+J+bmj71VcizEU4l5Pmm
         ST/2Enpe6g2j2e7h8o46CqkTIU5XBggvNVm5CJ8h5npVmcwlVG2jEJjzIMYNwsk9TZ+d
         8HlpBS1/Iz4h9dKONeYmRLxQvhRf1cbqTUct9qMCkg+hU8ZM44efcaL96bdK9DpN8htf
         eWfQ==
X-Gm-Message-State: AFuF++mIuwdNKGlsN3lMJXqGNt1M09XgVhvbk5ukAtKMZ3yFsWnujo7E
	IQH+UsjdjOfxYjEjlp/YSKShgphvqP7oewRUa/IgGsvJSud3nqh6V2aj6YgC+Q==
X-Gm-Gg: AYBFou03Boz77P4DJ0fsKTubOZa9a7hCzvZCR8p1UyUBeAPi0oHcc0EkfNjV/2WKXeO
	oLL8N0pKJHPvpQqeCPGMRFjiM270RCdYPOB/3HhoOQw+BU02jYyCjQnE3PFslSSuhR+KiHq+DYJ
	LUCQPBijAtp+l/JX4ma7E8m49qh5tpkdm51pwV6NAMIbpo9VU6Bt3nLmAuERU4SwllNKh5tVl3s
	FQVV2MGe5AKH16hmzt96pEbsB8h3C0P+0lMaulFljSd5YBJ8ZWhanNoYRtm2khPfagusvN3bmEN
	0uPRc8zXs5MdlPlzqdkhMTw2s6pWmQcHm25TMiw0W5fYvzOD75htAVSYPaufrlnz5VLm9zX8+6W
	Nta7MGLhEwRl1m7iscRslzJS6T8/khfBNvwz4zV+IHl71e1/E8jDLe9OlcsZUOZtgxig8ugQzdh
	Ps8vaB3V83z0Jmmm3B3/Niu3gRZcx2rNJtPgMvbfVsFR7mFRmZqn0DbZxfV395bxXxkHI=
X-Received: by 2002:a17:903:1590:b0:2d8:d4d3:da51 with SMTP id d9443c01a7336-2d8d4d3db89mr100738965ad.21.1788018330752;
        Sat, 29 Aug 2026 08:45:30 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.253.38])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32b4bc05416sm2724280eec.6.2026.08.29.08.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 08:45:30 -0700 (PDT)
Message-ID: <6a92fe9a.244fc04b.a56c2.6f76@mx.google.com>
Date: Sat, 29 Aug 2026 08:45:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0381408372663931423=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: L2CAP: fix and annotate l2cap_conn::chan_l locking
In-Reply-To: <dbcbac89076e5aa3aa4f3ab22a82f85e051bb022.1788013041.git.pav@iki.fi>
References: <dbcbac89076e5aa3aa4f3ab22a82f85e051bb022.1788013041.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0381408372663931423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1153622

---Test result---

Test Summary:
CheckPatch                    FAIL      9.75 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      3.65 seconds
SubjectPrefix                 PASS      1.36 seconds
BuildKernel                   PASS      22.58 seconds
CheckAllWarning               PASS      25.40 seconds
CheckSparse                   PASS      24.17 seconds
BuildKernel32                 PASS      22.14 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      379.29 seconds
TestRunner_l2cap-tester       PASS      58.14 seconds
TestRunner_6lowpan-tester     PASS      19.38 seconds
IncrementalBuild              PASS      74.33 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[02/16] Bluetooth: L2CAP: add l2cap_chan_close_unlocked() and locking helpers
WARNING: The commit message has 'syzkaller', perhaps it also needs a 'Fixes:' tag?

total: 0 errors, 1 warnings, 0 checks, 132 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14774767.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[03/16] Bluetooth: L2CAP: fix race condition in l2cap_sock_shutdown()
WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#113: 
Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>

total: 0 errors, 1 warnings, 0 checks, 31 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14774781.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[11/16] Bluetooth: L2CAP: hold chan in l2cap_ecred_conn_rsp()
WARNING: Assisted-by expects 'AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]' format
#104: 
Assisted-by: deepseek-v4-flash

total: 0 errors, 1 warnings, 0 checks, 29 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14774789.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[12/16] Bluetooth: L2CAP: annotate locking for l2cap_chan_del()
ERROR: "foo * bar" should be "foo *bar"
#156: FILE: include/net/bluetooth/l2cap.h:657:
+	int			(*recv) (struct l2cap_chan * chan,

WARNING: Unnecessary space before function pointer arguments
#156: FILE: include/net/bluetooth/l2cap.h:657:
+	int			(*recv) (struct l2cap_chan * chan,

WARNING: Unnecessary space before function pointer arguments
#158: FILE: include/net/bluetooth/l2cap.h:659:
+	void			(*teardown) (struct l2cap_chan *chan, int err)

WARNING: Unnecessary space before function pointer arguments
#160: FILE: include/net/bluetooth/l2cap.h:661:
+	void			(*close) (struct l2cap_chan *chan);

WARNING: Unnecessary space before function pointer arguments
#161: FILE: include/net/bluetooth/l2cap.h:662:
+	void			(*state_change) (struct l2cap_chan *chan,

WARNING: Unnecessary space before function pointer arguments
#163: FILE: include/net/bluetooth/l2cap.h:664:
+	void			(*ready) (struct l2cap_chan *chan)

WARNING: Unnecessary space before function pointer arguments
#166: FILE: include/net/bluetooth/l2cap.h:667:
+	void			(*defer) (struct l2cap_chan *chan);

WARNING: Unnecessary space before function pointer arguments
#167: FILE: include/net/bluetooth/l2cap.h:668:
+	void			(*resume) (struct l2cap_chan *chan);

WARNING: Unnecessary space before function pointer arguments
#168: FILE: include/net/bluetooth/l2cap.h:669:
+	void			(*suspend) (struct l2cap_chan *chan);

WARNING: Unnecessary space before function pointer arguments
#169: FILE: include/net/bluetooth/l2cap.h:670:
+	void			(*set_shutdown) (struct l2cap_chan *chan);

WARNING: Unnecessary space before function pointer arguments
#170: FILE: include/net/bluetooth/l2cap.h:671:
+	long			(*get_sndtimeo) (struct l2cap_chan *chan);

WARNING: Unnecessary space before function pointer arguments
#171: FILE: include/net/bluetooth/l2cap.h:672:
+	struct pid		*(*get_peer_pid) (struct l2cap_chan *chan);

WARNING: Unnecessary space before function pointer arguments
#172: FILE: include/net/bluetooth/l2cap.h:673:
+	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,

ERROR: "foo * bar" should be "foo *bar"
#175: FILE: include/net/bluetooth/l2cap.h:676:
+	int			(*filter) (struct l2cap_chan * chan,

WARNING: Unnecessary space before function pointer arguments
#175: FILE: include/net/bluetooth/l2cap.h:676:
+	int			(*filter) (struct l2cap_chan * chan,

total: 2 errors, 13 warnings, 0 checks, 272 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14774790.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[13/16] Bluetooth: L2CAP: annotate locking for l2cap_ops callbacks
WARNING: Unnecessary space before function pointer arguments
#118: FILE: include/net/bluetooth/l2cap.h:663:
+	void			(*close) (struct l2cap_chan *chan)

WARNING: Unnecessary space before function pointer arguments
#127: FILE: include/net/bluetooth/l2cap.h:671:
+	void			(*resume) (struct l2cap_chan *chan)

WARNING: Unnecessary space before function pointer arguments
#131: FILE: include/net/bluetooth/l2cap.h:674:
+	void			(*set_shutdown) (struct l2cap_chan *chan)

total: 0 errors, 3 warnings, 0 checks, 37 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14774791.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[16/16] Bluetooth: L2CAP: refuse __l2cap_chan_add if chan already has conn
WARNING: Assisted-by expects 'AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]' format
#121: 
Assisted-by: deepseek-4-flash # finding the race condition

total: 0 errors, 1 warnings, 0 checks, 33 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14774794.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/664

---
Regards,
Linux Bluetooth


--===============0381408372663931423==--
