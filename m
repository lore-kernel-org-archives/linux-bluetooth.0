Return-Path: <cyrus@holtmann.org>
Message-ID: <47DA8869.5030602@aircable.net>
Date: Fri, 14 Mar 2008 12:15:05 -0200
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <1205440348.12951.9.camel@californication>	<47DA5229.3050605@aircable.net>	<9D26A74C-6B7C-48A7-BFA1-A5128475F01B@holtmann.org>	<47DA813E.7060503@aircable.net>
	<63E1C59E-6425-4B25-B5F2-44CF0107BADD@holtmann.org>
In-Reply-To: <63E1C59E-6425-4B25-B5F2-44CF0107BADD@holtmann.org>
Subject: Re: [Bluez-devel] Moving towards a new API for BlueZ 4.0
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Marcel
> the new MacBooks suppose to have Bluetooth 2.1, but in case of  
> Extended Inquiry you need the new firmware (old hardware is okay) on  
> both sides. Haven't seen any of it in real life so far, but that is  
> what their specs say.
>   
Yeah me either, and I have some access to firmwares.

> In that specific case you would, but that is not the case we designed  
> the API for.
>   
I see.

> You get an additional DeviceFound which will then include the Name  
> value in the dictionary.
>   
Ok perfect, so then scanning with no name resolve makes no sense at all.

> As mentioned above. You get one (at least one) DeviceFound with no  
> Name value and a second one with the Name value.
>   
And I guess this one will be sended as soon as the old one was sent right?

> I am not sure. The code to make this all work is so complicated that I  
> really wanna remove it when we hit 4.0. Ping me again at some point.  
> For now we are going without allowing discovery without resolving the  
> name.
If this is the case, when we are still getting a callback as soon as the
device is discovered, and then another one with a resolved name it
doesn't harm the kind of applications I talk about.
What I'm most concerned off, and that's why I used no name resolving, is
that name resolving consumes connections, and we only have 7 per dongle.
And in some cases this is a real issue. In the past (well actually now a
days). What I do is first I scan with no name resolving, and then if I
don't know the device I go and ask the name, and then I go and ask for
the sdp records (I know I'm wasting connections and time).

But with this new API it will be even easier. I can't wait to start
getting my hands on it, and helping as much as I can (and my time allows
me). BTW what will happen with the old libbluetooth? I remember reading
some comments from you saying that 4.0 will remove all the hci commands,
will this be the case?

Cheers,
Manuel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
