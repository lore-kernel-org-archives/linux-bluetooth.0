Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946404;
	b=hfOJN6ZUILNY5UwzWzGfSM3jYdfJhd4x0QUrBwMJTJAAPFqrQqUddm02wFb8a3mrIGZM
	 P9JSKSxNrZaOKzIdeU/9FB65Zyc21hDF6Dkxj32WuGPDOVDp82IXQFAj41SjyFBjv/5Pl
	 I/onr3tEYWB/MqWRMhpmW9PpD5J00NJA8HPiz6QYzfsszimgf5GLMk3dsDZokIKfTa2Uq
	 H97870DO3eaHSs29ukobZvQdw3WDQC+ux1XsVhJCzWywGm2A8A4txugD+CJHoEn3Ovq5z
	 M9jjHKGgJYIryBgeFUcKcWhBveJhcADrPTByBZBhDzm7M6VX/VRjS6eqP4701T44fVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946404;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=/n2JAWAt3eTv2I5vLu0CDxmguDIqo4j53Bb0goeFIvo=;
	b=Yl9M6P4TdPMfSlsSiDF/eyHn6EFfQF69+qfwXH/tmw5u3NhmOwny6kl//3sQ6gt03H9Y
	 37TfNvZNRLBrulF6l6li37aMlpJ+U7arCEX1Zr/Tk67KpHPa5vVCY/cmj1VH1K5aoI2br
	 ZbyhuLl5u0uok/n//Y/vNXAD6OBNySl7fXm7PbM8coOKYUahOsSmSOb3sVLcJtkzW/TtF
	 5os/61xZfadHctL4JBtltOOJ46I5FeGFozihjXeIa+uE+g5ayFHqHYCer+tQVTVJrE9J5
	 sTV2Nfnyx8FZRoF+ihnD7ADyK8VNW73m1f2FXdiU2GHExQs0pxWGiggcb/4Gsij6qPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N0yziCDa;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DD9606A31C
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 20:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78DD9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N0yziCDa
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e977109392so1243415ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 12:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794946403; x=1795551203; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/n2JAWAt3eTv2I5vLu0CDxmguDIqo4j53Bb0goeFIvo=;
        b=N0yziCDaIeNSfi6deBYGyNLKSmebZNgGouC9dOpU2r7OJTke7hZMFgJRbmQbviU1E4
         KnDv0xnENomosBW237Vg92aO7QqZuYLgozyvobKjDgFMIQWsYACY74Xxl+RqTj9yMr/d
         rGt1t8ZQYmKEPQpXS9OsSKTn0pAR6OqIeZIMZAtEmDjJy/ZaY6M0s5okw8/7cb7YhC3Z
         D9LuYjqhXOw1BcqtCKg6uncdJG3sVrTXQLp3NBdBl+MTI6MjVpZ06X+CWwP769fd97Mn
         NWBbMfrjHpgoy+5nYZjTb2Nqza/lDLEQaLFHhQmGRM8hAkSI5K73B8G0e2YT0XUtxrH9
         1iRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794946403; x=1795551203;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/n2JAWAt3eTv2I5vLu0CDxmguDIqo4j53Bb0goeFIvo=;
        b=OrtnOaX5F4+W+/HqAXnfURfbBNaE+Ulk29Vu5DBjTcDt1x6TOXhRw/GuRRQ59N0e7c
         ap+NZuMnOVwqI+09eUeH+yETooRe7FFxEnRqG8Wp4leHw0ELbvNk0S/yfOE0FFA65y0L
         iO2zUMrfHxhuXdQQm1cL9mZ5xr3HLUyILZsdk7srQ31jf2zGpPnGQW/3YvKAZt4LXuM+
         dgQNwqeMo2AyECNJTHVEMm72IX1HMzX74GJaRpuXAPaYQt4cwIoz7L4sONJeBuv6IHxZ
         Ck3z8BQ8wcNd/soir71CZuh5jFHaA83c6YiiZRpCpzlfqdpd2RAXkEkA0pLbfDjs+JfM
         AQ/w==
X-Gm-Message-State: APuU4Z+npd2igv4Gvn+/anrQjJ3JsaSWry6DZwjMhvmBoQdBsai8RmTf
	pqQp/anAagVFBa/Zl2QAeygKn4SngxOBBYPBOAmN+lv+6KgcLs+idpyTzM5LZA==
X-Gm-Gg: AZFdTZdn5kSlYWRPoC/Ib6LX+Ih0+ey2SUNlMhci73DH1HYeHJ49cA4GJ2eWD+gEGAA
	6W5Dg3ePwyHyNiwIdMpX8YWZV3beBvYE34x1WVPVSHtLK6AaSAdPxbzdlHCGKaAs7EEEAwS9g7b
	Atn9rSkn+KNWviJkDO0y/RhtijgGKkJ+w5r6DtTCpxw/J4cqkgUrEJZWG/JfrStakmwPXsNeXU4
	wfmTLkK25De47clR7OPShTdT4BA09uuKJISHVbUxLflcsNY6MBC4OTfclUYuYDbLLRREk70+fPn
	44jF8APnrGlksIeI6BZBlddIB5yMcn+qfnOOVQerysTPDwtCMnWxodYR6oQTrJ32XdyQCscKedc
	A7Re9uPdaU69YPw6JVXkOzGqgGEyteTsZwkUaIFzZ4nr67InywXGdwcLH1RK2RsSaaEXR+3tsJT
	uMZktGcGWkjgNwKwdKbygZv0IVeeYqwSn4ghV54rbX24THvUyG1X45v8sAEtBdDD5RC1xiWSOGG
	i2/UrDdc6UNsK5dg3fCuB3H+NgA3Uj25D5qfKkez0NgSCP97y2gYrwVO0Wfr8ttu5B7n22N2R2Q
	s0Y9+cSgBikwcATQopu1dX3NWP+lnzxBNd0okEs=
X-Received: by 2002:a17:902:e541:b0:2e2:e3aa:7a35 with SMTP id d9443c01a7336-2eff756e4f7mr3660635ad.36.1794946402536;
        Tue, 17 Nov 2026 12:13:22 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-42-157-64.us-west-2.compute.amazonaws.com. [3.42.157.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff5ed13a2sm2544995ad.6.2026.11.17.12.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:13:21 -0800 (PST)
Message-ID: <6afcb561.44d83eff.99f24.7c4c@mx.google.com>
Date: Tue, 17 Nov 2026 12:13:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8831979713792030220=="
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
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: Fixes for issues reported by sashiko.dev
In-Reply-To: <20261117185737.3758255-2-luiz.dentz@gmail.com>
References: <20261117185737.3758255-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8831979713792030220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1214200/

---Test result---

Test Summary:
CheckPatch                    FAIL      6.95 seconds
VerifyFixes                   PASS      0.05 seconds
VerifySignedoff               PASS      0.06 seconds
GitLint                       FAIL      2.62 seconds
SubjectPrefix                 PASS      0.81 seconds
BuildKernel                   PASS      20.07 seconds
CheckAllWarning               PASS      23.47 seconds
CheckSparse                   WARNING   25.04 seconds
BuildKernel32                 PASS      20.33 seconds
CheckKernelLLVM               PASS      20.77 seconds
TestRunnerSetup               PASS      479.13 seconds
TestRunner_l2cap-tester       PASS      16.07 seconds
TestRunner_iso-tester         PASS      11.73 seconds
TestRunner_bnep-tester        PASS      3.12 seconds
TestRunner_mgmt-tester        PASS      84.64 seconds
TestRunner_rfcomm-tester      PASS      4.37 seconds
TestRunner_sco-tester         PASS      5.42 seconds
TestRunner_ioctl-tester       PASS      4.49 seconds
TestRunner_mesh-tester        PASS      4.41 seconds
TestRunner_smp-tester         PASS      4.30 seconds
TestRunner_userchan-tester    PASS      3.20 seconds
TestRunner_6lowpan-tester     PASS      4.37 seconds
IncrementalBuild              PASS      56.39 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v1,01/16] Bluetooth: mgmt: Fix read_index_list() buffer overflow
ERROR: Unrecognized email address: 'sashiko.dev (linux-7841362e-9b8f-465f-aa22-e99c315231e2)'
#127: 
Reported-by: sashiko.dev (linux-7841362e-9b8f-465f-aa22-e99c315231e2)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#127: 
Reported-by: sashiko.dev (linux-7841362e-9b8f-465f-aa22-e99c315231e2)
Fixes: 73d1df2a7a10 ("Bluetooth: Add support for Read Unconfigured Index List command")

WARNING: Non-standard signature: Assisted-by:
#129: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#129: 
Assisted-by: OpenCode:claude-fable-5.2

total: 2 errors, 2 warnings, 0 checks, 12 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14994489.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v1,02/16] Bluetooth: hci_core: Take req_sync lock in hci_power_on()
ERROR: Unrecognized email address: 'sashiko.dev (linux-1baf7393-3aeb-4fa5-806f-19cea743b9f3)'
#125: 
Reported-by: sashiko.dev (linux-1baf7393-3aeb-4fa5-806f-19cea743b9f3)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#125: 
Reported-by: sashiko.dev (linux-1baf7393-3aeb-4fa5-806f-19cea743b9f3)
Fixes: cf75ad8b41d2 ("Bluetooth: hci_sync: Convert MGMT_SET_POWERED")

WARNING: Non-standard signature: Assisted-by:
#127: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#127: 
Assisted-by: OpenCode:claude-fable-5.2

total: 2 errors, 2 warnings, 0 checks, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14994488.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v1,03/16] Bluetooth: hci_sync: Lock the lookup in hci_disable_ext_adv_instance_sync()
ERROR: Unrecognized email address: 'sashiko.dev (linux-a364929c-cd00-492a-a83c-5425d042b09f)'
#127: 
Reported-by: sashiko.dev (linux-a364929c-cd00-492a-a83c-5425d042b09f)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#127: 
Reported-by: sashiko.dev (linux-a364929c-cd00-492a-a83c-5425d042b09f)
Fixes: cba6b758711c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2")

WARNING: Non-standard signature: Assisted-by:
#129: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#129: 
Assisted-by: OpenCode:claude-fable-5.2

total: 2 errors, 2 warnings, 0 checks, 36 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14994490.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v1,04/16] Bluetooth: hci_sync: Hold hdev->lock in hci_schedule_adv_instance_sync()
ERROR: Unrecognized email address: 'sashiko.dev (linux-616b1f8e-06ec-4634-a907-5eb4e82f66df)'
#125: 
Reported-by: sashiko.dev (linux-616b1f8e-06ec-4634-a907-5eb4e82f66df)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#125: 
Reported-by: sashiko.dev (linux-616b1f8e-06ec-4634-a907-5eb4e82f66df)
Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")

WARNING: Non-standard signature: Assisted-by:
#127: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#127: 
Assisted-by: OpenCode:claude-fable-5.2

total: 2 errors, 2 warnings, 0 checks, 22 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14994491.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v1,05/16] Bluetooth: SMP: Serialize link key updates from smp_notify_keys()
ERROR: Unrecognized email address: 'sashiko.dev (linux-7482a666-d2a0-44a4-9e0d-05354860a5fa)'
#133: 
Reported-by: sashiko.dev (linux-7482a666-d2a0-44a4-9e0d-05354860a5fa)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#133: 
Reported-by: sashiko.dev (linux-7482a666-d2a0-44a4-9e0d-05354860a5fa)
Fixes: 6a77083af57f ("Bluetooth: Add support for LE SC key generation")

WARNING: Non-standard signature: Assisted-by:
#135: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#135: 
Assisted-by: OpenCode:claude-fable-5.2

total: 2 errors, 2 warnings, 0 checks, 134 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14994492.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v1,06/16] Bluetooth: SMP: Check smp_data before using SMP_DEV()
ERROR: Unrecognized email address: 'sashiko.dev (linux-9bc9da90-02a8-4a87-a603-87d0a4cf464c)'
#126: 
Reported-by: sashiko.dev (linux-9bc9da90-02a8-4a87-a603-87d0a4cf464c)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#126: 
Reported-by: sashiko.dev (linux-9bc9da90-02a8-4a87-a603-87d0a4cf464c)
Fixes: 94f14e472812 ("Bluetooth: SMP: Fix trying to use non-existent local OOB data")

WARNING: Non-standard signature: Assisted-by:
#128: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#128: 
Assisted-by: OpenCode:claude-fable-5.2

total: 2 errors, 2 warnings, 0 checks, 18 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14994493.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v1,07/16] Bluetooth: SMP: Don't create the BR/EDR channel while unregistered
ERROR: Unrecognized email address: 'sashiko.dev (linux-a921c99c-0b41-485c-91a4-1c6e54b45b0b)'
#128: 
Reported-by: sashiko.dev (linux-a921c99c-0b41-485c-91a4-1c6e54b45b0b)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#128: 
Reported-by: sashiko.dev (linux-a921c99c-0b41-485c-91a4-1c6e54b45b0b)
Fixes: 300acfdec916 ("Bluetooth: Introduce force_bredr_smp debugfs option for testing")

WARNING: Non-standard signature: Assisted-by:
#130: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#130: 
Assisted-by: OpenCode:claude-fable-5.2

total: 2 errors, 2 warnings, 0 checks, 34 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14994494.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v1,08/16] Bluetooth: hci_event: Validate sent command length in LE Set Ext Adv Enable
ERROR: Unrecognized email address: 'sashiko.dev (linux-42bcc244-62e6-4295-802c-f9a512ca49a3)'
#125: 
Reported-by: sashiko.dev (linux-42bcc244-62e6-4295-802c-f9a512ca49a3)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#125: 
Reported-by: sashiko.dev (linux-42bcc244-62e6-4295-802c-f9a512ca49a3)
Fixes: de181e887ac2 ("Bluetooth: Impmlement extended adv enable")

WARNING: Non-standard signature: Assisted-by:
#127: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#127: 
Assisted-by: OpenCode:claude-fable-5.2

total: 2 errors, 2 warnings, 0 checks, 18 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14994495.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v1,09/16] Bluetooth: mgmt: Reject zero multi advertising rotation duration
ERROR: Unrecognized email address: 'sashiko.dev (linux-24ecb695-0c5c-408a-a016-a980c3115e95)'
#126: 
Reported-by: sashiko.dev (linux-24ecb695-0c5c-408a-a016-a980c3115e95)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#126: 
Reported-by: sashiko.dev (linux-24ecb695-0c5c-408a-a016-a980c3115e95)
Fixes: 17896406ff35 ("Bluetooth: implement read/set default system parameters mgmt")

WARNING: Non-standard signature: Assisted-by:
#128: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#128: 
Assisted-by: OpenCode:claude-fable-5.2

total: 2 errors, 2 warnings, 0 checks, 12 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14994496.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v1,10/16] Bluetooth: L2CAP: Don't use uninitialized EFS in l2cap_parse_conf_rsp()
ERROR: Unrecognized email address: 'sashiko.dev (linux-089f015e-6251-4fea-85ef-7d6761e8c457)'
#125: 
Reported-by: sashiko.dev (linux-089f015e-6251-4fea-85ef-7d6761e8c457)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#125: 
Reported-by: sashiko.dev (linux-089f015e-6251-4fea-85ef-7d6761e8c457)
Fixes: 66af7aaf9edf ("Bluetooth: EFS: parse L2CAP config response")

WARNING: Non-standard signature: Assisted-by:
#127: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#127: 
Assisted-by: OpenCode:claude-fable-5.2

total: 2 errors, 2 warnings, 0 checks, 23 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14994497.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v1,11/16] Bluetooth: mgmt: Fix mesh transmission locking and lifetime
ERROR: Unrecognized email address: 'sashiko.dev (linux-4ab89465-fc27-4d91-a870-a8ed49b22e91)'
#147: 
Reported-by: sashiko.dev (linux-4ab89465-fc27-4d91-a870-a8ed49b22e91)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#147: 
Reported-by: sashiko.dev (linux-4ab89465-fc27-4d91-a870-a8ed49b22e91)
Reported-by: sashiko.dev (linux-93ef41e7-8b48-4483-aa5d-d21f1e27c104)

ERROR: Unrecognized email address: 'sashiko.dev (linux-93ef41e7-8b48-4483-aa5d-d21f1e27c104)'
#148: 
Reported-by: sashiko.dev (linux-93ef41e7-8b48-4483-aa5d-d21f1e27c104)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#148: 
Reported-by: sashiko.dev (linux-93ef41e7-8b48-4483-aa5d-d21f1e27c104)
Reported-by: sashiko.dev (linux-ab941894-dbe1-49da-8bac-c52efda6eaee)

ERROR: Unrecognized email address: 'sashiko.dev (linux-ab941894-dbe1-49da-8bac-c52efda6eaee)'
#149: 
Reported-by: sashiko.dev (linux-ab941894-dbe1-49da-8bac-c52efda6eaee)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#149: 
Reported-by: sashiko.dev (linux-ab941894-dbe1-49da-8bac-c52efda6eaee)
Reported-by: sashiko.dev (linux-4016f774-7ac7-4b8a-916f-587ec9d597d4)

ERROR: Unrecognized email address: 'sashiko.dev (linux-4016f774-7ac7-4b8a-916f-587ec9d597d4)'
#150: 
Reported-by: sashiko.dev (linux-4016f774-7ac7-4b8a-916f-587ec9d597d4)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#150: 
Reported-by: sashiko.dev (linux-4016f774-7ac7-4b8a-916f-587ec9d597d4)
Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")

WARNING: Non-standard signature: Assisted-by:
#152: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#152: 
Assisted-by: OpenCode:claude-fable-5.2

total: 5 errors, 5 warnings, 0 checks, 365 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14994498.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v1,12/16] Bluetooth: MGMT: Fix use-after-free in mgmt_powering_down()
ERROR: Unrecognized email address: 'sashiko.dev (linux-e45413fa-48a6-43f1-90be-638841567534)'
#127: 
Reported-by: sashiko.dev (linux-e45413fa-48a6-43f1-90be-638841567534)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#127: 
Reported-by: sashiko.dev (linux-e45413fa-48a6-43f1-90be-638841567534)
Fixes: 302a1f674c00 ("Bluetooth: MGMT: Fix possible UAFs")

WARNING: Non-standard signature: Assisted-by:
#129: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#129: 
Assisted-by: OpenCode:claude-fable-5.2

total: 2 errors, 2 warnings, 0 checks, 34 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14994499.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v1,13/16] Bluetooth: MSFT: Protect the event prefix with hdev->lock
ERROR: Unrecognized email address: 'sashiko.dev (linux-246df501-f32c-46fd-8779-7fa755ed7f9d)'
#128: 
Reported-by: sashiko.dev (linux-246df501-f32c-46fd-8779-7fa755ed7f9d)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#128: 
Reported-by: sashiko.dev (linux-246df501-f32c-46fd-8779-7fa755ed7f9d)
Fixes: 5031ffcc79b8 ("Bluetooth: Keep MSFT ext info throughout a hci_dev's life cycle")

WARNING: Non-standard signature: Assisted-by:
#130: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#130: 
Assisted-by: OpenCode:claude-fable-5.2

total: 2 errors, 2 warnings, 0 checks, 88 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14994500.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v1,14/16] Bluetooth: hci_debugfs: Fix racy toggling of debugfs controlled flags
ERROR: Unrecognized email address: 'sashiko.dev (linux-442108d5-76ce-44a1-a84d-16b44d6a26a6)'
#132: 
Reported-by: sashiko.dev (linux-442108d5-76ce-44a1-a84d-16b44d6a26a6)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#132: 
Reported-by: sashiko.dev (linux-442108d5-76ce-44a1-a84d-16b44d6a26a6)
Fixes: 4b4148e9acc1 ("Bluetooth: Add support for setting DUT mode")

WARNING: Non-standard signature: Assisted-by:
#134: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#134: 
Assisted-by: OpenCode:claude-fable-5.2

total: 2 errors, 2 warnings, 0 checks, 102 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14994501.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v1,15/16] Bluetooth: hci_core: Hold hdev->lock when removing advertisement monitors
ERROR: Unrecognized email address: 'sashiko.dev (linux-8b358899-5ac9-4687-af16-58420a4d9bba)'
#129: 
Reported-by: sashiko.dev (linux-8b358899-5ac9-4687-af16-58420a4d9bba)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#129: 
Reported-by: sashiko.dev (linux-8b358899-5ac9-4687-af16-58420a4d9bba)
Fixes: 7cf5c2978f23 ("Bluetooth: hci_sync: Refactor remove Adv Monitor")

WARNING: Non-standard signature: Assisted-by:
#131: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#131: 
Assisted-by: OpenCode:claude-fable-5.2

total: 2 errors, 2 warnings, 0 checks, 32 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14994502.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v1,16/16] Bluetooth: RFCOMM: Serialize tty device reparenting
ERROR: Unrecognized email address: 'sashiko.dev (linux-cd8016c2-2358-40f0-b65c-091f6a957f67)'
#127: 
Reported-by: sashiko.dev (linux-cd8016c2-2358-40f0-b65c-091f6a957f67)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#127: 
Reported-by: sashiko.dev (linux-cd8016c2-2358-40f0-b65c-091f6a957f67)
Fixes: acea6852f32b ("[BLUETOOTH]: Move children of connection device to NULL before connection down.")

WARNING: Non-standard signature: Assisted-by:
#129: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#129: 
Assisted-by: OpenCode:claude-fable-5.2

total: 2 errors, 2 warnings, 0 checks, 38 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14994503.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1,03/16] Bluetooth: hci_sync: Lock the lookup in hci_disable_ext_adv_instance_sync()

1: T1 Title exceeds max length (86>80): "[v1,03/16] Bluetooth: hci_sync: Lock the lookup in hci_disable_ext_adv_instance_sync()"
[v1,04/16] Bluetooth: hci_sync: Hold hdev->lock in hci_schedule_adv_instance_sync()

1: T1 Title exceeds max length (83>80): "[v1,04/16] Bluetooth: hci_sync: Hold hdev->lock in hci_schedule_adv_instance_sync()"
[v1,08/16] Bluetooth: hci_event: Validate sent command length in LE Set Ext Adv Enable

1: T1 Title exceeds max length (86>80): "[v1,08/16] Bluetooth: hci_event: Validate sent command length in LE Set Ext Adv Enable"
[v1,10/16] Bluetooth: L2CAP: Don't use uninitialized EFS in l2cap_parse_conf_rsp()

1: T1 Title exceeds max length (82>80): "[v1,10/16] Bluetooth: L2CAP: Don't use uninitialized EFS in l2cap_parse_conf_rsp()"
[v1,15/16] Bluetooth: hci_core: Hold hdev->lock when removing advertisement monitors

1: T1 Title exceeds max length (84>80): "[v1,15/16] Bluetooth: hci_core: Hold hdev->lock when removing advertisement monitors"
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


https://github.com/bluez/bluetooth-next/pull/1144

---
Regards,
Linux Bluetooth


--===============8831979713792030220==--
