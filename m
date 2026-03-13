Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED682DA755
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773403333; cv=none; b=QnbIxwrewxJLjx/VCOiPKruCqU7GsA8fvVsrexgwHJk8nZP4w/Vr9rt29Hpwy1eHOMqavRgQmqjlp6Cv6XqDG4PP6bbpRqsQqbDsFsJ2eu7lIMDjGdTZej24Mn3gkGuEJaY40o+guYa6YF3g8AjNJrmiFOhK0mCx/Ko1hlmvVuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773403333; c=relaxed/simple;
	bh=aDC3Usxs7zxLRzmTsJrKrI9VqfDkhg5LJkjW4l9NMd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=PV7S49uEcXHC7iwApVqiMSLBhiXPU69Urv1RPZCcn60+4YejrSU40KUI3rYtpI9oySb/5R4jirgxITvNJ5lDph1b2smu8K6ssnh1CP/yOd9MKN8dulCfBohsJAu1UhVS+iHtInWxbdPmF/KBPC9CgkWAoBjTXKHr97wVZ/3hvS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=TaWPu62/; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TaWPu62/"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260313120201epoutp03f9b56f8995de88e0ee155008a0418353~cZOzdcyBB1042910429epoutp03f
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 12:02:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260313120201epoutp03f9b56f8995de88e0ee155008a0418353~cZOzdcyBB1042910429epoutp03f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1773403321;
	bh=JtR/tPeSjnEA5n1/nVAdVMKstWMFoX0nTClR5rknjbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TaWPu62/htJ3XdAKer59Hhz4spyu0bAggfW1LcNnfTeFnJ0uw80JpNszPnXQmkgTv
	 axsGFxKDg2CI57rIocQHlNklxyssTvS6HLjTDridkltlx0V7tJkPp79W0NKRPxnNEm
	 +pvEnjXCrKx4Yhh8W5/dEi3P+z4QKrBMmCeHdrvA=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260313120201epcas5p4c5ed216958483e3a0b69aa46e9f75c82~cZOzKiW651634516345epcas5p4B;
	Fri, 13 Mar 2026 12:02:01 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4fXNQ12vJLz2SSKY; Fri, 13 Mar
	2026 12:02:01 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260313120201epcas5p3e57284d5bb295b1f9040478d96fa95b9~cZOy-NYdi1116711167epcas5p3X;
	Fri, 13 Mar 2026 12:02:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [109.144.5.214]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260313120200epsmtip1a98a36650dea4a213fd1391d2f30717d~cZOyf1Zf32933729337epsmtip1M;
	Fri, 13 Mar 2026 12:02:00 +0000 (GMT)
From: Tailu Shi <tailu.shi@samsung.com>
To: Pauli Virtanen <pav@iki.fi>
Cc: Tailu Shi <tailu.shi@samsung.com>, Marcel Holtmann
	<marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Paul
	Menzel <pmenzel@molgen.mpg.de>, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: ISO: add timestamp for outgoing HCI ISO
 packet
Date: Fri, 13 Mar 2026 20:01:54 +0800
Message-Id: <20260313120154.1254129-1-tailu.shi@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <6b523ff37391a685be2fc08ee88e1fbde3a2142b.camel@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260313120201epcas5p3e57284d5bb295b1f9040478d96fa95b9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20260313120201epcas5p3e57284d5bb295b1f9040478d96fa95b9
References: <CGME20260313120201epcas5p3e57284d5bb295b1f9040478d96fa95b9@epcas5p3.samsung.com>

Hi Pauli,

Thanks for the detailed review and for sharing your RFC patches.

On Wed, 11 Mar 2026 18:24:23 +0200 Pauli Virtanen wrote:
> These timestamps are in controller clock domain, so generic host like
> Linux appears to need to perform clock synchronization via
> HCI_OP_LE_READ_ISO_TX_SYNC to be able to provide timestamps.

I agree that, according to Core v6.2 Vol 6 Part G Section 3, the timestamp
must be derived from the Controller's clock. However, Section 3.3 also defines
a falllback where the controller decides the CIS/BIS event when the
host‑supplied timestamp is not based on the Controller's clock. It looks
contradictory.

Section 3.3 further states that the host may retrieve the timestamp via
HCI_LE_Read_ISO_TX_Sync command. The wording makes it optional. And also
as you have noted, many controller returns 0 for it, leaving the practical
challenges to make it work properly.

That's why we considered leaving it to the userspace application.

> I had in the works a not fully finished patch series adding the same
> thing + LE Read ISO TX Sync + tests. I sent these now to the list in
> their current state, maybe they are useful if you are working on this
>
> https://lore.kernel.org/linux-bluetooth/cover.1773245666.git.pav@iki.fi/T/
> 
> https://lore.kernel.org/linux-bluetooth/cover.1773245672.git.pav@iki.fi/T/
> 
> The tests pass, but not really tested to satisfaction on real
> controllers.
> 
> From what I saw, it seems several controllers like Intel AX210 and some
> Realtek ones don't implement LE Read ISO TX Sync correctly (returns 0
> timestamp), so in those cases it AFAICS it's not possible to provide
> host timestamps.
> 
> Getting the clock sync via LE Read ISO TX Sync to work properly across
> controllers is maybe not so easy, as it appears the Core Specification
> is somewhat unclear how it should work.

I have reviewed the series you posted and I think it both complete and
elegant. Since my earlier work is now covered by your commit (08692f3...),
I will withdraw my patch.

I've cherry-picked your series and kept the PipeWire logic that passes the
timestamp via BT_SCM_PKT_ISO_TIMESTAMP CMSG. The implementation works on my
platform (based on the Kernel 7.0.0-rc1, BlueZ 5.85 and PipeWire 1.5.84).
The timestamp can be observed in the btmon trace.

Partial HCI parsed by Wireshark:
 Frame 32436: 72 bytes on wire (576 bits), 72 bytes captured (576 bits)
 Bluetooth
 Bluetooth Linux Monitor Transport
 Bluetooth HCI ISO Packet
     .... 1010 0000 0101 = Connection Handle: 0xa05
     ..10 .... .... .... = PB Flag: Complete SDU (0x2)
     .1.. .... .... .... = Timestamp present: True
     0... .... .... .... = Reserved: 0x0
     ..00 0000 0100 0100 = Data Length: 68
     Data
     [Connect in frame: 9436]
 Bluetooth ISO Data
     Timestamp: 469412333us
     Sequence Number: 3595
     .... 0000 0011 1100 = SDU Length: 60
     SDU

Please feel free to add the following Tested-by line if it helps:
Tested-by: Tailu Shi <tailu.shi@samsung.com>

May I know if you have any plan to merge this series? And also please feel
free to let me know if there's anything I can help to move this forward.

> This sends timestamps in host clock domain and has no clock sync, but I
> guess this is just for testing.

I think it's better to have a complete implementation solution. So if possible,
I would like to improve it and push it forward. Please feel free to let me
know if you have any other opinions.

> I think these are not needed, they can be passed as arguments to
> iso_send_frame().
> 
> Adding them to iso_pinfo() probably causes a data race if two processes
> sendmsg() at the same time.

Thank you for identifying this potential data race issue. It was not considered
in the current patch, and I will incorporate your suggestion in future development.

> I would put this in a separate function.

Agreed. It will make code clear. I will keep this code style in future development.


Thank you again for the detailed review!

Best regards!

Tailu
