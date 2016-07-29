Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 29 Jul 2016 09:42:03 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] tools: Fix recevied/received typos
In-Reply-To: <CABBYNZ+_rMYB_mRhC2+wxytv=O=K3BNcK05yZooGrAQA=4ZpEA@mail.gmail.com>
Message-ID: <alpine.OSX.2.20.1607290931410.62393@mjmartin-mac01.local>
References: <20160728162147.29986-1-mathew.j.martineau@linux.intel.com> <CABBYNZ+_rMYB_mRhC2+wxytv=O=K3BNcK05yZooGrAQA=4ZpEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Fri, 29 Jul 2016, Luiz Augusto von Dentz wrote:

> Doesn't apply:
>
> Applying: tools: Fix recevied/received typos
> error: patch failed: tools/ubcsp.c:351
> error: tools/ubcsp.c: patch does not apply
> Patch failed at 0002 tools: Fix recevied/received typos

That's a surprise. Turns out it's an issue with the CRLF line endings in 
ubcsp.c, and there's nothing to be done about it on the git format-patch / 
git send-email side.

Please use 'git am --keep-cr' to apply the patch.

Maybe converting ubscp.{h,c} to Unix line endings is worth it after all. 
What do you think?

--
Mat Martineau
Intel OTC
