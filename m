Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41C80A43.4030105@better.se>
From: Marcus Better <marcus@better.se>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] snd-bt-sco and Motorola HS801 success
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
Date: Tue, 21 Dec 2004 12:34:27 +0100

Hi all,

I just wanted to report success using snd-bt-sco with my Motorola HS801 
headset. I am able to play and record sound through the headset.

The only minor glitch seems to be the volume control. I can change the 
volume with the buttons on the headset, but using alsamixer has no 
effect. Moreover, alsamixer shows both the "Master" and "Mic" controls 
in the "playback" view, and no controls in the "capture" view.

Thanks for the nice work!

Marcus


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
