Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F517204C1A
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 18:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750100162; cv=none; b=AVX8PQPLCeeWFzhvrPDxK4/Svfeksmfn5tncC5iu5ltUyKlpaWKj6UVXJ+DcLhNSufiDi2NJ1dwQPNcS8dTcGP7KfcubTD+o0Mzf2w9VdYjZKlGLXQq1GIkySR12JmJ40grKguVMLy12BeW6c6sQG8M/zfXkJI1+ImJYBgUo8WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750100162; c=relaxed/simple;
	bh=vlo9sbhi7PR5jq4z8W+Pm8UzH6ATPlvIvFqnNTPMVsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8GMwHa298NyDsbe4S/KUzZ4KMYTebHw1ZTce5EyLVV8Bw05rvMyMkpH6fdbSIGH5amhjmUX/C1rRLm+ys0/RFAMzQX9OUTnvHnLawRpKxTmDLQR6lpSdq8iH4U5GXNba04He17jsRj3OGIr7OChDtrwn3fnIiFgIFW/DhyGdEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMD2Ti8b; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMD2Ti8b"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2349f096605so64205285ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 11:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750100160; x=1750704960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/f4FddS0pQ7NWrVC1kcIP85c5tBr5/IsqIRPI5hoOY=;
        b=mMD2Ti8bYfDRl07fPpOjhYvA0M1YqCTGU0gktl9ZgCGZFdFQ1nmkOs8E28kbaPiDTy
         0RzWA9STB9NCmt7hv6IXZIu8FmnCbMsiIupmUcVqoAyhrdSBWyaaYa3b86sd/hRGevLM
         G4BhfkcVFWaoBhGd9XSeKO9F+aRJsrA4/m/oWEW0+haTnxvJnmC+z3+oHYFXZ79+SNkp
         fLMTxyN7TJc1aJPiW15V3ZBUlJb6+9ctymIyILrq31hR2pEVzQfyFDVuRQJEpHfpJ2q9
         SDUe7gvaPhlY9Wh6nZdnk1Oum5FKxIRog8Epi80OoQJC5KqKPTPQ6G2FOKc1JIM2HfLD
         BCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750100160; x=1750704960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/f4FddS0pQ7NWrVC1kcIP85c5tBr5/IsqIRPI5hoOY=;
        b=J+AEVmJlc6M0NMssq9YF4VEGi727O8AYkitlpSASyFzSwEMnqfcEsVE3GpOev74b+Y
         qeHwStPv7F80Bpzmdm6y1VO2h+WdMmTrNN4HS6htRT1L41IA8e4EyB4+lStXYHZOfyWm
         N5SWDmJS4rn4DiGAhbSUoZpMbLwqrGN55t8xfb9X/RbHSXPtj85Rnac2L6cP449Sbhgj
         MDlh2w1DtKRBAv6F1LAe1kVVkayLBb3Myv6VnkXL9dRITm7pD754tdT6azaodl0KmOmQ
         rpe59AjvIpa4BAUm1fE6j9tv2zye1Ow2hfJ/HfEP0krdWxNr8p5l64GiIkIeXe4Guuqq
         ugWA==
X-Forwarded-Encrypted: i=1; AJvYcCWLXqBr6QyB31aq8ohHoJ/LepkaJWCbI6if4C2KobbhSRfO5heqf3tYDqFYzlLc4gAG+MiHIq7LsejwW8oeI+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww1ePSvsipsGGGvloqDkGrAD5dbgosAXp1YZ46lyR+6K03D8jN
	18tAH0Moef+IhR89/6yJ7lqrxrrZ2icfuLpQrYA+AlW0PMmvdTCFhdM=
X-Gm-Gg: ASbGncuDyiwSoxxtpKynia/6kqDQd+a8g3MEE6gNcI3dQooyHZGTs8bClxq/j5dSh/9
	JxyONp4MIspZ8EJ7BzEGWOYueI5qttF6KKKRaVia3yOyARF8EDCHWj/8YxDnJg8VPSwi1ZHKZ5j
	jjzAmmQ06/ugVXgGoZS2LRi62RWlabZXrtC/W6VRnnVMXV3mvnWml/KsksyTncZTlQmc03W7Hwm
	NQae0o6VsIeLvsX/OXQaR2TsElZ1OV469T10o2wEwz+T3prtTWSA5ECpSepb/4k4OQ3w32kU8At
	9fUCzBPXbUcyOp8KqR86zeMPP5gyKtSTKG4CfRk=
X-Google-Smtp-Source: AGHT+IHhb0dF/RWlHNUTOGhPR4ARKOm7xZsslZhFUnOzshypUDn210X33A/2VJ5ANlqIGK7JwQIhkQ==
X-Received: by 2002:a17:903:b88:b0:234:8f5d:e3bd with SMTP id d9443c01a7336-2366b3c353amr161855135ad.39.1750100160555;
        Mon, 16 Jun 2025 11:56:00 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deca2dasm65047235ad.206.2025.06.16.11.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 11:56:00 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: pav@iki.fi
Cc: kuni1840@gmail.com,
	linux-bluetooth@vger.kernel.org,
	syzbot+2faa4825e556199361f9@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] Bluetooth: hci_core: Fix use-after-free in vhci_flush()
Date: Mon, 16 Jun 2025 11:55:56 -0700
Message-ID: <20250616185558.985414-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <b964dbbad90d2561b28386d6d254048596d0897c.camel@iki.fi>
References: <b964dbbad90d2561b28386d6d254048596d0897c.camel@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pauli Virtanen <pav@iki.fi>
Date: Mon, 16 Jun 2025 21:12:10 +0300
> Hi,
> 
> ma, 2025-06-16 kello 10:37 -0700, Kuniyuki Iwashima kirjoitti:
> > From: Kuniyuki Iwashima <kuniyu@google.com>
> > 
> > syzbot reported use-after-free in vhci_flush() without repro. [0]
> > 
> [clip]
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 07a8b4281a39..d648b514e2df 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -64,9 +64,9 @@ static DEFINE_IDA(hci_index_ida);
> >  
> >  /* Get HCI device by index.
> >   * Device is held on return. */
> > -struct hci_dev *hci_dev_get(int index)
> > +static struct hci_dev *__hci_dev_get(int index, int *srcu_index)
> >  {
> > -	struct hci_dev *hdev = NULL, *d;
> > +	struct hci_dev *hdev = NULL;
> >  
> >  	BT_DBG("%d", index);
> >  
> > @@ -74,9 +74,11 @@ struct hci_dev *hci_dev_get(int index)
> >  		return NULL;
> >  
> >  	read_lock(&hci_dev_list_lock);
> > -	list_for_each_entry(d, &hci_dev_list, list) {
> > -		if (d->id == index) {
> > -			hdev = hci_dev_hold(d);
> > +	list_for_each_entry(hdev, &hci_dev_list, list) {
> > +		if (hdev->id == index) {
> > +			hci_dev_hold(hdev);
> > +			if (srcu_index)
> > +				*srcu_index = srcu_read_lock(&hdev->srcu);
> >  			break;
> >  		}
> >  	}
> > @@ -84,6 +86,22 @@ struct hci_dev *hci_dev_get(int index)
> >  	return hdev;
> >  }
> 
> If no list item has `hdev->id == index`, doesn't this now return the
> list head -> crash?

Oh right, thanks for catching this!

I placed read_lock() outside of __hci_dev_get() and returned
NULL in v0, probably that's why.

I'll keep the *d as is in v3.

Thanks!
