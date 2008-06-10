Return-Path: <cyrus@holtmann.org>
Message-ID: <484EF658.7080006@earthlink.net>
Date: Tue, 10 Jun 2008 16:47:04 -0500
From: "Mumia W.." <paduille.4061.mumia.w+nospam@earthlink.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <971056.49705.qm@web57912.mail.re3.yahoo.com>
In-Reply-To: <971056.49705.qm@web57912.mail.re3.yahoo.com>
Subject: Re: [Bluez-users] bluez commands
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

On 06/10/2008 12:18 PM, hong zhang wrote:
> --- "Mumia W.."
> <paduille.4061.mumia.w+nospam@earthlink.net> wrote:
> 
>> On 06/09/2008 06:05 PM, hong zhang wrote:
>>> List,
>>>
>>> Does any document descripe bluez commands?
>>> My fedora 8 does not return info for "man
>> rfcommd".
>>> ---henry
>>>
>> Have you tried "man rfcomm" ?
>>
> Mumia,
> 
> Thanks.
> But where can I get all bluez commands?
> 
> ---henry
>

On Debian, I can do "dpkg -L bluez-utils" to get a list of all the files 
in a package. Some of those files will be manual pages. I'm sure that 
there is a equivalent command for Fedora 8.

These are the bluez-related manual pages on my Debian 4.0 system:

/usr/share/man/man1/dund.1.gz
/usr/share/man/man1/hidd.1.gz
/usr/share/man/man1/pand.1.gz
/usr/share/man/man1/rfcomm.1.gz
/usr/share/man/man1/sdptool.1.gz
/usr/share/man/man1/ciptool.1.gz
/usr/share/man/man1/hcitool.1.gz
/usr/share/man/man5/hcid.conf.5.gz
/usr/share/man/man8/hcid.8.gz
/usr/share/man/man8/hid2hci.8.gz
/usr/share/man/man8/l2ping.8.gz
/usr/share/man/man8/sdpd.8.gz
/usr/share/man/man8/hciattach.8.gz
/usr/share/man/man8/hciconfig.8.gz

I hope this helps you.


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
