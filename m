Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42244089.7010906@futurlink.com>
From: Pedro Monjo Florit <pedro.monjo@futurlink.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] OBEX Push without pairing
References: <42242BAB.7080406@futurlink.com> <1109667687.17256.140.camel@pegasus>
In-Reply-To: <1109667687.17256.140.camel@pegasus>
Content-Type: multipart/alternative;
 boundary="------------080304070001050107050407"
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
Date: Tue, 01 Mar 2005 11:14:33 +0100

This is a multi-part message in MIME format.
--------------080304070001050107050407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

Marcel Holtmann wrote:
>Hi Pedro,
>
>  
>>I am writing an applications that, among other things, sends an OBEX 
>>Push to a device (e.g. a mobile phone). This is working fine, except for 
>>one thing: whenever I send something to the device, the first time it 
>>always asks for the PIN. I have seen that, for example, kbluetooth (the 
>>KDE Bluetooth framework) and Impronto can send a file without pairing 
>>first. How can I do that?
>>
>>I am sure that I am missing something, but still have not found what. In 
>>my application, I call to socket(), bind() to a local address 
>>(BDADDR_ANY) and then connect(). It is at the connect stage that the 
>>pairing takes place. I have been following the code of kbluetooth and 
>>all I can see is that I am doing essentially the same.
>>    
>
>it seems that your device is working in security mode 3 and then
>actually every ACL connection requests the authentication. The simple
>answer is to use security mode 1/2.
>  
Thank you for your fast answer.

I am not quite sure about the security mode the device is. How can I get 
it? In any case, I have executed (as root):

$ hciconfig hci0 noencrypt
$ hciconfig hci0 noauth

but still no success. With the same computer and configuration and as a 
normal user, if I send a file from KDE using kbtobexclient, it works as 
expected (no PIN requested, just the confirmation for receiving the 
message), so I believe that there is some other things to do. I guess 
that it should be a library call or somthing similar. Any suggestions?

Thanks,

Pedro

--------------080304070001050107050407
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
<br>
Marcel Holtmann wrote:
<blockquote cite="mid1109667687.17256.140.camel@pegasus" type="cite">
  <pre wrap="">Hi Pedro,

  </pre>
  <blockquote type="cite">
    <pre wrap="">I am writing an applications that, among other things, sends an OBEX 
Push to a device (e.g. a mobile phone). This is working fine, except for 
one thing: whenever I send something to the device, the first time it 
always asks for the PIN. I have seen that, for example, kbluetooth (the 
KDE Bluetooth framework) and Impronto can send a file without pairing 
first. How can I do that?

I am sure that I am missing something, but still have not found what. In 
my application, I call to socket(), bind() to a local address 
(BDADDR_ANY) and then connect(). It is at the connect stage that the 
pairing takes place. I have been following the code of kbluetooth and 
all I can see is that I am doing essentially the same.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
it seems that your device is working in security mode 3 and then
actually every ACL connection requests the authentication. The simple
answer is to use security mode 1/2.
  </pre>
</blockquote>
Thank you for your fast answer.<br>
<br>
I am not quite sure about the security mode the device is. How can I
get it? In any case, I have executed (as root):<br>
<br>
$ hciconfig hci0 noencrypt<br>
$ hciconfig hci0 noauth<br>
<br>
but still no success. With the same computer and configuration and as a
normal user, if I send a file from KDE using kbtobexclient, it works as
expected (no PIN requested, just the confirmation for receiving the
message), so I believe that there is some other things to do. I guess
that it should be a library call or somthing similar. Any suggestions?<br>
<br>
Thanks,<br>
<br>
Pedro<br>
</body>
</html>

--------------080304070001050107050407--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
