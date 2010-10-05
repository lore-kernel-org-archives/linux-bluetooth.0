Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Oct 2010 10:20:26 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix use of uninitialised variable on legacy pairing
Message-ID: <20101005082026.GA785@jh-x301>
References: <1286264425-24281-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1286264425-24281-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Oct 05, 2010, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> Regression caused by e7daece858070d71cecf6ade4f0e3c93272c53ac:
> 
> ==23899== Use of uninitialised value of size 4
> ==23899==    at 0x49CD888: _itoa_word (_itoa.c:196)
> ==23899==    by 0x49D1109: vfprintf (vfprintf.c:1613)
> ==23899==    by 0x4A7506C: __vsprintf_chk (vsprintf_chk.c:86)
> ==23899==    by 0x4A74FAC: __sprintf_chk (sprintf_chk.c:33)
> ==23899==    by 0x4830E08: ba2str (stdio2.h:34)
> ==23899==    by 0x1496B3: set_pin_length (security.c:514)
> ==23899==    by 0x168399: pincode_cb (dbus-hci.c:179)
> ==23899==    by 0x162E0D: pincode_cb (device.c:2135)
> ==23899==    by 0x15AD55: pincode_reply (agent.c:416)
> ==23899==    by 0x49467E0: ??? (in /lib/libdbus-1.so.3.5.2)
> ==23899==    by 0x4934975: ??? (in /lib/libdbus-1.so.3.5.2)
> ==23899==    by 0x4937B81: dbus_connection_dispatch (in /lib/libdbus-1.so.3.5.2)
> ==23899==
> ==23899== Conditional jump or move depends on uninitialised value(s)
> ==23899==    at 0x49CD893: _itoa_word (_itoa.c:196)
> ==23899==    by 0x49D1109: vfprintf (vfprintf.c:1613)
> ==23899==    by 0x4A7506C: __vsprintf_chk (vsprintf_chk.c:86)
> ==23899==    by 0x4A74FAC: __sprintf_chk (sprintf_chk.c:33)
> ==23899==    by 0x4830E08: ba2str (stdio2.h:34)
> ==23899==    by 0x1496B3: set_pin_length (security.c:514)
> ==23899==    by 0x168399: pincode_cb (dbus-hci.c:179)
> ==23899==    by 0x162E0D: pincode_cb (device.c:2135)
> ==23899==    by 0x15AD55: pincode_reply (agent.c:416)
> ==23899==    by 0x49467E0: ??? (in /lib/libdbus-1.so.3.5.2)
> ==23899==    by 0x4934975: ??? (in /lib/libdbus-1.so.3.5.2)
> ==23899==    by 0x4937B81: dbus_connection_dispatch (in /lib/libdbus-1.so.3.5.2)
> ---
>  src/dbus-hci.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Thanks for the patch. It's now upstream along with another patch to
clean up the logic in this function. Strange that the compiler didn't
catch this issue. Unfortunately we just made a 4.74 release so I guess
there'll be a 4.75 out soonish.

Johan
