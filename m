Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4D740AA7.5080209@interlinx.bc.ca>
References: <4D6EF7ED.2090905@interlinx.bc.ca>
	<4D740AA7.5080209@interlinx.bc.ca>
Date: Sun, 6 Mar 2011 18:08:40 -0700
Message-ID: <AANLkTin3-+9txbUyFxyrirySnkjwWVeMHrZtCqGfz-4m@mail.gmail.com>
Subject: Re: how to set adapter to master with bluez 4.69?
From: Brad Midgley <bmidgley@gmail.com>
To: "Brian J. Murrell" <brian@whamcloud.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Brian,

> Nobody knows?  I was hoping this was going to be one of those simple
> questions that just about everybody knew.  :-(

It has been really quiet.

I got the latest bluez and looked through doc/ and test/ for
references to link mode. I think maybe mentions of L2CAP_LM_MASTER in
test/l2test.c might be on the right track. You could probably follow
that model and set the l2cap link mode to get what you want. I didn't
see it in any gui I could find. A patch to a gui would be ambitious
but would end up being the nicest user experience in the end.

-- 
Brad Midgley
