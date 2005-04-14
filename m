Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <425E18B1.106@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluetooth-alsa no sound
References: <66d811d805041312521f5d6cf4@mail.gmail.com>
In-Reply-To: <66d811d805041312521f5d6cf4@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Thu, 14 Apr 2005 01:16:01 -0600

Mike,

bluetooth-alsa is a pretty fast-moving target. If it's not working, you 
should get the latest from cvs and build it from scratch (see the 
instructions at bluetooth-alsa.sf.net)

Brad

Mike Zhou wrote:
> Hi,
> 
> I am new guy of Linux. Now, I am dealing with Bluetooth-alsa. But
> after I installed all packet, there is no sound.
> 
> I used 2.6.11 kernel with patch-2.6.11-mh2.gz. I also installed the
> newest BLueZ.  I installed the .deb pakage from
> http://cgi.sfu.ca/~jdbates/moin/moin.cgi/Bluetooth%26ALSA?action=diff
> 
> It seems the snd-bt-sco should be worked. After btsco command, I got:
> lab509-8:/home/z0410016# btsco 00:03:89:00:45:ec
> Device is 1:0
> Voice setting: 0x0060
> RFCOMM channel 1 connected
> speaker volume: 11 mic volume: 0
> 
> But I can't get any thing after I enter: aplay --verbose -D
> plughw:Headset test2.wav.
> And the software will not stop unless I kill it.
> 
> The result of --verbose is:
> lab509-8:/home/z0410016# aplay --verbose -D plughw:Headset test2.wav
> Playing WAVE 'test2.wav' : Signed 16 bit Little Endian, Rate 22050 Hz, Mono
> Plug PCM: Rate conversion PCM (8000, sformat=S16_LE)
> Its setup is:
> stream       : PLAYBACK
> access       : RW_INTERLEAVED
> format       : S16_LE
> subformat    : STD
> channels     : 1
> rate         : 22050
> exact rate   : 22050 (22050/1)
> msbits       : 16
> buffer_size  : 11025
> period_size  : 2756
> period_time  : 125000
> tick_time    : 1000
> tstamp_mode  : NONE
> period_step  : 1
> sleep_min    : 0
> avail_min    : 2756
> xfer_align   : 2756
> start_threshold  : 11024
> stop_threshold   : 11025
> silence_threshold: 0
> silence_size : 0
> boundary     : 1445068800
> Slave: Hardware PCM card 1 'BT Headset' device 0 subdevice 0
> 
> Its setup is:
> stream       : PLAYBACK
> access       : MMAP_INTERLEAVED
> format       : S16_LE
> subformat    : STD
> channels     : 1
> rate         : 8000
> exact rate   : 8000 (8000/1)
> msbits       : 16
> buffer_size  : 4000
> period_size  : 1000
> period_time  : 125000
> tick_time    : 1000
> tstamp_mode  : NONE
> period_step  : 1
> sleep_min    : 0
> avail_min    : 1000
> xfer_align   : 1000
> start_threshold  : 4000
> stop_threshold   : 4000
> silence_threshold: 0
> silence_size : 0
> boundary     : 2097152000
> 
> It is the same when I try to use arecord.  How can I fix it? 
> 
> Regards!
> 
> Mike
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_ide95&alloc_id396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
