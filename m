Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC37433D6;
	Mon, 23 Sep 2024 14:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727101992; cv=none; b=Lwn7I6dv3WOw3ncDZ8/OWFm8OuKWGd5UklGC1YMVfkbKCagiwSAxcwmcWYxgNzDMdCo+d7urGXSSCaDeNhVW8tOAA0GG60aR6aI10CiqAZ9mdpf44YjxtdNIhx/gFQOPa2T12vSRb0lIvxYlpflicYycL6tyEWAuK2YkK8C2xo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727101992; c=relaxed/simple;
	bh=ux73KK1XidaY1vstLLZK/drl+q1xdkBgjQnP1RVPmPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JrWsB2BtP7ImOsMCvglrUBkoHwLqXYknYaDPposimxGOup5bQyNZBdjhuHYpByWIJCUWIAJoFrLKsnKjtniEDibaOng2j1xB/Xe764Z9YpQwQ3+tpQWhxAKlp2Puh+4XO46DKdnP1/GoKOSWH9YlfLdUr0Ec2UrxCU78KVz8glI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSOnqBiG; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSOnqBiG"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f75c205e4aso45257371fa.0;
        Mon, 23 Sep 2024 07:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727101988; x=1727706788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ux73KK1XidaY1vstLLZK/drl+q1xdkBgjQnP1RVPmPI=;
        b=eSOnqBiGoy6YO3J0wgTUlDQmcA5IT65wpvrTNWZQuuGaStugTPJ0SfdF2C7gq4z5d6
         oq0oYnrteKIwbHd57hFCJqxx+V634QlFw+o2qV9bSOg3XSHIISCgR35snn9XMknQYIAi
         az2EIQRPA0G8neZPTF1wVGgJJ9TX2e70shVJMO4MFlYWkSXgC4ukGzgh2eMkHZspQMx/
         RXzAX+cY6mvJeEmi1meuI52WRwgkR8kydmoAaSJ/IsWX4H/2aDyJKQeGCV25pKP5nJMf
         ebOhzwnShyujoPSOw8C/MdeuXDOyaerZuwIaSrFO5usy3vzB5S50Yuaxm5cYOYiwBxEN
         f5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727101988; x=1727706788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ux73KK1XidaY1vstLLZK/drl+q1xdkBgjQnP1RVPmPI=;
        b=foEKRx0VFQi8Vz90N3hQdPuR+MJn/hLD1MMduCI9vAUxtEdX+1bTHCGWjrGhq4sqnP
         d3v5uT7wYrzyWbNItGLV50L7RlhLZHpsLTbVnrBHVp4rVdzJO5OF6QfQjyost+j/17Ji
         Y3NMvVbGGBbxdw9mtCJWBgPV98Eqr5EILcsjjGwXjGjWv+shIP1ijlrG2Js62dDZumTw
         o63Dho1jXFvEipGpYXPZNwhP3Ucjw05wBGG4srvD74GqQPt6O0IzmlcWYohbLGSXz1Vr
         PPq1FPOZ6YiI2ttseVOaqU9Zn1bHGd8wHpifLmnSwIF450FzOz34nRlr+HdFF4yScPaG
         GLVA==
X-Forwarded-Encrypted: i=1; AJvYcCV4RhvnxwXLdo5QimgsOhmgVQ1DsVwmTIE++9mzAPooR1j2ncqkrD8C1y2OC9NKtea1exMKIa2/xPZ8BCv3@vger.kernel.org, AJvYcCWYlORoKp8dCsTHUXDG3C+5emSMBsfvEtOdZjpUjftjGm9spfFZRxIJJasDIReMBeNdO8ylNbrO/CQhrS15V9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTgoN2CAMhEnW2rTpmX60tQrxzcDs/tNXCYPl+OdDqUY8ndvQD
	tgg4C6ZcwhRzEU0cZgZKH3OFmo3RdK71DhsWxlq2tPU16+7GU346HrqwAEDpzyLzYB1PCftdW9r
	x2/x6cTzj0DCdDf/29IycnOIfifQ=
X-Google-Smtp-Source: AGHT+IEFUz6n/ZcKvi6jYMV0+1WnTF9yTVi2Jnjt6EoSGcbAZHhGA8n8oKL706mxoKT+HS7yfC6vAiAe+ABMDxFmsJQ=
X-Received: by 2002:a2e:b90d:0:b0:2f3:f358:8657 with SMTP id
 38308e7fff4ca-2f7cc5cc009mr40609041fa.44.1727101988087; Mon, 23 Sep 2024
 07:33:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZLnohZofm4Tchk7p36XS=HwYmN94DB0FGyiPFJno+evSw@mail.gmail.com>
 <20240921105609.1025-1-hdanton@sina.com>
In-Reply-To: <20240921105609.1025-1-hdanton@sina.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 23 Sep 2024 10:32:55 -0400
Message-ID: <CABBYNZLqXfAc7_YO+goAf7fnAsmJ+j9V0cjmPMX4+MhoDhzOCA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth/l2cap: Fix uaf in l2cap_connect
To: Hillf Danton <hdanton@sina.com>
Cc: Edward Adam Davis <eadavis@qq.com>, syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hillf,

On Sat, Sep 21, 2024 at 6:56=E2=80=AFAM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Tue, Sep 10, 2024 at 4:56=E2=80=AFPM Luiz Augusto von Dentz <luiz.dent=
z@gmail.com> wrote:
> >
> > Maybe something like the following would be a better approach:
> >
> > https://gist.github.com/Vudentz/121a15fa4391b2b1f6c7e8d420a6846e
>
> If your idea is not bad, boy, feel free to win Tested-by from syzbot with=
 it.

Is there a way to quickly check a patch with syzbot?

--=20
Luiz Augusto von Dentz
