Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Alexander Holler <holler@ahsoftware.de>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hid2hci and Logitech Hub
Message-ID: <10920000.1072457386@[192.168.207.2]>
In-Reply-To: <1072451203.2640.11.camel@pegasus>
References: <8430000.1072356496@[192.168.207.2]>
 <1072363056.2876.75.camel@pegasus>  <30700000.1072366993@[192.168.207.2]>
 <1072369721.2876.90.camel@pegasus>  <19230000.1072404120@[192.168.207.2]>
 <1072406653.2876.98.camel@pegasus>  <27150000.1072412780@[192.168.207.2]>
 <1072451203.2640.11.camel@pegasus>
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
Date: Fri, 26 Dec 2003 17:49:46 +0100

Hi Marcel,

--On Freitag, Dezember 26, 2003 16:06:43 +0100 Marcel Holtmann 
<marcel@holtmann.org> wrote:

>> Hmm, such an report I've searched. How to do you got this?
>
> I decoded the HID report descriptor of the HID mouse interface.

> The complete hiddev interface is a mess and I even don't understand the
> basic parts at the moment.

I've looked somewhat deeper into it. When your description is right, it 
seems that the problem is in the usb-hid-parser. According to your 
discovery, the report 16 should have 6 fields, each 8 bits wide (I've read 
some hid-pages ;) ).

I've now put some printk's to hid_register_field in hid-core.c, the parser 
only registers only one field for report 16. So hiddev is correct and it 
complains about trying to send 6 fields with report 16.

Isn't there any free parser for Windows which outputs the report 
descriptions (just for checking before looking deeper into the linux 
parser)?

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
