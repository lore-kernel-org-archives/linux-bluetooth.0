Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8667539CD06
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786119177; cv=pass; b=U6A2ezibQuZsr3OzTamUYBF0MjZ+SVQxzin27hh+v2SjvIE1u9vnFj8ElqDThJOb0AgFTOI7HjuGjYsAJ6YioX/cP8hpTVhWGQ7ujmqW0t1FEFqtUbu+26x8u/rtM1SwF8hHDWT0N4Kw3UGVdi51UxJ5nucbZht0fWhsLXs4Fhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786119177; c=relaxed/simple;
	bh=DqtMhpwA/bXvSFLAjWXp70gh4lTUw9Mtkk9TbVJbvlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5mfrAbCfd1GrS7xTbp1MPEEARDxCQrZH6OJwB7XyZ8/KbBO4TyZk9uJnxIY9UFEJcB93dFnZ2gfc5M08WjWMUI0EnAvSWuGN3Q+ewDsrh8S7GhQ+zM8oHcZdSi7HHplfgHs2m5BAB9Azh146qBnKnJ2MvRT85XXSKCC0lGbDdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n2jyX5lh; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2jyX5lh"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8234e9ea616so19176087b3.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 09:12:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786119174; cv=none;
        d=google.com; s=arc-20260327;
        b=jSKATC3MXsCoKnnGR6z1LH8atJmS8QY4Wl+EK2lxhd1uBNH7LkGPRlvDCHlMOlYm3J
         8OyFIuuydNYt0tN6CaaZQM5Coqcw+UT/75COGSPat2Of3/VurT6lGejdLNUZlN+f2zIp
         oxmMxogdQzTyPKETN3fUrz/7Pzbb/3tZ7OyEkKIcSOeoIO8umjflEXnAt6ZoqnsBkHwY
         WNHLB4X1ZorTFhe5aeL2nHOW/aUkBpZ39N+E9IeLhBYQ8CVnLCwJh5XB49Bbwe4+8Cmy
         9XqgCLVakEVC/OTfZZu65o3uRygjoY0kTCtRQ8/VDK9FJIn6gNQK0e715YKhiRCg6TSU
         dJJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CVZ3s8+W6wLAeEpvBAYhf8iqhQLxzivAvSxjQOV8D5k=;
        fh=3Tt1czTmTYQr4kpVxpPQnULFPl6b2ZigaweNzAiVhZs=;
        b=KL2JGwa3ZlSDAZSvk5HrdsMdcCo+/tuayKDxQK6iAqFU10YHDpzHK+S5aXm6lp9s1r
         mKGgzFTqZFmBi8UjoAqzkTt2WetCiDvNTy3EnFybn4tDKRl9WNbOTmY7HzC5u7JIBB98
         1mO8rh3Av7NnQhDIIuLWEXqKkzeNPrGpcjVtjYZ0k7mrhhaXXo2xmwXl+tCbK6Fk74J1
         ch1/J4YurmVbSrJwPUJxK84r2NvYi9OPDcwUSyCwt4dxWePUFtSekokqn5QYemX64UNP
         7TUGGm4UuoGnrTj4JZexsI3yYYAuZmXuqzq4TDhkWVB2ViHXW8zOL5hXKACkqLOCFDfv
         PCPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786119174; x=1786723974; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CVZ3s8+W6wLAeEpvBAYhf8iqhQLxzivAvSxjQOV8D5k=;
        b=n2jyX5lhPEt5lgc1TubnPPIYSBQ1PT9/+YnTA5qAyj7NKAFma8FikuWg7IZPJH8MY2
         VLwNha2C9aqRjmiyhuL5zXmbK3JDnW1cuxPZE3N4zKq9/jFQc1G8pJrzEF3kmrWupv1Y
         U9lZur6rrKZfSl4PFzv3sORqnI7hNDbh2nmdM0HXCj/LvkF70G+7RB8OTAYFo4fgFX+u
         ftQvUclOA6vRBcOvwPtrU5wwdvRZ/viFF6qykoUiQdUMy+ql9rOYfanqr5iap1pjNoB6
         +q5LR906cip5zXjV/x9XBGhlJBPk4GZTyHpDfyY6vQ4dQ217NaKdQZGvNz12mNMDyu5C
         o7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786119174; x=1786723974;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CVZ3s8+W6wLAeEpvBAYhf8iqhQLxzivAvSxjQOV8D5k=;
        b=s3Mncdh5zJxr2q3Udq1hkmQjd0UF1Kz8sAnHGsRUsxe3ZqOoIxzE5XQwCYNrbLfCSZ
         QdgS3KxXRqE2S4eTwHwOJviDl1rC1MGYSp/qzXVeQd9mm27myI8kT7uGOPtAxVkMErfy
         VIFS7ZV1De7pMptXmg4k5t7sPYdi5QsfsIe86hq3/mdmCNJsBP8p3eLT5UKQjvOGalAC
         r9+EaOcWIrBVnJdqeAbXylc+PVSLJxSxV+V185wITJrvVwfPTzZ/EyDW9phe8RCqlXnC
         J4Qu08Bey61boNx07jAPOV45zwybX1RIQ0v7PX172GzeN/1Esh2I6qgKGdmM20lWyiHz
         HAnA==
X-Forwarded-Encrypted: i=1; AHgh+Rq3Ul1TVesWnJvkaXqfW1gRDI49NeVGjmQXd9bwK8eC+6rcZeo6sG6p896s7UnA4/q2fr7s2bkZq9emgdLSLK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvli7OxZSD1vvWIIHtiAWjj8BA83/jjrS8zquCYFa3ra3iDxgT
	WaUKDdLCeAqiRRUixx50jFCo8vqLfgPEOB8uP9g7onJ5dErS8y8ZdCMlm4opNboXj7Vuc8dEpcV
	Yt1Yjmiom4PKoo5M/CsaiK2iqaHjG+YM=
X-Gm-Gg: AR+sD11VeTO/m20CYJXeqltth1VEdsqpDZGdhIEo7r54hLciiEvPo75nYijU6JAlae/
	6RmeNrU5opy13CQ5duCBunzNaomv6ppe4t35iJBMhsCogvzMqzH7cUIOhbf8tcoVhbApjP0olYM
	ZPr/BgZ0lbecvedXruL4EQoK+mTdv+8ixcxCEiiZQOO2NQmr3rEjI2jKIDV+rFjgyzJTOASjBAd
	Gc+kP14yuwG+slpvWWmToEtiwzdK2KcOIyr4s+eRFVtBtzG9QHOxrNAdhtb7xm3HPc2h2Due9G7
	i8NdtylbTmru8QYvd/DlD89Vx4KooIwNcGMTCJxL122uv8CEsqrQ0zJNrFonJ9BKJPrX+f2jYeZ
	0OnKGB4fy9fPbY3XAKY+ECpFcbcS7el4=
X-Received: by 2002:a05:690c:4d89:b0:80e:dc2:873b with SMTP id
 00721157ae682-8259860cf01mr7611667b3.16.1786119174329; Fri, 07 Aug 2026
 09:12:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807101529.17348-1-baul.lee@xbow.com>
In-Reply-To: <20260807101529.17348-1-baul.lee@xbow.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 7 Aug 2026 12:12:43 -0400
X-Gm-Features: AUfX_mypSIQqGfHUVtlQhC9PiRr-Glq80LV76qSLr4GhgQJcG-dLER3roUrIb7U
Message-ID: <CABBYNZK8sfUkhMSwJ-G8F7z_hGkQKy+Yu9nrbU0cfbzA4vQ0CQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Bluetooth: MGMT: fix use-after-free of struct mgmt_mesh_tx
To: Baul Lee <baul.lee@xbow.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Brian Gix <brian.gix@intel.com>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, Dmitry Antipov <dmantipov@yandex.ru>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, federico.kirschbaum@xbow.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Baul,

On Fri, Aug 7, 2026 at 6:15=E2=80=AFAM Baul Lee <baul.lee@xbow.com> wrote:
>
> hdev->mesh_pending is extended and walked from syscall context under
> hdev->lock, and unlinked and freed from the hci_cmd_sync worker under
> hci_req_sync_lock, so the list has no protection; the objects on it are
> also handed to hci_cmd_sync_queue() as raw pointers, and those work
> entries outlive the list.  Three use-after-frees follow, all reproduced
> under KASAN.
>
> Patch 1 removes mgmt_cleanup(), the one walker of the list that cannot
> take hdev->lock.  Patch 2 puts the list under hdev->lock on the worker
> side and asserts it in the helpers.  Patch 3 gives the object a
> reference count for the work entry.  The order matters: the assertions
> in patch 2 have no violating caller left once patch 1 is in, and the
> reference in patch 3 is only well defined once every unlink happens
> under one lock.
>
> Reaching any of this needs CAP_NET_ADMIN in the init user namespace.
> hci_sock.c sets HCI_SOCK_TRUSTED at bind under capable() rather than
> ns_capable() and gates every later mgmt command on it, and the mesh
> commands additionally need HCI_MESH_EXPERIMENTAL.  Nothing in
> hci_event.c touches hdev->mesh_pending.
>
> Each reproducer was run at identical parameters on the unpatched and the
> patched kernel, built with KASAN, PROVE_LOCKING, DEBUG_LIST and
> DEBUG_ATOMIC_SLEEP: every splat the unpatched kernel produces is gone.
>
> v2: rebased onto bluetooth-next, where send_cancel() no longer ends in
>     mgmt_pending_free(), so v1 did not apply for the CI.  Context only,
>     no other change; v1 applies as posted to the bluetooth tree, which
>     still has that line.
>
> Baul Lee (3):
>   Bluetooth: MGMT: remove the mesh walk from the socket destructor
>   Bluetooth: MGMT: protect hdev->mesh_pending with hdev->lock
>   Bluetooth: MGMT: reference-count struct mgmt_mesh_tx
>
>  include/net/bluetooth/bluetooth.h |  1 -
>  net/bluetooth/hci_sock.c          |  1 -
>  net/bluetooth/mgmt.c              | 72 ++++++++++++++++++++++++---------=
------
>  net/bluetooth/mgmt_util.c         | 31 +++++++++++++++--
>  net/bluetooth/mgmt_util.h         |  3 ++
>  5 files changed, 76 insertions(+), 32 deletions(-)
>
> --
> 2.50.1 (Apple Git-155)

Sashiko found a couple of problems:

https://sashiko.dev/#/patchset/20260807101529.17348-1-baul.lee%40xbow.com

--=20
Luiz Augusto von Dentz
