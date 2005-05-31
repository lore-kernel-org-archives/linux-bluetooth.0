Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <429BCBD3.90205@avantwave.com>
From: mike lee <mikelee@avantwave.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] about rfcomm tty channel listening
References: <429B04EE.5070205@avantwave.com> <1117471183.7072.192.camel@pegasus>
In-Reply-To: <1117471183.7072.192.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Tue, 31 May 2005 10:28:35 +0800

Marcel Holtmann wrote:

>Hi,
>
>  
>
>>    When i bind a rfcomm tty socket, Could i serve mulitple connections
>>at the same time? And how about rfcomm raw socket? if the answer is no,
>>that mean i need to open a new channel to listen.
>>    Also , could i connect the rfcomm channel in the same computer?
>>    
>>
>
>be more specific in what you are trying to do. I can't follow you.
>
>Regards
>
>Marcel
>  
>
    Sorry for my bad english, may be i describe more.
    I am now writing a server program to accept 2 rfcomm connections. I
found that it is not possible to accept 2 connections with same channel.
Why i ask this because, in tcp socket, a server create a socket with
e.g. 80 port. It can then accept multiple connections with the same port
number. The behavior is different between channel and socket.
    So, if i want to make multiple connections with rfcomm, i need to
bind, listen and accept in another rfcomm socket. Does this thinking
correct?

    I hope i can describe more clearly.

>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by Yahoo.
>Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
>Search APIs Find out how you can build Yahoo! directly into your own
>Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>  
>


-- 
Software Engineer
Mike Lee
Avantwave limited
Tel: 852-29527125



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
