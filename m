Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795819190;
	b=bqrAZ0yOIER5o5p936CnHOkBpW/X3kqBacSc53CgHLgttD9kd7ERSTXKkhb4q7DB5O1n
	 KMkLmh03P8ec4xcacFykOIX3zad60ut/6FQOdA86QrNxapV+WEJyQLJDQhO3NLgd3rG1j
	 yXVI3KgatkBaTgCuu5VYQ55NdsdN0xRtoFtkMs0XGyBIhzmNMwjcpXC1o3PHUXS8T4Six
	 O1i9cYDQcWC9bn7FVxhtXBC8cthcRwtghQhN7fyJRIkSQAplKxttFEA6NSvcuUccf9tRJ
	 eezhngjt/1p8jPEl+EsMIQlMafTH73XxVaBa0ZqPo2PgB5R1AeZsgLQRFaBuVAGeDDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795819190;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=pY/5ZK4ZqCEmatAJico3Wux74LWqKERrvJtwEL1ToAw=;
	b=dD/Swvopq8PRnYLURqOYRmqSaChttZumDQc5KAkZGHOG78LV18d9znm5D3Pgw7CLZH2z
	 6VW6sydMBFznFf8d0HsZNEDR3lpJnGWUytknmzcBkKL9bzt2MIsnOPVYt2h32JoL73MWO
	 qy6Rpske8Uh615RtfkHYXSYC0D7EI6Hnz4/7gijaf3Ahu3XZhAk57tShGCPbY8L97X/4E
	 7S/OnerPHEcvtHWrubDCetqN4W1jSdyMTSJEVsPmUtZZKoX0fr6u2D6/1UMLbgSLqGn6C
	 txCmlC/FzZ/UdpyQENxHgLJzw/gGFLA8Lp8w8vthSJlDaJBsXBHNLX17D3PKvoYRt9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p4FHoa8X;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B42606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 22:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3B42606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p4FHoa8X
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-71b45386310so4095287eaf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 14:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795819188; x=1796423988; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pY/5ZK4ZqCEmatAJico3Wux74LWqKERrvJtwEL1ToAw=;
        b=p4FHoa8XLyGM7w7C+PIOgf0KXXRN0swhY61tKbEBTqVZ160o9sKvrSWTeGjNx1fgKO
         QiaUdRUhXkE62KpRUFKSVmIn6aAso71jggDQ6Y4qdBrtPcutX6TfH8hBWuePwfBMj3nt
         915iTjqOZ4N/RSTHCxShZpPHhfqUiuPC7jfxdKOu8Xme5EjKQ1h4kI7S5OJrDg2y2Oqy
         5g7NoZgH9WnQ0LnjuMOPZEJsI63UUy6FihjDos8F2SHVWUrDlgdu0sSMHphO77pdasEO
         t01+WnWYQXY1g3gWYshqjoUgIqpcv3HY+xcaPSo1gjZIGh8MTcYEboZcTosJIA6mlV5n
         PeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795819188; x=1796423988;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pY/5ZK4ZqCEmatAJico3Wux74LWqKERrvJtwEL1ToAw=;
        b=mCCDzWxIUuyUX/0VPtV11SzIHwVw78qo6rYxiXK6sefqxtOrQl9fbnWA1cgSbaHTMr
         5A+OUBrP6wnDxTf8oEdY/pgHiVGzUOLe/5yMmCB5JeFr3NStvzk6Vr7A9YOeH188rgDb
         mjmWOtWtbVQdK5nSfjREvkeQR78Hwm6l+1IdQcsaMYNX+SNPZJuXcsjg7YQqkV6KWLVX
         cT3cUQ3YpVD0otJLwRm4WJzgFa088glS+8Y0/IMg/NMt1k8BuVK6SvqSIDRKmMEfu0J8
         rBq00dHs0BiMGKYZBCDNZ74owovevgZRR1Mp16pnQ4rLTKb0iL53oga8INxLKqVmFVwl
         8k8Q==
X-Gm-Message-State: APuU4Z+ctlPXRSt1a7augxikTExkeuvufxwqGJ6K+lNME+IkBax9HgV3
	6MudLCvD0axR9jMqW+xWxhKoyfpn0uyYtVf9AyOxw3HLPHYZyu+dw3DwC9PJeADP
X-Gm-Gg: AZFdTZf1xXv4b1RzoVi5M2WvEbC7XLWVkBQ/HphaDfXQ9Zb55tQwv6Apf7BTFpkEPaZ
	XMLb/ix+nitpN6VD/QJuYchs+MDwSDYClbEOt+5BZh8B8Cy6WqLnDkro4eDvZsW1/c5T1eqiBwP
	hVf0LyyOj41g69Vp3rNgSM8Ur1u56nRcuU/+6QgCXS4bu9TdMSjBvVRgo7gJsP9wV0dLw3BWf0g
	G7QFsGKWO2dvENuc7KqSuOQkaIzjaS1xxAIvg5OgWyM+RF1Z5wqVwkuSYhxvSwvJ3evIuIGJnFZ
	eQXN1ZvYyuMxW1w3BZymQ44EsPO3uf6TRvNQ2BZjN7sA2HHJjdK6SBi2Jr1xXRCUdhd/5VCoshU
	/VzyFPJb21AdagFruh8W4UbmKBSAW2wuloditoA+iZctcoFcMK6SwH1uYFSqYohodmP41gjI4mr
	lmxF0ZC76MTtY/DHFeoSs9zyQcYlTS8Tt+bxmeubxnYL1OsX1c/8CS+osXyRzqxIlMrtr/UugYJ
	74qvWKwkfIYkgcjTS6N47tsZgTxqgPzDVraXqgvBJrve/Qx+iLBbluowteuMA0rkw==
X-Received: by 2002:a05:6820:f015:b0:71a:df0d:ea24 with SMTP id 006d021491bc7-71b394f3a89mr21773161eaf.51.1795819188569;
        Fri, 27 Nov 2026 14:39:48 -0800 (PST)
Received: from [172.17.0.2] ([172.169.236.187])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b38015c51sm16923378eaf.3.2026.11.27.14.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 14:39:48 -0800 (PST)
Message-ID: <6b0a06b4.a3ee09e6.ab514.6f1a@mx.google.com>
Date: Fri, 27 Nov 2026 14:39:48 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2560494260544077700=="
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
Subject: RE: Bluetooth: hci_sync: Disable PA before removing an advertising set
In-Reply-To: <20261127213437.121157-1-rolandschober1968@gmail.com>
References: <20261127213437.121157-1-rolandschober1968@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2560494260544077700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1224867/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.61 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      23.55 seconds
CheckAllWarning               PASS      27.15 seconds
CheckSparse                   PASS      29.01 seconds
BuildKernel32                 PASS      23.43 seconds
CheckKernelLLVM               PASS      24.62 seconds
TestRunnerSetup               PASS      555.22 seconds
TestRunner_l2cap-tester       PASS      15.19 seconds
TestRunner_iso-tester         PASS      11.34 seconds
TestRunner_bnep-tester        PASS      2.88 seconds
TestRunner_mgmt-tester        PASS      85.05 seconds
TestRunner_rfcomm-tester      PASS      4.10 seconds
TestRunner_sco-tester         PASS      5.17 seconds
TestRunner_ioctl-tester       PASS      4.27 seconds
TestRunner_mesh-tester        PASS      4.16 seconds
TestRunner_smp-tester         PASS      4.02 seconds
TestRunner_userchan-tester    PASS      2.95 seconds
TestRunner_6lowpan-tester     PASS      4.11 seconds
IncrementalBuild              PASS      23.19 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: hci_sync: Disable PA before removing an advertising set
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#141: 
[1] https://patchwork.kernel.org/project/bluetooth/patch/20261127085525.264299-8-rolandschober1968@gmail.com/

WARNING: Non-standard signature: Assisted-by:
#144: 
Assisted-by: Claude:claude-fable-5-2

ERROR: Unrecognized email address: 'Claude:claude-fable-5-2'
#144: 
Assisted-by: Claude:claude-fable-5-2

total: 1 errors, 2 warnings, 0 checks, 55 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15031776.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/1249

---
Regards,
Linux Bluetooth


--===============2560494260544077700==--
