Return-Path: <cyrus@holtmann.org>
Date: Sun, 6 Jan 2013 15:09:02 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] gdbus: Fix memory leak on properties_set()
Message-ID: <20130106130902.GA8751@x220.Elisa>
References: <1357433266-31642-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1357433266-31642-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Sat, Jan 05, 2013, Anderson Lizardo wrote:
> The pointer returned by dbus_message_iter_get_signature() must be freed
> with dbus_free().
> 
> Fixes this memory leak:
> 
> ==1857== 16 bytes in 1 blocks are definitely lost in loss record 104 of
> 251
> ==1857==    at 0x402BF52: realloc (in
> /usr/lib/valgrind/vgpreload_memcheck-x86-linux.so)
> ==1857==    by 0x415E286: dbus_realloc (in
> /lib/i386-linux-gnu/libdbus-1.so.3.5.8)
> ==1857==    by 0x415E70B: ??? (in
> /lib/i386-linux-gnu/libdbus-1.so.3.5.8)
> ==1857==    by 0x415F17B: ??? (in
> /lib/i386-linux-gnu/libdbus-1.so.3.5.8)
> ==1857==    by 0x414CB33: dbus_message_iter_get_signature (in
> /lib/i386-linux-gnu/libdbus-1.so.3.5.8)
> ==1857==    by 0x8053239: properties_set (object.c:899)
> ==1857==    by 0x5FFFFF: ???
> ==1857==
> ---
>  gdbus/object.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Applied. Thanks.

Johan
