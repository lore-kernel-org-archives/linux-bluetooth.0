Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <f16b04cf05033022021405d585@mail.gmail.com>
From: hariharan veerappan <hariharanneevee@gmail.com>
To: Bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] Bluepin ERROR with RFCOMM
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
Date: Thu, 31 Mar 2005 11:32:58 +0530

Hi,
      we have bind the RFCOMM with bluetooth device using 

rfcomm bind 0 <BD_ADDR> 1
     binding was successful.

while connecting the device with RFCOMM we get error,
      Cannot connect RFCOMM socket: 

As per your mailing list, we checked the HCID dameon running state 
and bluepin working status.

we found that bluepin is not working properly it returns ERR.

please advise to fix this
Thanks and regards
Hariharan.v.


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
