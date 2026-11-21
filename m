Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795233528;
	b=4vteTaBsEx0xyvE8300c8plAFawyz9C0RW1GSz/oiC+r5gq1SJNymBi9HS26pcij51pR
	 nhYNi9qCfNqxIIdy/b8LVzakjlLKWVSkOLRVLV1yEuADEGZh7SL7DtTyMyKMlIJOlMBpJ
	 9udv+zO+NKjboSu7Mm2feUE+JeqHn9lOn21GWqgrjwWm1k89sWO3v1gZEQcmYTluYU0xA
	 VD7VqRJlXnuTbFOPFL37UxXf76deBwULHcTRS8CYd8Mj7Ack6rOA83SxBDEUI1qYoeaku
	 jJnh98W32mayVefRs/KrWDY2OCjOFEO0mBJtuvFidBitb0RwgGIytS/0+qRFPUM7teA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795233528;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=5tZMctJrioVxoxV0xlJdIk51Jl8WEmpxbWX5cL9xYzM=;
	b=EJbamOIpjVaPeKb5y8AwsSK8Q6XTVQi2yJwlsy5JO3cfkkso5pqF7SBS4qEASTRrx2S5
	 mma40hNXuUdF/X5HJsbheFwiR/Qlak6iTNvosOijXo08m1q9Ty0wVpYD/tmzHeO7ogwFl
	 6GbLFQhsKJWJCmZ7pbVS86IxuaHaN9+xaQ7HT+VzBNznhtsCOjILUWmnrMtRWKoPNCrT1
	 2s1PznUwOJJaxBbOGIKbPWCAShH8AAVkVFJ+ybBGSiVykBJAT7l5GuhpZvNMxc4AWYqPJ
	 NST9QydGOe0i9P0uhVtmxIRV4IkQ7TP5FATiwBiREim5sASFaEdkjGDP2GPHFzpgvhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MTXznjDH;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFE0606A320
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 03:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AFE0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MTXznjDH
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-385c497bf94so2900396eec.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 19:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795233520; x=1795838320; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5tZMctJrioVxoxV0xlJdIk51Jl8WEmpxbWX5cL9xYzM=;
        b=MTXznjDHv6vW3ILYK3eEZn143re04SqzhyLwsNsA3hRzRdRgPP60Bf1YhFUCr1zZe2
         egTTZ7JRwiKszhsWFmd31f0j/vRpyTdusfu+R/vkdNLsUKedzO33NKZdFdPNd3RfulfU
         ktYyfYJOFGc5JDz6z3quffldYkMd8eh+ijxehe5waXtDsSk+/3h5vlNI3IMnMtuNbnJ3
         nkyiiolrceuR7o+37iDD8gwC3yCS5NU5BdKHDFe68qJKevIBUGdrn1lsoUZvN+WbC3wL
         opdYWUyGXOPgJYgicATVLA414OtHjMN2/fCHh0lgJCQoFvdZ9FN4Ps1CBUCRTx2iqYnu
         jmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795233520; x=1795838320;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5tZMctJrioVxoxV0xlJdIk51Jl8WEmpxbWX5cL9xYzM=;
        b=dlT/zjWOj5P77kqSKViZB5xesMI4TRg/SDZ+xfb22um8JP4KlFwNQE+xyuDlAeymnN
         gpvFK8YTJin19pLYQkrOckQ0s4GIyGw4PqEV93urdqEkJSQk39Ek3tUJZxtoMk5q+1cj
         S7jEOokhj5iWnNUPZpIb3XZVEpkulV/RREAklsbp698wccj1/Ij/hBI0Ytvn7tIjVsmU
         4HTwMbc6brUIO8OnFXbUKOWhhOZ6VqBkoe/6Bigmkk8MMu9fOlLTJYVEXao3u7TXE7OL
         LWSi8YTKjuTI1qgNHRT2QFzdILVJuORIw4qQY/dHYN2HWUHBM4/GVoBM3GL8PV/RAiDt
         +6kQ==
X-Gm-Message-State: APuU4Z+ECkJJUFhgQ++p6MN4LE2NpHlj3MwSa+mBuQvxI36EJ/DX9sh+
	kCGksuE5p73NhVlfAzT1nhTGIC2y3KGpaXsGZMUqlKTBky8r/fXzcHCldfgDww==
X-Gm-Gg: AZFdTZf+J9E5ykYQ/kXVN6SV03JHkEe8jDlirXEaEjmsiGOkdzS4VfjM+D/DwOj5vLc
	eDhfTUXgigIXG6i8Jul3Fw9hoDu8CysW242pEwTjivi8+Dnx1vKRkhZxGFguCvY8KZiL+jzww6v
	wxQLaua9c1y+PyJA70G+Fm+MSvALvgYMynRBTE+08ZzFX1tWVfb1JxBtirJqQ5NiZub7vQjAP70
	2E+2SKTbjNyYw70dFOXI6x1MzqcPcHXZICQCkTxI8DNme3LcjfAx8pGkyv9uWp1CLEYs/y7mvVC
	SZTuPueDy5eUhfi5QgD9zqkisAYcQQ6D6Edmo9n+HZHy9KN+SKqk+Qa4yXvDulVVcshzee+78Bb
	/t0p8U/k0PN7FsG0K0RRzlFBf+FMjZW/Qit1ubveYO/spJJSyZp8lnv8c19woMee6Uxc0LH9fGd
	zffiSXOg68Fox540bv9FDyZLuYvGROaFTwngh1nhIS03KdqYQSmQp9VD6dN4xifV5SqvYsYU+v7
	Iqc1XulApJpPDNyrlFtth+A1e3zliO44adfy3lep8Z7z2zmqnrSYRShhM3zCr+XdYX1fyR4J3FX
	JhVgQgBT
X-Received: by 2002:a05:7300:ce93:b0:379:7251:9a1b with SMTP id 5a478bee46e88-3856f0421femr5183592eec.21.1795233520458;
        Fri, 20 Nov 2026 19:58:40 -0800 (PST)
Received: from [172.17.0.2] ([13.71.231.145])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd4efesm13049842eec.12.2026.11.20.19.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 19:58:39 -0800 (PST)
Message-ID: <6b0116ef.7bf231e0.18dcf9.ad47@mx.google.com>
Date: Fri, 20 Nov 2026 19:58:39 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3473327550593922118=="
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
Subject: RE: monitor: Fix reads beyond advertising data
In-Reply-To: <20261120222624.150321-2-rolandschober1968@gmail.com>
References: <20261120222624.150321-2-rolandschober1968@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3473327550593922118==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1217829/

---Test result---

Test Summary:
CheckPatch                    PASS      1.97 seconds
GitLint                       PASS      1.37 seconds
BuildEll                      PASS      21.72 seconds
BluezMake                     PASS      320.55 seconds
MakeCheck                     PASS      0.94 seconds
MakeDistcheck                 PASS      149.82 seconds
CheckValgrind                 PASS      160.43 seconds
CheckSmatch                   WARNING   322.69 seconds
bluezmakeextell               PASS      102.01 seconds
TestFunctional                PASS      1252.88 seconds
IncrementalBuild              PASS      364.47 seconds
ScanBuild                     PASS      1179.33 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2292:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4220:52: warning: array of flexible structuresmonitor/bt.h:4208:40: warning: array of flexible structuresmonitor/packet.c:2292:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4220:52: warning: array of flexible structuresmonitor/bt.h:4208:40: warning: array of flexible structuresmonitor/packet.c:2292:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4220:52: warning: array of flexible structuresmonitor/bt.h:4208:40: warning: array of flexible structuresmonitor/packet.c:2292:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4220:52: warning: array of flexible structuresmonitor/bt.h:4208:40: warning: array of flexible structuresmonitor/packet.c:2292:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4220:52: warning: array of flexible structuresmonitor/bt.h:4208:40: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2861

---
Regards,
Linux Bluetooth


--===============3473327550593922118==--
