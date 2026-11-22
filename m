Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795341996;
	b=0hKTb3GWAaRLz/IxJGZTb5M0bWDILXPijX7U/2Wu97CHCVXxdL741x013I7ZeJgZRE2h
	 3gNC7obxDRShJUmNg14BR71vbCcTmAio4Cef3c2Sp2qEiQcBCo0sNzkBcWwD07AgMCIIM
	 dF8RRFDWzMCCwHC0z4DTunZgF7Me+cUd6ZJr78gBLWD4zvA/4B+znzC0wjNgOwoZbwLX1
	 GQV3SY10tLdFatqvcUaiyn4pbSfEciNICvz0AXe70WJYe3JPS54eG8X2PPkJ7O6o4n6DG
	 zsh3J4ktkX5DrrRYnWPBStIJmGtBfeUM/3tWlYPLtz3HE1mMLraAbW3lU97uxufASnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795341996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=IGgl80Vp9PiQsEv1G9AGhyshkh429I2HCd7ftavNf5c=;
	b=xBT2zWzBCnl285yBiz7rj5SoDP1PYksrQE2c0Qywmo5PX7jM062/NofRRwHSXCQaCuQu
	 hjJ/3dgmvH4WIkA+Lhsy2vHXGf6n9Kqzm4i26AS3FHjvdnQaDwdAz4ya9IZnL562Tk19N
	 JS4bC+HHqf3HBqV1tqdm141gIv0IfH0L1rkGEl7bR7dnEdWnZwEELKN1rv+xyfqL3OIRs
	 EnVakDqdpJb1PDtuwdnRHubwHk0VAi47LMGVtS9oAlIkslINrnmpo095bLI15yKYVb+7K
	 vaRzfLylAAfcRVWG0bkG+qmubNDnJLdPiux+751iTFf5bOGNiR4++AMEeMwJwCIB94A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b8pyTTFt;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81DF606A320
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E81DF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b8pyTTFt
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1b3b4944a0eso1723336c88.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 02:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795341995; x=1795946795; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IGgl80Vp9PiQsEv1G9AGhyshkh429I2HCd7ftavNf5c=;
        b=b8pyTTFtQ9AoZOv2/IMzB/2/S2BRapb0eBpIDHGlyefW77SZO3HEN4oUJkgZjrr//4
         6d/QsJENHXmhNgH0HP1BS/Oo1Sdr1XMWgHofzhjJtjX4JAp+nNdZV14QQZvLVWqpRgOn
         XEgWk6SWTz+8IIkO6hfJURjEzRCIbeA6txPGxLOxCsNBrvLLuERWQVE7XXxo/eC7/Ww6
         I38Kjj+DUWX2x75jn2DBn1qn3Alv6IPAEJVvdS+w/A23EeGtVpSzY7Hjd+qz93D53oi0
         LID5iZHZ+4cAxidderykwA2utkLfp2ny4cI34KimVROdMOCqkOli1Ss/O2biNRQSjxDm
         UxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795341995; x=1795946795;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IGgl80Vp9PiQsEv1G9AGhyshkh429I2HCd7ftavNf5c=;
        b=UayOdTBy6yuGyDA3hK8Hp5TEX6bUihACMhv/+vhw/BC5HS8gw22DsTiNoRb+V1bDns
         iF6JoPVGVru+ZlvhEWzMGztyj3NJZqa4jHvYKkSfDSAeQ2PExqEcdcbzJRox5TT2xtEV
         SXs+4OAsjbp4mgeMX71gVuBOiFR6GLRLbZAxZGAROG2DQaxqctDlJ3sTDHhXPlUoBk0j
         lWuxX+F6RwRfQ/8b9O+jlJxH2b95Swp3tfwjHdHmPrE2v9eKFeX4ZZ+cRAdpXEBEWjMA
         jpOJWrcneDs6/gfyX3LJ4GsNaS7hEpFGL30bIxaB26bBGSctt0B3ZQSDJCpDhPiPauNa
         NNsQ==
X-Gm-Message-State: APuU4Z/M6whyhSp7pRjiPm4YxzDHSPyibNS2ozyBl/8VSOgLSlZhiSgp
	5hLZYYnm2izMviv29uFgW5eqiDc6ULCYu7hJyn3Nm5mmHICczsiZbRxMe3Vitg==
X-Gm-Gg: AZFdTZfecp7JJxWHlBlKZglWglmU44+Qf36bfOU3t5hz8AnpVIk6JYSvU1JzHK55/87
	pvivMhIFQ8Tpjy5ey1Bf3CoXpDObqt/YbNXhWJokOhnh+KV4+Ldjx4tp6WhzqtCpJ7nuHZJoiB9
	zlZJ6S5X3hPR75n97GoPHAmzSaPMbe/GIQ5SmRZv5ZkVeseTWntvwyryag/l2z5LG7gtm3hBmVA
	dasn2/Ni4g66VnfXn+V0IaH2kraqq6D5KWozgYSqgUbE91o8gwCjZT+42QRzsl9Fmv6UBgB6kmJ
	18RrXUhlXFIre9uxcKxb6ZBzjVKedPQm0J3Jgmd+0ljFJDqG3/GxWKTEwprYLs3CGomGIUzT0Jx
	d+R0MsKWjxB6x62jVzxlhqP0c3MOYRI83CTluGqu49xPkzR9aD4DMnlWcQOO8pU+FivK9fLjTr3
	9fbkN1UXBdPZbSYwP29o46iDraCRJhHvvBE7N04CjVEcE+0uewUmRfm97URh26RFKFftO083BKZ
	jQoNt5PyL1x4N0Vr0jpdbJbfM6gh3IXaWjRJXMjJFtCv9cdfGYuRGqwwD9nR5FOm2G4G2Epjwr+
	OcdGdA==
X-Received: by 2002:a05:701a:8148:10b0:143:2719:f800 with SMTP id a92af1059eb24-1b556908ecdmr7908632c88.40.1795341994667;
        Sun, 22 Nov 2026 02:06:34 -0800 (PST)
Received: from [172.17.0.2] ([20.169.103.2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5566c3052sm19898579c88.1.2026.11.22.02.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 02:06:33 -0800 (PST)
Message-ID: <6b02bea9.54e42a5c.2bfb27.b170@mx.google.com>
Date: Sun, 22 Nov 2026 02:06:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2282628074225894213=="
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
Subject: RE: shared/gatt-client: Cancel discovery read-by-type requests
In-Reply-To: <20261107065854.2147141-1-cochcoder@proton.me>
References: <20261107065854.2147141-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2282628074225894213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       shared/gatt-client: Cancel discovery read-by-type requests
   Pull Request: https://github.com/bluez/bluez/pull/2779
   Created:      2026-11-07 07:54:58+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============2282628074225894213==--
