Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1012160741390.15684@linux-sea-02>
References: <1292251105-31130-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1292251105-31130-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<20101214192223.GD18509@vigoh>
	<alpine.DEB.2.00.1012150817580.12898@linux-sea-02>
	<AANLkTi=Kfm9jV0HA=Sa9=hs1meXthrpZEzn5-czTaSO+@mail.gmail.com>
	<alpine.DEB.2.00.1012160741390.15684@linux-sea-02>
Date: Fri, 17 Dec 2010 09:48:54 +0200
Message-ID: <AANLkTimg3L021rh2iJYm1ZhaUrpb37tKM8N=WVKQaME-@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: Use non-flushable pb flag by default for ACL
 data on capable chipsets.
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Dec 16, 2010 at 7:03 PM, Mat Martineau <mathewm@codeaurora.org> wrote:
>> <skipped>
>>>
>>> There is one more thing missing:  Even though there is an L2CAP socket
>>> option to set flush_to, and the flush_to is passed around during L2CAP
>>> configuration, there is no use of the "Write Automatic Flush Timeout" HCI
>>> command to tell the baseband what the flush timeout is!  Since the flush
>>> timeout is shared across all connections on the ACL, how should BlueZ
>>> handle
>>> the case where different flush timeouts are set on connections that share
>>> the same ACL?  (My guess is that either the longest or shortest timeout
>>> should be used, but there are good arguments either way)
>>
>> I would suggest bluetoothd to take care about setting Flush Timeout. There
>> is of course possibility to have sockopt for timeout and send HCI command
>> but this looks like a dirty hack.
>>
>> I think bluetoothd can read compare and write new flush timeout value.
>
> There is *already* a sockopt for flush timeout (flush_to in l2cap_options,
> it was added before 2005), but it is not terribly useful because it does not
> configure the baseband.

Yes, I just check, that code is just dummy code and only used to set dummy
value in L2CAP configuration phase with no actual use.

If I execute command like:
#Write Automatic Flush Timeout
~# hcitool cmd 0x03 0x0028 0x01 0x00 0xa0 0x0
#for handle 0x0001 to 100ms

it will still report old value through that kernel interface.

> One more piece of background information: The spec requires the default
> flush timeout to be infinite, so if no "Write Automatic Flush Timeout"
> command is sent, none of this flush code will accomplish anything.  Android
> has customized their version of BlueZ to send this command for A2DP
> connections, with certain BR/EDR basebands.

I believe they do it right way.

> I don't have any major objection to managing this setting from bluetoothd.
>  My only minor objection is that it requires an application to manipulate
> the setting via DBus instead of using the existing sockopt - it would be
> confusing to have both available, but I suppose the sockopt could be
> deprecated or made read-only.  The flush timeout would seem to fit well as a
> device property.

I would remove it at all, but of course it can be done as read-only.

Regards,
Andrei
