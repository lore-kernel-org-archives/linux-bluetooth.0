Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com [209.85.208.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC4A34AB06
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 01:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.194
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780016465; cv=pass; b=k/S6rGdv3E+GRA4cbpd7cFhwg5/R7lqY6wUvntfR9bySstdKhMdLG3KqzUPWzur1uRaxAW/h9ugmv7Y0cl1vjlNIjbsVdDr+dj5fb1gCFbW1+fBhMWFqRVHVj8eg+GqxqhT+OO5rwMGnk5Oohi18hOzojYNYCqcuDF0hDEzrSzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780016465; c=relaxed/simple;
	bh=xsLWvpniOLGjbCkSk+ba6OoinlPY17QPqNdtwNDuu3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mC346Fq0HyZA0GPgV14Vv7N9zLA/RbQWNt97+Xb8D7E91aXipkg8D0dmoOpLqKuoh6D2b7v5CiByg3UoS1EZYcaEoap4Mx6dUNCigdWZmvYUlyyD/dXuxYINThVjZ8kblnxtIkWBY1He5ypwfEXDlV5Y4/b11A1K2vOKVBxpRno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hODiTDtm; arc=pass smtp.client-ip=209.85.208.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hODiTDtm"
Received: by mail-lj1-f194.google.com with SMTP id 38308e7fff4ca-38be5e86918so26150611fa.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 18:01:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780016463; cv=none;
        d=google.com; s=arc-20240605;
        b=JIKwmoMCXXfaEusZn65ilanWs5mGiKijBsfCo4hk/AYq6XCqePNCASGqiTBHfFZvod
         wmlnl21uYOlvuDY5GYCuVSiHMgCvkJMHupBfb1wcWmU1TyZnxVYN1GxqojGImLj1mlv+
         iAEddSTm81bJ1X9vMP7GFfqJ59In5MxcxitjZMvOY7tyvFx7fo1EI0LBesbBtpj22K6N
         MoFfcLaaujw86tflGuIMElbn4+Hu3/yQCOjNlujJ4vVyQ1p1YnGaf/jJQRuqXjlN5bc7
         YeD3RMGb4/i+MBL23DGa3jCucFdkSShgADJcKCAApOG4ifKeb2WWbuDRzHwoJofhj1zT
         SBbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=thtmsDQXFWMlXHx1x8Us7UQcmsS9q77kLGmw0frWVEA=;
        fh=oBQqmt5LCHhR43Y66JVQNUhhrmbEqH+chsVevOeUgi4=;
        b=OeC/XaOB6NzAURDGSyecNEzJO3gRpQ+el4RAmYZ2TFlGCltvo2Us1gb76SRiHrNzWz
         8vmQeTXB9nDHlc1TNIOi5axSAI6bgFTm/FXETEptldcLaTxtvhDR8BxNSESz7TxDHfwI
         QmKvWO/4v9iojztKo963WLa5qpfGBlXCgWaXwAdA/IkVcWKJ7uuRINL96w2NBXjk1gcO
         GV2MahDd/VK/r1Wg/LMiG2HvmYAgAfRq/OkaX+bW4H276b8IEPGQTWl78aRx3bCDlYe+
         dDm1Cm1Q0UokjWTWoH2CY2iQWsWDGcyxvrHpk21iKhaEEHdJsYNYaG5o9RRq1Yye0EHa
         Dt6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780016463; x=1780621263; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=thtmsDQXFWMlXHx1x8Us7UQcmsS9q77kLGmw0frWVEA=;
        b=hODiTDtmrz8yB25EHXWY7Y0/MVHwGzpSPK0O57G2geyfpVnBqa+KtNrtc1bjJ85OZN
         4RFZiv2M998WYtnE5wDb70wR/2JBEbW+kBtr1Etv6qpM0vvXDAglAkzWCw32sJcsEvWf
         onBy8jHUeYXgAYCxXsQinYMvNsiyFZozvHDZiXYWcBY6cuAojHgOEKXQ0V0/fdSchwKS
         g3VRNhIkRopR0LV0E1Ozk9re8O7Q3Zn2DFr0uLYxoV+DKSF/PrePzdXKUC3cQxoOjUgX
         1i1RzZKTL5HlfE+t+BVTA3CFfa+IIabB8O/5BDksA/mul7wz/O3FSxWgXU4WGEeJKkZS
         w5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780016463; x=1780621263;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thtmsDQXFWMlXHx1x8Us7UQcmsS9q77kLGmw0frWVEA=;
        b=QZPqQV4VqHA5QfhTDjPK8v/jQslea7NxEAEX/rfUxA29LsKZQI1YSpuz6XxkpglJN6
         t3S5e8JC5epoU6L638S3yyJAJb/hwjf7Pu4MynOeBlzcwkJseCdcNtXxz2v8sTkOxHxP
         R5A8vyPOP2kxlR7Sa2OL/P0uRjxZP2TmkSPuucuf7giMp7A6lXuz7cHEk7xA7av7BAjN
         0rEnQEeSebo/q6dH8CcfxvtlSJFGVpmeZcdk1z9DuNaRn3eH4+aU+fTXCDDBJtjgSzZI
         xPwhPzX0L8lB4okAcKsW8EbIgDQ6hxb3N2aR3FBYkkGBj5jl6tfu1TNbextHgNgMyDyK
         EA1g==
X-Forwarded-Encrypted: i=1; AFNElJ/vVGr3yGZLaJ5fn+WXTosSogLP4NLayPwex6dNvPwZHDuD+m6HEsZV8/eLaiTf+RG2hax9OJdFa36L5pJB7O8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHMuso5hA1VVXZrcVG6DM06t1oWwFiAurQVcp8u3ilU0CmGugZ
	yuJ44ySMu2l/bO6H1h0+hwqiIazgQtv18+XGq4CzRn0RxAxbIXKMcDefg2LCA/KAmKswOOhczZn
	UDgsY6nNt4L9m1/9DK4H26gmKeoqE1ps=
X-Gm-Gg: Acq92OEaTUTCGeWeRbWdcXGGH4ATZ7KITpNwwnC11jZrtm2RQYHXUSzqEVu+Rz6WLdo
	naPPZGYnYu92LOKQyyRkl0NEGxc3u6Ua0bwkzJQI0V/lGBb4WcFGYFTZqb40BwwyyjLrG8h4Ww4
	7cmAnaQC/KIdJ5OePJRpR+KksiafLkyc+M5jEKb8JJ/L8SXd8MsKG0fM8emMbmH68ajiC4ajHiB
	vLckiH592yamzjT8PC6/gMW/8QrL+/nMyYVg/L0vkYM1Qz93ILGwXe3s9aYTaxm1baLhrAxfmzU
	FwKfkF9Q8PoMcJfGz6y1
X-Received: by 2002:a05:651c:25c9:10b0:38a:a7b4:15e8 with SMTP id
 38308e7fff4ca-396536cdf9dmr1088571fa.12.1780016462479; Thu, 28 May 2026
 18:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521052611.1815693-1-rollkingzzc@gmail.com>
 <CABBYNZJ7aETr9KdUFdU5uVkcr8RMzOyBS5xv4vpb7ij6Di7FOA@mail.gmail.com>
 <CAB7XQsF72-2zPMKFjko5pKvR-scqyOCT3463cghQBY4G5O4arw@mail.gmail.com> <CABBYNZJt1dLQyFk+vfn4bzktF-a5=LKghXjDDMAomeJMe0NW=w@mail.gmail.com>
In-Reply-To: <CABBYNZJt1dLQyFk+vfn4bzktF-a5=LKghXjDDMAomeJMe0NW=w@mail.gmail.com>
From: Cen Zhang <rollkingzzc@gmail.com>
Date: Fri, 29 May 2026 09:00:51 +0800
X-Gm-Features: AVHnY4L7vJwaQLQsbelVXgZNqJzLsHAc-UXEtWwBfC2JA_mFm5q0B69wfQ4FsIo
Message-ID: <CAB7XQsH8_DiqA9Kd37bUxi6imkjavW1w39bk38-gQ_FaEmZiCA@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: bnep: reject short frames before parsing
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zerocling0077@gmail.com, 2045gemini@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Luiz,

On Fri, May 29, 2026 at 4:48 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> This is what you get if you don't know where to look at:
>
> struct bnep_setup_conn_req {
>     uint8_t  type;
>     uint8_t  ctrl;
>     uint8_t  uuid_size;
>     uint8_t  service[0];
> } __attribute__((packed));
> https://github.com/bluez/bluez/blob/master/lib/bluetooth/bnep.h#L79
>
> It is in fact a tuple of src + dst service as parsed by btmon:
> https://github.com/bluez/bluez/blob/master/monitor/bnep.c#L104

Right, service[] is the dst + src service tuple, each uuid_size, so the
skip after the control type is 1 + 2 * uuid_size.  For v5, I'll name the
byte uuid_size and make the setup-request layout explicit in the comment
so it is not an opaque length.

> Probably just reference the above, but the fact that you couldn't
> mention any of the BlueZ references really bothers me. Although the
> result was correct, the lack of references makes me believe I'm just
> arguing with an AI prompt which doesn't have BlueZ userspace loaded as
> context.

You are right to call this out, and I'm sorry for the noise.

The initial lead for this issue did come from AI assistance.  I then
reproduced the bug under KASAN and checked the kernel-side code, but I
should have done a better job before replying.

I've also been reading the recent kernel discussions around AI-assisted
reports and patches, and I understand the concern better now.  A patch
is not just a bug report saying what can go wrong; it also has to
explain why the change is correct in the subsystem context, so reviewers
are not left doing that work from scratch.  I was thinking too much like
a bug reporter there and not carefully enough as a patch author.  I will
not rely on LLM output as a substitute for reading and understanding the
code.

I'll send v5 with the above and will be more careful with Bluetooth
patches and follow-ups going forward.

Thanks for taking the time to point this out.

Zhang Cen
