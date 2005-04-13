Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Matthias <matthiasbrune@gmx.de>
Message-ID: <loom.20050413T154320-783@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: [Bluez-devel] Patch for L2CAP (kernel<->userspace)
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
Date: Wed, 13 Apr 2005 13:53:59 +0000 (UTC)

>Date: 2005-01-25 12:54:00 GMT (11 weeks, 1 day and 49 minutes ago)  
>Hi Matthias,  
  
>> I have a (problem) with the L2CAP layer from BlueZ.  
>> I wrote a program that communicates with a mobile phone by using its own  
L2CAP   
>> layer (the program builds its own L2CAP packets for protocol testing).  
>> For example I send a valid "connection request" to that phone and the phone   
>> answers with a valid "connection response".  
>> So far so good.   
>> But then the L2CAP layer from BlueZ sends a "command reject", because this   
>> layer doesn´t know about the "connection request" and cannot handle   
>> the "connection response".  
>> Ok, i understand that.   
>> But has anybody an idea how i can communicate with my own L2CAP layer and  
the   
>> phone only without using the BlueZ L2CAP layer, because the Bluez layer  
always   
>> prevents a further communication?  
>> Hmm... is in this case the L2CAP RAW socket the solution?  
>> I´m stucked with that problem and i hope anybody as an idea.  
  
>as Xavier mentioned the easiest solution is to unload the L2CAP kernel  
>module. However I looked at the code and it seems that the the kernel  
>respond to packets with all idents. It should not do that, because they  
>are shared between the kernel and the userspace. I think a patch for  
>that is needed so that for commands from the RAW socket no responses are  
>send.  
  
>Regards  
  
>Marcel  
 
Hi Marcel,  
  
once i posted a question dealing with an aborted L2CAP communication.  
  
The solution is, that "a patch for that problem is needed so that for commands  
from the RAW socket no responses are send."  ("However I looked at the code  
and it seems that the the kernel respond to packets with all idents. It should  
not do that, because they are shared between the kernel and the userspace.")  
  
Since iam a noob programmer i want to ask, if the problem is already fixed in  
a newer patch or is the problem still existent.  
  
greetings  
Matthias  
 
 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
