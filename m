Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40327D70.8080003@vpop.net>
From: Matthew Reimer <mreimer@vpop.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net, pmarques@grupopie.com
Subject: Re: [Bluez-users] How to configure a 723kbps connection?
References: <lists.bluez.users.40327430.2090807@grupopie.com>
In-Reply-To: <lists.bluez.users.40327430.2090807@grupopie.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 17 Feb 2004 14:45:36 -0600

Paulo Marques wrote:
> grpmind+bluez.users@boromir.vpop.net wrote:
> 
>>
>> For a poor man's throughput test I'm downloading a 7M mpeg file, both
>> through Pocket IE and by having Pocket TV stream it from my 100Mbps LAN.
>> I'm running "nload -o 800 -t 250 xl0" and watching the outgoing avg in
>> kbit/s.
>>
>> No matter what I do, the average caps out at about 265kbps. I've tried 
>> all
>> the following in various combinations:
> 
> 
> 
> What profile are you using? LAN or PAN?

I think I'm using PAN (what PPC2003 and sdptool call "Network Access 
Point"). Is that what you mean?


> If you're using LAN you should really try using PAN. I don't trust the 
> micro$oft stack at all. The simpler the profile, the most likely it is 
> to work ok.
> 
>> Does all this mean that my ipaq has a slow UART
> 
> 
> It's strange... a slow UART should be 230400 or 460800 baud. If it were 
> 230400 you shouldn't get a bandwidth as high as you're getting. If it 
> were 460800 you'd probably be a little higher.
> 
> Of course, this is no proof that the UART is in fact the culprit.

Yes, it is perplexing. I'm waiting to hear back from knowledgeable 
people about how the bluetooth chip is connected.

Matt


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
