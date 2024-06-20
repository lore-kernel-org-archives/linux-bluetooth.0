Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A5E1B4C3D
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jun 2024 19:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718912058; cv=none; b=HDiyJTtji0FkjvldLohP23pVEDg7jSQlyLbEF8Ew64Uwl7hGbjMhUxLdYIj9HwHlaQdhm9WXf/HBPYdqo6c9T3+IkDmkM61C923Lham/VtnGRD1+HfGv3EDonYlhbcy58oiR9beW9SI5XcdjOuG9rQUsUBzgXKXQlc9J3y9nSBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718912058; c=relaxed/simple;
	bh=LMJhwXKqZKwDoZfSA47gsl66tl0ZA7Fm/pP5alDoprs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aNQUKQBi25ILDymy7DfTOEIDjowvAGuHnYFsaH0zYtpuihqRo8XmipTK2KPphLDHPzZFnhA0KrSgAMNiQBJlgW0D+gRFmr+slm0HqVJp6d1BjCQESKs4N+733A+fzEC0R/RBw5VJsUI3TeAuI5S6Dd76IrX2aNwXTqr+fivmXOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=T8nqgziM; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="T8nqgziM"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a63359aaacaso189359466b.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jun 2024 12:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718912055; x=1719516855; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rxmltmQrKwAluprbf/AG1nvFIcYg57/7dnDwU0ucSDg=;
        b=T8nqgziMBEYRN680BTXWFLc8Utv4ywSChHlG1sx7gpoAJ8TalEW/nk2aASMZsJ5JEV
         II32E1WYPBr1Q44ut+ufaQZNoL92ZLvIuN7EzaJDP5/f+9lU6P5o30sZ6D2iJq4fdmqq
         +NPgS4qVvVbmjK8FNNFOvr/a1Eh73Q+EWPO48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718912055; x=1719516855;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rxmltmQrKwAluprbf/AG1nvFIcYg57/7dnDwU0ucSDg=;
        b=jBOhlJqP/TZJ55loQSLtoKzbEvzlsA3gKgYYg7Q6KRc6X8BUu816ZqBI2W7SP8tIfI
         CvQfm3uw48r8/mXDZrQvV82ZzAwkj37Ed6+dcrBQjVWFcymaUpAUc3DTNY3yePhYP8sj
         fNNLNLzQlTPLQ1numniCxEcZetXiFKZdxAfb2ynZkoGNqWhe2VGP60bXM5PLcB2PVQIh
         dVxoQLqaCa2xy8jofclx4O+pAW960LjtUCgwt3BhbQtNrmrOdm1X1qrQV4k/htBk0A/y
         yLm1OuRN+8NbdqJSUeo59RhY9t8scnSe3BK4aUfrLqUTy2O23Y+LAul8r1kBiDxkQwfI
         i4aQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8lDnzZtVMhp0LzsHeZOggz9aR8RZk3s2UdEAmTRG13utLpS/k134oplKcgINcxBVSe+hUCrVwUaVq3NbmW8M7tebfE9sbFbrcuOt+DHoJ
X-Gm-Message-State: AOJu0Yxc3k7ZvbkratX+GL6qUKvx2gfk96fxjDuRDaV0DCTS6SpQ+y9E
	o6DehUCaHSpTHUA5e2xYhKM35/OXKfVAT2b6dmWeRnP2ndcc6yWZXfba6GHYTMbSBghoZ/cVONu
	9umPYmhrk
X-Google-Smtp-Source: AGHT+IEJ1JdTm3bREztVYoqso3jQoqe3d9JzzPmqrzIEYzvaOvndnK+YS+v3uymyFKcJE3XxqYOcDg==
X-Received: by 2002:a17:907:a581:b0:a6f:af4f:ff82 with SMTP id a640c23a62f3a-a6faf500049mr463576766b.25.1718912054911;
        Thu, 20 Jun 2024 12:34:14 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf428b41sm3747566b.21.2024.06.20.12.34.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 12:34:14 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-35f2d723ef0so993760f8f.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jun 2024 12:34:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXiBjuiccfXZyq1Hd0bBk6xBFOwEW5AYnR7yTBUjNi9Mv1xVvhNOKxfMIgtDF7SO1E5WrXcp9zvLAknNiMvKiZ96bScaTkYhPQMqiDE/bA3
X-Received: by 2002:a5d:6152:0:b0:35f:308a:cab0 with SMTP id
 ffacd0b85a97d-363170ecbe5mr4379764f8f.13.1718911595412; Thu, 20 Jun 2024
 12:26:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620175703.605111-1-yury.norov@gmail.com> <CAHk-=wiUTXC452qbypG3jW6XCZGfc8d-iehSavxn5JkQ=sv0zA@mail.gmail.com>
 <ZnR1tQN01kN97G_F@yury-ThinkPad>
In-Reply-To: <ZnR1tQN01kN97G_F@yury-ThinkPad>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Jun 2024 12:26:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjv-DkukaKb7f04WezyPjRERp=xfxv34j5fA8cDQ_JudA@mail.gmail.com>
Message-ID: <CAHk-=wjv-DkukaKb7f04WezyPjRERp=xfxv34j5fA8cDQ_JudA@mail.gmail.com>
Subject: Re: [PATCH v4 00/40] lib/find: add atomic find_bit() primitives
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	"H. Peter Anvin" <hpa@zytor.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
	Akinobu Mita <akinobu.mita@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bjorn Andersson <andersson@kernel.org>, Borislav Petkov <bp@alien8.de>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Christian Brauner <brauner@kernel.org>, Damien Le Moal <damien.lemoal@opensource.wdc.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Disseldorp <ddiss@suse.de>, 
	Edward Cree <ecree.xilinx@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gregory Greenman <gregory.greenman@intel.com>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Hans de Goede <hdegoede@redhat.com>, 
	Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>, 
	Jiri Pirko <jiri@resnulli.us>, Jiri Slaby <jirislaby@kernel.org>, Kalle Valo <kvalo@kernel.org>, 
	Karsten Graul <kgraul@linux.ibm.com>, Karsten Keil <isdn@linux-pingi.de>, 
	Kees Cook <keescook@chromium.org>, Leon Romanovsky <leon@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Martin Habets <habetsm.xilinx@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, 
	Nicholas Piggin <npiggin@gmail.com>, Oliver Neukum <oneukum@suse.com>, Paolo Abeni <pabeni@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ping-Ke Shih <pkshih@realtek.com>, Rich Felker <dalias@libc.org>, Rob Herring <robh@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Sean Christopherson <seanjc@google.com>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, Stanislaw Gruszka <stf_xl@wp.pl>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Valentin Schneider <vschneid@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Will Deacon <will@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	GR-QLogic-Storage-Upstream@marvell.com, alsa-devel@alsa-project.org, 
	ath10k@lists.infradead.org, dmaengine@vger.kernel.org, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-media@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-net-drivers@amd.com, 
	linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	mpi3mr-linuxdrv.pdl@broadcom.com, netdev@vger.kernel.org, 
	sparclinux@vger.kernel.org, x86@kernel.org, 
	Alexey Klimov <alexey.klimov@linaro.org>, Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Shtylyov <s.shtylyov@omp.ru>
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Jun 2024 at 11:32, Yury Norov <yury.norov@gmail.com> wrote:
>
> Is that in master already? I didn't get any email, and I can't find
> anything related in the master branch.

It's 5d272dd1b343 ("cpumask: limit FORCE_NR_CPUS to just the UP case").

> > New rule: before you send some optimization, you need to have NUMBERS.
>
> I tried to underline that it's not a performance optimization at my
> best.

If it's not about performance, then it damn well shouldn't be 90%
inline functions in a header file.

If it's a helper function, it needs to be a real function elsewhere. Not this:

 include/linux/find_atomic.h                  | 324 +++++++++++++++++++

because either performance really matters, in which case you need to
show profiles, or performance doesn't matter, in which case it damn
well shouldn't have special cases for small bitsets that double the
size of the code.

              Linus
