Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41E93682.9040907@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] scooped by pocketpc (a2dp)
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
Date: Sat, 15 Jan 2005 08:28:02 -0700

hey

it's interesting to note that one of the pocketpc manufacturers 
(audiovox?) was announcing a2dp profile support at the consumer 
electronics show. the implementation has been floating around and i 
tried it out. it needs the occasional soft reset but otherwise works.

anyway, we're no longer ahead of every other commercial OS with our 
implementation, but on the bright side, we should be getting interest 
from more developers.

the next step is still an a2dp userspace alsa driver which has sort of 
stalled (my fault). i would be more excited about it if there was a voip 
application out there that used libalsa. (there's not a way to get oss 
emulation for a userspace alsa driver) kphone uses only oss.

btw, i couldn't find a way in the spec to adjust the a2dp headset's 
audio from the a2dp source. has anyone noticed a way?

brad


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
