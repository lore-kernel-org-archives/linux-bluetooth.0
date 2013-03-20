Return-Path: <cyrus@holtmann.org>
Date: Wed, 20 Mar 2013 14:19:12 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, Dean_Jenkins@mentor.com,
	andrei.emeltchenko@intel.com, s.syam@samsung.com,
	yongjun_wei@trendmicro.com.cn, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH -next] Bluetooth: fix error return code in
 rfcomm_add_listener()
Message-ID: <20130320171912.GB7522@joana>
References: <CAPgLHd-SvkWV9frakmbbzc1v6n_nEW+f8afUVLxMF1-=GVSyTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPgLHd-SvkWV9frakmbbzc1v6n_nEW+f8afUVLxMF1-=GVSyTw@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Wei,

* Wei Yongjun <weiyj.lk@gmail.com> [2013-03-20 20:23:37 +0800]:

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Fix to return a negative error code from the error handling
> case instead of 0, as returned elsewhere in this function.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  net/bluetooth/rfcomm/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
