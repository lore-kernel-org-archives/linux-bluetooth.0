Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC69F376A08
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 20:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780086592; cv=none; b=Ilp8ICRLrngAUZJh/ek10CJSWOPqivVN49Zjm6JqK3YsdOrsWaviP815VjulR94IUoavaL40ZGiQIuGsTB1jWokBdyLgpuXBdaUWdU4qXvyCNBFPSJ03a1lTGZdhKWTBv57Q3uH8BMU0gJANxa+Xx1jI0lOC7CsDFBYLizkx6FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780086592; c=relaxed/simple;
	bh=CcjNpUagqxJuSiv58+Utof9/ZNVGbIp7avdmCi1yevE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AinStKL/yXebrtnU/uanhfX5s0PNXk7TvhYpRuvdfuFJFFHB9m3IhRXJCoW2MRqjy2sSLGiRiw8ObEt5iCi99OOPytf3mkomyMu9SlMKWSJxpVeC2Phdjgkmg8Kr8paOyJjl4DnUt21cmt27mDcdaJDiupuZUAcS/Km0rV0PRw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boeA7hmG; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boeA7hmG"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8cbe69b122bso88400316d6.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 13:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780086590; x=1780691390; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c3CL4UM6+YRqJOt7leLMvnIMkuzNv00ohlPj3bNzcc8=;
        b=boeA7hmG/ak5Us3HpEhUlKnyh+pzXe/NAdflZfk/Iirq7hFwUoo4Z1LGXLhS2DjTiN
         4VPD68ya6HC7QQyWiWWis1EoQjCL/+iKxZfUsuwFwasYdfgHrTzSnauJKOgDRIjpoEat
         k8TvjNPTUA5MqcrIoQ5VdLgyyvUegHXfQqwr2q/y//d1N86cq+PyxUX5zOS5H9gLEsXS
         z7tJp9zVkwIwv8p4T3dhQ1+RfOKFj9VBS8Ql/xdGF4gAyL0L4uDxUy+TszcPKq58cfts
         cvQf9tCMBQDuUVMFV7/HmjREgCpi5ORf/vcG4qBd8Dk0JDJO3dmqaKYq/y61d1KBig3P
         UAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780086590; x=1780691390;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3CL4UM6+YRqJOt7leLMvnIMkuzNv00ohlPj3bNzcc8=;
        b=nafYFJKhRC9CndMlMU3s+1x4KOxQdKbBiEtWJLWYBsLhUfz0yVi0+4zq4HJdVLqezC
         izfisjd2gcGKLalOVYwGOI2SfBAcHUVGgvNG7SfstvnYJAainK1T38kc/IWertdXpQ5E
         JtzsuvreOOmgSYsYie4+YpPqgoA1txo14wwbn8mCW2iNltt6e2pprdygxCFrBS0HwwNg
         i8cc5G6XMq06Tr0z06MM5kQV5+XPF7yhpS6F09ZvZnVfw4DRMzlGPh/Giq/DwqVk4RPy
         cqnbyKhwc9/oMcJBQkcbdsBR3wkCDSmlXXcRnmS4U4985NydNxNcczMBBsbdkZtp+jFn
         j+zQ==
X-Gm-Message-State: AOJu0YycyXyH/B2MrJ4l+pnC+dEzhw7Id+TWipmYi5ew47lFfMFKSoho
	71UueFnlTOqDTHqMFyiDIE/ZP3l/t9OP+/X1+JytErnc4Iuhxs1lsEDTlz4CjA==
X-Gm-Gg: Acq92OEsbMvH2CGyN9UcOb6D/fIy7PbcO9kAFKB0GmKt4yih1R+iZ+aw1vjXB3YKaXY
	YwjfNfEkEuyjBtCsjQ4dRX5Rtxyk9AcMcNOv4+DU0BTTcXj27kU1dtOO7huDhLGXCpGhiWFu+Mi
	X20iVQERpmkwXNllof60tr2zIyIHZ6VKhaJnk8kceXoYUrkqZoGEF6p4nY4tUXbmehAbfCispSn
	qEBHKKWw21yKCFuQ4g8vQpf5+ECzdFjzZmG1FvIgUiLjXQW5/f+O3OJF9+Uo2yncRfBRsYe0Jle
	ogrNLT1Qod954MZIToUIcj/tezjL2P2XqrpISskv7SCcwtWf08zijxwYQBscSlvRPfULuSGSeWN
	EtxIv7+GxWXH8anq7ulxdTMKZEjwd7FAqDRQV7yPtMA27Fu6fj4NxTGyWwR2J20LJSyV7/6PjA1
	8QhupYvN98ttttuYDyS4kB94vU4Xhobehj7h3enw0=
X-Received: by 2002:ad4:4eea:0:b0:8cb:e63e:2a4c with SMTP id 6a1803df08f44-8ccefd2d52emr22207106d6.12.1780086589929;
        Fri, 29 May 2026 13:29:49 -0700 (PDT)
Received: from [172.17.0.2] ([20.119.79.72])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea1cadd2sm27388046d6.24.2026.05.29.13.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 13:29:49 -0700 (PDT)
Message-ID: <6a19f73d.143d05a0.bd374.a96b@mx.google.com>
Date: Fri, 29 May 2026 13:29:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5230248191683250423=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yepuri.siddu@oss.qualcomm.com
Subject: RE: [1/4] dt-bindings: bluetooth: qcom,qcc2072-bt: add bindings for QCC2072
In-Reply-To: <20260529175342.3363935-1-yepuri.siddu@oss.qualcomm.com>
References: <20260529175342.3363935-1-yepuri.siddu@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5230248191683250423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1103053

---Test result---

Test Summary:
CheckPatch                    FAIL      3.60 seconds
VerifyFixes                   PASS      4.63 seconds
VerifySignedoff               PASS      0.72 seconds
GitLint                       FAIL      1.64 seconds
SubjectPrefix                 FAIL      0.44 seconds
BuildKernel                   PASS      25.11 seconds
CheckAllWarning               PASS      28.10 seconds
CheckSparse                   PASS      26.48 seconds
BuildKernel32                 PASS      24.42 seconds
TestRunnerSetup               PASS      526.63 seconds
IncrementalBuild              PASS      28.03 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/4] dt-bindings: bluetooth: qcom,qcc2072-bt: add bindings for QCC2072
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#176: 
new file mode 100644

total: 0 errors, 1 warnings, 38 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14601841.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[1/4] dt-bindings: bluetooth: qcom,qcc2072-bt: add bindings for QCC2072

15: B1 Line exceeds max length (88>80): " create mode 100644 Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


https://github.com/bluez/bluetooth-next/pull/258

---
Regards,
Linux Bluetooth


--===============5230248191683250423==--
