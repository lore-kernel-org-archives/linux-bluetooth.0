Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20090312111123.2763cd79@symphony>
References: <20090308232215.727f38fa@symphony>
	 <20090312111123.2763cd79@symphony>
Date: Thu, 12 Mar 2009 11:23:40 -0300
Message-ID: <2d5a2c100903120723m5ce4a0fcp59d5de8a09aa6242@mail.gmail.com>
Subject: Re: PANU currently broken?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: James Le Cuirot <chewi@aura-online.co.uk>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi James,

On Thu, Mar 12, 2009 at 8:11 AM, James Le Cuirot
<chewi@aura-online.co.uk> wrote:
> On Sun, 8 Mar 2009 23:22:15 +0000
> James Le Cuirot <chewi@aura-online.co.uk> wrote:
>
>> I've managed to serve my phone with NAP successfully but using PANU in
>> the other direction has not worked at all.
>
> I'm not necessarily asking for an immediate fix here but could someone
> at least explain the situation? That might allow me to fix it myself.

I have a fix for it, the problem was that we use
g_io_channel_set_close_on_unref on BtIO code so we should maintain a
reference if we want to maintain the socket open.

Try this patch and see if it helps:
http://gitorious.org/projects/bluez/repos/vudentzs-clone/commits/adaf1c1d4f2c8764c3d5336759368a0e1dcb44c9

ps: we are still reviewing the code so it may have some bug left.


-- 
Luiz Augusto von Dentz
Engenheiro de Computação
