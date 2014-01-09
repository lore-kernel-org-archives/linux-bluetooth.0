Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1389267956-2297-3-git-send-email-lukasz.rymanowski@tieto.com>
References: <1389267956-2297-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1389267956-2297-3-git-send-email-lukasz.rymanowski@tieto.com>
Date: Thu, 9 Jan 2014 14:14:13 +0200
Message-ID: <CABBYNZ+cVbwPQO-RX6yosU4arkdonVjaB0sAgg0jJbpEbLO=Nw@mail.gmail.com>
Subject: Re: [PATCH 2/4] android/audio: Change mainloop handle in ipc_handler
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Szymon Janc <szymon.janc@tieto.com>,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Thu, Jan 9, 2014 at 1:45 PM, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> Make sure we wait 1 sec  after each loop iteration.
> It is important in case of failure that we do not overload cpu.
>
> ---
>  android/hal-audio.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/android/hal-audio.c b/android/hal-audio.c
> index 7a7c111..4a12bcb 100644
> --- a/android/hal-audio.c
> +++ b/android/hal-audio.c
> @@ -465,15 +465,14 @@ failed:
>
>  static void *ipc_handler(void *data)
>  {
> -       bool done = false;
>         struct pollfd pfd;
> +       bool done;
>
>         DBG("");
>
> -       while (!done) {
> +       for (done = false; !done; sleep(1)) {

This is getting bad really quickly, I did not realize there was a
sleep in it but usually the use of it means we are doing something
wrong which I suspect it has to do with either bind or listen failing
since you are executing them in a loop, in that case I would suggest
to start the listen socket on audio_open and only do the accept in the
thread.



-- 
Luiz Augusto von Dentz
