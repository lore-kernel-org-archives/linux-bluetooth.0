Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101025110908.GB7721@vigoh>
References: <1287714419-13545-1-git-send-email-haijun.liu@atheros.com>
 <1287714419-13545-2-git-send-email-haijun.liu@atheros.com>
 <20101022173411.GB980@vigoh> <AANLkTinbP=N-pTKG1dN9PEPFHSLk9N98cq8aC=dfzav7@mail.gmail.com>
 <20101025110908.GB7721@vigoh>
From: haijun liu <liuhaijun.er@gmail.com>
Date: Tue, 26 Oct 2010 19:50:48 +0800
Message-ID: <AANLkTi=qJunx=jP+E7quEeBSUCSvAryCvkO1MYEdsuv3@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] Bluetooth: Fix system crash bug of no send queue protect
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: Haijun Liu <haijun.liu@atheros.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> sk->sk_send_head is also protected by the socket lock.
>

I thought you mean sk->tx_queue.lock, actually it's sk->sk_lock.slock.

But there could be some paths have not been covered.

> This dump shows that the crash happens for a code that is not mainline
> yet. I can't take a patch that fix a bug for code not in mainline. You
> have to show the bug using mainline code.
>

Yes, it is not mainline code, but this issue could be common issue.

OK, let me try use sk->sk_lock.slock to solve this bug.

-- 
Haijun Liu
