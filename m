Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC5A4014A4
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 15:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774539336; cv=pass; b=Yqyrtt5oxsUAI7YkKrwxpTOUH+7Z4GtvUTmkZU+ioNkbP9nMp8Pu7LdemiTiehZGQD69ISKRtQVrrb9fHUcXx1NAGkQ9chXL4/PLbrjGFox8BTmmnjHXvbgzDqvJIwABMQLecXEcN/P3+3lRgXr0/OQDqUmgQ4sAUrtCU+lwte4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774539336; c=relaxed/simple;
	bh=jgDCDagFxs45kepszyAwXrusEA0s3E501ts5BEvMEjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMH+BM/33dgnZBfGXp4N5lITz4Z5l/UX8QOIPuFmi0GdziZFotABiP/AdtGqpte8ZibqLPU6pFNEJQja+0s7JBYzvw4YHuk0HeEZKopmoluMLCJF3S4dk56URrowIigkYi6RsNBFg0P0Lqf+z+qEAxu3PPhzcBcNdZCJ4AuSehA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDyza4sE; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDyza4sE"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-794719afcd4so12797497b3.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 08:35:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774539334; cv=none;
        d=google.com; s=arc-20240605;
        b=iKJpfi6BPo+VgQepIxqRjy2h55GuOX6HsADcxahwK0CUIeWp3duvBEl/7xEXdAgzxS
         d+SzcroFLJRpUctjtf6XdWnXI4NrOzibmB0fcJW8tc5Na9qcTr/sH5mKD4EY5g2TkhEt
         pfgmYgtDcgFg3wVgESq/kAqR4lrb63xAHzJ6qSjTs+RHAG53Lv6TqaI3UZDiCpziQJ8Y
         nqPc64+yiBCw2noMHyeUjoGlUCCLh40Gpd3Pc7JLfDtmNEUy8RmfiPR5b05BO54kjdQ+
         ZGiMg8UhvmbOn8rcBFTkUQC0b+JPDFc3TjrrAyGRPaFNsZW83b5FcMmddUelhmNG18nd
         i0yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HE1n6fNopOli1ZrfFGiFRLxGHswUymMuekCzV9grZto=;
        fh=ZJA8dYE675G4uYvjKtxbD9wCx8k+PK5mWLFbGVIbBZY=;
        b=J/zCTl8La4v6JvAoIYYVMVWboCl8L+Ct6pIXyld+58MNeWgLcQIMCvrIoGIpmufbf0
         i3s4PO4qtlgv7OQ/F//njdIlndn/ZEWnrkXNljaQ2crR24C3tz7XfzU3kzj4HD6/f8gl
         QtnYlehzYHLfMAfcq9FLXlfYDzaHruLcug/IevXJYjBJNrtwA1st3liNzqxsA8h0maot
         +R3arK0WmimH46F/gVpzh1aj4AOCoig6CgVSCiwqAUP7930cTJJYlp5HZFWQcIpq1In9
         AEaXxA5EZMJ7Y+BaF+IWVGCgUlL/Hg67hlotTYV55Ouf6jTUe+XdzK/vlQKJG06x6eOy
         b+BQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774539334; x=1775144134; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HE1n6fNopOli1ZrfFGiFRLxGHswUymMuekCzV9grZto=;
        b=JDyza4sEy5D/TLmHXXklpXX038Sy8jU4QbP6l8GxZFR8MxI5PVKvi8lkLL31moCANF
         c69jclPKJIHVQfOEe59/VM+Daf4tJWFx+WE+A06EuC3eQ96ttI9Iu65hACvSs8M2PBeO
         TsRu8PwDaTYkF4AwILGIucKlIQQABFAqNCSRcEsw8nbsvOoaUMOxIIrnT8JQCzsy+/+p
         h3TW0gPE9SsFHUHgQyxQQZsH7BsmvsgCq/0l+Gv620A/lCA8+G4k9k+E803duRpMI1MT
         X+gME9lVolkcRqfOOfx9SKUj3Uo00uZgu9Wzmn2xp0fTpOi6xENF5EesVyYjq+4niPbx
         zKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774539334; x=1775144134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HE1n6fNopOli1ZrfFGiFRLxGHswUymMuekCzV9grZto=;
        b=h/iBGmQSsjsHDAIV1VzFWep01ZPI2c7YI23lov6fbNrPoHWGEHg0m9wrWPFgZDAKLc
         3DK4CEf9EJNfTbnfoULivNfTyP2HykYq7L4ffgXBVQW67W6/DAFzOxiLB55r2dLDrOAq
         8sdLFGvVlZ2RhXTbs4ajlsZywfN7IlUD2v+PMqod69X3wbEYynay7458aFNNCGcE4m2t
         IhJL+Fu+MEcfHmhmIJ5+tppsNx7JNtdCoIUMeXW9fqMuIp7PsgwSbXcWEPVMxGFMW+eL
         PBGEPCharZiKqNzRA9aYfAY7q0aiVzPRLTpBTV8RGCP7ihZ5n0VRwo3w6ru+MgJKNNgd
         a23A==
X-Forwarded-Encrypted: i=1; AJvYcCXC8GqJ9TauHWfyo1pVbXYXreO5O0qufkjCG5K58z6jF8iI7xXYJEGpvxI/0+fzQDyXIhtF8EFoZLWjnUnzczA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+siohPngrGQgkqhKhbA3xRZ1YkCpHhXkKEJFC73FoIHTNl7gi
	W9b9H6/uyiMgv5Adxugw743SeC3WC6Nf27euM1iC94O69Dk414XCAwFMfSCdEbOujyrwhWdY0vk
	D2fIyn+LkyB5JyHW/HtFPBNKjxscxInc=
X-Gm-Gg: ATEYQzzjR99k7Och0VLtgdgi8p8RhZHv2pF1lQFoumYecdzpLzyknx+FjcORo0GhEnS
	uhvnIZsW7+gOXCXvTafTFvH9wIkHUE2Iq0o3c7ThH2lAFM3rx++SZZnAU39xIgiXbMHPqt3XqcL
	dYagoqUsF8rmtRjaDk5Zs3K8CJ/fNAaeDRswL/FvtUmIb1GfkpJ3fmv/7Nd+gWZDeHCS72Ktrg0
	XrnHYNCvHjbRZg6ZVZ+Ewz88afobd0xdcWhjK3rJax5yXgdfi6wNoq+dkbX3E++l10tNcsGQjYs
	5YyeLh+I
X-Received: by 2002:a05:690c:c0d3:b0:79a:b00d:c863 with SMTP id
 00721157ae682-79acf6a4d73mr70335267b3.47.1774539333923; Thu, 26 Mar 2026
 08:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326122842.13664-1-zzzccc427@gmail.com> <CABBYNZ+nWzf0te1BuyDNQXdV9PsJg88vHEmxW68FOiiFpz8QQg@mail.gmail.com>
In-Reply-To: <CABBYNZ+nWzf0te1BuyDNQXdV9PsJg88vHEmxW68FOiiFpz8QQg@mail.gmail.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Thu, 26 Mar 2026 23:35:21 +0800
X-Gm-Features: AQROBzA2F7-ea6M97fqfYhuHnSP3_9UiFnHZPNz4uvy8VOOgz-mHFtyXQQOUPE0
Message-ID: <CAFRLqsXPh-6DeS27Nqg2R1EJda_NxCxRPHg2q0VEDYCF1MLSYg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: SCO: fix race conditions in sco_sock_connect()
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Luiz,

> Ok, the first and the second points don't seem to agree. If each
> thread creates its own socket then the sk wouldn't be the same would
> it? Or is the first point about two concurrent connect syscalls to the
> same fd? In which case that should have been made clearer.
>

Thank you for pointing this out. You are right -- the original
description was not clear enough. This is indeed about two concurrent
connect() syscalls on the same socket fd.

I have rewritten the commit message with a detailed timing diagram
that reflects the actual scenario I confirmed with logging
instrumentation. The race requires three participants:

1. Thread A calls connect() and completes sco_connect() under
   hci_dev_lock, setting sk_state = BT_CONNECT.

2. Thread B also called connect() on the same fd and passed the
   sk_state check (without lock_sock), but is blocked on
   hci_dev_lock inside sco_connect().

3. While Thread B is blocked, Thread A's HCI connection
   disconnects. sco_conn_del() runs under hci_dev_lock,
   clears the socket (sk_state = BT_CLOSED, SOCK_ZAPPED),
   and releases hci_dev_lock.

4. Thread B unblocks, creates a new HCI connection and
   sco_conn, and successfully attaches it to the already-closed
   socket -- reviving a zombie socket from BT_CLOSED back to
   BT_CONNECT, leading to use-after-free on subsequent cleanup.

Best regards,
Cen
