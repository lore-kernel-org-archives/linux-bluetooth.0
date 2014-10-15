Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Oct 2014 16:55:40 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Nathan Jozwiak <njozwiak@mlsw.biz>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: GATT Notification not sending
Message-ID: <20141015145540.GA28120@t440s.fdxtended.com>
References: <543D474D.1040700@mlsw.biz>
 <543D5645.7090403@mlsw.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <543D5645.7090403@mlsw.biz>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nathan,

On Tue, Oct 14, 2014, Nathan Jozwiak wrote:
> Update: I downloaded the LightBlue app from the Apple Store. The app allows
> you to connect to a GATT server and select available services to interact
> with. My notification characteristic showed up properly with an initial
> value of 0x00 and a CCC value of 0. But when attempted to register with the
> notification I saw this error from my bluetoothd output:
> 
> bluetoothd[8754]: Refusing storage path for private addressed device
> /org/bluez/hci0/dev_59_F2_63_47_1D_90
> bluetoothd[8754]: Unable to get ccc storage path for device
> bluetoothd[8754]: attrib/gattrib.c:g_attrib_ref() 0xa073bd8: ref=3
> bluetoothd[8754]: attrib/gattrib.c:g_attrib_unref() 0xa073bd8: ref=2
> 
> Unfortunately, I do not know the command LightBlue was sending to set the
> CCC, but I figured this might be a clue for someone.

Unfortunately this isn't related to your main issue. It just means that
you're running a kernel version that doesn't support LE Privacy. Because
of this the kernel has not been able to notify user space of the
Identity Address of the remote device so that information about it could
be stored persistently (iOS is one of the few implementations out there
actively using Random Private Addresses).

Johan
