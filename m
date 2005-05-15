Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4287A0A1.80309@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
References: <20050515145042.70745815.tobias-lang@gmx.de>	<428761F9.7070805@xmission.com> <20050515192044.659654d3.tobias-lang@gmx.de>
In-Reply-To: <20050515192044.659654d3.tobias-lang@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Re: [Bluez-users] Hama BT1000 Headset Problems
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
Date: Sun, 15 May 2005 13:18:57 -0600

Tobias,

My first guess was the the SCO routing was not right for your adapter, 
but if the audio player is blocking on a write, then it's somewhere else.

Again, it could be that the linux drivers don't support audio on your 
adapter.

Brad

Tobias Lang wrote:
> On Sun, 15 May 2005 08:51:37 -0600
> Brad Midgley <bmidgley@xmission.com> wrote:
> 
> 
>>Tobias
>>
>>
>>>However, when I ignore the fact, that I haven't paired yet
>>
>>this sounds strange. when you click the connect button on the headset, 
>>what does btsco print out?
>>
>>brad
> 
> 
> The print out is like this:
> $~: btsco 00:0B:2E:06:15:74 -v
> 	btsco v0.4b
> 	Device is 1:0
> 	Voice setting: 0x0060
> 	RFCOMM channel 6 connected
> 	speaker volume: 15 mic volume: 15
> 	i/o needed: connecting sco...
> 	connected SCO channel
> 	Done setting sco fd
> 	recieved AT+VGS=15                                 #Changeing Volume
> 	Sending up speaker change 15
> 	recieved AT+CKPD=200                              #When pressing the HS button
> 
> I also get one beep out of the HS, when starting XMMS playback via ALSA. However the
> playback doesn't really start. The timecode on the XMMS player stops after 1sec.
> 
> Tobi


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
