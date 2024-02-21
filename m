Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBF265190
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Feb 2024 12:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708518694; cv=none; b=XB85ipU7x5C7TlelSJRVXG2l22iuKszo8r7j0LJSzjZMlWoDkyi0qDo2gDST1rS6pyEOGpnFgcjj/RrcELE7L95bP2f8NDHINt/mui+sr2YhNJTFUa8CQ/8iJ57KFsWWcdWw3gWfGKSJmKCnoPIGOIer7Xki9rVDP52Ydu52l9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708518694; c=relaxed/simple;
	bh=rdu3pSuBFdBsakemgueM323s49VD/Uw28VkeAMnM8D8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fPETrut8WirIjroPgQjdZ3vaBPa0lVlTuJ5lnKe2mV/i0fRxrYyVRX9L48MTRm4bhPh9D4gsorcfnvFkrAjTqrfkt/ejERQroG+qJi08gNvFfP1nbI1gGZqdrBHoh9HO14EGxY6D/zGTDHXPIgqPKXsRXUjH+bedx5EKELh8j30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmCJ7dN1; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmCJ7dN1"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-68facd7ea3eso1113046d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Feb 2024 04:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708518690; x=1709123490; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ciVs+hFF5+3JdMYltHwOuZoZ+F0XUZ+YY+BNTeBOyZg=;
        b=EmCJ7dN1DBn3EjL9lNQkTB1JzYNC2gbpHg8UcFXp7FuLtQz1gojyfircwy/OwOnOGV
         dNwklb8JXcU1zdfdzsEXEV+K4Jxojh7O5AXnoWYN2RHFU23qvq2wzept4psJc8pPI1x3
         /Hw33cKIZCYYErco6XsViRrMH+NINBugaKdHydbYwmipaNkHIJvyOIpZv5p+N7WyWqZN
         q57mw9gPjFUlAVGSd1O9zvTfb+y/JSOdrMEYjeSbibyKbraU1TSmascrGW9OCipqCLNe
         EqKkU9og3bR5xJLQRz7Q8zlV2CpgA2IoIKwHE6w6X5xk8jkFtrE0lxtd55Uejr4L+zpk
         H4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708518690; x=1709123490;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ciVs+hFF5+3JdMYltHwOuZoZ+F0XUZ+YY+BNTeBOyZg=;
        b=sSRfGgYNks0JuwsJ29IauAzbqNelOZlRW5zzOjcdK3+GFq1fmElvw+1xP0qkJNlmtt
         vQx50KeasXDrGcc7mM9kcaEOvMVaoJ7DmUv75KtKazm3qhTficYQGbTJM1vrvR9WAvt+
         IAHTxuNvEQqggYvFu8iD0TMzaCrmwgTBajmIMDLkNPyrvrzFkD2ECGe/UBJm6Ai5djEm
         XAKEYx/2QNqsxVg6ztREDW4sK941dL9aW+N54ZkadwXGX/J/qHs2LgMsP4fwb3h9cZVL
         Gu+DnFTLyHIMzqGtXIgZDfllZxNPV//WhDrN3jknCVDmYKB8sZOQNg3jHlYbJUH4vD4t
         d9eQ==
X-Gm-Message-State: AOJu0YzTg3+iU4PTO3qG4LtxkTpOzBzsUIY1BNPWHCCwcdc25VquyEHU
	zeOu2X6gUDfJ2RXm+DlzPfJtSALyTSMPqkeKcCp88W4RqLEDkg5bP3ltLsEF
X-Google-Smtp-Source: AGHT+IGJSVuNnD0NqHaHO+rn/YOMnBnmYeS5errTmiL6qPXh5WM+uUzrl++2THQcO1dbfBvEe93dvg==
X-Received: by 2002:a0c:cc04:0:b0:68f:ac70:69a2 with SMTP id r4-20020a0ccc04000000b0068fac7069a2mr657248qvk.9.1708518689981;
        Wed, 21 Feb 2024 04:31:29 -0800 (PST)
Received: from [172.17.0.2] ([20.51.206.228])
        by smtp.gmail.com with ESMTPSA id ok13-20020a0562143c8d00b0068fa78ccef7sm507215qvb.116.2024.02.21.04.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 04:31:29 -0800 (PST)
Message-ID: <65d5ed21.050a0220.58cbb.17f2@mx.google.com>
Date: Wed, 21 Feb 2024 04:31:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3520475535036257149=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, Joakim.Tjernlund@infinera.com
Subject: RE: CUPS lives in libexecdir
In-Reply-To: <20240221111901.2807853-2-joakim.tjernlund@infinera.com>
References: <20240221111901.2807853-2-joakim.tjernlund@infinera.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3520475535036257149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=828229

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.37 seconds
BuildEll                      PASS      24.26 seconds
BluezMake                     PASS      738.36 seconds
MakeCheck                     PASS      11.74 seconds
MakeDistcheck                 PASS      165.40 seconds
CheckValgrind                 PASS      227.10 seconds
CheckSmatch                   PASS      332.11 seconds
bluezmakeextell               PASS      107.93 seconds
IncrementalBuild              PASS      695.69 seconds
ScanBuild                     PASS      964.55 seconds



---
Regards,
Linux Bluetooth


--===============3520475535036257149==--
