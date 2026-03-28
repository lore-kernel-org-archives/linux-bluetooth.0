Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB862D73AE
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Mar 2026 10:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774693166; cv=none; b=qIWpA1Mgmo6b258zst18CdPoRGwZPLsQFOGV0K0KD5/mN1lpLkWpxDm14pd527wMhUM7+OCEY94R+d8qCutYOZkwA4vGBzo0FP8F3nfciyi4UPL25i9rXF/6onqy9XQPU6cMbRQHKxoVnJgXFMBYeQZY2xhn8Ls9yCIJww4qzeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774693166; c=relaxed/simple;
	bh=f2O1o9ChHw/hKIhPXdo0+cAv6jxe2DukmdBXXrGj3Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoHnbH9BSXmwyAtPTuzsFK7+8fgc1LBK6l8TEqHjWYiAY2YO3Yd8oFZc+Sjg3/xxAxnHaYC8yrmla0CeiD0Z9lj60EDjTu3xoiVnB7/JYQUDrwPGJK+r52ihBwQrRhC36GsW5fTbtxKFAI+uyEoe/2Lh4MFPAPHYTIQR/B5EVs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+DWzbEn; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+DWzbEn"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82c28f0a4ecso2139018b3a.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 Mar 2026 03:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774693164; x=1775297964; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z6kc9CVC1Mu2V4uWX99Um1RmDLB/D3eNR7xt38VOK/4=;
        b=Z+DWzbEnO4nJc4fssoZQYFkezjBrR9aQxEViIC1doBbqNzIaOrYJ9xoVPhbxlJUmRq
         /gJJmjtr5pegLskcI59dHIW+VYENoXks5A5uvrmrqXYvXghLaslv0jSQk/GKbFHRVoGw
         QUGKW0ZXez80srNOaY64Z8dSf8YrjhlMupbHHc3yyeb5l+cmm/YctqsejV+TCt1qXAlZ
         uazc6aZW4GRst5P55Vxj8rzmnlM5XFNpqerNQrE61vSX+00CBmtIHim8Ao382ggxiEwR
         gpV9nbtqb5F4Lpq7zyOlCRNUuUTUVvTjziQE57o4IXSnfYZtUVhgRUO2Vev/8MbjiW8z
         tHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774693164; x=1775297964;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6kc9CVC1Mu2V4uWX99Um1RmDLB/D3eNR7xt38VOK/4=;
        b=Mqk9dqZclLMP5cFiQMW1uRC9xlKUD4dmm+H4TE0oASDt5VNMhQ7UPsvQFlZ0x77NdM
         V76eBheSk6OTJkUHk2Wu/ocv/pGh5EYDp5jA1Je32tldorQD3Ix+fWou9537bawUeQ3i
         +fbErzAzJVE1r1lCuBsX2OR6cIBubf7ojyflBZCsbCXch0diRgQZCKlfCPrnzXjaIZhF
         k9Q/l3Y/WOhLNJ9VKIHbTU669X52C2AoR9yzyxmCQtQ/g8TWI6+ihahFvclom3EI5Y0B
         NIwbcMEjTLAcqZisBScByh8MjGwW0Nshq9KCsBCCrYHT2h6o/E/IAhjL/QOeUVqS5/5Q
         MZQw==
X-Forwarded-Encrypted: i=1; AJvYcCXwJYasjBir3X1yhsCbTYfmC6oWfI914g5Y9UW77D6WPkPD+lubc1SXwl/0U5D+B1wqGiAZvUGe+T0Klv4gE0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxadDfBSXAUZKuA0lORHk6RxHjTVVGlDAZCReDtU+8/1fc0Y5kW
	vDPJOnNr5kER+QgslGHZLpSKYzi6U3TOztTxdXXO3J8kAxKwTwC9CgRN
X-Gm-Gg: ATEYQzyCOwgwT3Y/I7p/U3sN0J66scQLtS7wgohASEDh60kPDGStyO2Gh203wbD3YGc
	3QpM8nct0ySGAkGyapVtVzJgHSN7g+FRvvgDlDbV5HyvyT/GGr+IJWeENYonqYa7958eOjsb20e
	yCUcE6Hx5z1fvRevrTG5WnOftFHkPxfYFj1MQiXLDH0A+RPswdBGL8vBmAvKf/0/brxakAbXgcU
	SidRILhRaNSnCwDXbLVKP+3UNkpx4eBMpykajZGVAvKA/lf3v6KKoKTxbYVGqX0vzlTaPMPpwsh
	EQ9jvpmC4p6GARYH1FaM8x1W+AFEOz5DVbBE0bj08z/rqAFNGgan2DI0fkaibbGQql+IbSWq8Yu
	bwhb9aJcIzjJQo6tXKCnR+C2jC4XilJtX3NKDk03BTstgDzq8g38kF9hiuopktZtoG1A6X1U8qt
	KKVFYcldjCFLER1IF1tA==
X-Received: by 2002:a05:6a00:3c8e:b0:823:d58:c4ab with SMTP id d2e1a72fcca58-82c95af2c2fmr6063313b3a.2.1774693164283;
        Sat, 28 Mar 2026 03:19:24 -0700 (PDT)
Received: from fedora ([103.149.159.98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85fc6c8sm1553087b3a.45.2026.03.28.03.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 03:19:23 -0700 (PDT)
Date: Sat, 28 Mar 2026 15:49:17 +0530
From: Aby Sam Ross <abysamross@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	syzbot+b170dbf55520ebf5969a@syzkaller.appspotmail.com
Subject: Re: [PATCH v1] Bluetooth: hci_release_dev: disable delayed
 devcoredump work
Message-ID: <acerJSJ5cx-4CKcp@fedora>
References: <20260322210849.68743-1-abysamross@gmail.com>
 <CABBYNZJ0hJaVRpqPOknitzD_VnKwQ3RkS00EH4GStdbW6E+ADg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZJ0hJaVRpqPOknitzD_VnKwQ3RkS00EH4GStdbW6E+ADg@mail.gmail.com>

On Tue, Mar 24, 2026 at 04:42:21PM -0400, Luiz Augusto von Dentz wrote:
> Hi Aby,
> 
> On Sun, Mar 22, 2026 at 5:09 PM Aby Sam Ross <abysamross@gmail.com> wrote:
> >
> > It is not necessary that the pending delayed hci devcoredump timeout
> > work, hdev->dump.dump_timeout, submitted to the hdev->workqueue by the
> > bluetooth devcoredump state machine,
> >         hci_devcd_rx()
> >                 hci_devcd_handle_pkt_init()
> > will be reset by it or by the timeout func hci_devcd_timeout(), using
> > hci_devcd_reset(), before destroying the workqueue or before the hci
> > device is freed up in hci_release_dev().
> >
> > In this bug the active delayed devcoredump timeout work's timer object
> > is active when the memory associated with the hci device is freed up in
> > hci_release_dev() causing the ODEBUG WARNING.
> >
> > Make sure that the delayed devcoredump timeout work is disabled before
> > the hdev->workqueue is destroyed and before the hdev memory is freed in
> > hci_release_dev().
> >
> > Tested the change with the syzbot reproducer that uses vhci device
> > locally on x86_64 and on syzbot portal as well. Ran kselftest with net
> > target.
> >
> > Fixes: 9695ef876fd1 ("Bluetooth: Add support for hci devcoredump")
> > Reported-by: syzbot+b170dbf55520ebf5969a@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=b170dbf55520ebf5969a
> > Tested-by: syzbot+b170dbf55520ebf5969a@syzkaller.appspotmail.com
> > Signed-off-by: Aby Sam Ross <abysamross@gmail.com>
> > ---
> >  net/bluetooth/hci_core.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 01f8ceeb1c0c..1c7ee2a33337 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -2747,6 +2747,9 @@ void hci_release_dev(struct hci_dev *hdev)
> >         kfree_const(hdev->hw_info);
> >         kfree_const(hdev->fw_info);
> >
> > +       if (hdev->dump.supported)
> > +               disable_delayed_work_sync(&hdev->dump.dump_timeout);
> > +
> >         destroy_workqueue(hdev->workqueue);
> >         destroy_workqueue(hdev->req_workqueue);
> >
> > --
> > 2.53.0
> >
> 
> https://sashiko.dev/#/patchset/20260322210849.68743-1-abysamross%40gmail.com
> 
> Both points seems valid, that perhaps the dump shouldn't be attached
> to hdev object since it maybe necessary to unregister the hdev as part
> of devcoredump handling, anyway if it is required then upon unregister
> it shall actually cleanup the dump object as well.
> 
> -- 
> Luiz Augusto von Dentz

Hi Luiz,

From what I see hci_unregister_dev() is called by all bluetooth drivers that use
hci_devcd_init(). Please correct me if I am wrong.

So we can either make hci_devcd_free() non-static and then call it from
hci_unregister_dev()
OR
Do vfree(hdev->dump.head) followed by disabling the delayed devcoredump timeout
work in hci_unregister_dev()

And then destroy the workqueue(dump_rx)?
