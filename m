Return-Path: <cyrus@holtmann.org>
Message-ID: <bd5b16740807110217m6e0587c9oea41ae7aaee667c9@mail.gmail.com>
Date: Fri, 11 Jul 2008 12:17:19 +0300
From: "Ohad Ben-Cohen" <ohad@bencohen.org>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: Re: [Bluez-users] BRF6350 support
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

Hi Pramod,

Please don't send the same question so many times.
I will shortly repeat my answer for the general interest.

On Fri, Jul 11, 2008 at 11:41 AM, pramod gurav
<pramod_gurav_etc@yahoo.co.in> wrote:
> Hi All,
> I am working on arm platform. I want to configure TI's brf6350 bluetooth
> chip on UART.
> I read some of the mail on the list. I came to know that hci_ll.c provides
> support for brf6350.
> Support for these chip is being added to bluez hciattach.
> Is the hci lower level support in kernel enough to drive the chip?

Yes, though you may want to add platform-specific power management
features that let you control the chip power leg and/or let the chip
wake up the host in case of a bluetooth acitivity.
You can take a look how we did that on the OMAP 2430 platform at
http://brflinux.sourceforge.net/.

> Where would I get the brf script file for my chip?

That depends on your specific chip version and personal preferences.

We have a dedicated list for supporting TI's chip - please send your
question there (for details visit the site I mentioned above).

BR,
Ohad.
>
> Thanks and Best regards
>
> Pramod
>
> ________________________________
> Meet people who discuss and share your passions. Join them now.
> -------------------------------------------------------------------------
> Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
> Studies have shown that voting for your favorite open source project,
> along with a healthy diet, reduces your potential for chronic lameness
> and boredom. Vote Now at http://www.sourceforge.net/community/cca08
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
