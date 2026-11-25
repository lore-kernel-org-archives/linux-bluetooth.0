Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795649511;
	b=hG4WYcY8EzaqVdZULWVnpBu/EAZNvJA5jkc+HEhOCf90M15Cau4FO9m4ItUaxhCo346C
	 ArRPGNKSLMHQyOUmD1k32Ve/kWN6XJfZHBv5srJ561rUer3+0e1Nh96fZcjsU0+hUTBhF
	 SZkNqxXG6AVJTkXD/5M4KQ2JR3psCLeT/KkPY6h/I+VkzM/l2DfJEcd/oDwGUEY84Uety
	 AWE7pKLTfYRrevyDDL8ANH2pw3hCowWWNMYLBKtZLpNfrYqCBhTjioizrttdXxib3Gyid
	 Bdb7fysS6ajdCa8Dq+xmjdU2cLVn2T43xEKPzcuzJf5mRl4YJUr/Z10U+sKUkgl0rqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649511;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=7Vff4DepNTdp6vd8XOw9jj39ijwrIVPEhnUduCPvSqI=;
	b=rmRcnW11d9HW/eSzgTpfqDTfq3BsyrgswQex7RVd+ZaGhU2cVRFDK6EYO+MqqJaZi3FV
	 uxBI606KXDd/jDh+4kzvkr4h7CF7OQuEXfLe0Ws9qS/iUcuZSSs1GLc5II6e0zPqA2v6l
	 wRVj5l9j+/a80MK2/TKiamB+DFYi5qoKqiUhpHs5NN9219Mpfnl7o7dtuJ8p9DY53Mat2
	 VQTgSC0JokcLVlp/DM4gKYykFGAfz0Bitw1IsYLy+398FNufQUABRU8+6mlzMqz7PrhMF
	 Qw4xZuhePRNCL5/VJMwknEgVojG8O5fUmzTksQTw70T+P99xmZq8Awzx3PGan9fZDMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=joTgQ4Dx;
	arc=none smtp.remote-ip=209.85.167.173
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EC8606A321
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 23:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25EC8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=joTgQ4Dx
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-51f2e9e6987so5055198b6e.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 15:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795649510; x=1796254310; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7Vff4DepNTdp6vd8XOw9jj39ijwrIVPEhnUduCPvSqI=;
        b=joTgQ4DxuxmnO0uXpHc0Z1c7rxVsTtbRfYu0A+96ugnOZ8dj32+lrnHPGhx0XNm10a
         svwpPvVOgCmvsHgUqVT1MiqjaZ+sHN94FDQfc3r9c+M2ePpD7rZjWMKKR7Cf70T7uTot
         iHHNPMizb8OWX6W+9otsy/4/820KRiTUQMvyPD8Nqtkrn+D1eWhrhRnJa1ZNUJ11XkAz
         /7cwoJ1uI7zJAHnW/PUQH0y6LZWHrqyoqmJKXT2ANnR4O0flcJHSm4a8Xrxk2Oon+hZc
         ML1/35kpZ1blUKLpk53E5WiR7WOrvHJiKl0BruTzGKbbnKpqFA7RHw1v7eDXHR0yMjmm
         a0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795649510; x=1796254310;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7Vff4DepNTdp6vd8XOw9jj39ijwrIVPEhnUduCPvSqI=;
        b=FYfkSFoWdDPpndgjCETLNPNWBzyfWn6V4cLzFuqLvHV2H47isfe06tUQc6EZm1PmZD
         Cb3TJIviPitXnfQi2selz73sZ/JysU+O4QfdirqhlCLq0eqXJjQGtPSy8mhYTcTd23e5
         CV0Xn7nUTEa+W64NwZAEiF32As/iVO9iyFh70EeCJyNOm6i+JuP4bl99kOMdC395tRLV
         MIzacxv0Ghd+SHkYU1fwrj38q6kz2IbVa/Bl3CXBRO++h65RUhRKQrMmyjwesI0/qME+
         gq1gddcGM+judgJOvJFAHrkC18LFud/9ujCOblzUjcWT47lyjeEUgcWczf8cWIeZE8I4
         3jbA==
X-Gm-Message-State: APuU4Z/3wP7moBFG8s5QLSnJZotnBJ5oPlHxxZ/C56KJDB4zaHOsd1/c
	AJV93guzUUwgNCe3BZr1kK910PdXnrRrT063ZMPWIDvUFACSj1OMyVBZAro37w==
X-Gm-Gg: AZFdTZf6KlopQnsdAIxO4iutDmhLwQq92rq0dG2spezAlgUqHnGeFA0pvDW1+5sIyKx
	hTe5PxlAtbng+pPKUX44TISjDmO6fEFWAbG5sWTEZagftgb6B6M3vmi4c2qko7lCp5ZaYjCXf8H
	pM/EeWHT3+N/X/2f4HT47UzQyJcL6+ByWANaRL2Qw5EbsMYMXgZGqjSfTi5opD8kcjoWkt3gB5w
	swd0YNBLP8cXjD5KKLi/nk6DdIViCf7hv7DKRnRdI4e7rgDKjlNJVBLz6kOOmXhliZCOHltY9XI
	Dog4R2csPWFpqVBpD3DlhKO31Q/4U2NXr0xZSegRvVU/5N8oEpJExup7JUOEST+Jb0ttpb2/Ret
	uBGQNC9zExye1yEE5wdBEXA1rjFWdfceGgcS1gE5qSBzzRiAF17NMdWpgapmxeqI4X9j+4ZBynj
	EgdD1GXmsdlxudc0vAgRXC6EtRlxy8Swc05WRKzJqTTr8JKtP1fcTjhjy8hrO/exugHP6NdUsRJ
	0I3KBlPva0QeiUxejsKB/iGzCFcqINvw2CtMrHpVg5qbD/aD5iUx/baF35Rou4/
X-Received: by 2002:a05:6808:4f68:b0:4d6:9133:cff6 with SMTP id 5614622812f47-57a0bb5403dmr16177696b6e.29.1795649509932;
        Wed, 25 Nov 2026 15:31:49 -0800 (PST)
Received: from [172.17.0.2] ([20.112.237.241])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a31929223sm15243306b6e.1.2026.11.25.15.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 15:31:49 -0800 (PST)
Message-ID: <6b076fe5.7439f5ce.1c54ec.1eba@mx.google.com>
Date: Wed, 25 Nov 2026 15:31:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0761403759812511920=="
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
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: Fix GATT over BR/EDR
In-Reply-To: <20261125165906.1645581-2-simon.mikuda@streamunlimited.com>
References: <20261125165906.1645581-2-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0761403759812511920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1222363/

---Test result---

Test Summary:
CheckPatch                    PASS      2.95 seconds
GitLint                       PASS      2.10 seconds
BuildEll                      PASS      16.01 seconds
BluezMake                     PASS      189.96 seconds
MakeCheck                     PASS      3.10 seconds
MakeDistcheck                 PASS      113.32 seconds
CheckValgrind                 PASS      109.76 seconds
CheckSmatch                   PASS      197.97 seconds
bluezmakeextell               PASS      69.38 seconds
TestFunctional                PASS      940.80 seconds
IncrementalBuild              PASS      239.77 seconds
ScanBuild                     PASS      691.63 seconds



https://github.com/bluez/bluez/pull/2923

---
Regards,
Linux Bluetooth


--===============0761403759812511920==--
