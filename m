Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795081289;
	b=0fyM5QGL/h/8HpEaisb6jIpXff/AzqAjyNPrN/y6lJmWejpVReONJrr7Xt3feSpM5dhd
	 8HUCPxs+4CV2SChTO3/r+f3pNOPvS7BmMS9O1MetDEgmwR5vh51/mUCIPZAAkD1N0W0Ju
	 626wg/LqQlUA9Wq7JwFOKZNEvj/DWPas8uNUJXx2N+lLIBk1vXcqahEXC4/HpR40GManA
	 YqNMobZiKW3jJtvjZsC4hFIUIT6FUjRTP6acQUax8G13fX5mBcHsO6+ezIJcXmTcF15+Q
	 J2TPcnjx8bS6NxTYWfb96uMWHw0TldLNI/Ove8q+EaFfsfMekt0gZ4Hvl+CUbcqDePw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081289;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=XRRx5zpBR06u9hYDde87o7ghTRzrgVu2HyMNbQvFnjo=;
	b=lic+K5ATQd5JbCcqTJPwrgFPqjxz0qjAZfYuf04T9VJc9o+ddSZaqoW2/Eq4yo5YI4yo
	 hJol5pJ6u2gEJNbcKz/LKpDHlJ43VNDQzVdX7WGMcmvKR3iHsw4FQqUyZJsFvzaQzNwBQ
	 KhOWBDrtEvWSo65kEy9eOGTCNNfCGayzJlY9ab8jY2ov8e1rnUGpgVoblcBf2/RokHIN/
	 4v3CcCdptLRoUp4zKVr6DbD2kTbsDETamw3eYqTKe6I5iEvysgn+NtDzEtvty4+oN4zYJ
	 2en1owCwnEpq5YHNWynbNREq186cJSdsIg///vC1G/USpaRHQp8+fWhdP0JE9rXQJQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X1iBZXpa;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF7B606A320
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 09:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FF7B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X1iBZXpa
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e9995ce866so15671555ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 01:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795081288; x=1795686088; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XRRx5zpBR06u9hYDde87o7ghTRzrgVu2HyMNbQvFnjo=;
        b=X1iBZXpaH7aXbAMeIo8XC640o07xaxTmRtVOT6wLMpPdB+MYbH5zJQ1Aui/ZCPE/Wf
         pX2osNFqlCKnbcQpPoUxlHEJI6w2HbQtnwJJpM3BPTPYeZll0VutmJG/WW/8YwJjdNfH
         bfsY7F8yvYfCxv9uLSXbKaGOTaa44eueC7IQmfUPGbUC2kJqWOsKm1LkdKjveqYIVaZb
         Y7U/zxiqqvFqkqo7W2VL4s8kpnfV73/bFLNYY8+XL80ouRa1ikDIMIlOmvVchPqPE3dP
         B3ATtPfxI1wdcBnhfXfnMklzCp0Aqk4xTo62PnwofzwwT/8DicY57SPadPWQi/MVJvD6
         TUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795081288; x=1795686088;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XRRx5zpBR06u9hYDde87o7ghTRzrgVu2HyMNbQvFnjo=;
        b=F8JXzaJ9yg9SzkK09xIjO4NcADhyxjTm0rciLqGoqbtIfv+z6oMitIihf4wJBUdtMg
         INWithYN5k3n5jS+WhxemptZ3PfT5ALQ/Tqhrup80pFwes5VP/ls4sFEFjE1AJpXG0sO
         PUwYxMQPNzf5JiesWLKG8sxoq2kyVupkojP4F+dmHr+0HPw68aZbr4BYkbeEFfjY9fVO
         QseXF2WbacGxY9GkUvbYfPGke+nQTf+0ZvLBCbOJV6qfqxuU78FQa40hnIG5QHrZ4hJh
         edP6Q34fHjUWb5raO1+OguRmRJKMpYMS9SsGtsjfhFV+O7LEVFLZEsFmt6JDO+No9Tgz
         1M/A==
X-Gm-Message-State: APuU4Z/6Az2I4w3pfvbrfjSL3uhYMclG9vN7HjT1Lx1iiXUy4ydnRfJ7
	eG0vtOBjpiikLzLHcsK1Zl1vVs/nuxLayA1zrNhcC/OPsxVItaZR4IGuqfS/1Q==
X-Gm-Gg: AZFdTZc/FkMs1wo1dbLUeqgUEMqHWPaSYSPLMBNBqhZUSx4eZdtQJKiZRwDfiforXyv
	wjOOimINbMKxJQwQNmu2epW4atuVhil+aQNSEKxrsCpvziJu9ghI/+yU3stF0QyzZeKaCYepLQ5
	GAnjZfmliOdSqH7EKimsKI3tf4cyuDCm4wypmtUlK4ytHYRvTiDD0coMkuOogmELT3WtZRw4HvO
	dF7ea8GVkDl7puQCRLqjajl6OLgTgU2Sogv0DXwrSKq0ohvSQzOkncFMFkMYrjN8uRyN8fUlQTd
	2FsNLMoy2ePZhrZDVDVkf6wbsEMWjL8QcdOBPkj0x20aL+v5b8i/u3iNO2i5FqlV4iR1bBpjVAs
	GL2pF5kBU7XXmexiewH4CSTsQXqGWQuOtXuy9rrOyWn3mD3xLnDsCVMYc3IAjcMrgmf1cAYjz13
	HjZrGXkMxtoH5GdJHhi95ophY9wtN52+8CeW8JBbwITHWZWn1bUj6taqD/oL68pGbHb0U0ZjEdX
	YHreNvfTesWC91LiMhJ6KB8viPC4x+w/dx6xmSD+3xLQuWpedvUrZ5ICWX0C5/p
X-Received: by 2002:a17:903:41c5:b0:2ed:f9c:3e5b with SMTP id d9443c01a7336-2eff756ec1fmr52120105ad.52.1795081287958;
        Thu, 19 Nov 2026 01:41:27 -0800 (PST)
Received: from [172.17.0.2] ([48.200.106.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f036ddfd11sm2075805ad.32.2026.11.19.01.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 01:41:27 -0800 (PST)
Message-ID: <6afec447.5af1dd36.7a5c2.de05@mx.google.com>
Date: Thu, 19 Nov 2026 01:41:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3138933585885713116=="
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
Subject: RE: monitor: Decode Periodic Advertising with Responses
In-Reply-To: <20261119071332.32424-2-rolandschober1968@gmail.com>
References: <20261119071332.32424-2-rolandschober1968@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3138933585885713116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1215777/

---Test result---

Test Summary:
CheckPatch                    PASS      2.03 seconds
GitLint                       PASS      1.21 seconds
BuildEll                      PASS      16.65 seconds
BluezMake                     PASS      243.12 seconds
MakeCheck                     PASS      0.81 seconds
MakeDistcheck                 PASS      123.15 seconds
CheckValgrind                 PASS      122.29 seconds
CheckSmatch                   WARNING   238.85 seconds
bluezmakeextell               PASS      77.90 seconds
TestFunctional                PASS      1028.42 seconds
IncrementalBuild              PASS      347.80 seconds
ScanBuild                     PASS      868.30 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/bt.h:4530:47: warning: array of flexible structuresmonitor/packet.c:2292:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4530:47: warning: array of flexible structuresmonitor/packet.c:2292:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4530:47: warning: array of flexible structuresmonitor/packet.c:2292:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4530:47: warning: array of flexible structuresmonitor/packet.c:2292:26: warning: Variable length array is used.monitor/bt.h:4304:52: warning: array of flexible structuresmonitor/bt.h:4292:40: warning: array of flexible structuresmonitor/bt.h:3048:52: warning: array of flexible structuresmonitor/packet.c: note: in included file:monitor/bt.h:4530:47: warning: array of flexible structuresmonitor/packet.c:2292:26: warning: Variable length array is used.monitor/bt.h:4304:52: warning: array of flexible structuresmonitor/bt.h:4292:40: warning: array of flexible structuresmonitor/bt.h:3048:52: warning: array of flexible structuresmonitor/packet.c: note: in included file:monitor/bt.h:4530:47: warning: array of flexible structuresmonitor/packet.c:2292:26: warning: Variable length array is used.


https://github.com/bluez/bluez/pull/2848

---
Regards,
Linux Bluetooth


--===============3138933585885713116==--
