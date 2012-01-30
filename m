Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327960292.1955.177.camel@aeonflux>
References: <1327430878-23913-1-git-send-email-scott@netsplit.com>
	<1327952480.1955.154.camel@aeonflux>
	<CA+bD78it1S40KTRA+F9QX0KCVG3jDQsS=VdvEjuRdyxUPN4qhw@mail.gmail.com>
	<1327960292.1955.177.camel@aeonflux>
Date: Mon, 30 Jan 2012 13:57:19 -0800
Message-ID: <CA+bD78iUaG2Kmjn6k+x=MqUcdQaG=-w4dQTVEmvEA_LW1QRzcQ@mail.gmail.com>
Subject: Re: [PATCHv2 0/4] Add support for bonding callbacks and retrying
From: Scott James Remnant <scott@netsplit.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jan 30, 2012 at 1:51 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:

>> > We have to also ensure that we do not disconnect the ACL in between th=
e
>> > retry attempts. Otherwise some car kits might cancel their pairing
>> > procedure and you have to have user interaction to get it back into
>> > pairing mode. So if the ACL gets disconnect, then we should just fail
>> > and cancel the bonding.
>> >
>> In my testing, OS X/iOS drop the ACL between retry attempts - so we
>> wouldn't be any worse than they are. I'm not sure whether it's even
>> possible in bluez to avoid dropping the ACL?
>
> Is Apple doing retried pairing (or auto-pairing) as well?
>
They are; they send 0000 to the device, and then if it fails, it
retries after about 3s.

Android does the same (from the bluez Agent, ick)

> Strictly speaking the ACL disconnect is host stack triggered. So you
> have HCI_Authentication_Requested and you can just execute that again
> with the same link. We also do have a ACL disconnect timeout handling of
> 2 seconds that will allow sockets to re-use the same ACL link. Can you
> provide some hcidump traces from your test cases?
>
Sure, probably will be a few days though. I may have a play and see if
I can get it to avoid dropping the ACL link too.

Scott
--=20
Have you ever, ever felt like this?
Had strange things happen? =A0Are you going round the twist?
