Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bthid,ppc,sdp
From: Marcel Holtmann <marcel@holtmann.org>
To: Ben Wilson <bwilson@yooser.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040519212124.GI15386@stag.mark-and-erika.com>
References: <878yfp4bmz.fsf@handgranat.org>
	 <20040519212124.GI15386@stag.mark-and-erika.com>
Content-Type: text/plain
Message-Id: <1085002651.4327.82.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 19 May 2004 23:37:32 +0200

Hi Ben,

> I did try patch-2.6.6-mh1, but get the following errors:
> 
> net/built-in.o(.text+0x71360): In function `hid_output_report':
> : multiple definition of `hid_output_report'
> drivers/built-in.o(.text+0xf23c0): first defined here
> net/built-in.o(.text+0x715f0): In function
> `hid_find_field_in_report':
> : multiple definition of `hid_find_field_in_report'
> drivers/built-in.o(.text+0xf2650): first defined here
> net/built-in.o(.text+0x714a8): In function `hid_find_field':
> : multiple definition of `hid_find_field'
> ...(etc.)

build the hidp support as module, because it looks like that some
function will collide with the usbhid driver.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
