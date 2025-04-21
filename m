Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FA31C3C1F;
	Mon, 21 Apr 2025 19:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745263081; cv=none; b=e6YlbQ78Q8i/m+6IrBXCGhVD/RXkycMwJpV9xW3sTNgjkf+c9D9Qzxoia22ZD9vEon10NsFi+/KCek3UOrCw8cc4kry2krUC5WQtlTnNpD4k+k6TT+0IZ8rMJ6SVKTXYeUdMJTu807LTkCKovr3mikbiyvfFmnpveaB7JcSI4Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745263081; c=relaxed/simple;
	bh=6Lt6s2kB5xiKzlFdAj66SBUP/GuCc0AQgjD4vfIFCcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nNohjCrl4Y+My5Ncz0UI0yDW/5zT7yzzZI3tpl9jx3qPd+d/HOS95ts/5iNpaBjAFuJZ6IyCJieZfouoE03ThcFI9tBdjZvSgZxXOTQe0VKa0nTy8TwdWlMYmyBhWiuprm978bFKm/9U0FlhyYoqInLuFkMmH7uTGy5SZQDJoig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDqlCtEn; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDqlCtEn"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3105ef2a070so43427061fa.2;
        Mon, 21 Apr 2025 12:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745263078; x=1745867878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rvx762aZIWnIRrfPsLkFmtHGZEgCQuMTQMsPMH9+g74=;
        b=NDqlCtEnUVMk4FRJoX8MnOos9pZi3Btle/9KUDfHqP18po007j7PL4pd0KJoEFjj5q
         CH7aFU0HYwAfDngyoTaOcj0nUu+SzrWR8YsvfkySjzCOjeaiFdFgwJ3UQu07EQhw2bht
         OyDMPXElX37zlCJLFHTyR7/5v7PMX4BhiiKg+grISCFauoPepbs8+33SLe7zznRlGUde
         ndS2hnKl9MDkmhLgwtNnvYviil8VHy9WJMGmdZth5kCp9FvgLCovmFUxhDibeKmA2Nm1
         KxPkQuPw4NdUjQJl7zxh6JjN763KnlA4lFL4OM4gYNbe/374EePCJt8joBw2TyK7YTjA
         PP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745263078; x=1745867878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rvx762aZIWnIRrfPsLkFmtHGZEgCQuMTQMsPMH9+g74=;
        b=hMCbQIyYdaWSsxePL6WaJoJgZ3SqW9jjJwx3+OM4Dxk07zWUPYJCe5KX7mfAbBF7pN
         dPhr3k4IOrRIwJmhTiPSwTssCVbUG0soDqKHdSrswYGZJa3Eai/qz/9yTcl3pd+dFcD2
         0ZgPs0gLrmoipVOVVqfNpKz9trijou16VOUyqjNh3T32BnAH0Hha54U3nINDfDzY2PRZ
         bO5Gu+XHdsZ9HaNof19EFJXLaI7xQbLGCFGF95qyCn6UuPm1mgN+IkXwpsW3N4WaDYoz
         agwrI4Lf4AS3+/uFjBSyk2KIYcCkYzaReru4WTtlx1pD1hEiEncClXrupwMN+KfPq0Jl
         5BHA==
X-Forwarded-Encrypted: i=1; AJvYcCUBbQRVPt+JYa0+dyU92Ujo43NoW2Tpc5GA4+bIuK0CmfU4OeVrwMIUvfi1hkRLxV6s5M/djtRsCkP2Do/pPYI=@vger.kernel.org, AJvYcCW+9JlesJtIpzDa3WPIYl3swJcapb4RdU1ARpcmwlg4mkmtwCz2gXDZYEQdsnjL+VknMQLP1iaCcKE0IKso@vger.kernel.org
X-Gm-Message-State: AOJu0YxkPu2ps/u45AO4t7CyF8ePNeoxBC7DPxLaq39Q3ozLGQ4c1ypM
	q1TN7Mcvedo3DHUpm5QBx8jpEqpQhuJgCXlFVbSGR8TpE16VLHqvifIdGQiu0/EaQ8aBzjJHE7E
	ihi0lkabnPeyg027MqpC7ol4muBr3+FAU/vY=
X-Gm-Gg: ASbGncu018RNMeylfnnAua/bWIKlGw3tkS5RboBRMocrCqLCC93jdeeHEKJVO+iWy7K
	pPZtEfgpwYvmXzHkiwbV4KtcndOIdr1s/m/n5W0SLNXXI966ij8nYFu51/ywl1YG/zWW7rjYLjh
	IQEdC4PU3yW4qcHVClhei9
X-Google-Smtp-Source: AGHT+IGs3B57KMvlgjlfvccjd0/38p0xmvDab1+u0Sox3eMJMunwv+qpBFbV8vLCIEwxkeTnXIuR2T9fhEFCZyWI0PY=
X-Received: by 2002:a05:651c:988:b0:30b:c328:3c9a with SMTP id
 38308e7fff4ca-3109054ea5amr43995041fa.29.1745263077487; Mon, 21 Apr 2025
 12:17:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421130038.34998-1-en-wei.wu@canonical.com>
In-Reply-To: <20250421130038.34998-1-en-wei.wu@canonical.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 21 Apr 2025 15:17:45 -0400
X-Gm-Features: ATxdqUGFwSCA4kgTPjKIQgEDjGMucb5LwgwhlNcqp8vwVHLix3TA-zSWQ7Rfkno
Message-ID: <CABBYNZLXd3EzMhf41wJg93jNp7DWQK7oHOnHGv_ThZJ7yMXTGw@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] btusb: fix NULL pointer dereference in QCA
 devcoredump handling
To: En-Wei Wu <en-wei.wu@canonical.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pmenzel@molgen.mpg.de, quic_tjiang@quicinc.com, 
	chia-lin.kao@canonical.com, anthony.wong@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi En-Wei,

On Mon, Apr 21, 2025 at 9:00=E2=80=AFAM En-Wei Wu <en-wei.wu@canonical.com>=
 wrote:
>
> This patch series fixes a NULL pointer dereference in skb_dequeue()
> during QCA devcoredump handling, and adds some safety checks to make the
> parsing more robust.

While at it, please move this logic to qca specific file, there is no
reason for this logic to remain inside btusb.c

> The first patch fixes the logic bug where dump packets were mistakenly
> passed to hci_recv_frame() and freed prematurely. This was caused by
> handle_dump_pkt_qca() returning 0 even when the dump was successfully
> handled. It also refactors dump packet detection into separate helpers
> for ACL and event packets.
>
> The second patch adds bounds checks and replaces direct pointer access
> with skb_pull() and skb_pull_data() to avoid accessing invalid memory
> on malformed packets.
>
> Tested on WCN7851 (0489:e0f3) with devcoredump enabled. Crash no
> longer occurs and dumps are processed correctly.
>
> Changes in v4:
> - Fix unused variable error in the first patch
> - Refine commit messages
>
> Changes in v3:
> - Use skb_pull_data() for safe packet header access
> - Split dump packet detection into separate ACL and event helpers
>
> Changes in v2:
> - Fixed typo in the title
> - Re-flowed commit message line to fit 72 characters
> - Added blank line before btusb_recv_acl_qca()
>
> En-Wei Wu (2):
>   Bluetooth: btusb: avoid NULL pointer dereference in skb_dequeue()
>   Bluetooth: btusb: use skb_pull to avoid unsafe access in QCA dump
>     handling
>
>  drivers/bluetooth/btusb.c | 120 +++++++++++++++++++++++---------------
>  1 file changed, 74 insertions(+), 46 deletions(-)
>
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
