Return-Path: <cyrus@holtmann.org>
Date: Sun, 06 May 2012 14:53:04 -0400 (EDT)
Message-Id: <20120506.145304.1998242927519675381.davem@davemloft.net>
To: dh.herrmann@googlemail.com
Cc: gustavo@padovan.org, linville@tuxdriver.com,
	linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix coding style
From: David Miller <davem@davemloft.net>
In-Reply-To: <CANq1E4TTfDxZPsOqqWUT7PqTKUr8nCTC-wo=iGe_pxoUmnecgQ@mail.gmail.com>
References: <1336157988-4602-1-git-send-email-gustavo@padovan.org>
	<20120506.123656.1335354317428258137.davem@davemloft.net>
	<CANq1E4TTfDxZPsOqqWUT7PqTKUr8nCTC-wo=iGe_pxoUmnecgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: David Herrmann <dh.herrmann@googlemail.com>
Date: Sun, 6 May 2012 19:46:46 +0200

> Whose rules are they?

Find me an example in another major core subsystem, let's use
mm/memory.c as an example as that file gets hit by a lot of people,
that uses the multi-line conditional TAB-only crap you guys seem to
keep using.

They don't.  All the examples you'll find are of the form:

	if (a &&
	    b)

not:

	if (a &&
			b)

like I see happening in bluetooth all the time.

How did you think they figured that out?  Did they read someone's
mind?
