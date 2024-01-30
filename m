Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50C314E2C2
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jan 2024 17:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706636915; cv=none; b=Z51giTni8aB6h5D8dxEnkEhnENiZFkfgGZO/UIw2D0EwObQI8nV80v5AIYqwFI3O+2uVX/XYp3CJh+T2ukXvtZ9dDcOTKEbX4lKC6SDbOQGRqWhfu8NCMHKyv5fY0zivJCnBbVswPsp2VvzcUrb/T5cS+Z54AEOnUa9ZqoVPY1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706636915; c=relaxed/simple;
	bh=1kVcsO2u/g8iWzGK6PRwMkltTTA34ijGWDGjOImXE/c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IdtKFqjLkamyRhxH1z4CE7LgfLZiYJMzqqCi2jbaLPXo4eDPtidWxvPcdGJfLvbfUamkJqiZQGqmL1EEjBuUExL0OO6DkHpafIm5dCVa29coqOQJEgmEDDLjot4pOTOmD074BK/v0sszNuZzJ6MzXUt44B9DcCmgavNxpQcUN0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cuqLnjjK; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuqLnjjK"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-783cd288ac5so2866785a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jan 2024 09:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706636911; x=1707241711; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O3qap9PyyPjvQ7wulLU//nAyPamDHCc/OMSk8OvQa4U=;
        b=cuqLnjjKGyBKxWfaVMNF+5sb8glpFWHJVVRN6UJhnEBVoZjvCyr9WnMfFEPCGECaUo
         HzUVGv6SG1RuI3YokwWWJXKhFsj1cdJYWJqk9DDgdxc8t6UUqpF7xmQREi0fYqQsZl0s
         o0nHVIyGY6nfTTFEkVnjpO/eJr1mH+2rp2dRXHXSeVJQkjbB8acpLQyvsd3PNRpPeOfD
         I/2JCbEsbhmDJchxdBMXUfhvXSayN+yRHfNzH+9eVmLx/fD3tAlubSdKYEQVNqUTXCnM
         DLS/NvMQ7SoauAijFVjq07lz1pf3eIHEWc90yJ+UE7kg/Yac1gB8/YFj5/K0MThASx+Q
         LgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706636911; x=1707241711;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O3qap9PyyPjvQ7wulLU//nAyPamDHCc/OMSk8OvQa4U=;
        b=RNjnm6cmnDsaxBD3x5w+y7HuytVwGvy5Luw/umQ1OWxin0md2IqZy4H5DkCCpCfJJ0
         hpbt3THVAerzKIuM5HgpwSnb4Eg02fOU0vmsBJ8RB7FcO025dpGKoI7TrVHmk/g0nYWY
         /Fjl8KikHTKbAo/Oj0n7QKhmIvlINWEDQdvZwsrNdh7vUNf19dqg3zYlIUqzDNezACzL
         DFDg6F29kSmBRacRdOWS7yMZk+jdZWDVsb3tS6BkzQr0WrAGqEWFgBrp451ohQwqndpU
         WGG0sOHSk26Wlsj0zlBaTSFuKQb05b9nOPdKtoJmD7hOnfgWWd3bhhiu5VgElbK0FgKR
         1KRw==
X-Gm-Message-State: AOJu0YxozPTUxMMDB0tNbnX5epVhlnginfPOqcOhkKjpCC6NapRPomKP
	lPTC+dv4oehKNPq46uoS1HVDYK0VTPowAalxLiW0TIi4UImKnU26vY6skrxD
X-Google-Smtp-Source: AGHT+IEjs2CNqwDG5qX3hebg9blzP2vO3ZaCBTNVkSQhKNMkxugj9eBUxHScMKeZCz89jXuq2ICmEw==
X-Received: by 2002:a05:620a:4508:b0:783:4bfe:b0e6 with SMTP id t8-20020a05620a450800b007834bfeb0e6mr2219950qkp.38.1706636911327;
        Tue, 30 Jan 2024 09:48:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUDQx5GQCbun0Kqs6FCmSSr4YAm3sGldxcRb73V9mUFCf8J/69+H43OBAxHeuJzBTO0NOMSUmWNkqo1+Dk4YmVjROF2BEn1BA==
Received: from [172.17.0.2] ([172.183.161.195])
        by smtp.gmail.com with ESMTPSA id de16-20020a05620a371000b00784b5fc8f1dsm428842qkb.34.2024.01.30.09.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 09:48:31 -0800 (PST)
Message-ID: <65b9366f.050a0220.f49f3.2992@mx.google.com>
Date: Tue, 30 Jan 2024 09:48:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4710252090390878649=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Update bcast ep register and config props
In-Reply-To: <20240130154412.3157-2-iulia.tanasescu@nxp.com>
References: <20240130154412.3157-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4710252090390878649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=821345

---Test result---

Test Summary:
CheckPatch                    PASS      2.26 seconds
GitLint                       PASS      1.11 seconds
BuildEll                      PASS      24.40 seconds
BluezMake                     PASS      770.42 seconds
MakeCheck                     PASS      12.05 seconds
MakeDistcheck                 PASS      168.67 seconds
CheckValgrind                 PASS      232.61 seconds
CheckSmatch                   PASS      336.84 seconds
bluezmakeextell               PASS      109.69 seconds
IncrementalBuild              PASS      2852.15 seconds
ScanBuild                     PASS      981.67 seconds



---
Regards,
Linux Bluetooth


--===============4710252090390878649==--
