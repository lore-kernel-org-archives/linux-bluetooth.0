Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4963980.578001331189664043.JavaMail.weblogic@epml07>
References: <4963980.578001331189664043.JavaMail.weblogic@epml07>
Date: Thu, 8 Mar 2012 14:28:32 +0200
Message-ID: <CABBYNZJut6tNv6Eq66sM1xToD=tT63Q6qT+Bcg1aFcwmc=Dc0Q@mail.gmail.com>
Subject: Re: [PATCH obexd] gobex: call g_obex_unref() before io channel unref
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: jaganath.k@samsung.com
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Thu, Mar 8, 2012 at 8:54 AM, JAGANATH KANAKKASSERY
<jaganath.k@samsung.com> wrote:
>
> Hi
>
> ------- Original Message -------
> Sender : JAGANATH KANAKKASSERY<jaganath.k@samsung.com>  Lead Engineer/SISO-Linux Platform Lab/Samsung Electronics
> Date   : Mar 08, 2012 15:48 (GMT+09:00)
> Title  : [PATCH obexd] gobex: call g_obex_unref() before io channel unref
>
> In g_obex_unref, tx_queue will be flushed which results in SIGPIPE
> in g_io_channel_write_chars() since socket is already closed in
> io channel unref.
>
> Please ignore this patch

I guess if the io is closed you don't need to flush anything, in the
other hand it would be good to add a test that does what PTS expect
with abort being sent.


-- 
Luiz Augusto von Dentz
