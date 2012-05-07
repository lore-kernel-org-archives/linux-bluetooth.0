Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 May 2012 11:14:13 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: David Miller <davem@davemloft.net>
Cc: dh.herrmann@googlemail.com, gustavo@padovan.org,
	linville@tuxdriver.com, linux-bluetooth@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix coding style
Message-ID: <20120507081411.GA19002@aemeltch-MOBL1>
References: <1336157988-4602-1-git-send-email-gustavo@padovan.org>
 <20120506.123656.1335354317428258137.davem@davemloft.net>
 <CANq1E4TTfDxZPsOqqWUT7PqTKUr8nCTC-wo=iGe_pxoUmnecgQ@mail.gmail.com>
 <20120506.145304.1998242927519675381.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120506.145304.1998242927519675381.davem@davemloft.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Sun, May 06, 2012 at 02:53:04PM -0400, David Miller wrote:
> From: David Herrmann <dh.herrmann@googlemail.com>
> Date: Sun, 6 May 2012 19:46:46 +0200
> 
> > Whose rules are they?
> 
> Find me an example in another major core subsystem, let's use
> mm/memory.c as an example as that file gets hit by a lot of people,
> that uses the multi-line conditional TAB-only crap you guys seem to
> keep using.

If you think that Documentation/CodingStyle is a crap why don't you send a
patch to fix it?

> They don't.  All the examples you'll find are of the form:
> 
> 	if (a &&
> 	    b)
> 
> not:
> 
> 	if (a &&
> 			b)

Actually it does not look like this, otherwise "b" would be placed in the
same line, don't it?

Best regards 
Andrei Emeltchenko 

