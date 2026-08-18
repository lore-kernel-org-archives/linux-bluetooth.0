Received: from sender-of-o53.zoho.eu (sender-of-o53.zoho.eu [136.143.169.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB35036DA18
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 19:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787081449; cv=pass; b=jM4/yG1YK648BNvQ4hraRU+uWu+6GtwncS5vdyVrODQF/oR+zarX1KeNuhrf9stqBQ2h3brU9gO0mZBpSPxSiBtdrHeL6gRYPp/6YUTrMBQ03z/la/IYh36NJZsNNpnFc0UAxNeOcpPaOAUHzQiT1ywJTPACcwUiTMyNKQptSY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787081449; c=relaxed/simple;
	bh=jpabdVL+Omrrni+BzkJoPavGInAh1Ooqfcejgbt90jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nfw9KLqfp15G42BQESE5+h609s6apaf+nQAncwbVbhNblXV3qre6yDw/XEFn5iEm7h2Mq8tpO/uIEHPzqorECXwR39tAh2jIWT/i3eEoKJ3C5zAyR8cgNNHrFDc7VFgvYTsyrCnAR4eAiXrceJw1DnNY+VjxkhlDjV++bFBcXOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=GYGj0t4N; arc=pass smtp.client-ip=136.143.169.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="GYGj0t4N"
ARC-Seal: i=1; a=rsa-sha256; t=1787081429; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=A4MHA2FPr9G/RhwYx/BPPGEjlDtnBae0EOoe5b3SQD5d4vC9jt9671DDBvL5DtU6Se00i7B8su/hdeHvj49eP6wDagCbvBiRfgOs8ekAPb0H7OS23tpcApmzUkXX6EwLfmZIwB06LaibTBbHDkakEWSiIxeHfG5kqxeHm7H3wgU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1787081429; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jpabdVL+Omrrni+BzkJoPavGInAh1Ooqfcejgbt90jk=; 
	b=QGMX1nkBrtgbpeXXLAgA/ZVVkrEiN+2yM4ZwSoOnqOpkIXn8DO2sg1OF1+pkBYWSMNqIXBFOJq0P1BqW45oXSANSAgjA7yJXlcc/VIJFurMVIrQEvx/RP3XApS8OL50LAXALY3hrETCIgrARgyqVSXVsRm5cFSfQkW0Zt55HmZ0=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787081429;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=jpabdVL+Omrrni+BzkJoPavGInAh1Ooqfcejgbt90jk=;
	b=GYGj0t4NBvvuw8GYusobfO3JvGpSmPYhdMKq/cSin6WskimWwd68aPf2/3nhz70M
	VYPrckYzUEzNfkRWJQPXzF6amyEh8tqofm4jdGo3wPqj17/RICfZiunI+p1K+/VgwUD
	uSWWK/PsLoflJUm73TCGs8XMXgKp/TqNs/wyZVhg=
Received: by mx.zoho.eu with SMTPS id 1787081426042449.0040655407855;
	Tue, 18 Aug 2026 21:30:26 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: neeraj.sanjaykale@nxp.com,
	amitkumar.karwar@nxp.com,
	marcel@holtmann.org,
	alex.zhou@nxp.com,
	song.xue_1@nxp.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btnxpuart: Keep FW dump header in coredump chunks
Date: Tue, 18 Aug 2026 19:30:05 +0000
Message-ID: <20260818193014.609252-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CABBYNZLUUBbK47giBBG7KH=9vU7V_wuAcSYB-oTyr0k+7iYw=Q@mail.gmail.com>
References: <AS4PR04MB969206113CDC2F5C66994E6EE7A62@AS4PR04MB9692.eurprd04.prod.outlook.com> <20260818080104.563675-1-ali@iusegentoo.com> <CABBYNZ+yDwFJ7YFB60-SG6Tr1R+6BeE1E=06d5+UEK_y4j7g+Q@mail.gmail.com> <20260818162501.584425-1-ali@iusegentoo.com> <CABBYNZLUUBbK47giBBG7KH=9vU7V_wuAcSYB-oTyr0k+7iYw=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Luiz,

On Tue, Aug 18, 2026 at 12:59 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Yeah, and it concatenates the header states into a dump skb,
> interleaving data with headers. The worst part is that if the analyzer
> finds an issue with the header it can consider the entire trace
> malformed. This means both the kernel and userspace try to parse the
> same thing but may interpret what each chunk means differently.

The kernel uses these two fields only for framing. It does not interpret
them as part of the dump format or validate their contents. It also does
not compare buf_len with the actual payload length.

This cannot be moved to userspace because the driver has no other way to
know where a dump starts and ends. Without seq_num and buf_len, it
cannot know when to call hci_devcd_init() and hci_devcd_complete().

I agree there is some overlap here, and I think this is also why a short
chunk should not be dropped silently.

> Well, it does change, it doesn't append anything if the chunk is less
> than a header and that won't even show up for the analyzer to analyze.

You're right. That statement was too broad. A chunk shorter than the
header is dropped, so the analyzer never sees it.

> Now, regarding this, I wonder if the driver receives a chunk smaller
> than the header size, whether we should either append it and leave
> interpretation to userspace, or 2 drop the entire dump because we
> can't guarantee its consistency if we suspect data corruption when the
> firmware is not supposed to generate chunks smaller than the header
> size.

I would go with the second option.

Appending it does not really leave the interpretation to userspace. Each
header tells the analyzer how many bytes belong to that chunk. If we add
a fragment without a header, all following headers are shifted and the
rest of the dump becomes difficult to parse.

Aborting seems like a better fit. The firmware should not generate a
chunk smaller than the header, so seeing one means something has already
gone wrong. We can no longer rely on the rest of the dump being
consistent.

hci_devcd_abort() keeps the data collected so far and marks the dump
with HCI_DEVCOREDUMP_ABORT in the State line. Userspace can then see
that the dump is truncated. hci_qca and hci_vhci already use it on
their error paths.

> Yeah, the decision of considering a chunk valid or not seems to be
> split between kernel and userspace. The kernel evaluates if the chunk
> is too short but won't check any data consistency after that;
> userspace will evaluate the headers but won't get a chance to evaluate
> if any small chunk was dropped in the process.

I think aborting closes that gap. The kernel decides that a chunk too
short to contain a header is invalid, and userspace can see that the
dump was aborted instead of silently missing bytes.

Would you prefer this as a separate patch on top? This patch only
restores the header in the appended chunk, so its Fixes tag can stay
focused on that regression. Handling short chunks with an abort would
be a separate behavior change.

Thanks,
Ali
