Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4AB130C4.5030205@binarywings.net>
References: <6887eb5d0909142301r52343cd3sbe64c106da2d7434@mail.gmail.com>
	 <20090915061104.GA20323@jh-x301> <4AAFBFA6.70007@binarywings.net>
	 <20090915165854.GA6550@jh-x301> <4AB107DE.5070700@binarywings.net>
	 <20090916164104.GA11739@jh-x301> <4AB130C4.5030205@binarywings.net>
Date: Thu, 17 Sep 2009 16:49:22 -0300
Message-ID: <2d5a2c100909171249g24fc2572rf75723f4c4cb7feb@mail.gmail.com>
Subject: Re: PIN Helper
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Florian Philipp <lists@binarywings.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Sep 16, 2009 at 3:39 PM, Florian Philipp <lists@binarywings.net> wrote:
> Well, I'm pretty sure some other guys came up with the exact same
> question which was the start of this thread at various occasions last
> year or so (i.e. wanting to have a simple daemon-like pin helper). From
> your post I read that you acknowledge that this functionality which
> those other guys and me miss in bluez is something you'd like to have
> back in, right?
>
> So, if any solution, maybe heavily based on those two test programs
> would really make it back into upstream and would not be dropped because
> it somehow does not fit in the current design or whatever (that's what
> my original question was because the functionality _was already there_
> in 2.x), then why is the answer to those requests always "Do it
> yourself" and not at least "Do it yourself and maybe send it to us so we
> can merge it into upstream"?
>
> That's exactly what I wanted to know in the first place: Why you would
> not want this functionality in bluez but rather put people requesting it
> down with "Do it yourself (and leave us alone)". At least that was my
> impression.

Actually I think agent.c can be used for what seems to be your use
case, you need a pincode helper which handle pincode requests with a
predefined pincode which is what agent will do if you pass a pincode
e.g. agent 1234. Also you are free to suggest improvements, we are
very happy to accept patches from anyone as you can see from the
commit logs.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
