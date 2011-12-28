Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1325056119-15172-1-git-send-email-chethan.tn@samsung.com>
References: <1325056119-15172-1-git-send-email-chethan.tn@samsung.com>
Date: Wed, 28 Dec 2011 11:40:40 +0200
Message-ID: <CABBYNZJ-WsWmczvyhpf0b+ndcQsGg++V8exzWdH6td+7ecZgsQ@mail.gmail.com>
Subject: Re: [PATCH] audio: Increased AVDTP request timeout
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Chethan T N <chethan.tn@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chethan,

On Wed, Dec 28, 2011 at 9:08 AM, Chethan T N <chethan.tn@samsung.com> wrote:
> Original patch by Chan-yeol Park <chanyeol.park@samsung.com>
>
> While the streaming is in progress, the remote headset is capable
> of buffering audio packets. When it buffered the more audio
> packets, we are sending the SUSPEND command before initiating
> sco connection. Some headset is able to process the SUSPEND
> command only after processing the buffered audio packets, hence
> the delay in the response. So in this case, increasing the
> REQ_TIMEOUT from 6 to 10 will solve the issue.

What model does that? This use case is exactly when we need to proceed
fast to switch profiles because in between there wont be any route to
the audio and a lot of things can happen during 10 seconds. Now I
don't know what is going on in the headset side but it seems it should
be dropping the remaining buffered packets if a call is alerting/SCO
is needed, in that case it might be better/faster to just drop the
avdtp connection and reconnect forcing the headset to drop everything.

-- 
Luiz Augusto von Dentz
