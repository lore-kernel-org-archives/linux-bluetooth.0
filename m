Return-Path: <cyrus@holtmann.org>
Date: Tue, 4 Aug 2009 07:49:28 +0200
From: Artem Makhutov <artem@makhutov.org>
To: Andreas Volz <lists@brachttal.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Adressbook with bluez?
Message-ID: <20090804054928.GC26953@titan.makhutov-it.de>
References: <20090803202404.5d62b6a4@frodo.mittelerde>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090803202404.5d62b6a4@frodo.mittelerde>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

n Mon, Aug 03, 2009 at 08:24:04PM +0200, Andreas Volz wrote:
> Hello,
> 
> I like to read out the address book of my bluetooth phone with bluez. I
> didn't find any info about this.
> 
> Is this possible?
> 
> If not, what is missing in the implementation to get it working?

You need to send special AT-Commands over the rfcomm like to the phone.

Regards, Artem
