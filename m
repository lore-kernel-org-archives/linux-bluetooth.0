Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4216E189.8070307@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] rfcomm question 3
References: <20050218032831.77410.qmail@web60909.mail.yahoo.com>
In-Reply-To: <20050218032831.77410.qmail@web60909.mail.yahoo.com>
Content-Type: text/plain; charset=Big5
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
Date: Sat, 19 Feb 2005 07:49:45 +0100

Hello Michael

Do I understand this right:

You have to control infrared devices like a television with your mobile
phone. The connection between your mobile phone and your pc is over
bluetooth and your pc then sends the infrared signals to the television, is
this correct?
You were able to connect from your pc to the mobile phone. Did you use
bluetooth? Which service do you connected to (from your mobile phone),
what's it's name?
Then you sent the menu for the remote control from your pc to your mobile
phone using at commands and got the choices you made on the mobile phone
bacck to your pc. Your pc then sent the answer to the television using
infrared?

Hope I understood this more or less correctly...

regards
Marco


Ka Kin Cheung wrote:
> Hi Marco!
>    I think it is a need to explain the whole things
> here so that you can understand.
>    My purpose of my project is to use bluetooth mobile
> devices (now are T610 and iPAQ 3970, where iPAQ is
> running on Windows CE 3.0) to act as remote control on
> IR devices (now is doing for AV devices such as TV,
> CD, VCD, DVD and VCR). The OS used is Linux, and the
> main programming language is C. At first, I connected
> PC to T610, and it successed and the remote control on
> AV devices using T610 was also successful. But my
> supervisor said that the approach should be that the
> PC act as server, so that the connection from
> bluetooth mobile device to PC is needed. Then I tried
> hard to find out how the T610 can connect to PC. Now
> T610 can search my PC and then add in the "My device"
> list. But when I looked at the "Service list", the
> "Local service cannot found" statement was shown.
> Then, my tutor said that sdp (service discovery
> protocol) is needed for T610. So, my work is now
> mainly on how to do for sdp so that the T610 can
> connect to PC. If this is successful, then the next
> thing that I have to do is to  connect the iPAQ
> running on Windows CE to the PC to access my main
> program that runs on Linux. 
>     Regarding to your questions and comments in the
> prevoius mail:
> 1.>> My expect is to see if my phone can connect to
> mobile phone,
>   >I assume you mean if your phone can connect to the
> pc.
>   >How do you wanna see this? What behavior do you
> excactly expect?
>   Your assumption is correct, and then after I can see
> the address of T610, what I wish to see is the menu
> can be sent throught AT command to the phone and then
> try to do the remote control using T610.
> 2.>> But unfortunately, nothing to see because I can't
> find an option   >>on T610 that can connect to PC even
> though I put the PC into "My >>device" list.
> 
>>As I said, you need to programm this yourself (and
> 
> install it on your
> 
>>mobile phone)...
> 
>    The main point is, as the menu for my program can
> be sent to T610 using AT command and the C main
> program on the Linux PC can get my choice from T610
> and then do the corresponding things, I wish to know
> why an extra program is needed to write and then
> install on my phone? And is there any contradiction
> with sdp?
> 3. >how should I know what he needed the sdp for?
> Actually you should >explain us what he needed the sdp
> for.
>     The situation is when I connect from PC to T610,
> the "accessories" i.e. the menu that I wish to use is
> sent through AT command to the phone, and then I can
> use. When I check the "service list", I see "object
> push" in the list. But then when I change the
> connection approach that from T610 to PC, no service
> can be found in the "Service list". Then my tutor said
> the sdp is needed for T610 so that the service on the
> PC can be found and then the connection from T610 to
> PC can be done.
>     By the way, my tutor is Hong Kong people, and you
> may not know him.
> 4.>>>you've to write a client program for that runs on
> the mobile >>>phone. if i remember right, the T610
> hasn't support for jsr82. I >>>don't know if you're
> able to do c programming on it and have access >>>to
> the bluetooth system. i use a nokia 6230, there you
> have mdip2.0 and jsr83. so it's no problem at all...
> 
>>>Thx for suggestion.
>>
>>that wasn't a suggestion. you have to do this!
> 
> But the problem is, my project can only use T610 and
> iPAq at this instant, and the language used for this
> project is C. So, is there any other alternative that
> can do the thing same as that you said before?
> 
>     Here are the things that I concern now:
> 1. How to do for sdp so that the mobile devices can
> connect to PC (and the main point is, this can be done
> when I run my main program)
> 2. As my iPAq is running on Windows CE and the program
> used on it will be written in Visual eMbedded C++, but
> AT command is used for T610, so how can I solve this
> "contradiction" and that the choice from my iPAQ can
> be known by my main program?
>     I do hope that you can understand what I face now.
> Thank you very much.
> Michael
> 
> _______________________________________________________________________
> 新年願望第一位 : 找到友緣人
> http://personals.yahoo.com.hk
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


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
