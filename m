Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <448591C4.9010102@xmission.com>
Date: Tue, 06 Jun 2006 08:31:32 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <96B7A15232D6CF42836BFD428AD6B6034E556A@deexmb01.de.icap.com>
In-Reply-To: <96B7A15232D6CF42836BFD428AD6B6034E556A@deexmb01.de.icap.com>
Subject: Re: [Bluez-users] bluetooth-alsa: a2recv stutteringsound	from	WM5.0
 AKU2.0
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Guido

>>argh... well i will try to run this test with my brother's aku2 device
>>this weekend and see if i can see the problem.
> 
> Is there any progress?

sorry, I reported it in a new thread.

So when I tried things on an imate jamin aku2 device with a2dp hacked on
top, the audio sputtered a little bit at the start and then worked. It
sounded fine. fwiw, the codec settings it prints out upon connect are:

Channels=2, speed=44100 channel_mode = 2 allocation_method = 1 subbands
= 1 block_length = 1 min_bitpool = 48 max_bitpool = 48

I did run a2recv as a regular user, not root, so that may be why role
switch didn't work. It may be a good thing it didn't work... who knows.

One time it did disconnect on its own with the message "unsupported
signalling command: 9" but other than that, it worked as expected. I did
not play around with avrcp at all.

Brad


_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
