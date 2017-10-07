Return-Path: <johan.hedberg@gmail.com>
Date: Sat, 7 Oct 2017 09:45:04 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix compiler warning with selftest duration
 calculation
Message-ID: <20171007064504.GA11714@x1c.home>
References: <20171006184245.5525-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20171006184245.5525-1-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Oct 06, 2017, Marcel Holtmann wrote:
>   CC      net/bluetooth/selftest.o
> net/bluetooth/selftest.c: In function ‘bt_selftest_init’:
> net/bluetooth/selftest.c:246:3: warning: ‘duration’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>    snprintf(test_ecdh_buffer, sizeof(test_ecdh_buffer),
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      "PASS (%llu usecs)\n", duration);
>      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> net/bluetooth/selftest.c:203:21: note: ‘duration’ was declared here
>   unsigned long long duration;
>                      ^~~~~~~~
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/selftest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
