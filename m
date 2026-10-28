Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793185256;
	b=gQRQpN+h2IAxwxpF6vPFWiGnC2gLo4kvgulxdIejeZEHR8jxiqLdXBsp/4Lt//lUJ7kV
	 ktPxHFU2rPEBlVQrBDGnjEn2bz9QDpCWUOd8wc02YnOP3QoC1uqX4g//EFN/8ZHjq3BXK
	 ADF5CWsWtGR8OibzP8SWlG011TgkzNXTRhsEKI2rdWKe9peHhmsv/pGAfwZ4lHVr44BDW
	 DcfEjXV1Mrad6yeX+8JIoGEDWii6oMUQ43JWSBUQzVF6ZIXICLydAXYBb+Z3XgaFyWGub
	 UiZr+aJzAGijltu3DxpRv76LrtduFNYXR96dXuyOBdlUQkOKcg05cXQ+ceuUJ0gEFnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793185256;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=VAN2JLXiVdtggCB4Z4MBTUK9lMN8Jp+OnH9Ejr3SruE=;
	b=GNneuW59rvtjDy8BHzfpTo3JE8lJQdsoWLJBpT3v2A/KqaEjoF4qbo7KwKqxDmBAcx6+
	 YT1t+khxqfBeAZhpj4W0QskdCwAibtjitHx7HmaM5zHKkEtuDjhGs2CARdvVOb5Wb5LMW
	 n2jI2CugiQJkkJkgak6nljIm1okNbMrz8NNxCiWjp7EkQhfX6Cam8YAI2/kFY1Kbhj4L1
	 /CJ2oUTrDqcgbSXO6B1IUzNWRC7j7ZZhe0F+2cAQ9dR5ZKDAWzMBbIUZK3Y1vcLn4+pJN
	 QgvtF0vJoq/ljReDTBeWkya+Elh+ypfF9V2Cwbdh0LuviwXl9Rv12ozX03R/I0uHhJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fRXk9ELU;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6740606A324
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 11:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6740606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fRXk9ELU
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-843cf077f10so970053a34.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 04:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793185255; x=1793790055; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VAN2JLXiVdtggCB4Z4MBTUK9lMN8Jp+OnH9Ejr3SruE=;
        b=fRXk9ELUK8Idpo3GShxNNj7KDaxjrulIzcjRJpyV4l4dbFbyKM4bUprO9B51t5pimI
         EivxIO1vRq2MHVsKNm440NyNZm6YdojA0esbIpOT2CbAw0MBb5y5PLo1AM4Pd6L066I7
         bHHuAV+q+yNY0vFybfRZmb+XzI2Cne1XNrnTw7sEzBFKMghUIYrzAkEMcltSZx9GTwXl
         nkGbvOCHXOput4Z0kRcEkMKFOk5C30nfQZA453qU02GoFLJTGcwBgSrnvNiGYc3T4ZhD
         Gpg02h+jN2GYnjtP10DfIzNJAq28/ra9MCivO7VysT9Q7pFKVjj1/GGoPLVO8tKCsbed
         zQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793185255; x=1793790055;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VAN2JLXiVdtggCB4Z4MBTUK9lMN8Jp+OnH9Ejr3SruE=;
        b=x702sV8xwN8tFLbXhcsSl6YqEdnmFQeavKUfDj5Xw5eaXlYzhZ2M9RBAg6+XYT+ZNR
         dnayN05q6bAYq8bS2x2z1+Dbz4A4pC1wc0UN2u67Z+64foHgaiODJgcY0ApK3XkmdbDS
         ZifhKeRKESYzDZJ03JJRDExvY+4QCa+/WFvo3BSKsT2QuCLussWNtuJMi98rXa3upNaU
         dgKy/oJTeiOPKaa8I2oC7vJhHPd+oe4PuenHQFD5v65gYduBfaF3Yk6oUsXpyzTmo+zx
         SF2khvSO0WGXs/fibeEyYk09XM0vMM3RUwGUOkV2WzQg38acBt8eRCtYkaq1ONcb5Dhj
         tpmA==
X-Gm-Message-State: AFq9FYKIXjSvBtUNh9r4KS1Logjnn0qMErb950BdicoTudQa0T/JxPpH
	OHDMKNqjovLmgwucWmd7dWmZpoUKozurJ1BgGB9c4i4G7JLXLREvRE5jz9I0KsVz
X-Gm-Gg: AYBFou38WQsicdnTD4rFO5v1p0/E2ubIEVuC+CEfmFOvMAKC7KwyOmjvR1YsyX/trMe
	nfHhjFDJ4lI1V1C+RcIhPLh+b5Gfb3uas5EXxxU8viMxFjhI3Hv92e77mx2d5WHrLS9KGRf+Sii
	w+i0z5srtC0LjoFNJemvS3boTMc3HgF1b6LPJSTSAvJZiVxPil948tXxb9db0O1i1/MTmAh4yRe
	JZt5r3AyYjIfBYEFl5algDAMH3O5t3mFzx0UPX5YpUhf22eiSkjbuwS8xW4ZUWTRj9qswQRQfdJ
	pxvjxXebW2VPnZlm31Xhskpus1AKh1qh2sNDbSYoUZyvjJpsnm3Pd6XG2q8ca6Zwe8eoSAH01+j
	zIq5BhlU7vQLIYAnqHKiHOgt9+dwaY7gzZxqGmrnZKG2O2gwchBaqTzsDtL0XxGevsNDHKdYkBf
	oKGN7WHPa7vNSpHZcBx+C5LoLo+rcDkZrt8wXQHsgl5ub95OEY/n36mLwqmkHRk37JfVfvVwNB6
	waGBXJrDEs6Cz73eP75byu7OZWQcyDTVvvq1RT/DDIBUKiNjfi5+DFWPex/R6A=
X-Received: by 2002:a05:6820:828:b0:6e2:4cc3:b142 with SMTP id 006d021491bc7-713f0baff78mr921475eaf.29.1793185254701;
        Wed, 28 Oct 2026 04:00:54 -0700 (PDT)
Received: from [172.17.0.2] ([48.214.149.50])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a8b7979514sm1997918fac.17.2026.10.28.04.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 04:00:53 -0700 (PDT)
Message-ID: <6ae1d5e5.3d33c982.a4cfe.6507@mx.google.com>
Date: Wed, 28 Oct 2026 04:00:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0115188075432305504=="
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
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: obexd/bluetooth: Fix profile registration race and clean up
In-Reply-To: <20261027-fix_obex-v1-1-3d91aed181b6@oss.qualcomm.com>
References: <20261027-fix_obex-v1-1-3d91aed181b6@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0115188075432305504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: obexd/plugins/bluetooth.c: does not exist in index
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0115188075432305504==--
