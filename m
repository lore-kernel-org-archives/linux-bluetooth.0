Return-Path: <Mykel@mWare.ca>
Message-ID: <408DDA77.4050908@mWare.ca>
Date: Mon, 26 Apr 2004 23:58:47 -0400
From: Mykel <Mykel@mWare.ca>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
CC: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] can't get bthid
References: <408C4D8D.7090104@yahoo.com.au>  <408C5F5C.1040501@mWare.ca>	 <1082941746.28880.111.camel@pegasus>  <408C72DA.4070205@mWare.ca> <1082973170.28880.114.camel@pegasus>
In-Reply-To: <1082973170.28880.114.camel@pegasus>
Content-Type: multipart/alternative;
 boundary="------------020701020806070808040703"
List-ID: <bluez-users.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------020701020806070808040703
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Marcel Holtmann wrote:

>Hi Mykel,
>
>  
>
>>Hey hey! I got somewhere! (Thanks! I'm so happy about this!) But after
>>reboot, I'm not sure what I was doing wrong... It seems I need to hit
>>connect every time I restart... Maybe I have the sequence of commands
>>wrong?
>>
>>bthid -d
>>hcid
>>bthid -c xx:xx:xx:...
>>    
>>
>
>you should start hcid before you start any other Bluetooth daemon and
>the "bthid -c" is only needed once. The HID device will reconnect by
>itself after you pressed a key.
>
>Regards
>
>Marcel
>
>  
>
Tried this now a few times but it doesn't seem to work, I *must* bthid 
-c and press connect after an extended idle period

Apr 26 22:09:37 immutable logger: ACPI group button/lid / action LID0 is 
not defined
Apr 26 22:32:41 immutable -- MARK --
Apr 26 22:39:38 immutable bthid[1166]: Disconnected: Logitech Bluetooth 
Mouse (046d:b001)

So, it takes 20 minutes to disconnect. I return and there's no mouse 
working obviously:

root@immutable:~# bthid -c 00:07:61:14:5c:a7

==> messages <==
Apr 26 23:30:30 immutable bthid[1166]: Connection failed: Connection 
refused (111)

root@immutable:~# bthid -c 00:07:61:14:5c:a7
root@immutable:~# bthid -c 00:07:61:14:5c:a7
(press connect on mouse)
root@immutable:~#
Apr 26 23:30:38 immutable last message repeated 3 times
Apr 26 23:30:47 immutable bthid[1166]: Connected: Logitech Bluetooth 
Mouse (046d:b001)
root@immutable:~#


--------------020701020806070808040703
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Marcel Holtmann wrote:
<blockquote cite="mid1082973170.28880.114.camel@pegasus" type="cite">
  <pre wrap="">Hi Mykel,

  </pre>
  <blockquote type="cite">
    <pre wrap="">Hey hey! I got somewhere! (Thanks! I'm so happy about this!) But after
reboot, I'm not sure what I was doing wrong... It seems I need to hit
connect every time I restart... Maybe I have the sequence of commands
wrong?

bthid -d
hcid
bthid -c xx:xx:xx:...
    </pre>
  </blockquote>
  <pre wrap=""><!---->
you should start hcid before you start any other Bluetooth daemon and
the "bthid -c" is only needed once. The HID device will reconnect by
itself after you pressed a key.

Regards

Marcel

  </pre>
</blockquote>
Tried this now a few times but it doesn't seem to work, I *must* bthid
-c and press connect after an extended idle period<br>
<br>
Apr 26 22:09:37 immutable logger: ACPI group button/lid / action LID0
is not defined<br>
Apr 26 22:32:41 immutable -- MARK --<br>
Apr 26 22:39:38 immutable bthid[1166]: Disconnected: Logitech Bluetooth
Mouse (046d:b001)<br>
<br>
So, it takes 20 minutes to disconnect. I return and there's no mouse
working obviously:<br>
<br>
root@immutable:~# bthid -c 00:07:61:14:5c:a7<br>
<br>
==&gt; messages &lt;==<br>
Apr 26 23:30:30 immutable bthid[1166]: Connection failed: Connection
refused (111)<br>
<br>
root@immutable:~# bthid -c 00:07:61:14:5c:a7<br>
root@immutable:~# bthid -c 00:07:61:14:5c:a7<br>
(press connect on mouse)<br>
root@immutable:~# <br>
Apr 26 23:30:38 immutable last message repeated 3 times<br>
Apr 26 23:30:47 immutable bthid[1166]: Connected: Logitech Bluetooth
Mouse (046d:b001)<br>
root@immutable:~# <br>
<br>
</body>
</html>

--------------020701020806070808040703--
