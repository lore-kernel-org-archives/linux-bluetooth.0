Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth ipaq problem
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?S=E9bastien?= Delneste <seb@pong.be>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040325194812.GA28260@pong.be>
References: <20040325194812.GA28260@pong.be>
Content-Type: text/plain
Message-Id: <1080258707.2283.57.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 26 Mar 2004 00:51:47 +0100

Hi Sebastien,

> I'm having a serious problem with an iPaq 3870 running Linux (Familiar)
> 
> 6 months ago, I've been trying to change the PS registers of my CSR
> chipset (using the pskey tool)
> 
> Since then, my bluetooth hasn't worked anymore.
> 
> Today, I finally found back the URL I was looking for with the default
> values of the registers.
> http://www.samengstrom.com/ipaq/PSKEY-README
> 
> I've restored one but, apparently I failed to modify the second one,
> which results to the following problem : 
> 
> I still can't use the bluetooth function of my iPaq and I can't access
> it with pskey anymore 
> 
> the values are now : 
> 1f9	0001
> 191 01d8 00a8 00fa 0014 0004 0000 0004 001e 0064 000a
> 
> now, when I try to use pskey (no matter the speed , I've tried
> 15200,230400, etc), it gives me the following error :
> 
> ~ # pskey -d /dev/ttySB0
> Physical device :/dev/ttySB0
> Speed           :115200
> Use BCSP        :NO
> Initiating read thread
> Now trying to read firmware info
> Timeout!!!
> Error in reading firmware info
> 
> 
> Is there anyone out there who already had this problem ?

playing with the CSR PS and not really knowing what you are doing is
dangerous, because you can set your Bluetooth chip to a non working
state. The archive contains some post from CSR guys that may can help
you, but actually I think you broke it. Btw you never had to do this
modifications, because the iPAQ is working out of the box ;)

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
