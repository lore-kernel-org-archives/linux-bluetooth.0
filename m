Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <405EECA6.2080407@india.hp.com>
From: Swarup Mohalik <mohalik@india.hp.com>
Reply-To: mohalik@india.hp.com
MIME-Version: 1.0
To: Xavier Garreau <x.garreau@prim-time.fr>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] l2test problem
References: <405E6C9E.1030600@india.hp.com> <1079937432.2663.78.camel@pegasus>  <405EBCDD.3090402@india.hp.com> <1079951177.2663.90.camel@pegasus> <016701c40ffc$8a07f8d0$b67ba8c0@zaz1>
Content-Type: multipart/alternative;
 boundary="------------020802020500000403090204"
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
Date: Mon, 22 Mar 2004 19:09:50 +0530


--------------020802020500000403090204
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

  Thanks a lot Marcel and Xavier.

Actually I started with a client on the linux PC and a symbian server
on the nokia 3650. I used the API's for l2cap sockets and had set the
psm to 5 (arbitrary choice). Then i got the
    connection refused(111)
message from the PC.

It was now that I wanted to use l2test as a client (just for the 
connection part).
So I changed the psm in l2test.c to 5 and tested. But connection still 
gets refused.
The reason for connect response is always - "psm not supported".

Does this mean that the nokia device may not have l2cap socket support?
I did not find any such information though on the web.

Marcel, please tell me if I am not addressing the forum.

Regards,
Swarup


Xavier Garreau wrote:

>>yes, they are the uint16 numbers besides the uuid16 protocol UUID for
>>L2CAP, but why do you want them? You asked about a mobile phone and most
>>of them are based on the higher layer RFCOMM. So far I haven't seen any
>>phone that support BNEP, HID or HCRP. And this means that in your case
>>only two PSM's are supported. PSM 1 for the SDP requests and PSM 3 for
>>the RFCOMM protocol.
>>    
>>
>
>Symbian Phones like Nokia 3650 allows you to use an L2CAP (or higher) api
>for application programming.
>
>But as with other bluetooth applications, you of course must have a server
>llistening on a given PSM for it to answer "Connection accepted" (0).
>
>mohalik, you should have a look at development papers from Sony Ericcson
>(and maybe nokia) on symbian bluetooth programming (Basically, they also
>provide a socket interface).
>
>http://developer.sonyericsson.com/ (you'll have to create an account first)
>
>BR,
>  
>


--------------020802020500000403090204
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body>
<pre wrap=""></pre>
 Thanks a lot Marcel and Xavier.<br>
<br>
Actually I started with a client on the linux PC and a symbian server<br>
on the nokia 3650. I used the API's for l2cap sockets and had set the <br>
psm to 5 (arbitrary choice). Then i got the <br>
&nbsp;&nbsp;&nbsp; connection refused(111) <br>
message from the PC.<br>
<br>
It was now that I wanted to use l2test as a client (just for the connection
part).<br>
So I changed the psm in l2test.c to 5 and tested. But connection still gets
refused.<br>
The reason for connect response is always - "psm not supported".<br>
<br>
Does this mean that the nokia device may not have l2cap socket support?<br>
I did not find any such information though on the web.<br>
<br>
Marcel, please tell me if I am not addressing the forum.<br>
<br>
Regards,<br>
Swarup<br>
<br>
<br>
Xavier Garreau wrote:<br>
<blockquote type="cite" cite="mid016701c40ffc$8a07f8d0$b67ba8c0@zaz1">
  <blockquote type="cite">
    <pre wrap="">yes, they are the uint16 numbers besides the uuid16 protocol UUID for
L2CAP, but why do you want them? You asked about a mobile phone and most
of them are based on the higher layer RFCOMM. So far I haven't seen any
phone that support BNEP, HID or HCRP. And this means that in your case
only two PSM's are supported. PSM 1 for the SDP requests and PSM 3 for
the RFCOMM protocol.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Symbian Phones like Nokia 3650 allows you to use an L2CAP (or higher) api
for application programming.

But as with other bluetooth applications, you of course must have a server
llistening on a given PSM for it to answer "Connection accepted" (0).

mohalik, you should have a look at development papers from Sony Ericcson
(and maybe nokia) on symbian bluetooth programming (Basically, they also
provide a socket interface).

<a class="moz-txt-link-freetext" href="http://developer.sonyericsson.com/">http://developer.sonyericsson.com/</a> (you'll have to create an account first)

BR,
  </pre>
</blockquote>
<br>
</body>
</html>

--------------020802020500000403090204--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
