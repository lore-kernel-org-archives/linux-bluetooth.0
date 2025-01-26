Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6304DF5C
	for <linux-bluetooth@vger.kernel.org>; Sun, 26 Jan 2025 11:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737891085; cv=none; b=JoZMeqAorMDKNtOKz/ZjgIGaLgZxVhoFmDBJ6PzyyL3MztQALZ08uyygvDAc07ImbmLkaunOWKE3jnCw3NkAjT5DFGSoroj5vtgcejy07jNpD6rqZMpon5bG0PDFtiPrYEXlHOsm4syun5F/x31HgZerSORcgpfXL6VgNnj4RM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737891085; c=relaxed/simple;
	bh=bpyXfLMhj8Iqec80MGCg4Y3v3PP1i+5qwG4AzBFSgd0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=P5d/CbuwOUsnAa4swMoiEzrMdo1Bj5tK9R6c+7c60oxYoy0YWMITTOa0X6AWVEiQMb0j/PGT7YUYA09Lm2M+En7ty8xOOFKfc5isNsgcF857uUd4NKeh4PDFZqdt0dXcg9yYd9dda/BvHO81aiE+XsfcIxhDQa+aPL4R1EM2VMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LivsS0mm; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LivsS0mm"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-467a3c85e11so26184311cf.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Jan 2025 03:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737891082; x=1738495882; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iMU5+JRn4DEdRB+NMe6eQGZHm7VY9fRC5lXO6jNFIT4=;
        b=LivsS0mmIEHyw5lBbCj3JnhYczoYcBuh8oduh2D9ZD8WlblnsX2qA/Bc5oMY+b9iV4
         wpCMjSW5Lgtqzt4CJqd6w1QT+5+6VQUM81ZWE90dWrFH97+IzdDL2MwkQg2gSHtBS8or
         2M5gmDwiW4EYmy6XvX1x4CIT33klloFVQR0fMArtdneRZHkS2vual2xgJq0EAJQepF+j
         SQmIhaeNm4n+wE7CQ3ElaUJ9MDJOUlMVyTgajJHPOxmOyA+cbj45WVYYRE5OkiKmcLzf
         6l2IDrfnEIOggvPTGnP4b9tH/aNcALR+EnsuxmmDnAsN/uYSUOCU0iUchtTBjGjvkugh
         q1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737891082; x=1738495882;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iMU5+JRn4DEdRB+NMe6eQGZHm7VY9fRC5lXO6jNFIT4=;
        b=jzZCp6O5v6NIV77BQSeLBKjzMqQ4MM75INcKKqo9sOMm4h9mGJiEYE/1B0eNDXAYTU
         dNqjr7LGbom+8eTtE6S5a++gWjmsNLFceQWae0x5ySrHg/C0ZeIxRimPrxBf6q365R08
         ZEf246teuBYI1jVzMfqr5Qcx4rCddER99g3k/afMGW99R2pfrUcPPF/cHKycXU31pGnM
         aAmQ84IpvzjHuvcbACBUeqHxfhHdCCXUA6kP+CuLpOsmxHfylkIAZ0AKh511kEvrujSC
         skfxZlmmwbOBJtjXlelUhyxn/pWT/wYP7blW0ZaQPHOy2oguZfx1TKv9SxyLPT19/0mP
         hLtw==
X-Gm-Message-State: AOJu0YxpMNtfMrdM2b2+1qZTZ4t4skov9dTcFwewvBBpbCM9d5aa6aUE
	fTFD59FYkeAuTh2QShjdr3jmLdC124EiEzL76A0NxzkjkSYlTP6EKCmmazLF
X-Gm-Gg: ASbGnctLjoJEpX4O1AqleE58azEqApOU9kVKgUK0OklE9WFjBOGfGafSYT+exPCNp9x
	78fEmEJqK+SAGTB79RwH04oSKdBYAcmZNS9N8JRgvN/+U7CB8FuE52B371++ikGnmAP9V/LTyIH
	w656MZsYJCy/xhSw8/W98qKr4BbYanUlz6pgu5Lb/t6He5a/+1zC7Fr0WMxfreUXOXPILy0kYOl
	OTchbNz84ZAcakTczb5BEMjUP9Jc1VWmi6G195pxF5rFoCdTeqoTJkyhYLoqODar3AIiY3SgneM
	eTzUz3jW0g==
X-Google-Smtp-Source: AGHT+IG8+6OHim94muj+zLomrMvy+DLplRjv9+IwT0PL2EePfcJ1zICE9IrfsUPXH5xLw46cVEawnQ==
X-Received: by 2002:a05:622a:94:b0:467:6505:e3c with SMTP id d75a77b69052e-46e12a96f42mr454091861cf.24.1737891082064;
        Sun, 26 Jan 2025 03:31:22 -0800 (PST)
Received: from [172.17.0.2] ([20.57.71.210])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e66b88f10sm28660011cf.80.2025.01.26.03.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 03:31:21 -0800 (PST)
Message-ID: <67961d09.050a0220.206c36.b379@mx.google.com>
Date: Sun, 26 Jan 2025 03:31:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4959009123215382135=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] shared/gatt-db: fix crash on bad attribute index
In-Reply-To: <efe1351374fceccbe4f1392fddab0d75e128a510.1737886528.git.pav@iki.fi>
References: <efe1351374fceccbe4f1392fddab0d75e128a510.1737886528.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4959009123215382135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=928379

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.18 seconds
BuildEll                      PASS      20.30 seconds
BluezMake                     PASS      1556.24 seconds
MakeCheck                     PASS      13.13 seconds
MakeDistcheck                 PASS      157.99 seconds
CheckValgrind                 PASS      212.64 seconds
CheckSmatch                   PASS      269.75 seconds
bluezmakeextell               PASS      98.00 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      850.99 seconds

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


--===============4959009123215382135==--
