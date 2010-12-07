Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Dec 2010 23:17:41 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Fix possible crash when processing session callback
Message-ID: <20101207211741.GB26977@jh-x301>
References: <1291734061-24408-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291734061-24408-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Dec 07, 2010, Luiz Augusto von Dentz wrote:
> If the callback removes the pending data it cause this:
> 
> ==20639== Invalid read of size 4
> ==20639==    at 0x80553E9: free_pending (session.c:112)
> ==20639==    by 0x8056C83: session_request_reply (session.c:837)
> ==20639==    by 0x412F7E0: ??? (in /lib/libdbus-1.so.3.5.2)
> ==20639==    by 0x411D975: ??? (in /lib/libdbus-1.so.3.5.2)
> ==20639==    by 0x4120B81: dbus_connection_dispatch (in /lib/libdbus-1.so.3.5.2)
> ==20639==    by 0x804C27F: message_dispatch (mainloop.c:80)
> ==20639==    by 0x407EFCB: ??? (in /lib/libglib-2.0.so.0.2600.1)
> ==20639==    by 0x407E854: g_main_context_dispatch (in /lib/libglib-2.0.so.0.2600.1)
> ==20639==    by 0x4082667: ??? (in /lib/libglib-2.0.so.0.2600.1)
> ==20639==    by 0x4082BA6: g_main_loop_run (in /lib/libglib-2.0.so.0.2600.1)
> ==20639==    by 0x8055171: main (main.c:625)
> ==20639==  Address 0x4363c88 is 0 bytes inside a block of size 12 free'd
> ==20639==    at 0x40257ED: free (vg_replace_malloc.c:366)
> ==20639==    by 0x4087485: g_free (in /lib/libglib-2.0.so.0.2600.1)
> ==20639==    by 0x80553FE: free_pending (session.c:115)
> ==20639==    by 0x805543C: agent_free (session.c:127)
> ==20639==    by 0x80566A6: session_free (session.c:149)
> ==20639==    by 0x8056BCA: session_terminate_transfer (session.c:914)
> ==20639==    by 0x8056F61: session_prepare_put (session.c:1397)
> ==20639==    by 0x8056C74: session_request_reply (session.c:835)
> ==20639==    by 0x412F7E0: ??? (in /lib/libdbus-1.so.3.5.2)
> ==20639==    by 0x411D975: ??? (in /lib/libdbus-1.so.3.5.2)
> ==20639==    by 0x4120B81: dbus_connection_dispatch (in /lib/libdbus-1.so.3.5.2)
> ==20639==    by 0x804C27F: message_dispatch (mainloop.c:80)
> 
> To fix this agent->pending is now reset to NULL before calling the
> callback, so even if the session is terminated it won't cause a free to
> pending data, which is fine since it is latter freed on callback return.
> ---
>  client/session.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Patches 1 and 2 have been pushed. For the third one (as we discussed
offline) I'm still waiting for an update to fix the format string
specifier for off_t.

Johan
