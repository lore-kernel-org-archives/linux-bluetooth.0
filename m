Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <422C0E72.7030108@futurlink.com>
From: Pedro Monjo Florit <pedro.monjo@futurlink.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: Fw: Re: Can't able to send data in both direction
References: <004401c5207b$c13a3210$4100a8c0@benjamin>	 <7aa80ced05030321482f162db2@mail.gmail.com>	 <d09q50$7r9$1@sea.gmane.org> <7aa80ced050306210062f2ad1e@mail.gmail.com>
In-Reply-To: <7aa80ced050306210062f2ad1e@mail.gmail.com>
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
Date: Mon, 07 Mar 2005 09:18:58 +0100

Mohan K wrote:
>Hi Sebastian,
>                  Thanks. The send program without closing the
>connection for each time is working fine. But on the recv side I am
>unable to read the data immediately.  I am using recv() function
>available in the bluez. After recv() fn I am using printf(). Until I
>close the connection it is not printing the received data.
>
>Thanks & Regards,
>Mohan
>
>
>
>On Fri, 04 Mar 2005 15:14:03 +0100, Sebastian Roth <sebiroth@web.de> wrote:
>  
>>Hi Mohan,
>>
>>why do you connect for each keypress?
>>Just connect on programm startup then `do' `send' `while' `getch'
>>and close the connection on programm shutdown.
>>This should avoid the delay!
>>
>>Best regards,
>>Sebastian
>>
>>    
>
Hi Mohan:

I have done a program which basically does the same thing: and echo 
server and its couterpart echo client, over bluetooth, of course. In the 
client part, I open the connection at the begining, read line by line 
and send the complete line with the trailing '\n' in just one send() 
call. The server reads the line with recv() and sends it back to the 
client, including '\n' again. This works perfectly for me.

Regards,

Pedro


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
