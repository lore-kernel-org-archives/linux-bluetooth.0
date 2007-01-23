Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Tue, 23 Jan 2007 09:12:44 -0800
Message-ID: <D8CE9CFA707C894180BAC8CDD154F8460B0334A7@msiexch01.marvell.com>
From: "Quinton Yuan" <qyuan@marvell.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Bluez-devel Digest, Vol 9, Issue 86
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


Marcel, Mayank

Thanks for your kind reply
1. Chip version is development version, belong to company I am working
for
2. Unfortunately hcitool does not xor the bit before it sends chip, I
just found out this in the hcitool source code, whhile hcidump need to
take care this bit revere definition as well.

Regards/Quinton
-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net
[mailto:bluez-devel-bounces@lists.sourceforge.net] On Behalf Of
bluez-devel-request@lists.sourceforge.net
Sent: Tuesday, January 23, 2007 1:51 AM
To: bluez-devel@lists.sourceforge.net
Subject: Bluez-devel Digest, Vol 9, Issue 86

Send Bluez-devel mailing list submissions to
	bluez-devel@lists.sourceforge.net

To subscribe or unsubscribe via the World Wide Web, visit
	https://lists.sourceforge.net/lists/listinfo/bluez-devel
or, via email, send a message with subject or body 'help' to
	bluez-devel-request@lists.sourceforge.net

You can reach the person managing the list at
	bluez-devel-owner@lists.sourceforge.net

When replying, please edit your Subject line so it is more specific
than "Re: Contents of Bluez-devel digest..."


Today's Topics:

   1. Re: hcidump EDR packet type (Marcel Holtmann)
   2. Re: hcidump EDR packet type (Mayank BATRA)
   3. RE : Still trying to install bluetooth headset on	Mandriva
      2007 for Skype (Frederic Dalleau)
   4. Re: About the pairing event (Fernando Unzu)
   5. SDP: deleting service record attributes (Stephen Crane)
   6. Re: SDP: deleting service record attributes (Marcel Holtmann)


----------------------------------------------------------------------

Message: 1
Date: Tue, 23 Jan 2007 07:23:29 +0100
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] hcidump EDR packet type
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <1169533409.11260.14.camel@violet>
Content-Type: text/plain

Hi,

> Wondering someone can help to enlighten me on where hci packet type
> bit is reversed for  change connection packet type command (issued by
> hcitool) for EDR mode, based on the below hcidump, seems 0x2000 is
> passed down (which should be 0x1306), however, return message ptype
> 0x1306 is correct even decoding is not right.

what does "hciconfig hci0 features version" tell you about your chip
version and manufacturer.

Regards

Marcel





------------------------------

Message: 2
Date: Tue, 23 Jan 2007 12:08:49 +0530
From: Mayank BATRA <mayank.batra@st.com>
Subject: Re: [Bluez-devel] hcidump EDR packet type
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <45B5AD79.8020104@st.com>
Content-Type: text/plain; charset=ISO-8859-1

Hi Quinton,

> Wondering someone can help to enlighten me on where hci packet type
bit
> is reversed for  change connection packet type command (issued by
> hcitool) for EDR mode, based on the below hcidump, seems 0x2000 is
> passed down (which should be 0x1306), however, return message ptype
> 0x1306 is correct even decoding is not right.

In case you wanted to change the packet type to 3-DH5 0x2000 is
perfectly fine since EDR packets are inverted i.e. they will be selected
if the corresponding bit is 0 and not 1. Internally, before sending the
change connection packet type command all stacks (hopefully BlueZ as
well) will xor the packet mask with the EDR packet type list. Thus if
you enabled an EDR packet (eg 0x2000 for 3-DH5), the bit for 3-DH5 will
be made 0 and bits for remaining EDR packets shall be made 1.

0x1306 means that 3-DH5 and DM1 have been selected on the ACL link which
is logical since DM1 is by default selected on all ACL links and you
just changed the packet type to 3-DH5.

=> There is nothing wrong going on except hcidump should be corrected to
parse the packet type mask properly. Here it should have shown only DM1
and 3-DH5.

Best Regards,

Mayank



--
Random Quote Follows:
"In my opinion, shareware tends to combine the worst of commercial
software (no sources) with the worst of free software (no finishing
touches). I simply do not believe in the shareware market at all."
                                              -- Linus Torvalds



------------------------------

Message: 3
Date: Tue, 23 Jan 2007 07:39:53 +0100
From: "Frederic Dalleau" <Frederic.Dalleau@palmsource.com>
Subject: [Bluez-devel] RE : Still trying to install bluetooth headset
	on	Mandriva 2007 for Skype
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Message-ID:
	
<7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EC5@eumonex01.palmsource.com>
Content-Type: text/plain; charset="iso-8859-1"

Retry from configure step using the following :
configure --prefix=/usr --enable-debug=yes

Fr?d?ric




-------- Message d'origine--------
De: bluez-devel-bounces@lists.sourceforge.net de la part de Kinney
Baughman
Date: mar. 23/01/2007 03:25
?: BlueZ development
Objet : Re: [Bluez-devel] Still trying to install bluetooth headset on
Mandriva 2007 for Skype
 
Fr?d?ric DALLEAU wrote:
> Run the commands in the main plugz folder where the bootstrap and 
> configure script are located.
> Or you could erase your current plugz directory and then redo the
whole 
> install procedure.

OK.  I'm finally back home and have started over with cvs checkout for 
plugz.

> Kinney Baughman a ?crit :
>> Fr?d?ric DALLEAU wrote:
>>   
>>> Hi,
>>>     
>>>> A2DPD[596.961]: a2dpd_signal_init: OK
>>>> Segmentation fault
>>>>   
>>>>       
>>> Strange,
>>> could you run it through gdb?
>>> I updated the cvs :
>>> you need to
>>> cvs update
>>> configure --enable-debug=yes
>>> make
>>> make install

At this step, I run into problems.  Here are the last few lines of 
output starting with where things start going wrong:
==================================================
test -z "/usr/local/lib/alsa-lib" || mkdir -p --
/usr/local/lib/alsa-lib"
  /bin/sh ../../libtool --mode=install /usr/bin/install -c 
'libasound_module_pcm_a2dpd.la' 
'/usr/local/lib/alsa-lib/libasound_module_pcm_a2dpd.la'
libtool: install: error: cannot install `libasound_module_pcm_a2dpd.la' 
to a directory not ending in /usr/lib/alsa-lib
  /bin/sh ../../libtool --mode=install /usr/bin/install -c 
'libasound_module_ctl_a2dpd.la' 
'/usr/local/lib/alsa-lib/libasound_module_ctl_a2dpd.la'
libtool: install: error: cannot install `libasound_module_ctl_a2dpd.la' 
to a directory not ending in /usr/lib/alsa-lib
make[3]: *** [install-alsaLTLIBRARIES] Error 1
make[3]: Leaving directory `/var/dl/plugz/alsa-plugins/a2dpd'
make[2]: *** [install-am] Error 2
make[2]: Leaving directory `/var/dl/plugz/alsa-plugins/a2dpd'
make[1]: *** [install-recursive] Error 1
make[1]: Leaving directory `/var/dl/plugz/alsa-plugins'
make: *** [install-recursive] Error 1
==============================================================

I took a look at "/usr/local/lib" and "/usr/lib" and they both have 
"alsa-lib" directories.  Both are owned, writeable and executable by 
root as you can see below:
--
[root@tower] [21:19] [~]: ll /usr/lib/
total 322986
drwxr-xr-x  3 root root     1024 Jan 22 21:09 alsa-lib/
drwxr-xr-x  3 root root     1024 Oct 22 13:01 ao/
drwxr-xr-x  2 root root     2048 Oct 22 13:36 apache/
--
[root@tower] [21:22] [~]: ll /usr/local/lib/
total 28111
drwxr-xr-x  2 root root     1024 Jan 22 21:11 alsa-lib/
drwxr-xr-x  5 root root     1024 Nov 11 14:18 gtk-2.0/

So I don't understand why we're getting that particular error message.

>>> gdb a2dpd
>>>
>>> press 'r'
>>> when it crashes type  'bt' then give us full output.

I didn't even bother to run these commands yet until I get past the 
previous errors.

Thanks for your help.

-- 
Kinney Baughman

------------------------------------------------------------------------
-
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share
your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDE
V
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/ms-tnef
Size: 4792 bytes
Desc: not available
Url :
http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel/attachmen
ts/20070123/a09bced3/attachment.bin 

------------------------------

Message: 4
Date: Tue, 23 Jan 2007 08:40:48 +0100
From: Fernando Unzu <fernando@bluexare.org>
Subject: Re: [Bluez-devel] About the pairing event
To: bluez-devel@lists.sourceforge.net
Message-ID: <200701230840.49172.fernando@bluexare.org>
Content-Type: text/plain;  charset="iso-8859-1"

Ok, I will try to explain me.

I want to make an application who recognize several events produced from
one 
mobile (for example) to other device (in this case, a PC).

I have the control of the PC, and I want to know what kind of event the
mobile 
realized.

If the mobile sends a card, or an image, like this event is realized by
OBEX, 
I put a listen port with RFCOMM in the channel I'm using OBEX.
Therefore, I can know when one device tryes to send me something.

And I want to recognize the pairing event too.

I think the hcid does this, but I don know how to modify (the code) for
my 
necessities.

I have explain me?

Sorry, I don't speak english very well.

Thank you very much.

Fernando Unzu


----------  Mensaje reenviado  ----------

Subject: Re: [Bluez-devel] About the pairing event
Date: Lunes, 22 de Enero de 2007 19:14
From: "Ulisses Furquim" <ulissesf@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>

On 1/22/07, Fernando Unzu <fernando@bluexare.org> wrote:
> I'm working by searching the mode of caught the pairing event with my
PC
> from one mobile.
> Could anybody help me?

Sorry, but I didn't quite understand what you're trying to do. Do you
care to explain so we can help you?

Regards,

-- Ulisses

------------------------------------------------------------------------
-
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share
your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDE
V
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

-------------------------------------------------------



------------------------------

Message: 5
Date: Tue, 23 Jan 2007 09:41:20 +0000
From: Stephen Crane <jscrane@maths.tcd.ie>
Subject: [Bluez-devel] SDP: deleting service record attributes
To: bluez-devel@lists.sourceforge.net
Message-ID: <20070123094120.GA79734@salmon.maths.tcd.ie>
Content-Type: text/plain; charset="us-ascii"

Hi everyone,
I've noticed that service_update_req() in sdpd/service.c doesn't allow
previously-set attributes to be removed from a service record, only
new attributes to be added or existing ones updated.

The attached patch (against CVS) clears an existing service record's 
attributes before reading a new set from an SDP_SVC_UPDATE_REQ message.

Regards,
Steve
-------------- next part --------------
diff -u -r1.20 service.c
--- service.c   20 Jan 2007 20:42:27 -0000      1.20
+++ service.c   22 Jan 2007 17:55:47 -0000
@@ -289,6 +289,9 @@
                        rec->handle = handleExpected;
                        sdp_record_add(device, rec);
                }
+       } else {
+               sdp_list_free(rec->attrlist,
(sdp_free_func_t)sdp_data_free);
+               rec->attrlist = NULL;
        }

        while (localExtractedLength < seqlen) {

------------------------------

Message: 6
Date: Tue, 23 Jan 2007 10:51:01 +0100
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] SDP: deleting service record attributes
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <1169545861.11260.31.camel@violet>
Content-Type: text/plain

Hi Steve,

> I've noticed that service_update_req() in sdpd/service.c doesn't allow
> previously-set attributes to be removed from a service record, only
> new attributes to be added or existing ones updated.
> 
> The attached patch (against CVS) clears an existing service record's 
> attributes before reading a new set from an SDP_SVC_UPDATE_REQ
message.

the patch has been committed to the CVS. Thanks.

Regards

Marcel





------------------------------

------------------------------------------------------------------------
-
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share
your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDE
V

------------------------------

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


End of Bluez-devel Digest, Vol 9, Issue 86
******************************************

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
