Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743E446553
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947447; cv=none; b=Q//bardBl8OzgPR1RXbsMUjRFzraO5GJKUalniDPTNbEuUSeXSEiGkDWJugZyFLt7YjxJZHoJ4MG9r6j+uygoinebKrISWtkfG5rBXiwFw6P1EvAxBoTbcpGrFN5VnNI7rteRRA4kT0o5XlAwycj++42xXDz1ad7FupnEl4qb3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947447; c=relaxed/simple;
	bh=8WP4F1/iqnQozfvR6MwyaTUwTNNzxBrfyOx9I4RD/08=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=F1zsfqzpJXKeeLal/jQ6gra25r57iJ//JAeNMciEo6HquBDitxOrwkYSbn8Nrc/lUvBSq3N+TOHznluZYwra7uqIfXllNFxY39As0Xj/OzieFLXIrD2ntzYAeA1WOh9LKzT4Gs69Und6gF5vr/UlugKf8aUBweikeXReZU+ASII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUqbQnxs; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUqbQnxs"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6dbebe4938bso542475b3a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 10:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705947445; x=1706552245; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8WP4F1/iqnQozfvR6MwyaTUwTNNzxBrfyOx9I4RD/08=;
        b=KUqbQnxst+ReEPMb7Kbp3lKdRDEC/6f+EzUaaKKUWyihjJXJueeW4G1gIUjGDOnDgl
         l2IkiL4ktGkLPNr7zSjOCp73c1wdgklCeoIgKoRsyXVqw3I1H2F4IOHNl7HfEwaeLGh4
         LU0emxJa/yzjqoGKz5krNI4s9ByriaHMSeVZ/Q+iyB2Q6dtEmDG2ueo6jWloUI6wl1B9
         nT/vRVHdH5eUBdgfybr9367FkczYAMzU4IlFhzggBIisDqNGSZOsab+n/vpfzrIMKe3k
         4xpajbK7h3I13mzznaL+5YJfvkAWbqYQBeH/tEGg1VTjCSkZo2z+xuX+hvb3uy4Ds5Mt
         OUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705947445; x=1706552245;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8WP4F1/iqnQozfvR6MwyaTUwTNNzxBrfyOx9I4RD/08=;
        b=mzKBsdupLyUui5vsIKJByIl+Iq16bWkJYV9Myic5OO6PL2RNieSPyukuaMgpZr9xhZ
         9RhiFJfe2S/ndZHqxurp/Vl4zYOO15qVE6TySL0UGwHlqHZKYJz83Dnd+dPaPK+DBW9Y
         4isE0bj154TXoayG2F6hmVKv/wwTu1N2nE8LWfgrYfEXfgvcSCYz7LXqCHFncfAlX6mT
         hwXgHFJ9mFrLQAYd9D4feAjHK+lNDj70dePgPI7CMHEE17rSB7qIl9kK+C4wxwot6GU0
         lPQQmbYWfEWvopGgOIxL9RJxBxsW6sN5dS0WBzLsNeHXh7LnavHio+tFkjZLcURNCDGQ
         etpQ==
X-Gm-Message-State: AOJu0YzXc2CD5uhMWLZlmRY6mzzcJkHWkL+mDe8Z+Mfr6uv/MoPtfCcE
	L7ZNYD9qsRkd4PqMOkJm+wgLz4UU/wlLbFMiwBFhvRR9NvHkbLxcqD0aDV7C
X-Google-Smtp-Source: AGHT+IFeyayaTqNn+izljIgY3iKPi6i2J4Z819TQTJgTX5wSpRkA9lI69nf3GpA1rSTD0dg8NJo3TQ==
X-Received: by 2002:a05:6a20:d386:b0:19b:fb9a:286a with SMTP id iq6-20020a056a20d38600b0019bfb9a286amr2790947pzb.66.1705947445457;
        Mon, 22 Jan 2024 10:17:25 -0800 (PST)
Received: from [172.17.0.2] ([13.91.68.164])
        by smtp.gmail.com with ESMTPSA id z8-20020a056a00240800b006daa809584csm9793364pfh.182.2024.01.22.10.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:17:25 -0800 (PST)
Message-ID: <65aeb135.050a0220.27468.357a@mx.google.com>
Date: Mon, 22 Jan 2024 10:17:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1849114615159234014=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, francesco@dolcini.it
Subject: RE: [v2] treewide, serdev: change receive_buf() return type to size_t
In-Reply-To: <20240122180551.34429-1-francesco@dolcini.it>
References: <20240122180551.34429-1-francesco@dolcini.it>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1849114615159234014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btmtkuart.c:383
error: drivers/bluetooth/btmtkuart.c: patch does not apply
error: patch failed: drivers/bluetooth/btnxpuart.c:1264
error: drivers/bluetooth/btnxpuart.c: patch does not apply
error: patch failed: drivers/bluetooth/hci_serdev.c:271
error: drivers/bluetooth/hci_serdev.c: patch does not apply
error: patch failed: drivers/gnss/serial.c:80
error: drivers/gnss/serial.c: patch does not apply
error: patch failed: drivers/gnss/sirf.c:160
error: drivers/gnss/sirf.c: patch does not apply
error: patch failed: drivers/greybus/gb-beagleplay.c:271
error: drivers/greybus/gb-beagleplay.c: patch does not apply
error: patch failed: drivers/iio/chemical/pms7003.c:211
error: drivers/iio/chemical/pms7003.c: patch does not apply
error: patch failed: drivers/iio/chemical/scd30_serial.c:174
error: drivers/iio/chemical/scd30_serial.c: patch does not apply
error: patch failed: drivers/iio/chemical/sps30_serial.c:210
error: drivers/iio/chemical/sps30_serial.c: patch does not apply
error: patch failed: drivers/iio/imu/bno055/bno055_ser_core.c:378
error: drivers/iio/imu/bno055/bno055_ser_core.c: patch does not apply
error: patch failed: drivers/mfd/rave-sp.c:471
error: drivers/mfd/rave-sp.c: patch does not apply
error: patch failed: drivers/net/ethernet/qualcomm/qca_uart.c:58
error: drivers/net/ethernet/qualcomm/qca_uart.c: patch does not apply
error: patch failed: drivers/nfc/pn533/uart.c:203
error: drivers/nfc/pn533/uart.c: patch does not apply
error: patch failed: drivers/nfc/s3fwrn5/uart.c:51
error: drivers/nfc/s3fwrn5/uart.c: patch does not apply
error: patch failed: drivers/platform/chrome/cros_ec_uart.c:81
error: drivers/platform/chrome/cros_ec_uart.c: patch does not apply
error: patch failed: drivers/platform/surface/aggregator/core.c:227
error: drivers/platform/surface/aggregator/core.c: patch does not apply
error: patch failed: include/linux/serdev.h:27
error: include/linux/serdev.h: patch does not apply
error: patch failed: sound/drivers/serial-generic.c:100
error: sound/drivers/serial-generic.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1849114615159234014==--
