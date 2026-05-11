Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5253A374E6C
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 11:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778498791; cv=none; b=n2Zb6VG2Egs1NKtrOY4gk7mRoIj1DoNqrEyjG/GWCAEuYDjyYuVgsOKLfQG8pt+U+v00trdgtiFtU9ZJAyid/2Xzb2U3qYNnmnA27K3IXt9qyteBAM7kmcQfQrZjKEqncO6rHLkLb8EWl6G18ywgHEfAKwb21gbILAI1SBiIDek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778498791; c=relaxed/simple;
	bh=SkoKfYdqHyDabRKj/GwmHBmNYk4O6JcWOZxYxZr+b54=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IccACIjyVpmiZ9rrkeqj+rnNgM8Q2kxoZqfb5O6gStTXWCjYIe7WvYcfyDmY9TksztPIqgFhq+AjQCDNcuEp+5vZoQ356er0uD3Ijs0RsaUFLoJf4PXJS9DwA+7nFaf/mR3EluDzmmydXhW0+XIQxI7zIUf+ds9PAL96nOegr4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdpYquN1; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdpYquN1"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1330d6bb78dso501605c88.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 04:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778498789; x=1779103589; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=of+h5mKOSzwsPlvBj/9Gt5oQDy5vheQfmDsDN7FthF0=;
        b=NdpYquN1Apqm1CIEqWpvmnPyDnzF9z0d2YeqX+AlOsu+dfK6XLvMVPuklJKpJNjWRc
         q1JfLYpc0AUVE4RkKXZZP3YNjdKZcbN3xSDsVu76YvXC8x0ykC8fy9fVPAhTd1V+4OTD
         gavowAQnM3+l8FmjOSTNdNQSerTbmrFbvKYBDktlkT5E3rvGv9nN2fJIaUNUm/jcZGyJ
         S7oLkR4HLTkXuoxk7VvZxf7xe6NAb5XDz8fAc/jMunx7iQxnlqGMWlTdNV3IZ80vt5Qq
         rGxCrPTLKZlZuu+GaeTl/I4E51rNzUhxs/rUmUmxN0zwqYKU1NtiJKArkIMxByfvkkWX
         Ua+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778498789; x=1779103589;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=of+h5mKOSzwsPlvBj/9Gt5oQDy5vheQfmDsDN7FthF0=;
        b=Db+jrj8d0UcUXX9VtugcxZmve+2cuCpSIO5eWvilAGNTbspTnzqeSdh8/Xi0FKnekD
         YGKBwAUvFwDO6scUv5uj06dGoPpc+jY3LjNo1aZwkvETklR1dm/qquzVo92J6TE/UxwV
         pzO04D9dxYct0263bfQySko/JFlbWfPk9PIh3szrDxctof5Z+27LBAMP9CJOxTj7bv48
         0h+Mvex2g4hCETvo2RCA1l9MYd7aPeGJL3Vy8nqbVoNAevmUj1+cxuacOW/3bUroEi8r
         dQxqSmh4/SW8bAkNxioCcW17vZyuwK+iWcMphrhBdMUzaFeQqjKUok8urwMgtvEcGMqE
         LBXg==
X-Gm-Message-State: AOJu0Yx7GWwseJGTbXz+pfcTtojDUCIKXkbwlMjB/IvQB8jSeCHiVkUt
	1+bQcJ51q55VB80WqtERprpNJNCSP4xuBiOLmFan5H3wNWLTv4kD2NO9MDIqsA==
X-Gm-Gg: Acq92OGhWThPSNszdA+BbUqoXcnHL8gAhdjb7fchV7HDGP2otI0lCdnvVErO0EHHUXO
	Ech/3MKYhI4FMbKuW0RNFIqDb2vnPBCJufHkIWQNWJFwbFQLrhp6N2bK6uhxoaZGKA8UFHpR62A
	DXocRt8ha6q5GA2tp8nytSfJAkCOE1z4D4bZoOUitxm0eQd576Z/oxO6uklpaRRa7Poyhnb7MDl
	OM+iB9DRjdWXbSGjcuTkZRFTvYwkbMvfHQuh6eh83jk2t3bgTIzl4vxm47t+VLWaH3kiVGJs/K8
	2fy3ApiAc7wHhwD2xWckaVSm9xfdh6LEJWNTl7Ah4gFFCLqFqansBeKhEnGzIYarIL6OCoJQ5ZF
	tjdNTNH+2Er9DcEAqMniEWkxKW2oz5ykjumpI5bXGH9sSANBvhvVN+y0t+SiFp8VZmYCI22E8It
	TUUhN3mUhZpKH1AqLt5rpA+xeWJsqt+8Tzxxndk6Y8
X-Received: by 2002:a05:7022:2222:b0:128:d219:e169 with SMTP id a92af1059eb24-131853dc968mr11870564c88.10.1778498789028;
        Mon, 11 May 2026 04:26:29 -0700 (PDT)
Received: from [172.17.0.2] ([128.24.163.71])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13278210d40sm17009190c88.4.2026.05.11.04.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 04:26:28 -0700 (PDT)
Message-ID: <6a01bce4.050a0220.25fde1.9c1b@mx.google.com>
Date: Mon, 11 May 2026 04:26:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4866751448076707389=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, silviu.sandulache@gmail.com
Subject: RE: Bluetooth: btmtk: set HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN for MT6639
In-Reply-To: <20260511104607.382060-1-silviu.sandulache@gmail.com>
References: <20260511104607.382060-1-silviu.sandulache@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4866751448076707389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1092685

---Test result---

Test Summary:
CheckPatch                    PASS      0.55 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      25.33 seconds
CheckAllWarning               PASS      28.30 seconds
CheckSparse                   PASS      28.08 seconds
BuildKernel32                 PASS      25.05 seconds
TestRunnerSetup               PASS      549.88 seconds
IncrementalBuild              PASS      25.94 seconds



https://github.com/bluez/bluetooth-next/pull/164

---
Regards,
Linux Bluetooth


--===============4866751448076707389==--
