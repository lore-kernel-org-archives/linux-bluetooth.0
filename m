Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAKT1EBevp9_bygG8UNO6fj-nU8_C3HDfjOQBRrhMqJij103tBw@mail.gmail.com>
References: <CAKT1EBevp9_bygG8UNO6fj-nU8_C3HDfjOQBRrhMqJij103tBw@mail.gmail.com>
Date: Tue, 1 Nov 2011 06:56:35 -0400
Message-ID: <CAJdJm_N-8b+FD8LSfeT3zhby5_WL7=-TWSTfAyZukqFDEzEHwA@mail.gmail.com>
Subject: Re: Multiple instances of same characteristics (was: Re: GATT Dbus
 API on BlueZ - attirbute-api.txt modifications)
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: "Tsai, Mike" <miketsai@qca.qualcomm.com>,
	linux-bluetooth@vger.kernel.org,
	Vijaykumar Dadmode <Vijaykumar.Dadmode@csr.com>,
	"Ganir, Chen" <chen.ganir@ti.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,

>> [MT]How can this handle the multiple instances of same characteristics within a single service? The characteristic UUID will not be unique in that case.

In BlueZ GATT services are represented by a D-Bus object path, in the format:

<device-path>/service<handle1>/characteristic<handle2>

Where <device-path> is a path specific to a device connected to a
adapter (there can be multiple adapters on the same host), and
<handle1>/<handle2> are attribute handles for the service and
characteristic declarations, respectively.

Example:

/org/bluez/2161/hci0/dev_00_02_5B_00_D5_D0/service0001/characteristic000a

So, even if you have multiple characteristics with same UUID, they
will have different declaration handles, and thus different object
paths in D-Bus.

>> Also, how is the profile specific characteristic descriptor handled?

I think Chen's proposal does not address this. But there was another
proposal sent by Vijaykumar Dadmode on Oct 4th (subject "Proposal for
GATT Client Dbus API") to this list where it was handling
profile-specific descriptors. We made some comments on it, and we are
waiting for an updated proposal.

We need to consolidate at least these two proposals: Chen's and Vijaykumar's.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
