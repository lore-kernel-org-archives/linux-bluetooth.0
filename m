Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20050108092154.27208.qmail@webmail2.aruba.it>
References: <I9YM8N$7FAD017A09BC73827FE250A0E50B0128@uol.com.br>
In-Reply-To: <I9YM8N$7FAD017A09BC73827FE250A0E50B0128@uol.com.br>
From: "ubaldo" <ubaldo@eja.it>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Subject: [Bluez-devel] Re: miax
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
Date: Sat, 08 Jan 2005 10:21:53 +0100

Ciao Omap, 

download it from http://sourceforge.net/projects/miax/ or go to 
http://www.eja.it/gpl and download it from my web site, there is not any 
documentation yet, but once compiled give a "miax --help" and it should be 
easy to understand how it works... 

Anyway it works as a iax client connected to an asterisk server as usual, 
taking audio in/out from console and input/output from keyboard/video. 

If you have a bluetooth mobile phone, you should pair it with your computer 
and once paired you add "-b source/destination" (where "source" is the 
computer and "destination" the mobile phone) and it will take input/output 
and audio in/out from the mobile phone. 

If you haven't a bt phone you can use a normal gsm modem (tc35/gm47/etc) but 
this way you have to connect the audio in/out to a soundcard and the 
serial/usb port... 

With bt it is better because there are not cables and above all any 
digital/analog conversion. The best will be when the bt-sco will support the 
famouse 3 connection per bt-dongle at the same time, 'cause this way it will 
be easy to make a mini gsm gateway with just few bt-phones and a 
linux/asterisk server... 

> 
> Hi ubaldo. 
> 
> I have special interest on telephony
> over the internet. Where can i find
> more information about your
> application? I visited the project
> homepage but i could not find a
> description about it.
> And I want to congrat you for your project 
> 
> Regards 
> 
> 
>> Hi, I developed a mobile iax client
> for asterisk server with bluetooth
>> support that can be found on
> http://sourceforge.net/projects/miax/ . 
>> 
>> Thanx to everyone who helped here! :)  
>> 
>>   
>> 
>> ubaldo porcheddu - eja.it software
> development
>>  
>> 
>>
> -------------------------------------------------------
>> The SF.Net email is sponsored by:
> Beat the post-holiday blues
>> Get a FREE limited edition
> SourceForge.net t-shirt from ThinkGeek.
>> It's fun and FREE -- well,
> almost....http://www.thinkgeek.com/sfshirt
>>
> _______________________________________________
>> Bluez-devel mailing list
>> Bluez-devel@lists.sourceforge.net 
>>
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>> 
>  
> __________________________________________________________________________
> Acabe com aquelas janelinhas que pulam na sua tela.
> AntiPop-up UOL - É grátis!
> http://antipopup.uol.com.br/ 
> 
>  
> 
> 
> -------------------------------------------------------
> The SF.Net email is sponsored by: Beat the post-holiday blues
> Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
 



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
