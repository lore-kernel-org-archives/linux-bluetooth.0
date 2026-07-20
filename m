Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160F442CB1B
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555333; cv=none; b=n6eAkIzxCWcuQLMGJ+zkt+siHCeBmAwpqMfon8S6bFV8gxZ2qTzItitvulMrJ6bDc8JKJ9RY9dNNUPwhBhRopm7Kwzbgm2yphm5XFCKBR3Ux67EyYY/NmNa6kbnGuxxP19qfpZE4pEL8/BQD7967LNAh1mPRYJISUGtkOVP0olg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555333; c=relaxed/simple;
	bh=VXTL0nWUs6ARY7/mBgCqD9/Pk4RANoGqiEM640qRpmI=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlWMmUcLvuZGbiDR7akQ4/hRXlYOva3DGrmQwiWbu601j9mJqtBCiak16AujmKIj/G8cMtQkqoTqeKB/EUKdIyW6jUDNxPc2qfXcwddYB8qtMatspxTt0OgOxLhJ0pzDIns5VaT6iBqtGQz6P5U/614rOK/i19Or0oTLKedmZwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7Uuk7al; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7Uuk7al"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D224B1F00ACA
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 13:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784555329;
	bh=L8C49SuWPc7UrHJM/7J+so26KwjGuUOI0PDx4EtC0qI=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=I7Uuk7al+n5XzzlG/XnQBVnxY7TZgxpnqsXwWLApjhiG+g/vX4f98U+9S4j0CuOXN
	 3f85WqSEv7syaPxiHzQNQt7OXy6syNK2q7cc8W0pj/Y7HK/HdExnrG+gYCzoqwoslx
	 FF7lHTtj0dMj/7AaOrUc/qaand8UNGH6rnk7uON6qph/amzVe0/rfHH4YXUZuMaNPW
	 hrQvGv5q/f9cdOg/MJfA3xaJHSU1Uc6oN9dpTDjHlNFKwrKTHHWeBTuhCAyPp/AFfS
	 PVzDT0ntC4ezmV4fp7k7KfN/X1o3xm+Z9hkDTMPiTclh8toIYxO6KVl/MzhQaV/SZE
	 WiVTMz5Vr8aEA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b14d1f9315so8831329e87.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 06:48:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpHDcEP+JD8cOdEtck80jY1/ERHrWfJ0NxPZ2TbYQYSAFy7ODEOiTjx6/fl4X9pXN7pga/DEDd5mQAr4/BL9RY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG6RHfOnO4Hfi9Q1fSLtTuUZwdWcCiODejMT7+cqPNIdNqsR/+
	RUbzQKa52SCdBJrPydcNBYgXZT9C8UcOJpzI60j0l1PsZef4sqs8IzYajMKA2Sfduv6lOYt/r2K
	fqKnY3rg0YnlZrnwHCgx4h9fzZWuixzS0Y8UFjNNdxA==
X-Received: by 2002:a05:6512:282:b0:5ae:b24c:7723 with SMTP id
 2adb3069b0e04-5b28f875b5bmr2211818e87.17.1784555328484; Mon, 20 Jul 2026
 06:48:48 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Jul 2026 06:48:46 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Jul 2026 06:48:46 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <0CB2D8D715AB9933+20260713072543.3348755-1-raoxu@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0CB2D8D715AB9933+20260713072543.3348755-1-raoxu@uniontech.com>
Date: Mon, 20 Jul 2026 06:48:46 -0700
X-Gmail-Original-Message-ID: <CAMRc=McFRb8iZaDLY=DfLfDDA9WFJeNG94CaQeF3RJDgyqe8bg@mail.gmail.com>
X-Gm-Features: AUfX_mw4AS4rGrPFiCIt4A6Wg2v_GfsNMetY7jsTwq9BAgndocjnJSk4IIzAsLs
Message-ID: <CAMRc=McFRb8iZaDLY=DfLfDDA9WFJeNG94CaQeF3RJDgyqe8bg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btqcomsmd: destroy RPMsg endpoints before
 freeing hci_dev
To: raoxu <raoxu@uniontech.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, brgl@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Jul 2026 09:25:43 +0200, raoxu <raoxu@uniontech.com> said:
> From: Xu Rao <raoxu@uniontech.com>
>
> The command and ACL RPMsg endpoints store struct btqcomsmd as their
> callback private data.  The receive callbacks dereference btq->hdev
> without taking an hci_dev reference.
>
> The current teardown order frees the hci_dev before destroying the RPMsg
> endpoints in both the hci_register_dev() error path and the driver remove
> path.  If WCNSS delivers data in that window, the endpoint callback can
> run with an already freed hci_dev and pass it to the Bluetooth core.
>
> For qcom_smd endpoints, rpmsg_destroy_ept() closes the channel and clears
> the callback under the channel recv_lock.  The receive path holds the same
> lock while invoking the callback, so destroying the endpoints first both
> prevents new callbacks and serializes with any callback already running.
>
> Destroy the command and ACL endpoints before hci_free_dev().  Keep
> hci_unregister_dev() first during remove so the HCI core stops issuing
> operations before the transport endpoints are shut down.  In the full
> registration-error cleanup path, return directly after freeing the hci_dev
> to avoid falling through to the partial-construction labels and destroying
> the endpoints twice.
>
> Fixes: 5052de8deff5 ("soc: qcom: smd: Transition client drivers from smd to rpmsg")
> Fixes: 9a39a927be01 ("Bluetooth: btqcomsmd: Fix a resource leak in error handling paths in the probe function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
