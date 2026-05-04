Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D483D6CAF
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777906766; cv=none; b=TPobwxnV3h6yiMANL6hAU8yK2xAt54DaHKtho6CGe0RMxp1C362+C9H16D8pWZqAoji1TTj6Qiy898DTsS0hTyrDlxFV+4oPdoxLDNLEefrVVi3M57wLohWzFXZFaF4PWIrHRwk+/ujJc9Auaaf8cx9iZcIOVKxQlRa67aH4jyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777906766; c=relaxed/simple;
	bh=JZ9RS3K5O58E2FL9TWO1I/64zX+WqREine4okhalxgg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ORvmmzzRbENGnMJck7yonUVaftMxcx9GJqsJdAFPto8xL2R5CDZpGueElzxitW5S5y7fofRtKqmuR7igWpgSc48DgGMWSLNfYPpv0gIFnQPq/ETWgnLg+xaQC5Jpy3lnmsmnBXo7/FK5gvtOdM0Pl5XwsiC10U2QQQdECN+RmZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhWIr4dA; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhWIr4dA"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8ef2118b478so414612685a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 May 2026 07:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777906764; x=1778511564; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JZ9RS3K5O58E2FL9TWO1I/64zX+WqREine4okhalxgg=;
        b=YhWIr4dAY6ShFJ6Db3how1htP3KBk9HJO3gRZwJP+DhLz8FHnP/KH3LS+UFHoxogpS
         AjnZfs1PaqgeLkM2Y94sUvVUjN1Akpz6NeFwclwBgplWbQ6iceg/ccUnO52WfHcEaOgJ
         6qqQ0i8WwItAzbEfkYNOmaEixv2VUzKU5XUqA1AGSAoYf0EUmtRTUSGQBubM7qpOElSE
         d50R2a93UItSuPxEnHCAEARvn+6I8usBWdiP0sWEMotsYOrpQMKDm3MeG6txaQ+mpgHW
         tiaSSu8re0ThlQpHvTS4D1yv7oCz9KamLR5J5fBnYDaqxnevl1ZanmFFVWYZQ/rFbNlO
         RZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777906764; x=1778511564;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZ9RS3K5O58E2FL9TWO1I/64zX+WqREine4okhalxgg=;
        b=SqE7AFXsf8wQBBpcXt1DbJ2aBNb1Le7+0bJVgZI2Dj+rSEx5KStMRdDYL2NnKBUDL4
         NfkeQAayLmYCbtDqCCXxmWHNgqEjCmupL8h1e/FJWZ6oyCnsp30xmcn5ylm6kICYeix2
         9weCGxWywgPd6niI+/eli1nDPOqjgpbm0C7cDwYLUQ+ShRrKea/BgLC1zpic0/iXilYB
         YMSrdCnubti5pgVqZDimyayX+E8eM02zRLc8vnQU2WuqO0M+/yoX6bHQLL83ULqhxerc
         aEXiUCSpSECKQLXsb22UivNCbj5wEryX9Wl+KRKJAN5+aydJoSF5KGVIrlj+XQEnKs5O
         7zLg==
X-Gm-Message-State: AOJu0YwC5CaXfWQUnxej5Qmhl69ezL3oaHaxwBorXIGlNAzqAF5z8xsm
	ceFaxsxBoSm5Vmx16l9lv8NdlCZ0hO0g2iEuxWZ0L8hoOU411LszmEaOaioD1w==
X-Gm-Gg: AeBDietAoHcsGciwb54bTsT79hEO1CuCcBLnUtRYSXktmVRYzddMk4r0aVvB065k82b
	13KX/I+r97aEQ1Y7UbQvQgCSmILtqbYalSyE4iFe/jkl9odkrKhSTeG6ftMi7OGFzC6FgY7yQdR
	AvcKhDF3t0HUNsuxT0hGeaeiGnutvSFqXqynF7izhYz8IKLzVAoyEliIUw1M5pcGeRxzFaHscLB
	saMsqc6FFuVinh0NTVGfk8KGL84ctvKbTLnnTbI3t52E5fZJ6ijXZX8wW2WHUxraMpMUuAIaTAe
	+y3l/Lce+Qi7cAwbZGeTrjq6MtbuRCkoxeLYVBkF7fITqKExWOGj9W6Br0blgV/SB9+QHLUXQJR
	gX6MdrzziQOT7R/DaaLe6Jln+hhMjR5RXnJid6FxwD3MKkwWr4PMBCjouZSn/9mWpCZuUw5YdwQ
	dZk+abOTLU5lqf/zQRjdWA3/j5eIsWP6slRu25HJr3tw==
X-Received: by 2002:a05:620a:3942:b0:8d0:2609:f515 with SMTP id af79cd13be357-8fd164cc2fbmr1482607585a.25.1777906764117;
        Mon, 04 May 2026 07:59:24 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.185.18])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91cdfbsm1088073485a.34.2026.05.04.07.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 07:59:23 -0700 (PDT)
Message-ID: <69f8b44b.050a0220.140549.fea3@mx.google.com>
Date: Mon, 04 May 2026 07:59:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8795819200515105559=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, admin@fluentlogic.org
Subject: RE: [BlueZ] sdp: fix overflow in sdp_extract_seqtype()
In-Reply-To: <yOqVLTbtJxpC_gx7otX_BNS0iLh7JlU7MCD2nqptPKZfZv7gmto_BKGqaQDOrN3BX_p_QwxMEpyX6dhwiEFnCSl5U07KWDk81YvABZVf82M=@fluentlogic.org>
References: <yOqVLTbtJxpC_gx7otX_BNS0iLh7JlU7MCD2nqptPKZfZv7gmto_BKGqaQDOrN3BX_p_QwxMEpyX6dhwiEFnCSl5U07KWDk81YvABZVf82M=@fluentlogic.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8795819200515105559==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: lib/bluetooth/sdp.c:1249
error: lib/bluetooth/sdp.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8795819200515105559==--
