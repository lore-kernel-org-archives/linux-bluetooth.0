Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795753316;
	b=HTrzusihf255hzjkCd3RBhXoZ5k4M4TrkEC75kXUdljh+8a1I7lzpYTJ0RMl7AAS6ouN
	 V0sm1OdLIeyZWCsvz8+BlCqjtunJvqq3lH6QNjMEa19Wwa2c3rAf/3NHyLeRp2IhwELv1
	 bH86iP6/qdeCWA6pBU/f0bfEf3UxUmO2TKhIPZRp6QQOTExtppFXHBAJgIUMJ0BCTOdZ1
	 K4aEV7HdAbHHrf32OVAMAGGAqG4WJS/G+YzlvjR+8Um+CRhwGDT2fNXs0Tc0Snc2+d38w
	 0r0MRupyuMfD6kLGUwhh+VfLCvx6UGFfh79ma61F4Rvq9TvxcmW7GXlgsB/CDfFTgdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795753316;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=nNk6YWXJLp+rfsGRa7hfnW4w4ihLnOp87csXuldPl5I=;
	b=bqOC6u6CnMkUcMpOGNppStMfpZrlTSet3BATfBzkAgC17TNSnAHJpnnm8ED0M2y374bq
	 HjHZOcgIkvbo2QRPKu5prjHNlm423goQw8V/+ObDgV/ZSozFDtrX8BZwY5jcD+o8cslDa
	 W684TzXnqq6PPwHqE9NdZvxO7oOzMKIqEpU2/SjB++mL83QBLESrZym9NWs1imABm19Z5
	 5VM9gjqFu8MyFNZWgYONbUYdREadk70E1c29iYcsNx1ZSaDH5tlX/4SlO29qL4+pT+p/J
	 rkZ7aHMWKCxE+2CJ2CtQPpS+h/buVHPo4TRjMvkfSprRHG724XfPIBkNiHDnOGEw9Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vSfXGbYX;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF06E606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 04:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF06E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vSfXGbYX
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-843cf077f10so10206450a34.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 20:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795753315; x=1796358115; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nNk6YWXJLp+rfsGRa7hfnW4w4ihLnOp87csXuldPl5I=;
        b=vSfXGbYX5GW4Us1hrumi44bZ/HTAqUln051cHu1lllAo3RT0NlBPTa4DgxmR48hYPq
         ++2qSNkVHFP4U75ceFeeUN1XwaNkW1Cbo4B5uA/QOslY02vzjH3aXvErJZxmxNhVYmFa
         NMrpF/XbXgvax1NZmzGUcsj3RtYNxOKxzhFVsrkJpxBWEGltXqe1O5uOrmIF6Goxc+8F
         aRlvH540KmiyLZFuWJzlDS4L644l79l3hUQ9GRqgAed3/x8VMIX45MANhJfmz/F3+V63
         mymjxiYk/DVqVFhk2FoULTry+aXuZLnU+pMq/wsDKqELfzR8hgpqNccniefaQoEhHamG
         tDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795753315; x=1796358115;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nNk6YWXJLp+rfsGRa7hfnW4w4ihLnOp87csXuldPl5I=;
        b=gNrpPJaDIEQY4UZC9E6KuI8qFHc2jiVFT2/9Q5fazj0r/KlTgzjUXKXBQuNZbX9KgY
         AhDMhSrrcjuY9qmuT76Cd1GnL3zBOUF+4K61A6KtOuD+0dPidnl2asR2ZiB5NwtNrrYV
         4J6AqDAmSdzrPv+RBDZAT8/WNau7K78kuwdzYwwF1L/dw3OVSUK9VzN32LKalrCuf1Ap
         VhoALo4/Z0w3/IOQVXeV/vhqMEghoStX+8v9r+69pSaBcmdleWD7uc3m3DF2c7Kef6FI
         hP4Ylvm050PjI2lYt2GAxHw2ldsVApX3jGQzO+9i3zg3ogHrC7OMbiukiaAmVKN+sRmG
         RMPw==
X-Gm-Message-State: APuU4Z/haJN4gLyjpf9DiZE1GzuGvq5+JOKZ7HUUEMJbdLxWpZNQVurW
	ZMDl3L+V891r0Gsb9WO03mJMPd3Zpoqnvj/1g0bg6XmdInaWyT9UM6DMPQamYfpc
X-Gm-Gg: AZFdTZfwP0aXFPtwh7Tc5lehYDtzcHxX7srDu62reuiuFsZcyqO7LuSzQHf5PBlXJhF
	GdWoLIt+Xaa6D2UoWKEMQHg20xVLypWOpVQHMhqRM0T7Z8aEaAK0pD+x2Esfx95wrkHH9W+H4BW
	FD5a0Bg2emEzyzjVm/5jQ2u92ZbvhhdA5NPMXZjvv+Mock7sEWIDmruNzwZHzm31iPF8iuenr+o
	ZzqX5gN3qQQce7KiF6bO9tmYzXvxZGAUhJJ9DTXETIiJ24razjyTDsYdtDLz30a+JI2CY/RqvaY
	FPJqHE78x+Vq8Lz+zVr4HdnMe1jJkAPAoj/MSWLOhnehkp4VhVV1kDKGfOqR0oaAX2ZrHhRVsM1
	b9DDVjW7PwYQBVvHo/OjP8vsilwGqqucsiYuivLcOnGC1u901Hc0ooaa+Gt8qp3L+FCE9sRJIdG
	xlOWK03lCqt3+ZROex1TzDeHpJiiIKyx+qbOkQm13SDVZ81NLI/Y6x4P6YiC4/4b6lnw2C6AGVZ
	9jFsxTxY8xWhOzYHvJh6hqLuL7zckk9Pr7bp1qZuPBWs8q+moemBmnVseDXMpCiww==
X-Received: by 2002:a05:6830:7086:10b0:863:3bec:2cdc with SMTP id 46e09a7af769-8633bec2fe0mr10893572a34.27.1795753314765;
        Thu, 26 Nov 2026 20:21:54 -0800 (PST)
Received: from [172.17.0.2] ([135.119.111.208])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8631690f53dsm15284397a34.19.2026.11.26.20.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 20:21:54 -0800 (PST)
Message-ID: <6b090562.ed0b4dca.1747f.6458@mx.google.com>
Date: Thu, 26 Nov 2026 20:21:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6160354261821070946=="
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
To: linux-bluetooth@vger.kernel.org, shindeswapnil028@gmail.com
Subject: RE: Bluetooth: btusb: Disable autosuspend and add shutdown reset for RTL8723DE
In-Reply-To: <20261127004644.8363-1-shindeswapnil028@gmail.com>
References: <20261127004644.8363-1-shindeswapnil028@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6160354261821070946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1223814/

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      17.81 seconds
CheckAllWarning               PASS      20.89 seconds
CheckSparse                   PASS      22.44 seconds
BuildKernel32                 PASS      18.29 seconds
CheckKernelLLVM               PASS      18.68 seconds
TestRunnerSetup               PASS      412.57 seconds
IncrementalBuild              PASS      17.66 seconds



https://github.com/bluez/bluetooth-next/pull/1237

---
Regards,
Linux Bluetooth


--===============6160354261821070946==--
