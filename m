Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E961C700D
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 19:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750101603; cv=none; b=TmvaiSlqSLXHUttWr1kyjG8sMPJo3IjyD0Geg0BCHmApTuZ8xleu1AcPizHH4kWAijO+q7j+MQRnv4BYNqKed9NHT6102NL1vuznlGitqO9jCuKblgLH2Hyl7tbtb+R94uh40IMqpiH9eaXPri4rZKR16k7xSrrGvVtpMe6cxFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750101603; c=relaxed/simple;
	bh=bAdRAuw8AMmRXxqyEYK5ymeoJ5OR/SGMfPMIj6c9SkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IoaSKQ8FEPsGFGx3M4uuagZ92LzE4dkeAkj/k5ONFxz0fLkQ3B6YhUyA82l/ihiSBC1wWr+b27au1U+u6/1zN+EFXiGpZNrgSkjkVNow7Eon/nMy2K48WQjUN/9+lfL3oeVG4WiKEj+LxeXbyA4ni5fwEaUFBLdQDv/f6L1J5n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVJEk2Pg; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVJEk2Pg"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-236470b2dceso41729765ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 12:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750101601; x=1750706401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIdZiVvE5kzBWRLmvXcmiH19apF3XkY2dYjomdJ/LJw=;
        b=VVJEk2Pgjb7yNeekp0YTa0vGKszoRGpeTENgpsOUUGbPcWaHSGAQvrZvazvJyO/bo0
         4UU7tNL4ehy5ZBgLedDyO4otyVfB3E3CVvb2moszad+HHbsWqqnhdUEkjLsV/HFJXE/q
         novw+HF2kuTZpN1ooYgWGy5wPe6Q9UJ/DplEXjahExOaRPGN0Q/gHLK5A5tq1G2sgka8
         ULm9KC5FAldgBcDTeOJpTWsv2BWzhbYg+asdpI3xN/7v1e5c9PIreOdH4gzkxKdmQXHF
         v4gkYppVA0ROKZ3vZ2uWltikDpKvSRhjru+UgWWLsq+40j6+cBIeciPSJtAgzVSVriqJ
         LUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750101601; x=1750706401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SIdZiVvE5kzBWRLmvXcmiH19apF3XkY2dYjomdJ/LJw=;
        b=Bii9maXodgYtc3PHWlXFIpZ6jB3m/Ixkv7S5JmdYQ68tcOdGO7hx7gdTYPYGNB3xqE
         xS3q3KrCtzIssTKxnbtLxaC92YXurTg8eFaXtezeZMbAKV0lre7vGJSFW0ON2F9nKAse
         Tq3FrNLIx98QZx+c1C9a2bNR1NjLkekrssBuKW7wREJ3T7Vn/ikYmy/aqR7oALdGmICg
         YL07a0zNUCPZmV0L3/hmDXWm6MHJqlcX1IJlQI07gm1Ey8p6dQfJtUBW2yqf30V99iMN
         97cz9q7LkVS4WD/nzAxu6fHoaI7kUqPnH4GYRanB/PbbiFInYKkuOu92nVJ79E+cbuMz
         wuzw==
X-Forwarded-Encrypted: i=1; AJvYcCXv9nxhxdtGqicVaFdw1dLTf0UW3VKdf4zlpEOSE/tai3qlv+F3F7UTY58Yj53OByQtojR2x48s3rOucr1eYXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNbG2BU/QbHW7CMMXjM949c2AtSGHKssuuW875ngL85QnWeUMR
	51qjp02r3oAO+yMLWD2w/mtfa8HZ/BlW9PmqxLBfhf3Axl8eBs2uEIU=
X-Gm-Gg: ASbGnctKZziCpucRBhoqSZUcMUC2UUsU3XBdW9yxo9ksqB4MdwrewYfRhytfZzNMfO2
	5cg2D4A66KWAfI670Rf4VAq3NT+IJI8i9UoTryw7s5kzW2Ndt6M9IODZKAXL0lcd/qn+bjsS7ir
	MRJFcWi8fEuqJHr9ic62KQ85XFjMos0hJxhp/EhM8HegsuBSFd4i4CjlOLDrWv6BYpkMTho+1hw
	fvMBY//PjVnzlda3iBjy8iwJrdT76+rG7Q13AfLAb6xWehkZj58ogvB6/TwKvHkEGHY7nGEo4vN
	qTbd9H4Wbt930xUCesDARUWxgjV5w4a9iNsKIxA=
X-Google-Smtp-Source: AGHT+IHVkitqGXu6HBm352Utyx6cR9lTLOTSEbYZxT2SAv/xXPcJFlNomllfM56JmH35rQIg1eNKMA==
X-Received: by 2002:a17:903:1205:b0:235:779:edf0 with SMTP id d9443c01a7336-2366b3e3323mr144932575ad.50.1750101601428;
        Mon, 16 Jun 2025 12:20:01 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deca351sm65136845ad.207.2025.06.16.12.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 12:20:00 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: luiz.dentz@gmail.com
Cc: kuni1840@gmail.com,
	linux-bluetooth@vger.kernel.org,
	pav@iki.fi,
	syzbot+2faa4825e556199361f9@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] Bluetooth: hci_core: Fix use-after-free in vhci_flush()
Date: Mon, 16 Jun 2025 12:18:33 -0700
Message-ID: <20250616191959.1001730-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CABBYNZJ0Vggb5J68PBEkv3CzLBO7YoBrqcMvJ-tU_aMghVgBMQ@mail.gmail.com>
References: <CABBYNZJ0Vggb5J68PBEkv3CzLBO7YoBrqcMvJ-tU_aMghVgBMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 16 Jun 2025 14:56:26 -0400
> Hi Pauli, Kuniyuki,
> 
> On Mon, Jun 16, 2025 at 2:12 PM Pauli Virtanen <pav@iki.fi> wrote:
> >
> > Hi,
> >
> > ma, 2025-06-16 kello 10:37 -0700, Kuniyuki Iwashima kirjoitti:
> > > From: Kuniyuki Iwashima <kuniyu@google.com>
> > >
> > > syzbot reported use-after-free in vhci_flush() without repro. [0]
> > >
> > [clip]
> > > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > > index 07a8b4281a39..d648b514e2df 100644
> > > --- a/net/bluetooth/hci_core.c
> > > +++ b/net/bluetooth/hci_core.c
> > > @@ -64,9 +64,9 @@ static DEFINE_IDA(hci_index_ida);
> > >
> > >  /* Get HCI device by index.
> > >   * Device is held on return. */
> > > -struct hci_dev *hci_dev_get(int index)
> > > +static struct hci_dev *__hci_dev_get(int index, int *srcu_index)
> > >  {
> > > -     struct hci_dev *hdev = NULL, *d;
> > > +     struct hci_dev *hdev = NULL;
> > >
> > >       BT_DBG("%d", index);
> > >
> > > @@ -74,9 +74,11 @@ struct hci_dev *hci_dev_get(int index)
> > >               return NULL;
> > >
> > >       read_lock(&hci_dev_list_lock);
> > > -     list_for_each_entry(d, &hci_dev_list, list) {
> > > -             if (d->id == index) {
> > > -                     hdev = hci_dev_hold(d);
> > > +     list_for_each_entry(hdev, &hci_dev_list, list) {
> > > +             if (hdev->id == index) {
> > > +                     hci_dev_hold(hdev);
> > > +                     if (srcu_index)
> > > +                             *srcu_index = srcu_read_lock(&hdev->srcu);
> > >                       break;
> > >               }
> > >       }
> > > @@ -84,6 +86,22 @@ struct hci_dev *hci_dev_get(int index)
> > >       return hdev;
> > >  }
> >
> > If no list item has `hdev->id == index`, doesn't this now return the
> > list head -> crash?
> 
> Seems wrong to me as well, *d was used to hold the current entry but
> that has been removed so hdev would be used instead which may return a
> valid/non-NULL entry even when its index doesn't match. Btw, are there
> any documentation regarding the usage of SRCU in such cases where
> there are still references?

I think that's the main use case of SRCU, and basically the use case
is similar to the normal RCU.  There are a bunch of doc under
Documentations/ and I'm not sure what's the best one, but LWN article
would be a nice one to start.

https://lwn.net/Articles/202847/

Also, one good example would be rtnl_link_ops_get(), rtnl_link_ops_put(),
and rtnl_link_unregister().


> 
> Usually the hci_unregister_dev is called by the driver to inform the
> hardware has been unplugged from the system, so we do want to be able
> to abort any ongoing usage of the hci_dev so in this particular case
> perhaps it is easier to just check if HCI_UNREGISTER has been set
> before attempting to flush.

Maybe like below ?

I think the downside of this approach would be we need to apply this
change to each driver that has the same issue.

Note that we need to hold mutex here otherwise there is no guarantee
that another thread does not complete kfree().  I'm not sure if touching
unregister_dev in non-bluetooth-core code is something we should avoid.

What do you think ?

---8<---
diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 59f4d7bdffdc..3dea1292da2d 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -66,7 +66,10 @@ static int vhci_flush(struct hci_dev *hdev)
 {
 	struct vhci_data *data = hci_get_drvdata(hdev);
 
-	skb_queue_purge(&data->readq);
+	mutex_lock(&hdev->unregister_lock);
+	if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED))
+		skb_queue_purge(&data->readq);
+	mutex_unlock(&hdev->unregister_lock);
 
 	return 0;
 }
---8<---
