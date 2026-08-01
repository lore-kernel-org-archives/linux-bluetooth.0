Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963AA395AD8
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Aug 2026 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785596260; cv=pass; b=I3SQr0HUw/Y9IOiyI6BY2X9exsJDMh12GpXHj+rzNBQ+sW6MjZGPzv6v1xh3OhJJ2BYpRyt2v7wBkx92W/f7Cx0ZGBBajZCkzC1k+O6wqMV+jhyJFjJo4wLtcdXKxK13eGdSwvijiwimLmLwClRYG5/Vro0uWjyafOXZaG0Z5h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785596260; c=relaxed/simple;
	bh=9jcsL2kmnS3mUEK7x24EyKaJQ0164vGOexLT+3HPn88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uvNGtZ53HblufgCoxhRb0FfNtR9o72+8l4/YgkRR85moPfJF79iTAFvgqYLyOy84CqrrMBXpzEo0l2xFaBL/YBKqoZXRCBFzYQxUdCuQmsIvp5vYFkktk3BimrY1e+7rtoTNKFN+SBBDMT1nZyGl9/gwXr2c2/rApPVRFxzu9Xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWnCP5AR; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWnCP5AR"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-69a33fb0031so363235a12.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Aug 2026 07:57:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785596257; cv=none;
        d=google.com; s=arc-20260327;
        b=EJgfJzcR4zJGU+HmfSbtuJCWmH2EN+nXVFG2SwLX6QcSGEajENQSM6QBX4yT5P60ru
         nLIzmvO//spaXZQSHVRFHUKlSlSnp5erHsoGi6Mk/+YYnI3aTrGj8ndOw8YCHmvZj/jB
         AjRcpJvoV1rtV3wF9k4PA791YmUFfVM+PsvzMilDeExB6LjloBsafnFPn5xsdADR4CNp
         MJSXPEa6H3rdKb82eG27ZnL9vhjLq3Ef7f6+ku94xxgFxazBQSTWemefGMdPwdto/PFT
         1FAGpD5YFImkTQFFWboRWmgrXhJjwo9JqRSvj4y8YLSXHIqLkZ8Z5CvzQpNn0+1I8PaI
         jYUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9jcsL2kmnS3mUEK7x24EyKaJQ0164vGOexLT+3HPn88=;
        fh=J9tJc58vniaRqOUB5pOWDb9PpKQyMSOozJ88F96erRM=;
        b=LgQ/6UEbRNY5HRoGBEJd+bgZa+lLSN1r+LBzflBfPcuGe3vzgb6TGKqK19QDLQlCL/
         WqCx5YNxbqEGpMm0x3ZSn+2IqNqfPLgJ+yy3mhzOp3IfTYSKOPvNGjHIG2P84RltyRIA
         QEzLWRpdut0/moj9De9otfaFUaN4H0zpt+5FijG3NFy1W39DOzqaHOCbgdflAcl8fYtn
         /9x64sLwt2/5rZ/VdUTQgkZI5sW/8jXxcLX+8NXR4/rYhoaz1dJ8e1k7B13mXAFajY6X
         63+tZixaUEKOyGAGrD6cSHFqaUJwijmC1uxLpBuqJxI9701mfhYvIwB7Ea5cpZQj+5u2
         LbxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785596257; x=1786201057; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9jcsL2kmnS3mUEK7x24EyKaJQ0164vGOexLT+3HPn88=;
        b=KWnCP5ARPnMsgDr33mo/I9VgFf14yKwpb/GC7V+2TYOa/A95T2DITeQ6pCKvls4exE
         mqtLMlLHDX81EFCdcf8VNcXuGiSaxjwziKaOKDXu254+IrqVioWOxV1oOraDM1iejewO
         rpTikBCdSv98BzF3hNCmvjdw2LX9OWLxCM2myod8RpQsedfaUIDIjPmJtIt++yaUXmWy
         ZoKJizl60eGwfGbkUEy+b8jzX9xBNapUsenrVLJAWxlut8ijmr8Aq6TBSsltB+aBvJMI
         ubCSSC0Y5shhcZkGzuam8R6LkoXzZHTdVOhGVLYcp0AUZvKHznIQg1KkknG/cz52xzag
         eOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785596257; x=1786201057;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9jcsL2kmnS3mUEK7x24EyKaJQ0164vGOexLT+3HPn88=;
        b=q2Omye7FC37m7rBtPBRF6Wl68y+clokI7O2vDU5WHcIbAGeCdKKn6gSG/SCPkJm1pu
         wZMsQPYsUljC1GT/o3zQ804MF+NpgqKX703E5I1y3nbJ0wzyTSX4A3xlD9vGo7/fGQcA
         TxWRQG/iggM3GUjEF+6z0aFHJ5EUjuu3CEAMtZd9OO/3d8YPmPJrE6x+wXfVwpXy/NI/
         KTIV3or20LJqVd7QbzxH6+/T5XH9n7xOGiyR9F9lHcjDPu+jwwPg3bY+2vgKP7TrYXWM
         YGLY5q1MvdiqT9bhtYdvw8Fbxwgj2uXTzMM02nzFRjRx6iwkDBQ7vUDpFCKVV9mCSXUW
         ww0g==
X-Forwarded-Encrypted: i=1; AHgh+RoPbcpxuENTm1IKD5+O0qmpwZvAjN+sGyKqhO9x2RNd0G99D16C24o9I0eFaUzKN2law5OjDjWyum9VRS+hAWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7jQ0LPDbbLeTJTQHNIVp7TN7wiwi3YFuWLuS2/Nk81wqC7jSu
	JK6Q44YYsNF/VDEBPdgL8gaYXuY5ngneiFj/hroX/Ei9p73Iw1EdSrNnYR9wPgLt23KMmebJZ3u
	B1cbTts9Gb018LBH89MKOtpdvz9ynep8=
X-Gm-Gg: AR+sD12mcKkub4hD/AOc6BlIDQ4qQFUaEz11dR3t74kUu4OtBTmXTpLOPrIKJfVgwXh
	MLTwiN4tTb6WfiwO8LemwJ/U9GZVFHkdAZFRiO/2ua1+gmfEcCc8ula124Rg1yT8dYQnRs6ySYc
	oi27ih6IjMqYZbMqaQgQkY1qSxW+sjAfKR4Ut3jWPFYhnfaGfePH3500iGwBIww8Fa9B9IRKsWA
	EUzONLBGLoFHXfpFOl5prTuP82INllb0wqy8p2MTl77zceKPgQF0nODVxTs8+VE7NPFHlAjKTXT
	dcOQu5JjhPK7RkZ3SThlqBsD+tYnoUjjtD8klmfr2lKjZoBjnN8AGe7pHwlRQuBXCco+ChaJ+s2
	70Pdvdh2N
X-Received: by 2002:a05:6402:2111:b0:699:6415:751e with SMTP id
 4fb4d7f45d1cf-6a0a7d096f8mr1938361a12.4.1785596256583; Sat, 01 Aug 2026
 07:57:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730104103.2080325-1-nicoyip.dev@gmail.com>
 <CABBYNZJx46usjp0_snfRQ7pvWrxPE8NZqSyqyM0rMEsoHgZnow@mail.gmail.com> <CAAo+4rV0ncEcMGZVH+VHScJozqs5L4C3S-mW77s5GyRKeQ78Zg@mail.gmail.com>
In-Reply-To: <CAAo+4rV0ncEcMGZVH+VHScJozqs5L4C3S-mW77s5GyRKeQ78Zg@mail.gmail.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Sat, 1 Aug 2026 22:57:24 +0800
X-Gm-Features: AUfX_mzHehqygWlg73i6eROY9af5HU3Udu-hd0Qa5VaoIeegBmsS60wFcCaDnSg
Message-ID: <CAAo+4rVTXCjhbcNxSMBefTm8C9YWN03CMY2dXGK3izgbb4g+rw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_conn: hold conn for LE timeout work
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@intel.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The v2 patch is [PATCH v2] Bluetooth: hci_sync: wait for directed
advertising completion.

Best regards,
Chengfeng
