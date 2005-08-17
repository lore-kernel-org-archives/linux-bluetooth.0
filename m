Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4303636D.4080305@palmsource.com>
From: Frederic Danis <frederic.danis@palmsource.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bluetoothd D-Bus interface proposals(draft 00.03)
References: <e1effdeb05080412401bc562f6@mail.gmail.com>	 <42F36564.9010505@palmsource.com> <e1effdeb050811101346f4ddd6@mail.gmail.com>
In-Reply-To: <e1effdeb050811101346f4ddd6@mail.gmail.com>
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
Date: Wed, 17 Aug 2005 18:18:53 +0200

Hello,

I agree with you that it is really import to have 
connection/disconnection signals from object hierarchy subsection.
But I think it can be helpfull to have those signals from hci level for 
an "application" which wants to display bluetooth states to user, even 
if bluetoothd does not know the profile used.

Regards,
Fred

-----------------------------------------------
It is not by improving the oil lamp that one invents the electric bulb!
-----------------------------------------------
Danis Frederic            PalmSource Europe
Software engineer
Mail : mailto:frederic.danis@palmsource.com
-----------------------------------------------



Claudio Takahasi wrote:

>Hi folks,
>
>
>I am sending a new draft(v00.03) of the bluetoothd D-Bus interfaces.
>
>BlueZ community, please send your feedback. I need collect your opinions
>and discuss with Marcel.
>
>The most important part for now is hci, hciconfig, sdp and bluetoothd.
>
>The documents are available at:
>http://www.cin.ufpe.br/~ckt/bluez/
>
>Fred, thanks for your comment. I am not sure if is useful send
>signal for connection/disconnection from hci. I think they should
>be restricted to object hierarchy subsection(pan, dun, rfcomm, ..).
>But we can discuss with the BlueZ community in order to verify if
>these signals will be required or not.
>
>
>Regards,
>Claudio.
>
>
>On 8/5/05, Frederic Danis <frederic.danis@palmsource.com> wrote:
>  
>
>>Hello Claudio,
>>
>>I think it could be usefull to get remote device
>>connection/disconnection signal from hci.
>>
>>Regards,
>>Fred
>>
>>-----------------------------------------------
>>It is not by improving the oil lamp that one invents the electric bulb!
>>-----------------------------------------------
>>Danis Frederic            PalmSource Europe
>>Software engineer
>>Mail : mailto:frederic.danis@palmsource.com
>>-----------------------------------------------
>>
>>
>>
>>Claudio Takahasi wrote:
>>
>>    
>>
>>>Hi folks/Marcel,
>>>
>>>I am sending a new version of bluetoothd D-Bus interfaces document.
>>>
>>>When you have time, please look this document to see if the interfaces
>>>names, object paths and services are following your ideas.
>>>
>>>The documents are available at:
>>>http://www.cin.ufpe.br/~ckt/bluez/
>>>
>>>
>>>Regards,
>>>Claudio
>>>
>>>
>>>-------------------------------------------------------
>>>SF.Net email is Sponsored by the Better Software Conference & EXPO
>>>September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
>>>Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
>>>Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
>>>_______________________________________________
>>>Bluez-devel mailing list
>>>Bluez-devel@lists.sourceforge.net
>>>https://lists.sourceforge.net/lists/listinfo/bluez-devel
>>>
>>>
>>>      
>>>
>>-------------------------------------------------------
>>SF.Net email is Sponsored by the Better Software Conference & EXPO
>>September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
>>Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
>>Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
>>_______________________________________________
>>Bluez-devel mailing list
>>Bluez-devel@lists.sourceforge.net
>>https://lists.sourceforge.net/lists/listinfo/bluez-devel
>>
>>    
>>
>
>
>-------------------------------------------------------
>SF.Net email is Sponsored by the Better Software Conference & EXPO
>September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
>Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
>Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
>_______________________________________________
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel
>  
>


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
