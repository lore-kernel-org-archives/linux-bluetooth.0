Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 May 2013 10:09:39 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC BlueZ] AVRCP: Fix crash when no A2DP role is detected
Message-ID: <20130513130939.GA10517@samus.indt.org>
References: <1368341952-5666-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1368341952-5666-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 09:59 Sun 12 May, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Invalid read of size 4
>    at 0x468370: btd_service_connecting_complete (service.c:315)
>    by 0x41B70F: session_ct_init_control (avrcp.c:2790)
>    by 0x41B1E0: state_changed (avrcp.c:2933)
>    by 0x418054: avctp_set_state (avctp.c:548)
>    by 0x41A2E4: avctp_connect_cb (avctp.c:1201)
>    by 0x44F989: accept_cb (btio.c:201)
>    by 0x4E77044: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
>    by 0x4E77377: g_main_context_iterate.isra.24 (in /usr/lib64/libglib-2.0.so.0.3400.2)
>    by 0x4E77771: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
>    by 0x40A8EE: main (main.c:583)
>  Address 0x20 is not stack'd, malloc'd or (recently) free'd
> 
>  If no A2DP is found assume the controller is the initiator.


This patch indeed fixes the crash. Ack.


Cheers,
-- 
Vinicius
