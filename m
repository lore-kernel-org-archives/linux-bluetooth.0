Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1343311869-5179-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1343311869-5179-1-git-send-email-claudio.takahasi@openbossa.org>
Date: Thu, 26 Jul 2012 11:25:13 -0400
Message-ID: <CAJdJm_M_hWV2fT2C13a5ii+pwN0VRe7+C3aNYn0ngUP0qfmFtg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v0 1/2] btio: Replace g_set_error by ERROR_FAILED macro
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Jul 26, 2012 at 10:11 AM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> This patch replaces the calls of g_set_error function by the local
> defined macro "ERROR_FAILED".
> ---
>  btio/btio.c |   19 +++++++------------
>  1 files changed, 7 insertions(+), 12 deletions(-)

I'm not sure replacing every g_set_error() occurrence by
ERROR_FAILED() is a good idea (some will show errors like "Server
L2CAP RAW sockets not supported: Invalid argument (22)"), but it is a
minor problem so the patch is fine for me.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
