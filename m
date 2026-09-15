Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C2C4BA1F4
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487656; cv=none; b=Vx8516sPnYC5hT5d/NqKnfCY/jKt/5d35yWG5cPCcEcNedQRZyGZsDs6ppJ6AjTYMV+G7Pjl7LvJ1hbrumA9eijrVbASVwNostjoi39PdIo3FBA8H1ZgOFkTDTHP6CWzY2KkaE5GZXYSDgrmDRJp/MyNpZvcvmSFwsMT4oJJzAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487656; c=relaxed/simple;
	bh=mJnhaZcB5kMb3f5fzObUYGBa4/RGju3f+hxU/7+kYsU=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=osBxwW8+IWKKcjsUbw2GGSLipInS+d955FytLGxQdSyyFD1v2oPIjbcZKmHydxIkfUg70ttI/UKOBuQYGAv3fXczMc7gCcjYG28dehWzL0I5RVBxNWkpERYZkfO5MpuQ/rW3IqVLHuFBQbsCW2xFJhxaGsJtA0NiyeqN4W+f3zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LP4UWICh; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LP4UWICh"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4cacd3409so395051a12.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 08:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789487653; x=1790092453; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mJnhaZcB5kMb3f5fzObUYGBa4/RGju3f+hxU/7+kYsU=;
        b=LP4UWIChu3Aw58AeZLJcsAWjCJWB5juhvCA7uZeXjAqx8cT5uoHB3LDLrEYohL3pHK
         jOJdkStYie7Vm7U4r38s30BaSAeSqFJEGFwYc+WNrZ4papZ3yge9eyI2U2EdkjTkKKo3
         VmSXPqiVUEnXauA0EkdawUbvNNygFk6m/TLQvdo4xSHdTDfMYTWr/hgBJxYcgnnjRUHW
         JoGnXSqm4SRLXzfaAQBqaWRtGW0OyQAvG26cP6DNKhMrdN15Wn1ZqFvCsgSYLWIC3gG4
         IpOdq5+rvsQQ+R572kzT7guNyYGO9iDmrqOKl64c8JReAoa9DtJEkOXMltClyqirnMUM
         NuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789487653; x=1790092453;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mJnhaZcB5kMb3f5fzObUYGBa4/RGju3f+hxU/7+kYsU=;
        b=zsnOS8jak39YAV1x5iM3LHAcjAm+yMeNWUFnXoWegmFUYxIuMV8BuJX/KoDo7j4hSO
         ghlmiOKhql52Pfr4IQ/QW1S4zmhRg4tICZXpItSDX1jD3Avcp/9KFf1UEe3A/+D//3TF
         ZYCZ7y8Bxovygc2xKYCEeRfkDBogxWiC8BY5IUD/5MOVnyeDAONLVRLGH+HwRcsJPcxP
         wWjZGlvgfCeOpUdoWSqzzKNhBzYxpy0Fg6nko5hGoLK94vQZzN0o8prrc04EQBSyU/t/
         0ZCBVi/C65X2pyLKxx1pVvE5pCDHru9eLM3a76nll3mmVrzriZrGKEIiDJr3oicDzNf7
         XJXA==
X-Forwarded-Encrypted: i=1; AKwUvBzL3K9e7Z+vaKWtilKzY5l7S46RjCUrtq/LQcBsNlPQtg+12dItKIbmcCq3sV/uv0ugIBDB72ejChxi/rLgfcY=@vger.kernel.org
X-Gm-Message-State: AFuF++lTOGv+9HCJAuFowfx9Yb94xUBXWydmD7kNTM+4xDNzbwEG64pz
	7kYu1HMDrkeN/3LZKNF7eAZlKmj1XV7NwbQmRBvzDpoXUD1df0XVAWac
X-Gm-Gg: AYBFou2hTodr0cIY5gvavT/2GfqUdVyOE5diTgYkSHg0mXXEnPlgCt8QtOWGXtX1m2c
	Cd7F4IuG5Ot2+Fe1Ph8MjWvpEWZjM6DAdJf0EF9GXlaeAxIA+gTQKmimNMeEO6rwwklIfqbjQb+
	ZgwX2kkvC8riv/Bz5msBw75Dhq8SGwcHp97IFBd4nXcHhfsVFyAVZtNV+b6FeQ6E+7LPeLHAyQ8
	f9l2fPOgcBHlJbpIqTYiulTPEs1vHkwg5iUi+Y94E7XADDvzqsRg2BNUQ488XSw1jbc7BHhyAMi
	SHT+i41XrhBO/3eH6Yucllrg7tzX3LexuwY8A4cYjfZbcjktY26S4dMLvnx73DtF+109MWTSA4W
	7cOQbmtJwGTHnw2oNtggGo9dZTRGT40N5Yj3Zoi1DeTFRbfEe5Sp8KYnntlJgjTMmgp8iKKFnzj
	l3J36EEuKsk/T/W3FF9MzscMxnt9gf4nkhtc3dSG55YnGVqIhJ/eeHAjZWUnkftg9SKxlW/uJ7U
	37++T4/LCdNGPcDBw955FrO2g==
X-Received: by 2002:a17:90b:4a8f:b0:39d:f254:4173 with SMTP id 98e67ed59e1d1-39e110dc85cmr2590678a91.21.1789487653470;
        Tue, 15 Sep 2026 08:54:13 -0700 (PDT)
Received: from localhost ([13.93.150.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfdaccc0fsm6012249a91.15.2026.09.15.08.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 08:54:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Sep 2026 15:54:11 +0000
Message-Id: <DLG0FI0V6C4U.8PPNEKEU8LBU@gmail.com>
To: "Randy Dunlap" <rdunlap@infradead.org>, "David Ahern"
 <dsahern@kernel.org>, "Ido Schimmel" <idosch@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>
Cc: "Simon Horman" <horms@kernel.org>, <netdev@vger.kernel.org>, "Arun Ajith
 S" <aajith@arista.com>, "Roopa Prabhu" <roopa@nvidia.com>, "Jaehee Park"
 <jhpark1013@gmail.com>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan"
 <skhan@linuxfoundation.org>, "Shuah Khan" <shuah@kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Alexander Aring" <alex.aring@gmail.com>,
 <linux-wpan@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH net-next v2 0/2] ipv6: update NUD_FAILED neighbors from
 NA messages
From: "Lawrence Lee" <lfqlee314@gmail.com>
X-Mailer: aerc 0.17.0
References: <cover.1789448374.git.lfqlee314@gmail.com>
 <4169629e-74c1-4a21-a187-6c65d70502fa@infradead.org>
In-Reply-To: <4169629e-74c1-4a21-a187-6c65d70502fa@infradead.org>

On Tue Sep 15, 2026 at 5:26 AM UTC, Randy Dunlap wrote:
>
>
> On 9/14/26 10:01 PM, Lawrence Lee wrote:
> > Testing:
> > - x86_64 current-config and allyesconfig builds with W=3D1
>
> What does current-config mean?
>
Accidentally forgot to reply-all when responding to Randy before,=20
copying my original reply here:

That's referring to my local .config build options. It's essentially=20
just the defconfig target but with VETH and Overlay FS enabled. Sorry=20
for the confusion.

