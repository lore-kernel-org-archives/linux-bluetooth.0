Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE35532AAD6
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 May 2026 10:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778235375; cv=none; b=KmjB/H1aO7zyKm7uRN1RuiPJF1Ov3beGYDQbePak+Jc1i0PacOKr+TPcfZE16qXGr4nLdJEW7M7fODNm1kg2BAQmEQLWDe9oX/TEiFsR0Sh4h01DoJkqTawwhmELop5mFNHvfCp8MwhR+kG6gck92y2PI8093rOdxpdou7GcfU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778235375; c=relaxed/simple;
	bh=tR6gPq/KWGu5/FLIxSrQAF06G8RpN6XnPuoyPBN/gpo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EfeJV5bBaKTfxERqypNyi3wvYGgGg1qALCihvnmtS2HE08GU0nfhbuZoIVgZ1Qn2tgKRMFJvsCkxZZ9K38HvKp4R0FgEJjDIcasXC16po+ue5u8c4Vhv9vA+SrvFHFYeTL6dywCT5rI7ygAHCeF2Lip3Zw5Hb7AuPQJYs6uI4mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyBxOEA7; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyBxOEA7"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2f0ad52830cso2764512eec.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 May 2026 03:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778235373; x=1778840173; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RhYrD/qUlnmFbz6WLzAXwub0GqnME4rTJoiXfzFciys=;
        b=HyBxOEA7ph0qcCHQqwDjF3A2GL6JuIl5ramWuT9AJMbtpRv+iZd/+SnquswQiQQzmZ
         DezjnGfRBlstan7IrmNtfoWWS1uWJ/124/2t6MutXdfpZTxHiJKVh1gtqEtEzDnSjv2d
         ovOSERHx512ywtdF762AfmRg2rV4wLEYw/oor4vvsDaulDkZiPPTW4fuMd8+zeeTxH5T
         kn+r+Q2doqulMfEiwv9e4fZVhq48FZEsZMhrZhFZTdzBxJKSg6yzZtyv4GjvF4qk8oZf
         1YYu3Sm4fbDi4E1AthERodiI8+y53KdnN4QdhlbuQLbmuNs7TWbk6oWIqPxnH3JRzqRj
         ZNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778235373; x=1778840173;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhYrD/qUlnmFbz6WLzAXwub0GqnME4rTJoiXfzFciys=;
        b=MddmKvtb1ScRW2YWn7At7EF7hDcjncEMf0rg5xPlTNwq6CXW1EjEU8D2WaSCaV0wAB
         bFmNdW0cQ88X5cHqvY2+5OauGioTRLInTJdXlhw5b+Bs/QF1AP/sV9UFegp4cHNHgp2E
         QvhrVPGDmg9M9/VTCftiLkfq8CwpS910IiTEh9o9ePzOyxzCZBgIp7wuls9Qywu6iUwu
         +RTF8fuhgdc68NuYPLDuGtSCYk2ZGEFyblXE0eQQpUInMi5icUNnD2iHD+3H/Giwzmwd
         3U8RwKnn0glzMsG1zc4gGtzMZA8s4c9OI8Eaj+BtQXtYUawq/eflMbNYBi1//8b23XsW
         4xKQ==
X-Gm-Message-State: AOJu0YzTJ/QaJ1iMxdJfz5ipQPnh8seltsxyh1LOaf4ayXybIJ4SucSg
	7ct84kK+EckxEr/2P0pjHlD/EuH6nNTnzwbBEoIE1Dr1B3ruG6unCcOMGTeBRQ==
X-Gm-Gg: Acq92OHAY5lLi9bR+L/dwdsPcRs65uWW+zMzqD19hbDAcrRv4pNdaXkmqTCmUdqP35d
	Ks15vu07JAcEJUwn19vsgyHsIotRJvEJRGolqC4kbzEj3tO28JzrXVd2QxxiVjFP2tgM21Qa5m5
	4LrUBVB0+UH24GGFZOp9z/W5x92r0LGeXMj2dVlswQJH6C+5IGbTRm211pvXcxs4IVgAsZK414M
	Tbzr/R4J9pgMdQdb5p/HK0gF0u4hkRLdgXRDe8InVwrS0n6vHnK33CQYA5kIS5J++m3Qd3Fd4S2
	dIC9QU4Rg/US23CORSa+8dS83DIAGIN22vvJQRox0D0Kjcr8xwUALcFlM4u+T/zTAXrGg7bXgQf
	9eQiiestkda8mZHu6UHNHwNEMVVGXtZG7b7MQRUv8lcgIrFOoAxNMal1/qDPmPgzvo9dGYgofY8
	p0ZJp04bXHqTRXe2rq42ADyN8FLUC9XuU=
X-Received: by 2002:a05:7300:434b:b0:2ea:b975:3db1 with SMTP id 5a478bee46e88-2f54ad77112mr6009479eec.23.1778235372364;
        Fri, 08 May 2026 03:16:12 -0700 (PDT)
Received: from [172.17.0.2] ([57.151.136.184])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8884752ccsm1484127eec.17.2026.05.08.03.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 03:16:11 -0700 (PDT)
Message-ID: <69fdb7eb.050a0220.22ece4.c2f2@mx.google.com>
Date: Fri, 08 May 2026 03:16:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2461048002471212337=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nihaal@cse.iitm.ac.in
Subject: RE: Bluetooth: virtio_bt: fix potential memory leak in virtbt_probe()
In-Reply-To: <20260508084158.68765-1-nihaal@cse.iitm.ac.in>
References: <20260508084158.68765-1-nihaal@cse.iitm.ac.in>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2461048002471212337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1091511

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      26.45 seconds
CheckAllWarning               PASS      29.08 seconds
CheckSparse                   PASS      27.49 seconds
BuildKernel32                 PASS      25.44 seconds
TestRunnerSetup               PASS      572.35 seconds
IncrementalBuild              PASS      24.73 seconds



https://github.com/bluez/bluetooth-next/pull/156

---
Regards,
Linux Bluetooth


--===============2461048002471212337==--
