Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4235F562.6000406@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: [Patch] Some btsco modifications
References: <1110683934.5056.43.camel@pc7.dolda2000.com>  <4233C663.80109@xmission.com> <1110762698.5056.73.camel@pc7.dolda2000.com>  <423589B1.6000403@xmission.com> <1110809103.5056.102.camel@pc7.dolda2000.com> <4235C92D.80107@xmission.com> <Pine.LNX.4.62.0503141958420.2286@block>
In-Reply-To: <Pine.LNX.4.62.0503141958420.2286@block>
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
Date: Mon, 14 Mar 2005 13:34:42 -0700

Florian,

I don't know enough about how hidd works. Does it spin off forked 
processes for each device it finds?

Brad

Florian Echtler wrote:
>>Maybe what we're looking for is something to start/stop/restart
>>one-per-headset btsco deamons appropriately. Maybe a daemon itself.
> 
> IMHO, the best option (I've been thinking about implementing that
> myself) would be the behaviour of hidd..
> 
> Yours, FLorian


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
