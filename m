Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309681;
	b=GGMT8V28dy6CPqxPJuMkMRQPVjkdSdnGf+iSAs3MJG8iJMCdVYCVxXv3dEuTnIChm1Lg
	 yk/KcgXkMVy+z93AjTNgMHJSNhC9wQASZDdftrKMbn0q7cYWWjZYFX9eEH2hx0uUAWL7h
	 cgF59nfAfetO7nZnjSsrli/137QxSapCbWopPKxDMCKVdCyidUSYoFUbsKIucKWNLzr1s
	 yiufzeNgHwSORLYhetkrHWmiFKZ+FKxKgswCiANTHBOuILGEV5YuIwyE1r3Ytvf3RwYkc
	 YM157j6TleA+eb5zp9lzMGi6fg/kvd7N2zROkCt2VDw1hEl6M31rYeOG5vHLCkdSAFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309681;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=8HfhiGyj1nAwzw3KSfm9vKpLgP4q/v94i/y5hlr4FBs=;
	b=a6nN/c0HcT5sIES6GeCeh5BtBsMQFBGqsclzb+zY/IuXTizkAL9k8dX03lCbBg/LArBQ
	 vCcUoUwyWHcerQWMej9gpaC09YP881r8q+pezRtqvOvh9JrsRGiF6UpNstxn5LQmFqVoj
	 c7h/ZsnO+KXitL7Bn8oDmW2msmepaxRAFIXp/zVeCUu2066xAOmw9+1E8TNn57Zj53lqW
	 K+td9bFGaU2ISDh/mN6uNi4VRRyGzInB/IN1bjhTwpbtBRLnV8K+KU9bNk6k0BVOy6eF/
	 h5+HVyKdwVaIrHS6cwI5h+tcFPb0sa0HYxqc9CoV80wamJ7CZ73DgEWxOnedLvU5VGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hLtjAP39;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C466606A31C
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 11:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C466606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hLtjAP39
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc751eddf25so942142a12.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 03:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794309681; x=1794914481; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8HfhiGyj1nAwzw3KSfm9vKpLgP4q/v94i/y5hlr4FBs=;
        b=hLtjAP39e7AElQPW1KlO3lRtzdhaB+yPSAtRkLtZn0mO0drkkpCpk+SdumVGZAVD3a
         uZcV3RwpOXm1x+6spnX7X3jGb5tNy03a51857OYcYZDX/bGDi1frcL8P508fvcZK8Kt/
         1/Bn5Zpk9L1UJ9n/s2SrhmcBdXngTLoRWU+bbJbKul8jTtfxIgFIJBPfVCme9Z2o9a/0
         8YotfbnvviIxxY3nHYGdBtOnrHkmLgaAMid+kcqsDnoNp9Bj8k6Ninc3ra9esnxH3ze0
         OaD+bmEqXoIwl1qtwjrpWAyhoLoFfqYigIYBKanjLauVzzuDQ52vTMWpSzY4ThvQndTg
         lBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794309681; x=1794914481;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8HfhiGyj1nAwzw3KSfm9vKpLgP4q/v94i/y5hlr4FBs=;
        b=QUhYu8AWVxCYVqkZdS0HB8LWioic7qmH1BkTCE8XVeFLZXdrbGMlqQXe7BdpkxeRSd
         dz8TWUjAvpbjrRFItpHrecZdT9lBofJiqR+JDEFt8MJawOP53+JZvbxnLCnqTUMhxdg4
         bgXvOVEF5D3GD563u8pEpnzkhOdopJsDhMW+iE128dDDLHW7z9mUBAmTPTla9NxHu4t5
         303SFRcYkhSm9gcdDuY8eruxlX3fhZHKvJt61CAKOGFwIWwuYwiXdlejiD5u6WhkCLKD
         2DUY4L8ZgwPnc/8+G29OOpbaw0ZV0YgHbsiRnIt0PehiKoLQDLq/2Hv79wgT3mwRVr5+
         rFIQ==
X-Gm-Message-State: APuU4Z/Ao8hvhDKBLS1b0p9QnG+cRl60PZ6+/Kutq0pqjiZ5xjeSCvVl
	miU4ef3Sx63C8JdtYRELVASK84CXlMQ6McvjvpERwzT7duoj0b4jWY8kN5aeTQ==
X-Gm-Gg: AYBFou1mypQ58onXvG392sBv1qSnuhatykqfMRP7yAOZk3Uwq0geuOe60RxSeLoJgXP
	bQhdY8idA0uQQXwWts91+donRwtQp5reaPezlpZdzWBiBQfOynZGAwpTDUvwAfyU/dm3HpWlQGX
	Q4eAx6WeR35I8ZFUrL+wIjRcF0jzxYgo5EaDloklF7TEDxnKeTa3ryrtDv49R5A3RBsOQw4HHy+
	JYI1GNpabLF2ScQf6rjjQdCkl2g0F1m6fvTIwvGKu6hPmll1wpawGjaKgqtvYpT+VM08tzaOaxc
	HGeBdDtjkz4CClW3bBx3RCcs0Btl82zGZ5GmCW7xoxNXVyavCpoIWAENtvSwmLFlLevi05uo4DY
	UjprGYo802n7OmhpvPU+hswT3vLuUyzJyg1UoHfJQTmrAxltz77GrXQRLZeFJhgrrkt84fVKEwn
	PA0XJm38B0OS+Wqn2hZpUAste8bqogmnEXkTxCmarQETMjtwUX+nR5Ig738U0mNAn+OdUEtfZNu
	sx7tT0N5Ey8wZLYp3nLZ49oV7UviC0GhsypewTGi6pQD4RKIgvL4yylJZly+yw=
X-Received: by 2002:a17:90a:d450:b0:3ab:36c4:b502 with SMTP id 98e67ed59e1d1-3b166cdd823mr2601251a91.30.1794309680723;
        Tue, 10 Nov 2026 03:21:20 -0800 (PST)
Received: from [172.17.0.2] ([20.83.204.186])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d699b93sm558467a12.14.2026.11.10.03.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:21:20 -0800 (PST)
Message-ID: <6af2fe30.95e3f73a.2f341e.982b@mx.google.com>
Date: Tue, 10 Nov 2026 03:21:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6814461322467042050=="
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
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: Bluetooth: hci_qca: Reopen the UART after enabling QCA2066
In-Reply-To: <20261110092929.234617-2-shuai.zhang@oss.qualcomm.com>
References: <20261110092929.234617-2-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6814461322467042050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1207050/

---Test result---

Test Summary:
CheckPatch                    PASS      1.64 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.44 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      38.72 seconds
CheckAllWarning               PASS      35.45 seconds
CheckSparse                   PASS      37.63 seconds
BuildKernel32                 PASS      31.26 seconds
CheckKernelLLVM               PASS      35.23 seconds
TestRunnerSetup               PASS      749.31 seconds
IncrementalBuild              PASS      32.44 seconds



https://github.com/bluez/bluetooth-next/pull/1103

---
Regards,
Linux Bluetooth


--===============6814461322467042050==--
