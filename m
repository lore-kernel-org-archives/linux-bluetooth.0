Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: GATT Clients and Servers in the kernel (was Re:[PATCH BlueZ v3 06/16] attrib...)
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CACJA=fUGFOJOfzg-uC6sibT+=DZVQj_TZ3pk5RQJx+n6A+=8Hw@mail.gmail.com>
Date: Tue, 21 May 2013 21:25:24 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	Vinicius Gomes <vinicius.gomes@openbossa.org>,
	Jefferson Delfes <jefferson.delfes@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <5581FC69-22F4-4708-BD74-D9920378AC52@holtmann.org>
References: <CAE6HaM=ogwUXRFM1+Pv-O9Cg0W3ueOpATMtU8kW2=D4Ghb93JA@mail.gmail.com> <20130503044355.GB3742@x220> <A060FC80-17F1-4666-B3CE-DA0B576D3A0D@holtmann.org> <CACJA=fV1ctv-D8FUccuYNN7obA_T7BQQMp-MyS+9ueYRUukxew@mail.gmail.com> <41BA1C3C-C3B7-430C-8EAC-651DBDC5033B@holtmann.org> <CACJA=fUGFOJOfzg-uC6sibT+=DZVQj_TZ3pk5RQJx+n6A+=8Hw@mail.gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> Last week we did some brainstorming about the two LE connection
> approaches. So far, the only drawback we see in this accept() approach
> is that it requires at least three new mgmt LE-specific commands to
> add, remove and clear the set of devices we want to connect to. IIRC,
> we don't want commands LE-specific in Management Interface.

I am not worried about the mgmt commands actually. My main point is that after a reboot they need to be reloaded into the kernel. So something else is needed here as well. And I do not want to hold file descriptors for devices that say are know, but only connect once per week.

What I want is that we tell the kernel what device we know about and what we expect to connect automatically once in range. So that we can program the controller properly. And to that effect not have this controller via L2CAP layer connect(). Since that layer has nothing to do with it actually.

This mgmt commands does not have to LE specific, but are most likely LE specific. I have not a big problem with this. We already have the LE long term key loading command that LE specific already. Maybe there are some common features between LE and BR/EDR possible. For example we have been talking about remote wakeup in the past. That can fit on BR/EDR and LE.

> Also, during discussion, some questions were raised and we'd like to
> share with the ML:
> 
> * What happens with connect()? What should it implement?

Actually connect() will stay relevant, but I can not go into specifics here for unreleased specifications.

> * How this approach integrates with peripheral role and advertising support?

The GATT part is no different. Both roles will support client + server at the same time. They have to. With  GATT over LE you only have one CID and both peers will provide a server and both peer can be a client within the same GATT transaction model.

The difference between peripheral and central is just up to bluetoothd and what kind of services are exposed for that specific LE connection. Right now, we might just disable central handling when peripheral mode is requested. However in the future I can see us running central and peripheral at the same time. We might have to tell the socket on accept() what kind of role the connecting LE device is.

Regards

Marcel

