Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Nicolas STRANSKY <Nico@neo-lan.net>
Message-ID: <d79vmv$i2n$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Latest bluetooth kernel stack
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
Date: Sat, 28 May 2005 16:39:37 +0200

Hi,

I'm trying to patch my kernel with the latest bluetooth kernel stack in 
order to have a MS Intellimouse for Bluetooth to function properly.
The problem is that I'm using a -mm 2.6 kernel and that it seems that 
the bluetooth stack is not so recent in the -mm branch because it makes 
the mouse to be detected as "boot protocol device" instead of "Microsoft 
Five Button Mouse".
So what is the best way to have both 2.6.11-mm patch and 2.6.11-mh2 ? 
Applying both of them fails. Will the -mm bluetooth stack be updated 
soon or is there an better way to do so ?

Thank's in advance !
-- 
Nico
Fuyez un ennemi qui sait votre défaut.
	-+- Pierre Corneille, Polyeucte -+-



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
