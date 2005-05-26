Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4295EC2C.3070002@palmsource.com>
From: Frederic Danis <frederic.danis@palmsource.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Problem to connect hci as non-root
References: <4295E697.9060802@palmsource.com> <1117120845.12036.41.camel@pegasus>
In-Reply-To: <1117120845.12036.41.camel@pegasus>
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
Date: Thu, 26 May 2005 17:33:00 +0200

OK, I thought about this but I don't know how to start the 
authentication from an L2CAP socket.
Is it possible ?
Is it possible to acces to hci command from the L2CAP socket ?

Regards

Fred

-----------------------------------------------
It is not by improving the oil lamp that one invents the electric bulb!
-----------------------------------------------
Danis Frederic            PalmSource Europe
Software engineer
Mail : mailto:frederic.danis@palmsource.com
-----------------------------------------------



Marcel Holtmann wrote:

>Hi Fred,
>
>  
>
>>I am trying to write an application that can be used to add or remove 
>>paired devices. But when I try to connect to the remote device (to add 
>>it to the paired devices), I get an error EPERM (when I try it as root, 
>>there is no problem).
>>I can not suid root my application.
>>Is there a way to connect to a device as user, and to be able to do 
>>authentication ?
>>    
>>
>
>why don't you connect a L2CAP channel (for example SDP)?
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by Yahoo.
>Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
>Search APIs Find out how you can build Yahoo! directly into your own
>Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
>_______________________________________________
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel
>  
>


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
