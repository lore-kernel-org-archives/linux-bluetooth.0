Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <425A3894.20301@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Logitech Mobile Freedom headset problems
References: <20050411082345.GA24929@janus>
In-Reply-To: <20050411082345.GA24929@janus>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Mon, 11 Apr 2005 02:43:00 -0600

the headset hasn't found your cellphone has it?

the very first btsco step is to contact the phone and discover its 
services (using sdp). this doesn't work if the headset's only available 
connection is being used to hold a connection to another device.

Major A wrote:
> Hi,
> 
> I'm trying to get the Logitech Mobile Freedom headset working. I use
> "hcitool scan" to find its address, and it identifies itself as
> "Logitech HS02-V05". Now when I do btsco -v <bdaddr>, I get this:
> 
> 
>>btsco v0.4
>>Device is 1:0
>>Error: Failed to connect to SDP server: Invalid exchange
>>Assuming channel 2
>>
>>Voice setting: 0x0060
>>Can't connect RFCOMM channel: Invalid exchange
> 
> 
> What's the reason for this? I'm supposed to be able to enter the PIN
> at this point. The headset is in pairing mode, and bluez works because
> I can use minicom to issue AT commands to my phone at the same time.
> 
> I'm using the current CVS version of btsco, kernel is 2.6.11.6 and the
> snd_bt_sco module loads just fine.
> 
> Any help would be greatly appreciated.
> 
>   Andras
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
