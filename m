Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855491E525
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Apr 2024 23:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713741445; cv=none; b=Il0ZM4xpnErwX40tTToTNDlOW+lOQ3TzmLE3mvCjZJ1kk4WGkbwOeuakrBDsngIsBtDdkImG9p11mOraxxQ0fC9yLOg9rz9ze8DPNZti3x3bw0Qk7wLmFFaTSB6+XqkXc4tSyqLneeJGiAzzmjIzo4s0AeSNCMTgKVTtFQiU4nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713741445; c=relaxed/simple;
	bh=WPHJ8jIX26rEwkvduVUxNyGj9e35OtyCTCYZkuAloSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJu0R5WXKQ5ndq3vD7c2N27JfBrdShw4NRgt/cQkaBcE7tuEDHdTU9MjLAuzXME1PKHk9f2yc0t4eL1AogLdXxXfeRlDfyoGmZWE+L3u+EAfV/2prdaKGC4O9pK8sKz4INFfDgfI1tOkpCUItr6lNvCdVUh5+VYKv11Gfpzt0FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=m4x.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=m4x.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-de47485532cso3455586276.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Apr 2024 16:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713741442; x=1714346242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfgAEXBcQOd8UzPb5qH32b/khj+DQW8szwmBobhaae0=;
        b=tbNp/rsFVK/UwEbwF/TLNWYCwaPFMP10Oybc2TLuOnUaXI8CM+pVDd5Ru1KkRVPeIG
         fj3mZVSFxfbskNV45D8WqH+uvnrX7rhl38gM7hbtxbjh4fxZeeSsKB+gsHiM4n9mJcyA
         8gxU2mm7Ap8qI2X/FhAACpfX9Oe5sB7vdxNClx4mUyZXqMxOMxdsqTq/IKQaT5+DO6KU
         pe7tB/ZjJMKsOFxCBeUFUnEBSXxkxt1iOhSw8oR8PO0/5uf0rzQC2Gl10/vtoFtjLrOL
         pelzbAEq6VxLTivwBdQ6rYRPadzTotdhyfr5+EYxvZfkJodwaAkTRG4URofMpap5mA2c
         Ortw==
X-Gm-Message-State: AOJu0YwlxprwrpF2KjHtD5bCGILgfc+BIdkGp/Yjp5t8LwMUuoMNRzKB
	dyslnmOAIvfU8v60sm/2/RCnlCo68KDfDkjFIqy3aQngP5nXWjxsTHnolQyLAp/UeK4iaeqZyX8
	d1iLCxWrDplH1FgJtdBA4MzPIDqdCc3MW
X-Google-Smtp-Source: AGHT+IHL30zcY2nQMw+jpz6oqOzygr6Ivc7gQssdlwLmX4hzaD4AXPe/9i0fPq5cpLjEeFmQUefRBKhziFdgbl92lGM=
X-Received: by 2002:a25:acc3:0:b0:dd0:6d11:1a71 with SMTP id
 x3-20020a25acc3000000b00dd06d111a71mr7812521ybd.10.1713741442391; Sun, 21 Apr
 2024 16:17:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADRbXaDqx6S+7tzdDPPEpRu9eDLrHQkqoWTTGfKJSRxY=hT5MQ@mail.gmail.com>
 <8eeb980a-f04a-4e94-8065-25566cfef4dd@molgen.mpg.de>
In-Reply-To: <8eeb980a-f04a-4e94-8065-25566cfef4dd@molgen.mpg.de>
From: =?UTF-8?Q?Jeremy_Lain=C3=A9?= <jeremy.laine@m4x.org>
Date: Mon, 22 Apr 2024 01:17:10 +0200
Message-ID: <CADRbXaD5Fsy0dxjrVG2JAn1PA36hpoTe6=23=zbhx8NWNf_9mg@mail.gmail.com>
Subject: Re: Bluetooth kernel BUG with Intel AX211 (regression in 6.1.83)
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Sun, Apr 21, 2024 at 11:01=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de=
> wrote:
>
> Would you be so kind to go the extra mail, and bisect the commit between
> 6.1.82 and 6.1.83 [1]?
>

Thanks for the link to the instructions, here's the bisect log:

git bisect start
# status: waiting for both good and bad commits
# good: [d7543167affd372819a94879b8b1e8b9b12547d9] Linux 6.1.82
git bisect good d7543167affd372819a94879b8b1e8b9b12547d9
# status: waiting for bad commit, 1 good commit known
# bad: [e5cd595e23c1a075359a337c0e5c3a4f2dc28dd1] Linux 6.1.83
git bisect bad e5cd595e23c1a075359a337c0e5c3a4f2dc28dd1
# bad: [440e278cb53b8dd6627c32e84950350083c39d35] net: kcm: fix
incorrect parameter validation in the kcm_getsockopt) function
git bisect bad 440e278cb53b8dd6627c32e84950350083c39d35
# good: [a4116bd6ee5e1c1b65a61ed9221657615a2f45bf] arm64: dts:
imx8mm-kontron: Disable pull resistors for SD card signals on BL OSM-S
board
git bisect good a4116bd6ee5e1c1b65a61ed9221657615a2f45bf
# good: [e16c33dd9967b7f20987bf653acc4f605836127b] net: mctp: copy skb
ext data when fragmenting
git bisect good e16c33dd9967b7f20987bf653acc4f605836127b
# bad: [6083089ab00631617f9eac678df3ab050a9d837a] Bluetooth: hci_conn:
Consolidate code for aborting connections
git bisect bad 6083089ab00631617f9eac678df3ab050a9d837a
# good: [934212a623cbab851848b6de377eb476718c3e4c] SUNRPC: fix some
memleaks in gssx_dec_option_array
git bisect good 934212a623cbab851848b6de377eb476718c3e4c
# good: [8499af0616cf76e6cbe811107e3f5b33bd472041] igb: Fix missing
time sync events
git bisect good 8499af0616cf76e6cbe811107e3f5b33bd472041
# good: [653a17a99d752ffde175d4bc96154f2a3642f400] Bluetooth: Remove
superfluous call to hci_conn_check_pending()
git bisect good 653a17a99d752ffde175d4bc96154f2a3642f400
# good: [1023de27cd1d0d692e70fe6d6d5cee9fff9b9c84] Bluetooth: Cancel
sync command before suspend and power off
git bisect good 1023de27cd1d0d692e70fe6d6d5cee9fff9b9c84
# good: [ac7a47aaa7944efc94e4fc23cc438b7bd9cc222c] Bluetooth:
hci_sync: Only allow hci_cmd_sync_queue if running
git bisect good ac7a47aaa7944efc94e4fc23cc438b7bd9cc222c
# first bad commit: [6083089ab00631617f9eac678df3ab050a9d837a]
Bluetooth: hci_conn: Consolidate code for aborting connections


> You can pipe the output through `scripts/decodecode` and it should show
> more information.

This was the output of running the dmesg snippet through `scripts/decodecod=
e`:

All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   fe                      (bad)
   1:   ff 0f                   decl   (%rdi)
   3:   0b 48 89                or     -0x77(%rax),%ecx
   6:   f2 48 89 fe             repnz mov %rdi,%rsi
   a:   48 c7 c7 48 18 7a 9f    mov    $0xffffffff9f7a1848,%rdi
  11:   e8 14 a1 fe ff          call   0xfffffffffffea12a
  16:   0f 0b                   ud2
  18:   48 89 fe                mov    %rdi,%rsi
  1b:   48 89 ca                mov    %rcx,%rdx
  1e:   48 c7 c7 10 18 7a 9f    mov    $0xffffffff9f7a1810,%rdi
  25:   e8 00 a1 fe ff          call   0xfffffffffffea12a
  2a:*  0f 0b                   ud2             <-- trapping instruction
  2c:   48 89 fe                mov    %rdi,%rsi
  2f:   48 c7 c7 d8 17 7a 9f    mov    $0xffffffff9f7a17d8,%rdi
  36:   e8 ef a0 fe ff          call   0xfffffffffffea12a
  3b:   0f 0b                   ud2
  3d:   48 89 fe                mov    %rdi,%rsi

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   0f 0b                   ud2
   2:   48 89 fe                mov    %rdi,%rsi
   5:   48 c7 c7 d8 17 7a 9f    mov    $0xffffffff9f7a17d8,%rdi
   c:   e8 ef a0 fe ff          call   0xfffffffffffea100
  11:   0f 0b                   ud2
  13:   48 89 fe                mov    %rdi,%rsi

Best regards,
Jeremy
