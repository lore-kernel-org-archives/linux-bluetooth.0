Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0FA8460
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Sep 2025 02:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757729794; cv=none; b=f6a73l+5wFF1re/b9f2BIMYh9Rm7fBOxenIWAbhst49NyVcCehtIDN04bhttXFLE4rQ8oldosV6ddVmvFc8hXUWSLYok+dS80GAtfGkPMixhk5NO0jIOpbiyWtIFFyMyldFdoTtlUDicQ3cvtku+8yWKmsttal2L2LqdonsVl8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757729794; c=relaxed/simple;
	bh=xGbt/rQns9Xu5005jWUhfQNWdPT+cghf1LrEGQeNWFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+IVwcMRQ1xL0INx9xcjjrD3EUUieOVtWiQ8hIFMeEOtfQCZM3pmsRtU6ltd9HrSx0sokA8rCAUnvzoEXtyhpx4sxpBYzfMxkrCxOmQhHVES79YQhB91z8Tcy49KTLeM/XJQmW+jX6MFylcA+ZyZNVsRwQvHlJ6Wjj+uPWU/mfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhqNS/da; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhqNS/da"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-ea3e7c4aef5so661225276.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 19:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757729792; x=1758334592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGbt/rQns9Xu5005jWUhfQNWdPT+cghf1LrEGQeNWFI=;
        b=bhqNS/dakLhQNXHeGd35vFqEnlG8EnX+a9Gbg67EOUje61ZaoV6MQ5VQuWx2jNwcmb
         1UgrWtYzPbaOYDNxh4jeEdwnt5gLtO9pe+XA9/Zvw/tsEj9tTgDci8mlPtP1rcsuedjY
         P7ioeokpljH2rU5tLV+3wm8pyxedjz+pYzWsBK66I1pKN+5tYNL5NmEimYhq1aJQ2KR5
         cG6jTcY+8Hhwo2fOhHF4C2wNO1yZHg6eGaasMa8tNkJhS9Gf/m+wme+IDbZSYLjO4v8k
         8TOr6OtK724LF3jot+UekM6OR4ikTTrOH/QTNRvLnLvP2llerrs4KKkUWqNlAlYZ2WYT
         gbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757729792; x=1758334592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGbt/rQns9Xu5005jWUhfQNWdPT+cghf1LrEGQeNWFI=;
        b=m6eYJFvNxfYPnqu+vC1pFRrG4DZcgagki3FHxkIsP4laj4nLN6xR/t/R1XGV9QffqP
         MlyaaBrILZ3uPjOIsQ1+H3G94dzIjZ6oF15uoKgKGRgBjkJjhsoD2XXG/0x/S8KuH0Gm
         AdPY3v03EJtHM5z3xdjfo2rgKPpN0OO1eo7RROnuL4naOm2o/NLYnQX8hcD2MUVsoFjg
         qOeFY1dNr2at8Eh808O2XM5LcSfyZEew51Vup5evdrIKMi0V/O7DGCaazUuS/sjAIrbd
         pTc50+/BIu/wpA5vMMVdpfjrPWLEXqonZeR0UWa4+h6LTVR0dUbOuGDVK0AlwzqjVXYs
         5/Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVpMsZLII4D5xGn3ssTNaVPCituw4yhXjItTWAn+71q5umsh1qhh/ln+YgyuHmK2mg63NhzC9PntvK761iL70Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Ts23FXEkA7U3l2CLo80U0SSMK8xGISvmbZojSA2urkfkxa5Q
	3n2480MUO3wHbrHCvCriM1IOeDr74xVcNZaKsOdBsGIJN5xnBux6dhBmeEFrKbTd9hFS13NjO0c
	dqRj/V6CDqL164x+TnajfmGycqqAh+wU=
X-Gm-Gg: ASbGncuCaUtnX5EkleAro0l0Z/TsOyK3SYXbJyo5z7I9bhLM/UJjBJvaMKxAbCD8f4N
	nbbU3WX6KUot0Z3HisthKY2wuVN8hP9gLV1Xu/6cuMpJeLokPejIbA3mQUAh0Z0fjh9eQi6i1hp
	EFZemIWzNUyGuMQdkgyVxAMthrqMIgWLltqLpH3eULSKmqgRyosQbCm6RTjYD7qeCp6GV0qWs88
	CZJEdq1VY1OW41vTPtorkaqSRA=
X-Google-Smtp-Source: AGHT+IEuudP1MbDDzDJ1Axa9SCCj4RwO48Bzzr207D0xOeX8T5X5b1dOTn/r/1lDgWqGhIk9sTkt80hOQTBN9t/z3bM=
X-Received: by 2002:a05:6902:540f:b0:e9d:75c1:7584 with SMTP id
 3f1490d57ef6-ea3d9a326e2mr4933440276.15.1757729791476; Fri, 12 Sep 2025
 19:16:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFRLqsUfDuoMMCUmBuSkiV_b=VNn7CuYqJSc19bhyQ6Kims36w@mail.gmail.com>
 <CABBYNZ+PJuvWYk_XVw=esNj1hVMPESjTc70VLQH=LrKdSqD7ag@mail.gmail.com>
 <CAFRLqsUE84wW0JKbsh6Lw0USQbnCbokXd3PANc+4i_nsnEUMYA@mail.gmail.com> <CABBYNZ+xg05sbfU51VXo1M=PqPOktDtRpTe5yHwwUhF9ui+NPA@mail.gmail.com>
In-Reply-To: <CABBYNZ+xg05sbfU51VXo1M=PqPOktDtRpTe5yHwwUhF9ui+NPA@mail.gmail.com>
From: cen zhang <zzzccc427@gmail.com>
Date: Sat, 13 Sep 2025 10:16:19 +0800
X-Gm-Features: Ac12FXzsluXLpHyt7EcRtG6kj7lTIOteS8YvIwP_xzOAOF1VPauaqg8FN5vOBFI
Message-ID: <CAFRLqsVj28niHO9XejYrMu2g3fCrDXXgArshP-kr4CM=eV2smQ@mail.gmail.com>
Subject: Re: [BUG]: slab-use-after-free Read in mgmt_set_powered_complete
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: johan.hedberg@gmail.com, marcel@holtmann.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, zhenghaoran154@gmail.com, r33s3n6@gmail.com, 
	linux-bluetooth@vger.kernel.org, "gality369@gmail.com" <gality369@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

Thanks for your patch! It not only addresses the TOCTOU issue we
discussed but may also fix another bug I reported
(https://lore.kernel.org/linux-bluetooth/CAFRLqsWWMnrZ6y8MUMUSK=3DtmAb3r8_j=
fSwqforOoR8_-=3DXgX7g@mail.gmail.com/T/#u).

I will test it soon to confirm.

Thanks again for the great work.

Best regards,

Cen Zhang

Luiz Augusto von Dentz <luiz.dentz@gmail.com> =E4=BA=8E2025=E5=B9=B49=E6=9C=
=8813=E6=97=A5=E5=91=A8=E5=85=AD 02:29=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Cen,
>
> On Fri, Sep 12, 2025 at 11:59=E2=80=AFAM cen zhang <zzzccc427@gmail.com> =
wrote:
> >
> > Hi Luiz,
> >
> > Thank you for your quick response and the important clarification
> > about hci_cmd_sync_dequeue().
> >
> > You are absolutely correct - I was indeed referring to the TOCTOU
> > problem in pending_find(), not the -ECANCELED check. The
> > hci_cmd_sync_dequeue() call in cmd_complete_rsp() is a crucial detail
> > that I initially overlooked in my analysis.
> >
> > After examining the code more carefully, I can see that while
> > hci_cmd_sync_dequeue() does attempt to remove pending sync commands
> > from the queue, but it cannot prevent the race condition we're seeing.
> > The fundamental issue is that hci_cmd_sync_dequeue() can only remove
> > work items that are still queued, but cannot stop work items that are
> > already executing or about to execute their completion callbacks.
> >
> > The race window occurs when:
> > 1. mgmt_set_powered_complete() is about to execute (work item has been =
dequeued)
> > 2. mgmt_index_removed() -> mgmt_pending_foreach() -> cmd_complete_rsp()=
 executes
> > 3. hci_cmd_sync_dequeue() removes queued items but cannot affect the
> > already-running callback
> > 4. mgmt_pending_free() frees the cmd object
> > 5. mgmt_set_powered_complete() still executes and accesses freed cmd->p=
aram
> >
> > I am sorry that I haven't get a reliable reproducer from syzkaller for
> > this bug may be due to it is timing-sensitive.
>
> Let's try to fix all instances then, since apparently there is more
> than one cmd with this pattern, please test with the attached patch.
