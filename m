Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Jun 2009 18:38:52 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Petr Lautrbach <plautrba@redhat.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add on demand functionality to bluetooth init script
Message-ID: <20090605153852.GA29262@jh-x301>
References: <4A27DFBE.407@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4A27DFBE.407@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Petr,

On Thu, Jun 04, 2009, Petr Lautrbach wrote:
> This patch adds on demand functionality for bluetooth service based on
> udev events.  It's adapted from Fedora [1].
>
> Idea is that bluetoothd doesn't need to be running unless the user
> actually has a bluetooth device.

The patch looks good to me (though my udev knowledge is rather limited).
However, I'd like to get a second opinion from Marcel before pushing
upstream.

Johan
