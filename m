Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC23227E82
	for <linux-bluetooth@vger.kernel.org>; Sun, 16 Nov 2025 06:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763274376; cv=none; b=g1nYnCvH77T9czJXNWlw1VGwuKcVTUmBodUwPb7y5xhr5E+Z81comJLYi6fLBoJs2BO7sI3W+QnvuytOLOexca+kZWjQKSJYR+QCsa24nh7VpEQAOLz5LkSCcjcy8CVULS9zf8FXfAyptSZS88KU833GaxOBqKaUDvCJ849jLzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763274376; c=relaxed/simple;
	bh=bRTpqW34DWOfVb0TcyK0qI0c3k7oA4DWw/TAyK6ova0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ih6k35RBp6QFAVZ9wgKOdjPD2hnbY6Yh6aj2x9Rq1mlcSqlqrWcE/5MkuFVBN2xE74lm9Z0mgRvMnUW1gqNr1e3PXATFGcKzTdB6St2zIMZhbz54nJUB3UmTl00YX6dx3NsaWrclNaaLM3vIFT46IVHrJi94sULJdxZ1IeKE/44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXww4SI8; arc=none smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXww4SI8"
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-37bac34346dso15747651fa.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 22:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763274372; x=1763879172; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bRTpqW34DWOfVb0TcyK0qI0c3k7oA4DWw/TAyK6ova0=;
        b=BXww4SI88Q1c/sUz4wOA2X1FccQzeyGB7/pJW4l6NlG6BUHgExTgT22O97sGiwc/0C
         tk45V2db2sTCMHYRUSVW5xHl1zNvvo4hLwElrP3m3mLJmmm4MQPkdRv/QH+tPy3y0c8X
         /D05XkppvLJAPp+oaJKecB2vBNCIIRlC8nWyj4RYxOUckOrQj5E6k9oAeJeJEttF/eQM
         75Q8AxVax3BJyDFPJ6mr7m3l48VthkmDM1qmL/xF+MAj8mbG7kK/W2rIJLexWdCfAv4f
         /LCSxgZc3g35WDyiB6xDbrvuF86/gec/ANGwg+Bd+IrxBuvA2jpba97WMiagkPUej0au
         IC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763274372; x=1763879172;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRTpqW34DWOfVb0TcyK0qI0c3k7oA4DWw/TAyK6ova0=;
        b=kqA+Kd37m8fV0kg9dbI2j7htlZ3OTAiOUXzPBQcLK9DUi5lXSTUzHamTaA5aQIMwCK
         sFBYwGmDlbBgQ7nVxW6MRUQ7wg4queBcAWxUthVZmnl9a648WlhZbLkmyO96ujEO2kfz
         vGwfgiNB5srPKbsr2emdMzKVHWCaGLl6ZP2jO4Z1EW4li0WBlVvHpLs7S90oXV+Y6WXC
         qoWSMMgTf/iSiIOUyLbxkuN7EfWFdwpbuTfDVpSJWU7uiXjv3VKSUu9odb3ed7CaByr6
         tXI6eA/ysI2a3P4p0Zfida/RlcGEahkowNpIv6oRBqSMLPC8U+FfWUWt+FL4yoq+mU+f
         ULfg==
X-Gm-Message-State: AOJu0YzXEhMDI3lWUCu/YvfZWxMu4sfCGZLFfumB+ACNxcGucTx0gdUI
	NVq2V+Ys41JS5PVAf3MzyRzNDJPouVHGv1C+8RrpV8JzDSFbI3F/BfGnWACKVUSkUGQCqfSfFwU
	G+vM/t80jRMttlMpKKVsBlRoYHI0hogQ=
X-Gm-Gg: ASbGncuFPQij9mAhUarJwr1QV5BHNVio3zjuCzb32I4BRqCH9cv74e1hYuGAIS5TTvm
	8PWoiW79N6to7VX5V9a291flD4+N0kVYDDIvydkttx8AAIl3KthnKSXLScbitUuwRrUhT3O8gZ2
	EAB1jQFdN6C5WbZPA6kVlo0eEbEmO8Vu0/IhxHN6F/OMSKABcluYeKCoXFbSfOZR6PtQwMVgYcP
	ZeJKrzWVjAHuUytokxIG6CL0CJ0t/w8UDxSdRVory6DRJbzmAt4hKth+7fDN23ZIADk2ga7gXkC
	QhzaVzY=
X-Google-Smtp-Source: AGHT+IHCO0gB53dgQIMTyu3+21+Cg3cdeL30tT+RjgLxXDa9qnv+x+lMHKTHBO4DfB0td9H3LUpwiSWvc3Xw4GbZRM4=
X-Received: by 2002:a05:651c:25c5:20b0:356:7e6f:c66b with SMTP id
 38308e7fff4ca-37babd7d5dfmr17634051fa.38.1763274372221; Sat, 15 Nov 2025
 22:26:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB7XQsFfTn3gL6TksbTNnC3E7SRPt+odtkVUJa24b=LmP3615Q@mail.gmail.com>
 <6c550cbe2e1f22c18efd6dada81966bbb5269eaf.camel@iki.fi>
In-Reply-To: <6c550cbe2e1f22c18efd6dada81966bbb5269eaf.camel@iki.fi>
From: c Z <rollkingzzc@gmail.com>
Date: Sun, 16 Nov 2025 14:26:00 +0800
X-Gm-Features: AWmQ_bm0go4oiOLKLIZ1geMJSgvSYDw0asW3vFZvkd9vJkIPAQmAHFdMfS3XGyk
Message-ID: <CAB7XQsGcMdph3B4eOt_7+-=N+0s23pWyTKQJ95N54J2XM+jNEg@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: SCO: make locking more systematic and fix
 missing locks
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Pauli,

I tested your patch and it fixes the SCO UAF issue on my side. Thanks
for the quick response.

Best regards,
Cen Zhang
