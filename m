Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Alexander Holler <holler@ahsoftware.de>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Success: switching the Logitech-Hub
Message-ID: <13690000.1073440312@[192.168.207.2]>
In-Reply-To: <1073411335.2508.96.camel@pegasus>
References: <9810000.1073197538@[192.168.207.2]>
 <1073267036.3804.4.camel@pegasus>  <20040106171510.GE15149@smartdata.ch>
 <1073411335.2508.96.camel@pegasus>
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
Date: Wed, 07 Jan 2004 02:51:52 +0100

Hello,

--On Dienstag, Januar 06, 2004 18:48:55 +0100 Marcel Holtmann 
<marcel@holtmann.org> wrote:

>> One question: I can't switch back to USB mode. Is this not supported at
>> this time ?
>
> No. I think it is possible, but at the moment we don't understand how
> the Logitech protocol works. I have some written notes about it on my
> desktop, because they also use the same protocol framework for driving
> the display of the mediapad. But I haven't found the time to setup a
> webpage about it.

I don't know if Logitech knows how to switch back. ;)

At least I've send them a bug report, that the widcomm-stack should switch 
back to usb-mode when deinstalling the stack.

I've discovered that because I've got the answer "reinstall all" 2 times 
for a problem. But deinstalling the stack leaves me with a box, I could 
only reset using a hw-switch, which isn't that fine. The problem I now 
have, is to explain this to help desk. The first time they didn't 
understand what I mean. ;)

When they will fix that, I will try to log the usb-communication while 
deinstalling the stack, which should give me the correct sequence of 
reports for switching back.

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
