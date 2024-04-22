Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1112452F92
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 08:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713775897; cv=none; b=RwkkdYURHYRT06Ap0WrQGKIdDoZiMK+sgR4Ksx2WlT/zGvqOrPvNrCElMh3kYixZedrHasmSriUcIZpI3Tn/yAYiwhJKHBqiuaqyJl+Y3WofWn7ISJtKd/NovcMu1sCJ3C/a+YEg4zRgH+KIQma4easvwoaD/NgPMlAP/Lvy7WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713775897; c=relaxed/simple;
	bh=aaWJhrxHefW6OYM1Lm42mdnzIMmKYx7z/3WTEesws2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZmrNr1B5kCJl/qVNMxOcHHAyyJqVquZxNn/2mhmczd2Obf7Pew9JV6YOaPYm2E0j9gFlhejV+ohj09xwVWXdwAJaBW1Wgqr7oDtC1vBs0wRdRzwnB40aMFzVKTpb60CRVGDCVmjVkAgdak4mg2gjjR7cOgNwEDR8j+YhlyXt14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wKRmLQ9Z; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wKRmLQ9Z"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-de45e596a05so4483198276.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 01:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713775895; x=1714380695; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aaWJhrxHefW6OYM1Lm42mdnzIMmKYx7z/3WTEesws2M=;
        b=wKRmLQ9ZHC9A/HHsxL1KGOPiXmgSueV5K35qSZMBi8W9eX09AHF57mwT+YY9niZ/dv
         Ng6LITR+Cz7blGF+F1ic4heVsgKX087kpx2KrKr8Rtz5mW1fSYhgMoT8iqxffc5mNJRA
         gBns/E6oWDNJWDn3yXuYl97egcvF6oJ8dif6NQzZ5VyTCN4Co/I+iTS5n2GiBYjW/KFq
         kyuWn9KSL05VzCpf0R+eX3TMes0ik8mk68nQYHkOr1RUjhySdCkATejc8mXxo0PHSBQ2
         MgaRQ8JisSZWCpB6/mbYD0f36bLVP5e6ByPkpMCScR1Q+mXgW+N83cIpo2jjPkDAKgRP
         f4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713775895; x=1714380695;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aaWJhrxHefW6OYM1Lm42mdnzIMmKYx7z/3WTEesws2M=;
        b=NoYMLGQgEewP7A5+5W4n4sltIGCFxsKLQQJ+1oCjidYKoI+v/k/PmqAWqj/4a2Soqd
         4NZMRtegJepFlD4Ij11urHR/i5sw1J3zCRS/EBtDZchyvKf/7ekdDhoZZ5R7y9FbX/t9
         /ZPmJl+xCgTU9ev1RefnkedMjYoJo5TLXeu0cFfp7gEc3L8S8/g3/vMGrjGhX4+RRp9/
         eZE/iLSqyZADCE2SU67KK1wdZRYTkMMKHyn/bw1CtT7pEjwwoY/HywzuCfL39vF4iVSm
         sDZ3ONatZqvo8TP3itCqNtoEsJqJ7abThDQcQXfUap5LROhroOWtakoAygyC2bBuNBxm
         wVTw==
X-Forwarded-Encrypted: i=1; AJvYcCVPNzpGJhAkieEbgXwu4HpptXaWjhejwlUOrk3Fb5OcrqkkQnE7VK16ZvCr3alyjZ7YaITbPhkt1y9WtjnQ2oIJT5IpdMbaMF0VBlvXBIOF
X-Gm-Message-State: AOJu0YyrS7OriWmZhs7MENERPeEhHaoz4Ja6KwkaLPAEaqHxrx86pb6F
	iUBuDpqt7P/aPvyp6iQB/gUbajOP4G0bt8rfvk8AxG0K7C00xunXhG5qfBaDRXy5W5yvpHATE2C
	xKMoW+yqnag+6GgoWGj74ElPHH6NypMIpASfsFg==
X-Google-Smtp-Source: AGHT+IGa0GuupdMNJ1epjmn8Wpx5q6rHYjGPtTWalVI0uAb5KutY6EIOzU4z2zWEvfy1Zqj7s2LYy4MLxWJI1kqtXsk=
X-Received: by 2002:a25:86ca:0:b0:dc6:52ec:7ff8 with SMTP id
 y10-20020a2586ca000000b00dc652ec7ff8mr9108028ybm.4.1713775895134; Mon, 22 Apr
 2024 01:51:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1713564212-21725-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713650800-29741-1-git-send-email-quic_zijuhu@quicinc.com>
 <369512e2-f091-4370-bce5-9ac32178dc4d@penguintechs.org> <a6ae69ad-b602-4cfc-9f76-8932f357d30b@kernel.org>
 <c0f7036d-c129-400b-85a2-1414ec3d2622@quicinc.com> <dc17aea1-9399-4c2b-8775-fa0a7f602035@penguintechs.org>
In-Reply-To: <dc17aea1-9399-4c2b-8775-fa0a7f602035@penguintechs.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 22 Apr 2024 10:51:24 +0200
Message-ID: <CACMJSevocRot6J06uvridRw9MZFftJrkCyYBgXhLnwfapVPnCw@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Fix two regression issues for QCA controllers
To: Wren Turkal <wt@penguintechs.org>
Cc: quic_zijuhu <quic_zijuhu@quicinc.com>, Krzysztof Kozlowski <krzk@kernel.org>, luiz.dentz@gmail.com, 
	luiz.von.dentz@intel.com, marcel@holtmann.org, 
	linux-bluetooth@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Apr 2024 at 07:21, Wren Turkal <wt@penguintechs.org> wrote:
>
> As the user who originally reported thes issue, I can confirm this. I
> was introduced to this regression because I use Fedora Rawhide on my
> laptop, which builds and pushes kernels based on mainline very regularly.
>

I don't doubt my patch could have caused a regression.

> Here is my description of the regression: After the reverted change, the
> BT hardware in my laptop (qca6390) will only work after a cold boot when
> the hardware has only be enabled once by the driver. Once the hardware
> is enabled, the process of disabling/re-enabling fails. Also, the
> hardware cannot be enabled after a warm boot of the laptop.
>
> Among other things, this makes logging into KDE Plasma break my
> bluetooth mouse. The cause of this breakage appears to be that Plasma
> disables/re-enables bluetooth hardware upon login.
>
> GNOME operates slightly less badly in that bluetooth stays enabled.
> However, if I manually disable the bluetooth via the ui or by restarting
> the bluetooth service with systemctl, the mouse fails in the same way as
> happens with Plasma.
>
> Once the bluetooth has failed, the only way to fix is a cold boot and
> only enable the hardware once. I cannot remove the modules (btqca,
> hci_uart, and bluetooth) and re-modprobe them to fix it. I can't restart
> the bluetooth service. I can't do both of those things. I haven't found
> any way to re-enable the hardware beyond cold boot with bluetooth
> service enabled.
>
> If I disable the bluetooth service and cold boot the laptop, there also
> appears to be some kind of race condition as not enabling bluetooth
> service very soon after loading the hci_uart and btqca modules during
> boot puts the system in a state where I can never enable bluetooth. I do
> not know what causes this specifically, but my theory is that not
> starting the bluetooth service immediately puts the driver in a similar
> state as when the service is started immediately. Maybe some kind of
> lazy initialization that is forced to happen more quickly when the
> bluetooth service is enabled?
>
> Any way, this reversion by itself (which I manually did after a
> discussion with Zijun before getting his test patches applying to my
> kernel for test). However, this reversion did not get the hardware
> working after a warm boot.
>

This all sounds plausible. However just reverting this patch is a
waste of time as checking IS_ERR_OR_NULL() on the return value of
gpiod_get_optional() and continuing on error is wrong as I explained
several times under Ziju's emails already. I provided a suggestion:
bail out on error returned from gpiod_get_optional() even if the
driver could technically continue in some cases. I don't want to have
to argue this anymore.

Bart
