Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D0113AD0
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jan 2025 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736753830; cv=none; b=LK+8C99YQQ/tClmNRgLyM+nXf1KLr2ekdEmbtnAJ9kfY6cXc9tfy7aAy539D7JNCPKDF73vUn+HmE18eqb8vaigQzcP6EvlCBYNYUjZElbjxWEXEUnn813/I0/I/HBaRQDHnhhRHfGVL3IjZ2so+KasNDmlfSRwGnN+Il/Juqzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736753830; c=relaxed/simple;
	bh=1z08WWJLx/YD6El7MsQDRZHftYXjycmhExqxvpwHBtw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VMnOv1IZFVut2z3IrP7+RQyi2sjXU+dkSuBbruOhrvuVsce65HGpSp6ENfXT5qHkpBhhS678mNeEXnlcovEr1sNCiI7GVSXm0qsS8GFwjiC/F3Xqo8BdSYKKVDgFrHEt1u3gpXwLKkdugE+vOZMwk2+y+OER4MpWJFEJq/CjIio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5MKGaSG; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5MKGaSG"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46677ef6910so41341331cf.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jan 2025 23:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736753828; x=1737358628; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1z08WWJLx/YD6El7MsQDRZHftYXjycmhExqxvpwHBtw=;
        b=a5MKGaSGEh6CupTS4IaEUEhCJy1qP8sqt/7/1g7ODr2d4CzgLRsb9bc4SeTNAMkpUY
         bIkZmc0v0tD91eTRSnMKYo4IIw+dBTC74OLEWa56UkNwvwR1k7TWcpFn+fG8usubwMsO
         Mk55CYKp+C1ES3poylbQ7LCqhGx0GOgdUr0a38ATXvw27H18JGxiAliHLoFjsmdhPMpY
         xIxhkoU3eKIuq7i6htbLTN6UNUx0hSGd5SrMsht3lebhgm9wP+cFKFciz78Aw252Mr8W
         luOL0UlxL3upujPDIXrCH5+k2qZP9VXgplmq+iSRqVqnyDjaPs9jUO7yPJplPtPZ/CnN
         sjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736753828; x=1737358628;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1z08WWJLx/YD6El7MsQDRZHftYXjycmhExqxvpwHBtw=;
        b=Fh95wApljDdgCe2iA4vSTAnUB5tjYyBJF/WSeRiBMORQTEtp0hyNPyv6tNCzOEbEVK
         6c2HcYDOaZFPTclSzz09GfNpH8LNoXI0V1swTr7iHYosDL9XdyoptRRfjuGKsWLUVTBU
         YQMM4lhcmnkLVwusgawVIHXpN2ZaNYu1ICS4GollKx7maYqOaSHapngovRjEDpQK0pLR
         VlRjHK1fPs9UvusPE877Jj5Jk782BktxmXPZl4/jFMsspY08SHDpYsKyfxEWweJQ3qGn
         MyU6Zze8FZV0SySzVw9y1LkkeXqKye4Dk/86A2/4lbNuO6ngt8GxN+x2d0NCrX7pJhyL
         TsWw==
X-Gm-Message-State: AOJu0Yx93lOt26C7nBsEiZhR+dI1TZOpOjhixbrIg1dbfOoaUdB7CfEc
	PaZeRxVBlWiBuvJvLQb2MQhyRVWLrLK0kHPs5I7yuTLwHPHIhNpSxwu9qQ==
X-Gm-Gg: ASbGncsmcy0yvxCuTtBYxEPz7x/VpP4n51MVwcU88HtJS3EYxT8WMHomYUX8fxCfOki
	rZR5T/9fSSHezdJc2r20c4QM22tHGjSCWAnOL5AgT/CIhKQb7J+F6CGcR25t0fpM0b9pTMAJyJA
	ZzS/UlUWhn8qXWmhAHBCno5U2cmDdwXq9h+GBLXDnjaMPZqVrDOjmoVZw3vZZha58X85ZzTejG6
	Cvpc03XmGM4pg8iUADWLcQjs5L9enRXVywN3QN3E9RFhUzBEFp/xyVXMkcHFg==
X-Google-Smtp-Source: AGHT+IF1vKCvm7xc8FzBK7H9Zk44aNHm/ReyUz7EZCqwLbdmTlKQVe/zOe+Pxh0xXEVKJqIJMRAE0Q==
X-Received: by 2002:ac8:5ac5:0:b0:467:43c1:f0ea with SMTP id d75a77b69052e-46c70ff7391mr329674011cf.16.1736753828071;
        Sun, 12 Jan 2025 23:37:08 -0800 (PST)
Received: from [172.17.0.2] ([20.75.92.153])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c873dbf16sm38443931cf.67.2025.01.12.23.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 23:37:07 -0800 (PST)
Message-ID: <6784c2a3.050a0220.12bce2.cbbe@mx.google.com>
Date: Sun, 12 Jan 2025 23:37:07 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7256293771722551876=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, d.privalov@omp.ru
Subject: RE: [5.10,1/2] Bluetooth: L2CAP: Fix uaf in l2cap_connect
In-Reply-To: <20250113073100.34744-1-d.privalov@omp.ru>
References: <20250113073100.34744-1-d.privalov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7256293771722551876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_event.c:3245
error: net/bluetooth/hci_event.c: patch does not apply
error: patch failed: net/bluetooth/l2cap_core.c:4272
error: net/bluetooth/l2cap_core.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7256293771722551876==--
