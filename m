Return-Path: <cyrus@holtmann.org>
Message-ID: <2a9506370811210705g3a81a1c5kc772cf5f81a2bbed@mail.gmail.com>
Date: Fri, 21 Nov 2008 12:05:51 -0300
From: "Vinicius Gomes" <vinicius.gomes@openbossa.org>
To: "Li, Zhigang" <zhigang.li@intel.com>
In-Reply-To: <B94C62E7C2870743865418621F040C1301E82411@pdsmsx502.ccr.corp.intel.com>
MIME-Version: 1.0
References: <B94C62E7C2870743865418621F040C1301E82411@pdsmsx502.ccr.corp.intel.com>
Cc: "bluez-devel@lists.sourceforge.net" <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] What's the maximum size of file by FTP transfer
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

On Fri, Nov 21, 2008 at 5:10 AM, Li, Zhigang <zhigang.li@intel.com> wrote:
> HI Vinicius,
>
> I have one problem for bigger file transfer.
>
> I can't transfer 9MB .mp3 file but 1MB file is ok by FTP.
>
> I know it's difficult to transfer a bigger file which more than 10MB by
> Bluetooth.
>
> I used latest release version in bluez.org.
>
> It even can't open the file, it's not file self problem.
>
> fd = open(filename, O_RDONLY);
>
> What's the limitation in ftp client side? I saw the size should be 2GB.
>

As you already said, the only limitation really is the size of the object
length header (32 bits).

> Do you have same problem? Or any idea/

No. I just tested it here, and it worked fine. But if it is failing on the open
call, it seems it isn't a obex-client issue.

But I would like to know more, perhaps a strace would give more
information on what might be happening.

>
> Thanks
>
>

Cheers,
-- 
Vinicius Gomes
INdT - Instituto Nokia de Tecnologia

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
