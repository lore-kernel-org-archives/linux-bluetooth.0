Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BD240B6DC
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772464516; cv=none; b=OkJxog3zrBBr24tWKAmasVzYvHuCNQnwUWVqYc8foy26Nb7dINgiW4l1cT9AKW+qdeN6l6lgJMfO4Cg5Bt1X63MUS3f2iKt0XwsLjR7wpLKaMSVXHVYTKYHxQox21hvr6ZLqp8sDm+hZYJvPMFoC6wHP4ZnDgRUOlIFfs0N6M6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772464516; c=relaxed/simple;
	bh=RylHFfKMo58ACH53WpLhzoW4pMTRcE7bpn2360e/1es=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YQitvkYNaGBI5/gpn7Bq+SUnqsyjgFNgk6gc8qBTr4aCFG5wEWds5/1K29LQgJGVnQ3XvUABx4r/NgAmtacdZgBZ35OhPDr6hwdingy6qBYs7dAw0EX+gAzyVDpN/kn2efni/hXbyf9gsoFA4M5Ityudwo0i820H7GwnncObdxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJYBPPV0; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJYBPPV0"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1270ac5d3efso4297088c88.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Mar 2026 07:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772464515; x=1773069315; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UH54A7O4fAqV9aLrHXEOWZ8alyjZe2VhYuzCwKO6iow=;
        b=jJYBPPV0GJJ1t4veywQ7qSkAjdIVTX0x6UqJfDUZtfvb7L98q9k8k28e3RRMB2Yueb
         Pwoz9oCohDB7XZfqcOequMk+lc2qy7xwC61BivlXcX+raZlufk2JRrZNM2k6rZ2DIG2c
         wd0nu97zu3A9QvgNQVrd83MSGxwV8j+EkgGSkBbQsfS7Hu4NdJXtDlFlm8+q2v3WsXz8
         aCtDcrOTJyspJQ8OdmtuDCHwYsE9JttycD75AtYLMD8LyBrz4Tn8RGxlLMmL3ho+M9Bw
         BejqwJpo2/oX923q+SNKSv1umE6aL1KNKFFDK0vYS0OMTBptu+2UTpdw9MM8Ql8YpAcr
         fLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772464515; x=1773069315;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UH54A7O4fAqV9aLrHXEOWZ8alyjZe2VhYuzCwKO6iow=;
        b=VhfxV1h3WmD7wkYH+BmXxwXc4dmJu9WEqo392JDHnApobN+Ja4suj/vfUuto/kAyxD
         kcHQyg9WL/T5WNAWMZ1Tq5CjXWXTd4Hm+EieMpBMdG3hDWbOwcdZmkZ20a49E8H/xf/b
         yh70/QvsAN6xQBmhSKA5Kpdz2FebuCD0CvSTOGaNq7DpFTc4j2QAb1kt2GThNjXFCU3/
         wJryjCS3KjrXK5O6YvZPgqYJj+P/rM8fgdjDg+MMJvZaDyv1Tw71un9ss1+nPSQNBOZw
         wMhWZ1C7GHTpuoyCzDXtV+tinRUufoolZmT9rikgesHg3CNZlwDMgGym9DGYicYncNv0
         4vtw==
X-Gm-Message-State: AOJu0YyqObvWnyS19ZBlVYwuiSGNAy31guKdWFUWJYegNI6M804i+22b
	ZoyjiCogp2DtnAU1eKT/QIYMwk5UZqnoriNq47M/WiEqFoF6mC+1Acv7fS/PwQ==
X-Gm-Gg: ATEYQzxPsynndhVMS8vz5yj9wRKw89U7vCJcY3ardVJuXRhXxsIbKT0j93dbITVVmZ9
	RT45jdsMxsHyYOGRxgHy1M7NpAHYIqaAJUHNcfDr/rRn/6Jqo1PntZh2kogYU26QYBP7QY29hnT
	eTeM6Bu0amf8tZyUSXMsu/genu+/8MS5LDFkftDUr+UynbnH+ngbMVOCwV+QnkdLvRW9Z/X9dfB
	Lf6rdLDHNwtodorRryp/PnNElM8DhsUi9iWwrV6qmmNmabd0q4qHRbsL9AEU4vL9hdvzZq+6t7Q
	s9ptQEmHTfXBmvn/KZwObpPDazbB31Blv/4EL+cMk3dQ7chHmikYS1pWEpBN1m9VeooCIwh8SQK
	9gBeZkLizeAnsO5fJfaq+hyNmRs11BH3KNg/HKTyvWxbQD2Zz5m1uVTOfgGPL0JnSpXxbNwY1X7
	pnowuLvUX3J0CNSwNCCj6tvA1AiFfRuw==
X-Received: by 2002:a05:7022:611:b0:11b:923d:773f with SMTP id a92af1059eb24-1278fb607b7mr6675092c88.5.1772464514309;
        Mon, 02 Mar 2026 07:15:14 -0800 (PST)
Received: from [172.17.0.2] ([52.159.243.181])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1279e9950cesm5728551c88.7.2026.03.02.07.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 07:15:13 -0800 (PST)
Message-ID: <69a5a981.050a0220.275d4d.4f63@mx.google.com>
Date: Mon, 02 Mar 2026 07:15:13 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8361443839663017378=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ceggers@arri.de
Subject: RE: doc/qualification: Updates for TCRL pkg101
In-Reply-To: <20260302134540.25540-2-ceggers@arri.de>
References: <20260302134540.25540-2-ceggers@arri.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8361443839663017378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1060034

---Test result---

Test Summary:
CheckPatch                    PENDING   0.46 seconds
GitLint                       PENDING   0.47 seconds
BuildEll                      PASS      20.79 seconds
BluezMake                     PASS      644.28 seconds
MakeCheck                     PASS      18.69 seconds
MakeDistcheck                 PASS      245.85 seconds
CheckValgrind                 PASS      296.92 seconds
CheckSmatch                   PASS      362.31 seconds
bluezmakeextell               PASS      184.62 seconds
IncrementalBuild              PENDING   0.54 seconds
ScanBuild                     PASS      1040.15 seconds

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


--===============8361443839663017378==--
