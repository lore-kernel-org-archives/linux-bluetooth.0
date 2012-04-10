Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <05C57A66007544188BE786ECFA833CBA@sisodomain.com>
References: <1332844351-13732-1-git-send-email-jaganath.k@samsung.com>
	<05C57A66007544188BE786ECFA833CBA@sisodomain.com>
Date: Tue, 10 Apr 2012 07:11:59 -0300
Message-ID: <CABBYNZ+vXAmWW-cuEyTAkGa1y7q-zYB=o4Yx_BKfycf161XjiQ@mail.gmail.com>
Subject: Re: [PATCH obexd 1/2] gobex: Introduce g_obex_abort_transfer()
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jaganath <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Wed, Apr 4, 2012 at 2:11 AM, Jaganath <jaganath.k@samsung.com> wrote:
>
> Hi,
>
> --------------------------------------------------
> From: "Jaganath Kanakkassery" <jaganath.k@samsung.com>
> Sent: Tuesday, March 27, 2012 4:02 PM
> To: <linux-bluetooth@vger.kernel.org>
> Cc: "Jaganath Kanakkassery" <jaganath.k@samsung.com>
> Subject: [PATCH obexd 1/2] gobex: Introduce g_obex_abort_transfer()
>
>
>> This function sends the abort request and wait for response before
>> disconnection. This patch fixes the issue ABORT packet not sending
>> when user cancels the transfer.
>> ---
>> gobex/gobex-transfer.c |   22 +++++++++++++++++++++-
>> gobex/gobex.c          |    4 ++--
>> gobex/gobex.h          |    4 ++++
>> 3 files changed, 27 insertions(+), 3 deletions(-)
>>
>
> Any update on this patch please?

g_obex_abort_transfer seems like a good idea, I just did not like the
idea of resetting the callback though because then we cannot tell when
remote has replied which is what Transfer.Cancel should be doing.

Btw, can you please add a unit test for this problem?


-- 
Luiz Augusto von Dentz
