Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Subject: Re: [PATCH] Bluetooth: Fix not clearing ack timer when sending an i-frame
Date: Tue, 7 Feb 2012 13:02:59 +0100
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1328539133-26410-1-git-send-email-luiz.dentz@gmail.com> <201202071221.51920.szymon.janc@tieto.com>  <CAA37ikZSaELhgHmU53jYA==B-11PPiAxVnKxuEjHQMaQiddZCw@mail.gmail.com>
In-Reply-To: <CAA37ikZSaELhgHmU53jYA==B-11PPiAxVnKxuEjHQMaQiddZCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-ID: <201202071302.59506.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> >> But that means we would be clearing ack timer even for retransmit
> >> frames which Im not sure can be account as an ack?
> >
> > Right, only pending I-frame(s) is an acknowledgement. But that means
> > __l2cap_send_ack() is broken.
> 
> Yes, it is broken because it was relying on l2cap_ertm_send()
> returning if it sent any i-frame with an ack. And that wasn't
> documented anywhere AFAIK and it's very easy for someone else to add a
> change that breaks this assumption.

We can add comment for that. Yet, this is what I assumed when looked at that
code in first place, that it returns number of pending frames sent..

> 
> > To fix that, I think l2cap_ertm_send should return number of pending I-frames
> > transmitted, not a total number of I-frames sent.
> 
> Why? Have you checked if other part of the code relies on
> l2cap_ertm_send() returning number of I-frames sent?

Yes, it looks like only __l2cap_send_ack() is interested if any frames were sent.
l2cap_chan_send is only interested if error occurred or not. Others just ignore
return value.

> 
> > I've quickly looked over the code and that change should be OK.
> >
> > What do you think?
> 
> I've already answered in my other e-mail. I'd like to see us tracking
> what we already acked and then easily check if we need to send an ack
> or not.

Well, if ack timer is running we have sth to ack. Isn't that enough?

-- 
BR
Szymon Janc
