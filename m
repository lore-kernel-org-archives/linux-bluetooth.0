Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C14AB652
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Mar 2026 16:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772382497; cv=none; b=Hut3dSr/tVIG2MyCONF/4zU7xh/AmG/WMO3hFJsQXe1cXzejmvfleq4/L3lSyqEHwGGImfjjNsqjvfx0Ve9dmtrC3mJVjvBtZE93yAADA+BGENFYNmyERGsZbNC79/avhBPo2Ey0u+2raGzboln4UVCI9wJCoQ7iav3/XB4WtrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772382497; c=relaxed/simple;
	bh=BlSzZKtwXU1zyxXmP+PE5JEzs3DdQ00zBg1vGsvMbb4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Jk6s9N9zHNxUonnltujIDWgBLp2/6iOF6JOkWMgr8ZX5vfuLe40acWKqK3Bc+x9L6iXIgSjr/awbN4kNZ9XfMfFU/n4WQT99WQlQ7q8DhXTzg7uIAHoaY8IJOwssbwIAQTLq3GccuS8RQvLlC0c30rWTxwXwRPI1b5WNXOTimBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POy4zn2E; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POy4zn2E"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-899e43af784so13252506d6.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Mar 2026 08:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772382495; x=1772987295; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DT9K+vlj214Cva6IIczqvBQB1Bf5prs/VHmAGKChGP8=;
        b=POy4zn2EeRPaJ8Wb3KouTqd6hGhKqhaIg7F23ekyg3EKDEYRem7yOOsLSgvSc+ZmRO
         8MxsfdQ85heRHqobVbNRsYZf3EEsRJ4I30glBLQGF36/8zV0ibqY86k8yTHka5SMn3FO
         3hVmOzOtEmH6m5pcZ+pzcQPEOB5nbs3YpbFw5NsWLhiVx6ed2vqfRCh5f5/XFMCa7z6J
         LgMe8oexyLOrjuPSvyuOXLhTNdcXaoNQyKU2pLHZFxfog6aVkG/zhk1F5WeobuP30ENC
         /gh6j9FZEIeiu00MSs8TjsZU39+ClGPeEvOEukaGysMtwRRHTpHlg9QwqTwXpX2/oYVU
         CWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772382495; x=1772987295;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DT9K+vlj214Cva6IIczqvBQB1Bf5prs/VHmAGKChGP8=;
        b=oMvIofdnEohUvqxuiuxv4grdq817jxWdAnDdeNiV5G2T6XvBJAqGJn7AALbLDg4hG3
         coQcpv0zlu0VjdHIHHm9ZXPd9nO1sLD1asUjCBUafIRIIzOH3Kf3Q/iazJ5WkvUKShQB
         Zyj/gPAZQU5RauUNa74Xj4FjARsO0KWL3N5pHkk3MRHUmrlK8VZYW0dZVrWVq1yMn7CW
         dV8YAJszYg9hVvooVpLOYTEeCmnMFJXGBmvgRih/LHjmm1mF5nD/NioaKPUtry6jJuKQ
         BED0kyNWJxZo7SByj1CckXaFlQH55Xkmn7oDl5oKskunivITULe5yQywa/Fqp7AJ6beY
         TGWg==
X-Gm-Message-State: AOJu0YzT46SFj/K48bjZHWoSR+Jwu0gYv6652qPDikd3yMHNuw6PtidE
	DQa14/q6583vfVLtsCIPw3rEG4FzHg7fQV9isFvSHKbIJZBr7s/HLbgvANOOqCje
X-Gm-Gg: ATEYQzwzVApNWP11VMrOpfP6vcKzI65xjuD4bwsN54Sz4ZKt3B/67fT+G+4TvgsIi7z
	LOdRFdmQQFMyICf8jBQO53by5WAhMUCsBuuOPm8mGgHfoOJ/5Nnb3MTLcy7Oyc6ZKiYCG2dm24F
	decSugeI3gSxTbt0gQ63ZqOG0VXMINzvRon8/H1jmKiR0gfqMN3T8RQSbSwO/y6ooIvDWmqIK/H
	DaLOff43JMLwzcbldKL8seFk2yeaw5pHhGR32mdbxZNRI92E4IfGFERd/iyhU4n0vYxderxnp1X
	BsPig8TDnlnNYuRDyLpfSetA2qVzrMx2UEZNK5/onWzRKaKzdO34zvetaJLuvL5MnlWC786UdYO
	jnDFDXHDf4rDNSirmA6y+mwWiDANhph3nwBaU01IoAWI3uzHsbD4OxUZmP5YOu+rxsw1fkCctsD
	SBW/KZDl7Ym/xBgcs76r0KVEWa4mTulA==
X-Received: by 2002:ad4:596d:0:b0:899:b7a9:7e14 with SMTP id 6a1803df08f44-899d1da8ea6mr132884166d6.9.1772382495018;
        Sun, 01 Mar 2026 08:28:15 -0800 (PST)
Received: from [172.17.0.2] ([64.236.137.130])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899ebb09772sm26724276d6.12.2026.03.01.08.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 08:28:14 -0800 (PST)
Message-ID: <69a4691e.0c0a0220.1c38a.4c06@mx.google.com>
Date: Sun, 01 Mar 2026 08:28:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4933911601204925245=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, martinbts@gmx.net
Subject: RE: Enable and add support for Nintendo Switch 2 controllers
In-Reply-To: <20260301152930.221472-2-martinbts@gmx.net>
References: <20260301152930.221472-2-martinbts@gmx.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4933911601204925245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1059646

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.35 seconds
BuildEll                      PASS      21.27 seconds
BluezMake                     PASS      663.48 seconds
MakeCheck                     PASS      19.25 seconds
MakeDistcheck                 PASS      254.70 seconds
CheckValgrind                 PASS      300.82 seconds
CheckSmatch                   PASS      365.26 seconds
bluezmakeextell               PASS      187.90 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      1043.45 seconds

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


--===============4933911601204925245==--
