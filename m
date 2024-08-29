Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5471AE05A
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943408; cv=none; b=XBcvfMhWakrqKsGL6UsNrXLjU+2/zxPjPCEhk5AM0++QV6BdmyP+tggpY1fLG9zU5uJfhZw0n9dvg4PyDhFp6CMdXNy8dadDWGTbM0sQ77MwIbWdF6jb9CZ5dzcSG/z3wKs1YOIyInalSxHfcraD/Rt0Ha7Tp1KZBuxEtTEKbgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943408; c=relaxed/simple;
	bh=sWONQjZjpmI/rTQv9Z1Kul/qECopM26aS+3jrgpNHBM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rTEYhAVrgHWGP7OHYvAfJZyx8qd2AMoi26Bnuocw64tJtJNfJir894/m7mO2mk0n6X7ToCKREXr0Aa7MT5OXFoLFUN1eAoxnYaylKOA9S5ZJNGwfdfr1sJLmniKrw463M5RRqV4zFI8j19YNHzKi1CMpt4a0LFBLeLKxBrUIZCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxqUQGNy; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxqUQGNy"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6bf7b48d2feso3944616d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 07:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724943406; x=1725548206; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2IkCWKbiigHXgX6zIy3YDA1xKGUISiW2/tda2Jizjb8=;
        b=RxqUQGNy8b1B8Sz4oE0Jh/grFS4vrf0kQHhThXNWpvhseJGKxREaW90yv24PVmbRhT
         +FfetvVf+96ssnDKVY67QM72fvjwOpUWKCWOK4CFRR2ldS/Uj1IYMqKfV7nJhw9Cg0qS
         0B3caI9SHnelEjG7KLClu7lt7lCAG2Vz7klmVAyq00uopK8UJKUPtfko1eIe4GI7pSeg
         6Nsaz74yNVRuZvlST1eOrn9sF/RfhlR9WapjaLqjw6N4lfLI0mD/bu5h824Tq08duOIZ
         GnzlEfQ8eaDjsmGMqusa1dJM7SLdIrVHwDd/G5apnQLrbAtEuChPLpz2B8jwW3s+KR/t
         EWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724943406; x=1725548206;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2IkCWKbiigHXgX6zIy3YDA1xKGUISiW2/tda2Jizjb8=;
        b=VVXah89YTOm0ElZ60G00F6xZecR3rQKGbiJyWUK/WP5vMODAs+h0YjgrZSeA7PpOfM
         CE1QEfRmcXlV/b4qFshaC0TMxv3n4iqPJ6QJ3IbDYItt2iiqQMlQJ/DzDhZuObp092fx
         aarVm1Ni36j+1kxPFFCVHP4+tiQE984Zv+pUxAt301v+DGFjDMDg2aLMjUXpbw5GMjlc
         Y+slpkEtHNICFSqUN8NdO/Sthi239yUJakr+Z09GFdiiT/U+RK258AusL9lMIAhPOM+V
         TxCd8927VweONU9KjFhd22fTs1JQksV98Q6noFQwbe7X0Fh1zZ18F59I9MoXW6CO1nxN
         sYyA==
X-Gm-Message-State: AOJu0YxyUOGJVXqDC1bPH9HkIm1Pub4zaLmjSRg4TY50Zs1snerrhMNg
	+05rYFjGKVReIc91QRFElhgTVChxt+tWyD9vaPVR/lICE4d4QwskZzGQZg==
X-Google-Smtp-Source: AGHT+IFGyGXTYyLCu3ewTZpJiatHCy7bymK7XovHlZj6uhBInRt1lj17jQDbo8YqehAcbbDdG8RDyg==
X-Received: by 2002:a05:6214:3992:b0:6c1:5ae5:ac3b with SMTP id 6a1803df08f44-6c33e6aac35mr32528026d6.53.1724943405833;
        Thu, 29 Aug 2024 07:56:45 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.91.175])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340c967c9sm5777156d6.102.2024.08.29.07.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 07:56:45 -0700 (PDT)
Message-ID: <66d08c2d.d40a0220.3b471f.1fb7@mx.google.com>
Date: Thu, 29 Aug 2024 07:56:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3969872232143040002=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: Add support for setting bcode on bcast sink
In-Reply-To: <20240829095206.91150-2-vlad.pruteanu@nxp.com>
References: <20240829095206.91150-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3969872232143040002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=884682

---Test result---

Test Summary:
CheckPatch                    PASS      3.21 seconds
GitLint                       PASS      2.12 seconds
BuildEll                      PASS      27.19 seconds
BluezMake                     PASS      1750.76 seconds
MakeCheck                     PASS      13.11 seconds
MakeDistcheck                 PASS      181.81 seconds
CheckValgrind                 PASS      255.83 seconds
CheckSmatch                   WARNING   360.37 seconds
bluezmakeextell               PASS      122.20 seconds
IncrementalBuild              PASS      12970.89 seconds
ScanBuild                     PASS      1055.91 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============3969872232143040002==--
