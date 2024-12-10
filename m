Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067722046B0
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Dec 2024 22:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733868932; cv=none; b=ZKv9sQchXkmv21s1S6CZFkL0nbJSy5DIYhMp8foT/w5JolJ1RZI2ZWPZ7jbJdYdb4oZck8bLRGa5llPybZA49LeuxIn/vrYzuyY9UxSlY5Z5rIzemQtT6ZceyPTxJaeoXLYcjxsLWErm60aoHmQ1x26W4EJJpQ6I0AD7Wir1wXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733868932; c=relaxed/simple;
	bh=iexj35VEw3PO9sDaoRB2DPXv4caCta0ARbzw4n9n8do=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=h6drlmfGI+hwYIZaRHDueVfvzG5vZlWh8BS7LURMVf6WmIw+Bpt0B/N6s68ct2wNdZNGsA65Qj7WJJNzNmXBd8jvdH2yGPmzLIrenQ4lgKz70fS2BYWQKFAksfQE/9nEydNL9e9UEQ4JSLUSpoXuTTuzVb0DxP14q9Ex38d3C5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mn/x8pN0; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mn/x8pN0"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21631789fcdso558765ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Dec 2024 14:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733868930; x=1734473730; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iexj35VEw3PO9sDaoRB2DPXv4caCta0ARbzw4n9n8do=;
        b=mn/x8pN0VQz1Nz7dHdg9OL5I30f4kfWg0IqCKHVjNFrnOR13xA9badLBQrgR0eaHiu
         YaWRTl3DZsWfIwt7w/OIR721jd9Jspmvr6GSjrnuxFn6NDDU2ryILY+clDPCdN5qEa6P
         VwOQhQNBw1RqhCJfASjaKIs8UF0Ygo9Ejou5wQzJnle+jwLZMx8yb5WExF15yEYEWnGG
         ezJOBAKemQcRweY+McSLP0RLtvyeGEK/NLTU9Z3IqrhTqS+S+dkV1cvcXcCwh2+GrJz2
         s8Z/plgT2VzSlsgmzFinf9xhuceBqre9GG0ID0QOaN++w+HeXBCgdOw9JrLn2RqoOvF+
         BJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733868930; x=1734473730;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iexj35VEw3PO9sDaoRB2DPXv4caCta0ARbzw4n9n8do=;
        b=E1P1zWPb+TN774SL1DpGjd5GxRnF+J1c1cLJWLWOKM51Z+qM+dOILxeTj9XaWfcok3
         IOup1647KzO0GoR2GWEoDKcK6CPesTINawdfe4E/L5322U2gYjM8VuJvy6PBes1SXOmz
         hI/v2FHQpHYNiMJjTAKBasRBeMCotMMRji/budmjTCg6nuCQqfcJrSikop4WL/vAKqas
         DpWdh+eYU4EsnI1+X5k2ucnopAfgecwd4UwXdZuXOrFjMtKq15dWrpgF4VPJIQUehHlT
         gsCRPmFJJGkrTPgxlpfsBUFKKkJd3l7Cssx/fapIcREZQVTfqskYlzmclL60NrHa1ZcZ
         EFWQ==
X-Gm-Message-State: AOJu0YzoYN9yf78yDftYGz1vojDViUoAoaWtfxJLXzElchKftGR9V/Kf
	DuXEAddy8wxrXil0psAOtu9c5Xh87GTXQazTR0vaI+LBdJuc722oEiXCXQ==
X-Gm-Gg: ASbGncvyIS+1prdjuUYTu6kcQK6GPgZlhQphO2utbT6oZaNlDaHZLPKYQzSLPgpjEvd
	b+YWlDr9V/czUsMr9LwZ19pcGovdGEIFBXthbIZti5g5EefNKSBL2cH+ZimbPUBGXJto9oyCQPv
	zOikRLMSjOJO+8KZcJWnu9skWHTs38oSlCjM2EuIey71OLRcJnjazer8GM6SFabhiMJXslQl3as
	IRmkdY/Sg2+PnGDOs5R4iaginBvQ4BSU2k38RoeI6q/QH07/bUCW4nU1hO+oQ==
X-Google-Smtp-Source: AGHT+IHo1KkQfA7nn7Nb+07mxmwG6GP5zyRaG+7S/SyPzNkSVjqtJMsF0CmEtfEUjBsMHCpkLfMUMg==
X-Received: by 2002:a17:902:e803:b0:216:11cf:790 with SMTP id d9443c01a7336-21779e47231mr5707065ad.16.1733868929962;
        Tue, 10 Dec 2024 14:15:29 -0800 (PST)
Received: from [172.17.0.2] ([52.159.136.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f29b63sm94438005ad.260.2024.12.10.14.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 14:15:29 -0800 (PST)
Message-ID: <6758bd81.170a0220.10dee1.89bf@mx.google.com>
Date: Tue, 10 Dec 2024 14:15:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2378829542073722876=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, eahariha@linux.microsoft.com
Subject: RE: Converge on using secs_to_jiffies()
In-Reply-To: <20241210-converge-secs-to-jiffies-v3-1-ddfefd7e9f2a@linux.microsoft.com>
References: <20241210-converge-secs-to-jiffies-v3-1-ddfefd7e9f2a@linux.microsoft.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2378829542073722876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/scsi/lpfc/lpfc_nportdisc.c:906
error: drivers/scsi/lpfc/lpfc_nportdisc.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2378829542073722876==--
