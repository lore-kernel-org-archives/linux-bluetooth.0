Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2858539903A
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 21:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779140387; cv=pass; b=qgTeVcdPRcod6/zjvcHtOOq/MFwfgtty3TymPNqkYqr6sA5Uk4iF/+UqEzx6O7AYFs9VnPWqCLKIRuOvXEmOGIn90HGoVNO36BeGXC3rAibec4WR5G1f7xum7lQ/XboHV4gjg418Pn8ktFat758jq3MYIp3Ij8Vbttv/IQxXJs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779140387; c=relaxed/simple;
	bh=dsKPYoDYYJtuLQ37soWSsYZNzmx/H7vwP9z6YPTysPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PBhx8Bxjt5Cq6Jw5voA3Sjn/AQ1CgSe/DNJl5+wXTNE/SZOIPFkS/4Qm0/aUXH4KItKo+QwOjt9Fk7+UCDxdldA04s8jNip9pVLM/sWo13MG8f7K0bCkPe0VgQoT5fEfXJoEJfzhZz5W9piCebyp5UAVAUOmGzcEixwxa061ork=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3hxDL7k; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3hxDL7k"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-65e170f1ca5so2917534d50.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 14:39:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779140385; cv=none;
        d=google.com; s=arc-20240605;
        b=XlIEsIr0M0ycy/oN3CHiIaLLATi/puivZndr/liFdQ8DGdVSxKbw1qLPICdWxjdjL2
         lvbDujUKdsPXLRXbZV+QV//nlRZv6h1z50tnwGajgh/4Yf6obKNeG2sT1sNVBKbfzR0D
         /VZJG3tqeXkCSpvBcx2/P6s5VeCsodJ8Pc3Itq1gmTKwU4J5LFBDDHKC7UN0+v23+mMm
         B2iAVtvX0SJWbAJHvo2EsN/3AtldRfH93yyxb0xbkHLpfkUy7nbmGHsLv3VdhpiOMis+
         CXq35L9gQy69t0HkwQMZdBapci15+XM1IYKTqcRtAR6+8CwFY8jLATeTdhs+3ncN/V5J
         otsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d0HUecEw0PMUFBxiOjQOJyeQcTD5lixC5TSucYgYMqw=;
        fh=SzHRvP5ne8SD/Yc4znsfLwXHDolNt6fVvEgTdqC0wsI=;
        b=IG7S8m+Ck5nZ4xAxAdIAZMKBQ4mXoP2+4Pr6zvhesJ0OWc4YpdYkp+yvaiWF5bo+Wn
         dtLKeLYLt3uL8Z6EhREvNzkQYkT4NbBGBeGSmCt1hBfdWmdt+zeBz7WqWukl4sssrPC2
         zYKvYmlWYf41h6PMbx3q3GseRP3u/+g8oGyrM19wMagx57ECcbDA7U0uo9rhA2kZBc+Q
         cEptvYynCt577lJe8hFysbrAYkxpxWfnUS1uvuf6/4lbgAgmhUbEz3gQB3Rwza+zmtsB
         2OreKcWb/5vS/qqvmK3s/Pm+CsmxFadK7mOK9B2oHdrknw6Ii5kxzJNWFidYNU0T3228
         Qmow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779140385; x=1779745185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0HUecEw0PMUFBxiOjQOJyeQcTD5lixC5TSucYgYMqw=;
        b=Y3hxDL7kQVafvvsXB3ViJBHWr+pJlZ3ZOGrmfjCv5kCLv1oxgSh6UijWYZwb8G6eyr
         8HxiMcwpL/ez7JS0TCEiq6pllriJxTMUPvw62d6SlbmraG9aaY9E+H1AoONA+U7mP50d
         jh8TXPFtvri6/VrtWkyVBfI+X/nslf9kKwN8HzuUeIyiIzLajwKByF/vC/9X+EOF+0tY
         rDbau2cb3AALGNNpuWic2RQ+n5DwAjLV7kd+7hnrmZIIcFm0sS1s0DGxgwkaLS3dvkRw
         D0pKBfIo0A0hLwm3Lt28QtiCW+7pnH2x9e5OUo+xexa4zX5h24yn1hmAN3g9llA+gw2r
         N9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779140385; x=1779745185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d0HUecEw0PMUFBxiOjQOJyeQcTD5lixC5TSucYgYMqw=;
        b=qT26WPzJ4IiOdkP28VA8gobMdebEpfdYHQ+hsk56gk3TpIP0QuUZY/bQFv+uGgKStr
         uhGxeHssI7l+WW8xRZdsR+QB1nUzCjoi1wLfHN5DV4cZAObqd99uuUD/DkLqWL9d1RZo
         /UOtY9rlpiJdLXEZMfHY7PAoOzQOhcQ1AygBFOznt+nbiRa+OODiQ6KLPAOlDCfq4s//
         zBoVxjpsB2svMBHvEkCUtxDPEIDd/0sItfYMcX6LcNEPedqs+odTq58OpGpfMdGtB1aL
         wu/XjAIp0bPrI6Bb2ktGoZuyJ3kyALKQXRDzrWCrQATqdhIeNXWHmmcV1yfSoriPMf5D
         mwwA==
X-Forwarded-Encrypted: i=1; AFNElJ/9tuv32XRsVhSqUEHIlNRD7e/XtoH+4u3JBd1A7rcYcIGz+UCIDrg1hN54M6CQ/mLSfNIoDvvxY5YN+WoQg3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxWgHvVInPJ/APUeBwCWkU8R4ZpHh10OvSnDQviWvtlC+1W5fp
	qfC1RH0Uc70uizjmdexjgn4Fs93wdGF8xgw4pNTq/2wrtkeQdoEb+6RohlGQvv4uaQlvql3nMH4
	JCtmPNZo3h3ppz4FvZ5XSqC3k4V9+vf8=
X-Gm-Gg: Acq92OEBTl/P9Nvh5v4KIXizQLzbZY8mTBwzjec8enFBxgVeo0haP4+nOnniGalTVoz
	jKfK0muQAY/LiZCdl1etNj0bd2vOomWcSTooX0EXZVVXHJV/rFWlD/988+4Tt9sfxMovBaYG6BU
	sIJLhXyGbo7rHa3NkVUQg79dzSSvkYXCsKg8zvdHBjvJtcvm71Dv5Yxnx/JLqvgrQCJUEXKHkxx
	dQ0XCjIIvY4uikHhPtVD4B7XF09eQqTGYtZsF/49mbufYq+C3kcwT8NvEyUjCfgIGeIZBLwLk4r
	GxL+E+UeafUfoU4bWz6OTOW0YB/eU+21iWJMZsIBDC7FV4HaIp8kAmtG7loNBa5qbjE9hiJM67g
	EcQ==
X-Received: by 2002:a53:acce:0:10b0:65c:c744:36b6 with SMTP id
 956f58d0204a3-65e22686bd8mr13237042d50.8.1779140385086; Mon, 18 May 2026
 14:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516004433.3199522-1-rollkingzzc@gmail.com>
In-Reply-To: <20260516004433.3199522-1-rollkingzzc@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 18 May 2026 17:39:33 -0400
X-Gm-Features: AVHnY4Jm81Lp4l4vPeLTB-07WtvbRw6ZlL_CVZwxTLCAChCfa7x-pc2tiemxIgc
Message-ID: <CABBYNZKC+Wr+0_aDUxpc2NmpfkM3_Gb7nvDxEChFPjdQZ0Dk-A@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: bnep: reject short frames before parsing
To: Zhang Cen <rollkingzzc@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zerocling0077@gmail.com, 2045gemini@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 15, 2026 at 8:44=E2=80=AFPM Zhang Cen <rollkingzzc@gmail.com> w=
rote:
>
> An L2CAP peer can deliver an empty BNEP payload or a payload that contain=
s
> only the outer type byte. bnep_rx_frame() currently reads the BNEP type
> byte and, for control packets, the control opcode before it proves that
> the skb contains those bytes. The BNEP_SETUP_CONN_REQ path can also read
> the setup size byte before that byte is present, and bnep_rx_control()
> dereferences the control opcode before checking that its control payload
> is non-empty.
>
> Reject empty skbs before reading the outer type byte, require a control
> opcode before parsing BNEP_CONTROL, require the setup size byte before
> using it, and make bnep_rx_control() fail zero-length control payloads.
>
> Validation reproduced this kernel report:
> KASAN slab-out-of-bounds in bnep_rx_frame()
> Read of size 1
> Call trace:
>   dump_stack_lvl() (?:?)
>   print_address_description() (mm/kasan/report.c:373)
>   bnep_rx_frame() (net/bluetooth/bnep/core.c:306)
>   print_report() (?:?)
>   __virt_addr_valid() (?:?)
>   srso_alias_return_thunk() (arch/x86/include/asm/nospec-branch.h:375)
>   kasan_addr_to_slab() (mm/kasan/common.c:45)
>   kasan_report() (?:?)
>   process_one_work() (kernel/workqueue.c:3200)
>   worker_thread() (?:?)
>   __kthread_parkme() (kernel/kthread.c:259)
>   kthread() (?:?)
>   _raw_spin_unlock_irq() (kernel/locking/spinlock.c:204)
>   ret_from_fork() (?:?)
>   __switch_to() (?:?)
>   ret_from_fork_asm() (?:?)
>   kasan_save_stack() (mm/kasan/common.c:52)
>   kasan_save_track() (mm/kasan/common.c:74)
>   __kasan_kmalloc() (?:?)
>   vpanic() (kernel/panic.c:576)
>   panic() (?:?)
>   preempt_schedule_common() (kernel/sched/core.c:7352)
>   preempt_schedule_thunk() (?:?)
>   end_report() (mm/kasan/report.c:219)
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>
>
> ---
> diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
> index d44987d4515c..f5070bbd6b57 100644
> --- a/net/bluetooth/bnep/core.c
> +++ b/net/bluetooth/bnep/core.c
> @@ -208,9 +208,14 @@ static int bnep_ctrl_set_mcfilter(struct bnep_sessio=
n *s, u8 *data, int len)
>
>  static int bnep_rx_control(struct bnep_session *s, void *data, int len)
>  {
> -       u8  cmd =3D *(u8 *)data;
> +       u8  cmd;
>         int err =3D 0;
>
> +       if (len < 1)
> +               return -EILSEQ;
> +
> +       cmd =3D *(u8 *)data;
> +
>         data++;
>         len--;
>
> @@ -303,14 +308,21 @@ static int bnep_rx_frame(struct bnep_session *s, st=
ruct sk_buff *skb)
>
>         dev->stats.rx_bytes +=3D skb->len;
>
> +       if (skb->len < 1)
> +               goto badframe;

Lets stop using skb->len directly and just skb_pull_data and theck if
the return is NULL.

>         type =3D *(u8 *) skb->data;
>         skb_pull(skb, 1);
> -       ctrl_type =3D *(u8 *)skb->data;
>
>         if ((type & BNEP_TYPE_MASK) >=3D sizeof(__bnep_rx_hlen))
>                 goto badframe;
>
>         if ((type & BNEP_TYPE_MASK) =3D=3D BNEP_CONTROL) {
> +               if (skb->len < 1)
> +                       goto badframe;
> +
> +               ctrl_type =3D *(u8 *)skb->data;
> +
>                 if (bnep_rx_control(s, skb->data, skb->len) < 0) {
>                         dev->stats.tx_errors++;
>                         kfree_skb(skb);
> @@ -326,6 +338,9 @@ static int bnep_rx_frame(struct bnep_session *s, stru=
ct sk_buff *skb)
>                 switch (ctrl_type) {
>                 case BNEP_SETUP_CONN_REQ:
>                         /* Pull: ctrl type (1 b), len (1 b), data (len by=
tes) */
> +                       if (skb->len < 2)
> +                               goto badframe;
> +
>                         if (!skb_pull(skb, 2 + *(u8 *)(skb->data + 1) * 2=
))
>                                 goto badframe;
>                         break;



--=20
Luiz Augusto von Dentz
