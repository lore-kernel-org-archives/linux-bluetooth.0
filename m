Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9C03FEB0A
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2026 17:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774633917; cv=pass; b=B9ILQgNgrU+T3ulOlMZRiHy+Y5Df4tDtqg8+Yp3ss+ojC7pHmtCraYkihfSks4NRy50B3SLOFdC8Cdq4BWrD3eNdWtD6PiojLcvdI8n+HjQUZDpZqrUBUthk9GtDYV2X2AqFGG9JF7NBnTb4lOs+7uue4dEi9L8awirfQHg3KpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774633917; c=relaxed/simple;
	bh=3OUvfFHGuHM2QBTFO9WY8r9kR1/cxJMORvSKgUjxTqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=calNuyQCLmRYVhWy+NMELDu1uZTjkF8wd5fRFhbnTcvgKlaJVHtRxbt2NKX0VCpbhEBGAevACeveIvYMoVdT0pu5KKtyFUp6u+l/1D2HqLk4eN7i9pWKKOz8qbEzzPAlh+zbcw1y2Hu5MBtPega9ElfAgfX68cpOEbx5Il/XObI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o7AGaXO+; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o7AGaXO+"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-65003f40a22so484898d50.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2026 10:51:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774633914; cv=none;
        d=google.com; s=arc-20240605;
        b=UOJs3YIra2mihYGJglZFpPgCHseL2+SpgJGvPAYykDqhpxqZwRt8+B8hO5ivDeGjVv
         Oh6UmW4eVJ6s9A/ThuJrINfeTKsX7FithETnSPj5Tex/ZTxuPj9QRMlFdNHWyT/GRXa7
         1SaBQc+oZROPBQbKwYGK2akg3N1Q7pjtKQ+iLiXHelLbXbzrhwhfoMMofotH8BiEXUv0
         0tslDjOewMmvB4UrOhZvTBXwmfcPcRSZlS00xttMcqM15YlVgUyzzqD7I/zakg27m9w8
         zefI3UIfwL5CKSeg2tPJQorKyyV2NF3kSSRKgQQa8g3UdOQEpI3OehBDb2xvyfxnzMRi
         h/zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IF9FRhjmH8zSwIBkeE7rltrcgfchPDGu/fGIAYdHEUs=;
        fh=VzHQUcqNXfo9CIErvg1SeWJ0dcQTHTn52WIcztfL7i4=;
        b=CHoAlpJ43EjpoW39uQxL4W47ae7Mf58pf1FUCurOrNyYzBoAbEd//wvCyFYnQJ+BKD
         r1OwUwInDrCKkLKRRCIqEEiB9WKFC9JppWWvdZmu2ahMxDHmNP+X8nJQquXjoAaDdz80
         Z6yhkGw+QI4LHbGdO8Y4c3z/BIrdGCWJIFcqQXIHpWxcYwxk2hq/zkH/GV2qjyd8f2BA
         XG0ulD/SMJNB5YRXxdmjrPCaGJ6ZgMh3sr9+KKAlwto0v3rVC4rHBVAVA8YWKEU98SjW
         PjzRM3S0XC9E9u6SJDwoP0X14MuYLz6uBb6ETwqYAFbpac+vej/IXOt+EzZaWBW+tjMX
         e+DQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774633914; x=1775238714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IF9FRhjmH8zSwIBkeE7rltrcgfchPDGu/fGIAYdHEUs=;
        b=o7AGaXO+wzt0deTZP0fraClJolZs1TXFkoq2w1zMzhcsV0HusSyOiJqhaXoKKtPgAD
         Vl0PjfUhVMUKjvZzs2Velz+cr6WEeWlwb1wOX+zISLHV+OFMt5eUrOBKv0B+KzNjK6W9
         3ceQFxcThwdMtZWnFmw+wNmvj/lkFBEUfCEYSSIXtAaNqNcN+MdoJLWPAsTi9x1CvgFB
         ZJojy1mfJ8wmtDap/mEsd5MmAXgdpqcUdGBzrlbQjN3LYMKQks9ZpLxIu3jkqQZkxU/E
         6UvUOkgodxO9WhfqxM5qTXWmH6hWBLm7jrXtCc38emAR0Nu+UJ4lp7AyiG4JQvvnXa+Q
         GDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774633914; x=1775238714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IF9FRhjmH8zSwIBkeE7rltrcgfchPDGu/fGIAYdHEUs=;
        b=EvEBFBYv2k37x52LEvhf0NBJXhDgjp7NXPac8Gzx0DZvlCUtiIcoDEHddOEAQvxDdZ
         5kiwQI1v3t+aEY37VmpYtjdaR1pcTs5sbAo/myuGQYlYLhim43Mu1nT28tuD1Mu0fdtU
         6xY6udDi06R7hGhJqO4oTURIR58ynYnoXQa+q4jU2BSJ0q4yKLUpXUSu2zBwyGHINsmr
         Bmhqj78bh//p+ylevmjqY5xaGaFMRrpU3AwyGwUK5kYt262dguII2jLT54fREF6zZHpq
         gtF+KAueQiw5eMI/M6IVzotueg0oIaGEyvEUOMCzLVida+29Z70Sf9TWCVoMO4YNbh6Q
         c3BA==
X-Forwarded-Encrypted: i=1; AJvYcCXoUakE8YjMLfz9DZDmHS56qGuJFcNrYekaW9IYfgXbazM5GrjNdDidVHsxJGTrgSQtuDNdGMtv1ClNcJYmBFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf+2oM44e7jzO5dgp4B2FEALn7THE3xU8CLzP/WLQ8Q5kTHwQy
	IkoZnevy8skQ9r5ssfVdRICdtdXSGnGZ0fm7F8hxsajcQNx231jG5h1um+mOhwKlS1U5X1nrcnl
	hb1Ped4U5uafXkADilA3SlLwGORhtkNw=
X-Gm-Gg: ATEYQzyeJKR8JxKmTqPFDI+tNq7l7YGnJgWPen4UH0GQTk39AZHErVCv3jYGPjGTI2x
	SdG+33Dxe9Is2ac3kF0z+NNOYeSSQnZqVpOLx6hlI9+pQLhsfTunZ5NPBCktEMe8NFrwcYEMZ0B
	2AKUstwTcbwWx0aQA/URovKCGSXIo7XKkKNrS6Kz9U+ALOBwi9mJFfO9KetJcZ95CjmM8Eef1J0
	t2+amXS7WdOH3qSfs8AQbdv7ShfvNwjUXULaMN8IO7obaBYouQqYUxhYADG0wmqV6KLPOCQmvlk
	wnMnaRGBz+w/FeLz6OW4VEGDZzv8dagZWDk3Nx/uKAp6wtAODk1La1pWP9PVkOM+Vz0+kQ==
X-Received: by 2002:a05:690e:4843:b0:64c:a4ab:e4d8 with SMTP id
 956f58d0204a3-64ff720cb83mr2835610d50.20.1774633914461; Fri, 27 Mar 2026
 10:51:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327083258.1398450-1-shuai.zhang@oss.qualcomm.com>
In-Reply-To: <20260327083258.1398450-1-shuai.zhang@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 27 Mar 2026 13:51:43 -0400
X-Gm-Features: AQROBzDahLri4nXUWvYxFtl5RrxDtiNo6y7zoELouPOJAeBfQtf-OGwuWxOEQLk
Message-ID: <CABBYNZKwxh1R=EcBpqNpsO=pyJ7Z47qgYUQtrpG9QSC6sK3SpA@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: qca: Fix delayed hw_error handling due to
 missing wakeup during SSR
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com, 
	wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com, 
	mengshi.wu@oss.qualcomm.com, Shuai Zhang <quic_shuaz@quicinc.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuai,

On Fri, Mar 27, 2026 at 4:33=E2=80=AFAM Shuai Zhang
<shuai.zhang@oss.qualcomm.com> wrote:
>
> From: Shuai Zhang <quic_shuaz@quicinc.com>
>
> When Bluetooth controller encounters a coredump, it triggers
> the Subsystem Restart (SSR) mechanism. The controller first
> reports the coredump data, and once the data upload is complete,
> it sends a hw_error event. The host relies on this event to
> proceed with subsequent recovery actions.
>
> If the host has not finished processing the coredump data
> when the hw_error event is received,
> it sets a timer to wait until either the data processing is complete
> or the timeout expires before handling the event.
>
> The current implementation lacks a wakeup trigger. As a result,
> even if the coredump data has already been processed, the host
> continues to wait until the timer expires, causing unnecessary
> delays in handling the hw_error event.
>
> To fix this issue, adds a `wake_up_bit()` call after the host finishes
> processing the coredump data. This ensures that the waiting thread is
> promptly notified and can proceed to handle the hw_error event without
> waiting for the timeout.
>
> Test case:
> - Trigger controller coredump using the command: `hcitool cmd 0x3f 0c 26`=
.
> - Use `btmon` to capture HCI logs.
> - Observe the time interval between receiving the hw_error event
> and the execution of the power-off sequence in the HCI log.
>
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> Link: https://lore.kernel.org/stable/20251107033924.3707495-2-quic_shuaz%=
40quicinc.com
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> Changes v4:
> - add Acked-by signoff
> - Link to v3
>   https://lore.kernel.org/all/20251107033924.3707495-1-quic_shuaz@quicinc=
.com/
>
> Changes v3:
> - add Fixes tag
> - Link to v2
>   https://lore.kernel.org/all/20251106140103.1406081-1-quic_shuaz@quicinc=
.com/
>
> Changes v2:
> - Split timeout conversion into a separate patch.
> - Clarified commit messages and added test case description.
> - Link to v1
>   https://lore.kernel.org/all/20251104112601.2670019-1-quic_shuaz@quicinc=
.com/
> ---
>  drivers/bluetooth/hci_qca.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index c17a462ae..228a754a9 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1108,7 +1108,7 @@ static void qca_controller_memdump(struct work_stru=
ct *work)
>                                 qca->qca_memdump =3D NULL;
>                                 qca->memdump_state =3D QCA_MEMDUMP_COLLEC=
TED;
>                                 cancel_delayed_work(&qca->ctrl_memdump_ti=
meout);
> -                               clear_bit(QCA_MEMDUMP_COLLECTION, &qca->f=
lags);
> +                               clear_and_wake_up_bit(QCA_MEMDUMP_COLLECT=
ION, &qca->flags);
>                                 clear_bit(QCA_IBS_DISABLED, &qca->flags);
>                                 mutex_unlock(&qca->hci_memdump_lock);
>                                 return;
> @@ -1186,7 +1186,7 @@ static void qca_controller_memdump(struct work_stru=
ct *work)
>                         kfree(qca->qca_memdump);
>                         qca->qca_memdump =3D NULL;
>                         qca->memdump_state =3D QCA_MEMDUMP_COLLECTED;
> -                       clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
> +                       clear_and_wake_up_bit(QCA_MEMDUMP_COLLECTION, &qc=
a->flags);
>                 }
>
>                 mutex_unlock(&qca->hci_memdump_lock);
> --
> 2.34.1

https://sashiko.dev/#/patchset/20260327083258.1398450-1-shuai.zhang%40oss.q=
ualcomm.com

Not saying the feedback is actually valid, but if there are other part
of the code still using clear_bit(QCA_MEMDUMP_COLLECTION then perhaps
they should be updated as well?

--=20
Luiz Augusto von Dentz
