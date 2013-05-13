Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 May 2013 13:55:13 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC BlueZ] AVRCP: Fix crash when no A2DP role is detected
Message-ID: <20130513165512.GB10517@samus.indt.org>
References: <1368341952-5666-1-git-send-email-luiz.dentz@gmail.com>
 <20130513130939.GA10517@samus.indt.org>
 <CABBYNZ+00O1cZbzwW0_J8U4tmEu=vKgj5Z40JVo=-QiBkJBwGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZ+00O1cZbzwW0_J8U4tmEu=vKgj5Z40JVo=-QiBkJBwGA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 18:02 Mon 13 May, Luiz Augusto von Dentz wrote:
> Hi Vinicius,
> 
> On Mon, May 13, 2013 at 4:09 PM, Vinicius Costa Gomes
> <vinicius.gomes@openbossa.org> wrote:
> > Hi Luiz,
> >
> > On 09:59 Sun 12 May, Luiz Augusto von Dentz wrote:
> >> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >>
> >> Invalid read of size 4
> >>    at 0x468370: btd_service_connecting_complete (service.c:315)
> >>    by 0x41B70F: session_ct_init_control (avrcp.c:2790)
> >>    by 0x41B1E0: state_changed (avrcp.c:2933)
> >>    by 0x418054: avctp_set_state (avctp.c:548)
> >>    by 0x41A2E4: avctp_connect_cb (avctp.c:1201)
> >>    by 0x44F989: accept_cb (btio.c:201)
> >>    by 0x4E77044: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
> >>    by 0x4E77377: g_main_context_iterate.isra.24 (in /usr/lib64/libglib-2.0.so.0.3400.2)
> >>    by 0x4E77771: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
> >>    by 0x40A8EE: main (main.c:583)
> >>  Address 0x20 is not stack'd, malloc'd or (recently) free'd
> >>
> >>  If no A2DP is found assume the controller is the initiator.
> >
> >
> > This patch indeed fixes the crash. Ack.
> 
> We were discussing about this problem offline, it doesn't seems very
> clear how we end up with control being NULL like this and it is
> desirable to have such information in the description because perhaps
> we are fixing this in the wrong place after all. Can you explain how
> exactly you managed to reproduced the problem?

The issue is not that control is NULL. 'btd_sevice_connecting_complete()' gets
called from profiles/audio/control.c:73 with control->target being NULL. The
interesting point is that control->remote is valid. This makes the point that
the wrong function may be set to session->init_control(). Which brings the
question "how?". Seems that in my case (BlueZ vs. BlueZ) with no A2DP Endpoint
registered (dev->sink and dev->source are NULL), the wrong AVRCP role gets
selected around profiles/audio/avrcp.c:2873 .

Your patch makes this role selection find the correct one.

> 
> 
> --
> Luiz Augusto von Dentz


Cheers,
-- 
Vinicius
