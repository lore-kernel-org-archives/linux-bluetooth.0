Return-Path: <cyrus@holtmann.org>
Date: Fri, 21 Sep 2012 15:43:23 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Pacho Ramos <pacho@gentoo.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: bluetoothd: Refusing input device connect: Operation already in
 progress (114)
Message-ID: <20120921124323.GA14885@x220>
References: <1347704153.24322.11.camel@belkin4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1347704153.24322.11.camel@belkin4>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sat, Sep 15, 2012, Pacho Ramos wrote:
> Downstream we got the following report:
> https://bugs.gentoo.org/show_bug.cgi?id=431624
> 
> After adding mouse (via Blueman's "Add device" dialog) it works fine
> until sleeping or powering off. After that it fails reconnecting.
> In /var/log/messages appears strings like these:
> 
> Aug 16 15:40:31 user bluetoothd[3222]: Refusing input device connect:
> Operation already in progress (114)
> Aug 16 15:45:13 user bluetoothd[3222]: Refusing input device connect:
> Operation already in progress (114)
> Aug 16 15:45:16 user bluetoothd[3222]: Refusing input device connect:
> Operation already in progress (114)
> Aug 16 15:45:17 user bluetoothd[3222]: Refusing input device connect:
> Operation already in progress (114)
> Aug 16 15:45:19 user bluetoothd[3222]: Refusing input device connect:
> Operation already in progress (114)
> Aug 16 15:47:46 user bluetoothd[3222]: Refusing input device connect:
> Operation already in progress (114)
> 
> Searching, I found this thread that pointed to the culprit, but I
> haven't found what finally occurred with it, if patch was reverted or a
> different fix was pulled in:
> http://www.spinics.net/lists/linux-bluetooth/msg26442.html

This is a different issue but the cause seems to be similar. You don't
need to patch bluetoothd though but just disable the mgmt part by
passing -P mgmtops to bluetoothd. For whatever reason the connection
state isn't cleaned up with mgmt (which shouldn't be dependent on mgmt
to begin with) and the input_device_set_channel function returns
-EALREADY when accepting a connection.

Johan
