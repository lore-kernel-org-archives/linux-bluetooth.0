Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v619)
In-Reply-To: <1105375711.8652.39.camel@pegasus>
References: <9DCE2262-6326-11D9-95C8-00039390D626@pepper.com> <1105375711.8652.39.camel@pegasus>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7A567168-6328-11D9-95C8-00039390D626@pepper.com>
From: Michael Frey <mfrey@pepper.com>
Subject: Re: [Bluez-devel] How to trigger an event after hidd connect/disconnect
To: bluez-devel@lists.sourceforge.net
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 10 Jan 2005 11:55:48 -0500

Marcel,

I see -- trigger off the device not the actual hid connection.

Thanks,
Michael

On Jan 10, 2005, at 11:48 AM, Marcel Holtmann wrote:

> Hi Michael,
>
>> Is there a way to trigger an event based on a hidd connect / 
>> disconnect
>> event?
>>
>> In other words I would like to run a specified script when the event
>> occurs. similar to the linux hotplug events.
>>
>> Is this possible using hidd?
>
> it is not possible using hidd, but there should be a hotplug event for
> the created input device.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> The SF.Net email is sponsored by: Beat the post-holiday blues
> Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
