Return-Path: <dave.givens@phaldor.co.uk>
Message-ID: <418670F2.1090001@phaldor.co.uk>
Date: Mon, 01 Nov 2004 17:22:58 +0000
From: Dave Givens <dave.givens@phaldor.co.uk>
Reply-To: dave.givens@phaldor.co.uk
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Belkin Bluetooth USB Printer Adapter
References: <418601B6.2010905@phaldor.co.uk>	 <1099313330.16247.91.camel@pegasus>  <418650E3.3070909@phaldor.co.uk> <1099324636.16247.135.camel@pegasus>
In-Reply-To: <1099324636.16247.135.camel@pegasus>
Content-Type: multipart/alternative;
 boundary="------------030308080009040906030703"
List-ID: <bluez-users.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------030308080009040906030703
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Marcel;
    Sorry pressed the right button this time.

    I tried using the web front end and still no joy.
    I tried to add a new printer (I have no printers attached other that 
the bluetooth link).
    I entered the name - test and location - localhost, pressed continue.
    Then I select the device 'Unknown Network Device (Bluetooth)', again 
pressed continue.
    Next I entered the URI - bluetooth:/00:02:72:40:80:A3/      and 
pressed continue again.
    Then I selected the make - Canon and pressed continue.
    Lastly I select the model and pressed continue and got the message
                               'client-error-not-authorized'
    Now I suspect that I have not set something up correctly, any help 
appreciated.

Dave Givens
   
Marcel Holtmann wrote:

>Hi Dave,
>
>there must be a "Reply to All" button in your mail client ;)
>
>  
>
>>    I have installed  bluez-utils-2.10, shutdown linux and restarted,
>>but when I enter a custom entry in the print configurer, it will not
>>accept it. I am entering in the following format 
>>
>>bluetooth://0002456574a3/spp
>>
>>is this the incorrect format or am I entering in the wrong place? Is
>>there something else I hav'nt done?
>>    
>>
>
>you don't need to add the protocol, because the backend will identify
>the support protocol by itself. Only fill in the BD_ADDR with the
>colons.
>
>Do you tried the web frontend at localhost:631 ?
>
>Regards
>
>Marcel
>
>
>
>
>  
>

--------------030308080009040906030703
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body>
Marcel;<br>
&nbsp;&nbsp;&nbsp; Sorry pressed the right button this time.<br>
<br>
&nbsp;&nbsp;&nbsp; I tried using the web front end and still no joy.<br>
&nbsp;&nbsp;&nbsp; I tried to add a new printer (I have no printers attached other
that the bluetooth link).<br>
&nbsp;&nbsp;&nbsp; I entered the name - test and location - localhost, pressed
continue.<br>
&nbsp;&nbsp;&nbsp; Then I select the device 'Unknown Network Device (Bluetooth)',
again pressed continue.<br>
&nbsp;&nbsp;&nbsp; Next I entered the URI - bluetooth:/00:02:72:40:80:A3/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; and
pressed continue again.<br>
&nbsp;&nbsp;&nbsp; Then I selected the make - Canon and pressed continue.<br>
&nbsp;&nbsp;&nbsp; Lastly I select the model and pressed continue and got the message<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; 'client-error-not-authorized'<br>
&nbsp;&nbsp;&nbsp; Now I suspect that I have not set something up correctly, any help
appreciated.<br>
<br>
Dave Givens<br>
&nbsp;&nbsp;&nbsp; <br>
Marcel Holtmann wrote:<br>
<blockquote type="cite" cite="mid1099324636.16247.135.camel@pegasus">
  <pre wrap="">Hi Dave,

there must be a "Reply to All" button in your mail client ;)

  </pre>
  <blockquote type="cite">
    <pre wrap="">    I have installed  bluez-utils-2.10, shutdown linux and restarted,
but when I enter a custom entry in the print configurer, it will not
accept it. I am entering in the following format 

bluetooth://0002456574a3/spp

is this the incorrect format or am I entering in the wrong place? Is
there something else I hav'nt done?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
you don't need to add the protocol, because the backend will identify
the support protocol by itself. Only fill in the BD_ADDR with the
colons.

Do you tried the web frontend at localhost:631 ?

Regards

Marcel




  </pre>
</blockquote>
</body>
</html>

--------------030308080009040906030703--
