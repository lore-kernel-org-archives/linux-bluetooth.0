Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Markus Kohli <kohli@webdeko.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200502120858.46323.kohli@webdeko.com>
Subject: [Bluez-devel] DiNovo in Bluetooth-Mode
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 12 Feb 2005 08:58:46 +0100

Hi

I read some posts in the archives, because I was trying to get my DiNovo 
working under SuSE 9.2, and found this here:

>  > I tested it with SuSE 9.2, Fedora Core 3 and Ubuntu. The only thing you 
have 
>  > to do, is to call
>  > 
>  > hid2hci
>  > 
>  > Then you should see a message, like
>  > 
>  > Switching device XXXX:XXXX to HCI mode was successful
>  > 
>  > Now check with
>  > 
>  > hcitool dev
>  > 
>  > if it sees the bluetooth hub.
>  > 
>  
>  yes it did that, said it was successful, 
>  BUT the keyboard & mouse stopped responding! 
>  The only way to get them working again was to reboot.
>  
>  Laurence

Now, I found out how to get this working... Only enable the following 
bluetooth-services:
HCI
SDP 
HID 
HID2HCI

If you have any others, like obex stuff enabled, that'll block the keyboard 
and the mouse. With SuSE you can easily configure that by help of yast2, or 
by hand in /etc/sysconfig/bluetooth. 
Then additionaly, once I had this working, the F-keys had gone missing, but an 
update to the latest kernel-of-the-day also fixed that (I'm running on 
2.6.11rc3 now, that's probably got the -mh patch included).

Hope this helps anyone.

Kind regards
Markus


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
