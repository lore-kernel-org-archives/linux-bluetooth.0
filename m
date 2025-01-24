Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E6913AC1
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 07:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737704245; cv=none; b=lE9EDtRv++3IH7gUUydSWThws/BRlgkLnG0hbHdjAIY3Wn4MfSb3gigb+JHutt+B1CBIWhpiLC8z1VnxYOm0INUQgkewZQnGW+1XlyavOJv/ylYrEQBij/lQRuae+O1SePfp3H3icvpfdL23LU8aGn0/nyPJYhfYvpmH/Ok7obo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737704245; c=relaxed/simple;
	bh=9jfXR00ahbYAB2XmTIDZMEKGrcS5fVYq3iYxAcNJOW8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gw62RmKPLd4vY4XdT6j1i8uxhnOPJ6DleMDddhJ3QyoIPCKM6fIP3ARo4wb879+rRARYFAhM50c6VYNH07qlpbFqF6zehWyqe+japx8WfJjWCE472J29N1l6idelitbb1XMDMG2lbpDd7GA7JLFq3I44ex00fs8caODsNTfm1Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGv6ZH/Z; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGv6ZH/Z"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ef70c7efa5so2693094a91.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jan 2025 23:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737704243; x=1738309043; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9jfXR00ahbYAB2XmTIDZMEKGrcS5fVYq3iYxAcNJOW8=;
        b=bGv6ZH/ZuXYLVI7vHPLbz69SkBYsd45OMH6Pg+xuhP6POX0bK0H4MIrdSJ6uN1CaKW
         x2tReD9vr5F+17/BDOri/Q9NC6Z4bU4nJzdjtS+RTxO0XjifRvysveQtaem45UF96VY8
         CD50xh2MkzUF+z8TDA7x25lq7IcSMkwsFWNc7o6x/ONB6mwsjL1i8ygPjNIRq5lrQDbo
         06KKfoVFeE1nYOQr4Xj49patNEgsq/eB5LaJURLt0FmoF/5tET3qPwfgLCnHFJm0Iz3E
         K4X5MruWt5ihGNkY6Vki8c27QibiCee/jMz8C9lU9DNX+NG33gKgenlNK0fF0Scgar+L
         Ktvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737704243; x=1738309043;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jfXR00ahbYAB2XmTIDZMEKGrcS5fVYq3iYxAcNJOW8=;
        b=oo5jmXywN0mEojV+/lL5OiAEOP9OJmUyRMFNETsfcjKj9mkTEhC1O0wCy63BDZ0u8f
         y3yscy5tLLQAq8gTRfwIDGEgwB0xa1jVZu9E7E0AxK4gY/gaX8g2LLXRF2vzxlLc2/yr
         5hDcrk9kmJiWfbQMSw8euBLm46YJ20YgvJdYRUPzE6DNqrG7I1LSPWCEQpCAk/u+bEVM
         58O42IPLvlXxXBnN0WB8uxObX1AIBQn1xdRQTwtvKu3X67r2R8uoCAMAk4pDT8XuXY9m
         g8i/sqe6dzcKe8kzWfjPqb9RFGCFir3F+2loT0qClWZdGVL411/hes7Wadgq/JzOmfJk
         HHoA==
X-Gm-Message-State: AOJu0YzMpsViiwFfQhkkedtBlUv6P/gSpxCltxRwXapZrsaOJcQDB+MK
	56IH/q5axX3yzCmLMGZUndLoeB2dUnNluuf/u6MaEEV+d9SfbcJaj4zScQ==
X-Gm-Gg: ASbGncs8f2UV7oSIoW0LjTNyms96Ol7iQEEqDk5cRh5Yv5nAC9pvKgf7e/KpyFlK2P7
	AjBbKpjTygy5fXqzyx43FznmEzQUhrIUShn35JnoZcYEvsT91mdGOhWy7Xc2O3Doyf41m6iTkld
	LpFEJTZdJ92lwYW0xAvgyPwzzCGs7sEJ1LMfycP/lVOA9auVcp2/Er4XYqugele4CIz3MG3YaGq
	F7nPhJXNJ0aKHnyO4ujHZ8foCRUZzCBcgMZq8nou57dDhqktcj6LyqfopX6ywEqDHyKqcGeowJM
	L3aah00fanY=
X-Google-Smtp-Source: AGHT+IEWvVaxWw1gdHKedle/PwF09HHCU2N3RTevXh4QG2Z1d452iaaZhDpyr/FL27KiLVw1r735qQ==
X-Received: by 2002:a05:6a00:4c83:b0:725:b347:c3cc with SMTP id d2e1a72fcca58-72dafaf7788mr41402215b3a.23.1737704243156;
        Thu, 23 Jan 2025 23:37:23 -0800 (PST)
Received: from [172.17.0.2] ([52.155.62.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a77c78fsm1194533b3a.133.2025.01.23.23.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 23:37:22 -0800 (PST)
Message-ID: <67934332.050a0220.106870.6340@mx.google.com>
Date: Thu, 23 Jan 2025 23:37:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0158262083401497955=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, keerthana.kalyanasundaram@broadcom.com
Subject: RE: [v2,v5.10.y] Bluetooth: RFCOMM: Fix not validating setsockopt user input
In-Reply-To: <20250124072047.5320-1-keerthana.kalyanasundaram@broadcom.com>
References: <20250124072047.5320-1-keerthana.kalyanasundaram@broadcom.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0158262083401497955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/rfcomm/sock.c:657
error: net/bluetooth/rfcomm/sock.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0158262083401497955==--
