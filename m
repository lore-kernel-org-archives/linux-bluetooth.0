Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 18 Dec 2006 18:34:26 +0100
From: Stefan Seyfried <seife@suse.de>
To: "Mark S. Townsley" <mstownsley@gmail.com>
Message-ID: <20061218173426.GC13541@suse.de>
References: <be976db60612172156l60a7124bsc9a02b4d1a68c455@mail.gmail.com>
	<20061218090638.GB960@suse.de>
	<be976db60612180843r5faa3f3bwcc8d46e0bea1d31f@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <be976db60612180843r5faa3f3bwcc8d46e0bea1d31f@mail.gmail.com>
Cc: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] minicom over /dev/rfcomm0 failed
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Mon, Dec 18, 2006 at 08:43:58AM -0800, Mark S. Townsley wrote:
> Hi Stefan:  Below are the various info that you asked for.  Let me know if
> you notice anything I did that is wrong.
> =

> =

> linux-fqoe:~ # rfcomm
> rfcomm0: 00:80:98:98:A2:28 channel 1 clean
> linux-fqoe:~ #
> linux-fqoe:~ # id
> uid=3D0(root) gid=3D0(root) groups=3D0(root)
> linux-fqoe:~ # cat /etc/bluetooth/rfcomm.conf
> #
> # RFCOMM configuration file.
> #
> =

> rfcomm0 {
>        bind yes;
>        device 00:80:98:98:A2:28;

is this the correct BDADDR?
Did you already pair the devices?

What SUSE version are you using?

>        channel 1;
> }
> linux-fqoe:~ #
> linux-fqoe:~ # ls -l /dev/rfcomm0
> crw-rw---- 1 root root 216, 0 Dec 18 08:16 /dev/rfcomm0
> linux-fqoe:~ #
> linux-fqoe:~ #
> linux-fqoe:~ # minicom
> LANG/ja
> LANG/ko
> LANG/ru
> minicom: cannot open /dev/rfcomm0: No such file or directory

This works for me, i only get "No such file or directory if i enter the wro=
ng
BDADDR in the rfcomm.conf file or if i wait too long during the "do you want
to allow device foobar to access the internet via the phone" dialog with
confirming (on the phone).
-- =

Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, N=FCrnberg \                    -- Leonard Cohen

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
