Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41D8F10B.5050207@avantwave.com>
From: mike <mikelee@avantwave.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] rfcomm socket and rfcomm tty
References: <41D12158.6020206@avantwave.com>	 <1104315958.6319.13.camel@notepaq>  <41D3600B.8000702@avantwave.com> <1104604967.4253.4.camel@pegasus>
In-Reply-To: <1104604967.4253.4.camel@pegasus>
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
Date: Mon, 03 Jan 2005 15:15:23 +0800

Dear Marcel
    Thanks for reply.

    Is it mean that rfcomm socket can not connect to a rfcomm tty?
    If the answer is yes, Does it mean that all program base on bluez 
should use rfcomm tty to connect to bluetooth Serial Port profile?

    actually, i get mess up something on bluetooth. Please help

best regard
Mike,Lee
   
Marcel Holtmann wrote:

>Hi Mike,
>
>  
>
>>    Here come to a question , i am wrting a socket rfcomm program and 
>>try to use it connect to a bluetooth rfcomm channel by bluez-util rfcomm 
>>listen from two different computer.
>>    
>>
>
>this makes no sense. Either you use rfcomm or you deal with the RFCOMM
>socket in your own program. Both things at the same time are not
>possible. Post more details about your program.
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>The SF.Net email is sponsored by: Beat the post-holiday blues
>Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
>It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
>_______________________________________________
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>  
>



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
