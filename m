Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: =?ISO-8859-1?B?Sm9yZ2UgQS4gR29ueuFsZXo=?= <egrojorge@terra.es>
Reply-To: egroJorge <egroJorge@terra.es>
Message-ID: <692442859.20040519115732@terra.es>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] sdpd crashing (in uclinux)
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
Date: Wed, 19 May 2004 11:57:32 +0200

Hello

I have already "ported" the bluez-utils to uclinux (over an ARM7DMI)
and I realized than sdpd crash whenever other device tries to browse
its services). I have printfed the code and followed it until I found
out that it is the command sdp_put_unligned which is having a
segmentation fault.
I have seen that sdp_put_unligned is defined as a macro depending of
the definition or not of 386 architecture. I will trie to play with
the defines and to port hcidump in order to have more information but
I would like to ask the list about this problem in the case I am not the
first one.

(I think my system is little endian, but I will also trie to be sure of
it today)

Thanks for your help!

Jorge



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
