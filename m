Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Nokia 6680 services....
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <4344DA83.30300@ruault.com>
References: <4340F256.3040605@ruault.com> <1128339452.22437.6.camel@blade>
	 <4343953D.7070901@ruault.com>
	 <1128511597.5102.2.camel@localhost.localdomain>
	 <4343EF4F.7010901@ruault.com>
	 <1128534736.5447.35.camel@localhost.localdomain>
	 <4344DA83.30300@ruault.com>
Content-Type: text/plain
Message-Id: <1128593198.5492.28.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 06 Oct 2005 12:06:37 +0200

Hi Charles,

> Here you go !

this is weird. We ask for the FTP record handle only. The handle is not
important. We need the channel number:

< ACL data: handle 46 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 1]
        SDP SSA Req: tid 0x0 len 0xd
          pat uuid-16 0x1106 (OBEXObjTrnsf)
          max 65535
          aid(s) 0x0000 (SrvRecHndl)
          cont 00
> ACL data: handle 46 flags 0x02 dlen 24
    L2CAP(d): cid 0x0040 len 20 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0xf
          count 12
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x10005
          cont 00

If you use obexftp then this is a bug. However this is not the big
problem. The problem is the FTP service itself. We get a service
unavailable response:

< ACL data: handle 46 flags 0x02 dlen 36
    L2CAP(d): cid 0x0041 len 32 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 20 pf 0 ilen 28 fcs 0x31
        OBEX: Get cmd(f): len 28
        Type (0x42) = Sequence length 22
        0000: 78 2d 6f 62 65 78 2f 66  6f 6c 64 65 72 2d 6c 69  x-obex/folder-li
        0010: 73 74 69 6e 67 00                                 sting.
> ACL data: handle 46 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 20 pf 1 ilen 3 fcs 0xf7 credits 1
        OBEX: Get rsp(f): status 503 len 3
        Status 503 = Service unavailable

This means another problem. Maybe it is in obexftp or in the phone
itself. I don't know. Maybe you wanna try btftp from the obex CVS
repository of BlueZ. Or someone has to send me such a phone for testing.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
