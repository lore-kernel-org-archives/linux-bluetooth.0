Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 18 Dec 2006 10:06:38 +0100
From: Stefan Seyfried <seife@suse.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20061218090638.GB960@suse.de>
References: <be976db60612172156l60a7124bsc9a02b4d1a68c455@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <be976db60612172156l60a7124bsc9a02b4d1a68c455@mail.gmail.com>
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

On Sun, Dec 17, 2006 at 09:56:40PM -0800, Mark S. Townsley wrote:
> Hi:
> I am trying to use minicom on my SuSE box to receive connections from an
> external device that connect, via Bluetooth, and handshake with the AT
> command set.
> I have /dev/rfcomm0.  I also have entries in /dev/rfcomm0 that binds to t=
he
> BT_ADDR of that external device.
> However, when I run minicom (with serial device set to /dev/rfcomm0), I g=
ot
> back:
> =

>  minicom: cannot open /dev/rfcomm0: No such file or directory.
> =

> I do have /dev/rfcomm0 and the permission on it looks correct.

Please show us your /etc/bluetooth/rfcomm.conf, the output of "rfcomm" as
root, "ls -l /dev/rfcomm0" and "id" as your user.
-- =

Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out." =


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
