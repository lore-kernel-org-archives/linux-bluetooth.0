Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 May 2012 10:31:39 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Paulo Alcantara <paulo.alcantara@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] agent: Fix segmentation fault
Message-ID: <20120530073139.GA6539@x220>
References: <1338330726-11517-1-git-send-email-paulo.alcantara@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338330726-11517-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Paulo,

On Tue, May 29, 2012, Paulo Alcantara wrote:
> This patch fixes a segmentation fault when the agent leaves the bus
> and there is a request passkey pending.
> 
> bluetoothd[3137]: src/agent.c:agent_exited() Agent exited without
> calling Unregister
> ==3137== Invalid read of size 8
> ==3137==    at 0x4489E7: device_get_adapter (device.c:2197)
> ==3137==    by 0x448C69: passkey_cb (device.c:2757)
> ==3137==    by 0x43FA47: agent_free (agent.c:168)
> ==3137==    by 0x40A738: service_filter (watch.c:477)
> ==3137==    by 0x40A450: message_filter (watch.c:527)
> ==3137==    by 0x516451B: dbus_connection_dispatch (in
> /usr/lib64/libdbus-1.so.3.5.8)
> ==3137==    by 0x409387: message_dispatch (mainloop.c:76)
> ==3137==    by 0x4E7986A: g_timeout_dispatch (in
> /usr/lib64/libglib-2.0.so.0.3000.2)
> ==3137==    by 0x4E78091: g_main_context_dispatch (in
> /usr/lib64/libglib-2.0.so.0.3000.2)
> ==3137==    by 0x4E78887: g_main_context_iterate.clone.6 (in
> /usr/lib64/libglib-2.0.so.0.3000.2)
> ==3137==    by 0x4E78DD9: g_main_loop_run (in
> /usr/lib64/libglib-2.0.so.0.3000.2)
> ==3137==    by 0x431AA6: main (main.c:542)
> ==3137==  Address 0xe818247c89102594 is not stack'd, malloc'd or
> (recently) free'd
> ---
>  src/agent.c |    5 +++++
>  1 file changed, 5 insertions(+)

Applied. Thanks.

Johan
