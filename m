Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <17479.152.62.109.21.1091436641.squirrel@webmail.fusebox.be>
Subject: Re: [Bluez-users] Palm connection problems.
From: "Johan Van den Brande" <johan@vandenbrande.com>
To: bluez-users@lists.sourceforge.net
Reply-To: johan@vandenbrande.com
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 2 Aug 2004 10:50:41 +0200 (CEST)

Marcal, Virat,

Thanks for the replies!

/dev/rfcomm0 exists:

johan@questor:/tmp/bt> stat /dev/rfcomm0
  File: "/dev/rfcomm0"
  Size: 0               Blocks: 0          IO Block: 4096   Character Device
Device: 303h/771d       Inode: 146053      Links: 1     Device type: d8,0
Access: (0666/crw-rw-rw-)  Uid: (    0/    root)   Gid: (    0/    root)
Access: Fri Jul  9 00:05:38 2004
Modify: Fri Jul  9 00:05:38 2004
Change: Fri Jul  9 00:05:58 2004

(as does 1-255)

The versions I'm using are:
bluez-fw       0.9
bluez-hcidump  1.5
bluez-hciemu   1.0
bluez-libs     2.4
bluez-pan      1.1
bluez-sdp      1.4
bluez-utils    2.3
patch-2.4.22-mh1

I had it working in the past, though. But after a while it stopped
functioning. So I guess something must have changed in the meanwhile.
I'm not sure what, though.

As for the 'bind' solution. The 'rfcomm bind <hw> <channel>' works, but
then the pppd daemon complains about /dev/rfcomm1 not existing ...

Any advice on how I can gather more information (hcidump)?

Regards,
Johan

-- 
Johan Van den Brande





-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
