Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 3 Aug 2016 16:35:40 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ RESEND] tools: Fix recevied/received typos
In-Reply-To: <20160803233343.23515-1-mathew.j.martineau@linux.intel.com>
Message-ID: <alpine.OSX.2.20.1608031634420.44454@mjmartin-mac01.wa.intel.com>
References: <20160803233343.23515-1-mathew.j.martineau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Wed, 3 Aug 2016, Mat Martineau wrote:

> ---
>
> ubcsp.c is one of the files changed, and it has CRLF line endings. The
> normal git-format-patch, git-send-email, git-am flow does not handle
> CRLF well.
>
> I'm sending using "git send-email --transfer-encoding=quoted-printable"
> in order to make git-am happy. You'll need to make sure your email
> client saves the raw message correctly, and git-am will print whitespace
> warnings even though the patch is applied.

Please ignore this version. v2 is coming up, where I actually use the 
--transfer-encoding option.

--
Mat Martineau
Intel OTC
