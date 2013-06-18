Return-Path: <cyrus@holtmann.org>
Date: Tue, 18 Jun 2013 13:29:16 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] core: Fix crash when a duplicated record is found
Message-ID: <20130618102916.GA15389@x220>
References: <1371542934-23797-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1371542934-23797-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Jun 18, 2013, Luiz Augusto von Dentz wrote:
>  Invalid read of size 8
>     at 0x470101: update_bredr_services (device.c:2784)
>     by 0x470591: browse_cb (device.c:2975)
>     by 0x458B0E: search_completed_cb (sdp-client.c:186)
>     by 0x47C154: sdp_process (sdp.c:4343)
>     by 0x458954: search_process_cb (sdp-client.c:205)
>     by 0x3F31A47A54: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
>     by 0x3F31A47D87: ??? (in /usr/lib64/libglib-2.0.so.0.3400.2)
>     by 0x3F31A48181: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
>     by 0x40A265: main (main.c:595)
>   Address 0x0 is not stack'd, malloc'd or (recently) free'd
> ---
>  src/device.c | 65 +++++++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 38 insertions(+), 27 deletions(-)

Applied. Thanks.

Johan
