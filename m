Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4231ACAA.3050207@tomtom.com>
From: Dimitry Andric <dimitry.andric@tomtom.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SDP browsing inconsistency on Motorola A1000
References: <423191C1.2020107@tomtom.com> <1110549590.32238.131.camel@baroque.rococosoft.com>
In-Reply-To: <1110549590.32238.131.camel@baroque.rococosoft.com>
Content-Type: multipart/mixed;
 boundary="------------070205070504010905040507"
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
Date: Fri, 11 Mar 2005 15:35:22 +0100

This is a multi-part message in MIME format.
--------------070205070504010905040507
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Crane wrote:

> I don't know what's causing your problem but I've had a look at the
> dumps and it seems that the integer-sequence values being printed out in
> error are in fact from the LANG_BASE_ATTR_ID_LIST, which occurs 44 bytes
> after the SVCLASS_ID_LIST. 

I didn't notice this earlier, but I'd say they are *before* the
ServiceClassIDList:

[...]
Attribute Identifier : 0x0 - ServiceRecordHandle
  Integer : 0x10003
[...]
Attribute Identifier : 0x6 - LanguageBaseAttributeIDList
  Data Sequence
    Code ISO639 (Integer) : 0x656e
    Encoding (Integer) : 0x6a
    Base Offset (Integer) : 0x100
[...]
Attribute Identifier : 0x0 - ServiceRecordHandle
  Integer : 0x10003
Attribute Identifier : 0x1 - ServiceClassIDList
  Data Sequence
    Integer : 0x656e
    Integer : 0x6a
    Integer : 0x100
[...]

At least I've got a bit of a clue where to start looking now. :)


> Can you step through this in a debugger on the ARM box?

I'll need to fix up some things for that, I'll get back about this
later.  I tried debugging on the thing before, but there's some weird
problems with gdb on it.

Usually I try to get by with inserting printfs in various strategic
locations, but the problem here is that I'm not sure where to put
them...


> Also to check for memory corruption, can you run it under valgrind
> on the x86 box?

Valgrind reports no problems, at least as far as I can interpret its
output.  (Attached as valgrind.dump.gz)


> Finally, are you sure that the text of your sdptool-arm dump is correct?
> The data for the record in question seems to be repeated:

Hm, either my mail client or my mail server corrupted this specific
file.  I'm sending it again as a .gz file.


--------------070205070504010905040507
Content-Type: application/octet-stream;
 name="valgrind.dump.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="valgrind.dump.gz"

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
--------------070205070504010905040507
Content-Type: application/octet-stream;
 name="sdptool-arm.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="sdptool-arm.gz"

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
--------------070205070504010905040507--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
