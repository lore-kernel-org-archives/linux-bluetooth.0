Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45D8958A.7090208@yahoo.com.au>
Date: Sun, 18 Feb 2007 19:06:02 +0100
From: bluez.mexon@spamgourmet.com
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <45D7173C.6090108@yahoo.com.au><CE5216C10C83944D9FD37B65CD33F3970CF472@mplex01.mpl.access-company.com>	<45D873BC.2050305@yahoo.com.au>
	<CE5216C10C83944D9FD37B65CD33F3970CF473@mplex01.mpl.access-company.com>
In-Reply-To: <CE5216C10C83944D9FD37B65CD33F3970CF473@mplex01.mpl.access-company.com>
Subject: Re: [Bluez-devel] RE : bluetooth-alsa: ALSA doesn't recognise
 a2dpd? (bluez: message 14 of 20)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Frederic Dalleau - Frederic.Dalleau@access-company.com wrote:
>>> Hi, just type it manually a2dpd
>> This doesn't work for me either.  I typed "a2dpd" and selected software
>> mixer.  When I press play, the frequency band thing shows a solid
>> horizontal black line, so it looks like it's just unable to write any
>> data out.
> 
> Download and build latest xmms from their site.
> or try another player.
> aplay -Dpcm.a2dpd
> or use pcm.!default instead of pcm.a2dpd.

I tried aplay -Dpcm.a2dpd with a wav file and got this:

aplay -Dpcm.a2dpd testfile.wav
Playing WAVE 'testfile.wav' : Signed 32 bit Little Endian, Rate 44100
Hz, Stereoaplay: set_params:904: Sample format non available

Do you have some particular reason to think that a newer version of XMMS
will work better?  Because it looks to me as though a2dpd is somehow
failing to register itself with ALSA properly, and it's nothing to do
with the player at all.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
