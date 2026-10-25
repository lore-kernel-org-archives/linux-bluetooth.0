Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792930378;
	b=TC7wMo5M66OxBwaA44UXY5kDFLqgeE/fGNAM/0mvkGZxrSVxUhdvnTCwYO5OWlDC/q93
	 H7af3nxz/izW/WLHBc6VGRMeuTUtw29tvYS1JGxprsNc+Nz1yo1HJauhlUn3KBrLy7Tn/
	 GnnFyj+hYO7PjC4QvNMGb0JVfpJHjbxfR8RVtTLp3yIjoqvq2lprT9k5Ib/L0g0T0PZPv
	 eYrJSq2XycJk2I/jZoanhNlmKhJIlc5SwXfgext1CpJLVyue11waLy4+6V0v4pb9eZ1qx
	 vwqrrx3gWbfTQyvVWyOTvU7y+2sv9SSXxPN+T1hvjuBD5RTCeEmC3BXCN1w7EE+MIAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792930378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=wCE0pPgrYRfvdGnMQUS1V07xon8EkGO/fiik/FCvDhw=;
	b=eCCwIvQ5LPY7oCzE0JadJl2WoepESc7xUZhZ7Fba/ugxYKRbQbLiHf+4cqJ6w2tkMS2p
	 iJ+gueaa3YvCrymvmF2K/E9mZIe2mLQOvGuWqi1rIIZUMcUjcYWItM23VnFrMaxP0EYF/
	 gwN/hJVjBPiaZwE4c0nGLshXKXRRT6sHoDEsB3cPWNRqiqiKc6zmbIRxHnVdLz/rnJhca
	 yG+NNEAKEacwL6Ngo9+RVxlmoYLX1hP0ehq0FdPvG77RIMdsAZMCJQMREOoSSHjrUcZpS
	 TbrFFTdDxS0eduTKWBx23RN2nRdpbUozICti9A/VWwXkgZblTkH6A3KaXIjlSMfSwFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bpNcpy90;
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70CD606A321
	for <linux-bluetooth@vger.kernel.org>; Sun, 25 Oct 2026 12:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B70CD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bpNcpy90
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-702fd86d674so1405464eaf.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Oct 2026 05:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792930376; x=1793535176; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wCE0pPgrYRfvdGnMQUS1V07xon8EkGO/fiik/FCvDhw=;
        b=bpNcpy90oJQ3uZj3gKvzPgCYBW8lfkhpKpvHa9zVQabmqIOoDe4pmFoSgyR+jSfL3i
         vEyU92ORFVUktpQVAIhXhkazmeVlCR84QoBs6EA8Cw5zwy8+7T3wQI0vsam+juyZNkfq
         E2POPnlCcdKJME/zmrGqJRt6VPHHBqBVnQVAMC5HNY3q3fXEsiZ5pS2PqxMYD6Dk4yiq
         ZxwqQb3hCUwFqGk7tN+AGQ00VLdGIhV5pb5hi5M5z1DAtu+Tnqq9wYSYFVFP5Se6JAzF
         Jh+MTMf6kOQFLPxgeIkI7GAaLWvnEls5LgST/520p94SMcsW//xJryoZ8lXeYUx63qLK
         fWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792930376; x=1793535176;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wCE0pPgrYRfvdGnMQUS1V07xon8EkGO/fiik/FCvDhw=;
        b=iw9q5fhGKF0P6GJqZHstopRDWTZSdNTCogT3A9L02UGC547jVwrKKD5dgffOmLaWaf
         CwVIBs9XV9ldu2R3yvua4dgT8dQlURtW4Sh6hy9II+/cNiT7xKRU8i5MB87bk3oG+tzT
         mYQPYC9+cdhP4OW3CYlQZE1RbN99Z31L7YlMGePnm+eDsvrpWws5C3YVbaWHHa98aA42
         9tdJwvsKzvv5qm5S2iPE2MEa2hJHsjZ80ViJt7VCKnZPctOwwzmoTLjsKPA8QU5wiUzS
         pkUblWVc6L637URd34EzNX8+qwc77GAOiPV+A+Jm8CnyO3f1h4pWjXNZW4fAWOQUWy/j
         Lbaw==
X-Gm-Message-State: AFq9FYJVFjSlkBleVnBe/oPqEyGNkisSXwqcFgXytWudcOZeMWNmW+6H
	zsoaqqk/724Q685jznIBqfO1pBhnLfIbd10x/2dDrBw7iWsKuYFrcARG+gW1IA==
X-Gm-Gg: AYBFou0lEMkq+vgpJSnbZjXrpO1mzsF+0NG2gaEMDXnM0gq8wcP3iaP77BKKUj669Cx
	04AdhzNB2LixEpbDKTOK75PaheBlgWo4YCwgqXpQJ53+8GFX9xdLngy2t+q+Ih1D0O1ilpLAf1i
	fhf9T8fR3abvqNgtB7MHgnUTa+UTtOGm0yRbRdNDWe3XuoxOcztMrM+zUTb7XwpClSLeCD/XhVt
	xTElmwfnWlMo4qjnKzBZmFdc+9tu2sSUwGhoZA7i9GGJqef52whlS42sQa8PGaJyaYSNSp6X0U/
	2D1UbDIhwMpQ036OM5FyiF/gHeHeLrmjeDdZxurQrjur7ANy9+zGfRVST4MSJuTfo1jXvk4hVLk
	dKKJpxKWHm+1Nr/lUM08t6J0vP4su+fGS+ziIhOxpD/oPgeXDuJZmSYZYLoi7CMxGQxvoZU94zC
	cIOFpQ2ePlpSuCFWPjkVrwa+BxuL2EU89QTCsSHmNZGaSiCZwOW7Le9prGqOurt3Fo3seur1zlT
	M3R/J7UB1nRZrr8nxTUH0OVe1MLa2fqqE5u8PlipB1c8ndq1xiP2doVBjuLcoEt5A==
X-Received: by 2002:a05:6820:a299:10b0:6fa:ae05:1c7b with SMTP id 006d021491bc7-70ba0da226dmr1349280eaf.23.1792930376628;
        Sun, 25 Oct 2026 05:12:56 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.135.145])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70b9dd3a58dsm4323845eaf.1.2026.10.25.05.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 05:12:55 -0700 (PDT)
Message-ID: <6addf247.b31e8986.1128ff.a81f@mx.google.com>
Date: Sun, 25 Oct 2026 05:12:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7002806744657709150=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ye.he@amlogic.com
Subject: RE: [bluez] device: fix loss BREDR info when merge duplicate device
In-Reply-To: <20261010-device-merge-v1-1-65e5e1a79d91@amlogic.com>
References: <20261010-device-merge-v1-1-65e5e1a79d91@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7002806744657709150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [bluez] device: fix loss BREDR info when merge duplicate device
   Pull Request: https://github.com/bluez/bluez/pull/2656
   Created:      2026-10-10 09:07:19+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============7002806744657709150==--
