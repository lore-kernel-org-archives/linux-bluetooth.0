Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: Problems with incoming connection request on Nexus 4
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <55BA16BA.5060302@gmail.com>
Date: Thu, 30 Jul 2015 14:25:02 +0200
Cc: Szymon Janc <Szymon.Janc@tieto.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <F5B83C8F-6BD0-49C8-96C9-F13DF68CEECE@holtmann.org>
References: <55B83614.8090702@gmail.com> <BC4DBE9E-8369-4B20-BBE5-F175DD4C5626@holtmann.org> <55BA16BA.5060302@gmail.com>
To: Florian Grandel <fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Florian,

> >> Symptoms:
>>> - The connection request times out.
>>> - bt_io_accept() is being called but the accept_cb (=connect_cb) only gets called when the request times out.
>>> - the device is stuck in the CONNECT READY state and never reaches the CONNECTED state
>>> 
>>> 
>>> Any ideas how I could analyze/solve that problem? I'm stuck on this for many hours already...
>> 
>> what does btmon actually tell you about what is going on with HCI.
> 
> = New Index: 10:68:3F:56:AD:35 (BR/EDR,UNKNOWN,hci0)            [hci0] 0.629837
> @ Advertising Added: 1
> < HCI Command: LE Set Advertising Para.. (0x08|0x0006) plen 15  [hci0] 4.398493
>        Min advertising interval: 1280.000 msec (0x0800)
>        Max advertising interval: 1280.000 msec (0x0800)
>        Type: Connectable undirected - ADV_IND (0x00)
>        Own address type: Public (0x00)
>        Direct address type: Public (0x00)
>        Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
>        Channel map: 37, 38, 39 (0x07)
>        Filter policy: Allow Scan Request from Any, Allow Connect Request from Any (0x00)
> > HCI Event: Command Complete (0x0e) plen 4                     [hci0] 4.401392
>      LE Set Advertising Parameters (0x08|0x0006) ncmd 1
>        Status: Success (0x00)
> < HCI Command: LE Set Advertise Enable (0x08|0x000a) plen 1     [hci0] 4.401484
>        Advertising: Enabled (0x01)
> > HCI Event: Command Complete (0x0e) plen 4                     [hci0] 4.402277
>      LE Set Advertise Enable (0x08|0x000a) ncmd 1
>        Status: Success (0x00)
> 
> There is no connection related HCI activity going on at all on the Nexus 4 side. You can see from the debug logs that I sent before, that the connection is being initiated correctly. The bt_io_accept() call does return without error, just the accept callback never gets called. To me it seems as if the Nexus4 was not responding to the incoming connect request.

we are advertising now. If the HCI traffic stays this way, then we are basically waiting for the central to connect to us. It is up to your Nexus 4 to connect.

If it would connect, then you would see an LE Connect Complete event indicated that the connection has been established.

Regards

Marcel

