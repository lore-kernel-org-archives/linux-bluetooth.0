Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4204D19B.1090108@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] rfcomm question 3
References: <20050205124828.1758.qmail@web60903.mail.yahoo.com>	 <4204C77D.1040207@gmx.ch> <1107611491.6921.133.camel@pegasus>
In-Reply-To: <1107611491.6921.133.camel@pegasus>
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
Date: Sat, 05 Feb 2005 15:00:59 +0100

Hello Marcel

Thanks a lot. I hoped someone more c experienced will take a quick look at 
my code. It's the result of a example I found (the mistake comes from 
there) and a socket programming howto I read.

I now changed it to
addr.rc_channel = 4;

Actually I do not need to #define it for the whole file.

regards
Marco


Marcel Holtmann wrote:
> Hi Marco,
> 
> 
>>Maybe this helps:
>>
>>---- start code snippet ----
>>// handle the includes yourself
>>
>>#define CHANNEL 4
>>#define QUEUE 10
>>
>>int main()
>>{
>>	int sock, client;
>>	socklen_t alen;
>>	struct sockaddr_rc addr;
>>
>>	addr.rc_family = AF_BLUETOOTH;
>>	bacpy(&addr.rc_bdaddr, BDADDR_ANY);
>>	addr.rc_channel = htobs(CHANNEL);
> 
> 
> thanks for the example, but the htobs(CHANNEL) is wrong. rc_channel is
> only uint8_t and when you do byteswap on a big endian machine this will
> end up in channel 0.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
> Tool for open source databases. Create drag-&-drop reports. Save time
> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
