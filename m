Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A337419E806
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 10:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732097815; cv=none; b=tI7hLlCF8zzlofktSVSj81xsORTv8GlANORwNJUK7aox9x6QV/xj9Fo1r2ZP2Vx/wmIecX2E3Gq4+DJ0LpvEALdXgZqTNCe7ny620V12NFsK1Sa2y4oR2f4Ablym/XKMOkFjTi6WGxossSpvRLX7Jwn7f4/KbEuAgMuj6U5BjZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732097815; c=relaxed/simple;
	bh=GdHpRA5iwF65WnmXorws97sx3NBPZ+iDYRJMNlWdZxs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jiXwT4+3XbIBTJRZdCQr+SQ6Hx+6DyDLuxI5WzV2y5eaxWHGKvTQM+BW+JYqbBNNsc3WGQNJbvOGpdsFLxJj0P00mjd7kTekFNaYI/rn1XuN28iCLMIgRr01Vgw8/wFMDtYPMM4WrPn7N/03DPxiPdv5WMD2f6+m61ue+YUJbOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FX3p9Y/7; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FX3p9Y/7"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7eb0bc007edso2790415a12.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 02:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732097813; x=1732702613; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GdHpRA5iwF65WnmXorws97sx3NBPZ+iDYRJMNlWdZxs=;
        b=FX3p9Y/7hJl0sJEuF/hL6LDKJ+tMqXlqZ1023Etd6aEQahJmqwAv8vYCNFXxmds9hz
         37lf4vCncV9kjY4tOB6ix5WaCxAS8LKzAnkfoWUFLboUutLLnLdMkNWwjT9llcjK+yVo
         ty/cpHmDgjhUYxehxS11GPtPuOGiskWvAO15cp2NK+dY7Y/U+cB6Z40ZwMwz63xdrZtU
         G/BeKiYBrsEIu5WF80ihaBuiapxqk8e9GXOVBgPEdzCp98LcjjXY0tnf5UbNL/vNbGGa
         OyFuDPhSoi9/YR5Ly+PFB5aVbka48k/jbeGvu6f72NVbs2J53ISFjT3iQySjmu8q97vm
         Lrow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732097813; x=1732702613;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GdHpRA5iwF65WnmXorws97sx3NBPZ+iDYRJMNlWdZxs=;
        b=hILwYKssEDhShh1CpZlzAo9Tx04f1I66LAjth384xR15ca1cWsSX9yUzB7WJttBSXI
         wfMFXuMAb3fUjYtl9dmBIict6JnXlVcIJ/5MBbaOK4J93cFEpuX5KOiBmd+loYGLNfne
         pO3nd3xC9cAUMmqXiUYT18nEbsnjUuyzClias3+p7/ywEgO1B8kDfXlbthDIcnNDKg1g
         OGgtcxSeZVBMjAUu6PRj9B2LKa9v5Xmu7RKb6Cy6QQg3X6k6jcCYigFro+UV2YMmvrAf
         F7WvXSpZ/1K1dKaGaERPfWZS67z7G2rbatpGd8NZG4ELlOnUKha0OvrlHdxgGduDfM36
         utIg==
X-Gm-Message-State: AOJu0YwjI96g4KmoDXU8GsJhwpTvBsXpfmO/42MpbI6eYwKq8MMpkPua
	qd5AnWqXxkyQmoi+LzC1j9cKW+V5JljnMGpzbXNDE683ypGqeJ/aB2PF8Q==
X-Google-Smtp-Source: AGHT+IH9EnDSpvAhrpxeooJjVGDZzOxiZNZCqE+9LO4LZQMx3qGkYRiWUjtV4mk8LmvHDUAI29nOFQ==
X-Received: by 2002:a05:6a20:258e:b0:1db:db48:50f7 with SMTP id adf61e73a8af0-1ddb0818fb8mr3223983637.28.1732097812696;
        Wed, 20 Nov 2024 02:16:52 -0800 (PST)
Received: from [172.17.0.2] ([13.91.68.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724bef8fb30sm1242944b3a.111.2024.11.20.02.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 02:16:52 -0800 (PST)
Message-ID: <673db714.050a0220.5f561.3308@mx.google.com>
Date: Wed, 20 Nov 2024 02:16:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8443036952866927531=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_chejiang@quicinc.com
Subject: RE: Add qcom,product-variant properties in Qualcomm
In-Reply-To: <20241120095428.1122935-2-quic_chejiang@quicinc.com>
References: <20241120095428.1122935-2-quic_chejiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8443036952866927531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi:856
error: arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8443036952866927531==--
