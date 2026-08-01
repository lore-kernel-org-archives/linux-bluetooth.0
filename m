Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D9B392C56
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Aug 2026 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785596071; cv=pass; b=rRFhLX1yl8xwD9FXQ1ut3mO02Z3J6ji3vzbVS2nQ1X3PNNPoZSjq/NHOlYbtTGtCTp28xGwm3rqk1guIiFnDsLgKRRHPKN5tdQad69uuM/I2dRFwVNRUojOi8sedtfk6HAvMk56X6lJw3wymvO/FgqzjwN0vQpkpdlPis1yeUH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785596071; c=relaxed/simple;
	bh=lALeePGZVy7EXUBDDuEbDUR+laeZz6c4FLEA8PHGpQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lVeaQVCVyNtdB7Fyj6XPH9djl1ib00bcw0w1ZLhquv4XD+THsbyr/ejZ7b65CE3jtJ7qLU8/V2WPmT1E96rax3Nmbl/6jBzMgwPVe6ucCOr9Cz5lfbdD4epEEHaLpwMnA/ORr8fKCVwOS4ChDJxrklxTT2P67DkSqV3maAtEGjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SO33PMB8; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SO33PMB8"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-698aece3d7eso397273a12.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Aug 2026 07:54:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785596068; cv=none;
        d=google.com; s=arc-20260327;
        b=GhnyKPt/Z79Sr0GaBEa6tTB0G8CAeiDtuDvGmOBatKYJgR+YNls0ZD1B6SlZ9LpgZB
         IUWhlDbVQjl9LbuJR6JxVCRnn2NQ9YGwxDE3erljfpMXSCiXSL0lukwwjVDpWcVYoCWW
         dpeuMehmdbwoZqdhRqFvclILbojaoJ9PPQVN7U2y4dW2TLxy7txk6IfMVl90WjGNrRYv
         h0aPmHpMcbfIJVadiiA8Wf0uAJkbGHgNfAaR4VDFlVFtMGHwli3jAEYQ1NN1HLdvBalb
         JYeWU9kAvR8+D00VLsmAOqMkqP/cveGXXOy7Ka/BCRtYr9zQK7pjFt0vMS5k2dxA4I6+
         BnLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lALeePGZVy7EXUBDDuEbDUR+laeZz6c4FLEA8PHGpQA=;
        fh=1+NOtJqXObW6sVyBPPVxFk5jVJ/lIEIVB0U3yMfSEh4=;
        b=kL1h73zqBP0msIsVbduZrcH9KOV8vokSUf+nHnyalxfccjleBXYTRiwa2TG2kMZ1bb
         8a1h81aGp7C1TDgV4iBiFIgBHQ7KLM9Xc6kCxR0vt51AU4hLNM3gUlJuILGn9dOTp/Ud
         jZsQnPdksRlbWXDnII2vNNZdwYT2JE7sTamUDTW217/wbpo3DwL95XmnHWmS7Xk9HEak
         Rh2n3Z/Xy2pUTqaDSLko1JzK9Bo9etNm45pLh6wq2ulfjDob2QNm1FLqL5TNgushE63P
         eAqL7L+nN0YIE+LNe1G0zx+V61ukvIj6Nssl4mYX8j+GdxAKFmnZS6iOmr/R3E3OguED
         d96Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785596068; x=1786200868; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lALeePGZVy7EXUBDDuEbDUR+laeZz6c4FLEA8PHGpQA=;
        b=SO33PMB86LWO56A81UQNiunI1hVkQKQiC+trgH0uAQti1jekX7WFUilbHx7EUO3Nj0
         qn3OixXsCInZ9cDrOuvvug+EQByMZDvFO1lz14gwcUWKSQY7vp81gV7b7lpsxFsowXeK
         qFs7ufyuEX0uubWLezN4TRlkAxHmaj3ejl6mhsafHxYeAyLRm04h/meVHMrMUQGNAmzF
         Iu0mef0fccay/RQ/MsLYVnNCPhltwxW39b7O0BKSY/HNTA4NezR5/PVFmGUTYt6U5qqv
         dSHtCXpj4tKq5Zi2szBalPnjEcdy2yv5I6dWo7XFvrxbJc9Ufuk7e/9ZR6ap7XoZydiu
         wF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785596068; x=1786200868;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lALeePGZVy7EXUBDDuEbDUR+laeZz6c4FLEA8PHGpQA=;
        b=pOIUnYhZ5XCYzc3+XxA8f+G1cjWIBkxZ51q+zViytLDl8bkn81AiPWdcASc+q9ToCX
         XZxMC2LXYmxzxXsfcgar1rYJybk6cLWdFQXkPzc1+Kf0s1K8fYbEDlk5j9y2eFuWcdm5
         KmZjP7IDZf4UJFGtQFTuSCmtIFLLhlMmQo2j+qsvUHiqkP7h3068epYf8/3V5P0Zvk6l
         I5bcDQG/zq/MVnfmCCu1GFjrgCV0ZjrjGPSPHcOp7bJnYO6uHdmSQdJYXpmTvqJ8NKuG
         AjrNRM5iz25cfx39vzlKPakIY5dfkx5HJuYUuU+R/n+OqgzYvyYWHX5VuWxZLFesbJlI
         DPTA==
X-Forwarded-Encrypted: i=1; AHgh+RprjMoy32Au4In18l5T01Wts0lZtixvh+QGpnaJ1XmELSMDmp3QMmGP1RQfw9zJz+wlYnlOMqquf9dJq+wncmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbX9fvj76ClZkLhXDSY7CUloB2TJ6yGFZOk+w6QWoI/yQBg+/2
	z5QiAe7rxqg/lrOCiu72JHpIokB5TRIB/7zOLW71ljCXOGpL4xbkx455wLKNHzY1JcKKMmW6idq
	eSmngR6qX5jM95TDjf/eAyXze1OhrEes=
X-Gm-Gg: AR+sD12OwC6uz2sm7YyJAALchY4/9st2+994Gj88HqJVantbBjvDfjr5j9t+6+2eX0F
	ggCgV9RFH+MNcgrM1KekQOMufWhqiUnOXIHKAAPFhsFrn5ADQ2EEFJxe1mlicVEiHWihN2+tLSK
	fx4hm2d5Oaa6qmXIbLF+V4QyNtWUSGjF0ZpKMz7NHJdRuNws8/MlJV89YWMuhSBlgxxweTilhD+
	4vBschWnf1bJuxlbf/PnaA+jaGV4V8TLtnyLdTMDqGQwnZyAMJf5vH2aV2Zz6k5pzRWqCDnAZDh
	RjqchJji/5wuscwdeL8Az6TaUXQDmrtnTIfXtW9DtfCH+C7is2XD2Sd6D9PtBuu5rCyca2NYsQ=
	=
X-Received: by 2002:a05:6402:280d:b0:698:d8d2:df38 with SMTP id
 4fb4d7f45d1cf-6a0a7d14af4mr1792429a12.2.1785596068086; Sat, 01 Aug 2026
 07:54:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730104103.2080325-1-nicoyip.dev@gmail.com> <CABBYNZJx46usjp0_snfRQ7pvWrxPE8NZqSyqyM0rMEsoHgZnow@mail.gmail.com>
In-Reply-To: <CABBYNZJx46usjp0_snfRQ7pvWrxPE8NZqSyqyM0rMEsoHgZnow@mail.gmail.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Sat, 1 Aug 2026 22:54:16 +0800
X-Gm-Features: AUfX_mxege7Yh6aPEsZJXnOr0qQ1CCnaaBLHWtdaqnDVHVEc1876k_pZtjV9gkQ
Message-ID: <CAAo+4rV0ncEcMGZVH+VHScJozqs5L4C3S-mW77s5GyRKeQ78Zg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_conn: hold conn for LE timeout work
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@intel.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Sat, Aug 1, 2026 at 3:25=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> We might be better off removing the le_conn_timeout completely and
> just make hci_le_create_conn_sync -> hci_le_directed_advertising_sync
> wait on the connection complete directly rather then using yet another
> work that can then race against the likes of hci_conn_del.

Thanks for the review, I have just sent a v2 patch to remove the
racing timer completely and let the hci_le_directed_advertising_sync
synchronously wait for the connection. Let me know if anything should
be further adjusted.

Best regards,
Chengfeng
