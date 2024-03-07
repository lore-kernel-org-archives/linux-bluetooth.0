Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D13112C52B
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 13:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709817455; cv=none; b=lz0slk0CODkMLRj9nHarKWYR1ytGEfeimjYH6yjBXEZcXLomnlK1+IgR4VyXdlrFfBhjLwolAVRk43Op0X9lkxLwRy4VC2ExlI8mOm5PMnXvnRJFIeI/JHfrXhfdj5z+6mJw4n5AkvcUn3H6k4GCj0o1aHA4NVL1lyz/00P725w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709817455; c=relaxed/simple;
	bh=0mniF0FkjIQ1wE3I9uCxxku1rmMP8odNkhWR0JTP3hU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=se9etfcGLWlTxR7ZaKVBKhej39S+1FitnDKcbLxWK+w5zwJjV4HMRY9amXAtI/3KQMgqNgnZX/9Uwj1deVpbU45Law4KRY3OYvmkQxNkD1UVjuGFUE1K53PVrPpqFT1bVvzNqGUndwq2tjqviKEw1fo197Hvr3wR1SseDNpDaRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDGXAqRB; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDGXAqRB"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dca160163dso7981265ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Mar 2024 05:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709817453; x=1710422253; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jS3DqRqP6lu4DdnA2w+EuJfDHkDtk/dp8I0VIhuWVLI=;
        b=kDGXAqRBqpgrW95BcmzgvmS+5WigAy1kDdJlx353z1/2lOsWyy6JX62cS47k2KnaWf
         gTUKQ0PFO7tSMNEtX3SpQ37UgM4h9PkKz4Xsrd/259wQQ7NdBJ0zN8iqPXENqi5N33yV
         7iCDUvJc2lT/PqXg1Vx1GTieVnUfEMHacb8IT+OrExx8fM1zIOObmHMi2t6TWY4lzVIl
         E2WJf3mZMzD5pxjCYSMphdwIm6N/WkVZyyHNAwmq0QtZZcbEa/QFRhTR0zPHc9u0ngVB
         b/cjaI8XE+EsTSKySEFcLf/F6coDQ4hLi/96ToFHna/5WlF/A1omFgw8VdLhNPO3bP71
         +rqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709817453; x=1710422253;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jS3DqRqP6lu4DdnA2w+EuJfDHkDtk/dp8I0VIhuWVLI=;
        b=pE6PJ00AymZDYpbj8YPJeVPiXa/RiAgO85ucx6exmUj5EOrmitCIJsjQJTscVA/AMg
         9d/hKOWoPQcwUEq3ywlEsCMds3BGlitM1NfceYWCw58RzXUPJ5svXEfBjREoxeJzxf1f
         t9FmWV99RBsQOh0DxG92CKIGzvDKSAyBWH5s9myH4pYNgxXr83DXfn0dX6ufT+cPbylg
         adrQ5WuuzY5VmGpCCYFcEK0+vuvKPEeBHtj2JLYtxZdr+n+8yP8ir2T/CSpTC1UuG108
         E2iibuTi1GOdEitUjD3mXoCvBrrHFmvzAoGCSXTJM078A/Bcck/dN2AUjhqTdujgR45Q
         v6sw==
X-Gm-Message-State: AOJu0Yy5iBDBf51sWmPxffiOv4cgahDpH3hOY30NZrOb1Q8g5g9IET5F
	FPK5kaOApquwnYS3T93hgovYz6mnayHn7k3H+WKdvxmB6HlNMDVsPvwe3HNP
X-Google-Smtp-Source: AGHT+IEN89lh8epFo7LGiAkCHTrls24r3QNLLB4AMLAcFXH+B67ZFnBYFvAjo4G4hueWMXAjRHcXnA==
X-Received: by 2002:a17:902:ecc4:b0:1dd:8f6:69ee with SMTP id a4-20020a170902ecc400b001dd08f669eemr11630630plh.20.1709817453385;
        Thu, 07 Mar 2024 05:17:33 -0800 (PST)
Received: from [172.17.0.2] ([13.88.3.84])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902e9cc00b001db9fa23407sm14574207plk.195.2024.03.07.05.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 05:17:32 -0800 (PST)
Message-ID: <65e9be6c.170a0220.30a15.69e5@mx.google.com>
Date: Thu, 07 Mar 2024 05:17:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1511167097807509601=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, Joakim.Tjernlund@infinera.com
Subject: RE: [v2] obexd: Install D-BUS service for non systemd
In-Reply-To: <20240307120033.1327905-1-joakim.tjernlund@infinera.com>
References: <20240307120033.1327905-1-joakim.tjernlund@infinera.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1511167097807509601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=833367

---Test result---

Test Summary:
CheckPatch                    PASS      0.25 seconds
GitLint                       PASS      0.21 seconds
BuildEll                      PASS      24.09 seconds
BluezMake                     PASS      721.56 seconds
MakeCheck                     PASS      11.52 seconds
MakeDistcheck                 PASS      166.08 seconds
CheckValgrind                 PASS      230.03 seconds
CheckSmatch                   PASS      336.05 seconds
bluezmakeextell               PASS      108.78 seconds
IncrementalBuild              PASS      669.70 seconds
ScanBuild                     PASS      981.60 seconds



---
Regards,
Linux Bluetooth


--===============1511167097807509601==--
