Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4818D392836
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 19:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785009206; cv=none; b=Y1NiYwUf9uxQrUeCCnXEaqQbGZVja5Yf2AH6w88/nAHxnoMXhtT/VjNPGIVPOfk8DDUzwZvOeeMwk7Q8DGbO9nxmhZd2Wn50w1pm5hKSP1p6gTUMnFspWWs0YePM568VSemNIdKv+nrU2QmNFTz8d8GOnrZURV+mgWJwvf5KrGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785009206; c=relaxed/simple;
	bh=7ZN6T1/AH75YPS/XHcc9nUnZtBrIkvt1Zj9ameGBJLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqPvGw37v9D13nQ+azn+hUljIa3vjg9Y5hzIdnRSf6gWq8m9xm9h0/Mg4s+anJonAoLyQN7YRm2N5Zco8s/zxsvcvPzZaKHSKR1XAqmlW4zHUBM8YlUwKdMk9PnUq0vmY4yMckX+mwpFlWT0BTILJ4LIALVK/5fEHnkawc/uNfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFf92UED; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFf92UED"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-49fa951b2c6so836085b6e.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 12:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785009204; x=1785614004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xH26qF1R9t6qCKYPvNS6zoA9qXRJOpqJZW8w6fjc860=;
        b=gFf92UEDUnetF5SZGlJ9cm6w1UrlDK9xOcC2yaVi0IsoAPPb+G4LhcVteMchO8Ga5V
         bHV8mI/CPIzscRXbZOglutbahJj2weE3QDjSKgCHatGrovFr2FXD4qpqSZKvIERCDnVF
         wgrzCu+daybSTwOvI6D/K3ig0kCU8QAKgS+H37dnQFWrr5I52lvt1UcOH6IjZcxz5HkW
         YNHfXdirxJufXmvkOkOi/0MPQx+fOUULTIucbZ7moKT9l2qRhBr04A5DZi+TOOsVYXmi
         LTprsB03ONciDZaRa8ykOUXb9OYsLakYIGQglEOL7hN3oIRCaFCm29x1PZEUiiB/nzs/
         5ODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785009204; x=1785614004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xH26qF1R9t6qCKYPvNS6zoA9qXRJOpqJZW8w6fjc860=;
        b=mY3wgItn9omQO0+nUc9z4lBesV24tFZSeDrF9W+uwRgHa3VonNXmirqvLw42Ud1YEk
         nbGzf0qQeuXMwXz+1oxaQUFRVnM8ipHYg33Wzg6Va8Ax6N+KGFivXodmDNtL2gDKF0hZ
         Tlqq/iJF58ooJvDbUdRRoU6cfNSDbaQf33YyqgdOTcQxxhgtLHzlqVPtQVLcZtthnOvj
         C69+qgIeTbi/aoWshzF2SvzeGlQQ5b+oEvU8CNFOkRFEMqJsgpuUmMNwfrpmiUNkaDI9
         MheDllmOlkF9aLQA+KK2OF0JQhHdvtMoWcbYKF8gAs8+wZgM1R+iOgs6eZWoYq26cICx
         yQSw==
X-Forwarded-Encrypted: i=1; AHgh+RqGujWi+0WOwE4FagWZkf9IBj7hmvsOGpZZyZlyUQuf1xI7OG2dCCCvGWMcJbvdsYbu8Vkqx2n4eZBjaPCbCqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG2SODJ3IHxb7W1yjpu4NuCtXx5ih09ma0kA4u6dBhzgwrwy26
	nIKhiBUoGgp0dAM/O9H+htfQKm2Xkl8A11fAviRZUDGlFNSQDWDwIlLC
X-Gm-Gg: AR+sD12FnBDDbpFtpj5eabbkKYrkWcZ9BhEcxtQfi0oNCU5xRyDCKpzgkPCEGeqkIZ3
	fKDVEFEmf0jBD72uzt/vjw4QhwCX2Z8YcFl7WjnNMrcDnpfXf5SOdmWg6n97E7Z42ZkFzMQ1evc
	goqTRXyxl1JXdXRvs+64Bqr2++dmDZrWvOMzC6LFGdmqP+PtfZhwmSZ8b52Lz4CTe0lia9Yap2s
	Nz2Y3yNhf4XY3InaCGEx/KEFj8LVBrND7bBFdwzjL3G53kARZE/Dl1cEnzqB9P1EHgxtaCP9tmd
	KSmrtMnxMoPeSo9g9acGSVmKnMLOqZKIQ5cLsBZN2J83ESGmbaZOSkb4o/3dUABEd/WBFQJKLgb
	/LAGVQi5MxhUb0vC7N4iPHX4UcLqAVKSGBmZoWDNT6PtUNNx3O2pWuiUqp46ct+M63HtDq4avXc
	TGGTtLjaI=
X-Received: by 2002:a05:6808:1a29:b0:4a4:934:b316 with SMTP id 5614622812f47-4ab6a15c6acmr2921176b6e.21.1785009203969;
        Sat, 25 Jul 2026 12:53:23 -0700 (PDT)
Received: from beelink.. ([155.133.15.206])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45767488299sm11082928fac.16.2026.07.25.12.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 12:53:23 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Pauli Virtanen <pav@iki.fi>
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: SCO: give the socket its own sco_conn reference
Date: Sat, 25 Jul 2026 16:52:59 -0300
Message-ID: <20260725195310.970347-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c6e534e497ee771ca80e5f3c6223eaf305bca48c.camel@iki.fi>
References: <c6e534e497ee771ca80e5f3c6223eaf305bca48c.camel@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Pauli,

Thanks a lot for the detailed review and for sketching the hci_conn
ownership rule -- v3 incorporates it (you're on the patch as Suggested-by):
sco_conn_add() now consumes one hci_conn reference and the sco_conn owns it
for its whole lifetime, sco_connect() no longer drops hcon on its error
paths, sco_connect_cfm() takes a reference before sco_conn_add() (and drops
it again if the allocation fails), and the hci_conn_hold() in
sco_conn_ready() is gone. That removes the double hci_conn_drop() you
spotted on the error paths.

One correction to v2: I had also dropped the

	if (conn->sk)
		sco_pi(conn->sk)->conn = NULL;

clearing in sco_conn_free() as "unreachable". v3 keeps it. Testing the
close()-vs-Disconnection-Complete race under KASAN showed that removing it
reintroduces a use-after-free on the sco_sock_release() path, so it stays.

While validating this I built a /dev/vhci reproducer that races close() of
an SCO socket against an injected Disconnection Complete over many
iterations, on v7.2-rc4 with KASAN. It reproduces the sco_conn_del()
over-put reliably on an unmodified tree (a few thousand iterations), and
with this patch that over-put no longer fires.

I want to be upfront that it does not leave the reproducer fully clean,
though. With the over-put fixed, the same race still occasionally trips a
separate use-after-free in the SCODATA receive path, which this patch does
not touch:

    BUG: KASAN: slab-use-after-free in sco_conn_hold_unless_zero+0xbe/0x160
    Write of size 4 by task kworker/u17:0
    Workqueue: hci0 hci_rx_work
    Call Trace:
     sco_conn_hold_unless_zero+0xbe/0x160
     sco_recv_scodata+0x13f/0x490
     hci_rx_work+0x3af/0x730

sco_recv_scodata() takes conn from hcon->sco_data and calls
sco_conn_hold_unless_zero() on it, but kref_get_unless_zero() only guards
against a zero refcount, not against the sco_conn already having been
freed and its memory reclaimed -- the read of the refcount itself is the
UAF. It looks like a pre-existing race around the hcon->sco_data weak
pointer rather than something introduced here, but I haven't yet isolated
it on an otherwise-unmodified tree, so I didn't want to fold a fix into
this patch blind.

Happy to dig into that one next (it feels like the sco_conn lifetime wants
a firmer owner for hcon->sco_data), either as a follow-up or however you'd
prefer to see it handled. Let me know if you'd rather I respin this
together with that.

Thanks,
Aldo
