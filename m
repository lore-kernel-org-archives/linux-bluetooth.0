Return-Path: <cyrus@holtmann.org>
Date: Thu, 21 Nov 2013 16:44:13 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/ipc: Zero initialize cmsg buffer
Message-ID: <20131121144413.GA31496@x220.p-661hnu-f1>
References: <1385043811-21842-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1385043811-21842-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Nov 21, 2013, Andrei Emeltchenko wrote:
> This fixes valgrind warnings:
> ...
> Syscall param sendmsg(msg.msg_control) points to uninitialised byte(s)
> ...
> ---
>  android/ipc.c | 1 +
>  1 file changed, 1 insertion(+)

Both patches have been applied. Thanks.

Johan
