Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Feb 2014 15:31:13 +0800
From: Adam Lee <adam8157@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] core: retry connect_dbus() several times
Message-ID: <20140228073113.GA3771@adam-laptop>
References: <1393571362-27898-1-git-send-email-adam8157@gmail.com>
 <04802ECE-6B8D-4DF4-BFFD-EABBD42BD30F@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <04802ECE-6B8D-4DF4-BFFD-EABBD42BD30F@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Feb 27, 2014 at 11:15:01PM -0800, Marcel Holtmann wrote:
> Hi Adadm,
> 
> > Sometimes the hardware, especially which needs firmware patching, is not
> > yet ready when connect_dbus().
> 
> this makes no sense. Connecting to D-Bus has nothing to do with
> firmware patching. What are you exactly fixing here?

connect_dbus() fails sometimes with Intel 7260 bluetooth, sleeping 0.5s
before executing bluetoothd workarounds it. I assume the firmware
patching slows down hardware initialization then fails to connect.

Any other possibility? I'm not a D-Bus guru :)

-- 
Adam Lee
http://adam8157.info
