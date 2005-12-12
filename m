Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] problem adding 1284 ID SDP attribute
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20051212092649.65060.qmail@web32403.mail.mud.yahoo.com>
References: <20051212092649.65060.qmail@web32403.mail.mud.yahoo.com>
Content-Type: text/plain
Message-Id: <1134380076.1468.9.camel@blade>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 12 Dec 2005 10:34:36 +0100

Hi Arch,

> I am having a problem adding the 1284ID attribute. The 1284ID is of
> type String. (So I use SDP_TEXT_STR8) However, the first 2 characters
> of this string are to be interpreted as a 2-byte length field. The
> length of my string is 80 which is 0x0050 in HEXADECIMAL. So when I
> add it as a string, the SDP function interprets the 1st byte as a null
> terminator and sends an empty string.
>  
> I tried increasing the length of my string to 0x0101 to avoid a 0x00
> byte. However, this cannot be done since the maximum length for an
> SDP_TEXT_STR8 is only 255 which is 0x00FF.
>  
> In this case, how will I be able to add a 1284ID string attribute
> whose length field contains a 0x00 byte?

last week ago or so, Collin ran into the same problem with the HID
report descriptor. It is also a binary string. With bluez-libs-2.23 you
can use sdp_data_alloc_with_length() to specify the length of the string
and then it should work fine.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
