Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36741607B7
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jul 2024 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720533218; cv=none; b=KESW1503oFN3y+tdHDbTd5C27mXgrX7RYnyEjsNRU4MxVsISujlO76gz29pnWS3zadDLagn0EhVSyx+GMMlCqjatpAQoODJQ256V+HUObT/oEqX7KoTvEnvOJtz9ELJgxPrc4K3IjdgJiINlTBq5i25iaJOHj+86ZtGhuyRm614=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720533218; c=relaxed/simple;
	bh=Wg9bDnnlVChnXeBET258WhbXyZVy8KnDt9AarpFhDyQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TxpUvUfIWRFgIab5I/emVQUcjdwEGEYtw+5NFbCTJ3VLwlOwrqTHZYJyc2n4rNyAxbJWS8Yz6qdANGIlspdYLREcPj1CSd4gqy5R3q6Zs7tQRMM/RgNTC9cR8xkZKeRfmHp2cAQ0M+rZvWdR3xk5d0QpEhsaYA5XKarYtKooCII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPAgvaq5; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPAgvaq5"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-651da7c1531so47764667b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jul 2024 06:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720533216; x=1721138016; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M+Yvcfi3UFMoHAzO/b6rh1ebgHwi568tY4OSQbmM9N8=;
        b=cPAgvaq52IjHeL6B/7IhlLhTYK6Xkw5TSAtII2cq9McVnASQkBFbmzxul8HQE3tDfX
         KmcoQRl7j5X4rz9TLMmA2B0Q4ZtHqyGDRKUP2jBa4xJR45xw12KLfUj95FcIMGQoLi6i
         erCCBcI3Lt4ic2/QGPgkfUAy2zv9SPDxVTqumCFPNu6sc0FO8L0Lzo59XfQ7dwi6ynPt
         SgMnaZ/natijvGJ/PojNeN8DYvHJkgv6KDqK4OeIPNKxghWrCfCmWtIJBD7j/oR4z785
         oKISYHzENU0b1guBr0Vbb2K8B37tmuXUPc0NUUX/AKMo+XbTVaDUrl6q3/O0H8XxVpxe
         GFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720533216; x=1721138016;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+Yvcfi3UFMoHAzO/b6rh1ebgHwi568tY4OSQbmM9N8=;
        b=KbK0al56C/PzM806XOqT3Iuf5KFZx1TmQGYb/1YWmA5tMbS7h/ckHh/eVh2tEVhl5k
         /XeSpYyrtongPXlEALOriyFM1fG75NCRKE5rgBNhSXiqPfmMRGPvrePRRWXNS0FA3WYX
         b2XPyzhoUJwkUkUcpiJjxyKyVwVoFhKpjXgCMwTWmykc+RlFDdeZADeyvNRu07OcKipo
         mmx6FE024ZJSJcQ/TniMSpnJ9I9A6LjMnqiDfIFt0f5on5vzzRQDoGvYtS26/UQv8JTU
         SgskX/S8xT/mK2fCfcKfz3VoqgB09TQDoIEnw7PiWNwEgL8j/bMLgYiV9+5sb6srdPC8
         hOZA==
X-Gm-Message-State: AOJu0Yx0LnBJbCEuKp69LUdpfIT30RRcNkEII62D7p7S4t+krBCG6EJO
	LONIzOzAJNx3ejiiH1+3QPjD3E7Wssp9p5ON0jrQyHxclnQoGe5Z0fguNA==
X-Google-Smtp-Source: AGHT+IGg7ihCs2cBxIi0wuULpwoRoEHISiChx9I6TEG/I8o5ivvksPJ9dagJCjTnsaagMW20bZOtXA==
X-Received: by 2002:a0d:ea50:0:b0:653:ffe7:d648 with SMTP id 00721157ae682-658f0bc622fmr27057127b3.34.1720533215711;
        Tue, 09 Jul 2024 06:53:35 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.106.56])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-658e4d2a7d1sm3524807b3.31.2024.07.09.06.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 06:53:35 -0700 (PDT)
Message-ID: <668d40df.050a0220.e1fce.1f82@mx.google.com>
Date: Tue, 09 Jul 2024 06:53:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2231405661959550996=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arjan.opmeer@gmail.com
Subject: RE: [BlueZ] tools/btmgmt: Fix --index option for non-interactive mode
In-Reply-To: <20240709115541.66118-1-arjan@opmeer.net>
References: <20240709115541.66118-1-arjan@opmeer.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2231405661959550996==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=869637

---Test result---

Test Summary:
CheckPatch                    PASS      0.38 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      24.65 seconds
BluezMake                     PASS      1645.25 seconds
MakeCheck                     PASS      13.60 seconds
MakeDistcheck                 PASS      178.83 seconds
CheckValgrind                 PASS      253.40 seconds
CheckSmatch                   PASS      356.17 seconds
bluezmakeextell               PASS      120.42 seconds
IncrementalBuild              PASS      1467.28 seconds
ScanBuild                     PASS      1001.55 seconds



---
Regards,
Linux Bluetooth


--===============2231405661959550996==--
