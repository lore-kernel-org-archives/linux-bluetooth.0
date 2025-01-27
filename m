Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40B11FCCF3
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 10:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737973924; cv=none; b=SX5qu95byIwMchE41ll9K/QyWYue2tMesexJBwe/6bdv70Nhl52S1Uj9yfIro/WHidkhuT4TDnX5YpCPsnydu0WGcpGH0LmdSYHX19RFmOl39UsLAzJIsWbZUnUtDoXXVvjYFygwQW+07Xbcho0Cm69DhFXItckxONCCWM6IMRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737973924; c=relaxed/simple;
	bh=xo6GJVXrAooVofwqwNZrJR1Hg4iXTbzUL3EUJ0s3t+8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=H6VgrPWLhwVzj3Xoj4Wcaz5F+uPjmuIZCEeLyNEcNw0VM6n8X2Dtm82o5gWs2Wm3m/XLtnsX95BL6Y1xKccm80rk26pllVZD7gHEPGjAO02H6kJ+fHyyKTOj3BaLp2AhgtjFVHFRIvgP9PQw6qpQVezTxXocKyze2Xq4vohYO1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfMfX2lb; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfMfX2lb"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b6e4d38185so429850685a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 02:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737973921; x=1738578721; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IEF6wwGtoq4xKtPSRfxo0b4yY34GdfNJYr/YXqrBUtQ=;
        b=NfMfX2lbGBb6diJYYbIVSw9+NRdS5nALWatwv1eurex3P9Nl74gBBWlsGmk+pmnsAd
         hVucoJHBoMmCeytZKxwG/QdZLJbPp6jLOd8fd3u572FZlPGOmQpgsmZixJHpRbCjS8zE
         pWE3ca9kXKGSem6GLlSI5JGEYMLAg4JBH5RZLvs57Mgo+KetJDLXlhPDte5yfuWa019S
         x+JrNDFvqUvp2OkU6I5ywZ83bq3hVF31qYtogCZIlhGzTurQ30o78xkD26EiHSza0TKG
         9jU7SNluLN1o5A5YcDyx8IF0D0B3xU0oYQjHe7piUrKorRu6xkWAP09XX0KJskQpMMiO
         vgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737973921; x=1738578721;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IEF6wwGtoq4xKtPSRfxo0b4yY34GdfNJYr/YXqrBUtQ=;
        b=S07yA+g0wgyxiKEtBssnr+9mAOJxGs6vKv9Rmoe5mMGhszguUauLpQBzG8xtliJjOQ
         gjS95FWSjm1nL0OQVUTesdS607iKlKYhBsW+b5IWseviVNI+Zi1bwQ8/fUNv9KvC8K5t
         HR9Xz/AHSw5pYebQbcDAJYKobqFASijdqvvMp0mL2W/Gkzsog22Oe5o8kjMkKTntq7qf
         Rd70eepS3wQxaJk5HSHj+I2A/zweS+qTKv3MWMCvYvE9zUmD42Dsfdt4hJO0vHkfK7+C
         p529fq1SyaXQtQPEABqkrVjn14+nN4x/SaDFYs8buYaNRLRMo8tFCHlgLh2u6PrEg3vp
         VKYQ==
X-Gm-Message-State: AOJu0Yz0J1x9CppwsC7FPW+5DranKsIJvd1SfBzp4QHyN+01ClZa7r8k
	WAGY/mKIk545esRyjWFwgEc2AyJ0Fl2MDekZw4hwKYo6qsrjU7xCHfpHZg==
X-Gm-Gg: ASbGncsqr/D8YEecmXVDcGy7v0rg++xDkkCfknkuIW1A6DwSn1F7lwY78gU2TvQ1m8k
	ASRpzmdeq0zWJcP69OJtbMm2PQWSlgocgkGPIubAdNyKZ0NBQUFfYtXUf2LsFokkLPc8XNj8FgL
	s8I8m/Aw01/V5c5px+K3v5Xa8TYsUS2H19CRcd7BQNaCs7hEBiHwRFkJ8JrbBCrLl8TLRUQ3MkE
	XBpXqrbiaY76LEwi5VvanBgHWrVamjtFhfiANyzoKCDJjIaGNVphh2Bu/6mBHiNxyZDxVJdexu2
	ghB81iYPoZ3Z
X-Google-Smtp-Source: AGHT+IGTdPaV55tAE7PQJWMGTqQC7PltJm/euxvPshlKrBKKbUNsWOX+yMpXuRyGRlKHqVIio2FSaQ==
X-Received: by 2002:a05:620a:2a0f:b0:7b6:cdd4:bdd8 with SMTP id af79cd13be357-7be6323967amr5474126285a.16.1737973921536;
        Mon, 27 Jan 2025 02:32:01 -0800 (PST)
Received: from [172.17.0.2] ([172.214.174.96])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9aeedc68sm377497385a.74.2025.01.27.02.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 02:32:00 -0800 (PST)
Message-ID: <679760a0.050a0220.feb4a.d984@mx.google.com>
Date: Mon, 27 Jan 2025 02:32:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2777466124167740836=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: client/player: Rework transport.select
In-Reply-To: <20250127093004.19268-2-iulia.tanasescu@nxp.com>
References: <20250127093004.19268-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2777466124167740836==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=928488

---Test result---

Test Summary:
CheckPatch                    PENDING   0.19 seconds
GitLint                       PENDING   0.21 seconds
BuildEll                      PASS      21.13 seconds
BluezMake                     PASS      1537.96 seconds
MakeCheck                     PASS      13.01 seconds
MakeDistcheck                 PASS      157.88 seconds
CheckValgrind                 PASS      216.10 seconds
CheckSmatch                   PASS      271.08 seconds
bluezmakeextell               PASS      98.03 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      865.86 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2777466124167740836==--
