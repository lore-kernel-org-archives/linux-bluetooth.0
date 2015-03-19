Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: bluez5 pairing devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <BAY176-W11EC25DD22E46D52ED6D92D3010@phx.gbl>
Date: Thu, 19 Mar 2015 07:08:21 -0700
Cc: Szymon Janc <szymon.janc@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <CC6FAAF0-122B-4678-9865-F5E237073C09@holtmann.org>
References: <BAY176-W679B1127159C091585D3AD3030@phx.gbl> <,<46068BD2-CF33-4617-80DB-5AE5C1FCA364@holtmann.org> <,<,<12627750.IG3ACNRtuD@leonov>>> <,<BAY176-W40E12E1C2F620AB0D38605D3000@phx.gbl>,<440EB08C-2BD4-4373-B3DC-80361AA74722@holtmann.org>,<BAY176-W203E6BB20ECCED0D35B6A7D3010@phx.gbl>>> <BAY176-W11EC25DD22E46D52ED6D92D3010@phx.gbl>
To: Ssagarr Patil <hugarsagar@outlook.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sagar,

>>>> # bluetoothctl
>>>> [bluetooth]# power on
>>>> No default controller available
>>>> [bluetooth]#
>>> 
>>> you need a running bluetoothd for bluetoothctl.
>>> 
>> Isnt bluetoothd part of bluez5 stack ? as I am not able to see it.
>> 
> A further debug showed me this:
> 
> Mar 19 12:51:51 evm systemd[1]: Starting Bluetooth service...
> Mar 19 12:51:51 evm bluetoothd[189]: Bluetooth daemon 5.29
> Mar 19 12:51:51 evm systemd[1]: Started Bluetooth service.
> Mar 19 12:51:51 evm bluetoothd[189]: Starting SDP server
> Mar 19 12:51:51 evm bluetoothd[189]: Bluetooth management interface 1.1 initialized
> Mar 19 12:51:51 evm bluetoothd[189]: Failed to read info for index 54749: Invalid Index (0x11)

this looks like an endian bug to me. That is no a valid index. Unless you really added 54749 Bluetooth dongles on your system. So something is screwed up that that needs to be investigated.

> Mar 19 12:51:51 evm connmand[149]: Method "ListAdapters" with signature "" on interface "org.bluez.Manager" doesn't exist
> 
> org.bluez.Manager service is missing in from services shouldnt it come from bluez5 ?

It uses D-Bus Object Manager to retrieve all objects.

Regards

Marcel

