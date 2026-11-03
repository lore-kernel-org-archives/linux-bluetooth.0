Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695529;
	b=p/4N0m/Fy8IgSQsR/+bMz61++tyaNNNN0Gjv4FtO3V5qhH2V2OMg/I+S7OUxu6CiyJS0
	 CThOPg99AKQ3SQkCy1xLN2f6jeqa4XUGGEGdmGhQ0qQEHpdfBfFf0G7Xv35iXirBsnaDv
	 kc7WP3/ptzpvi3w6vSQtQ5BoWwwCezuU1oPxBt8dh26GVj97PQ0IGiFPN4456uYMRGRbn
	 9Z6rzWXd5CyzpzIK00WFEMMLJ3DvGk76TQ9c4ENTT4k+VQqQoPRr2XGW4a+43a9yxpwyU
	 LurUKAsI9iLK7NFhJNzAqFyp7HRTVwPg1xghuvIQJlizYK3utnmEaBy/h6WNy4fsXSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695529;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=oxFA7QChJSgLFcA6ZFwcDJNvCPbY+KDe6Ri05Q67Ty8=;
	b=EA9NObwZg9nbbyqTYDSBBoef10exfI/4L8cbsIChZp00wQYNXJdQGyr49HojSAcemqxt
	 Q2Z04xaXKY2oR8vEA/i3OSKvcYIZpYkTxs0AwnQ61LSjdiKTQm3dn8ANaOY8bt4TOozQk
	 J+8tJTr2gWY4LnE2Rz+63LBaQQqPOZE+R1InxciJ5lYb85E66oBHlH3+ppGO/spVIkeRL
	 ra4HyXN8BDgHBtHlZjAgfbHGBMxE2Hu0X+vwSniTEoRtG+Xm9kCGTU8S+8qv3GiF8uKxd
	 irp+a3uaNw5++gnOaZDzT/04/v4WgJxPQZs8+NSxwkkcYFRUB7wtEOlny2xMAywFBhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sJMdFbvB;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D05606A326
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 08:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7D05606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sJMdFbvB
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-15ea896ddc8so6664608c88.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 00:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793695528; x=1794300328; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oxFA7QChJSgLFcA6ZFwcDJNvCPbY+KDe6Ri05Q67Ty8=;
        b=sJMdFbvBGG0Ny1nfM8wG57UnsPogPw4RKRDqqsWJwtHL0GZJFqI7iWhZz6meUS8Kzf
         buZOZM0xk1lA/QzX9S50X+w2Ec7gFlTuVR1xWOEtEptaBv0mbsVyNULvxWuEwrxwGVSZ
         Zp1Mn0ecfQ+3ZXTXbdSA4DJRbGB/PFSlh/0sVqde9ywTgrgjxR8TyT6xTa7q5SldhtDs
         Lx5pzcStyn9U/jJox0KIct0eMb8q5+eMKg8ECiE10bUDsVHfIYngyMa9HO0gS/ajxcL8
         wUDxvgZJzi8Ak5QfI/eLJ7SCM69xHbI5lj9GR+sy+TF10ZUI54o9GY7TF7ePLnCYhd4O
         kUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793695528; x=1794300328;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oxFA7QChJSgLFcA6ZFwcDJNvCPbY+KDe6Ri05Q67Ty8=;
        b=16e52WxJFHIBngCu2xKNAkWRyi2AT4VuhwCePJ6vF6TU9FeFnZLkJirerT4Crha7D6
         UNFxZPDS4tWkt3YQV9n8nCjxEaKRtYdeRaos8HMbx5YAl6XBhWCRcD1RQlSTJgxkEvY2
         sCzCRLjajQEVUA9rrvGUpNZbeRWTGeZIaa1T3BwnbuI9wNX9riw/YuLi6fdGlv3I0OQi
         L6xmDesJRRNgWVo/eU3XSdNcEUcdxUaflrJ/OoZ+SkluDODvgkC3LFeBxbowYEIsZ0oY
         J03wvcCIDkG3BkEF1+ojf4zbYlhDDYbguaCQ4FCtSSd0SQynkJX2lqkpFii8HAsKav6s
         smnw==
X-Gm-Message-State: APuU4Z9zSXKWP2L8bSuWnrAwF6ZdFrBTdGd0H3iMve86hvNJW8b6uygg
	EE6KtsIZOE5p0UBT10i0Ue8wMI22LHo/cROpKpS/eklmLhXaM41MFnH14TEDHQ==
X-Gm-Gg: AYBFou2bM/7Guvqk9XMkq2S2so/04fNKh+gG1LaABWLlx9AAyC6WfXeNOWF2Rog35ok
	TIeN+x5L+UEL1tdwXHYCvTTM8qOEfVsWf91D2HNcp24ADOOJZG24a76C8itTwwWZxNX8jjZKdW9
	rIWQfeA1YqGOpv4RXCtR/7CSYceZE8zrZm6LXwdzeYhansqPmkyxgARPtCPuY4+F8TaYAfhD7Qn
	kJ2L3DL8tu9lJ63HN59b+0KPwBjMvGqXwWenxPLUonW914Zp09TUdvkcZ64sEsABVuHet27YDhe
	8sNDLwfo8/QC2P/m8ld11xop8SphvPyqu/m2tNv6Mtljbw2gmNoOo5YQOTHjLNSGTmUK+w+/W/D
	HKijqEmDkxm5ETXj5BAYs/gfsYECe748w/qTWlggBgYGcYAfUeQE1xcDIFCKX2XWHLfexD6ABjX
	T6Cx0+TLc8KPBKAFij9Cg5yhtMmaHx72LgYDsCZkzMAfFDpwMXbwXtvHh0w8uflV1G5jCI4tF3r
	/iHkOizLv22LlDFXZTOTuP0MC9Rxeq/VkOq2j79MZetlRF5BKuGJlMmxw4cs+U=
X-Received: by 2002:a05:7022:1509:b0:195:9228:50a0 with SMTP id a92af1059eb24-1ac5d3ba9f2mr21533913c88.42.1793695528000;
        Tue, 03 Nov 2026 00:45:28 -0800 (PST)
Received: from [172.17.0.2] ([20.169.101.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b23f20d36csm4819671c88.11.2026.11.03.00.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 00:45:27 -0800 (PST)
Message-ID: <6ae99f27.f51f0d36.2e39f7.5642@mx.google.com>
Date: Tue, 03 Nov 2026 00:45:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6293264317009729514=="
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
To: linux-bluetooth@vger.kernel.org, aluvala.sai.teja@intel.com
Subject: RE: Bluetooth: btintel_pcie: debug INI rework and fatal error injection
In-Reply-To: <20261103062832.3083624-2-aluvala.sai.teja@intel.com>
References: <20261103062832.3083624-2-aluvala.sai.teja@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6293264317009729514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1199839/

---Test result---

Test Summary:
CheckPatch                    PASS      2.59 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      1.32 seconds
SubjectPrefix                 PASS      0.17 seconds
BuildKernel                   PASS      23.27 seconds
CheckAllWarning               PASS      26.47 seconds
CheckSparse                   PASS      28.95 seconds
BuildKernel32                 PASS      23.41 seconds
CheckKernelLLVM               PASS      25.62 seconds
TestRunnerSetup               PASS      550.26 seconds
IncrementalBuild              PASS      26.66 seconds



https://github.com/bluez/bluetooth-next/pull/1049

---
Regards,
Linux Bluetooth


--===============6293264317009729514==--
