Return-Path: <cyrus@holtmann.org>
Message-ID: <4E46E95B.8060500@Dartmouth.edu>
Date: Sat, 13 Aug 2011 17:15:07 -0400
From: Isaiah Sarju <Isaiah.Sarju@Dartmouth.edu>
MIME-Version: 1.0
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: RFCOMM channel 1 behavior differences
References: <4E45B5F1.4020807@Dartmouth.edu> <20110813000615.GA32541@piper> <20110813082621.GA11338@dell.Elisa>
In-Reply-To: <20110813082621.GA11338@dell.Elisa>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 8/13/11 4:26 AM, Johan Hedberg wrote:
> Hi,
>
> On Fri, Aug 12, 2011, Vinicius Costa Gomes wrote:
>> On 19:23 Fri 12 Aug, Isaiah Sarju wrote:
>>> Hello,
>>>
>>> Does Ubuntu, linux kernel 2.6.38.10, running bluez 4.91-0ubuntu1
>>> have a special security policy for incoming rfcomm connections on
>>> channel 1, and not other channels?
>>>
>>
>> Most probably this is caused by a problem in how Ubuntu packages
>> BlueZ.
>>
>> Could you try this: edit /etc/bluetooth/main.conf and add "pnat-server"
>> to the DisabledPlugins field (perhaps you will need to uncomment that
>> line). Restart bluetoothd and see if it works.
>
> That could be the reason, however the plugin name is "pnat" and not
> "pnat-server" (pnat-server is just the adapter driver name that the pnat
> plugin registers).

Thank you both for the advice. Adding "pnat" to the comma separated list 
worked for me.

main.conf now contains line:
DisablePlugins = network,input,pnat

What I could find on pnat-server in the archives stated that it has a 
use on some Nokia device. What function does the pnat plugin serve?

Thank you,
Isaiah
