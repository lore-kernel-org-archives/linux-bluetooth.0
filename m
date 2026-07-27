Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3733035674C
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 11:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785153266; cv=none; b=ZrAMQhmLR3LODu1VWo1/AhtqUP1xfpFlkJWIHIIZmJmWtrYvR5qDHp0IWpsEFNM8l9OeMym+SPtYOQEk9AfI1yPl/v8WUSg4yv0m+ZcrnnNB2rA4SH6a3iOnbuObTbptS7juy9rSmdwmIFeVEFwdon+sOlh6Ei5kjl1vzTVg/lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785153266; c=relaxed/simple;
	bh=josLFeofkVi+uy69Q68Ypn95Bg+mi14hYnyar9ZZaaY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UiejgTm78WcFI6P4peXtsopiIXA10iOKTXIX+fJG/y+HcyZUtBicgvGkIjIYEs5RQoaLNbqY3KGAHBUA4lSvTSRcxIwtjDucQ9G32u+Poj54N5/BCq6h475u86hyJqCYTrVykZ+lC+/PGsFDtM12clG1ZcJ5KasE5URvAMBiC4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0J9ect1; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0J9ect1"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84e04df8c46so2579753b3a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 04:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785153264; x=1785758064; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=josLFeofkVi+uy69Q68Ypn95Bg+mi14hYnyar9ZZaaY=;
        b=J0J9ect10kah3ZwVqJqkB/MwHrkQVEyBF7Au/bSb7gvkWr59G2mYY2+5CIMW6BkWL6
         jLnPUlmZti64mmkIhWFGk3AZHs0xgy/CAPoIkLHhmCp9pGneTuTQyCpoDNB+2I6nJUPM
         NCjcsQB0Acaesnn4VFhM0LYhXY4b3R7Goi8aVJK41y0L2Lw18Mw/1w3ehuFgbpHO6TM+
         Vssnt9PpM9rckS/NFUn4LNmLbR/nYhvRnH+sR9fko003l+Y2wJQn7LzVmNpkLsTX+9oF
         q7Mmp47+rDkbM5nMv4rZjibbpbokocgLaTQd3DK3LIrMraSATtI/1/tgJwlTPT1NnLNf
         XPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785153264; x=1785758064;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=josLFeofkVi+uy69Q68Ypn95Bg+mi14hYnyar9ZZaaY=;
        b=OYH+WoIhNsgWb6YUQG+5apvqdq4AQV4lafm9Q6VEOtx1mlNNuNH6alxMzOaZVfRcKk
         PQb8PQGVxy90AjuL2RL4KBln93LktdF8ejVdBWlh+Mf0oHw4SD0iNVR/aci+oTaUzN/d
         amsnVdwrulipVX1h5pXK/ppkHLUba4A4WCzNqO4nBem58VCxbdJGdOlzmKYvVIhJ6w5X
         YtYLNJO4q0wbzFpyUiB/Q2tH+uKk/NeuUYfDM3ieo/BsZeLxq5eqtYKwjSls03bxVJRF
         3o/RYZY14ktfiIgKbDEUSTw7GBV7cNvUl7m++L+x0ub3IIjEEnf2TGtTQA2129hZ54EN
         SVTA==
X-Gm-Message-State: AOJu0Yyhd7V13kN/uaGkspfZdrJkrCY4t/jcE3CJe+kOwXplnUGzxJs9
	cHHBtUj6MBtwumjpheEZiGB2cP86IHnKGMCPO+R9rAZrkPSA4kekEthT57RhVrRD
X-Gm-Gg: AR+sD11hDutO3Qs1ErxKW8/zaQ6X+lWP7tC68ampvvw89QtU9KVX1yJX7IqEZNK/+ph
	4PYsJu/Dc1J8uE/B+fOGpP86YeqDrJrtsKO0y3PAtpjZmj1TmcYlJCEnxluNPoRYy2l3o6zLjyq
	/meUaZnIkJJmtK7Mz3Fudp6Ady5HJhWN6t8XtzSIBPaGXoVhbRKGUrldV0bR+/UVcCUoc9uMORU
	tKzdl8gU+n78rIY33s2EH83lRJfhyUt2VANr9MkDX8jcwP85D8MEC/xfLByNvaXeTsUf39xmyNp
	f/yOnWt94r66JYkFOYV6IBi0vqd16McLXfrNB0aRYPJm1DEQAEghQdOdVzgiiMCz7LwoG9NfBwQ
	ZhL4OZECtRb9hVk83gXRpuPaWiKYxV4iQdEZoSwSrkKoH82pIlxd2P453DGsmbLnmsVAuD4w5JN
	Wu6OnrCp3f4YpG/n+K9z0=
X-Received: by 2002:a05:6a20:c5aa:b0:3c0:9c1b:d0b3 with SMTP id adf61e73a8af0-3c67e026f9dmr7808751637.62.1785153264462;
        Mon, 27 Jul 2026 04:54:24 -0700 (PDT)
Received: from [172.17.0.2] ([52.225.78.140])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb6622461sm3031660a12.8.2026.07.27.04.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 04:54:23 -0700 (PDT)
Message-ID: <6a6746ef.8a854648.8cb23.ca2b@mx.google.com>
Date: Mon, 27 Jul 2026 04:54:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4869021606453576889=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, bartosz.golaszewski@oss.qualcomm.com
Subject: RE: [RFC] power: sequencing: rename pwrseq_power_on/off() to pwrseq_vote_on/off()
In-Reply-To: <20260727-pwrseq-vote-rename-v1-1-a2029aeeac65@oss.qualcomm.com>
References: <20260727-pwrseq-vote-rename-v1-1-a2029aeeac65@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4869021606453576889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/power/sequencing/core.c:966
error: drivers/power/sequencing/core.c: patch does not apply
error: patch failed: include/linux/pwrseq/consumer.h:20
error: include/linux/pwrseq/consumer.h: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4869021606453576889==--
