Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42492B72.6010701@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] inquiry with rssi
References: <42492056.9040601@gmx.ch> <1112091034.9016.64.camel@pegasus>
In-Reply-To: <1112091034.9016.64.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 29 Mar 2005 12:18:26 +0200

Can you please provide an example?
I'm not that experienced in bluetooth programming as you are...

It would be sensefull to have a codesnippet like that in the 
mailinglistarchive as well...

regards
Marco


Marcel Holtmann wrote:
> Hi Marco,
> 
> 
>>how to do an inquiry with rssi?
>>
>>I set the inquiry mode to "inquiry with rssi" with hci_write_inquiry_mode.
>>
>>Then I passed an inquiry_info_with_rssi (named info) to hci_inquiry:
>>hci_inquiry(dev_id, length, num_rsp, NULL, (inquiry_info**)&info, flags);
>>
>>but this doesn't seem to work.
>>what is the official way? Can someone provide a sample?
> 
> 
> the hci_inquiry() command does not support inquiry with RSSI. You must
> use the HCI raw socket for this.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 

Content Security by MailMarshal


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
