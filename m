Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9BE1EB1B7
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Mar 2025 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480311; cv=none; b=RFCM0K2wu6wRLr92im2lOiKx0ihp72OUPLXhuueK1BnpHf0iuh9R9LJAw2yQ+CMV4JYF/ntv0zKoQ/VmVd+F7kZ64uzl5TlQqtJD4r2MGbJPbSq5Zqrn+WPurBeHvkW2IdymJU8Lnt/+sqHdm274+S12pNb8cyN3xFhu37bqrU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480311; c=relaxed/simple;
	bh=jslEAXtDOA/d8QdSG841c7qyb3HmCGVSAhd87hcY4Ho=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Rpn9broNuGqUFoJUzayfRlFHZS6r7jC+vVvDfSXPjQdfd4OZ62aqZKSbp0xe33tG1ITL6eRLzBxD9gOkkIk/DVOwB1k1R5WkzV1OPZdGHc3m45zpWVkVFncadrV6c0mea3H6tTd0POWRBASVEJWnqUidR+EJDZ1f1CSE1/ZBp9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USUUw4Eo; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USUUw4Eo"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c3bf231660so118179485a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Mar 2025 07:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742480309; x=1743085109; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ligTrdAp6X5NxLVgVxhD6WrklcJKlMqrJc8sbILgzmI=;
        b=USUUw4EoJ9RBc4UYdqvnt3TCbHJlXKaPerng+GbHzKjDNngV4oQCVOib2QYQmoU8TR
         mmnq3V/PVb6fzmzeVUnCx5TCx8b3vzljNExnEWhz3mb/Xm/d6bjAVntxbTThkcpwprtS
         Z7Eig3k+OFxG1+FflPotRdMr8ZrYGGYPnBp/dbbbIJ8D35HWb3VT6SuFAu7NqNlKoPa6
         g2rQjWb+DD644SvU6wVTJgTo2ipLs7jPjLNQkBSm+S1VTHiJL4fzYHbjv1J47PmRL3dA
         mnavcqmRjxfId0GZUWhYVYE6tBEnIgOm8xAPnwK5d0eyjxb/7Xdp8ksFVdimbQEmNCV8
         TZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742480309; x=1743085109;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ligTrdAp6X5NxLVgVxhD6WrklcJKlMqrJc8sbILgzmI=;
        b=LkWwm23cZV0gZKd+tTH1glyI1t9EPgHvqfy989uPvpy1cfFdT9aweTQeNUp8BCkZJU
         KMlsZA9Fb28hPpAgDH1SNINatV7NVIy86peI5wZPE6/WcbkWTK2Wv1UO/ePdThX2dCl8
         1U4U2tXVCqDM5enpar59pIOmM2MkPXy5s5H23JKjldXWUbJAcPdzh0L1L5iW1SXL4eLK
         jimVWhNOnX5PN8YmF9b8cMSC8Tf0Go/ehhLyxqcC7iixg2NNVAR+sHhjfZ9ppE4vZU2d
         ZRRMSaPPbSfcrZaXpa6Kxec/u8NeTjvXzHwFu0NYpc+ZdUObxpTUA1uqpQ7D8d0auPTh
         h7gQ==
X-Gm-Message-State: AOJu0YzrPyNTKltNDPzd3hoQkSiX5iv4tEhkD/UMQKlxxHowdvGYs+zp
	/cB6c/3E7zmOkqcjtBtJLIeNCD+7/NQtFKmaHSBhuVhxKI390hr6DdCifw==
X-Gm-Gg: ASbGncsut2Lj1oU4IQ51NoXqOHxMC1xAGwWPtOocfc8lNTe/oA4nWOpKykQ1r1bdiW2
	rYAGwIuDseeHjuCH+QzTx5STV9B7gaGqTUPXCmFprhJnab53l/Chck1UGWGACZ4/4hRO9jYQP2H
	gzVnvv//Y7gh0nYUX1aiNSZfwpyyjffyQwo8oQGEGKJbCzVn2NtXdTdQBu9GuV1oEzipZLiFW8k
	i3FLp3pvdcck4iPNGi8d8iRppOF1a6Swxmu1NfRQ39iSFWHjsBJsaYzLE2xoMvXvN/zP5Z+CTXU
	Rug0lUvpmwKhDrd5qQm82VpevLQMMPb3lvI8kvkphT76JS/6KKI=
X-Google-Smtp-Source: AGHT+IFsRDyr0F9K6MGS64rXemDIRkoKR16o3HNNDdgWgk7P5338HSbHdcYHNs8oxepJN62GMqWLIw==
X-Received: by 2002:a05:620a:258e:b0:7c0:b523:e1b6 with SMTP id af79cd13be357-7c5a818788bmr873042685a.11.1742480308914;
        Thu, 20 Mar 2025 07:18:28 -0700 (PDT)
Received: from [172.17.0.2] ([20.246.77.171])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c98225sm1010360485a.49.2025.03.20.07.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 07:18:28 -0700 (PDT)
Message-ID: <67dc23b4.050a0220.3a950c.6663@mx.google.com>
Date: Thu, 20 Mar 2025 07:18:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2502494747418355852=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v1] obex: Add supported-features tag in MAP Client Connect Request
In-Reply-To: <20250320123126.216903-1-quic_amisjain@quicinc.com>
References: <20250320123126.216903-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2502494747418355852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=945920

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.23 seconds
BuildEll                      PASS      20.66 seconds
BluezMake                     PASS      1494.92 seconds
MakeCheck                     PASS      12.95 seconds
MakeDistcheck                 PASS      159.52 seconds
CheckValgrind                 PASS      214.63 seconds
CheckSmatch                   PASS      285.96 seconds
bluezmakeextell               PASS      98.58 seconds
IncrementalBuild              PENDING   0.31 seconds
ScanBuild                     PASS      874.42 seconds

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


--===============2502494747418355852==--
