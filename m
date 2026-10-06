Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BEE3BED46
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791305009; cv=none; b=uSzooLXRqstNVyRgTWReeXt0yxaUDfgkYMaldtiBk6IjM9br5fWeM+JgBL63y0bqLlLEGDkPLDXgrPn1AfcHysO+q+Khc/MsBee6572407I6wK298O4dfLtiK/P97pa5+C4k1X50Xjc2W4YGsUHVz8Pm3VdbQILYCCN9XyiCReg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791305009; c=relaxed/simple;
	bh=RfrDsKmVNwo6Ujzz0lhr4E3FgnRd0r0akLuI5vHAe3A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KLTs5h4wOEyjj6JkheSpiqGGv/xUifZQ1i8AxbJpzdgTz0SaFS+6PkQTvKbI7KbdA/6ZlRi95iwWDOVqoueHrxj/pPgKH33BYZfAYf8wNp+4xyufwCCxSONJb4RLKVfOKJJFAtvEj5yochcLPsGxu7EGv8zx9Zr8xIv4f9irLHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdlUtAmK; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdlUtAmK"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6b0496f4bbcso1744155eaf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2026 09:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791305006; x=1791909806; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YDTI6fxXsQB+Lx6j6J/a38RUSgCTFiwhvEfBbqIWjoE=;
        b=mdlUtAmKNMP/h8daepolutPpe0C7G4m5OmNRiCNTONDJ0Vk4qy34y/9KKYNkNGxZVq
         c8tUFR0nE2cHdV92nDqUkfjaAmkM6XUgUvL5ITtw+5LbLViqruqdj6apdZJcWpUzGAMq
         A4yHgpknTUNPD16WyVQr98SgA3xtOykwyNHeoxxiaTW5h9RtegUzcph0MytY1eRK+M6L
         +ej/MoluRj6iYx0I52m1Fta0GhS4BgqTw4MAgVzWWJaOewKu4gZ2D1wA2dzDzjCaisCN
         +hifoUYDxxNTf9yD4a+EigVPulh5t7pc755u3nopjxUe0Panj/CKYoTr1+weORZLs27V
         3hKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791305006; x=1791909806;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YDTI6fxXsQB+Lx6j6J/a38RUSgCTFiwhvEfBbqIWjoE=;
        b=TvsqUQVuKnSqQXyta4doV5Yrv8tW/Idz6vDqWTVUQ8IyUK4+e+XNJI8xVXnYChJgsh
         5fgqEgfGJdMAiZSmtBgb2bmR/gM6KJEG9fAllu0WRSkCg6tZp7gyGSclkd93AkTVUsaC
         Dlto5edG/t6e4wfkObJeGXiuvSJMn5BI5tmQ4IWpQ8ThW8skORYjNojDA7wJNtY8I8Sy
         NRnYueK0ZsYCGjDNceZ4YN5tryfrkit676JnENIyOlWCr9VKdxpFrMuDTcTtUIMVfEhJ
         dnZAkLqBtL278GUU9RC4248mMA86PVU3Q3z+OwpBIQYXK8eiAK3uJASzKoU5SsIVy2n/
         3BvQ==
X-Gm-Message-State: AFuF++msqRNszo1E+wR/A5j1rNGT4PUFmjtXSHtHqLTbd8TpXhGVTFBW
	1Gd2S7cN9l+H34wC/zeyc8hJTJEv9l0pPYqWVbzs09lZ4vnX7sm1pmtxvhk7/ygVD6fPfQ==
X-Gm-Gg: AYBFou1enDBUVknVTAvb2HGF4Kx9RvyYRaeuMZqsqflbbbeJK68gyukaf54eFqUJ7qB
	J97Pz/ugeyKodfpcagwmigamJdJ7p8IY0x6sdBraDUxHytetJNShtMLk5A6PVaJ6+iEQDe1aPAg
	8YB+DbpUxMsYPD59yoToio4qbmZjzTeNqkrKzt/2LG2LRBm8aNFEqAoBKdr9iBP5BJxxnhSfoRZ
	1QFTR8xYYWf1aKSbwDlOhfjF9b8xsA5GXNKShkSMLoCsNBuUfx1VBRuhhrKuNXqZXx2BTqkrkP1
	2Wmfu/DJLrVfLHcZOQUaTx9pARexBZ5pFNQgBQKBJ8vi0qUlBy2VH7j5C+B6hREsUTWqOp3F37I
	tQkI3avgnixuTzHJ4YUKa0ajToGB5O/fm2qfcp7w1SOwel5Te4ZYkI78IOlQa+VnxSsx+FfQ2nS
	ooLs52Xdt5RnBwrPfWs7JEzSE/W558ithNFLAX8nPL5IBI3SNvBf7cWmftbavsI2cgzrlUA4vgD
	thp
X-Received: by 2002:a05:6820:1692:b0:6d8:8626:be96 with SMTP id 006d021491bc7-6e099d4de36mr9414091eaf.1.1791305006498;
        Tue, 06 Oct 2026 09:43:26 -0700 (PDT)
Received: from [172.17.0.2] ([52.154.20.54])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49e16d6b3aasm14120203fac.5.2026.10.06.09.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 09:43:26 -0700 (PDT)
Message-ID: <6ac5252e.e782ec0c.364fd1.6eb5@mx.google.com>
Date: Tue, 06 Oct 2026 09:43:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1227133337285544166=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, derektern@proton.me
Subject: RE: BAP transport Release and reacquire fixes
In-Reply-To: <PYDC9kPUFiayBviaLIJziLbacU4BWxj1nr2x3XTYoyuEajR8F_65ogs4D3OS3dMS7pzzn-x-4ekzVz2lfDRlyviCh5T-ZRm6GV-wtf-Ud0s=@proton.me>
References: <PYDC9kPUFiayBviaLIJziLbacU4BWxj1nr2x3XTYoyuEajR8F_65ogs4D3OS3dMS7pzzn-x-4ekzVz2lfDRlyviCh5T-ZRm6GV-wtf-Ud0s=@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1227133337285544166==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1180235/

---Test result---

Test Summary:
CheckPatch                    PASS      1.23 seconds
GitLint                       PASS      1.21 seconds
BuildEll                      PASS      19.40 seconds
BluezMake                     PASS      392.20 seconds
MakeCheck                     PASS      14.09 seconds
MakeDistcheck                 PASS      138.44 seconds
CheckValgrind                 PASS      229.50 seconds
CheckSmatch                   PASS      287.01 seconds
bluezmakeextell               PASS      92.95 seconds
TestFunctional                PASS      1139.30 seconds
IncrementalBuild              PASS      397.83 seconds
ScanBuild                     PASS      1103.29 seconds



https://github.com/bluez/bluez/pull/2629

---
Regards,
Linux Bluetooth


--===============1227133337285544166==--
