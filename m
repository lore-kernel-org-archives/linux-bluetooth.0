Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <40E346A8.2050209@mip.sdu.dk>
From: Peter Favrholdt <pfavr@mip.sdu.dk>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] snd-bt-sco
References: <40E33BF2.7010705@mip.sdu.dk>
In-Reply-To: <40E33BF2.7010705@mip.sdu.dk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 01 Jul 2004 01:03:04 +0200

Hi again,

Well, I figured out I didn't have the /dev/snd/* device files

So now it almost works. The headset seems connected. I can use alsamixer (and 
the volume buttons on the headset changes the volume in the mixer window). 
hciconfig shows data is flowing at a steady rate from the microphone:

hci0:   Type: USB
         BD Address: 00:0B:0D:20:79:21 ACL MTU: 339:4  SCO MTU: 64:0
         UP RUNNING PSCAN ISCAN
         RX bytes:8895374 acl:72 sco:329395 events:232 errors:0
         TX bytes:3768 acl:151 sco:0 commands:47 errors:0

But no sound

I'll try some more.

BR

Peter

Peter Favrholdt wrote:
> Hi bluez developers,
> 
> I'm not sure if this is the right forum. I'm probably in-between 
> alsa-user, bluez-user, kernel-user? But here goes anyway:-)
> 
> I just tried getting the Logitech HS01 bluetooth headset working on 
> kernel 2.6.6 (debian unstable), using the ALSA driver from 
> http://www.dcs.gla.ac.uk/~jp/snd-bt-sco/
> 
> Anyone had success with getting a headset working?
> 
> I know this driver is a hack, but it would be cool to have skype working 
> using a headset under linux.
> 
> BR
> 
> Peter
> 
> --- cut: long and windy story about my adventures ---
<snip>


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
