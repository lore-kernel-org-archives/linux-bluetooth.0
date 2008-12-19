Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] rfcomm/sock.c: rfcomm_sock_sendmsg() does not return
 error on a connection faulure
From: Marcel Holtmann <marcel@holtmann.org>
To: Victor Shcherbatyuk <Victor.Shcherbatyuk@tomtom.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <C36B5BF556750D4282E3E0FA9ABEE628023B1019@nl-exc-01.intra.local>
References: <C36B5BF556750D4282E3E0FA9ABEE628023B1019@nl-exc-01.intra.local>
Content-Type: text/plain
Date: Fri, 19 Dec 2008 08:00:42 +0100
Message-Id: <1229670042.17082.29.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Victor,

> We noticed a problem, when a connection from the remote device is
> dropper the write() function does not return the error in the user
> space, returning 0 instead - indicating that 0 bytes are sent. We've
> also noticed that with some older kernels it used to work (2.6.13 vs
> 2.6.23-17). The patch fixes the problem.

that is a bug and your patch looks good. However can you use
git-format-patch and sent it again with proper Signed-off-by line for me
to apply.

Regards

Marcel


