Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795553146;
	b=YKBWXSsGjjgxytn3tBf52yxwE3DqJG+lZ9FBaL1YSSEwEcxj8lKbPEvVMF1vHv7XNnfw
	 Ey5MzQHz9MI3vMcSL38NyRBbtga6EgT2VqrmQAT+9M+xtuToDlnm5u9nvei/AFQDf7qVr
	 Zt/65TgJo8FCib1yriHRGWO1r2acSkIYUlO7mglFkIF/y0kPeGRdPjI9Cn6wFEVDZms03
	 meGiod5b//JIJo2mS5tbt5bOdShRSTCZYf5rKPO+YnWslwThUscPCzgBu+KFVEK3aMcEn
	 2NQ93wn0snGBpfUY6HCUHMiXW4tvRYhZ3qwujuhWJtXmRtJA2HI9HLYSxkysQj5jVCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795553146;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=c3BnvSI4Wfefb8ReQHj8UBZ+JNiTLhxsXQpCKo2GfMI=;
	b=2a8SIOBEu3lE3JdPgZ/E4vpOZcTCyVfC5bSD/j7WLETwaYukP1a3AjQEuAWJhgNZDDna
	 oLi87+SZ9pQSvb1kM8Aetv5Zoql8oGOTssvyYxxbyy+itd2OgZdhz0h13AccQtYIex9t/
	 oxOX1Zs2drj4y2woGMyXDKAB3iAg8uYPWTca97v7KFHiMi9fUZr+pB1GsMOhy07xw3uS6
	 RMwlfeYKm87RjW9bC5g4Qb7KMNcg0mKc0Y7Ft0e63aotj0fSolOGg4cJwptOYmpNJyfYt
	 z726HhtPWX1Yg+T3f/pPJQpEQUHJqHqqBKNyG7AuPs02KjoEaU7Fo7NSImFoq8SO7SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tfOmON4Z;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E5F606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 20:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48E5F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tfOmON4Z
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91e7af9a67fso30399256d6.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 12:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795553145; x=1796157945; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=c3BnvSI4Wfefb8ReQHj8UBZ+JNiTLhxsXQpCKo2GfMI=;
        b=tfOmON4ZUbLHhO9csCoNezaljAvvLDBOvLWP/ze+Aiob6VL0nn6J68b4H72FmGJ+Nu
         IWF6icyqSPfhWrgbp0rietC2+v1V3GJrZD0+0jvRHO/5Se7P8X6u79Y0Od8gB5rD9JTW
         Ryr99vfv9T13ciT6awD6Sbzc2WfLfBXTJyCx6C5fQbPJdQUhOFrQ4xEujH9ybaPbkxrL
         7+ySrHGEO3BI+MUa3l4r23Mk/V8+bXrosY5XCxVwNiyaWpXSGDmW+E0iC5fpcn09T3PL
         4C2d6yUpm9B4b+S/ZyjSoEsNF6koDfQLqfYk9xOUC2pOA9szrxmtncEJWPxa1fvh4F+t
         tRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795553145; x=1796157945;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=c3BnvSI4Wfefb8ReQHj8UBZ+JNiTLhxsXQpCKo2GfMI=;
        b=ppZU/yx5RgNOVF3/jw7MlY2YgEANuEjbxiS+sgkA4IqHAxwy0Lrffu0tDNyR9MBR8T
         A38PLFS2iFBvB1s8J4DN+15schkM5kiU/70t2Slsh6959lJ29DzJRjXafCzKrA/nc9e3
         6SNCeGc9JOfATWcfSsa4XGOkLpwjC7Ebt5jPwk1su0VU9uZuciLpcVV/9Ii7Uv9bOnok
         kHondS2ozi6+qtIm0QVoMf1FMa2fmoqRz2ieS6TGEGQpxDyo8bv48XXQPBVHYhziTnf7
         e3P+0dPn5rzpDJVQZnN/bJ6aouItOqLMacrIKKr5VKqr4jU39UTuSWUB6QKtZbmgArR+
         ogcA==
X-Gm-Message-State: APuU4Z9HgY5IwZJatI7sTHu+LIXdqLMuE48TdBLOturkWwfTN3AUHKoP
	ZiuqlU+tsPj5fH5IK6IUc/uFCuavN1y14XFu25rpns+Z3jqN8pfq+E3A0hbwVQ==
X-Gm-Gg: AZFdTZcmZoRLLN2A0/UAxtuew3A2jSkTxeMUs08qZUz3cAIj9HvFW6QNjLaIp2nj8Jf
	QcjU+25EO3OiQpvs5X02kzHXFOD4qLWcf0pqgpSxa1XARCb5izkvW3AiaahOr0lhB54kEf0lIgQ
	nexO3JazSywjiGh7Dazwrqprfwx41K51w/QL3SVOEDnzfqGCopiyAjwNWY7CIM04AKy+STMq1+j
	ydVxz7L00bUqpM+bXXdNhAzagUQPoxUj/9gB/xuFgfFDoiUOK8BZSKYPBgNRUjxFl+D0Wlev78t
	wLliHD7ioPqiUgFnuMZFcmcbO/gcyuzqLtRgRofLd9wjFT+sTRCwQ6IeE3BiYIrtPpfpj6cIdeI
	iHukwi7nxN0qH/NxRai4xW7y/ccWTEQgQ5+5J2z+fZBXhPj6EQ8Zr79dcArGL/zNK2FPGVrKIcG
	g2fVzvuMeKFCmmMUmAhrjOlUNcPQ7uW0L/aQRS9U9kxkXYjsv2i664d8atbPkS0vHhGinU4inT/
	iaL2yQLPxhl8ypzrFuF+GaT+sDA2aYQ0xQzLPZ+O02Vodg8XHQvJ6NQ+IvcHbN88bQhtuggFiNv
	rHZHfLjuS+vUM04W1nuJZWc/pUmpVog=
X-Received: by 2002:a05:6214:4e81:b0:921:27c2:3f93 with SMTP id 6a1803df08f44-92134aeff23mr250340196d6.35.1795553145120;
        Tue, 24 Nov 2026 12:45:45 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-41-210-135.compute-1.amazonaws.com. [3.41.210.135])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921787fd72asm4431586d6.12.2026.11.24.12.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 12:45:44 -0800 (PST)
Message-ID: <6b05f778.140a8b06.51aa7.e475@mx.google.com>
Date: Tue, 24 Nov 2026 12:45:44 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5289090905233408769=="
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
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: monitor: Add an OBEX protocol decoder to btmon
In-Reply-To: <20261124145653.336273-2-frederic.danis@collabora.com>
References: <20261124145653.336273-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5289090905233408769==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1220979/

---Test result---

Test Summary:
CheckPatch                    PASS      3.44 seconds
GitLint                       PASS      1.64 seconds
BuildEll                      PASS      13.50 seconds
BluezMake                     PASS      204.97 seconds
MakeCheck                     PASS      12.53 seconds
MakeDistcheck                 PASS      103.94 seconds
CheckValgrind                 PASS      250.68 seconds
CheckSmatch                   WARNING   185.22 seconds
bluezmakeextell               PASS      65.59 seconds
TestFunctional                PASS      917.26 seconds
IncrementalBuild              PASS      250.70 seconds
ScanBuild                     PASS      691.04 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2293:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4220:52: warning: array of flexible structuresmonitor/bt.h:4208:40: warning: array of flexible structuresmonitor/packet.c:2293:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4220:52: warning: array of flexible structuresmonitor/bt.h:4208:40: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2908

---
Regards,
Linux Bluetooth


--===============5289090905233408769==--
