Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42244C4D.3030109@futurlink.com>
From: Pedro Monjo Florit <pedro.monjo@futurlink.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] OBEX Push without pairing
References: <42242BAB.7080406@futurlink.com> <1109667687.17256.140.camel@pegasus> <42244089.7010906@futurlink.com> <200503011150.57455.bluez-user@schaettgen.de>
In-Reply-To: <200503011150.57455.bluez-user@schaettgen.de>
Content-Type: multipart/alternative;
 boundary="------------070801020809010006020500"
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
Date: Tue, 01 Mar 2005 12:04:45 +0100

This is a multi-part message in MIME format.
--------------070801020809010006020500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Fred:

Fred Schaettgen wrote:
>On Tuesday 01 March 2005 11:14, Pedro Monjo Florit wrote:
>  
>>but still no success. With the same computer and configuration and as a
>>normal user, if I send a file from KDE using kbtobexclient, it works as
>>expected (no PIN requested, just the confirmation for receiving the
>>message), so I believe that there is some other things to do. I guess
>>that it should be a library call or somthing similar. Any suggestions?
>>    
>
>Are you sure that you are connecting to the rfcomm channel of the obex push 
>service? All others require authentication usually. Maybe you should have a 
>look at hcidump's output to see the difference and at which point the phone 
>is requesting authentication.
>
>Fred
>
>  
Thank you very much for your suggestion. It was indeed what you said. I 
was sending the data to the service "OBEX File Transfer" instead of 
"OBEX Object Push". Now it works exactly as expected.

Cheers,

Pedro

--------------070801020809010006020500
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Hi Fred:<br>
<br>
Fred Schaettgen wrote:
<blockquote cite="mid200503011150.57455.bluez-user@schaettgen.de"
 type="cite">
  <pre wrap="">On Tuesday 01 March 2005 11:14, Pedro Monjo Florit wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">but still no success. With the same computer and configuration and as a
normal user, if I send a file from KDE using kbtobexclient, it works as
expected (no PIN requested, just the confirmation for receiving the
message), so I believe that there is some other things to do. I guess
that it should be a library call or somthing similar. Any suggestions?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Are you sure that you are connecting to the rfcomm channel of the obex push 
service? All others require authentication usually. Maybe you should have a 
look at hcidump's output to see the difference and at which point the phone 
is requesting authentication.

Fred

  </pre>
</blockquote>
Thank you very much for your suggestion. It was indeed what you said. I
was sending the data to the service "OBEX File Transfer" instead of
"OBEX Object Push". Now it works exactly as expected.<br>
<br>
Cheers,<br>
<br>
Pedro<br>
</body>
</html>

--------------070801020809010006020500--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
