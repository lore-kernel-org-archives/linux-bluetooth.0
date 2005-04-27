Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <426F50F9.8090208@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] auto pairing between client & server
References: <2621d9af05042213064d0df1dc@mail.gmail.com>	 <426ABEBD.5060701@gmx.ch> <2621d9af0504250729e34a2aa@mail.gmail.com>	 <426D00CB.7060508@gmx.ch>  <2621d9af0504260302e1c13c7@mail.gmail.com>	 <1114515066.10706.204.camel@pegasus>  <426E7C67.30902@gmx.ch>	 <1114537612.10706.325.camel@pegasus>  <426E8A1F.7070707@gmx.ch> <1114542256.10706.329.camel@pegasus>
In-Reply-To: <1114542256.10706.329.camel@pegasus>
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
Date: Wed, 27 Apr 2005 10:44:41 +0200

I'm not sure if we talk about the same thing.
On outgoing connections, when encryption is demanded, the pin_helper, 
specified in hcid.conf is called and the output has to be like "PIN:1234".

If I wan't to use /etc/bluetooth/pin as this pin, I've to write a little 
pin_helper that outputs this pin.
My question now is: is it with the bluez packages >= 2.16 possible to avoid 
writing an own pin_helper? is hcid.conf configurable so that 
/etc/bluetooth/pin is automatically used for outgoing connections?

regards
Marco


Marcel Holtmann wrote:
> Hi Marco,
> 
> 
>> > the PIN helper is a program with specific parameters and it must return
>> > on standard output "PIN:1234" for example or "ERR".
>>
>>Yes, I know. But you wrote in that email that prior to 2.16 this was 
>>needed. That let's me assume that now it's possible to use the pin file for 
>>outgoing connections too.
> 
> 
> this is correct. With 2.16 you can create a pincodes file.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by: Tell us your software development plans!
> Take this survey and enter to win a one-year sub to SourceForge.net
> Plus IDC's 2005 look-ahead and a copy of this survey
> Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
