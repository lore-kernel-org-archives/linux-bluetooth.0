Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175A43FA5FC
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821421; cv=pass; b=Ln3W6a3/n7ktxb/x5hvr27r9PZ81iCvwP8JARg95ROnsTxJCTVHlVMXKhCvTnSdF2/gdXX/hQB65J1+O2oH6YneF6t5Lgw5AAh70AgIcs1txA7ibcZwJbylaK7N6S0OdwOXWHtjDsF4Nnx6+etQz9c2jY2jbSy3QVx9FSSxzDc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821421; c=relaxed/simple;
	bh=y3yJdLF4p5kROIsqaE7iia3mpx0KwmfIDoZ137chD/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jF9v7wyfQqvg/Gi/IrteTBTd+AM+BPouShtObT2cJuRaMJkW9knaoRroA0uPy9G+8rG9+nBSsFsVHuxA2EdvDhCZTobR/uox7Xld4R+pKlazPyBX8cDtrKLHFKXxMfnjEMKpUa2vZ18Bz4As/0EUgsJOpvy/s/zVqWOYzZOq/Kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o1uxibIf; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1uxibIf"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-698aece3d7eso212864a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 08:43:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784821414; cv=none;
        d=google.com; s=arc-20260327;
        b=rq5j3pTcx8R5dCElWOTjn30CwPt/pv6/vZmRS6gugGjM9PyGsr0eggeaQ/noVsCZTz
         jmbpp8EEdBycw2LEgfy+oR4Yzvy6y0o1uh69U7tmRPmO8YObaHIWLdnsJwYBiOjZXOZB
         EBomVQBaLwIFFh4y1eW3QdwGHuy5SZe8+Tq6PLA4o+3UftIEwEH7tFSfKUzmxIMkI5rw
         7jl9mVGj3XyprA7Ar7MmswtW5tS/zT8m41j591IwgHqrOnKRJPUwvhNFwCmOYjXbL39z
         L1PsWEWVXVHLJ8/A37d8z0qv2V/jQUntAPo4tMwVRMokO9UasGIc4pfWEdt8yAxeo8vM
         UauA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=y3yJdLF4p5kROIsqaE7iia3mpx0KwmfIDoZ137chD/c=;
        fh=Th9/sL+n3mIXRKhIRUR1lGSUdFfMe+LJ5kTzoiAW1XU=;
        b=NhOeEcA+Kcef9OwbdUQe6HwOI8ELaE2j8CfUUH9c6a3JQAwM6UbW0FFCSdO1yaPJvT
         X4g3TmZSQPJ3kicx5I6AkyEue37pWLoIkX27+ognVciN/iONYgXHC8Q4dbThhQCromcZ
         o2zUbY6rbdTiJQBfwkXCvGUX37h/0+LM6fm2XHdVM4N15xX6ObttwZ8A1/FIGZq9T7Yr
         OJKGMmyAWuDysHEuae7mieN7MVr8CI+WYxu6MseyO9AQMeeOxvQ3nwgd//C+NeZho/yd
         g5GvY4EHLFSmI5Q1uwE9rACf9+LBhSCjMesdzh+vtt2VNAbP6u3u0ZWhwmh8/j1z/NpU
         xCxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784821414; x=1785426214; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y3yJdLF4p5kROIsqaE7iia3mpx0KwmfIDoZ137chD/c=;
        b=o1uxibIfx7Xnt457MQzE8/zjN7I4enQ0vBFMSVS4sEQhfX+zBa1d8ux8WUaOBl+axI
         IJw8gTXzW1HBy7sSYFo7hYLIvFSX+ZcoHk9AVU5J+yFkEKlOIiGUa2/es0j335LH8/b7
         fxljIyjSXoABUvPypa+DO86FvoOdKOry8/wXlmrYNr4wq98wS2keB4uym/bKTW286eTQ
         YkfyiXtdFcbxqXwvyBbir/njLYuljlec1CXfs3w5cbuWYpSvQRn9gHiTeNx01yW6y9L4
         hilzRMFSfDZne4uNuE1odotcMzaBQFp+RY/LJPuxyrsUJOgNCnvWYuewc9J9Fk3zVLsM
         1ORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784821414; x=1785426214;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y3yJdLF4p5kROIsqaE7iia3mpx0KwmfIDoZ137chD/c=;
        b=IsMlWuXr6QT7MP8ucOnl6OQyGbPuTHWMo8av7Y1YkR+hVG/BBjpVHTsIgl12OrbwCN
         spy63LFIXHuiZR9fQbk4O/5aCWX28OiHduVZCTGa8uqLM3GzNDB5xLw1du6xFJ8cZzs6
         HrMCR403hJxzzK77bGjCc35efDzBuB8xY65cpbobPu47L9GODhEgpHmlxE3byGVFNRG1
         L/zL/QH7kptb75Zdek13TEmdaWdnOfrSsjPF9NF9/evYvNokm16983I9VRpobYkF49Zs
         RDrbZVtmUWZ9Vtf5CVis5CAfpY+tLVzl0eQNnopatYrsFoFhD+XTTCD3TFTTnrWKIDcJ
         6+aQ==
X-Forwarded-Encrypted: i=1; AHgh+RonsmNLZp2D/6HwVh4RoV5i9UO5xgoL1jt/6NKbuzc/CsW73JitJAQos5UJ9Ah1edJoSjO8yVL2Bt/Y4dZWsNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YycKUTdt1mFKdBf9fQj/ZrNRKILYXctwAEf6SRt+xV3iRZFzh/K
	3C+bFh7p7eXFycDYT8tteWnNpNjPAxz65KZLlpJQnmhzIL6YR8mboDl8BdicN68/LSMuaRRdp+H
	PZDVuGbreHvGgBl36ExN9xwe1q/b9VSu0vC+YHFM=
X-Gm-Gg: AR+sD12Ps6He1NdBh77zqNg3AhRikMSk8BagiVDdMCg1KvOn92GpYPQE6aDkfNBJ5pi
	aLJJZWmybqHr06Q7Kp2p5wrAlQPMbc0hapeA9NPCKuEphpvhMvrdR1/Dk93RuCvLiiGnMvxgdZK
	f94UtWrtiDIZ0a5VMAjL+T1fXMkYKEvs7KnRb9XJ5TmAVAci4Rhy2kvUXdjz5ojZI6sb/4Ahlph
	PV0F+VtAhnbBvBoGJZBhbeSz7r1hs9uIkXoPG97AG+puRsrsoNadH8MwzShDBSVH7cDkkxp4g4v
	SSa0+Xa/u09jBsU=
X-Received: by 2002:a05:6402:5290:b0:697:f633:47ca with SMTP id
 4fb4d7f45d1cf-69f6ab45963mr905098a12.6.1784821413483; Thu, 23 Jul 2026
 08:43:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720164738.2921802-1-nicoyip.dev@gmail.com> <CABBYNZ+G3jD3A6-k1fEm2sSRa27o8s0PNN_arzVa8de-eJK8oQ@mail.gmail.com>
In-Reply-To: <CABBYNZ+G3jD3A6-k1fEm2sSRa27o8s0PNN_arzVa8de-eJK8oQ@mail.gmail.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Thu, 23 Jul 2026 23:43:21 +0800
X-Gm-Features: AUfX_mwwyaNw9z-1nV9cpcV4k46oEw0QUp3y91y5WUTGsxw741-07Wj9uXIfycM
Message-ID: <CAAo+4rWXA=zojvcZPM-WN2L1rPWNNYZRhnj70AgJ4mRvd=o9cw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: Fix scan response data UAF
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

No problem at all, a v2 patch has just been sent to address the
similar problem in
other functions.
