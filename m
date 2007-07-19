Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: David Abrahams <dave@boost-consulting.com>
Date: Thu, 19 Jul 2007 19:52:50 -0400
Message-ID: <87lkdc6je5.fsf@grogan.peloton>
References: <87d4z1fdae.fsf@grogan.peloton>
	<200707101718.52425.thilo@riessner.de>
	<87fy3svw5m.fsf@grogan.peloton>
	<200707161303.29479.thilo@riessner.de>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Why do I have to pair my headset each time?
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


on Mon Jul 16 2007, Thilo Riessner <thilo-AT-riessner.de> wrote:

> Am Freitag, 13. Juli 2007 23:19 schrieb David Abrahams:
>> on Tue Jul 10 2007, Thilo Riessner <thilo-AT-riessner.de> wrote:
>> > Am Dienstag, 10. Juli 2007 00:00 schrieb David Abrahams:
>> >> My cellphone remembers its relationship to my bluetooth headset, but
>> >> it seems the computer does not.  Is there some trick I'm missing?
>> >>
>> >> TIA,
>> >
>> > Sounds like a similar problem I've had with my bluetooth mouse (see
>> > thread: "HP Bluetooth PC Card Mouse"). I solved it by starting the hidd
>> > with the following options:
>> > --connect 00:02:76:00:D0:3E --master --server
>> > (with your correct bluetooth address of course)
>> > openSuSE 10.2 to starts the hidd during system boot with the arguments
>> > found in the variable HID_DAEMON_ARGS in the file
>> > /etc/sysconfig/bluetooth. I guess, other distributions have similar
>> > mechanisms. So you need not to set this options every time after a
>> > restart.
>>
>> Yes, that's what I do with my mouse.  But I was under the impression
>> that the BT device (mouse in that case) had to be on at startup for
>> the above to work.  My headset is often not on, or not nearby.  Does
>> that make a difference?
> No, it works like you would expect to. No matter weather it is switched on by 
> hand, or wakes up after a sleep, it works after a about 2 seconds.

Made no discernable difference for me. :(

This is in my /etc/default/bluetooth:

  HIDD_OPTIONS="--connect 00:07:61:35:FE:A9 --connect 00:19:7F:21:EE:73 --master --server"

The mouse, which works, is 00:07:61:35:FE:A9.  The other one is the
headset, which I still have to explicitly pair with in order to
connect.

-- 
Dave Abrahams
Boost Consulting
http://www.boost-consulting.com

The Astoria Seminar ==> http://www.astoriaseminar.com


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
