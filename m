Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "João Santos" <jsantos_pt@hotmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F5425UE9chbN2t0002c71b@hotmail.com>
Subject: [Bluez-users] pppd problems
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
Date: Thu, 08 Jan 2004 15:49:52 +0000

Hi all,
Sorry about my bad english.
I don't know what is happening whit the pppd.
I have the mandrake 9.1  whit kernel 2.4.21-0.13mdk.
I have install the ppp-2.3.3 distribution.
PPP modules:

#ppp stuf
alias ppp0 ppp_generic
alias char-major-108    ppp_generic
alias /dev/ppp          ppp_generic
alias tty-ldisc-3       ppp_async
alias tty-ldisc-14      ppp_synctty
alias ppp0              ppp_generic
alias ppp-compress-21   bsd_comp
alias ppp-compress-24   ppp_deflate
alias ppp-compress-26   ppp_deflate

but after folloing the readme instrutions, it didn't work:

[root@olivia /]# pppd
pppd: This system lacks kernel support for PPP.  This could be because
the PPP kernel module is not loaded, or because the kernel is
not configured for PPP.  See the README.linux file in the
ppp-2.3.3 distribution.


i think the problem is because this distribution is very old.
I want to remove this distribution and install a more recent.
where can i download it, and get a good howto?

if you have another suggestion please tell me?

Regards

João Santos

_________________________________________________________________
Add photos to your e-mail with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
