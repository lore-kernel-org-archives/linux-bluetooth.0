Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 23 May 2008 07:47:51 -0700
Message-ID: <F60A3CE9E807BE49B5F56BD80B894D20016883DF@sc-exch03.marvell.com>
References: <48336FD4.9040803@judebert.com>
From: "Angus Ainslie" <aainslie@marvell.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Syncing a Treo 680
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

> -----Original Message-----
> From: bluez-users-bounces@lists.sourceforge.net 
> [mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf 
> Of bluez-users.10.judebert@spamgourmet.com
> Sent: Tuesday, May 20, 2008 6:42 PM
> To: bluez-users@lists.sourceforge.net
> Subject: [Bluez-users] Syncing a Treo 680
> 
> Okay, I've read the Wiki.  I've checked out multiple 
> different webpages.  I've been subscribed to the mailing list 
> for weeks.  I'm so confused I barely know where to start.
> 
> All I want is to sync my Treo with my computer.  
> Specifically, I want to back up my data and install programs 
> -- I don't need Outlook functionality or even a list of my 
> appointments in a desktop application.  Just backup and install.
> 
> I read here that I shouldn't use dund, but the Wiki points me 
> to a webpage that points me to a tutorial that uses dund. 
> 
> I don't program in Python.  Java, C/C++, PHP, and Perl, but 
> not Python.  
> I don't want to have to learn Python to sync my phone; I'm 
> busy supporting other Open Source projects and just don't 
> have the spare time.
> 
> So, I will donate $20 via PayPal to anyone who can provide me 
> with step-by-step instructions allowing me to sync my Treo 
> 680 with my Debian Unstable computer through my Kensington 
> K33348 dongle using available packages and configuration 
> files.  I will use this knowledge to create a page on/for the 
> wiki so other users can avoid the trouble.
> 
> I understand the first step here is 'hcitool scan' and 'hciconfig'.
> 
> $ sudo hcitool scan
> Scanning ... (blue light flashes on my dongle) $ sudo hciconfig
> hci0:    Type: USB
>     BD Address: 00:19:15:5A:B8:FD ACL MTU: 1017:8 SCO MTU: 64:8
>     UP RUNNING PSCAN ISCAN
>     RX bytes:694 acl:0 sco:0 events:25 errors:0
>     TX bytes:353 acl:0 sco:0 commands:23 errors:0
> 
> Respectfully,
> Judebert
> 


Hi Judebert,

There a howto on pilot-link's site. It not only allows you to
backup/install. You could also sync to evolution or surf the web.

The page is old but should still be valid for new devices. I use a
similar setup to sync and surf on my Treo 650.

http://howto.pilot-link.org/bluesync/

Angus

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
