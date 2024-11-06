Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3AB15383D
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Nov 2024 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730911549; cv=none; b=IsJRMVIuLEGT1Voo5JXuZk+gbhNfV0ZSbn4z7ZuwzFCMtzoTrkCcNK4YRQz+08JiEpFqQ2Sn7PgY461xo4xnWRYUBSxrP2x+uik92kGcyYhfxQexwqilQQM3xa0p+TnkqA5osAKvf3kB/faWQofX5Uyw6A0PYMTNP/k2YFhT3kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730911549; c=relaxed/simple;
	bh=ctYvfL6rFKD+9lO6S9htzIcaDtQOBk3prlMNgEp+kEk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uzbbgmRltK8PpYiLPTIfOKjx2Nj5Bg7x9wnk8MPiPKqknr7TgVGUX14hHRsJO0oYkujUfKS8O/azvJgzIjueUHlh4up7HouRs+OTqVwQzEvYbTw7H6Gb0wJlK1VirmSrsuKX1XQSKYYeQNtbWlJV0svbpH3ev+6bwWf431ZNGac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hx88pMkR; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hx88pMkR"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ede6803585so886008a12.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Nov 2024 08:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730911547; x=1731516347; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5KoMOrkqcGXHMZkQscbQIRltutLKrEggRqw+H0/d6w=;
        b=hx88pMkRVnlxUL49pir5JhX29aDFR/guFUrtJsDLbr7EON3yyyBGvLhmWVhmrfxZUH
         zhApy7vVusJmjAekJGTndBNvSkVlFcxCNgZDagpQGHePpSQiZZen77rxcWA8JL6wx/CB
         m1EiEBgWhZDIzJcPTiNjgXFgmssWuCNy3gZK8dR3rBh2vqqnbOfs0TIPiExXyJxsiaw9
         9LoipDJW6btIY7JxJ1wEcJOLYXZWaeWzFpsayU/UoZ0AtzZjqoDoZV1falejaMCRuEQl
         Q+cFyG7jFSo1P12ZIs4mQoVYNbFC8SRGcjAS2+3+XtJ6KgatbdKhlFbXmRcTFAOyHb2p
         g7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730911547; x=1731516347;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5KoMOrkqcGXHMZkQscbQIRltutLKrEggRqw+H0/d6w=;
        b=UBpold0Fu9dhADOpr+Y14+jKn67KLr8h2LSh6DNTm/NKAaFHiBZPnPXsln+FzjDeek
         IVZs24BAqX+gM0oNmrN666Uhinr6Xrj8K3fN75OLh4UoqI1k+j54503Ib+TtTQ8ZSIO4
         JHXfsAzjG+FIVRyBmAAubC4tEf5lsrw1QiXSYiR6ts9awMaZ1TcdKI2T77LBWQysZ7bh
         KWQMmGJ1ANYizFg9mAIzbw7Y/DZlVle/hZvtdDSBDK0uTun+9wjFpMhHcdBT1mdMhHqT
         fcBvC9WhMygexOB/Bb750R7oWd8ZpFr3TfIVur8w/bY3hsaR2i0OnPROhxBRH4hH/pqT
         ZlZA==
X-Gm-Message-State: AOJu0Yw6A+r/K33wkMzH/VFRdSyyQ2PCtTjkIWg8DA088lq1373HyFP2
	JCnROZ7G2eV00eHvNGdELTSTNiW7rv6uYXbuKs6it9dkrtIujm+9+wB4Ag==
X-Google-Smtp-Source: AGHT+IETmbW1Y7+ywW6vwPA4xs2D7JDXyPRNNu/AnEAx/ZOMhyQTHqiFkhCu+fdvhdV24P967/H1yg==
X-Received: by 2002:a17:902:ea02:b0:20b:a73b:3f5 with SMTP id d9443c01a7336-2116c88c75emr52659355ad.14.1730911547123;
        Wed, 06 Nov 2024 08:45:47 -0800 (PST)
Received: from [172.17.0.2] ([20.171.46.109])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d43fasm98564725ad.265.2024.11.06.08.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 08:45:46 -0800 (PST)
Message-ID: <672b9d3a.170a0220.7b874.1ff2@mx.google.com>
Date: Wed, 06 Nov 2024 08:45:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5355158149127995308=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] lib: Add IPC bus type
In-Reply-To: <20241106145100.42889-1-luiz.dentz@gmail.com>
References: <20241106145100.42889-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5355158149127995308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=906986

---Test result---

Test Summary:
CheckPatch                    PASS      0.30 seconds
GitLint                       PASS      0.22 seconds
BuildEll                      PASS      24.76 seconds
BluezMake                     PASS      1678.61 seconds
MakeCheck                     PASS      12.82 seconds
MakeDistcheck                 PASS      181.02 seconds
CheckValgrind                 PASS      253.62 seconds
CheckSmatch                   PASS      357.36 seconds
bluezmakeextell               PASS      120.97 seconds
IncrementalBuild              PASS      1596.93 seconds
ScanBuild                     PASS      1024.64 seconds



---
Regards,
Linux Bluetooth


--===============5355158149127995308==--
