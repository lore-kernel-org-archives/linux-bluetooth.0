Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Mon, 29 Nov 2010 23:09:39 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: [RFC 2/4] Bluetooth: clean up rfcomm code
Message-ID: <20101130010939.GB5919@vigoh>
References: <1290784965-4508-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1290784965-4508-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290784965-4508-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2010-11-26 17:22:43 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> 
> Remove extra spaces, assignments in if statement, zeroing static
> variables.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> ---
>  include/net/bluetooth/rfcomm.h |   18 +++++++++---------
>  net/bluetooth/rfcomm/core.c    |    8 ++++----
>  net/bluetooth/rfcomm/sock.c    |    5 +++--
>  net/bluetooth/rfcomm/tty.c     |   28 ++++++++++++++++------------
>  4 files changed, 32 insertions(+), 27 deletions(-)
> 
> diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
> index 71047bc..6eac4a7 100644
> --- a/include/net/bluetooth/rfcomm.h
> +++ b/include/net/bluetooth/rfcomm.h
> @@ -1,5 +1,5 @@
> -/* 
> -   RFCOMM implementation for Linux Bluetooth stack (BlueZ).
> +/*
> +   RFCOMM implementation for Linux Bluetooth stack (BlueZ)
>     Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
>     Copyright (C) 2002 Marcel Holtmann <marcel@holtmann.org>
>  
> @@ -11,13 +11,13 @@
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
>     IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES 
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN 
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF 
> +   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES
> +   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> +   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
>     OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
>  
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS, 
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS 
> +   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> +   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
>     SOFTWARE IS DISCLAIMED.

Marcel refused a patch from me in the past because its was touching legal
stuff, so or you remove these changes for your patches or wait for
Marcel's comments here.

-- 
Gustavo F. Padovan
http://profusion.mobi
