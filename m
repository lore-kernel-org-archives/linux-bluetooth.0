Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75981481CE
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 18:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721846141; cv=none; b=oGSCTq+tgwXp7HRqQAonSS0svH7niPTwcIsWjiasY4vgJn3CQDqzDMPCDsPpDvylUYaK5VWTCS5lLUfIqTB8+URv1MzLPmiRB4vlCwph+thT1w5an/YLfQG9Vs7Fjz8GWW6yKhtqZKGVdr/gj0kqp4Euwy0kvMg7YAt7Ux5J1Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721846141; c=relaxed/simple;
	bh=eT2Zb5+duJBrelwvR8Xp8bO5UL6Tp5mDVkPGPHp2DAM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jMINTjmA4lfGNoQSlDpe/L3mSYCXRfpEIWo55VcA/pZB+w3oKMrYJwnc9ZqawD7AhR6jDwp5Xw1mz7J/yQFBKCvVKwY4b6RMuYUJOIYmKD5tW58lJqSxw9Pc4RXGxo2YAM4X+mgbYsxucsmAPHKYGERrSsL3uH2IFa0ejUPqdrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HK0r+zVx; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HK0r+zVx"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-447ed27aea2so399041cf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 11:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721846139; x=1722450939; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kZ3qy+q6Jkc43RENdf4rRp/I30VZ1x9DQy8YlWiOUqE=;
        b=HK0r+zVxXmRLBdVJzvJdHFaWAPfbtLurYmwavPt/iUd6yPo/LIOwRe3LlzYHX/yKsO
         N+DWKFXHDnmHwbOdDZFJPtXXMQX/6upQZ6JabvaPIUPDbMuzTHL4NDkeQd/MAx+w4ZAN
         zb9lzXil4O0SfR7w+XdTQm9to6O+ahSpFW4oUaS47uoIn1HvhZ0AJETaRBrPgPtzQIvK
         kqHi6TMF9FHRFDLgAUKBqjvFoSjBjox/7ytAqBRdU26VHTdKJ1sBNcduyjKv5JuP6Og+
         1lssNF50FhjG62Cf4effgTtoFslz4W2dzcgosmqGiwpmXD/LX1ko+t8J9mh+BTWOyuI6
         UsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721846139; x=1722450939;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZ3qy+q6Jkc43RENdf4rRp/I30VZ1x9DQy8YlWiOUqE=;
        b=fy7HADNj0xuSwkSzq34VxxIzErgCSNIUErbjVYBw6DYGi+N9iCqZj5GnfzRD3ypO0+
         u6roy6UZbmB7QGPvZhpaCAJDU7lU/aGzdwDU5bB9dt+jNGdk/AU0G9rIloEVAk4hh7l4
         Nidd0ns0jvgY08TpP5Au5JX3FufLK4b/fitPinFSZkXxmMnyaj96zaPIzUlRbI3fohFC
         +VQkEYfWvMuY9TPGZI4G5Ii5SDPkCmCZbB8WNodg5ayS0YU2n66hTHDZZzSqJ10vHStc
         63tNAnhLDsU74/K/mF4BWOahxX+ydkUcayR2EhAXzALhXiF4j/6J6ERF44U726Y5mco3
         fh+Q==
X-Gm-Message-State: AOJu0YyztvfcIztmT1BQTlexOMCY2wlS/GPIj3UUp35+drcSkKV25rT6
	h5MKM1YLxYCO8sNAQe5lufgrwmCRuiKx0NBf9cBTm7kccL4rLSkxSXw2Xw==
X-Google-Smtp-Source: AGHT+IEiZvqSH/2aFFSIU0SxUkIPx5zSPmoFujdMuQyKdUGsfqtvb2a5RS95Ootk/I5lY0DN82khUw==
X-Received: by 2002:a05:622a:1489:b0:447:efb8:97f8 with SMTP id d75a77b69052e-44fe48dc239mr5714741cf.49.1721846139088;
        Wed, 24 Jul 2024 11:35:39 -0700 (PDT)
Received: from [172.17.0.2] ([74.235.135.240])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cdbce22sm55546591cf.84.2024.07.24.11.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 11:35:38 -0700 (PDT)
Message-ID: <66a1497a.c80a0220.b87c4.1948@mx.google.com>
Date: Wed, 24 Jul 2024 11:35:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1031522492770552358=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v3,1/3] client/player: Set number of channels based on locations
In-Reply-To: <20240724160608.2779282-1-luiz.dentz@gmail.com>
References: <20240724160608.2779282-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1031522492770552358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=873582

---Test result---

Test Summary:
CheckPatch                    PASS      1.67 seconds
GitLint                       PASS      1.05 seconds
BuildEll                      PASS      24.96 seconds
BluezMake                     PASS      1692.08 seconds
MakeCheck                     PASS      13.83 seconds
MakeDistcheck                 PASS      180.06 seconds
CheckValgrind                 PASS      253.65 seconds
CheckSmatch                   WARNING   357.25 seconds
bluezmakeextell               PASS      121.01 seconds
IncrementalBuild              PASS      4546.60 seconds
ScanBuild                     PASS      1018.96 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============1031522492770552358==--
