Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42381733.50901@futurlink.com>
From: Pedro Monjo Florit <pedro.monjo@futurlink.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Multiple Bluetooth connections
References: <42372E0A.80002@futurlink.com> <1110966130.9818.95.camel@pegasus>
In-Reply-To: <1110966130.9818.95.camel@pegasus>
Content-Type: multipart/alternative;
 boundary="------------030905040209060207050106"
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
Date: Wed, 16 Mar 2005 12:23:31 +0100

This is a multi-part message in MIME format.
--------------030905040209060207050106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,
>this is a hardware limit and I don't know of any chip that is capable of
>establishing two connections at the same time. From what I know this
>will never be possible, but you should better ask a radio/baseband
>expert for a correct answer.
>  
Thank you for the information. Together with the post of Peter 
Stephenson (thank you, Peter), it seems that this problem cannot be 
circumvented as I want to connect to different devices (as I understand, 
various ACL connections; is this right?). I will have to live with it. :-(
>>On the other hand, some connections die before sending the data, but it 
>>seems that the file descriptor of this connection does not receive any 
>>notification (I use select() on all file descriptors, with the file 
>>descriptor in the read mask). I know that this could be due to a problem 
>>with my program, a problem with OpenOBEX or the BlueZ version I am using 
>>(it is not the latest). In any case, to track down the cause, I would 
>>like to know how can I monitor the Bluetooth connections (at any level, 
>>but preferably RFCOMM) that a process (or the whole system) has. What I 
>>am looking for is a tool like netstat.
>>    
>
>Using poll() or select() is the right way. About what version of the
>kernel and library/utils are we talking?
>  
I am using SuSE 9.1 with the latest updates from SuSE: kernel 
2.6.5-7.147-default, bluez-libs 2.5-43 and bluez-utils 2.4-65. I know 
they are old, so it could perfectly be a problem with them; therefore I 
am planning an upgrade, but I am not quite sure whether I will be able 
to use the latest BlueZ upgrades. The problem with the lost established 
connections does not happen always, so I still have to look exactly why 
this happens. In any case, besides that, everything else works as 
expected. The only thing I am missing is a tool like "netstat" for 
Internet an Unix sockets. "lsof" does not give any information either. 
Is there anything of the like for BlueZ?

In any, case, thanks for the help.

Pedro

--------------030905040209060207050106
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Hi Marcel,<br>
<blockquote cite="mid1110966130.9818.95.camel@pegasus" type="cite">
  <pre wrap=""><!---->this is a hardware limit and I don't know of any chip that is capable of
establishing two connections at the same time. From what I know this
will never be possible, but you should better ask a radio/baseband
expert for a correct answer.
  </pre>
</blockquote>
Thank you for the information. Together with the post of Peter
Stephenson (thank you, Peter), it seems that this problem cannot be
circumvented as I want to connect to different devices (as I
understand, various ACL connections; is this right?). I will have to
live with it. :-(<br>
<blockquote cite="mid1110966130.9818.95.camel@pegasus" type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap="">On the other hand, some connections die before sending the data, but it 
seems that the file descriptor of this connection does not receive any 
notification (I use select() on all file descriptors, with the file 
descriptor in the read mask). I know that this could be due to a problem 
with my program, a problem with OpenOBEX or the BlueZ version I am using 
(it is not the latest). In any case, to track down the cause, I would 
like to know how can I monitor the Bluetooth connections (at any level, 
but preferably RFCOMM) that a process (or the whole system) has. What I 
am looking for is a tool like netstat.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Using poll() or select() is the right way. About what version of the
kernel and library/utils are we talking?
  </pre>
</blockquote>
I am using SuSE 9.1 with the latest updates from SuSE: kernel
2.6.5-7.147-default, bluez-libs 2.5-43 and bluez-utils 2.4-65. I know
they are old, so it could perfectly be a problem with them; therefore I
am planning an upgrade, but I am not quite sure whether I will be able
to use the latest BlueZ upgrades. The problem with the lost established
connections does not happen always, so I still have to look exactly why
this happens. In any case, besides that, everything else works as
expected. The only thing I am missing is a tool like "netstat" for
Internet an Unix sockets. "lsof" does not give any information either.
Is there anything of the like for BlueZ?<br>
<br>
In any, case, thanks for the help.<br>
<br>
Pedro<br>
</body>
</html>

--------------030905040209060207050106--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
