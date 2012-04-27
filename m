Return-Path: <cyrus@holtmann.org>
Date: Fri, 27 Apr 2012 15:26:49 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mike <puffy.taco@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: TP/SIG/SMG/BI-14-C AVDTP_RECONFIGURE
Message-ID: <20120427122649.GB24847@x220.P-661HNU-F1>
References: <CAB7rCTgjdGhM7bk=R=uPzmuUOL3+MB+ApiJiP8Xkgrvsd=APTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAB7rCTgjdGhM7bk=R=uPzmuUOL3+MB+ApiJiP8Xkgrvsd=APTw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,

On Thu, Apr 26, 2012, Mike wrote:
> Is there a method of passing TP/SIG/SMG/BI-14-C, which needs to send a
> AVDTP_RECONFIGURE command series?  It doesn't appear to be a part of
> avtest.c.  If no one has done it, I'll end up having to write it.

Why don't you just mark AVDTP_Reconfigure as not supported in the PICS
(10/5, an optional feature). BlueZ doesn't support it anyway.

Johan
