Return-Path: <cyrus@holtmann.org>
Date: Mon, 10 Sep 2012 13:55:57 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv0] Bluetooth: Fix SO_LINGER in L2CAP
Message-ID: <20120910105550.GA2558@aemeltch-MOBL1>
References: <alpine.DEB.2.02.1209070949580.3761@mathewm-linux>
 <1347265388-19759-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CAJdJm_PpSukMH=d1giiN1WKmXAam7s5OQB9-YS1aYwv1rB+84Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_PpSukMH=d1giiN1WKmXAam7s5OQB9-YS1aYwv1rB+84Q@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Mon, Sep 10, 2012 at 06:43:53AM -0400, Anderson Lizardo wrote:
> Hi Andrei,
> 
> On Mon, Sep 10, 2012 at 4:23 AM, Andrei Emeltchenko
> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Could you explain on the commit message what is broken on the current
> code, so we can review the semantics of your changes?

 If we have unacked frames when closing bluetooth socket we deadlock
 since conn->chan_lock, chan->lock and socket lock are taken.

Also see Mat comments.

Best regards 
Andrei Emeltchenko 

