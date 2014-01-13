Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 Jan 2014 10:27:24 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: marcel@holtmann.org, gustavo@padovan.org, yongjun_wei@trendmicro.com.cn,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH -next] Bluetooth: Convert to use ATTRIBUTE_GROUPS macro
Message-ID: <20140113082724.GA27885@x220.p-661hnu-f1>
References: <CAPgLHd9XikeBP3moVKugtsAD83CD1HqE82KeYOyYNdY+=0vctQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPgLHd9XikeBP3moVKugtsAD83CD1HqE82KeYOyYNdY+=0vctQ@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jan 07, 2014, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Use ATTRIBUTE_GROUPS macro to reduce the number of lines of code.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  net/bluetooth/hci_sysfs.c | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)

Applied to the bluetooth-next tree. Thanks.

Johan
