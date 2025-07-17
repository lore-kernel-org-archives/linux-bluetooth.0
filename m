Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA55DBA27;
	Thu, 17 Jul 2025 05:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752728814; cv=none; b=VVtjlAe6KrbZFRAVsv8EY2MXy+biOf3jdbKvR0w85S4e96JkAiaZsh0P4+4n55FzEVjDsp7YswnSLtVank2f5fL8kE2Yo1Qu83U/cKRxhcf7pj2HYBPn5FuKAYWGbS75AryUXXldpWp6UdpB4PGEx0Qk/gf1m/v7EF8huPQ2V0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752728814; c=relaxed/simple;
	bh=6rQjevkNmev+YgJUfdcl32Bmj+b20+kurXXbn4M21OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+qcDYMOkmG3fw33oCnnv+A8OQ8vXU6g/W7C0K8z8UYwHIqBk8xT8DR5qea6OA9NFKqKyvlS/nfMfoxoHviJvmVfnWLS//R8rFb61Jo+gdgxutwMz+UpGtTUGaMEUOa3jz+IMT4lQZKFbSca98U+KhZeTXycNRZY9YY2AXG7Uxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EojvWsrm; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EojvWsrm"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74b27c1481bso408937b3a.2;
        Wed, 16 Jul 2025 22:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752728812; x=1753333612; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bFue3v6mvDf66GLbgjtHGSkjRNvQOB54vDgPFztj8ko=;
        b=EojvWsrmBJr1eFu24MKOR2xsK1SqK4xtisTBNfsadhw2e6WOV8isK9rT0z5P3Hk7ll
         NtX0r8E8lKIPKF9m1DRTn0aoSPPFlBqAVsuwTW+73PMqJkMfH3/kCVylZV7HysEI1LY1
         gOSyhdK2Y4iwGhCc8XMQB0Hne7Nn7mnDJcPN3hYpfqFz+InKlEXxd7kora8cSTjeOb8o
         phZUMV6tccJn3bcomNvveFjb3TDjzE2D2chdIpjcmmhEA5cRkHZvYrhC1RVMQiqT6On0
         pedRcPZ9H0JkH5U4desJKgoIwU5LL7OSjamWc99tHLpS9KuMBIzsG+A5CWYCe2mM5ntu
         c/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752728812; x=1753333612;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bFue3v6mvDf66GLbgjtHGSkjRNvQOB54vDgPFztj8ko=;
        b=U2VZoSKMEnHvPWdH9hxsB+ECw+wX6cq94h0dGbbOkg6Ty3jqOBCVuwTipqnVearWzm
         r2oH9TVway64acnbBkBgFb4j47VBDhcF1qxKpzYVjL5L2r38naFJrtesCffE47ZBts6P
         1W6epmzZpLJTM7aXcMGdA47WXobHgSP1rtMeG36e9wp5eKdIdalHqL++77WkpRopUoxG
         ck8CdHj87+npDhsmHGKoZvhbKZT7LWgZDP7/0YX8scagUp8tav2P6W0LoRtFdqj+Ljl8
         3KyCgQyH8KPWUhwuqAcJostHcR/uJp/kXmLeYNvOgwFBqrW0CALMelpfi6lPrSdFaiGp
         42vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW1SxwUGkCp4j2taJjfA1uTjWgnq4/904nagqvCffEQCw2OBUzT28fnxva3JZqzLXKYSaI255DtMFqTvcv@vger.kernel.org, AJvYcCXg9JtHYrEEeoHFOkBgY9JboRGBqpnfrQcqTpZgJry94mdGrAcinSkw3qBOmeBFAxxaomiOTY/rqgvYSyBUTtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWST59uVMhkRawdrGEk0fr8guApGQsLYwygB2hfndpTADg7vt7
	6Q9CyeMiR1g+wcRevifGOSErnp5ppmJhDjb0W8UFxtIGgyIY+NEZL0mZ
X-Gm-Gg: ASbGncvKbGyWDlhr/87hBYIg8eui7+tSNEo66OevMcSJUCpnT9xS+xVnu+A+3PaDCWt
	3DGi6fQUNj1W2vulnGqASWzfD39JuShm9fJvVoVXxWNe7GIWU+Cd7w/kzCW/2Ucju1C67ss3Xjq
	EPLEFlGuWb5o6/VlTI9D1XCIDR2/qX8otPQISow7BebKvVXaLCX0TP0uwSxdkwHvxXeX8ZOEps9
	X0xUm2zzzLhtmeakjswM0uPsXz5+SOKkH0LP97Ox1B6A5OwCReGttxhVa3vkHEsn8TplVz3N9uB
	5PnoQmsIMBF70H6/aNJ51yRPDA7jUBKMEltg2/IhPnc+C808Bw4zwY99MlQtr9nVIJN5KKaSRdy
	IZfBJlsw/kyVuUSA+Xf6fpbNEanLCA7CjMJggBWFTU1aaTimE
X-Google-Smtp-Source: AGHT+IF85+6r+g8JG1IgS/yGFDFIoC03INiYvvfGIl4ekOkd3b4Z+DvIpWsbYEt4pXcpNjtnWLGofQ==
X-Received: by 2002:a05:6a00:399c:b0:746:2ae9:fc42 with SMTP id d2e1a72fcca58-756e9fe7578mr8755055b3a.19.1752728811900;
        Wed, 16 Jul 2025 22:06:51 -0700 (PDT)
Received: from ipravd-Nitro-AN515-55 ([2601:646:a000:5fc0:decd:a870:e335:5827])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f8dbf1sm14709755b3a.152.2025.07.16.22.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 22:06:51 -0700 (PDT)
Date: Thu, 17 Jul 2025 01:06:48 -0400
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] Bluetooth: coredump: Use tmp buffer with dev_coredumpv
Message-ID: <v7jemzeqc6cgvpb67iyzoxg5wbuhxfjprhpdamszkvs3dvglu4@2dzbx4d76ipj>
References: <20250716003726.124975-2-ipravdin.official@gmail.com>
 <CABBYNZLOTLVz4kCGMK7kw1RE-KdWciOYwkn6tN_=GZUk92ySdA@mail.gmail.com>
 <tdj2vssbhlth7gxggbnltssux6r7kzhn3guloefmieboszejo3@7yrut5ygk3yq>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tdj2vssbhlth7gxggbnltssux6r7kzhn3guloefmieboszejo3@7yrut5ygk3yq>

On Thu, Jul 17, 2025 at 12:11:16AM GMT, Ivan Pravdin wrote:
> On Wed, Jul 16, 2025 at 10:11:01AM GMT, Luiz Augusto von Dentz wrote:
> > Hi Ivan,
> > 
> > On Tue, Jul 15, 2025 at 8:38 PM Ivan Pravdin
> > <ipravdin.official@gmail.com> wrote:
> > >
> > > Create and use new vmalloc'ed buffer with dev_coredumpv. From
> > > dev_coredumpv documentation:
> > >
> > > `This function takes ownership of the vmalloc'ed data and will free
> > > it when it is no longer used.`
> > >
> > > As hdev->dump is used after dev_coredumpv, create temporary buffer to
> > > hold hdev->dump data.
> > >
> > > Reported-by: syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com
> > > Closes: https://lore.kernel.org/all/67eaa688.050a0220.1547ec.014a.GAE@google.com
> > 
> > It should probably close the syzkaller issue, which I assume is this one:
> > 
> > https://syzkaller.appspot.com/bug?extid=ac3c79181f6aecc5120c
> 
> I will change it in v3.
> 
> > 
> > > Fixes: b257e02ecc46 ("HCI: coredump: Log devcd dumps into the monitor")
> > > Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
> > > ---
> > > v1 -> v2: Changed subject prefix to Bluetooth:
> > >
> > >  net/bluetooth/coredump.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/bluetooth/coredump.c b/net/bluetooth/coredump.c
> > > index 819eacb38762..1232c9a94f95 100644
> > > --- a/net/bluetooth/coredump.c
> > > +++ b/net/bluetooth/coredump.c
> > > @@ -243,6 +243,7 @@ static void hci_devcd_handle_pkt_pattern(struct hci_dev *hdev,
> > >  static void hci_devcd_dump(struct hci_dev *hdev)
> > >  {
> > >         struct sk_buff *skb;
> > > +       char *coredump;
> > >         u32 size;
> > >
> > >         bt_dev_dbg(hdev, "state %d", hdev->dump.state);
> > > @@ -250,7 +251,11 @@ static void hci_devcd_dump(struct hci_dev *hdev)
> > >         size = hdev->dump.tail - hdev->dump.head;
> > >
> > >         /* Emit a devcoredump with the available data */
> > > -       dev_coredumpv(&hdev->dev, hdev->dump.head, size, GFP_KERNEL);
> > > +       coredump = vmalloc(size);
> > > +       if (coredump) {
> > > +               memcpy(coredump, hdev->dump.head, size);
> > > +               dev_coredumpv(&hdev->dev, coredump, size, GFP_KERNEL);
> > > +       }
> > >
> > >
> > >         /* Send a copy to monitor as a diagnostic packet */
> > >         skb = bt_skb_alloc(size, GFP_ATOMIC);
> > > --
> > > 2.45.2
> > >
> > 
> > What is wrong here the is code that attempt to send a copy to the
> > monitor uses dump.head _after_ dev_coredumpv has freed it, so just
> > changing the order shall make it work properly:
> > 
> > diff --git a/net/bluetooth/coredump.c b/net/bluetooth/coredump.c
> > index 819eacb38762..720cb79adf96 100644
> > --- a/net/bluetooth/coredump.c
> > +++ b/net/bluetooth/coredump.c
> > @@ -249,15 +249,15 @@ static void hci_devcd_dump(struct hci_dev *hdev)
> > 
> >         size = hdev->dump.tail - hdev->dump.head;
> > 
> > -       /* Emit a devcoredump with the available data */
> > -       dev_coredumpv(&hdev->dev, hdev->dump.head, size, GFP_KERNEL);
> > -
> >         /* Send a copy to monitor as a diagnostic packet */
> >         skb = bt_skb_alloc(size, GFP_ATOMIC);
> >         if (skb) {
> >                 skb_put_data(skb, hdev->dump.head, size);
> >                 hci_recv_diag(hdev, skb);
> >         }
> > +
> > +       /* Emit a devcoredump with the available data */
> > +       dev_coredumpv(&hdev->dev, hdev->dump.head, size, GFP_KERNEL);
> >  }
> > 
> >  static void hci_devcd_handle_pkt_complete(struct hci_dev *hdev
> 
> Unfortunately this does not work. This was my initial attempt but it
> still reproduces the error [2]. The reason for that is that
> dev_coredumpv takes the ownership of the buffer. From the comment
> above dev_coredumpm_timeout (which is used by dev_coredumpv):
> 
> > Creates a new device coredump for the given device. If a previous one hasn't
> > been read yet, the new coredump is discarded. The data lifetime is determined
> > by the device coredump framework and when it is no longer needed the @free
> > function will be called to free the data.
> 
> If hci_devcd_dump is called multiple times, first time hdev->dump.head
> will be kept. However, calling hci_devcd_dump second time before data is
> read by userspace will free it, leading to uaf error like the one
> observed in the report. 
> 
> As hci_devcd_dump need not be called only one time before hdev is freed, 
> calling it multiple times will lead to uaf, no matter in what order
> skb_put_data and dev_coredumpv occur in the function.
> 
> To solve this problem, a temporary buffer should be used. Such buffer
> should copy data from hdev->dump.head and be surrendered to
> dev_coredumpv without any possibility to be altered or freed.
> 
> For reference, here are some examples of using temporary buffer with
> dev_coredumpv in Intel AVS driver:
> 
> [bluetoot-next 6f40d15c70bc] sound/soc/intel/avs/apl.c:183
> [bluetoot-next 6f40d15c70bc] sound/soc/intel/avs/skl.c:147
> 
> [2] https://lore.kernel.org/all/6845dc6b.050a0220.daf97.0af4.GAE@google.com/
> 

Nevermind... I was under impression that hdev->dump is allocated only
once and is reused until hdev is freed. The link I have copied actually
shows another error that is solved by another patch [1]. I have tested
your suggestion on top of unintegrated patch and it did not reproduce
any issues [2].

I will include your suggestion in v3.

Thanks.

[1] https://lore.kernel.org/all/20250716004252.125466-2-ipravdin.official@gmail.com/
[2] https://lore.kernel.org/all/gkct6i53onzjuzugsor6pnrhjfef7trwhgbjrgfie25xirebhp@dpqxvkguqdnf/

> > 
> > 
> > -- 
> > Luiz Augusto von Dentz
> 
> Thank you for your feedback.
> 
> 	Ivan Pravdin

	Ivan Pravdin
