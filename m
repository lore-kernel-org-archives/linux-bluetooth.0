Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF222FD69A
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777035067; cv=none; b=uJYyA3lpi4TYpCNDkZtgw2b6GOnJMhoDoOlN3oBAFCgPcwvtEfBD8K+72ygJN1kRIiSCksfCqwytlO/PVBtftkit5neqpMokdQM8pz4MgqUvDHi/TO8C4/e+Hvggik/EC/dWPMW4igD4mOk5fjxS0HesXNlS3qqkr/KijRSUCjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777035067; c=relaxed/simple;
	bh=LGjeJhZUFtqYOlQdh2ZrjgfS4/3N7x1QLMQVuNcpb2M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SwtjQ7p3pyo7V5TfwkuH9WrtDacFgpcBRWl0wv0gWxFrK5LfXOGZqQZZ2Ecl3T6J3JNoI4Qw3MGOLj0MjFlWZLVRy4kso2PtAxlXET9+kBnLtNgkUAwUEhmxV63Lk2wOCTD5HaqtJK1slhIKKALL7RTPzD615AVyAPdfKxyxhtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZempP7/Q; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZempP7/Q"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2d891442388so12721115eec.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 05:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777035065; x=1777639865; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LGjeJhZUFtqYOlQdh2ZrjgfS4/3N7x1QLMQVuNcpb2M=;
        b=ZempP7/QmmusDkFnoLfLMSrldbEXq4gNnDMUH+HeSE5FZ3V+rMFqhAJylstBP0i2h5
         Mm1MtdwkUNFPFI5I8+U8Ankh2oGPCp1AZUDFNWh3y6Ikt8dKRFMJlyuMrVcSQSJuTkh1
         8nwf0BZctsHte9aKV4M41LuQbTn7BX8ze3LAfNg6A3JKBhDvRO8k7msBqRNiFSv19z6b
         Q67GaFU5RO+J+DJq4YW+P6lXTdmj8p26Ww+ZHPIIvr96r8DPKiVfN7jIpsf5UAqSxn5n
         cWqsy0KI1kVmpPcUIksvyPU2ueE2naHNproH2Eotks1bqDtjWCRLD63WoghkapCghJl0
         8/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777035065; x=1777639865;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGjeJhZUFtqYOlQdh2ZrjgfS4/3N7x1QLMQVuNcpb2M=;
        b=aHT9xwL9bl8RUsZYRjZy/qaNFmC+9OXSDPX8GFSsciFSGqyek6ZWh8+K0Y09uYlU0v
         gXr7m7VnA2pB3dZd7xkWK7y50rFcOjYz7lrAVNE0A9qO+52gcSq3KD+oLwmS74edBhn4
         uHp8aO61kZqT8cp7wCEgng/TBttsGEMD1lB4gjPd4FYvXkt5wre/4w/9vZBoWlmCVlSr
         b7YfPbFwCe+EOKaPAkTxaNHHz0ugU/4shT2gMPjmq2bW0WE+Em99xsmPh1uJVgxrhvTG
         7gZr/lLAl2Wvo+3h4/OdvetqlUr+q2UkttlM321jSQqVw/60xjubuDPlKqgLAvTGgPcs
         HkYg==
X-Gm-Message-State: AOJu0Yz5kULx15oz0kpo7qxQxpwmCeBqlg3zN3A9gak2NIGzVZ1gdJB8
	UncHHcaP6F6eQAv7NUCAouCZy6pc6VP4V8zhOLMMBxzzyOKHE4wsCKZRLcEJrA==
X-Gm-Gg: AeBDieuVFDuHvDoEESGfhwbvLOSxiLVNv+K0OorBHozpZhQHft9H+PH6uZfuSxhgc8N
	+L7YCbzBNstLXdT5STRQqe1hC4V7ElomHRJwBRZC6/rxeo05sfxGKqiuf8A6ydTWQKKcJ76a/3N
	4iCh4ezoY+5Fw81TDDbdSJQvtyTWPhadD+051I84b/LGt/UQ9W2ompUoJG7q1FSDS4Gg8Fpbr1O
	ad63q6JhDrbvOG08Ty3B3cQQjjAmwGGORtyONzQpBZE6CHmb11GzQwKyp02JqbKqoBuWKuZEI7H
	VurUs+WyxMnp6lN/xwhs4al38oS1f4RrNKyY5jEi1ibC77+9ylK8SyGELwZcvHre5okFTdezfp5
	mpzFkmsYnsuALcv+H435Ye3WCb+7DrR0hfoC864gAsPHJ25zOGHhKhm/D9fGcZLDt4TVC08uhKm
	6ab99xinluPkkWE6WGu/Y7gjQg0gaYR1Zs/LIL8kRFrg==
X-Received: by 2002:a05:7301:1f17:b0:2ea:3370:6e51 with SMTP id 5a478bee46e88-2ea33706e74mr9108494eec.4.1777035064988;
        Fri, 24 Apr 2026 05:51:04 -0700 (PDT)
Received: from [172.17.0.2] ([128.24.161.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53dcb487bsm32658073eec.31.2026.04.24.05.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 05:51:04 -0700 (PDT)
Message-ID: <69eb6738.050a0220.94ee0.6670@mx.google.com>
Date: Fri, 24 Apr 2026 05:51:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1584418294578333828=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhangchen200426@163.com
Subject: RE: Bluetooth: btusb: Add Realtek RTL8922AE VID/PID 0bda/d923
In-Reply-To: <20260424122522.402953-1-zhangchen200426@163.com>
References: <20260424122522.402953-1-zhangchen200426@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1584418294578333828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:603
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1584418294578333828==--
