Return-Path: <cyrus@holtmann.org>
Date: Sat, 16 Oct 2010 20:25:12 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Nathan Holstein <nathan.holstein@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] fix oops in l2cap_connect_req
Message-ID: <20101016232512.GB12187@vigoh>
References: <AANLkTi=CNW1pu-YdvmViqHxfw-_TDzvLkj15Ai_aANWo@mail.gmail.com>
 <20101014213709.GD9250@vigoh>
 <AANLkTi=xxj81e__fH1Bh8KuL_rmHVi0=ia9ELPUMThr-@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTi=xxj81e__fH1Bh8KuL_rmHVi0=ia9ELPUMThr-@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nathan,

* Nathan Holstein <nathan.holstein@gmail.com> [2010-10-15 11:54:02 -0400]:

> In error cases when the ACL is insecure or we fail to allocate a new
> struct sock, we jump to the "response" label.  If so, "sk" will be
> null and the kernel crashes.
> 
> Signed-off-by: Nathan Holstein <nathan.holstein@gmail.com>
> ---
>  net/bluetooth/l2cap.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
