Return-Path: <cyrus@holtmann.org>
Message-id: <D57C939B563741B492506B2E83571A55@sisodomain.com>
From: "chethan.tn" <chethan.tn@samsung.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Chethan T N <chethan.tn@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
References: <1325056119-15172-1-git-send-email-chethan.tn@samsung.com>
 <CABBYNZJ-WsWmczvyhpf0b+ndcQsGg++V8exzWdH6td+7ecZgsQ@mail.gmail.com>
In-reply-to: <CABBYNZJ-WsWmczvyhpf0b+ndcQsGg++V8exzWdH6td+7ecZgsQ@mail.gmail.com>
Subject: Re: [PATCH] audio: Increased AVDTP request timeout
Date: Thu, 10 May 2012 11:43:01 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

--------------------------------------------------
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Sent: Wednesday, December 28, 2011 3:10 PM
To: "Chethan T N" <chethan.tn@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] audio: Increased AVDTP request timeout

> Hi Chethan,
>
> On Wed, Dec 28, 2011 at 9:08 AM, Chethan T N <chethan.tn@samsung.com> 
> wrote:
>> Original patch by Chan-yeol Park <chanyeol.park@samsung.com>
>>
>> While the streaming is in progress, the remote headset is capable
>> of buffering audio packets. When it buffered the more audio
>> packets, we are sending the SUSPEND command before initiating
>> sco connection. Some headset is able to process the SUSPEND
>> command only after processing the buffered audio packets, hence
>> the delay in the response. So in this case, increasing the
>> REQ_TIMEOUT from 6 to 10 will solve the issue.
>
> What model does that? This use case is exactly when we need to proceed
> fast to switch profiles because in between there wont be any route to
> the audio and a lot of things can happen during 10 seconds. Now I
> don't know what is going on in the headset side but it seems it should
> be dropping the remaining buffered packets if a call is alerting/SCO
> is needed, in that case it might be better/faster to just drop the
> avdtp connection and reconnect forcing the headset to drop everything.
>
> -- 
> Luiz Augusto von Dentz

As mentioned the issue  in the above mail, I could reproduce the issue with
Samsung SBH650 bluetooth stereo headset. I have pasted the complete log
in the below mentioned link.

http://pastebin.com/UF6KzTDF

After increasing the REQ_TIMEOUT from 6 to 10 the problem got resolved.

However as per you suggestion "drop the avdtp connection and reconnect
forcing the headset to drop everything", which is the right place to 
re-initiate
connection "bluetoothd" or "application"?.

If application need to re-initiate then it should know/understand the reason 
for
disconnection before initiating the re-connection to  the headset.

Thanks and Regards
Chethan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html 

