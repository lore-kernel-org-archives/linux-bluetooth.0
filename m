Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <D2AC6A3B6F5245CE9F4AFAF703A7900F@sisodomain.com>
References: <4963980.578001331189664043.JavaMail.weblogic@epml07>
	<CABBYNZJut6tNv6Eq66sM1xToD=tT63Q6qT+Bcg1aFcwmc=Dc0Q@mail.gmail.com>
	<D2AC6A3B6F5245CE9F4AFAF703A7900F@sisodomain.com>
Date: Thu, 8 Mar 2012 14:52:35 +0200
Message-ID: <CABBYNZLSOoEyasnYU_nfMnnkYUry_UC+b6rCCDUk44XHznkB4A@mail.gmail.com>
Subject: Re: [PATCH obexd] gobex: call g_obex_unref() before io channel unref
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jaganath <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Thu, Mar 8, 2012 at 2:43 PM, Jaganath <jaganath.k@samsung.com> wrote:
> I have raised the the same patch with subject  [PATCH obexd 2/2]. This
> patch is required to pass unit test after applying my first patch
> [PATCH obexd 1/2] gobex: flush tx_queue before disconnection
> Otherwise while trying to access io in g_io_channel_write_chars()
> SIGPIPE is coming which kills the process.

You mean it crashes, anyway we should not attempt to send anything if
the io was closed and we should have a watch for detecting if the
application have closed it, perhaps we should set the io to NULL and
then check for that before flushing it.

-- 
Luiz Augusto von Dentz
