Return-Path: <cyrus@holtmann.org>
Message-ID: <BAY118-DAV3F4C2E9D80FB360F79BC7C7F20@phx.gbl>
From: <ichane@hotmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
References: <BAY118-DAV9D9EC1C84DCF7A987834CC7FE0@phx.gbl>
	<83810412-22B0-461B-9307-48269B59E8FA@holtmann.org>
Date: Tue, 8 Apr 2008 09:39:20 +0800
MIME-Version: 1.0
Subject: Re: [Bluez-users] sdptool add service
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi, there:

Thanks for the reply.

Hi, there:

Thanks for the reply.

I observe that "sdptool add SP" always sets rfcomm channel to 1.
Thus, "rfcomm listen 0 2" which should set channel to 2 does not
correctly set to SDP's service record for other rfcomm clients
to use channel 2 to make rfcomm connection.

Is there any way to set rfcomm channel to SDP's service record
in addition to channel 1 ?

Thanks a lot,

Chane

----- Original Message ----- 
From: "Marcel Holtmann" <marcel@holtmann.org>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Sent: Thursday, March 27, 2008 10:58 PM
Subject: Re: [Bluez-users] sdptool add service


> Hi Chane,
>
>> Do I need to add service manually using sdptool add? I got different
>> results using pand and rfcomm listen as servers.
>>
>> 1. >pand -s -M --role=NAP
>> After run the command above, no need to run "sdptool add NAP". The
>> service is already registered to sdpd.
>
> the pand will register service records for you. Why are you not using
> the network service?
>
>> 2.>rfcomm listen 1 1
>> Need to run sdptool add SP to register SPP service to sdpd.
>
> Yes, you need to register your own service record. However using the
> serial service might be a better idea here.
>
> Regards
>
> Marcel
>
>
> -------------------------------------------------------------------------
> Check out the new SourceForge.net Marketplace.
> It's the best place to buy or sell services for
> just about anything Open Source.
> http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
