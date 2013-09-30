Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 3/3] Bluetooth: Provide high speed configuration option
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20130930091820.GH10262@aemeltch-MOBL1>
Date: Mon, 30 Sep 2013 11:23:55 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C07188EF-416D-4FD4-8834-711F3194CBE6@holtmann.org>
References: <1380514261-21742-3-git-send-email-marcel@holtmann.org> <20130930091820.GH10262@aemeltch-MOBL1>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

>> Hiding the Bluetooth high speed support behind a module parameter is
>> not really useful. This can be enabled and disabled at runtime via
>> the management interface. This also has the advantage that his can
> 
> typo here.
> 
> …

the maintainer can fix that one up.

>> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
>> index c85537c..9119898 100644
>> --- a/net/bluetooth/l2cap_sock.c
>> +++ b/net/bluetooth/l2cap_sock.c
>> @@ -445,11 +445,6 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
>> 		break;
>> 
>> 	case BT_CHANNEL_POLICY:
>> -		if (!enable_hs) {
>> -			err = -ENOPROTOOPT;
>> -			break;
>> -		}
>> -
> 
> Do you think we don't need to check that HS is enabled here and below?

We can not. The socket might not be bound or the controller does not exists. So we have no way of knowing.

It should also work no matter what. The presence of an AMP controller is optional. That is why the policy is defined as BREDR_ONLY, BREDR_PREFERRED and AMP_PREFERRED. You can not force the AMP transport.

Regards

Marcel

