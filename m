Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC4226F288
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 19:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787083149; cv=pass; b=FQeKPzs0nus8uKkUR6fjMG2citMIOuZlM+r1x+RWfP/H/TuhCOEJyx8Ynmr9Eysl4516TSNh61omoSzfVKCcghnuXAJ8WqLH+sWn9p0ZDF/ksMlYeeVzla8BULBjJdXQ2ZdjE3x5XpHs7GK1HMxE1Q2rde54JJXa1GrLnXvmamk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787083149; c=relaxed/simple;
	bh=7fpxq/YmhOe2eGxSYnT396hSlOD/zVU/kumkx6JQ3Ms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PX0rpvVa8V4rdRTJjWF8ajxUNwiV+1tpER4wxLvmh9SoZ4RyDwGt61LJd6TJhPKyBO/+Jeqbi9xNYhIB+KCgBOnr3k9KelewZgmsrBtbyUiM9NTEPYlD6YeE5fZbmuCB+46+UxyZpmlljeIq3vNPYR0HW4zFwKcBK2i6UuS+1fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSbeaSe4; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSbeaSe4"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-836ce6cbe1eso5040287b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 12:59:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787083147; cv=none;
        d=google.com; s=arc-20260327;
        b=ThKfn+uFBA4OxEFyT4Q7JBQPT+2jZ9PAEnAmWmjrgM4rd0lNoGgMw24fGWcGyhsGMe
         4Q5nN6kYpOMcnGLfqD5m+LHBmacGieJfLRZoaSnSWVkPFtrYhh3Jpf2HI2nwqta47rJ9
         XZADmHoJzwH667yKBiY02EKoHBMpn6hAxgKEPClQ7eSl9f8JWnzwksLsvfunpsB12uzf
         LGESfklxFIpYRDU74puUHm2HlLFC2G9HZYKWuZTcKLVbyHhhGSVaZWtL8NNVRxHU+7gr
         +B4MjMV8segqO2d9kDjPxaRFKRpoleksrrovMrA8TXURwk1UZTH2rtILtHS14NiPrQaY
         yefw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7fpxq/YmhOe2eGxSYnT396hSlOD/zVU/kumkx6JQ3Ms=;
        fh=GgLxnIBQCIbtNRRWCXnRlPWDTrxTi+8mk4Oya+IZCBk=;
        b=LJvZjKmb6NrTpN0JglnuFJFl8bcXik8DLwFtACKXFwIT/c4GKx08WUAkhj3KNGhV24
         zH2snklQ/ENWhaf4vMhL+wyZ7lX6pmidU/7tdMmex8ypM4SzaU8GfLAn/pEeDzM9tJTU
         umvrRXEuhrL0lFHc77o7lGHe24LKDA39G+nKxc8UGFUJ+O4AVIrRBhHW840DOpAlsJ5K
         oq/w3qkhvmQG4vxotqP75OjqUB6MseiRWwPWoRUhuTtv16XP73Ppmq5nkkhH0APtcciz
         eyZY/K9ZPjfq3s3YSYFzxcB/aWbpES9GZr0R64dTyl5mOKvrb5wCnVdDmZ7I9MJAVenY
         XYQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787083147; x=1787687947; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7fpxq/YmhOe2eGxSYnT396hSlOD/zVU/kumkx6JQ3Ms=;
        b=VSbeaSe4XBSSs3B7/aJZ35hIpH6Nfz0Mf2G8UdLhDgwyzcVXEvGAy0P49nNNHBPIjG
         y8YYYmpKJB7xnNCG94xIaND6p+HBii52CztyWaf2Wq6IM8EsqLXZcZKvtP4WvOd9XSUT
         Gjo9cCjEBuOBdHzkF+p322CNs8+AtVfdqKpDcu3/DJnE0NDVgxoXZlbVS4lOicoDRFx9
         nzFN8tMiKVF+0bSCEMr3kgjugRAyNQPoW/pGq1fzb0GLi4HHmzBK9E/QGV2KoCPGRKgg
         f+RsWsEqYIEoNf1CQ9z9QoLWkQYdwv9O2OCNBmqeM7fJlrQ7ISmweigbJP74v1hUkuD5
         i1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787083147; x=1787687947;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7fpxq/YmhOe2eGxSYnT396hSlOD/zVU/kumkx6JQ3Ms=;
        b=ZZ1YtvCKZiCwE/cYyxWehzEya7iqczSt0Ak+FdX0xZoXNilRvFi3bokCo8qigEga37
         Z/X7mVw0Dxd/KWNfQhxndTg/P4QBGDVcDYpwL3YN+jQRfKh9TAnzJ5+3Jh5gCaRsAip7
         52QiBvxrAz79nUZX5LFILb0PZUkybjFbPRsBZhfSlxgUQhB8HDj5LxfBMh9HcMklkEcu
         mEJUqmVsTkWwoRkOZfPHhsq8IbaC3SOXC+dx7Ij/UOnrFrYl8nGsjwwQNP2gQJjphDmz
         1E0Xaf4w4WvDj+QVywmZ999yJDacsMw9J3Rq868VcxWoBUSym1gRivwtHWHddt1awT5F
         /5XQ==
X-Forwarded-Encrypted: i=1; AHgh+RozQ86sGXnT+niRE4k/jRLs0QL6DanOHqJqyTizdAJpiKQwph25hLnj8Z+IOSRJcxo9lzqKBdZAjexQ/vjvoCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaATmo/18MtsDkZ2hPwUdTdUUZA91xVeBYqUuSOs3IXd/ij/6e
	KkmYItZ/PGUXHYePHDNlJ55w6X56MTXv4VW6SUF+VPeF5Qob/CXJ/BK+3+79/JvWcHAZFIJrIHv
	AQfZHMci31RFHqRF6Oa2xjZ928/ZSG/s=
X-Gm-Gg: AR+sD13rAPqFsBYIMc7IPsN+kmiCQ7jTbAX9sritUvyYYRBeQil4PDd45Cqg4IWWTtj
	c2OSVBJMutf+N3c9Q5sHH4ACwwGvUSC4EppvpTyAZzQGPeKXvXcBw13LXwmJqYFLiHxTSOkVYKR
	rn5TlqUysmxtAnVwIGARKJy3khV2pWPcYTNaWb8bEq96CchQ0Vauy8fsUvdaAEwnGB0nHl77XHi
	AcMRS1ZMR++SK9n7Ioy0I9WsrOKwLfdPnxvPeFzo4QfadGfXtDMDbNPp/d7ZjjdsLKWW6qwxQ65
	hy7TbjIpxfwvrcEDQ55SsfcTxMzz/5b9+DpzgOp7uhAsRFHC61LAJ3T2cFtA20g6P81t6DPDFJs
	v2ySUAATlvBnsXsh8BiITMBInVNt1HRsx
X-Received: by 2002:a05:690c:b81:b0:806:b6ab:a410 with SMTP id
 00721157ae682-844c8bbbcfbmr647347b3.0.1787083146904; Tue, 18 Aug 2026
 12:59:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AS4PR04MB969206113CDC2F5C66994E6EE7A62@AS4PR04MB9692.eurprd04.prod.outlook.com>
 <20260818080104.563675-1-ali@iusegentoo.com> <CABBYNZ+yDwFJ7YFB60-SG6Tr1R+6BeE1E=06d5+UEK_y4j7g+Q@mail.gmail.com>
 <20260818162501.584425-1-ali@iusegentoo.com> <CABBYNZLUUBbK47giBBG7KH=9vU7V_wuAcSYB-oTyr0k+7iYw=Q@mail.gmail.com>
 <20260818193014.609252-1-ali@iusegentoo.com>
In-Reply-To: <20260818193014.609252-1-ali@iusegentoo.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 18 Aug 2026 15:58:55 -0400
X-Gm-Features: AcwNN1XzpZGQd3HLTY6RuSFv6icNKIbGcfG4hxlelmrYPTmTfsNwqfVPHoELqMs
Message-ID: <CABBYNZKYafGnNxr-pxfOAc2Op1Za7mo0h-H7Z0rxRCHT_9GyjQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btnxpuart: Keep FW dump header in coredump chunks
To: Ali Ahmet Memis <ali@iusegentoo.com>
Cc: neeraj.sanjaykale@nxp.com, amitkumar.karwar@nxp.com, marcel@holtmann.org, 
	alex.zhou@nxp.com, song.xue_1@nxp.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ali,

On Tue, Aug 18, 2026 at 3:30=E2=80=AFPM Ali Ahmet Memis <ali@iusegentoo.com=
> wrote:
>
> Hi Luiz,
>
> On Tue, Aug 18, 2026 at 12:59 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Yeah, and it concatenates the header states into a dump skb,
> > interleaving data with headers. The worst part is that if the analyzer
> > finds an issue with the header it can consider the entire trace
> > malformed. This means both the kernel and userspace try to parse the
> > same thing but may interpret what each chunk means differently.
>
> The kernel uses these two fields only for framing. It does not interpret
> them as part of the dump format or validate their contents. It also does
> not compare buf_len with the actual payload length.
>
> This cannot be moved to userspace because the driver has no other way to
> know where a dump starts and ends. Without seq_num and buf_len, it
> cannot know when to call hci_devcd_init() and hci_devcd_complete().
>
> I agree there is some overlap here, and I think this is also why a short
> chunk should not be dropped silently.
>
> > Well, it does change, it doesn't append anything if the chunk is less
> > than a header and that won't even show up for the analyzer to analyze.
>
> You're right. That statement was too broad. A chunk shorter than the
> header is dropped, so the analyzer never sees it.
>
> > Now, regarding this, I wonder if the driver receives a chunk smaller
> > than the header size, whether we should either append it and leave
> > interpretation to userspace, or 2 drop the entire dump because we
> > can't guarantee its consistency if we suspect data corruption when the
> > firmware is not supposed to generate chunks smaller than the header
> > size.
>
> I would go with the second option.
>
> Appending it does not really leave the interpretation to userspace. Each
> header tells the analyzer how many bytes belong to that chunk. If we add
> a fragment without a header, all following headers are shifted and the
> rest of the dump becomes difficult to parse.
>
> Aborting seems like a better fit. The firmware should not generate a
> chunk smaller than the header, so seeing one means something has already
> gone wrong. We can no longer rely on the rest of the dump being
> consistent.
>
> hci_devcd_abort() keeps the data collected so far and marks the dump
> with HCI_DEVCOREDUMP_ABORT in the State line. Userspace can then see
> that the dump is truncated. hci_qca and hci_vhci already use it on
> their error paths.
>
> > Yeah, the decision of considering a chunk valid or not seems to be
> > split between kernel and userspace. The kernel evaluates if the chunk
> > is too short but won't check any data consistency after that;
> > userspace will evaluate the headers but won't get a chance to evaluate
> > if any small chunk was dropped in the process.
>
> I think aborting closes that gap. The kernel decides that a chunk too
> short to contain a header is invalid, and userspace can see that the
> dump was aborted instead of silently missing bytes.
>
> Would you prefer this as a separate patch on top? This patch only
> restores the header in the appended chunk, so its Fixes tag can stay
> focused on that regression. Handling short chunks with an abort would
> be a separate behavior change.

Lets spin a new version aborting if the chunk is too short, I will
probably have it fixed up in place with the origina change since that
wasn't pulled yet so it makes it easier to not have multiple Fixes tag
applying one on top of another.

> Thanks,
> Ali



--=20
Luiz Augusto von Dentz
