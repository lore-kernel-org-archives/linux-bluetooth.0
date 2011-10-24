Return-Path: <cyrus@holtmann.org>
Message-ID: <4EA56B4D.9040306@monom.org>
Date: Mon, 24 Oct 2011 15:42:37 +0200
From: Daniel Wagner <wagi@monom.org>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [BUG] Invalid file descriptor.
References: <4EA564C1.8070402@monom.org> <CAMOw1v6Ec=GXvp3nZWa0=vALwWguXO3uo_DHqRJMXyV=_htO_w@mail.gmail.com> <4EA566BC.6070204@monom.org> <CABBYNZL_FvdVDk8dH+uNxys=LRXLtWaBo0rKAfJ72dSfokkdgA@mail.gmail.com>
In-Reply-To: <CABBYNZL_FvdVDk8dH+uNxys=LRXLtWaBo0rKAfJ72dSfokkdgA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 10/24/2011 03:36 PM, Luiz Augusto von Dentz wrote:
> Hi Daniel,
>
> On Mon, Oct 24, 2011 at 4:23 PM, Daniel Wagner<wagi@monom.org>  wrote:
>>>
>>> What about the patch?
>>
>> Sure, I will do as soon I have fixed all outstanding ConnMan bugs I found
>> just recently. In other words don't expect very soon this patch :)
>
> Try with this:
>
> diff --git a/audio/manager.c b/audio/manager.c
> index 818451c..3103824 100644
> --- a/audio/manager.c
> +++ b/audio/manager.c
> @@ -607,7 +607,6 @@ static void hf_io_cb(GIOChannel *chan, gpointer data)
>          if (perr<  0) {
>                  DBG("Authorization denied!");
>                  gateway_set_state(device, GATEWAY_STATE_DISCONNECTED);
> -               goto drop;
>          }
>
>          return;
>

Yes, that fixes the error message.

Thanks,
daniel
