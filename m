Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 26 Apr 2017 22:07:28 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Barry Byford <31baz66@gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Subject: Re: Serial Port connection with DBus API
Message-ID: <20170426190728.GA14369@x1c>
References: <CAAu3APbw0JyPfKUi6PZ4Nr2Uh5WXtDprDVFBTj3xr+801b9L6w@mail.gmail.com>
 <CAAu3APbMKQY2dnD=TUAb_3BqFKk0s2bzuFFLX8=h-1g7gm8G=Q@mail.gmail.com>
 <20170408071834.GA12144@x1c>
 <CAAu3APahskA_b2Ydt8TzUWBQnkuC10UwjZ37RaOyhAt4s1iyiQ@mail.gmail.com>
 <20170422052644.GA31652@x1c>
 <CAAu3APZxRDoZhCU7QtWVNd05HbKzadoX=886r_REiebvmMj6vQ@mail.gmail.com>
 <CAAu3APYz+fP-f2S3XqV1EJLs4d=4-URTMG-bffNZmZNFQE+ROQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAAu3APYz+fP-f2S3XqV1EJLs4d=4-URTMG-bffNZmZNFQE+ROQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Barry,

On Tue, Apr 25, 2017, Barry Byford wrote:
> I don't feel I'm making progress on this so I've attached the output
> from btmon in the hope that someone has the time to cast an eye over
> it.
> 
> The values that are received into NewConnection are:
> object device = /org/bluez/hci0/dev_64_BC_0C_F6_22_F8
>  fd = 0
> dict fd_properties = {}
> 
> if I do a os.isatty(fd) then I get returned True
> if I do a os.ttyname(fd) then I get returned /dev/pts/0

Our test/test-profile script does the following:

        def NewConnection(self, path, fd, properties):
                self.fd = fd.take()

Are you doing something similar? Otherwise it looks like file descriptor
passing is somehow broken in your system.

Johan
