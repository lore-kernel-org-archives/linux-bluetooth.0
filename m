Return-Path: <cyrus@holtmann.org>
Date: Mon, 9 Nov 2009 11:27:15 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: nirav rabara <niravrabara@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Pair device list query
Message-ID: <20091109092715.GA9047@jh-x301>
References: <912bb79a0911090106o6704e144y72fb9150865bc50d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <912bb79a0911090106o6704e144y72fb9150865bc50d@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Nov 09, 2009, nirav rabara wrote:
> I want to access this paired device list frequently and some time need
> to delete any of the paired device of list.
> According to my understanding bluetoothd will create folder (MAC
> address as name), in that folder one file name linkkeys having the
> detail of all the paired device address with link keys.
> Is this the only way to get paired device list? OR Is there any
> specific data structure in bluez stack code??
> 
> Or if somebody can guide me what should I read for above.

You should use the BlueZ D-Bus API for getting this list. The API
reference can be found in doc/*-api.txt in the source tree. You could
also take a look at existing code that accesses the API. The programs
and scripts under the test subdirectory (e.g. test/list-devices) as well
as the gnome-bluetooth source code would be good places to start from.

Johan
