Return-Path: <cyrus@holtmann.org>
Date: Mon, 2 Jun 2014 18:30:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] monitor: Fix crash when parsing SDP
Message-ID: <20140602153007.GA15058@t440s.P-661HNU-F1>
References: <1401719591-5503-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1401719591-5503-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Jun 02, 2014, Szymon Janc wrote:
> get_tid() may return NULL if bogus tid is passed.
> This fix following crash:
> 
> Invalid write of size 1
>    at 0x4A0A643: memcpy@@GLIBC_2.14 (in /usr/lib64/valgrind/
>      vgpreload_memcheck-amd64-linux.so)
>    by 0x4218E4: search_attr_req (sdp.c:413)
>    by 0x42214D: sdp_packet (sdp.c:748)
>    by 0x41ED09: l2cap_frame (l2cap.c:2632)
>    by 0x414D51: packet_hci_acldata (packet.c:7713)
>    by 0x415133: packet_monitor (packet.c:3332)
>    by 0x404AEC: control_reader (control.c:911)
>    by 0x40231A: main (main.c:197)
>  Address 0x6 is not stack'd, malloc'd or (recently) free'd
> 
> Process terminating with default action of signal 11 (SIGSEGV)
>  Access not within mapped region at address 0x6
>    at 0x4A0A643: memcpy@@GLIBC_2.14 (in /usr/lib64/valgrind/
>      vgpreload_memcheck-amd64-linux.so)
>    by 0x4218E4: search_attr_req (sdp.c:413)
>    by 0x42214D: sdp_packet (sdp.c:748)
>    by 0x41ED09: l2cap_frame (l2cap.c:2632)
>    by 0x414D51: packet_hci_acldata (packet.c:7713)
>    by 0x415133: packet_monitor (packet.c:3332)
>    by 0x404AEC: control_reader (control.c:911)
>    by 0x40231A: main (main.c:197)
> ---
>  monitor/sdp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied. Thanks.

Johan
