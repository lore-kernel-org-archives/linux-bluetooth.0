Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41A56774.1000308@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
CC: bmidgley@xmission.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] more encoder stuff
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
Date: Wed, 24 Nov 2004 22:02:44 -0700

Guys,

It was fantastic listening to my headset on the bus today. I didn't have 
to deal with the bluetake dongle at all... very nice.

I updated our project page http://bluetooth-alsa.sourceforge.net/

What should I be using if I want to encode live from the computer's 
line-in? (I want to see if encoding on the computer results in shorter 
latency than the bluetake dongle. Watching TV with the headset is 
currently not all that fun because of the delay.)

Henryk, you were saying the reference encoder runs faster. Is there any 
chance they are using vector processing like sse/sse2? Do projects like 
xine and mplayer detect and use a vector processor through a library?

We should get Sonorix to send us a headset for testing. Have you had 
much luck with vendor cooperation, Marcel? Right now in a2play we sort 
of assume the headset will only report one codec and I suspect they 
support mp3 natively. (It's possible they are pulling tricks like 
transcoding into SBC before uploading mp3's to the headset's flash 
memory I guess.)

Brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
