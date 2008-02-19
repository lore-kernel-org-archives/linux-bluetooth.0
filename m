Return-Path: <cyrus@holtmann.org>
Message-ID: <e378cfb20802190657m69936857ob676ad575842c222@mail.gmail.com>
Date: Tue, 19 Feb 2008 20:27:49 +0530
From: "Nel D" <newatlinux@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <47BAC7BC.7050503@wurmsdobler.org>
MIME-Version: 1.0
References: <47BAC7BC.7050503@wurmsdobler.org>
Subject: Re: [Bluez-users] Unable to get on D-Bus
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

On 2/19/08, Peter Wurmsdobler <peter@wurmsdobler.org> wrote:
> Hello,
>
> This topic has already come up several times, but the respective answers
> did not solve the problem for me. What happens is:
>
> mx27# /usr/bin/dbus-daemon --system
> mx27# /usr/sbin/hcid -n -f /etc/bluetooth/hcid.conf
> hcid[1869]: Bluetooth HCI daemon
> hcid[1869]: Could not become the primary owner of org.bluez
> hcid[1869]: Unable to get on D-Bus


I think one of the following cases are possible:

1. An earlier hcid is already running. Check ps ax | grep hcid to confirm.
or
2. You are not root while running hcid .


HTH.

nel

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
