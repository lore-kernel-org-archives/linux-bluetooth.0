Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78804570FF
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Oct 2026 22:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791757073; cv=none; b=nWSXLANYYvPOn8A5reaK1WdrvZisX2zEnliIhWCYeVAioBFryURY0CZeQEiI5VralaYSRhiqoyGfucUcNm+ZJ0DMtkYosSBF7YYrUyQUR7T7kpOHDPzK64qF6Yv4Kpx7dWW34DHvo/5ZhvIzshbuRdmxYhF/PnDemgG4HWC0j1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791757073; c=relaxed/simple;
	bh=zV6TC89BdGuMaS2RwIsBSfZX17b791IgXDO2bOIUR7M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qBSG+SoV2/tf5bXfIglJ0ek+gqLSdTehPlA0T5O+ypfOZ0hLSN3RENO2GjssHCmAsP3cvbByLo+Fasb/YYye0xCxLqm1hUHBJaCGj1vPLXXKupNuceQ6yYVr0FAXmbSFrHct+vDZFnUrZPh6Pr+tDA3N+2OvAsNzSEzdUhG1Ng0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvHP1UrO; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvHP1UrO"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6dcf573c429so901816eaf.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Oct 2026 15:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791757069; x=1792361869; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zV6TC89BdGuMaS2RwIsBSfZX17b791IgXDO2bOIUR7M=;
        b=bvHP1UrOk+QuQ4XUxiv0Pq3L6xJ/K2u3zKqnx2dlJgtaD4O/iXwIOdevIkdPaiMW5L
         jftCNNResXKG2eAUtMIvWwZSdu1zXUoPWowOSN5L83bN6uCPQCBDCHfdpmhi5uWy6zb4
         auNOzIpch6Znq78/PWbILMLyimDmxc5Nc5U+WDV5kjf0P9lfvTIXktsFfBFJE48XXofE
         BK3kQbLPKf305AcNJhQ4ixWw0t5UniyfwYIMADQdmy8eEHIrzM7rSb2oZcWXIdYRaM6D
         jJeuI24t8vPvWtmGQVBzzxB4f7VzEjCCK9Rop4xDMUaHw2rewSpo57qrQ8SXn1B+bA2M
         zL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791757069; x=1792361869;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zV6TC89BdGuMaS2RwIsBSfZX17b791IgXDO2bOIUR7M=;
        b=dCLjsYg4sngVZRz1wLrRAzcGI5nqWS+JAH3wV4UPC7GLrGz8bdpEO9RHaApK1N+VOn
         GfK0dMjmbyddtUunVDFyjWHUq2FoGfkhC1Lqw3k4bB9Rowgw74uFgbGaO0hqQ8rNKGzG
         QtlVPELeHTxyj46Lvz2unA+swzCWziOc6xQlS1EN9UFZXWSanoRv5ywbkNWU3ezLQGxt
         rzh0AOTvPrvr9Hj+62SvQa9wiZqSlM5UFel9umWyVoEUJZ1br0CY4b00NQO74iEnQDs9
         uGdQ/9wAorEtMoAOJSbOolZ0onXUUHtKXbLaO6yoIXsXRN6+A8AgXnOiOIAJN6Nw59PK
         rIKw==
X-Gm-Message-State: AFq9FYJVf1i+N5P8pe+ec1DSkqwwNkKaciTWLKh1sW+9rwNFIO1e/0B4
	TI8vXKcPxHBQ2I56UCW+ov3EOGX1F01obeapBjhF+XoDSLNpEFbmsiTqigj4lw==
X-Gm-Gg: AYBFou1pQ3UtQiu5R+oEn4UwPYI2TQciNk1WGmkTyQxRGljLld6xmJdZU9Y271uypZO
	vxU7dOif3z1TjSavBM16frMsSD+p0vV2h/RaIGzUyuOsDD2S/8qpVzB2xhwiDCU8P9rmAzo74jS
	Ma55v55s6ftt6brCB+Jk2v9sWbwxJ43FTnJ4S2obHZgdhqGe7To998/caTfNSLUxC5md+s2PXe9
	2kGbINxoeDbcykhwUHyDCT4lCyY+gBFxCL17Q0+gPZT1FcGOi8cfX4h13Aw+is/086eyVNTa3J4
	zFAgJT+X2luyry3ujo2m2edashO1WkUyvyik/rNaiCf90zUj+jL9xWe4pNbYlL2ijTkm3Hf+kAV
	Q66uOdFjUgLbs2F+oIlisyQnD4q2bgGy+s6vXfVfz9n/iAHBKHjxqeO6B2SpMTAgObBT1fF+0sl
	lzrTkFwZpt0omp+ahIVbrvk/TUQrhVFTda0QijuxVWm7599VgziPN5ihZDavHXoLXme1Mjo/ok9
	Xd+8q0=
X-Received: by 2002:a05:6820:1346:b0:6d7:e61c:d5cc with SMTP id 006d021491bc7-6ef08c787f2mr5723856eaf.8.1791757069518;
        Sun, 11 Oct 2026 15:17:49 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.134.213])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83038f82468sm8295982a34.11.2026.10.11.15.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 15:17:48 -0700 (PDT)
Message-ID: <6acc0b0c.3e00a709.b7bff.af14@mx.google.com>
Date: Sun, 11 Oct 2026 15:17:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1746189273427695304=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, me@andrei-z.com
Subject: RE: Bluetooth: btqcomipc: fixes on top of the IPQ5018 v5 series
In-Reply-To: <20261011220919.1816407-2-me@andrei-z.com>
References: <20261011220919.1816407-2-me@andrei-z.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1746189273427695304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: drivers/bluetooth/btqcomipc.c: does not exist in index
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1746189273427695304==--
