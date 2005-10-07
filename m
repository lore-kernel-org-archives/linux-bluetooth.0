Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <434644FD.6000001@ruault.com>
From: Charles-Edouard Ruault <ce@ruault.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Question regarding sdptool
References: <43463752.7000802@ruault.com> <1128677887.8750.18.camel@localhost.localdomain>
In-Reply-To: <1128677887.8750.18.camel@localhost.localdomain>
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
Date: Fri, 07 Oct 2005 11:50:53 +0200

Marcel Holtmann wrote:

>Hi Charles,
>
>  
>
>>i'm developping a Midlet using JSR82 on a Nokia 6680.
>>The midlet is running as a server and therefore registers a service in
>>the device SDP.
>>I had been desperately trying to see if everything was going ok on the
>>device using sdptool browse add and i was not seeing my service ...
>>I was getting kind of desperate since everything was looking fine in my
>>code when i tried using
>>sdptool records btaddr and there i saw my service listed !
>>Can someone explain the difference between the browse & records options
>>of sdptool ?
>>    
>>
>
>the browse command looks for records in the public browse group and the
>records command brute forces the record handles 0x10000 onwards.
>
>  
>
Ok so that means that my sevice has not been added to the public browse
group ... I'll try to figure out how to do that with JSR82
Sorry for the basic questions but i'm just getting started with
bluetooth and i still have a lot to learn !
Thanks for the explanation ! Things are getting clearer now.

>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by:
>Power Architecture Resource Center: Free content, downloads, discussions,
>and more. http://solutions.newsforge.com/ibmarch.tmpl
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users
>  
>


-- 
Charles-Edouard Ruault
GPG key Id E4D2B80C



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
