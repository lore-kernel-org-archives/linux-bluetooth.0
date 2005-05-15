Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42869C29.3040001@volantis.com>
From: Mark Watson <mark@volantis.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed;
 boundary="------------010604000700000905020402"
Subject: [Bluez-devel] Building btsco for Fedora 3
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
Date: Sun, 15 May 2005 01:47:37 +0100

This is a multi-part message in MIME format.
--------------010604000700000905020402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi. Hopefully this is the right list for this question.

I'm attempting to build btsco and the associated kernel driver for 
Fedora 3, kernel 2.6.11-1.14_FC3

With btsco, I get ...

> make[2]: Entering directory `/tmp/btsco'
> gcc -DHAVE_CONFIG_H -I. -I. -I.    -I/usr/include -Wall -O2 -c a2recv.c
> a2recv.c: In function `make_master':
> a2recv.c:281: error: incompatible type for argument 2 of `hci_switch_role'

So, first question, can I get away with commenting out the relevant call?

Second question concerns the kernel driver, and to be frank my inability 
to keep up with the fedora build process. I get:

> make: *** /lib/modules/2.6.11-1.14_FC3/source: No such file or 
> directory.  Stop.

Turns out no modules source directory was installed with this kernel 
rpm, though it does exist for older kernels. Any tips? I'm guessing this 
is an issue with the kernel rpm?

Any help appreciated.

Mark


--------------010604000700000905020402
Content-Type: text/x-vcard; charset=utf-8;
 name="mark.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mark.vcf"

begin:vcard
fn:Mark Watson
n:Watson;Mark
org:Volantis Systems
adr:Occam Road;;1 Chancellor Court;Guildford;Surrey;GU9 7YT;UK
email;internet:mark@volantis.com
title:Co-Founder and Chief Technology Officer
tel;work:+44 1483 739777
tel;fax:+44 1483 739739
tel;cell:+44 771 489 9417
note:Assistant = Zoe Jones, +44 1483 739773, zoe.jones@volantis.com
x-mozilla-html:TRUE
url:http://www.volantis.com
version:2.1
end:vcard


--------------010604000700000905020402--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
