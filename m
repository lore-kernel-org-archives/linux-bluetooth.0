Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKSLy6KYfKd8aBfb5DzG_ofihzVHcm6OBPuBcBne0j88g@mail.gmail.com>
References: <1329813983-26707-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1329813983-26707-2-git-send-email-mikel.astiz.oss@gmail.com>
	<CABBYNZKSLy6KYfKd8aBfb5DzG_ofihzVHcm6OBPuBcBne0j88g@mail.gmail.com>
Date: Tue, 21 Feb 2012 13:16:04 +0200
Message-ID: <CABBYNZ+kP5f1hxZiDhmZiqEVtWGc7myZVD-hN5EpX23E0TP0_w@mail.gmail.com>
Subject: Re: [PATCH obexd 1/9] gobex: fix callback remove when canceling transfer
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Feb 21, 2012 at 1:02 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Mikel,
>
> On Tue, Feb 21, 2012 at 10:46 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
>> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>>
>> This code path could lead to situations where the callback is later
>> used, making the daemon crash.
>> ---
>>  gobex/gobex.c |    3 +++
>>  1 files changed, 3 insertions(+), 0 deletions(-)
>>
>> diff --git a/gobex/gobex.c b/gobex/gobex.c
>> index 0665749..bc76e57 100644
>> --- a/gobex/gobex.c
>> +++ b/gobex/gobex.c
>> @@ -735,6 +735,9 @@ gboolean g_obex_cancel_req(GObex *obex, guint req_id, gboolean remove_callback)
>>                        goto immediate_completion;
>>                }
>>
>> +               if (remove_callback)
>> +                       obex->pending_req->rsp_func = NULL;
>> +
>
> I see the problem, so we are keeping the pending request because of
> the abort response, Im just not sure why we need to report an error if
> cancelled is set on handle_response. So perhaps the right place to fix
> this is in handle_response as soon as it checks for cancelled it
> should skip to the point it frees the pending call, in other words we
> should never need to report G_OBEX_ERROR_CANCELLED for requests since
> we are the ones cancelling them.

Actually this is correct, since when remove_callback is FALSE we still
call the callback so G_OBEX_ERROR_CANCELLED makes sense.

Ack.

-- 
Luiz Augusto von Dentz
