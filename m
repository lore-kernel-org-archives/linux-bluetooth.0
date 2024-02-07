Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A9180612
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Feb 2024 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707322266; cv=none; b=GSN4tr0oS8dCzhZrlPA2ZrGOt925YZozJNuZfkwzYIg4aSt75KRWIeaiTYfO7eQqRTeScWGYqEgRE3obymj7sSuuNLv38mxnhTBzD9kM6SCW+6e2Az/spP6j04OWgwthiUv60hV+grG+AlL4pb1vUVjE50rGGMglYAWf/99H5Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707322266; c=relaxed/simple;
	bh=iLCnJoDsqG4g+I7oRQTzm9Qo6DrER9OeDjJFKn9y+Wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJNZkyCApc7A1SjzB5pKgAJZoIPDaHRX9gJvrQf+50+rRA9t4joNRi8/gn0SgMjBsn/mz8HGgD+6rjZb0FORzrREB/iYSsLLNfsR5mE2OrPA36eo3UQQDUKe4nkKANN8uN0fsG+xh/2ZyYnVLajM/5ZkXoPk2/N+RCBeWJ1See8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvG8jIVf; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvG8jIVf"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d0d100336cso413641fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Feb 2024 08:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707322262; x=1707927062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLCnJoDsqG4g+I7oRQTzm9Qo6DrER9OeDjJFKn9y+Wg=;
        b=KvG8jIVfwj3anHyMDBiD6nLJfrDiRV9VUxmO4Cjh2wXAIkxYBp1PVWz8TQs/mDntYC
         K8EvJwONcWB7smwe/XJmsII6MEvRVn+Wpu6NiYyyjNsUyyt7ky9n9uce+0P/1m+gRzYi
         lcZ2UiLo+q2lBCxhYbZ8BfNvh3iDcXqbTlNdJX19aafN6RI40HEsgWxGDR08Aa4Fgvly
         S0JdoNzfMfy5iyNmKFEiiKS8MrtrYHhz9Q4AMLwEusWywocv0gEBMBF9T9qA3J4/6YMp
         2/yvTEAXxfY63w/cM9bCxXX7TAzy6JydK9j7f4UgAWCZEMu3zbWQUeFkwJuUsY88VCAF
         wwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707322262; x=1707927062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLCnJoDsqG4g+I7oRQTzm9Qo6DrER9OeDjJFKn9y+Wg=;
        b=BwBI0E0Ho0SCe30dPRwUN/Qf8LhoMCrc08uQo3YD6/H+e5XlzVFYQ5wkk3+KE2/V+d
         RMSusYDhCWcE7TRvGv3pfykiXFQEt0WTmk/rSSSXxrVyj9qZHtHni2AWtdFows4x/ECX
         5SsPM1H5Vso00Qtg5ozZjfHjelSdSwvR8kd86kL/EIasEK48hNRpzxqRyvcWh+CthwUb
         PiSY0kaLCPnQaXYNX6qoYZsmh20U2/Hh0RzrckQX/TyXbknbpJfXHuEF92TPRs8gCL2s
         6OGBCuRgEQUtbcQGo86gWa+FQD3EH2c5KgmRCyS3l1jB9RsqdY4iiUCgi1ZkRsPJ8IFA
         RI5w==
X-Gm-Message-State: AOJu0YyeUSOOm1oVLm5Thx4hkj6kTH53HUsHr7iGPjTM7wCZam3zQCBy
	SIDHv2yjEQLvm50r5uOcxKnj8x7sOUzl0zS7XOh7/kpF8vt9xOguRL8hHFiuvAfugy9mctqiAt7
	fgGNSTp2HEx7USBsNB8narSBdZs367Wm8
X-Google-Smtp-Source: AGHT+IHr8+MxgRHEBQU1jxYiKhiEuPWf7rLa8QYE5REeBnGuVyAC9j2gEjmtk2RxDRHzkPDD/Dc/J9E6AVdBp7UP6RY=
X-Received: by 2002:a2e:8545:0:b0:2d0:9bcb:6248 with SMTP id
 u5-20020a2e8545000000b002d09bcb6248mr4646002ljj.39.1707322261862; Wed, 07 Feb
 2024 08:11:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207040110.398884-1-user@LBTOE> <65c3655f.170a0220.e7119.2a26@mx.google.com>
In-Reply-To: <65c3655f.170a0220.e7119.2a26@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 7 Feb 2024 11:10:48 -0500
Message-ID: <CABBYNZLJZPH1gag5YBcdxjL=YY0o3ySnLA5DvUBqt0xVPcqfAA@mail.gmail.com>
Subject: Re: [BlueZ] monitor/att: Enable the notification logging support for
 the CCP
To: linux-bluetooth@vger.kernel.org
Cc: shahid.bashir.vichhi.com@web.codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shahid,

On Wed, Feb 7, 2024 at 6:11=E2=80=AFAM <bluez.test.bot@gmail.com> wrote:
>
> This is an automated email and please do not reply to this email.
>
> Dear Submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> While preparing the CI tests, the patches you submitted couldn't be appli=
ed to the current HEAD of the repository.
>
> ----- Output -----
>
> error: patch failed: monitor/att.c:3481
> error: monitor/att.c: patch does not apply
> hint: Use 'git am --show-current-patch' to see the failed patch
>
> Please resolve the issue and submit the patches again.

You probably need to rebase these changes on top of master with
something like git pull --rebase origin/master, if you had cloned it
from github then you probably need to either add a new remote or do a
new clone, anyway Id recommend always have the origin remote pointing
to the main tree not the github mirror.

--=20
Luiz Augusto von Dentz
