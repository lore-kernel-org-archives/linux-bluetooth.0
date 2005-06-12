Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42AC05A4.1090105@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] BlueZ on ETRAX 100LX devboard 82+
References: <20050610050635.82925.qmail@web52804.mail.yahoo.com>
In-Reply-To: <20050610050635.82925.qmail@web52804.mail.yahoo.com>
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
Date: Sun, 12 Jun 2005 11:51:32 +0200

Hello Naved

Step 3 should automatically be done from hcid.
Step 2 (sdpd), is not needed if you haven't services on the axis board.

I suggest do program step 6 yourself. look at the sources from rfcomm and 
read a socket programming howto. bluez is basically socket programming. 
There are examples in the archive too.
If the problem is with the rfcomm utility, you'll get around it by doing 
this step yourself.


btw, does your script look like:
#!/bin/sh
#echo "PIN:1234"

or like:
#!/bin/sh
echo "PIN:1234"


regards
Marco


Naved Aziz wrote:
> Hi,
> 
> Basically, these are the steps that I am taking to set
> up an SP connection between the Axis board and the
> Nokia 6600:
> 
> (1) hcid
> (2) sdpd
> (3) hciconfig hci0 up #set up the bluetooth dongle
> (4) hcitool scan  #spot the phone, get the BD address
> (5) sdptool browse <BD address> #see services and 
>     their corrresponding channels
> (6) rfcomm connect /dev/rfcomm0 <BD address> <channel>
>     #where, if channel 2 is the one on nokia 6600    
>     providing serial port service, I put 2 for
> channel.   
>     The /dev/rfcomm0 is already created prior to 
>     flashing the image onto the board as follows:
>     mknod -m 0666 /dev/rfcomm0 c 216 0 
> 
> At this point, the phone gives a prompt, asking for a
> pin number.  The value in /etc/bluetooth/pin is 1234,
> and I have changed the pin_helper in hcid.conf to
> refer to a script file called qpin that looks like
> this:
> 
> #!/bin/sh
> #echo "PIN:1234"
> 
> This script file that I have created to work with the
> pin_helper is stored in the /tmp directory, since this
> is the only place where I am allowed to create any
> files, etc once an image has been downloaded onto the
> board. 
> 
> After I type in the pin on the Nokia 6600, there is a
> moment of wait, and then, the phone says "unable to
> connect", and the board says "can't create socket:
> resource temporarily unavailable".
> 
> You mentioned that the rfcomm utility creates a device
> that causes problems on some systems; how to get
> around this?
> 
> Thanks in advance for your help.
> 
> Naved
> 
> 
> 
>  
> --- Marco Trudel <mtrudel@gmx.ch> wrote:
> 
> 
>>Hello Naved
>>
>>
>>>So you're saying that you programmed, as in write
>>
>>the code, for the 
>>
>>>rfcomm protocol, while keeping the other (working)
>>
>>BlueZ stuff (meaning 
>>
>>>the other utilities like sdptool) on the board?  I
>>
>>will eventually have 
>>
>>>to write some applcation using rfcomm in order to
>>
>>exchange files and 
>>
>>>stuff with phones, but now, I am actually at a
>>
>>loss as to how to 
>>
>>>progress.  As a cherry on top, it has been only a
>>
>>couple of weeks since 
>>
>>>I have begun working with Linux. 
>>
>>Can you explain what you try to reach?
>>
>>
>>>Marco, it would mean a lot to me if you could
>>
>>provide me with some 
>>
>>>guidance as to how to get rfcomm working on the
>>
>>devboard 82+.  I am a 
>>
>>>total newbie at this, so if you could give me a
>>
>>step-by-step guide as to 
>>
>>>how to set up the Axis board with rfcomm support,
>>
>>I would be forever in 
>>
>>>your debt =)
>>
>>Everything works fine. The rfcomm utility creates a
>>device, this creates 
>>proglems on some systems. But rfcomm isn't broken.
>>
>>
>>regards
>>Marco
>>
>>
>>
> 
> -------------------------------------------------------
> 
>>This SF.Net email is sponsored by: NEC IT Guy Games.
>> How far can you shotput
>>a projector? How fast can you ride your desk chair
>>down the office luge track?
>>If you want to score the big prize, get to know the
>>little guy.  
>>Play to win an NEC 61" plasma display:
>>http://www.necitguy.com/?r=20
>>_______________________________________________
>>Bluez-users mailing list
>>Bluez-users@lists.sourceforge.net
>>
> 
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 
> 
> 
> 	
> 		
> __________________________________ 
> Do you Yahoo!? 
> Yahoo! Mail - You care about security. So do we. 
> http://promotions.yahoo.com/new_mail
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
> a projector? How fast can you ride your desk chair down the office luge track?
> If you want to score the big prize, get to know the little guy.  
> Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
