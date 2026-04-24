Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2C9238166
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 13:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777036663; cv=none; b=qu2mPPr5EzN4aZ81XRfe76c9913yqJPfAhk300z/i4UUMbNe9WdvmcmpYsqoNQpO76ldVoOziUnljwIMvPzjtq7qZ5JnGCpdI7hjC7QerEfgLYv04I5THX3YZy673+z0O5OUWDF+svxH8WJ65tOWFCmzK+TU6yz2xjzMDdLRC6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777036663; c=relaxed/simple;
	bh=qDXnurOH//bBVY+e8MfNie96GJ+WeCoIlFV7W6kKmzU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ae4XmSbp9/E++4yfRNTOtaoFhQmNFRVkCmi9Ui9okxiebMCMGl56uYHpBt2mJJkN404eTd+uLJIu93UgqxVDynqbK3fkya1zwP2nv+y5zxtPMT3J5A2xda+KVAj+DY+WcK1qGRq9kiVX23mOOHslt/Jan1ZHz8QXuoTAlUf/7es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sIpFT1ij; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIpFT1ij"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12c6df0b9bbso4227610c88.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 06:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777036661; x=1777641461; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wb8S7KESghM2QTgOWWeS4BJifU2Adc7G9mXOmgCJdzQ=;
        b=sIpFT1ijlkFygV60JgGT3wok5B7h3MMkf5aFD7J9kQTHyC4PRM1+gaNmrls6s6FnUc
         8Y10spwbZumilrcZxrOJCOhTmKkfBbBirI8353J6dyfeZ9Z61Fzq/MbjjqHJYOvDfkcU
         IpDnM7GY0jqphl7n3n/uVOSV1eIu/LkwFDq012N+XXwdszmSBRtwiM9zppfJxaFVwdOd
         Z2rwR6c6PeYqXmlqEphRXov0BG5mh09E5a2W3xM6zdwkSuUc6V5RG3QOaR/rBWFs3BqX
         fDFfWXzrMQ3CjMdI5Ipih3HYt/TYTjf/a2Hnjt5bMSv9BHfGDgdc8kqmdlxk1k7AVnRP
         +1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777036661; x=1777641461;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wb8S7KESghM2QTgOWWeS4BJifU2Adc7G9mXOmgCJdzQ=;
        b=Y56jYjb7Exg0hOubl0+mrMwlNnq6iRliS5QDt+/EwioUjGExTpl70nNwZB5OCORdqR
         lWdUY6ONLWzOMPSwjwP4964QqX1zstbb/85sfnbxS/pLH8T7PnHgt7HCZcUtE+HWkOOf
         RxzHMksv5bpwOgVTXSTYTNQLw2amYMpY0cleIQGw24KSzS6e/OOz2dXE/77eNC9ctZw0
         AFXNLRfZG2xRb1LpoIzRMmihG7s4WdqAc9oquuNfT0Qtskl81nb3MISlgfRpq6ivAI/v
         uU9tRS7P4doOD+weMdcZTztUn+6OoFBros2Ekbo+zbqKWYouuQ6WuSICnU2+Ac1a3FXA
         R1mw==
X-Gm-Message-State: AOJu0YyLjgp8LoEp8qoq35qrXrhyLTX+M6w8h4T1arasU75o/OS9hJ+J
	GsWzgyDApCWG2bi1L3+sDDeHgfSx+YgMSabvvPh33WPBrpcX9XF5NRfpUSZMyA==
X-Gm-Gg: AeBDietET/gWwzSFnI0574HYe9wonhG26XLUnTv/H7nSGYXWptF/Kp+Tf75hJ+WrnG+
	oHUxxToKpySZFvdvSQxlMk53PpCBr7dhwKSwm7/LU+BTlp45pQo++WdWTIUQSThEjKOEkAVqV3u
	Ce53CE+12jC9M8hjV/71x7sT545O9LkApjV/48AYqOrpjwwmlc7CeZ1Zp9dBOrESs9TTVVgHVHX
	GWyoyKF7Y2Gv+hG+ujbFNknCe8t7fnBjy5Oq6PhXottTp3Z8hhEC+jMTyLYSDv5i2GUT9/TIIBa
	cZ8nWX/BkcSJz1tpc5MN6Moa0wHtfnrpyBsOCt8RinR/1V7os049NxPpBYh1KkGbsyXYazrn6g7
	I/vEipI15lj1W4GcXREOhlZOIk+FEwMZbArVPT6CH/r9mQINMt66wLZHbdCLTExhLZjhWKtmpCv
	o5FowxkTjzI1rhRLpNQYnDnC+92iBHok6z32C98mHjevdds0M5QRDNow==
X-Received: by 2002:a05:7300:371e:b0:2e2:d94d:6185 with SMTP id 5a478bee46e88-2eada6d676emr2365276eec.4.1777036660569;
        Fri, 24 Apr 2026 06:17:40 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.200.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce0f5sm31664119eec.17.2026.04.24.06.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 06:17:40 -0700 (PDT)
Message-ID: <69eb6d74.050a0220.d8405.02bb@mx.google.com>
Date: Fri, 24 Apr 2026 06:17:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7562782296692317543=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhangchen200426@163.com
Subject: RE: [v2] Bluetooth: btusb: Add Realtek RTL8922AE VID/PID 0bda/d922
In-Reply-To: <20260424120928.397758-1-zhangchen200426@163.com>
References: <20260424120928.397758-1-zhangchen200426@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7562782296692317543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1085181

---Test result---

Test Summary:
CheckPatch                    FAIL      0.59 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.46 seconds
BuildKernel                   PASS      26.51 seconds
CheckAllWarning               PASS      29.15 seconds
CheckSparse                   PASS      27.73 seconds
BuildKernel32                 PASS      25.47 seconds
TestRunnerSetup               PASS      572.86 seconds
IncrementalBuild              PASS      24.70 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: btusb: Add Realtek RTL8922AE VID/PID 0bda/d922
WARNING: Duplicate signature
#116: 
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14537778.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/120

---
Regards,
Linux Bluetooth


--===============7562782296692317543==--
