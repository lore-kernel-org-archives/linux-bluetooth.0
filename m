Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40AC714E.9040306@telus.net>
From: Ken <a5a33956@telus.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] rfcomm confusion
References: <40AB4D9F.7010307@telus.net> <1084969555.4327.60.camel@pegasus>
In-Reply-To: <1084969555.4327.60.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Thu, 20 May 2004 01:50:22 -0700

Hi Marcel,
Thanks for the response.  It is Windows on the iPAQ.
I've tried again using /dev/rfcomm0 for <dev> but the results are the 
same. (I think it was defaulting to rfcomm0 before even though I put 
hci0 in the <dev> field)

So, in linux I do:
 > rfcomm connect /dev/rfcomm0 08:00:28:90:25:D6 1
Connected /dev/rfcomm0 to 08:00:28:90:25:D6 on channel 1
Press CTRL-C for hangup

When I do this the iPAQ shows a connection icon, and when click into the 
status screen for that connection it shows me the details including 
connection time, activity, and signal strength.

Everything looks good but the activity always shows 0 bytes transfered 
and 0 bytes received.

So, I guess my question is, how do I send data through this connection?
Should I just be able to echo data into /dev/rfcomm0? (ie: echo "some 
data" > /dev/rfcomm0)

Or is it the case that I need an application on the iPAQ side to be 
listening for data before it will show any bytes received or transfered?

I hope this makes sense.
Thanks!
Ken

Marcel Holtmann wrote:

>Hi Ken,
>
>  
>
>>I am trying to create a bluetooth serial connection between my linux 
>>laptop and iPAQ pda.
>>    
>>
>
>is this a Windows or a Linux based iPAQ?
>
>  
>
>>I'm using the command "rfcomm connect hci0 00:11:22:33 1" and it appears 
>>to work.
>>    
>>
>
>The <dev> is not the HCI device. It is the RFCOMM device you wanna
>create. So use "rfcomm0" or "0" for short.
>
>  
>
>>the connection shows up on the iPAQ and when I go to the status it 
>>displays 0 bytes transfered - 0 bytes received.
>>    
>>
>
>Where do you see this?
>
>  
>
>>so, now i'm trying to send some data over this connection. my 
>>expectation was that i could do something like:
>>echo "test" > /dev/rfcomm0
>>and then see 4 bytes received on the iPAQ interface, however the byte 
>>counts on the ipaq remain 0.
>>    
>>
>
>Actually this depends on the program on the other side. If it is a
>Windows iPAQ I don't know how they count the bytes.
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by: SourceForge.net Broadband
>Sign-up now for SourceForge Broadband and get the fastest
>6.0/768 connection for only $19.95/mo for the first 3 months!
>http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>  
>



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
