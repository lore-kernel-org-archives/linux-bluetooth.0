Return-Path: <cyrus@holtmann.org>
From: Randy Yates <yates@digitalsignallabs.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: mgmt-api.txt
References: <87d2vygjyy.fsf@randy.site> <20130218081221.GA8590@x220>
	<20130218085806.GB11034@x220>
Date: Mon, 18 Feb 2013 11:00:43 -0500
In-Reply-To: <20130218085806.GB11034@x220> (Johan Hedberg's message of "Mon,
	18 Feb 2013 10:58:06 +0200")
Message-ID: <87zjz1ehn8.fsf@randy.site>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks much, Johan. That clarifies things nicely.

--Randy

Johan Hedberg <johan.hedberg@gmail.com> writes:

> Hi,
>
> On Mon, Feb 18, 2013, Johan Hedberg wrote:
>> On Mon, Feb 18, 2013, Randy Yates wrote:
>> > Almost all text files in doc/ are consistently-documented dbus APIs,
>> > specifying service, interface, and object path.
>> > 
>> > However, doc/mgmt-api.txt is in a completely different format. It states
>> > something about "Packet Structures" but I have no idea which packets the
>> > document is referring to.
>> > 
>> > Can someone explain how to use this API? We have a requirement to set
>> > some of these properties, such as discoverability and link level
>> > security.
>> 
>> This is just a special socket type that kernel versions from 3.4 onwards
>> provide. See e.g. the mgmt_new_default() function in src/shared/mgmt.c
>> for an example of creating a mgmt socket that you can use to communicate
>> using the protocol described in mgmt-api.txt. There are also several
>> tools in the source tree that use mgmt sockets, e.g. tools/btmgmt
>> client/bluetoothctl and monitor/btmon. Looking at the source code for
>> those tools may also be helpful.
>
> Minor mistake there: bluetoothctl doesn't use mgmt sockets (it uses just
> the D-Bus interface). I also went ahead and pushed a description of how
> to create mgmt sockets to mgmt-api.txt since this was a quite obvious
> omission in the file. Another file you'll probably find useful is
> lib/mgmt.h which has structs and numerical definitions for the mgmt
> protocol.
>
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Randy Yates
Digital Signal Labs
http://www.digitalsignallabs.com
