Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794020384;
	b=GgGSwLAxON00YSJ8XRBGwClspCixlyErKS+WCUoBHedXfXohoHxqhNhLOpIGugbdcYz+
	 hVOaZgufdzZicyQbhhLWQWlGy2RrzDUAhNXe4tsZT8S5AqZ6ZztMzsU2oLE20jxAbIa+c
	 DjdttoNrnL6agCD4mqU6GHEX5QOKg7PB+zcOLHT4jH75OUljboLzIfdJZBvVx1D5KuFf2
	 zZ4eb6SwmeKsJF0+rOt9ux/RoQyK5Yzcsztdop+Ae+JH4RoafLX9zOP9rjTzOyUcEn4Hg
	 S2Wt1FUf7RNKG7c0JaiuD9rnPwXZo5au/guPAnSVmndBlgm7Q5qnmz+5uCKJSEq0beQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794020384;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=iXj7k3t8pHpAvzy2fGJpLkqUTQU3zU6mecDsj+G7KsY=;
	b=t42lNZyzWpVrhosNAeuRczEbVk3lQ+N0ZOtHTnggKqqvFmI2NtGUvEBLkQiOmJcmu3iv
	 JkHy1NQSRP6Gqsvq/a9217ewzvZJq13TVze1BfDWt+yLyciQdkzYS8gsT8hmMieKbFEVD
	 fug6lreZUkQ/NGYnQkEPoKs7yyef7vTLNCrHCXNp4xYvY+OLH4ZBEX5KIeU+ZF1lsHmG5
	 mLZJvALOyrNFK66mG+BN/7Zr10UMTesUke7yXzqcZuuH5fDgabBGAtTgxRaPAN2e3BcS+
	 sQXTVwmVjVSBwiQ/6HnZ8ryDgSUF2RNq65FcTQ5C9Qrn3o94qGCJ1mEwhObxpnHR57A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MDsKFi9u;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBA0606A326
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Nov 2026 02:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCBA0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MDsKFi9u
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5351d76e1baso2655561cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 18:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794020383; x=1794625183; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iXj7k3t8pHpAvzy2fGJpLkqUTQU3zU6mecDsj+G7KsY=;
        b=MDsKFi9uA2WOLEiK2Fluyyp4RDHJbUEV5ZGYbBwbFhChlUvuHa4eNiktXJJKHa8ad3
         n4fm0OyLaGlKqdhe0syCxpJ4zpFx+kI00oGg0Ef448R8/xzeotgR9/i+CZ22ENKys460
         b7tmVqU0hCtZ82/NO1QHVnibuAOAyuwQqwg5O3HqoYIH/gWpAlNwm2QbbDFhwfy/zOPc
         vU4mSSm73rIO/27kjnSLKL9ElgWbgI8xIqyedVTAQ/34o4TwLHip0pcyRSHZfyaElnBm
         5vPe6YHvalpDt/mlpUTk4d+0wfxrfVYsk4InqWQi8Q4LZhWr+3Db1Pto/ethr8/Ih2iv
         DfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794020383; x=1794625183;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iXj7k3t8pHpAvzy2fGJpLkqUTQU3zU6mecDsj+G7KsY=;
        b=I25CkZ1Zd9tGxrEPyVtEHY5wkwuJybgg5P2JfEfwvnjltBKmMbKNjn+AaWt6ZJW+/+
         AmNhklaQ6dwEs9tpAamjMUhER47R/wUh+vixBtOuz0ZQDEiE+uLK9ImlwVHaia53nZT/
         9A1JnaJfY9vK3uYoXbFRxPpa9S9SQd23hoHXYAO6JGzvcHv3pdImODK8Rko9SzrtUBRd
         9ClHR1VVP/9hjzCE8tA1iKvfay81VH4y4v549yIg/OuTrkl2ecf6fwQWv55QtOWMykZX
         BRFKU8HG/j1bwITyBQUW4ntXw0AvfYynmehJLNAcdmNN458yvK4+6HrHe0Rt4CpaRvZJ
         /Xew==
X-Gm-Message-State: APuU4Z/XtPPBk/lC/d2X01NBnqDXo3H79x3MFVcHy3VtO/OJ30ZZWUHF
	nKIdNPdwS3rl1IaR58UhN+VVHTl03ndaA88hKWsciKy9nytmuKFEKYnupGa9/A==
X-Gm-Gg: AYBFou0ncSkmKUIspvxJN8LDu4/dpR4ZNNCxpjBcju/rfJu+38ztzoCBuxEShLRu4MU
	u3OXidAFA4Otzq3nDX10wBO7ZJLeTv2+IpVzU11CAtqB3p+0mA5Fwt7zbstWsKZT+rrv41P5eT9
	TXS1YiSLiLPPk7jqDzO3HWvObMeDDj+mxgl5AdCbtORWkxPVLFPxo4gLsJ0caCCZ0xyDkYhroyn
	fzWLuEZKDIRH+BtSI1W4/FuJCDrPzmXeGVC0H0i/GG6zFez7DgtqXohUYisI00jIH3P3+aOOi6X
	nj2w3A8FvzNPwEzAzQv02c6sH/Q48MRXWIS2PiHYdKM0Osq+sOrXM61m4dyPrpPYxAI1vKjwTJX
	XQ9wEVfUeUf3lONPhSJd1LPQzpYKO7q41DfhaA6J4aIwfS1lQZM1R6b1n0sCJ5cKX280gmM3yC5
	38YY8+fwm41rjrZuLhMMZH1hgzugZTIkX/85DlgRIOtm9OUW6z+diC8+3fRv2rKbORmSSNb1xdA
	WiFGMiOd4QqfnW4dTa9yUFb+/Zx6leMH47GExthITMS3qROixAruE4EtIKLoDw=
X-Received: by 2002:a05:622a:5818:b0:535:8559:3401 with SMTP id d75a77b69052e-54fa45754bfmr12785091cf.28.1794020382687;
        Fri, 06 Nov 2026 18:59:42 -0800 (PST)
Received: from [172.17.0.2] ([48.214.53.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e25d65a9csm35718911cf.11.2026.11.06.18.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 18:59:42 -0800 (PST)
Message-ID: <6aee941e.0ee05534.2cb743.6537@mx.google.com>
Date: Fri, 06 Nov 2026 18:59:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5766676653384145265=="
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
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [RFC,v3] asha: Notify connection interval changes
In-Reply-To: <20261106235122.719665-1-cochcoder@proton.me>
References: <20261106235122.719665-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5766676653384145265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1204623/

---Test result---

Test Summary:
CheckPatch                    PASS      1.23 seconds
GitLint                       PASS      0.35 seconds
BuildEll                      PASS      20.73 seconds
BluezMake                     PASS      313.38 seconds
MakeCheck                     PASS      14.75 seconds
MakeDistcheck                 PASS      148.35 seconds
CheckValgrind                 PASS      346.96 seconds
CheckSmatch                   PASS      303.05 seconds
bluezmakeextell               PASS      99.18 seconds
TestFunctional                PASS      1177.42 seconds
IncrementalBuild              PASS      306.77 seconds
ScanBuild                     PASS      1157.23 seconds



https://github.com/bluez/bluez/pull/2773

---
Regards,
Linux Bluetooth


--===============5766676653384145265==--
