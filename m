Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29855D72F
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 23:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710198049; cv=none; b=OzOBIOAYm+s5wTUXqAownBKikzqnN3MaeVVnmSTb/2vuAZA2FVCpTFGlHpqFA88THTX0Qyhe46UHNA9wS8QqxMYDNDZ5JoAE64lDW/tzQAcL5oQllLM4/DoHyGLDeC0JWlc5OWOtWKJulZhVhP/2JS2cLSigMWJx6jAlHnk7xFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710198049; c=relaxed/simple;
	bh=51jLP5eea8YD8pcyEY+wB7FM7aQjHbGhUXSWR/QvDTY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jqzbi10yb8H0JEE5RqRRgeabf6FIc10IrETe5CdBwgcCqET8V6Cj0diZadPh2ADJ6yy7KkUpR2p80TVX0urVuvdEv4hEdFceFK8gjNPDqbtR8155miJiSFw6hubvLgRkLrDle2UtTnTlYSZr8m+BFeFoQYa6x2keUpATgMAFoj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4JAQkvx; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4JAQkvx"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dcad814986so37706015ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 16:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710198046; x=1710802846; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CDsfszuORYuCq3+LG+U6R7ZixcxMP1eAFOQnHGEK4+k=;
        b=R4JAQkvxESNkvFPSBgGLQaxdA1BwOeLAjMvkR2Bar8bU+bpj+yqh2+uR0Re4Ey8VAV
         oh9E6kLVxUhEAFFu3fdaDpyChrnwEIeCWPmZr1roAN1Gdamy9zsEysS4hqTqih2iyr29
         OWnxIMBZuIIG7nhbrz4H3iyxV86orRSRur0p0uXCXmO4fjxJN5O6n4u23GQrvDB28sFE
         Ya/CPfq8LQlvAZ+g231U0zamkT3Q1iL2VBdZK+DnGbleF+dvOW7W/csZIoQPPbgRxLeE
         saFshKqGzf8E2ZLCv0LDSi6eJSA5Ud8CNEhrCZehfuZo7ebuczLZcPsbQbWGRUmcnB76
         PJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710198046; x=1710802846;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CDsfszuORYuCq3+LG+U6R7ZixcxMP1eAFOQnHGEK4+k=;
        b=p0wRPvf9x91m6aHRjN161K657qI9EZIN4da5ZypN4nJFW3JyYEdd2fg+8dh+g1IRd6
         RxacHd0N/tKW4EKHTTP7C/cmWWeOiXD7nuHym75bim/sIrL4o4UOOnNgSvC4oe/tXs5p
         MsaYORzuto1f6HDy3jaxv7pWm7Y22FxobPRuV8P8eA3DGtUU5Lr7OG7/FJtdfMkYGOSA
         QmiXkfAcBqYZKyuGej6y6766Uc8yV9PnvfyDPmip6J8gVhZOWwCfCgdb1DkhLcEpmKoa
         uA3OwifyvAwik5CekAwhKQZPa1Im7E860uaAr9x3NS95mBlJcAG9mEzxl/LrJeFmM313
         qdXg==
X-Gm-Message-State: AOJu0Yzg++DbSwJyf0a8sToKqJyaaGFoGnHSzEoTXW3ofdCr0YaZGu+g
	apo0XnAogVZWf0jcPp4gdfJWRj3VBvOHnAZkvNv5lfENiY+ATy2jWYKk28/b
X-Google-Smtp-Source: AGHT+IG4EqLR7ALLcSKbNdYFKIKs9WqMFngp5cJf0CkazT6j9JKRdP1dT8kNSTTSFSjryxy+klDbVg==
X-Received: by 2002:a17:902:a387:b0:1dd:b77a:d825 with SMTP id x7-20020a170902a38700b001ddb77ad825mr272942pla.28.1710198045729;
        Mon, 11 Mar 2024 16:00:45 -0700 (PDT)
Received: from [172.17.0.2] ([52.190.187.47])
        by smtp.gmail.com with ESMTPSA id n3-20020a170903110300b001db8145a1a2sm5199409plh.274.2024.03.11.16.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 16:00:45 -0700 (PDT)
Message-ID: <65ef8d1d.170a0220.42a39.e489@mx.google.com>
Date: Mon, 11 Mar 2024 16:00:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4687214857137254624=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v3,1/4] shared/uhid: Add dedicated functions for each UHID opcode
In-Reply-To: <20240311200004.962953-1-luiz.dentz@gmail.com>
References: <20240311200004.962953-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4687214857137254624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=834439

---Test result---

Test Summary:
CheckPatch                    PASS      1.28 seconds
GitLint                       PASS      0.74 seconds
BuildEll                      PASS      24.02 seconds
BluezMake                     PASS      1711.42 seconds
MakeCheck                     PASS      13.45 seconds
MakeDistcheck                 PASS      176.18 seconds
CheckValgrind                 PASS      246.00 seconds
CheckSmatch                   PASS      346.82 seconds
bluezmakeextell               PASS      118.15 seconds
IncrementalBuild              PASS      6271.33 seconds
ScanBuild                     PASS      992.67 seconds



---
Regards,
Linux Bluetooth


--===============4687214857137254624==--
