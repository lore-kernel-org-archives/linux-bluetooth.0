Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Feb 2013 15:23:25 -0600
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] AVDTP: Fix memory leak
Message-ID: <20130201212325.GA1258@x220.aaadfw.dal.wayport.net>
References: <1359742844-4612-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1359742844-4612-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Feb 01, 2013, Luiz Augusto von Dentz wrote:
> 56 (16 direct, 40 indirect) bytes in 1 blocks are definitely lost in loss record 173 of 263
>    at 0x4A0883C: malloc (vg_replace_malloc.c:270)
>    by 0x4C8568E: g_malloc (in /usr/lib64/libglib-2.0.so.0.3400.2)
>    by 0x4C9A7F1: g_slice_alloc (in /usr/lib64/libglib-2.0.so.0.3400.2)
>    by 0x4C9BB92: g_slist_append (in /usr/lib64/libglib-2.0.so.0.3400.2)
>    by 0x422072: send_req (avdtp.c:2569)
>    by 0x422D0B: avdtp_discover (avdtp.c:3380)
>    by 0x41D16C: source_setup_stream (source.c:307)
>    by 0x41D1EF: source_connect (source.c:331)
>    by 0x465411: connect_next (device.c:1073)
>    by 0x466C92: device_profile_connected (device.c:1097)
>    by 0x4629EB: ext_connect (profile.c:950)
>    by 0x44AECB: connect_cb (btio.c:230)
> ---
>  profiles/audio/avdtp.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Applied. Thanks.

Johan
