Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4200EC4D.4070705@clarinet.u-strasbg.fr>
From: Nicolas Montavont <montavont@clarinet.u-strasbg.fr>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Cc: nathanael@cmc.ca
Subject: Re: [Bluez-devel] btsco doesn't start
References: <41FF7E71.3080206@clarinet.u-strasbg.fr> <41FF8412.50007@dark-reality.de> <41FF4666.7020400@cmc.ca>
In-Reply-To: <41FF4666.7020400@cmc.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Wed, 02 Feb 2005 16:05:49 +0100

Hi Nathanael and Lars,

Thanks a lot for these clarifications... I succeed to establish the 
connection through btsco.
I finaly use the alsa modules in the kernel and make the  modification 
to hcid.conf.

While it worked with aplay, it didn't work with gnomemeeting and then I 
tried to disconnect and reconnect. Now, I always get the following 
message, even after rebooting :

Can't connect RFCOMM channel: Permission denied

If I try sdptool --search ... it gives me the same output (Permission 
denied).

I get this either if I put the headset in pairing mode or not.

I am sorry to ask these questions, I am not really familiar with this 
equipment...

Thanks again !

Nicolas

Nathanael Morrison wrote:

> Hi Nicolas,
>
> I had similar problems getting the M2500 headset, it's not getting the 
> Pin # when first connecting.  I created a simple file pin_helper_simple:
>
> #----------------------
> #!/bin/sh
> echo "PIN:0000"
> #----------------------
>
> Then I modified the hcid.conf under options{} and pointed to the new 
> pin helper:
>
> pin_helper /etc/bluetooth/pin_help_simple;
>
> After that running btsco <address> worked. Also note, for the first 
> connection you might have to put the headset into pairing mode.
>
> Cheers,
>
> Nathanael
>
>
> Lars Grunewaldt wrote:
>
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Nicolas Montavont wrote:
>> | Dear Developers,
>> |
>> | I just bought an Plantronics M2500 headset and I have problems to make
>> | it work in my linux box. I hope you can help me.
>> |
>> | The problem is I can not start btsco. Here is the output when I try to
>> | start btsco :
>> |
>> | Device is 2:0
>> | Error: btsco open (2-0): No such device or address
>> |
>>
>> looks like an alsa problem, because this device means the alsa device.
>> It detects that your snd-bt-sco is device 2 (third sound card) but it
>> seems to have a problem to connect. Maybe a problem with alsa-lib? Can
>> you connect to the snd-bt-sco by other programs, like alsamixer? In your
>> case it should be alsamixer -c2
>>
>> I'm no expert for this part though... (if I'm for any part at all, 
>> anyway).
>>
>> best regards,
>> ~  Lars
>>
>>
>> - --
>> Lars Grunewaldt
>> * software development
>> * multimedia design
>> skills: C/C++/Java/PHP/(X)HTML/Flash/audio/video
>> web: http://www.dark-reality.de
>> mail: lgw@dark-reality.de
>> -----BEGIN PGP SIGNATURE-----
>> Version: GnuPG v1.2.3 (GNU/Linux)
>> Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org
>>
>> iD8DBQFB/4QRQWC6DTWkDAoRAnpdAKClq19p+Wyc1rU/JomO/HzxhbRUJACbBHWF
>> MY2O6Xn/5fJl3TuSr8r2lms=
>> =Jkho
>> -----END PGP SIGNATURE-----
>>
>>
>> -------------------------------------------------------
>> This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
>> Tool for open source databases. Create drag-&-drop reports. Save time
>> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
>> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
>> _______________________________________________
>> Bluez-devel mailing list
>> Bluez-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
> Tool for open source databases. Create drag-&-drop reports. Save time
> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
