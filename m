Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A84A48F836
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 15:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791300558; cv=none; b=jO8M47an017jdwqKA9G6jPIjQ53135K3we6Vq/JTSn6Nt7QLNKR5vEA/0sy4XT3afHUhGu+PRKnMgg7EhhoLuPCb61D9q33MiaSpqzdaZXsZAWlE6zYyW69Hwf1ppMLeaF14YWE8vBEkxcrYqFQiU4ZXYP6XAPXnw2T3yWgtZh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791300558; c=relaxed/simple;
	bh=pQJrnuy6MGMa74o2P+2xazsKRjMqco/yFjEBZXrDYZg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PVJZpuGvGX3bKsXPIwWMZu69lJVxW6jN63TqV/I889mu6SCQRAKJdXXLIxLCjDWOhQ1bXpE2yTHAh2FG8I+5UQOO6v7b12FyolpMWSzqaqv2K/L9WaZFdPIQ6SKr31wYvA1rcN6g71LjapQ8UCViFr7kevYMN05CLss2X4/7awY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPfJnArY; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPfJnArY"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93e6fb35f91so53855485a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2026 08:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791300555; x=1791905355; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2hQHPQPBvxJbb10LIzlswdI/9ahVUhdMV4LW4/rhrWA=;
        b=MPfJnArY2LoEZWjf6F5L7RUSWJXevC/i8tAsH6uChZcW/vQlJL9bbxnyWyiYW0invR
         flxnnkqjtUmmdTuw6kN0IBPC4BYx//rutUTxdxFlBY5I6T7Z+11nIQeEf9VbXUSBLQFK
         RqNWxdrOovpBch44KLIkIr3PVcZbvHrkaMalcHXPJmnEV1QO4Sjw6AwjDevJ8DKPazel
         xVtfsV0B0n6ckcV2cMCXlNfqJltBoV+EN2whL+H1x3aMo2U51mUyt8NgIHXNPHacxHYd
         OgWukn+Rb4ujmUnUbQnhG3QVTXRZZA0Nq+1cVKq9xY1UsuAopH3YJe4CCs/JcFLq188u
         JTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791300555; x=1791905355;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2hQHPQPBvxJbb10LIzlswdI/9ahVUhdMV4LW4/rhrWA=;
        b=Sfv2ebfAAgLkc+V69H8UtWWWtcaNoy2HHHxyszNyqE6V7oqZia7LXIpqeM4Dbe1a+E
         EIUAqp2K8wxgn4EGDkfooAQufjuv2LMKkCn62wtPHu3rpRVNkqVbZ83v0ukgHGgcqKwy
         RuP0p9xNYzGcBljV6K1I+5Dr+aJ3ccnpFkFInLJSQY9XCzTfxHtqkNfNp+eiNEjBMW8x
         +4DXGUOxEJ7rwQEOCXGbjNX9xFk83yXuUH00RgZa0mwF6He5dyaMb4GHsEvhhEjWbYTJ
         24Falh7VOMYZZFitRR2+fFnul583B7U8omRuKlSykGy1ZmxLSdvL/trncodAvqZHBjRZ
         z+Ww==
X-Gm-Message-State: AFuF++mVsGmElcPtxjUXOj1qkBNQDOl/cxgFNvkaGl2K5Aolx92h3pRA
	PUQvlO4kgtyll84yS8MX8lEfRMnsGRIe/U9mwTk6mH7vOxneuj/wM5CgukNuRU6r
X-Gm-Gg: AYBFou3J9q7SiBBtq/Sos9b7q0PiLgfbR2FbptlL5gLZicpZthAnt2U0mbgrdUWrNXj
	5nclnZnBZSWHn62NwwEXqo2VwGCGoQZ/wXtepjwgu/PQHmn9eGTD+ahUzGGa+qWWrGH1FORnOFn
	AJwtjyRD0KD2TkbnFAd1c3da8REKHN1gUbtfAi/Q/S7cWNGNQouB6MuAqRrsMhZ+zTl4ijvlp5g
	LeV7huJd4EmRa/KizI/Qa3U8WLxKMSPFwlRtgxjiaGAQ2A+0XnuYqmrsYRmvK3RRQr+tJ8R5C85
	nTlu5G5im6RUHzwna3WbGsw8Imt94wX8vAToG062ciVd2bZ7TED1vNdYj9FzCt6iF9Ed1XBW5pg
	C/GgvqIM/wWLD6h7kWYqgx72vZLkqFmHTKU81iCF1iuEiCZ7ZNOYWg88j9t8ONXoYxoseBiZuJr
	j/LlHOQo8edBzfz89Vnu0Uq17JOsAjlGbTQp5wn1WKW3uttQofe4aeKnps9hxy5q0fRxWCLg6w0
	wMhobyd
X-Received: by 2002:a05:620a:c51:b0:93e:980a:2ff5 with SMTP id af79cd13be357-93e980a317dmr22436185a.73.1791300555434;
        Tue, 06 Oct 2026 08:29:15 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.125.245])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca297e84sm1152785485a.37.2026.10.06.08.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 08:29:15 -0700 (PDT)
Message-ID: <6ac513cb.37e4897e.12bc9f.9516@mx.google.com>
Date: Tue, 06 Oct 2026 08:29:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7921153228343088891=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: ISO: Hold the listener during disconnect notification
In-Reply-To: <pm-bluetooth-objects-candidate-0210-v3-42a02e0ef5261660c606@gmail.com>
References: <pm-bluetooth-objects-candidate-0210-v3-42a02e0ef5261660c606@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7921153228343088891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1180371/

---Test result---

Test Summary:
CheckPatch                    PASS      0.84 seconds
VerifyFixes                   PASS      5.08 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      0.36 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      31.47 seconds
CheckAllWarning               PASS      35.00 seconds
CheckSparse                   PASS      37.91 seconds
BuildKernel32                 PASS      30.76 seconds
CheckKernelLLVM               PASS      36.86 seconds
TestRunnerSetup               PASS      816.68 seconds
TestRunner_iso-tester         PASS      11.56 seconds
IncrementalBuild              PASS      29.99 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: ISO: Hold the listener during disconnect notification

39: B2 Line has trailing whitespace: "    "
40: B2 Line has trailing whitespace: "        CPU: 2 UID: 0 PID: 50 Comm: kworker/2:1 Not tainted "
41: B2 Line has trailing whitespace: "    7.2.0-rc6-pmb-bt-functional-v1+ #1 PREEMPT(lazy) "
42: B2 Line has trailing whitespace: "        Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps "
89: B2 Line has trailing whitespace: "    "
106: B2 Line has trailing whitespace: "    "
129: B2 Line has trailing whitespace: "    "
131: B2 Line has trailing whitespace: "                                                                which "
132: B2 Line has trailing whitespace: "                                belongs to the cache kmalloc-2k of size "
135: B2 Line has trailing whitespace: "                                                                freed "
136: B2 Line has trailing whitespace: "                                2048-byte region [ffff888105ca2000, "
138: B2 Line has trailing whitespace: "    "
140: B2 Line has trailing whitespace: "        page: refcount:0 mapcount:0 mapping:0000000000000000 "
145: B2 Line has trailing whitespace: "        raw: 0200000000000240 ffff888100042f00 ffffea00042cd010 "
147: B2 Line has trailing whitespace: "        raw: ffff888105ca5000 0000000000080005 00000000f5000000 "
149: B2 Line has trailing whitespace: "        head: 0200000000000240 ffff888100042f00 ffffea00042cd010 "
151: B2 Line has trailing whitespace: "        head: ffff888105ca5000 0000000000080005 00000000f5000000 "
153: B2 Line has trailing whitespace: "        head: 0200000000000003 fffffffffffffe01 00000000ffffffff "
155: B2 Line has trailing whitespace: "        head: ffff888105ca1000 0000000000000000 00000000ffffffff "
158: B2 Line has trailing whitespace: "    "


https://github.com/bluez/bluetooth-next/pull/872

---
Regards,
Linux Bluetooth


--===============7921153228343088891==--
