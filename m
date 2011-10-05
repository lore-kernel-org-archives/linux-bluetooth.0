Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Oct 2011 17:10:25 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Fix crash when remote connects to AVRCP without
 having a record
Message-ID: <20111005141025.GB1370@fusion.localdomain>
References: <1317824690-7710-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1317824690-7710-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Oct 05, 2011, Luiz Augusto von Dentz wrote:
> Device object may exist but control wont be initialized causing the
> following crash:
> 
> Invalid read of size 8
>    at 0x12B510: state_changed (control.c:90)
>    by 0x12BA20: avctp_set_state (avctp.c:367)
>    by 0x12C0DC: avctp_confirm_cb (avctp.c:733)
>    by 0x166481: server_cb (btio.c:200)
>    by 0x4E75ADC: g_main_context_dispatch (in /lib64/libglib-2.0.so.0.3000.0)
>    by 0x4E762D7: ??? (in /lib64/libglib-2.0.so.0.3000.0)
>    by 0x4E76824: g_main_loop_run (in /lib64/libglib-2.0.so.0.3000.0)
>    by 0x11ED19: main (main.c:473)
>  Address 0x8 is not stack'd, malloc'd or (recently) free'd
> ---
>  audio/avctp.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)

Applied. Thanks.

Johan
