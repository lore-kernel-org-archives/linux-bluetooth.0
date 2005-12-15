Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <1513322956@web.de>
MIME-Version: 1.0
From: Wolfgang Krug <w-krug@web.de>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-devel] Modify scotest?
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
Date: Thu, 15 Dec 2005 18:10:41 +0100

Hi@ all!

I have the following problem, maybe you can help me.

I need to meassure the quality of a bluetooth SCO link, therefore I want to send a data file over a SCO Link like OBEX.
So I want to see whats transmitted on client side, comparing with the original file, for the purpose to detect bit errors a.s.o.
Is this possible with the scotest tool - actually it seems to me that I can only send a predetermined number of bytes through the SCO connection and receive them on the client side. 
Or am I wrong and there is another solution for my  project ?


Regards

Wolfgang


Ps. I have two Bluecore 3 Dongles, SCO is mapped to HCI - if its relevant.
__________________________________________________________________
Nur bis 31.12.: 1&1 DSL mit WEB.DE Preisvorteil! Jetzt einsteigen 
und die Vorteile sichern! http://1und1dsl.web.de/?mc=021130



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
