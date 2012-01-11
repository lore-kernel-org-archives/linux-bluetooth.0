Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F82830D409D80E4881C83250E051B74B4A05D3CB@banasiexm01.ASIA.ROOT.PRI>
References: <1319497579-8859-1-git-send-email-pkrystad@codeaurora.org>
	<4EA6143E.4000606@googlemail.com>
	<7769C83744F2C34A841232EF77AEA20C01DCAA8D28@dnce01.ent.ti.com>
	<CAKT1EBeJB2FDrv6Xp_bGV3eFDEe5ecvnBN0rKniYxw5++Q9NfA@mail.gmail.com>
	<7769C83744F2C34A841232EF77AEA20C01DCAA8F85@dnce01.ent.ti.com>
	<CAKT1EBcd6dQq3bzOsW3Fuwv=d8J=yDvsJjbp_ELEAQUjfyRx9g@mail.gmail.com>
	<F82830D409D80E4881C83250E051B74B4A05D3CB@banasiexm01.ASIA.ROOT.PRI>
Date: Wed, 11 Jan 2012 11:57:31 -0300
Message-ID: <CAKT1EBdXx9=U9J8roTZT==fhHvH4ke5An5QSY3zc7xcyj9TMjA@mail.gmail.com>
Subject: Re: GATT Dbus API on BlueZ
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Vijaykumar Dadmode <Vijaykumar.Dadmode@csr.com>
Cc: "Ganir, Chen" <chen.ganir@ti.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vijay,

On Wed, Jan 11, 2012 at 11:25 AM, Vijaykumar Dadmode
<Vijaykumar.Dadmode@csr.com> wrote:
>
> Hi,
>
>> You are disabling all the GATT plugins, so my suggestion is: open the
>> ATT L2CAP socket directly in your JNI bindings. Using this approach
>> you will have all the control that you need.
>
>> We track the users/clients based on the D-Bus connection, if the
>> client(dbus-send or any other) leaves the bus the core will disconnect
>> link if watcher list is empty.
>
>> BR,
>> Claudio.
>
> If we are using plugins, considering the case, the device sends disconnect request if there is no activity on the device. On GATT Client we get GATT Disconnect (attio_disconnect). Then once there is some activity on device then it will start sending a ADV_DIREC_IND.

The plan is to get the disconnection reason through the
socket(getsockopt SO_ERROR).

I suppose that you are talking about HoG(HID over GATT). Indeed,
background LE scanning(in the kernel) needs to be active if the
service requires automatic reconnection. If we detect power
consumption problems one additional command can be added in the
management interface. Basically, the idea is to control LE scanning
and connections automatically in the kernel based on inputs provided
by the userspace: keys, socket(connection requested).

>
> How do we handle this case? As we have to again CONNECT/DISCOVER ?

Services/plugins need to keep the ATTIO callback registered only.
Scanning and connections should be handled automatically by the
bluetoothd core and kernel.

BR,
Claudio
