Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5A02E0B6D
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 03:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754967732; cv=none; b=Yws0sVFtJyDY42kxi3hk35p5xJ1MAlCC+zQb+VtgyLEmM6+xeKwOaBVyVcyxIzrpKrYMwlJXLC225JYoE1a6NJzuy0chwuaFdctBXqAqRZ6PCjnsN/klFsNtULPJ9NlhZyqRQyVzllmgh6aMB85SSnPcFKCIzg3GvCvl3GSJD+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754967732; c=relaxed/simple;
	bh=bushEHSUt9szsADMe1lWVD9jXeDqLuZmasq53U/y80E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LEVjMN+2PMGI+ieu4pVoBv/b8nHRenf2O5HedUqh9T94VB0AxqWMWNVmmnagGy/hwACZkqMf6Og1aITZ6QYpul0jrf2Q1TaQy8NT13Ci0Jd+B6tnP/YMmwBawCsBHBRd+TcQDRJxU1GLWhH8Ek8EhlvLtAHvdmcEQ7NP6ZbaaPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vs9hgiu7; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vs9hgiu7"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-70884da4b55so52960856d6.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 20:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754967730; x=1755572530; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bushEHSUt9szsADMe1lWVD9jXeDqLuZmasq53U/y80E=;
        b=Vs9hgiu7pBsGbAn1sjwkvsQtXApOqKV+eM6SqLCR/ktcG3LfIYRHXFeFv7WIq+WzV/
         dY2lA+/v0gPE3lgf6IOQjTk6MsN+Q3tEbg8Q8TTJbABXtC9NIYHmYYiSQFfkdyEtGxEJ
         yexi/nHLaW6zWQl5fAoimq8/pbh5wBfnlp2oqYyuZkdoSnT0+sJp72zM8uDx5+13DlfF
         OLf7d+v4eie1zESEXNxdPpEmNwKwhtDZX3LCcrjQYwHiKf49EKhsJNYNSCMtiMmPFlwT
         w+nEOAismnPee5fDWy+OXNSNsi69Zt4jV+PuFpA2836y8Xw6o9CINiiPjKibMPqHPks6
         S3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754967730; x=1755572530;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bushEHSUt9szsADMe1lWVD9jXeDqLuZmasq53U/y80E=;
        b=W90BAMXnChK2md9Q6zqWeadoglGgZT1Nvn7DA8BFVnRr1SHUGHDw/2y2uza3UECr32
         1ACIv35NXfbbPRK5FIkLnfDctsZGIx9coKaQvcss3EdLQMZlBN8336/xgQt1VaZd9VO1
         Z5CfA/mUTmY9iEaroDIcHbz+EsNSvX+HNjIdpJdh+EigArzm+SFeiNHMJ79nEYgtUWhB
         k2lbL44/VPfCjmVhb37spYFCSNccYClb1pf4nklDD2SjmZnagQZzoPz9T8DhosHdHoSR
         bFkOEgZcUkP3kHMxll7wn65mh9HXubQ2Yfxk6pNKbSlBQym7MGsf0zEfl4pcVTRz3kvh
         cExQ==
X-Gm-Message-State: AOJu0YzHcNKNcJQlP4/F0wIlPlf3Su9gKQ60XjWHCPTwTLBPSubwVQqK
	s+5EArHv2fPOhrd6sSdu1wi18JSiyVusMwxSMQFnL7XQDWxqObklJJA83ULzQOQN
X-Gm-Gg: ASbGncuHxgX9cLEqb5RPBHpK9fOTw5IoT3cFDVo+ugsHYa/FZ93CPdULlshlov9hdhZ
	gSbsaGHisPcbv4ViYPWaQrKdrXe9cIuyW2ZQPtON1cfgWcMAxBtMR+le+LI5btDQ56tLip/sTla
	epvYAO1HX2pL1xWomXSy2Ia8wpcy+SFkQA2Y1iYkniX6gx9dlpL2DvCOYJmeHrWNBruydP0sMfQ
	XZGr5sq5V+xsQzaCYq71pa7B6/iv0rETeod5alyF1woJdcJYSj/VHoYF9FXMhJvQmpoW79SdySy
	62RZxOOA78QTCTHCX5NNr1XCAIPlsR+yvRzeK3fQNM0+c3G1bBjRUoezNDA0bS9zDE6Icc39wX9
	53MFXJoCc+7UKuj4vbYg7erJSN7GoHL8=
X-Google-Smtp-Source: AGHT+IF4JTehkyBbF1SHEGImjRauKysdc+wT2T1r1WC1GvRewFhp+UgJ9av1W1AusFjyBBaN7s/mnQ==
X-Received: by 2002:a05:6214:808d:b0:709:b700:c71c with SMTP id 6a1803df08f44-709b700c7cdmr125933586d6.32.1754967729565;
        Mon, 11 Aug 2025 20:02:09 -0700 (PDT)
Received: from [172.17.0.2] ([145.132.102.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-709bfedf92csm36989316d6.64.2025.08.11.20.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 20:02:09 -0700 (PDT)
Message-ID: <689aaeb1.050a0220.42c12.af77@mx.google.com>
Date: Mon, 11 Aug 2025 20:02:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9206195760967370756=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sumanth.gavini@yahoo.com
Subject: RE: [6.1] Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync
In-Reply-To: <20250812013457.425332-1-sumanth.gavini@yahoo.com>
References: <20250812013457.425332-1-sumanth.gavini@yahoo.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9206195760967370756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_sync.c:5525
error: net/bluetooth/hci_sync.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============9206195760967370756==--
