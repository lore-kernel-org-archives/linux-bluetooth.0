Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Alexander Holler <holler@ahsoftware.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hid2hci and Logitech Hub
Message-ID: <19230000.1072404120@[192.168.207.2]>
In-Reply-To: <1072369721.2876.90.camel@pegasus>
References: <8430000.1072356496@[192.168.207.2]>
 <1072363056.2876.75.camel@pegasus>  <30700000.1072366993@[192.168.207.2]>
 <1072369721.2876.90.camel@pegasus>
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
Date: Fri, 26 Dec 2003 03:02:00 +0100

Hi Marcel,

--On Donnerstag, Dezember 25, 2003 17:28:42 +0100 Marcel Holtmann 
<marcel@holtmann.org> wrote:

> make sure that you always post also the answers to the mailing list ;)

I though that's nothing from interrest for the mailing list. ;)

>> > Logitech uses some specific HID reports to switch the device from HID
>> > to HCI mode. They use the report ID 16 for that and we also must send
>> > the same reports through hiddev interface of the USB HID driver, but
>> > by now I haven't figured out how to do it the right way.
>
> I think it will be this one
>
> 	0x10, 0xff, 0x81, 0x80, 0x00, 0x00, 0x00
>
> The 0x10 is the report ID.

As the report info for 0x10 shows 1 field and the maxusage from that field 
is 1, it seems there is no way sending 6 bytes (usages?) with one report 
0x10 using hiddev (if I have understood that part of hiddev correct ;) ).

I've tried sending 6 reports (0x10) with the values 0xff ... 0x00. That 
hasn't worked (allways remember, I've just started collecting some 
knowledge of usb, bluetooth and hid ;) ).

>> PS: 2.6 and the patch for 2.6 still oops when I disable the
>> bluetooth-device of my nb. Commenting out release of the isoc_iface
>> (which  is still done automacally) helps. I will write these days a
>> report to the  usb-helpline.
>
> For now simply compile your kernel without USB SCO support. I still
> haven't found the time to look deeper into it.

Just remove or comment out the release of the isoc_iface. The release isn't 
needed and that avoids the oops. ;)

> That is not really hard to achieve. I already reverse engineered most of
> the protocol they use on report ID 16 and 17, but I don't found the time
> to write it up.

Nice to hear. I will ask you after I got the hub working as hci. ;)

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
