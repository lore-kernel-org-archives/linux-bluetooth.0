Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: BUG: Unable to add a second characteristic (after adding a descriptor)
From: Dan Kunin <dkunin@ninuksoftware.com>
In-Reply-To: <CABBYNZ+XV7u-Xm-A8UhdnD1AzPxnpdJ-AEw4ZULBrZ9C1aY7fw@mail.gmail.com>
Date: Mon, 13 Apr 2015 11:58:18 -0400
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <CA026D85-CC21-4907-9827-C4E7FBD06451@ninuksoftware.com>
References: <12D8720A-944B-4266-9097-2813F7239A6C@ninuksoftware.com> <FDBF022C-4A53-4B7F-BD7F-35E13FC6F021@ninuksoftware.com> <CABBYNZ+XV7u-Xm-A8UhdnD1AzPxnpdJ-AEw4ZULBrZ9C1aY7fw@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey Luiz,

The issue is surrounding multiple characteristics per service once adding a descriptor, not adding multiple services, which works fine.  If you comment out the descriptors for the characteristics of the service, you can then successfully add multiple characteristics.

Dan

> On Apr 13, 2015, at 8:22 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> 
> Hi Dan,
> 
> On Sun, Apr 12, 2015 at 11:59 PM, Dan Kunin <dkunin@ninuksoftware.com> wrote:
>> Found a problem while using the new GATT DBUS API.
>> 
>> After adding a descriptor to a characteristic, one can not add another characteristic to the service. bluetoothd hangs with no error output.  Once you remove the descriptor(s), you can add more characteristics.
> 
> Thanks for the report, we don't actually support multiple services per
> RegisterService, but nevertheless it should not cause a endless loop
> so I sent a fix for that. That said we may actually need to support at
> least included services or at least add some means to references other
> services already registered.
> 
> Btw, your script is outdated, the latest one actually register
> multiple services:
> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/test/example-gatt-server
> 
> -- 
> Luiz Augusto von Dentz

