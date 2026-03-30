Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B972EA731
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882235; cv=none; b=LKHQXMaS7UW5BNifWc3JUgSQ1MiVL8+k7zgSp8sEZuOe9WgzLlhOW33ZJfdwFEVilLmq1SfVshKNd+5t9ckcaUBqglsIO0fCohyw17S5fPWm8Vdx8ES4ziO66BVtk/hFT8Bxslda03scs+IbqMdAODPH6LQPAb4mfi48H9MX3vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882235; c=relaxed/simple;
	bh=dW3gEfdnRKx7QsizEWfZiD4kS5ptKECzkBmW6pjViCs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JHkJDFdP4+7wsiJwxJ8C5Pf65ROE/NCEUSVfjBsF1i3UHObWmOEhXRvYAkH8cH1twsMnxGu7p1abD/jxu9mR3Up8maw+gtAUvkQN8yJ5GV8YuwYfhuGNae/nupGe8sJqdEsnQmew62E5DPCibKzrJVfO6904UWJGxHPtp1Q/uHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oXUfqfV1; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXUfqfV1"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2c175635a33so3301510eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 07:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774882233; x=1775487033; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dW3gEfdnRKx7QsizEWfZiD4kS5ptKECzkBmW6pjViCs=;
        b=oXUfqfV17UdQGHBPxu/Ghx6ZzbxM+ujkUWxbrsTl3PuX8OiUtLR1Iik+luKCVV7vN0
         vC9gfUcTNBP2MptTR25DjABfYQifgcBTcN1keVaMVBM9eK++HOgKrIv84b0ix+TMpi3n
         jCpja3cWNqweuMJYb9QAkWjIC8FUpqFjAm2ajkKylqWDYPYn2U/pv1FNjDETswaVUqs6
         OH+4FJWsKWi9hbL6Zta4bXhn+Ixa0DiAUtQFHMehg8OXAuTV5CfWntUvpph0cMlS1/2x
         TcZN3I4XNJe7/H0T9/0+0vxqk6CleLl/aJQKcJPhwycTZ7t+f3cIaE76dZVf4V6rMYmq
         pw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774882233; x=1775487033;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dW3gEfdnRKx7QsizEWfZiD4kS5ptKECzkBmW6pjViCs=;
        b=Hl+jzSXJREOzT6ZGbzPGw1fV9OiXzhe0f+N8P6mSRjubPfA+ADQl3q9R7uet2vkCvF
         5fERBV0TFGmdJFez7/yl0OwuOK03O574dgHZmfY7/13ieO4CwaO8XAPcKJpgq09t2ZhP
         fHMYMEe8ZnrfIJlC2r+xp0ajO8g3vMGs8S78EwZuQfPxVfc571+tC0rT80YZDO3R3I7W
         y5a0j39nG6qZSTo0ZD7zkcaCMLPI687jaIORryiXLuIf8YYnmZdtKAEZl7FNrX7SGV8t
         5NCg42pE41MaTC0zgsQqTancwXX0lWL0FTRD02/isVX/5OqEDobsbKZjK8gPtiMG5JmR
         Y4Hw==
X-Gm-Message-State: AOJu0Yy3RkTjb3AAGhp7CQrH1xF7C/Vk34jzotdI1sVF6BEcpAocZeu6
	yp0sWQcjsMf64/t7xFwONGMZvwJ9AeVbdc4Pp+qT6sXBOa4PTcAvglLwc/d/Eg==
X-Gm-Gg: ATEYQzywaDZhAGMFuSjuGsi8Nl7oe6xREUsFzze4aDh8n706j951YIp5n9a6mz8tbBL
	P7E2YUBqmuUWGOilFTZ0fWrcuvEC1A70Rdy/R+5qWyaMq+THPPIC1xlDVFYOO7mYVG+4KybvEBF
	TeRuZMnymR0g8DaDwN/YsJeybNOt0eF81UfJJ0ImkBsXLvXVowN3DaLDnJBUEGyv8MfgP+13IVI
	0Kq/2qzF3ruVef7gnZoNctUWvl6kqH9w4KJld1ogcegw4drfTQG28d3sR/JacNiDaiiazMMcuuX
	ysrmwsVB4YjwewQb2/oGdDUtRnJ73X+KMjn39rvcc90/YZH9rFtxdEXa17OzVMj5aU32wUo5jhp
	27DzoN9bUFRoV7HfwnytZldsp5su2F5OG4MGat5/8XHcPZXqbOObeK/BMBwHRaRnl62ch/p8/0u
	VrES/Wxu1l3T73NmDTfsrpMK6M45w35MEc
X-Received: by 2002:a05:7301:d0b:b0:2be:7fc2:fc38 with SMTP id 5a478bee46e88-2c185d557e2mr5974400eec.5.1774882232767;
        Mon, 30 Mar 2026 07:50:32 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.193.138])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c6e9ca80sm8037909eec.22.2026.03.30.07.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 07:50:32 -0700 (PDT)
Message-ID: <69ca8db8.050a0220.17a49.7b4f@mx.google.com>
Date: Mon, 30 Mar 2026 07:50:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7615094116288787330=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, aaron1esau@gmail.com
Subject: RE: [1/3] Bluetooth: hci_conn: fix UAF in create_big_sync and create_big_complete
In-Reply-To: <20260330140347.906689-2-git@aaronesau.com>
References: <20260330140347.906689-2-git@aaronesau.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7615094116288787330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_conn.c:2119
error: net/bluetooth/hci_conn.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7615094116288787330==--
