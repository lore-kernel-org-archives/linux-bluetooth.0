Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: ilmari@ilmari.org (=?utf-8?b?RGFnZmlubiBJbG1hcmkg?=
 =?utf-8?b?TWFubnPDpWtlcg==?=)
Message-ID: <d8jllis10s6.fsf@wirth.ping.uio.no>
References: <d8jpt8413da.fsf@wirth.ping.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: ilmari@ilmari.org
Subject: [Bluez-devel] Re: oops when playing audio
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 13 Jun 2004 07:31:53 +0200

ilmari@ilmari.org (Dagfinn Ilmari Mannsåker) writes:

> Hi,
>
> I was just playing around with hstest and my new Bluetooth headset (a
> Jabra BT250, to be precise) when I got this oops after a few minutes'
> playback:
[...]
> Call Trace:
>  [<c021d4c8>] kfree_skbmem+0x8/0x20
>  [<c021d56c>] __kfree_skb+0x8c/0x120
>  [<d09d252e>] bt_sock_recvmsg+0x7e/0xb0 [bluetooth]
>  [<c0219f40>] sock_aio_read+0xb0/0xd0
>  [<c014e7ed>] do_sync_read+0x6d/0xb0
>  [<c016007d>] sys_select+0x24d/0x4b0
>  [<c014e917>] vfs_read+0xe7/0x110
>  [<c014eb38>] sys_read+0x38/0x60
>  [<c0103ef9>] sysenter_past_esp+0x52/0x71

I just had a few other, similar, oopses involving unix_stream_recvmsg
instead of bt_sock_recvmsg, so this is probably not BlueZ' fault, it
just got bit by it first.

Sorry for the bogus report (but the disconnect/reconnect thing is still
valid, it happens independantly of the oopsing).

-- 
ilmari



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
