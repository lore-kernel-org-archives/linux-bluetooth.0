Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CALJeEo7qPkUj-Wfea4Vme38=g97uWLL9BXP6igyM1RvQfHJYfg@mail.gmail.com>
References: <CALJeEo7qPkUj-Wfea4Vme38=g97uWLL9BXP6igyM1RvQfHJYfg@mail.gmail.com>
Date: Tue, 28 May 2013 23:11:23 -0700
Message-ID: <CALJeEo7DyFmX4SVjxXMssBP7Z=aNN5KTcnQAQvsfXOLW+rPLhg@mail.gmail.com>
Subject: Re: Automatic pairing
From: Jonathan Nichols <jnichols@alumni.princeton.edu>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Just to follow up ... I didn't quite mean that I wanted to pair with
any device that initiates a pairing.  Ideally, I would like to hard
code a non-trivial pin, so that the linux machine automatically pairs
with any device that knows that pin.

On Tue, May 28, 2013 at 10:57 PM, Jonathan Nichols
<jnichols@alumni.princeton.edu> wrote:
> Hello,
>
>     I want to use bluez to set up a linux machine to automatically
> pair with devices that initiate pairings.  What is the recommended way
> of doing this?  I noticed that there is an autopair.c in bluez 5.5,
> but it isn't clear how to use it.  Is there any example code that
> shows how to use this file?
>
>     Any other suggestions for setting up a linux machine to
> automatically pair with any device that initiates a pairing?
>
> Thanks,
>
> jon
