Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4100FF67.7020705@india.hp.com>
From: Swarup Mohalik <mohalik@india.hp.com>
Reply-To: mohalik@india.hp.com
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm
References: <200401302209.52396.raydar@nwlink.com>	 <4100F85D.5080200@india.hp.com> <1090583514.4791.42.camel@pegasus>
Content-Type: multipart/alternative;
 boundary="------------030608060906030303030606"
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
Date: Fri, 23 Jul 2004 17:37:03 +0530


--------------030608060906030303030606
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello Marcel,
    Our mails have crossed.

    The machines are different and have two usb dongles from Bluegear
    twin pack from Amazing Tech.

    I will get the hcidump data and get back.

Thx,
Swarup
Marcel Holtmann wrote:

>Hi Swarup,
>
>  
>
>>I have bluez with bluez-utils-2.7 on two RH 8.0 systems (lx1 and lx2).
>>    
>>
>
>please upgrade to bluez-utils-2.8 first. What kernel do you use?
>
>  
>
>>When I start rctest -r on lx1 without starting rctest -s on lx2, lx2 hangs
>>and I have to switch it off and on to restart. This happens EVERY TIME
>>I try this.
>>    
>>
>
>I don't get the point how lx2 can hang when you listen at lx1. Are these
>two different machines or two dongles connected to the same machine?
>
>  
>
>>This does not happen when I run l2test in any way. Does it prove that
>>there is a problem with RFCOMM? I have not seen this problem in
>>the mailing list. If I have missed it, please inform.
>>    
>>
>
>Actually I don't know. Show us "hcidump -x" from both machines.
>
>Regards
>
>Marcel
>
>
>
>  
>


--------------030608060906030303030606
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body>
Hello Marcel,<br>
&nbsp;&nbsp;&nbsp; Our mails have crossed. <br>
<br>
&nbsp;&nbsp;&nbsp; The machines are different and have two usb dongles from Bluegear <br>
&nbsp;&nbsp;&nbsp; twin pack from Amazing Tech.<br>
<br>
&nbsp;&nbsp;&nbsp; I will get the hcidump data and get back.<br>
<br>
Thx,<br>
Swarup<br>
Marcel Holtmann wrote:<br>
<blockquote type="cite" cite="mid1090583514.4791.42.camel@pegasus">
  <pre wrap="">Hi Swarup,

  </pre>
  <blockquote type="cite">
    <pre wrap="">I have bluez with bluez-utils-2.7 on two RH 8.0 systems (lx1 and lx2).
    </pre>
  </blockquote>
  <pre wrap=""><!---->
please upgrade to bluez-utils-2.8 first. What kernel do you use?

  </pre>
  <blockquote type="cite">
    <pre wrap="">When I start rctest -r on lx1 without starting rctest -s on lx2, lx2 hangs
and I have to switch it off and on to restart. This happens EVERY TIME
I try this.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I don't get the point how lx2 can hang when you listen at lx1. Are these
two different machines or two dongles connected to the same machine?

  </pre>
  <blockquote type="cite">
    <pre wrap="">This does not happen when I run l2test in any way. Does it prove that
there is a problem with RFCOMM? I have not seen this problem in
the mailing list. If I have missed it, please inform.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Actually I don't know. Show us "hcidump -x" from both machines.

Regards

Marcel



  </pre>
</blockquote>
<br>
</body>
</html>

--------------030608060906030303030606--



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
