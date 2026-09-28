Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DAC45D1B1
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 21:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790630071; cv=none; b=tdB1HtZYaohlQzUqTK0yhqw/DFQ6lAvho5/9Xh4fIdQJ59nrZe6JAzWVsnGzD0GuTlPHm2mYgDiUjOuKoY8l3S8b+h0v+/1fnKAqzZnJeycuiyIv7SkCgKMVgzeaOjCFXVF5+6d49MyWBJ7Cjov2t74L9AxX3pIrO9/pZAFECFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790630071; c=relaxed/simple;
	bh=aCF8Tme2CgtzoXmWHTlE5OX7b96PnET6TbNRNjwcp/M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ml2E1FbGV4OvfAEjqLJOuGe4eUKECJob2uXsdU6cHsdraSzr970EkgGw7o1KW2vhuUX0xOubh3Et+RlzY3PtOxWwLsMB1QjP6L3DqTxh6xYLVwX2ZePAFeP2GNZipUB8+HtU5fpTcpnpnHmK5UdFMd//AMlww9hE9J4qNGgrl0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=SWLiRbSe; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="SWLiRbSe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1790630067; x=1790889267;
	bh=9E6G+DXzASNqgJtgUo1mOrZfjexrcjMhX9iNGOYdpaY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=SWLiRbSebasfOBJIUaFhOCQFjyu1yugNIdTd1xXJXSq49uSWDI0dlRXuFHs/QeztL
	 asRihp2DciUXJKeR44mdK+58eGOwTWB+T3bKva7pBrkZNpQY+RZ5CwSOPx5jMigJT0
	 V+6LxjWLw2RdRle7mN1CtzGjhNJiKVUunJK3LtthCXksu3Z33GxK1gQQjcLW7tD+z8
	 mYVxV7LnA/ae1a4XFJXBQeabdhQRJJnmf59O+GOWPHoLdrXfx6FeLSHF6gIrrVL/pi
	 xLS2sr+4PqautlP83F/kj15bD/uF04xfSRsGXy42m1CY0+UMFNsguX3SgnCjZUR3uj
	 DbaKQJrfVL32g==
Date: Mon, 28 Sep 2026 21:14:22 +0000
To: Ravindra <ravindra@intel.com>, linux-bluetooth@vger.kernel.org
From: Sergey Lebedev <lsa.uz@pm.me>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Kiran K <kiran.k@intel.com>, Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>, "Vladimir V. Kondratyev" <vladimirkondratyev2@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/4] Bluetooth: btintel_pcie: fix D-state transitions and PM flows
Message-ID: <20260928211413.26759-1-lsa.uz@pm.me>
In-Reply-To: <20260928171003.2925480-1-ravindra@intel.com>
References: <20260928171003.2925480-1-ravindra@intel.com>
Feedback-ID: 113843758:user:proton
X-Pm-Message-ID: a393ba71ed2e00f6f26f94f4a7033989b22f9f14
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ravindra,

Thank you for taking the race on and fixing it in 3/4.

I ran v6 on the Surface Pro 11 bench (BE201 8086:a876, s2idle, the same
base as for v4), with an instrumented copy that forces each path:

- plain cycles: the handler records D3 and re-arms RX, as before
- a gp0 dropped on the way down: one 200 ms timeout, the register read
  again, D3 recorded
- the handler's D0 or D3 case forced to break: the fallback records D3,
  or claims D0 and re-arms RX
- the race: the handler held in case D3 for 300 ms after deciding to
  claim D0, past the 200 ms wait. With v5 the fallback re-armed RX at
  203 ms and the handler again at 300 ms. With v6 the fallback waited on
  irq_lock, found D0 claimed and returned, and RX was re-armed once.

After every cycle Bluetooth answered an HCI command and scanned.

Tested-by: Sergey Lebedev <lsa.uz@pm.me>

Sergey

