Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431955B666
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 10:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713177400; cv=none; b=BUBQjNw3f5vGxfmALDQ6QUuHEcyI0nrLIwGMfUZU8aDKanum8HhID3FQXH5silLlDT9BS01FaFGkIdS1mv0C9zCexqXOAmbV3wTrBKH8a2SxkdkuXDMuqF26maFHqH9aIWSdlBGczO/chbiKy5u3vnbQm98dqLOZMWnIAanjDsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713177400; c=relaxed/simple;
	bh=TFiXoKiCB+6zyRbF2eseYXZgYOJtWwE5Ko7P4W9uCTU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ccOA50AK8Vvvu9YLeqnSntMpFpVfqfjmY5fPhA80sK4pptoRbPJJhBqnVcctqshki1qc0PaCVYIM9AFK9VhoGBG+yZOBBtZX4BAY64gvJvMOPBvh9IZI3tDyTrR3N/M5PFP9UlEWT72h/IUPB0DVBfBUfYiOvOEsxy1HI8xiSW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZtnnzgp; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZtnnzgp"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e5b6e8f662so20265345ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 03:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713177398; x=1713782198; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TFiXoKiCB+6zyRbF2eseYXZgYOJtWwE5Ko7P4W9uCTU=;
        b=jZtnnzgpz2uIL8qslrKvnHdbHlkeqecHDZ8JFt3FZI49elGoZLPvU+nZVI25Q+xTRN
         rBPRs9OZ3hHZf16nfz6BkfYm25LaUc/tRdfsCxdlDSIziy3MVIdbVpoJWrXyq/WXrtb2
         bs9NBWgjmUj7kkiRhYZJNQfbXmIdwdh5iP98d0TQeyglN5MUrLTzKlE5/so8YkPC0yl+
         XuSCcfol/e4UzLC/Da01PDCmxtImxq3VUaDkDLMH+Q5Ig3k2L47Z9kuMHVsdRtCHUaHu
         HjqYruZLTJfG36fUgELD8nx1rblRI/iBUL+A9o7cTDSpVIDXToD3BkFFJlzY2LtnN02o
         27Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713177398; x=1713782198;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TFiXoKiCB+6zyRbF2eseYXZgYOJtWwE5Ko7P4W9uCTU=;
        b=LKtnvPrmRY9o/G/n2ZQeureyT3p/yuAm4oPopW4WQoFrthdg0QF48zk6JTnkii11B4
         Cef4LBhQTIAhYiMRwBvpmKnPLTjuSVQdzHcakQwopXk0AHKIwQq5Kb5Dq9YkavhH1uEe
         iBwB9/qYsSQjXLtkBUfI9L4phxF8GeiiMV49rOhMV4Y//sfy3amalBxW79f3HgNKf7DS
         4wmkdQNRDkQB7E82WGZKJYvjrY1b+rvywM+P+opTSllXMywCPUSiRM754nBjd2DzwuWh
         09+BmnqEvZ51PkliuneUhvB6rujlwAWbi7pwg/8tbjin/JnJ0zRtyrvg/sfKG65tfokh
         uA1Q==
X-Gm-Message-State: AOJu0Ywp0pI+ukwz7+BfslmlxaeeIFMEeTLq1QLM2VZvIpQfbJFOd+EC
	eKcKg+7i7ZamF2pO8pAkAV+acL0Hz/93IAapllVyFXG5ogCDglwyZ0V9DA==
X-Google-Smtp-Source: AGHT+IHr1Xz3ht2+WfASAhyz0PSr4lqALXD1+jNR2cv8LiY67ZqDIibe0EaCQ4Vr9XsWGYc2GUovig==
X-Received: by 2002:a17:902:a511:b0:1e2:616e:2883 with SMTP id s17-20020a170902a51100b001e2616e2883mr7346612plq.24.1713177398191;
        Mon, 15 Apr 2024 03:36:38 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.114.106])
        by smtp.gmail.com with ESMTPSA id l1-20020a170902f68100b001e3e244e5c0sm7574749plg.78.2024.04.15.03.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 03:36:37 -0700 (PDT)
Message-ID: <661d0335.170a0220.90a0.4732@mx.google.com>
Date: Mon, 15 Apr 2024 03:36:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4899788906658960557=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v2] Bluetooth: qca: Fix QCA6390 enable failure after reboot or disable
In-Reply-To: <1713175927-13093-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1713175927-13093-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4899788906658960557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/hci_qca.c:2362
error: drivers/bluetooth/hci_qca.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4899788906658960557==--
