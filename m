Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795519311;
	b=1VxlZhN8esCk7AHdpRpICrgC0/s/LjMkDIJ91jGsi0T99vnfQUisBepuE7VRzCtlb37H
	 OBK/MPlgGwZzAI98rDMXR/Zn2NMR3p68PE+lxV7yz2TNHWyIXT7ZDQ3yVhU0OMZbGwXf2
	 pGd7lx0/oKchMJFCC1lJiNPB1vMBY4fHMTd05piyLzdCbhYCtMufIoArELIk5bkCnP+IU
	 Uw6tKiuco05/u7Q0gRE37Qvx/RSwVWMK1CgGWg64ZsBawHpsZ1buPJAg/EgBdVxqDlRNg
	 w2yj1c0sv7w6LpgzgG/VBA+n5RQvBq5AAcCKdbleT+96Z3cVzgmfoHY39r7Nk7/PLqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795519311;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=uhbHLDbji1jFgGQfXVpv0XR01L/RqcLA+uWlqbFM57c=;
	b=tVxmJULLI/3zWH9pDWb4HpCuleKGBgXpgShZw07gymDtoofKDiUUlu/9Cld5JQEruMPE
	 xynEsvtD9lSHxIoyZz0vYpF4OumN/z7oXKYWkC8UCaFxfeY1pUcwte40vZSb1kW0KSapj
	 ctzKNkqb2iujm5mIHqGBMpxyWUmrP0NxfjICQoLcOpP85WdpZK6sK+5OrvvZLTk/he94Z
	 LMFpWZnEgJ8R05CQiWSfvfPcoRpgfxa49Xp70IqHEsrH7Y7Fyh3TmM9NBk0aHuDWDg7S5
	 +VKlqjyrSQhfuKu0UHjMF2M+xmzvP0SOj9FdIcjOPTBpPuBWNrGgcZ3yAVJOS9KFNtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xNYBCnaJ;
	arc=none smtp.remote-ip=209.85.161.52
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6872A606A683
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 11:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6872A606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xNYBCnaJ
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-71ac9e15640so2773404eaf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 03:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795519310; x=1796124110; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uhbHLDbji1jFgGQfXVpv0XR01L/RqcLA+uWlqbFM57c=;
        b=xNYBCnaJmutPjkFQoQM8QdD1cShH1QOObMmHINpcPMY8mLVnu1JQot7VoWSh2snwLz
         vsemAwmNT42BqSTIf4lv/DMx2eZbSTINHt9FzQPRUcDxlnAmV7qCDTcOk/Fhbt+ck6J4
         j9jPIN/gM/4j8idbl8bN4XuwRTxIIx32IFPLCizHM82bzktXvqJOMJOO59EswsEtD7E1
         r5rv+j9h/f5lUjYJRnIBz8GLeafE0fNBnorBxiVHiXwOcIf5JJ35UJQv1g8kXcOmPNwB
         cBTythD8yZVjfDvgS0CgJMtD7NJETmn0inCn34eGlS09oD4u+5NYylGXyz/Y6gE7RKij
         RKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795519310; x=1796124110;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uhbHLDbji1jFgGQfXVpv0XR01L/RqcLA+uWlqbFM57c=;
        b=R5PtaMwIXhvKSGv4bXWHRZrFoV4P14dC1HrSQQQyKTkjnHbTNOYcm0k1ShtnUyiMg0
         yst+rAJ/3tGHUBr/TkAEz+wo6CBn8k35WXw9Wa1/LAZKNGfXREsUvJ9IGdWC+kZMGXlp
         QjdS/5bnPmYeiFAUnetOBCBlc+M9vxfj7PIT6GFoaJtUSgcMWlLlDfQOWuVLUPGYv7Vx
         fAXkxpvDVpLGkVAeD3xj+f9zjRlvEvCjzZYL2CCvE2Lp1sKQLyZlHOeqmcMf8nwpOIng
         dbCWBzdREt+hZyshMukMytOiGP5jcPyeOOgrn6RPnnaiBNY3sSv3kGLJdKm/a1G78tSC
         bKrg==
X-Gm-Message-State: APuU4Z/ukWVh/OgkZ9JevibEZWluKvPQ7zK6tg0t4ylkoBNBVddB/nrU
	Ljd2Z85cFFTWElxDlrvi1z2Q+4IcSCdvI3pvS3I/jzVnm4Jk/nKvSHQ3Dg6gWQ==
X-Gm-Gg: AZFdTZf1ikwG++Jj5jMeW8OISBNrASTO2luzsxBTUJBSUOq/2f7E5Zcm22ycSGD2jAB
	woj7qrGH0WJyZSQW1lwbxLhf5g45QHoIcknnzFOdpG03FKq686KK8cMjail/qLMLxQ2/O6j0j7e
	LpjOfi8c8iTBkVmrOWxeDc2sjJsCNqjQV+oOjZVaeHZDlVvgKErwUW6wTLWFXlsEHgTOTKeZS/Y
	JBoFf4lm3AS9ZhUzLvTe4m0r/aS9rwTDvFgxXBCzfZedAYU6cBdEjyC12vcg+Mnbd1l78Yu9L3a
	fWz/UZRo2hBj3L6/7heuhsNExnUSHgLbg5b0eFc52i1R+z8Wr599vmI0XWT4YR89aXQBw3y+EPa
	4VSUXNM1nwZW5Tk0LeDqRcycJaWCIN0U1ES22znPSIIDG+jK0pUMYEP8UFLAkMngwfwHlY+5ymm
	WeurPsx4gxnzd4yjfMlPMfoh1JmyOFRNN+EewAYRr7AkShmC12GckxIouLmgmHFx5SfOfEHf16g
	EYgDM2jlkyec2C36I0ZpHUhISBhx5GZYZqX3fkDNtNwO0G50xd3z2kYDpVTLaX25kt/7eiwPkaf
	sjn9lak=
X-Received: by 2002:a05:6820:614:b0:71b:410a:37f9 with SMTP id 006d021491bc7-71b410a3ff9mr10125447eaf.27.1795519310265;
        Tue, 24 Nov 2026 03:21:50 -0800 (PST)
Received: from [172.17.0.2] ([13.86.110.47])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b38015c51sm9121373eaf.3.2026.11.24.03.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 03:21:49 -0800 (PST)
Message-ID: <6b05734d.a3ee09e6.ab514.5d77@mx.google.com>
Date: Tue, 24 Nov 2026 03:21:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7438766304636220551=="
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
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: asha: Notify connection interval changes
In-Reply-To: <378719dfbe498086a4af54cca7b8808e09b5132f.1795489294.git.cochcoder@proton.me>
References: <378719dfbe498086a4af54cca7b8808e09b5132f.1795489294.git.cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7438766304636220551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1220324/

---Test result---

Test Summary:
CheckPatch                    PASS      1.80 seconds
GitLint                       PASS      0.96 seconds
BuildEll                      PASS      13.56 seconds
BluezMake                     PASS      185.11 seconds
MakeCheck                     PASS      13.05 seconds
MakeDistcheck                 PASS      108.24 seconds
CheckValgrind                 PASS      243.29 seconds
CheckSmatch                   PASS      181.56 seconds
bluezmakeextell               PASS      62.71 seconds
TestFunctional                FAIL      932.97 seconds
IncrementalBuild              PASS      196.23 seconds
ScanBuild                     PASS      631.84 seconds

Details
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bap::test_bass_past_earbuds_transport_acquire[hosts11-vm3]: AssertionError: Failed to acquire: org.bluez.Error.Failed


https://github.com/bluez/bluez/pull/2891

---
Regards,
Linux Bluetooth


--===============7438766304636220551==--
