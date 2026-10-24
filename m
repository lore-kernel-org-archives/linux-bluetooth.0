Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792851368;
	b=pACiEPbOZxSkRaz4gIp5ZrZ6t6CjkM+WBMClJF3B1DCVyqzMdM8vg8gjuzc2qDcuNJk1
	 GDizN7EcEgEyiYEiwP76PVgBifU7I8nWtkpENQGXtEWmXdgWjQSZ8PINKRApX6edrczBP
	 2fDqXrGzRDhazjlB2djdTDxFf7qVSZw9esBVxUslY4rF7Z+H4Ypq/OQh1rlWpXqRoyjm5
	 nom15MJWgPzf5FEoxH0j9360clyoj3mwNBSs/yC9+Nk2Ana8jKR5n1pIKRN+6LYNW3UOE
	 jHp9vuVAxd9WurKTn4E/sGL/xrRFtW9VPEArmb5lORoXLQ46T6iM8VzatY2kztDio/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792851368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=szJ5wya0L92MO0mE9zpgYULlgCfN/w7nlnY0tNls5f8=;
	b=rNkJ0qz4DSOXotLvxy97E73I2r83Zy3g8eIrapvk96D3S8OAVQfxyTofTfG8aD2pom28
	 6Njum/5/d3RYK2nuustKxY8nHMvIeY3wjuTxbg6B0ngxPa2j0jSbX3pmrisTu2nJsbsbx
	 laF/M2csE7bSibJM1isWqvlALvdKP2CjLMRpY63XnjtZ/hP7hTA0RStk56SB55K78QuF7
	 bficIs3bvfymZ0q7Grq5XaEu5NF9vxonhnF4PAfSPadncL7XgBqyM6tcBgErcmoY9uz9t
	 TJ+DPJ720RYPW3fqmP1ZhiG4nuNnzFGAPw5qs5PCwd88D5/6Fl9CnD5MJ6ZhxGh06Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RcS2iKci;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDFB606A31F
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 14:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEDFB606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RcS2iKci
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso1259931a91.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 07:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792851367; x=1793456167; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=szJ5wya0L92MO0mE9zpgYULlgCfN/w7nlnY0tNls5f8=;
        b=RcS2iKcijg1lTI5Oeo0hdj5IcLGblCxqI/h+K4VzLGknFK6O7ScmsjT3d1BM+Ch2P6
         RJKaq1jT6eOn4fruQIf/BA9CxN1w/3FFIG/JhDhhRBMmJm2YtwFQmnpkGuoUKRqCreF1
         0bHQGkLDSXhJ/HwJpe7HOAe+1EVQCMxpmtkRzyrp5DYS3u3ebc4RuXAHVOybzMwZtkJc
         477YCwbfWOSC+5nIsOCOah+eq6pW+vlgvWFpUig8U2qYQ0d/CUuOkWqhYksgnJ78gmca
         beVIKZnAw39y+Wy/4easFwFeBv2l87JV4cHa5cgvyVSK7CUoz0incc8alSeQY+5PIomL
         o1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792851367; x=1793456167;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=szJ5wya0L92MO0mE9zpgYULlgCfN/w7nlnY0tNls5f8=;
        b=SPN6uInwpq+xg8ZXDeXMI1yAQInCFNfXHw9Fv8zIbFmb128FzzNXjHfxAJrusd+N02
         wCXkZMwzC3g54nT4/KQX/XgYnpj+3k1PaDLVr4ODYVi/ITSljy6uStkAZ1W505Iz4MSR
         IiPLeskeExFCW1kgEriBnFb7L9/xZlFShqSa+iNQYLnk3ItOF88b2dAbjGVXP9Ove9Ig
         5eSp00ESZ8PyqU3w+XX0wEdfgy8Vp2l4J4NlKpMT8TvbYtk4Zg42mMSAzuVwta0oensn
         1ZeCad6ItvBlTCdbWsbU7srQhZEoOVuJW4jUgV7t/ZBfZTRSCOqULwzvAy7/88Jl2fIh
         BtgQ==
X-Gm-Message-State: AFq9FYJlXFZv79FLDToeRyUV6xvBAgszhcn4ek4tocpxpU+MDtM2oL0M
	d6vsZbFgcr5YM8lNzjYPuGMLkQUTl7VI7FIwNtvF/c2VCvo94+24he813m4nHQ==
X-Gm-Gg: AYBFou2RPx+9ljkpqPSE8VQAC5ugaoO2j+Lhum5b0MOAN2P64hb/lB0SPi9Z94MCjaM
	nktt3YsMLr2Z2DCxSeWTbdv1+PxRPIftyBVQGaciMbcdjtPx6fFoRFbMt6JHyn636JFwwy2nlfV
	0Vgl+x8x5+V882ivfeXW+G2QJks9xmLlLga8uK8JgXrGOvZWOYu080BPCh8pvi7Cgk/iSiHTY11
	g9G74s+DJ0CyRX9uYxEYTVdwcuD+vwTs/raEXFP35JQUDTlctKRfNkXOAH3mEe8ElTh5PO4JYg1
	cfB5ptwR8k8uRg7jhtadgfi6pJBitZp8hb2zcZQmEd7uf01F5GVF/h6ECYtreGw/PXl4KzI7JKe
	yXPFtjiJvkb/vYa74aXVinjeAiRyDp71l5vcOIFfdjC9R/ohhaqOt+L7d+8Hw+/4f8pXXFbc/dN
	HHJcCCc99P7Ri+G/r51oLc+sE+xn97VyVFc0ld8EIcNdP8hbJYHsu+pYJQNKpM2/ou+pa76qFyL
	kQ0lKHvx8afONkEBP7VS+zpQxxFIwGS83N+LMcnk117W6EadRqsesIbThcJ
X-Received: by 2002:a17:90b:2f4c:b0:3a8:6045:5a24 with SMTP id 98e67ed59e1d1-3adeb0fa979mr2014517a91.38.1792851367273;
        Sat, 24 Oct 2026 07:16:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.3.206.51])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebe8f0b2sm3025422a91.8.2026.10.24.07.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 07:16:06 -0700 (PDT)
Message-ID: <6adcbda6.7263b487.1147d5.f376@mx.google.com>
Date: Sat, 24 Oct 2026 07:16:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3829309276184005690=="
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
To: linux-bluetooth@vger.kernel.org, sadiq@sadiqpk.org
Subject: RE: [BlueZ] obexd: Improve handling unsupported MAP events
In-Reply-To: <20261024115735.2403759-1-sadiq@sadiqpk.org>
References: <20261024115735.2403759-1-sadiq@sadiqpk.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3829309276184005690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1192650/

---Test result---

Test Summary:
CheckPatch                    PASS      0.28 seconds
GitLint                       PASS      0.22 seconds
BuildEll                      PASS      17.63 seconds
BluezMake                     PASS      254.05 seconds
CheckSmatch                   PASS      227.38 seconds
bluezmakeextell               PASS      84.52 seconds
TestFunctional                PASS      1012.77 seconds
IncrementalBuild              PASS      257.62 seconds
ScanBuild                     PASS      922.53 seconds



https://github.com/bluez/bluez/pull/2709

---
Regards,
Linux Bluetooth


--===============3829309276184005690==--
