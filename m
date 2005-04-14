Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Jesse Guardiani <jesse@wingnet.net>
Message-ID: <pan.2005.04.14.17.44.50.965548@wingnet.net>
References: <pan.2005.04.13.14.52.16.599459@wingnet.net> <1113405322.9061.36.camel@pegasus> <pan.2005.04.13.19.52.58.815123@wingnet.net> <1113423981.15359.0.camel@pegasus> <pan.2005.04.14.16.59.12.288202@wingnet.net> <1113498461.8989.63.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] Re: Re: Re: bluetooth 1.2 - how do I know it's	working?
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
Date: Thu, 14 Apr 2005 13:44:53 -0400

On Thu, 14 Apr 2005 19:07:41 +0200, Marcel Holtmann wrote:

> Hi Jesse,
> 
>> > it is working, but you need to get heavy data transmission on your
>> > wireless LAN and place the two devices near by.
>> 
>> I'm not so sure it is working. I'm hearing fairly heavy popping and
>> cracking over my btsco connection, the 802.11b access point is about
>> two feet from my DBT 120 and my headset, and the afh value never
>> changes.
>> 
>> Are there different afhmode settings I can try? Can I experiment
>> with different afh masks somehow?
> 
> there exists a HCI command to influence the classification. So if you
> know what frequency is used by your access point, you can block these
> channels. Some time ago I thought about writing support for it, but I
> never really started it. Feel free to provide a patch.

OK. So custom code is the only way to specify it. What does the
afhmode command do then?

Also, is the fact that I'm getting a mask back when I run `hcitool afh`
proof that my DBT 120 is doing AFH? Or could it just mean that the headset
is attempting AFH but the dongle isn't?

Thanks!

-- 
Jesse Guardiani, Systems Administrator
WingNET Internet Services,
P.O. Box 2605 // Cleveland, TN 37320-2605
423-559-LINK (v)  423-559-5145 (f)
http://www.wingnet.net





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
