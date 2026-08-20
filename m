Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8079847F77A
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 17:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787248473; cv=pass; b=Ueuxc7jBpWZKARIuLnPiFynIcKt3Cjv52GGvmt2cKYA7rjdE+nB5895dHkkNRvC5O7K8DO+Otk+3KC3YXi0qSzYK9/Od82vsvIsxcg3al39cewEBWyf4kGrTgOctURZ8FAf/V/LOID0zBzxvoTF4aWJpbyrvm7Ga8wj0zp5hyPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787248473; c=relaxed/simple;
	bh=4C2AsDiHnUhkefLL9D//Fdv6uqoUR0A71Tlt7G/mBxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0vsxgY+QsitioROym4cWuBOdOEAtbwwoQC7EeJMDUR2VCJ93Kj9zeNrl1qPagoASMrvzryioibnqnlSvjVYxgJYxLhVxQ0zQItxWkoK80SKUJRZM0F0L0Z8e7vDQ+ovJAEwhF66LPDXvGopH8BChV+yCmdUqtRO1nt5JSC9y+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at; spf=pass smtp.mailfrom=irregular.at; dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b=MFDko0KX; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irregular.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b="MFDko0KX"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66c7e3a2332so59738d50.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 10:54:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787248470; cv=none;
        d=google.com; s=arc-20260327;
        b=X17Ac/2KKLi1BowQLS+QjfEHhx9s8BtpUcb0KhjcN//mthO/YnKD3km8oHVWsqEBqM
         gRzv9/yJcFzL2O7ADfF/ijQxRHYCaeO0zOkp6tABrL12QHN+8Y1u4HZP+eZEZWtzEjdC
         SwU47Ev5ENkLz7fIX6DS5hyjjVs5bGDvAZu+/dYTMe61vBxbV+fGMQfnS0Hb4AWA87Ky
         sgBpwtOW46S/2Zd/IUupPiAst+ZdT5EwFmme0m8Izy4+5Wfiwoz/yKUhpxMqDvki1KUw
         8fGkdYelQaGzjN1pbrH7aqy1s2xalmSXt+nMPafBAKTOu46SkCaao02QULJtMufn+m+O
         Z1uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TTaF1U/A1JDPbV3gmZWZ1HzKd1kjG6qRrzl0W5o2QNU=;
        fh=v4Z3N2Htbr8NtGqMLkQjkIE/EbeUcf6lhEWEAm07n3g=;
        b=j7U5h3gc9ZJQiBoEiCyH+gp4GrC0tYPzVlFQdu/nROMn824KOh+fqxDBZvrpnsPeyS
         LgnaSk9dRnLjGPOwPU2hKmZRGEukiAdFxZw4/gSpwdd9i1Bu7wVSXLwONievUDE4tgLG
         sqLZEG91r8Lv+JdS2hWPc/1fDgkJ9uEL7PR2SlmefDkobSwrDpA52nPX2BMODgjC9OZj
         1ty3rc3RLew+02GRDx6fBen4iKy/kvCCSvywIrw+GviNrlm/mhodqCylPBlYwk70RQrP
         zRs83oxNraSvxxF7+jxro9SpHwYm8AbWASSVLCJi0+VFzcwWrfUkimGhRmsyFkJbLafe
         pOlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=irregular.at; s=google; t=1787248470; x=1787853270; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TTaF1U/A1JDPbV3gmZWZ1HzKd1kjG6qRrzl0W5o2QNU=;
        b=MFDko0KXvKewEU5kliA3fHlsgn4xMkVi+2bOhcE4Zu2juohbzk4BwVB8oX/95TQ9w/
         S07W+bSbOH5HYKjKEFR11TIBxXDbfAl7WK39YdLT91w7UAe4OwGEiWF8jV+ATKe/kdaQ
         wYLz55+XmfeY9vXOVmX9AuovKhshU+SSFxrcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787248470; x=1787853270;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TTaF1U/A1JDPbV3gmZWZ1HzKd1kjG6qRrzl0W5o2QNU=;
        b=F76IK0ufE45boUIMytgrq/bM4yIgMP2gExeDSYP/3PpXsipr4MoCEHRn67qI1JDmfJ
         Z50unbLz426lfoQQ5JB+ge4DWV3MAAyYb8xYNwb3yoG4Wp6R6UfN2+lLvrzm1Q+qb1mg
         7gdI8L0j4wm5v1b0gh/zcTlbnVZHk/Qp92cYA9IhGVRuPP9iFGuuZKKa85C+aNUOO69U
         V5bM6bFG7eNcGahYJsy/Q6jiuYYjH1w5IOAHVr1w0l0A5pYi/PS23OqRIwpE2TofW3an
         ++EWWKGI8QXo6vd/BLS7WgBeC6sbuPqYTSA+mRfgcrrJgHO4gB9EZrOXLxg6zCQF6XSv
         O+vA==
X-Gm-Message-State: AFuF++kT9S0nOsnPhjl+zZNq3rQrr7BIzQol1429yuIaTaxk5/J+FeCv
	sg5hNWPSMIvj8NGTVca6s+g9Rg2TJ1d4UF6cQr0uzSfH82lhyDNzzSi/g9Sk/ChRxgJxjjuTdz/
	o9Y4n/TQYQcotSQTbjVId0V5JRHOvvZrSU1sYHF5uPQ==
X-Gm-Gg: AR+sD11h266d//3j8OGJYyQY+XXzdv3HBGo/6kNHZwPblZPc7HXIwC6w5Wb4R0oOsA3
	AtGiDk8qbo4u2WVroMNvHLlyf5loDLubCzFfjnW9quljmJkJr8d7ecKS5orLm4A6TSrRcRjiQ2F
	2X5ccpCsWclETLwW0WXsq40VEeymZ1aYuQpZ9rXorwKKtyIzxzihWrCBemQ1DeH9JQVsShkGY6X
	P/Q0FEgTnnuDJ+1jG3J2hiJD4MtkeYF90xZc43MCM+Wac+HaX1xluqYz84t4bhH/0ZYZ5PhuxgZ
	x6n+eUuPqEtg+k2MXTVa89C/ZsOtVkzFB4vFP5VoaTceSAYP9fRKBrC69pxfcGOybaQw/KChR1l
	tUDwNh+7cpozbMoo8JGBt28AethnzXc7bzZFiNlgXLUzkvvsqxotTzIKnE0KT9ACBBrw779yHzS
	lXjlHlb7WYr/ToIn/CmQQ2
X-Received: by 2002:a53:ec88:0:b0:66c:a828:abc3 with SMTP id
 956f58d0204a3-66ce49d30a6mr169365d50.8.1787248470349; Thu, 20 Aug 2026
 10:54:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819223144.82045-1-m.kurz@irregular.at> <CABBYNZ+4uMBiTcmTa88xKPg-454gOQXqnhvgq49DbjGYM6f2zQ@mail.gmail.com>
In-Reply-To: <CABBYNZ+4uMBiTcmTa88xKPg-454gOQXqnhvgq49DbjGYM6f2zQ@mail.gmail.com>
From: Matthias Kurz <m.kurz@irregular.at>
Date: Thu, 20 Aug 2026 19:54:18 +0200
X-Gm-Features: AcwNN1XjOv4PcUHUR0L5u0iPIoW-k3kTQzqGZL6D4Zum-y-8jX9e5RoBqztCm-o
Message-ID: <CAO=2mx7FTdWXtjxFCZSsx-nPTczgs6ifNqHr_w2+VG6XvvO_tQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/4] Add component batteries and Fast Pair Message Stream
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Luiz,

Thanks for pointing this out. The cover letter did not make the
transport and protocol sources sufficiently clear.

The general Fast Pair Message Stream specification defines two supported
implementations:

* RFCOMM, using the fixed endpoint UUID
  df21fe2c-2515-4fdb-8886-f12c4d67927c
* L2CAP, using the GATT PSM characteristic

https://developers.google.com/nearby/fast-pair/specifications/extensions/messagestream

The PSM characteristic page you linked documents the L2CAP variant. This
series currently implements only the RFCOMM variant. Pixel Buds Pro
advertise the fixed UUID in their SDP records, from which the code obtains
the RFCOMM channel. That transport was also verified against the real
device.

The battery message itself is defined by the Device Information
extension:

https://developers.google.com/nearby/fast-pair/specifications/extensions/deviceinformation

It defines message group 0x03, Battery updated code 0x03, and says that
the three additional-data bytes are identical to bytes s+2, s+3 and s+4
from Battery Notification. It also gives the complete example:

  0x0303000357417F

The individual battery-byte encoding comes from:

https://developers.google.com/nearby/fast-pair/specifications/extensions/batterynotification

The TWS-specific unsupported-case value is documented here:

https://developers.google.com/nearby/fast-pair/specifications/devicefeaturerequirement/devicefeaturerequirement_hearables

I will update the v2 cover letter and patch description to cite these
sources explicitly and state that the profile currently implements the
RFCOMM Message Stream transport. L2CAP Message Stream support would be
separate follow-up work.

Regards,
Matthias
