Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Daniel Vollmer <maven@maven.de>
Reply-To: Daniel Vollmer <maven@maven.de>
Message-ID: <475977561.20040824110859@maven.de>
To: Marcel Holtmann <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth Intellimouse Explorer not working after reboot
In-Reply-To: <1093293640.26717.48.camel@pegasus>
References: <167432047.20040823200031@maven.de>
 <1093285155.26717.25.camel@pegasus>  <489665030.20040823205505@maven.de>
 <1093293640.26717.48.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 24 Aug 2004 11:08:59 +0200

Hello Marcel,

Monday, August 23, 2004, 22:40:41, you wrote:

> Hi Daniel,

>> > it looks like such a problem. Try to put a "hidd -K" in the init script
>> > and see if that helps.
>> 
>> Putting "$HIDD_DAEMON -K" into stop_hid() in /etc/init.d/bluez-utils
>> before the start-stop-daemon line has fixed this. I'm CCing this to
>> Edd, maybe he can add that to the bluez init-script.
>> 
>> > Maybe you also need to set the device to non
>> > pageable with "hciconfig hci0 noscan" on shutdown.
>> 
>> Didn't try this as the above worked.

> the point in called "hciconfig hci0 noscan" before you call "hidd -K" is
> that in this case the mouse can't reconnect if you touch it again while
> your machine is shutting down.

But as I kill the hidd-daemon directly after issuing "hidd -K", this
shouldn't be a problem as it wouldn't try to reconnect. Or am I
missing something?


-- 
Best regards,
    Daniel.                         http://www.maven.de
[Open mouth. Insert foot. Echo internationally!]



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
