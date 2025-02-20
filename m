Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDBB1EB9ED
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 22:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740089710; cv=none; b=H82wkM9ySZ4HDVPljevPY7q/TXkA4Z5QlhE3qjL5z0LiAGtvdFKMnSfXNuLGB4za5ZW09tajHYu6Y6qy9JzdijnEzd5RWCqkWyNhPB0wzQujHctfjqc9vFW2TPfijcshZ8QFVj4QUiNQaPug9ChZMmTCVE/rL+V1EGTqwUxdy3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740089710; c=relaxed/simple;
	bh=zgBPrL/rb6FSusbrt2VlnhqbFpuj5YgWGpVPh3EFazE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bcLvFdBp4w/HY7L8NaRcVxjW/1hPlBWt79p45bu/OW4QqwXA6aJ/SUGEArIVWc8whtOPJ3jQvNYeSxaMKydVd5kugOd5JzrmDRWfVyT6h/Mnf0ITY8+p1fXVxSH+XsJJxZ4384SFvQmTOG9E0kaGD1LlXkjhQw/RAalDGqxCKSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLIBy0+n; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLIBy0+n"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-471ede4b8e5so7250031cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 14:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740089707; x=1740694507; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zgBPrL/rb6FSusbrt2VlnhqbFpuj5YgWGpVPh3EFazE=;
        b=aLIBy0+n/uPD/l+k1YouanQVnppds7YTmyfjiPkszDvo/UAQKl+7ifQDrnNdrLORaY
         +e3HqTkF6+0FQVlkOrDVc0nIwAlLnO3VzmdHZy9zKwjn+9dC7zUSsSZItlUfbGLxaR0F
         7ZlVxQk8Bx7Y9/W//Ef6GWo3uxNvYRMQuuUGiFoV9qqpnmRHzHBOwBLq/b/5cgqZeOyN
         4rNk2pe/bI7DBaMxroRZ7HtlopcEYmOjP7E1hkb5Ps922The463aqc+C4B95uERSNY3o
         rZRW8IYlrob+uWrqupEt3GWYTZ3M7xIsK536AmAeLK1xp8/af6Mgu/LDrsmCX2xu0H4m
         KISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740089707; x=1740694507;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zgBPrL/rb6FSusbrt2VlnhqbFpuj5YgWGpVPh3EFazE=;
        b=q9V+a13+n6wbeHWyxXQJ/GLjit/3XacJkMpNG/2t+fck1i9pL+iyCkfFqrq79gazci
         81g9aXzcMSEDlrU684Ag/OIQ9GG0hqDWd+DBdwSVT0QMh9dNT4O8LHi1v3A0Y1F6XGnm
         YJ401kkfi/SNnFDvh36ysUthmMjsQrSsLpzCGVwtQ87SSt9VmCwIpNpyQto2REQigJyN
         X8egwdkAWRZfWudUvBfj+PWjuUegFpxRRRo09YcF1yFsleDZ9bxLX1TzPvtmNHB9gIg/
         1x1L/csruADPCE4vo0xk7HVQY9zQiCcdOboNpMXHlPY2uZqCHMGP6jP5fH4BVJbl+1ty
         v0cA==
X-Gm-Message-State: AOJu0Yz0mTZSVxz7c4g5e7TVH6HxNzBS93MG+weaLwo3z6uD3Dbw4KEv
	30R+BQUd6n7Kr/M991MBrGaHh9kwS42hJJvIY5djNmH33Q5aF/Y3GH+EKQ==
X-Gm-Gg: ASbGnct6Hrh20zIj8uPgndMASb12ayljmmp/gPTcpED5qOoiEnJqTLhNeeYu55is4w3
	gqN8tdrjnvZxWNaYzfOgahQtKxLNscuUNnB7n1X3Zn7UFCk5aK0serAxav4AFlHEv6BM5Ao3apb
	oZq6cWQLeaBaBp9xhzqe/r3I1V+RK7EcA6/741n9WXMMDZJkHw3SCVkJlP7tGsz53abczIFG9vM
	am8PxyR4EFSNmR6hYnWg+PhwH7/EZsrxBBwAjvNKGm3nA3zbZFXV1nTwlMeuEB1FhF/+dsEcb9M
	qKKoStQBp36YKgNMK5lakw==
X-Google-Smtp-Source: AGHT+IEkgfToG2z2ENRuBXj4o7Ri2Sc/+dJhkAAV9d0vqxfT9EUqwojjTgI26RiOr5K0M3Jb10gAVg==
X-Received: by 2002:a05:622a:15d2:b0:471:c273:2399 with SMTP id d75a77b69052e-47222927ac3mr16649901cf.35.1740089707065;
        Thu, 20 Feb 2025 14:15:07 -0800 (PST)
Received: from [172.17.0.2] ([20.161.78.145])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471f5877a6asm44161331cf.36.2025.02.20.14.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 14:15:06 -0800 (PST)
Message-ID: <67b7a96a.c80a0220.5842d.64cb@mx.google.com>
Date: Thu, 20 Feb 2025 14:15:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2251500981477041497=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO
In-Reply-To: <20250220215727.2035833-1-luiz.dentz@gmail.com>
References: <20250220215727.2035833-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2251500981477041497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_core.c:3564
error: net/bluetooth/hci_core.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2251500981477041497==--
