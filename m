Return-Path: <cyrus@holtmann.org>
Message-ID: <482448F7.80806@powercraft.nl>
Date: Fri, 09 May 2008 14:52:07 +0200
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <4819B1A7.2070702@powercraft.nl>
	<1210336757.28002.31.camel@violet.holtmann.net>
In-Reply-To: <1210336757.28002.31.camel@violet.holtmann.net>
Cc: Brad Midgley <bmidgley@gmail.com>
Subject: Re: [Bluez-users] audio segment with audio glitches
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Marcel Holtmann wrote:
> Hi Jelle,
> 
>> I extracted an audio segment that has the glitches with bluetooth.
>>
>> http://filebin.ca/pugrs/glitch.wav
>> (I can sent the file again if needed)
>>
>> My headset has both bluetooth connection and analogue. The glitches only 
>> happen with the bluetooth connection. I tested it with totem-xine and 
>> totem-gstreamer. They both have the glitches.
>>
>> Also you really have to listen carefully, I have the idea it is only on 
>> the right channel also it does not happens always. My first guess would 
>> be some kind of parameter overflow...
>>
>> Hope this issue becomes reproducible.
> 
> please re-test with bluez-utils-3.31 and always state the version that
> you are using. Otherwise nobody can you tell you anything.
> 
> Regards
> 
> Marcel

I received a new headset device original Motorola s9 and did some more 
testing, and this device does not have the audio glitch! but the 
Motorola s805 definitely has the glitch. The glitch only happens with 
high quality audio, but it does also only happen with bluez, the Toshiba 
stack under windows works fine with the same audio segment.

I attached all device info in an other tread on this mailinglist.

I will test the bluez-utils-3.31 system is there a easy to use Debian 
package for it?

Kind regards,

Jelle


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
