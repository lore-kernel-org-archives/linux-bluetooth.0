Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3EA3B0ACD
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784141382; cv=none; b=CDXZe8T5y+cG4INESsUDaQ3ZR/e0s0knxXYdiXOcYnVKw1k9uoGr6W0wzyiw9gUWcfF1gJasd0UFbtjIgjaXmW8DwwD3H+1j4jkg1+kkbQL7MCofirLMlg+UosHhqFsbOuXxPyWCadhzQhfGoo4fNdM2u5Qp0Ikj+hC6/J5PAJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784141382; c=relaxed/simple;
	bh=t81E7jV5SufknKYuXA5R82fDBiH41DWOp+TBNiB3bFs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WSrLXbXCwa/jgtnF+bZerIH53vjq1Eg9d1VepUxKbRBK1CtGq/3CPueBcX2feUXq6zs92YgHkeQa4GB5+JNDsF0o24zbrB4nDvdeQnKR0N62p0mnY5J4Yzen+xWcNQIfJ7YsSFektOn4RpX8qCHvxgrwb7QKSbSiwP8P3X9X0Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mo/RKPKy; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mo/RKPKy"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84a2c90e383so736848b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 11:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784141378; x=1784746178; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uyqkHyeeprD/wmoDdeN0XD4aCbfqg0AVaJX0YdaC3AM=;
        b=Mo/RKPKytuuV6+b6nrD883XPctG2+T3JMga+AzRiXqkN0LM3Id79xfJImfvJlKxYsZ
         QkWw1dxd85Ci2hplHKZAjYI0WcUWltnt48hIcUh2R70jwJNRQ/27VxnIq4nXc+i/FGni
         bwrAg0gSb8RdIi7K6fNVfkAGBMvrPM+N/30wlyTTXGp7gqiHkRhfzZuJ50TnAC0TYDuN
         4nGJU/69u3FgtXJogfiMdePAzP9DzyAytF0Y/gAaETohXfL/4haAKN1ubNGL+RRfx41t
         t5itwft8HCgL8K+UehzZ6mqtjZAU70Gub4cA5XywFVBWfs25H7bXf34hKsav446fLB0h
         VLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784141378; x=1784746178;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uyqkHyeeprD/wmoDdeN0XD4aCbfqg0AVaJX0YdaC3AM=;
        b=rC7LZr/PMzkunonoJ0k0Hc5ez85JoE8EgKTINsQNuFWeJ92sVjR+/6OFQs1GOAcjku
         A1+7jAPIDzaiMs5CV/Oe5iY+HzfIyrj4FzBLwjZKEXuCj18si11gfYDobxpJ6lDRrTRp
         N6mcHKisz0cMdvZzI0FufZa01sBDyK4jkPmEigGWnwYqf8YUSMGLSvrjaUD20APvKXnt
         L4iZzj3fHYptwiaEakVK6rAcnSd9+wrCao238JQSyaj7ZWGq/8g7BfhbWEp/cJkZA8E1
         KTMRMMaTWGSslssrRjk4RGFz/igE4Nq5RCCPpJF4p4XKS9ShnC23Li2TqspqIGslorhl
         XAZA==
X-Gm-Message-State: AOJu0YxxWfHYJJwVuJgCvKusOLVbiMDXxf0zsX0bWdJkTPP5kg6yBRSf
	+d1++zeihOYrDLdg+D57gqQZa4d0KjYt5k/mibef1zjHfU1ULpijp7QrcXHMbg==
X-Gm-Gg: AfdE7claxPawmnoOigUupTFR2UJmGyDCX4aA+xq+t6A9rwbVums+0Xw5ylubGSmY1lF
	JtnIktQcAFPzj0lTsE0yblEutKz89KQmRLp3u0ulVWRC0KnX6clIlkoZoYkBXkZ7Q96eMRZDWys
	u1HzNP/58aF6Ow1wPEJcJKhYZeYYnyxVMdOZgxMfwnRcIZkVqwuCmM8WPTQkffE2FY4k3mnyba1
	xGgoh0sv5E+TpWq7EZNjxUlnM2Ob2orUXDrY1oLN2M6wgFoZafMbijxbhhnskMt2ddq4Px9FMVm
	2ZE5vUhynES7GOBop1VXB6y7wpHXlI1X54SVdKSgVDkijUADcdaqmnCDm5JC3AIvmyZupt3CDz2
	oIU/xmNGx33EbktSXCp/InnN3B6qiY1otMhkSdJwK2RFzYYr18mGq8hBmeYjXMvHPsK5fsZk0ko
	7Dw73ymC9wCVThuR9O90o=
X-Received: by 2002:a05:6a20:a10a:b0:3bf:990d:3fc7 with SMTP id adf61e73a8af0-3c384c92d29mr554018637.20.1784141378384;
        Wed, 15 Jul 2026 11:49:38 -0700 (PDT)
Received: from [172.17.0.2] ([20.189.179.85])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd4284a92sm2758793c88.4.2026.07.15.11.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 11:49:37 -0700 (PDT)
Message-ID: <6a57d641.1b0626d0.f09b5.d480@mx.google.com>
Date: Wed, 15 Jul 2026 11:49:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5446204796269229404=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] monitor: Fix build error
In-Reply-To: <20260715170747.1933443-1-luiz.dentz@gmail.com>
References: <20260715170747.1933443-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5446204796269229404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1128302

---Test result---

Test Summary:
CheckPatch                    PASS      0.29 seconds
GitLint                       PASS      0.22 seconds
BuildEll                      PASS      23.28 seconds
BluezMake                     PASS      559.43 seconds
MakeCheck                     PASS      6.01 seconds
MakeDistcheck                 PASS      158.55 seconds
CheckValgrind                 PASS      155.22 seconds
CheckSmatch                   WARNING   314.99 seconds
bluezmakeextell               PASS      104.04 seconds
IncrementalBuild              PASS      544.50 seconds
ScanBuild                     PASS      975.25 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2002:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3924:52: warning: array of flexible structuresmonitor/bt.h:3912:40: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2317

---
Regards,
Linux Bluetooth


--===============5446204796269229404==--
