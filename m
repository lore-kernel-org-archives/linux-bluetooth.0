Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Alexander Holler <holler@ahsoftware.de>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Switching the Logitech-Hub
Message-ID: <8600000.1073220340@[192.168.207.2]>
In-Reply-To: <1073212848.25261.142.camel@pegasus>
References: <10480000.1073193805@[192.168.207.2]>
 <1073212848.25261.142.camel@pegasus>
MIME-Version: 1.0
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
Date: Sun, 04 Jan 2004 13:45:40 +0100

Hi Marcel,

--On Sonntag, Januar 04, 2004 11:40:48 +0100 Marcel Holtmann 
<marcel@holtmann.org> wrote:

> do he got any comments about his patch? Do this patch break any other
> USB HID devices?

I've got no comments, it's not surprising, it's just 8 hours on this list. 
But I also have looked through the sources and up to now, I don't see, why 
this should break other devices. And it seems there are some more people 
with the same problem. e.g.
http://sourceforge.net/mailarchive/forum.php?thread_id=3345181&forum_id=5398

I assume there are also some more who are wondering why sending reports 
using hiddev doesn't work. But not everyone will find the reason. Without 
your help, I wouldn't have find it too.

As the author from the patch writes, it doesn't seem to interrest anyone 
from the usb-devels.

Regards,

Alexander



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
