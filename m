Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: Unknown Connection Identifier
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20151202085224.GC13305@t440s.lan>
Date: Wed, 2 Dec 2015 07:54:41 -1000
Cc: =?utf-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>,
	Szymon Janc <szymon.janc@codecoup.pl>,
	linux-bluetooth@vger.kernel.org
Message-Id: <0F926DB5-1497-4C5B-8738-33E8ED46D3E9@holtmann.org>
References: <CAEZxfGPTxwUZzU+3XSV-uiN+DMz+hyOKiiZfgF+oD6pp=-XiOA@mail.gmail.com> <AAC95ACC-36E4-4618-8F49-53F78AE93AA6@holtmann.org> <2045332.GytFuFKTvp@ix> <CAEZxfGOdyZat1evKm0Jfwg=knuigGdfK_wVqS8NG=zFAY3aRXg@mail.gmail.com> <2DBBB005-93A7-47ED-8E88-1D6B92ACCC07@holtmann.org> <20151201084107.GA11107@t440s.lan> <487A3350-04EA-43F5-AAD0-4B64005D108E@holtmann.org> <20151202085224.GC13305@t440s.lan>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>>>>>> HCI Event: Command Complete (0x0e) plen 4                                           [hci0] 17.672048
>>>>>    LE Create Connection Cancel (0x08|0x000e) ncmd 1
>>>>>      Status: Success (0x00)
>>>>>> HCI Event: LE Meta Event (0x3e) plen 19                                             [hci0] 17.674036
>>>>>    LE Connection Complete (0x01)
>>>>>      Status: Unknown Connection Identifier (0x02)
>>>>>      Handle: 32
>>>>>      Role: Master (0x00)
>>>>>      Peer address type: Public (0x00)
>>>>>      Peer address: 88:0F:10:9D:EB:42 (OUI 88-0F-10)
>>>>>      Connection interval: 67.50 msec (0x0036)
>>>>>      Connection latency: 0.00 msec (0x0000)
>>>>>      Supervision timeout: 420 msec (0x002a)
>>>>>      Master clock accuracy: 0x00
>>>>> @ Connect Failed: 88:0F:10:9D:EB:42 (1) status 0x02
>>>> 
>>>> This one still needs to be fixed. It is a bug. The implementation is
>>>> too naive. The unknown connection identifier is actually the success
>>>> case for LE Create Connection Cancel command. And since we keep trying
>>>> until the connection timeout hits, this is not an error at this point.
>>> 
>>> I think we need to differentiate between explicit connection requests
>>> (L2CAP socket connect()) and Add Device based connections. For the
>>> former we probably do want the Connect Failed since that's consistent
>>> with the behavior you see when operating the L2CAP socket. For the
>>> latter where we just go back to trying again, so the event doesn't
>>> really describe what's going on.
>> 
>> are you sure about that. I think we need to define when we want the
>> mgmt connect failed event to show up. Does it make sense that it shows
>> up for connection attempts that are not initiated by mgmt?
>> 
>> I mean, what is the benefit of a connection failed event if you can
>> not tell that something actually tried to connect in the first. So if
>> you try to connect via L2CAP, we are just getting a failure and do not
>> know what triggered it. How is that helpful?
> 
> I could think of at least one case: a device uses security mode 3 and we
> connect to it via L2CAP. This triggers a PIN Code Request event, however
> before we answer it the remote side cancels the connection/pairing
> triggering a connect complete with failure status. In this case
> bluetoothd should notify the agent to stop requesting for the PIN. Quite
> a far stretched scenario (and I might even be wrong about it) but I
> wouldn't be so quick to dismiss this event for non-mgmt actions.

actually I agree, everything involved with mgmt and pairing should cause this error. However has that really anything to do with L2CAP? It is more like we only send it if something happens on HCI side of things that are no related to any higher layers.

Btw. I am fine with applying your initial patch with the updated comment. It is improving the situation no matter what, but we might want to double check if not sending this event with nobody being able to react on it.

Regards

Marcel

