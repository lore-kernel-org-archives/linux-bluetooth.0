Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795264135;
	b=ZUi7Qbhla047J59nCZe7jmWnw/ddmqW4dMzUy2rlkp9fKH7XT+d9GQuiYPQIo4ibZ42H
	 J+17dO58wBJA0aOZtkVlntye+ACLp0HMzayraVAaNYWXw13CEOt2M41CBfwMpIwsb73LU
	 uzpTz9Xx9ZVFtbYpaxvuFZkpNJrn2yRaeMi1tXTg6M0SIXibYNSvpf0UyH/XFOoShNbbn
	 xlEjk09UjPK1HRKpAIMGXUCYq4L57Lac8NoTbtNxwtoQYRF3kqqCxvbB+8K4jWaLno55/
	 02m7l1gkqoOruzI/kfiQSQIs0Qwl6F/Pa+jSefV3CxdJgAmYHum9iqMNAG6rUPNHFkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795264135;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xbPlJS6qwfZzqUa056hpUcKGkd9cFIzccwWJm9phGjg=;
	b=iDjb9JRvqx0HzQRzljeRSv+TXZ0LH7Y3+G76HFpC+mofjf/UTan64oeAYqOFjzBhMCpz
	 mh4J+YBwOB9WR+dRcmuqeFjGvzpwRS2c1+zFGockNIKXmFzyySFQ2Qollo0rClv+JLHby
	 fgBBMD6B3r6R/+RcG80EjnakVVWRYCyMSKNnaMWhkPgLHaDbjuTfnIcs0MmVv+DFS3CVu
	 fN7p0LQqr0GzLIuroRvUSQnbxXxtyZhUYzeXW0IRObFfF5fy5urCPgjFOwKRqvwMu+Yb3
	 m0RXCCNP/Fif4FIRD6aVJU16SH13KJp3EbMhiEv1Cohue9s2Nfb5gMa61mAfYgNqT0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lMREvsw4;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66326606A320
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 12:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66326606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lMREvsw4
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b3acec6677so2595635c88.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 04:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795264134; x=1795868934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xbPlJS6qwfZzqUa056hpUcKGkd9cFIzccwWJm9phGjg=;
        b=lMREvsw4M7lZ1kgv7GSe+X02UOR03A0nw8vk5xpJ70qd+sSzBPAO7WLS8naehULzrp
         1lbPwzCUrkA8Z7YABjVOQB+IBmHYwYEx73k7HH7Vc0yq2LfOGblwkuMYPjeq5CBXnDBB
         wf8vhrmv7TSYOnKDYkQ5zA7oQoXvWB8zmOSU8NcBPn6lP9Y8uxdgI9AnnurZRI4qoB8Z
         ARb+dloSVJy2rlBGUOvwEerwofgpnpZdmViT+kHwvmh555zKf9fnkDgVD1TpwzVE0mlA
         GcuWTh3Vd8ojcIGNbNZ5lnoPhJx7aGq8EwXZ0DBUCH4XfzE5GujW+dnJscd/ZCCYqtoR
         w/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795264134; x=1795868934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xbPlJS6qwfZzqUa056hpUcKGkd9cFIzccwWJm9phGjg=;
        b=hM3faYvqbqAY6PJ0rWovf8zwE/52MoyUZR9Umt05Jg4LE/seXkLGOQpN13GELoU+fo
         NU4qZHivpoul657W8II6q91CkJvhDkcMDszA0EFPgqsxmvsA+moF/bQmMdHrZM0q6eQR
         CoKhT0cjWj//l1vT16uSlQWUBfZ06yKxIEE1fVsZUyc+hJZPrZX5/Hlq8/Pf9nf+ubvP
         ORWzZ6JhhBwfWxaYCHzJ3+tpBovcmtaN5MAcxLk6L1B8mBd2PuaqlHHkuYy1vblV6v7y
         H3RjSWvmKHGbD11emanXFLtXfAfJTaKeidUMvCw8DHOAWhIr4ZIv60TLXm4iVyJBN//x
         VHpA==
X-Forwarded-Encrypted: i=1; AL+hErHFl6xuCUlcBxjB/uluUoffHESWWKfa1cyYiZ5j8VdFK0b4u/sz7Z9XGbpZA5XJjrhjtOKenc75D4geVmGsFek=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ObA/y4882AbVtx0fnKnJTg+Wta7hWEk5oR81yEBT2eMlYZ8vP
	flZ5QNexL2TXfpjREp/XWpE3iZuzsFRLg1TJC92wjfv+ubiYrOWS6ZAb
X-Gm-Gg: AZFdTZdnvf2Wc5tiKPXXQpuArOJpYdHdko0pTcfso01A8L+bvOMkkG9aOp99ZsNWfAr
	o3RCYmoVeic4qzSvJiFKMUefMr2mt2IUrHj9gkMu+bigglermlpJbA16PSe7lpQWsDyDBUiYj8Y
	IjNgRJhxETzIivbLBODhznGe7kBp0VnoY1LbZMlFi4jM9XmzhYVkkzOyP5izPs2zEhtnHmYUExm
	ZzbpOIICxJdCNyWP8cX2o5QIEi+OT6sMFFYeGZHNGP64RuiWBZ9Q0VV57VIz5G//Cf9lEYAA3xD
	EtkSea+OuOJuIajMPLW5NYWLmB/jQNgi7z1rPqSJ6ZPevyb9GIm7pR81S81nWrEJG3m5SAeY2kb
	bu1+kJ5Z24UJ2j9LBTE646Tk+Ae1h2mEjpL7e4vVbU8yVcEbShU6hCYT133An/of9AeuvGxEzla
	BNXqzpRvWpeIV9/CXW6Fsl7qm5ttCJ8w4fDBhDbPuxh2asX8LTumo9QVvew5d5U6WXIBsXa3xsi
	ypwkUjJgbgN+B7MIAZ3R7BMhJqa7ePr8jPjBKWeaFHxSOl1EA5Nv84k0WAdU06vRilvZ7GB+w43
	mHS1/xl3BMcM/mbewil+0QBxpQ1KFdDmpJgK5n9mEq6gQPyZvw==
X-Received: by 2002:a05:701a:cc98:20b0:1a7:99b9:2eb9 with SMTP id a92af1059eb24-1b5568fbd8dmr5539812c88.27.1795264134374;
        Sat, 21 Nov 2026 04:28:54 -0800 (PST)
Received: from G7XWH7K1F3 ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b562a82b3fsm9671917c88.5.2026.11.21.04.28.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Nov 2026 04:28:54 -0800 (PST)
From: Zhao Li <enderaoelyther@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael McAllister <me@michaelmcallister.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: hci_serdev: stop write_work before closing the port
Date: Sat, 21 Nov 2026 20:28:32 +0800
Message-ID: <20261121122833.7545-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <CAFEp6-37+O4BoSL414Njogr-34G7se-8Nu+O7B0zjBY1Jw7UWg@mail.gmail.com>
References: <20261120062048.40310-1-enderaoelyther@gmail.com> <CAFEp6-37+O4BoSL414Njogr-34G7se-8Nu+O7B0zjBY1Jw7UWg@mail.gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Nov 20, 2026 at 02:39:41PM +0100, Loic Poulain wrote:
> > +               cancel_work_sync(&hu->write_work);
> > +               clear_bit(HCI_UART_SENDING, &hu->tx_state);
> > +               clear_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);
>
> Looks like you are mostly re-doing what has already been done in
> hci_uart_flush()...
> Wouldn't it be simpler to have a hci_uart_flush parameter to not
> reschedule tx on flush?

Good point. The only reason hci_uart_close() has to stop TX a second
time is that hci_uart_flush() unconditionally re-enables write_work at
the end.

Skipping just the final wakeup replay wouldn't be enough, though. Once
hci_uart_flush() re-enables write_work and clears HCI_UART_SENDING, a
serdev write_wakeup callback can still queue write_work before
serdev_device_close() runs.

Instead, we can split out a __hci_uart_flush(hdev, bool resume_tx)
helper (since hci_uart_flush() itself is the hdev->flush callback):

- Normal flushes pass resume_tx = true and behave as today.
- With HCI_QUIRK_NON_PERSISTENT_SETUP, hci_uart_close() passes
  resume_tx = false, leaving write_work disabled and HCI_UART_SENDING
  set across the close.
- After clearing HCI_UART_PROTO_READY under hu->proto_lock (to drain
  in-flight wakeups) and calling serdev_device_close(), hci_uart_close()
  clears HCI_UART_TX_WAKEUP, re-enables write_work, and clears
  HCI_UART_SENDING for the next open.

That drops the duplicate cancel_work_sync() and tx_skb cleanup while
keeping write_work completely disabled until the port is closed.

I'll send a v3 along these lines.

Thanks,
Zhao
