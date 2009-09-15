Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Sep 2009 09:11:04 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Kartikey Parmar <kartikey2781@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: PIN Helper
Message-ID: <20090915061104.GA20323@jh-x301>
References: <6887eb5d0909142301r52343cd3sbe64c106da2d7434@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6887eb5d0909142301r52343cd3sbe64c106da2d7434@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 15, 2009, Kartikey Parmar wrote:
> I have installed bluez-4.52 with linux-2.6.30 on my arm board. I m
> trying to connect to headset but because of unavailability of linkkey
> I can't obtain connection.
> 
> Is there any provision for linkkey generation for pairing in
> bluez-4.52? Any tool available that can be run on arm-linux board? I
> can't go for bluez-gnome else I need to install all its dependencies
> which will add more load in terms of memory.

You could try one of the sample agents that come with BlueZ, i.e.
test/simple-agent or test/agent.c. Or then just write your own agent to
suite your needs.

Johan
