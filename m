Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <421CC068.3050202@futurlink.com>
From: Pedro Monjo Florit <pedro.monjo@futurlink.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: multipart/alternative;
 boundary="------------050400050100090203010409"
Subject: [Bluez-users] Detect the type of remote device
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
Date: Wed, 23 Feb 2005 18:42:00 +0100

This is a multi-part message in MIME format.
--------------050400050100090203010409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi everybody:

While using the BlueZ API's we have discovered that it's difficult to 
find which kind of device (brand and model) we are talking to. We are 
writing an application that delivers an image to any device passing by, 
taking into account its screen width, height and color depth, but 
without any prior knowledge of the device.

Using WAP we have access to the HTTP headers from where you can parse 
the User Agent Profile (UAProf), but we have not found any similar 
function in Bluetooth. In fact, there is the PnPInformation Profile, but 
nowadays is supported in very few devices.

Is there any function or mechanism to retrieve the UAProf data (or 
anything similar) using the BlueZ library?

Thanks & regards,

Pedro Monjo


--------------050400050100090203010409
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Hi everybody:<br>
<br>
<meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
<title></title>
While using the BlueZ API's we have discovered that it's difficult to
find which kind of device (brand and model) we are talking to. We are
writing an application that delivers an image to any device passing by,
taking
into account its screen width, height and color depth, but without any
prior knowledge of the device.<br>
<br>
Using WAP we have access to the HTTP headers from where you can parse
the User Agent Profile (UAProf), but we have not found any similar
function in Bluetooth. In fact, there is the PnPInformation Profile,
but nowadays is supported in very few devices.<br>
<br>
Is there any function or mechanism to retrieve the UAProf data
(or anything similar) using the BlueZ library?<br>
<br>
Thanks &amp; regards,<br>
<br>
Pedro Monjo<br>
<br>
</body>
</html>

--------------050400050100090203010409--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
