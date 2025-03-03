Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99878214A7A
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Mar 2025 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018333; cv=none; b=Q4jBxgRn+CBZ/ZrXTe61mPpOaZxtMbvb54k87O9ublCFGM/Yag0egclLNCia7czyBfYAOWwC6ZtGoyHeqf5eZ6symOgpC1rZpb/5yx7bP49m5fkj1yI1jlHhdM09CxfQpxqEZvRnhjY55VJg9yxwnEoZO8cUcV8n34uJIA+jpd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018333; c=relaxed/simple;
	bh=Mmkh2bIJ2uqJsK/cvlG6QwnGcaZdLm1xin7uIx6Se6U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tAhQ2Zx2YiHr6X9G/TeaA8hNZbekP/t1u/thcnOmtsGLzTJrrllToBD3j1rHZMYs4dAkOjTTvYu2zLUeUOn9+/OO0VkgPiVfphacR71XNmMXLZ+aeJQkzcUMWGeMETHv5ssAV4GQNZY9hMeywiyhFVAz1FhdLdGKl+Z1Xzecgaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8o1Sww6; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8o1Sww6"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6dd420f82e2so65595796d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Mar 2025 08:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741018330; x=1741623130; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X7K6JO+QKx7s64/6mbYLWzCMjr+i+BKG5apU7m8q0mk=;
        b=f8o1Sww6H7nd4sO8FVZU9aTyeJ33GmPx1ILRwo8KuH8yXWEPJ/IHV44FqSpQQ4c02z
         wi73IgSwFR7LYK9Fu+6y3Cqdv88I4r2KLz/Tk27mFuX7ePGdc6+n/aAFgW6JlZNu9MAl
         AEJn+H1ARehJbbGjE4rlQ9paIh+ASOLBIHhXj4+LI7uNrsq2cawlaGtXqEY+X4oyvb/l
         WP8NFkSRp/QNqXlVsrnVvZp8s7mMP/lTJxgUqUol5W05KkyGAsSz5AVxpW+vpPfAR4IH
         PAW60MbaaEgamjOdSIn2/LQH8mmAd+q95npuUujJT5iBKeg7Y4zLjojQxanraB1+M45l
         XryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741018330; x=1741623130;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X7K6JO+QKx7s64/6mbYLWzCMjr+i+BKG5apU7m8q0mk=;
        b=HPVJ7YEXVHdZ+FXSn/rgJQepQnga/h0x0vQE/EteHn8cpe4gOj2pgrODo68mrrsx18
         Aioz/A/9RANuzjFT4bazvZTuzRLoTx6Dzi4OzJQFF/sRBPPDDkPfbPI1sKhInEAYMMUL
         1uh0XhX258FqewWZTg78hzFlDDftrMl+Gmr3VgpjEonBfUJ21d4CPL+0/14tl1ca6TDY
         NxSdQnD2FCRBJtMIwAU6iYYm29yUPSZgMPeqTnr+T6K/WSWeY5K7Uhdblm4+uvHZZ3wl
         nUP7gUMuKhaioK8eBr5owm5McmpTsgXO4279TnfEv1WdiyljnJxNOeD3ng6rnwyOftgf
         vCVw==
X-Gm-Message-State: AOJu0YyfKF4q2orLtF2UfXzq6J++9NclfOqYLXDdpKgBD1z26zSBymth
	TzlcFfmm0vsFEDA3rJaZ9zXFZnlmQHIzeNAqZ3QxmHeBCRO0WMpIp5KrWw==
X-Gm-Gg: ASbGncsGlqukuW9RSDdvl6wJdaXCHTYxlZdcH8bfwewrab5CSX7rXhD1Db36AeD4yM0
	SV9wXSjHn3adttxUSOUsf32ReLEGbg/eUNmKYLGL5T2LAUkoMRuew98b5ydMpIU0LzVRmdeS6i3
	g3fgEeLUMtFQiG6EMVEbAwOeFkSlhULoiZCHTbPs4AuQ8dsS8l/kM40exKgoJY05rrxObQztvBk
	CpgVFilj2FdUNih9fYYA1d7lbc8wErryrC01Q2MwCaA8Z5IN1wq/1KWBFDGQCodvQqhs4di6IWF
	ppwNTraO1B0ip8J/F+twi3khm8TRB1ce6sy5cfM8MVXYvB3ubA==
X-Google-Smtp-Source: AGHT+IHjcfW1w1fwZ3tXnFUA3qFHz3Fu1It16h6k1t7BmCPOVvvlEI8yoK2gFxV9yhC8O4yAHahO/g==
X-Received: by 2002:a05:6214:2687:b0:6d4:1680:612d with SMTP id 6a1803df08f44-6e8a0acd1f2mr220307336d6.0.1741018330179;
        Mon, 03 Mar 2025 08:12:10 -0800 (PST)
Received: from [172.17.0.2] ([20.161.63.97])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e897653667sm54535716d6.32.2025.03.03.08.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:12:09 -0800 (PST)
Message-ID: <67c5d4d9.050a0220.35430.3481@mx.google.com>
Date: Mon, 03 Mar 2025 08:12:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8200297354596923233=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v2] client: add input validation to main()
In-Reply-To: <20250303144844.60025-1-r.smirnov@omp.ru>
References: <20250303144844.60025-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8200297354596923233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=939649

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.23 seconds
BuildEll                      PASS      20.40 seconds
BluezMake                     PASS      1500.02 seconds
MakeCheck                     PASS      13.06 seconds
MakeDistcheck                 PASS      160.76 seconds
CheckValgrind                 PASS      215.10 seconds
CheckSmatch                   PASS      283.51 seconds
bluezmakeextell               PASS      98.61 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      874.53 seconds

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


--===============8200297354596923233==--
