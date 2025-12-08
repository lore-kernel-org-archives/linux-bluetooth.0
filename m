Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EAB1E51E0
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Dec 2025 18:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765219667; cv=none; b=hY3hbifqnEVGFaJVbxMcV3F4i5N2+9xE1HClkep1wus8Il5JUM41B88nXQbh2ORbXmg1Dx+1x4WalbwFHUbqz1LFxrpEr+G8l32TGs3pGku3CHWrBheJmnQ1Ixp8KvSl73WVFVNYcexER4AUchdI2jGAjPIo9uB9J8oJ5VDFnr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765219667; c=relaxed/simple;
	bh=YZk3Sf2g9/OaeHwX1jLe59gBzjmkPEwxvFUFvI6nw1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKKvAdUNpCGradxKh5ppOXT8YbOzsoktQGcZkMvm1fsPRjUIFw1QvEPFvtWGRe2K5HE9RdgL2MLrAm7kVQWr4zLR3ZCpyZT2C35Wav6V9B29QQvJ0lMIEqIkouu6B9Nng0u0SStfgbBtUkTSJHCb+B5P2uT9bb82nwUQ2U86zL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaPP/umQ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaPP/umQ"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5958187fa55so3811931e87.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Dec 2025 10:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765219662; x=1765824462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FxxS+BRVWZ6SqobY4sstRJ0/MH7UUsU8d+YBEULlRU=;
        b=DaPP/umQZgCJbHuInO6F3yD2K7RNm733U2W91pMbYb5ncI+Pv7yzIWw8J+L3Halj6N
         rJ4TLKVMwZuEA9mRAKzQff6m+05tENyJT7FrJkHulCVllu8GyQkIYiZfY/d3N+esYpKN
         bltQpEpmab9uXsMYE646eVqLj/57bLZ//SwL6azh1IRJA3gyuK/nu57INhfZstewpamm
         e0J61zXZ4XIpRs4V4KV64JCb7eKsVlmHFIEsXh4UvFQETVA0B49wqpQ/yfDcHIKh3zXT
         r8+HlMsigwr2oEswrJhkx3YmL+ORjCW5psiTSz5uzo4PSjFaXmQay525+jj7ZVfanr7K
         JR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765219662; x=1765824462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9FxxS+BRVWZ6SqobY4sstRJ0/MH7UUsU8d+YBEULlRU=;
        b=gYOr70TM5bWwB/bBhuWtRVoK1GZh4cZeGoQ5nbm5KAQ8LMLRxWlUarE7xxo9KU1DDc
         pf8axak7CBrQ/xOHf7qPf9lSqcM/Bacj4BYvqPg0vzRYXEu+jwFMHzuZlwI5g2yjA4+w
         dVIH7U9f+2FfkxIJFISRxS4Q/CGEoQ3Loojk4yZ4yjunVYI+vwG2STUOsqS6PznCBOkj
         HyOggRc6lRYTjcT4OrjrxBbxTM8+B2dVKTWVJvIJkzN9iB+j8DMa5DIw7sZgc08Bw7De
         6n2YSHka9aMfCPW59EYit16ucuxnPBjImwtfgBwtiZqRKqwqNky6i50bK5oeCjkAjX+y
         1hzg==
X-Gm-Message-State: AOJu0YzeSEHXGAc1oFefr4VLPxjBhdIGn+yofQKpaQJBUxoz6WbH336t
	nj4c5lV1nBwvZfKqZzUlJvB3Rpyq7Hh6Nr4UyOdz2ThPQvgD/dK2zXLwU3c84kbYQy2SZOY5FvU
	L2/6QXWQnEwNspwj6OpPKtS33UdwT9FIroceKjNg=
X-Gm-Gg: ASbGncsdh8pOatpnLsRwOnaBqXVJthd8/lRxWv+JFKWHeo4wQ0vHfPBDjLBE0GMHTT3
	/XaQwxVI/cYGjaJjXLjDJCGkOwNOlB89dwwg7S1lMpQn0s38swTnB4lLOHhhE4XdOSwQqcA/7kG
	96mwRNegJMk3A7ta4ko/9mNs79xHoUiY5DQ2IIaKxKk9IRnImLwSjr+r628+dXVfkXhQwj52Lv3
	BgvSq4UCekJJV6WxpajfYn6PbujRWC/oP7wqBWYBbskZwyXq1HWA21ds1kc1lKbAEH7Gg==
X-Google-Smtp-Source: AGHT+IEQJiRsmb47cNLIclMvSiqGchJCBhSvqXfcznoZqzh0cuwMtCOf/C42/4+maQ4OcS768KtuzLsXujGUtLDa8Wk=
X-Received: by 2002:a05:6512:3b27:b0:595:81c1:c57 with SMTP id
 2adb3069b0e04-59876c7e790mr2982614e87.11.1765219661963; Mon, 08 Dec 2025
 10:47:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205233253.550032-1-andrew.smirnov@gmail.com> <6933786b.050a0220.898a8.b4ff@mx.google.com>
In-Reply-To: <6933786b.050a0220.898a8.b4ff@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 8 Dec 2025 13:47:28 -0500
X-Gm-Features: AQt7F2q42xORG_e1ReGcboN9oD2_K6OPrGDREL0eAlFRTMxjSZxywzR0B_0Qc30
Message-ID: <CABBYNZLMJy+gBWDaNYViv5EbW51fUXapzUvd25Z3CCJ87vvTSA@mail.gmail.com>
Subject: Re: [BlueZ,v3] monitor: Add unknown options decoding for Configure Response
To: linux-bluetooth@vger.kernel.org
Cc: andrew.smirnov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, Dec 5, 2025 at 7:27=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D103=
1008
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PENDING   0.37 seconds
> GitLint                       PENDING   0.35 seconds
> BuildEll                      PASS      20.17 seconds
> BluezMake                     PASS      650.69 seconds
> MakeCheck                     PASS      21.59 seconds
> MakeDistcheck                 PASS      243.11 seconds
> CheckValgrind                 PASS      303.27 seconds
> CheckSmatch                   WARNING   355.85 seconds
> bluezmakeextell               PASS      184.68 seconds
> IncrementalBuild              PENDING   0.35 seconds
> ScanBuild                     PASS      1053.31 seconds
>
> Details
> ##############################
> Test: CheckPatch - PENDING
> Desc: Run checkpatch.pl script
> Output:
>
> ##############################
> Test: GitLint - PENDING
> Desc: Run gitlint
> Output:
>
> ##############################
> Test: CheckSmatch - WARNING
> Desc: Run smatch tool with source
> Output:
> monitor/l2cap.c: note: in included file:monitor/display.h:82:26: warning:=
 Variable length array is used.monitor/bt.h:3854:40: warning: array of flex=
ible structures
> ##############################
> Test: IncrementalBuild - PENDING
> Desc: Incremental build with the patches in the series
> Output:

ERROR:CODE_INDENT: code indent should use tabs where possible
#10: FILE: monitor/l2cap.c:737:
+                                 uint8_t *expect_len)$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#10: FILE: monitor/l2cap.c:737:
+                                 uint8_t *expect_len)$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#12: FILE: monitor/l2cap.c:739:
+       int i;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#14: FILE: monitor/l2cap.c:741:
+       for (i =3D 0; options_table[i].str; i++) {$

ERROR:CODE_INDENT: code indent should use tabs where possible
#15: FILE: monitor/l2cap.c:742:
+               if (options_table[i].type =3D=3D type) {$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#15: FILE: monitor/l2cap.c:742:
+               if (options_table[i].type =3D=3D type) {$

ERROR:CODE_INDENT: code indent should use tabs where possible
#16: FILE: monitor/l2cap.c:743:
+                       *str =3D options_table[i].str;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#16: FILE: monitor/l2cap.c:743:
+                       *str =3D options_table[i].str;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#17: FILE: monitor/l2cap.c:744:
+                       if (expect_len)$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#17: FILE: monitor/l2cap.c:744:
+                       if (expect_len)$

ERROR:CODE_INDENT: code indent should use tabs where possible
#18: FILE: monitor/l2cap.c:745:
+                               *expect_len =3D options_table[i].len;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#18: FILE: monitor/l2cap.c:745:
+                               *expect_len =3D options_table[i].len;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#19: FILE: monitor/l2cap.c:746:
+                       return;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#19: FILE: monitor/l2cap.c:746:
+                       return;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#20: FILE: monitor/l2cap.c:747:
+               }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#20: FILE: monitor/l2cap.c:747:
+               }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#21: FILE: monitor/l2cap.c:748:
+       }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#23: FILE: monitor/l2cap.c:750:
+       *str =3D "Unknown";$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#24: FILE: monitor/l2cap.c:751:
+       if (expect_len)$

ERROR:CODE_INDENT: code indent should use tabs where possible
#25: FILE: monitor/l2cap.c:752:
+               *expect_len =3D 0;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#25: FILE: monitor/l2cap.c:752:
+               *expect_len =3D 0;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#29: FILE: monitor/l2cap.c:756:
+                                 uint8_t offset)$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#29: FILE: monitor/l2cap.c:756:
+                                 uint8_t offset)$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#31: FILE: monitor/l2cap.c:758:
+       struct l2cap_frame frame;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#32: FILE: monitor/l2cap.c:759:
+       uint8_t type;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#34: FILE: monitor/l2cap.c:761:
+       l2cap_frame_pull(&frame, source, offset);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#36: FILE: monitor/l2cap.c:763:
+       while (l2cap_frame_get_u8(&frame, &type)) {$

ERROR:CODE_INDENT: code indent should use tabs where possible
#37: FILE: monitor/l2cap.c:764:
+               const char *str;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#37: FILE: monitor/l2cap.c:764:
+               const char *str;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#39: FILE: monitor/l2cap.c:766:
+               lookup_option_by_type(type, &str, NULL);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#39: FILE: monitor/l2cap.c:766:
+               lookup_option_by_type(type, &str, NULL);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#40: FILE: monitor/l2cap.c:767:
+               print_field("Option: %s (0x%2.2x)", str, type);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#40: FILE: monitor/l2cap.c:767:
+               print_field("Option: %s (0x%2.2x)", str, type);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#41: FILE: monitor/l2cap.c:768:
+       }$

>
>
> ---
> Regards,
> Linux Bluetooth
>


--=20
Luiz Augusto von Dentz
