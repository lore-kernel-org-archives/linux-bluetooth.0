Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C272C42AD7D
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2026 18:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792176310; cv=none; b=WyjYYvmPyhkR8/TdFhmw7UYKEBiTPvh0y3CTNBt+S5aTA3zwTBqcSyGgKh9tIYSoZJeZu+DSsg+p8OxY7Jte7J0Z37LBqehZnwZ1UtFo8pTpR2mNvjcX9KsOvRI27RnTU+HWm9uMdTpzRnletipigQPii0qMlB6vmBmSNxDg6jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792176310; c=relaxed/simple;
	bh=Z5fWiR0RIPXz+7LdfPXpxi06NU6WJDxeeua8Dq+zC0o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jgKxlwc56Wgfp6MkaQ9jp8lO6JBatZnq4HyLFYYP3T0K05/OIDhXJXt6YJY0DBupAhfunl5SAeS8wR1kyfC3+GZhEo4egLu63NT0WgdseEmmzpwOY/tYuQ+WlrBfwuaDrzKw3Mu2lPGcX3G+A3JFfaJRK7PDHrXvQU0HxgAbF/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqmF7fXZ; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqmF7fXZ"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93f2493c28bso24855885a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2026 11:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792176305; x=1792781105; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cWnvaGUWrTMs0nSY2PWYFVMJwZ9ewleY/F1hLiBKnys=;
        b=hqmF7fXZP/+La5NoY9sJOCXg3xQx13Qn+ODv76XbhJ8Zxf2+K8arGkz37QUmd+sLqQ
         n7Uu9oUUy/Tz5DT5hCJWPEUiI07lPyOI0vWEIsKY7Wxf5UMpp4G0B2mEuQcNbRv5tt36
         Et1jJ6iuxUfAJCvIydlk6Mx6lUF3Npw2Wt3rfKT200ZzfmmuKBJ5Pcjh5Ei0Yw+SkE65
         Qq7bbjTtY9dud4kjBRg4DtprTvuhg3TOVbrQs4P46WfA6B56Reclm8aoIkkYNZSR7MRc
         o94Yhal5cyVgL153QZaINTm9daZuXrqsoCD/VLGQxOcPLjdq+Slbmn+0oXAv4C7X4D6C
         NhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792176305; x=1792781105;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cWnvaGUWrTMs0nSY2PWYFVMJwZ9ewleY/F1hLiBKnys=;
        b=27iVDGg2vu4mMWpkkn2lG2GOKapCRg+YGu8xeYxv7OX3/6JvWfEKt/NfTPuRVhCPCO
         M7SpWCxmK9a9vfrf50J9Z1vfVUrFzpwwr/b9ey92JSH+Z2hLU1cKW2TWOHvQIOdNloLd
         x0bWBSmel0HOZiAtoRmEsNex5kbUDg9mAaAy3HuBac3skrhtCG3zqsIroxZEOa6evnKO
         s8RCAHKn+dbUvXlDeP6GgNxhwY7A+YPxbZ/VDZkxHKNNA2SNuNmBO63HmBDGzL839a6z
         AptkawSv0DETt21t2E9hWojjtWYbtTHbECxzG+iSOWCSho1+jgXXYxciaSJqtZ+n3hj/
         ezcg==
X-Gm-Message-State: AFq9FYKgBOduy9DYZ+PE0xawy4QrVx0Ukced5pNZJbICl0vwNh916oMa
	VYtjm6Tv4voxkJGIX4irWimin3lf0k5VvWCzXzPq2eV6aPWyojj7GcAJfqujgQ==
X-Gm-Gg: AYBFou19hDbK2usqvYL2VfO0vc2M7N8B7AtyC0X8qinivukjkbBUtQ6+JRJSdH931HX
	YDd/0O3hz9PV+5OqPAzEhoSknBoipcw7HKrAVTgb2T0WJL5XcL1VCXBoAfOzfdBJUg/v2rj6jkb
	9WGp2FEmZXFIkQR+eAFMsIQOQuIf0zrb891XOPlJcVF2h16whuQfY/9eac+8sZ9d0CcFg5OZcFI
	t4PDo7LSGMBgrE/TcmcTm5rUCSMBzSrDiBKy8GlOy1U+9bp91hwoR4vFCOzQUZEr+y70C1JVC3r
	rooAFr6rV8X1OizO4JlNnwX+kxiEhQRPZbeGjOOD4BukKo3n8jadsU5eKVdz1/jQmHP9V3LkZTM
	g0/zIrIHU2f49r+zQB7DBcwrWn1RDCqFIFMNBagF1SFx69bgGa6FHE6m9V2r9aelUCGYDn7KFhj
	ir22XZOCYpsna8AUXrtzbdWUlYTUonh6WuvfFI3UmCdeCNWkJ5Y0qGgrkvPaXt5pofxzcGZopKu
	uoU
X-Received: by 2002:a05:620a:29d5:b0:93e:d854:4b83 with SMTP id af79cd13be357-93f29ceeec1mr135494385a.22.1792176305298;
        Fri, 16 Oct 2026 11:45:05 -0700 (PDT)
Received: from [172.17.0.2] ([48.214.55.36])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f19f911e6sm282693385a.0.2026.10.16.11.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 11:45:04 -0700 (PDT)
Message-ID: <6ad270b0.3e5a4e57.3c7c8a.f7d8@mx.google.com>
Date: Fri, 16 Oct 2026 11:45:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8028558553948649797=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, eduardoalves8006@gmail.com
Subject: RE: a2dp: Fix crashes around pending SetConfiguration
In-Reply-To: <20261001143436.230557-2-eduardoalves8006@gmail.com>
References: <20261001143436.230557-2-eduardoalves8006@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8028558553948649797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       a2dp: Fix crashes around pending SetConfiguration
   Pull Request: https://github.com/bluez/bluez/pull/2618
   Created:      2026-10-01 15:45:40+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============8028558553948649797==--
