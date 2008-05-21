Return-Path: <cyrus@holtmann.org>
Message-ID: <48336FD4.9040803@judebert.com>
Date: Tue, 20 May 2008 20:41:56 -0400
From: bluez-users.10.judebert@spamgourmet.com
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Syncing a Treo 680
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

Okay, I've read the Wiki.  I've checked out multiple different 
webpages.  I've been subscribed to the mailing list for weeks.  I'm so 
confused I barely know where to start.

All I want is to sync my Treo with my computer.  Specifically, I want to 
back up my data and install programs -- I don't need Outlook 
functionality or even a list of my appointments in a desktop 
application.  Just backup and install.

I read here that I shouldn't use dund, but the Wiki points me to a 
webpage that points me to a tutorial that uses dund. 

I don't program in Python.  Java, C/C++, PHP, and Perl, but not Python.  
I don't want to have to learn Python to sync my phone; I'm busy 
supporting other Open Source projects and just don't have the spare time.

So, I will donate $20 via PayPal to anyone who can provide me with 
step-by-step instructions allowing me to sync my Treo 680 with my Debian 
Unstable computer through my Kensington K33348 dongle using available 
packages and configuration files.  I will use this knowledge to create a 
page on/for the wiki so other users can avoid the trouble.

I understand the first step here is 'hcitool scan' and 'hciconfig'.

$ sudo hcitool scan
Scanning ... (blue light flashes on my dongle)
$ sudo hciconfig
hci0:    Type: USB
    BD Address: 00:19:15:5A:B8:FD ACL MTU: 1017:8 SCO MTU: 64:8
    UP RUNNING PSCAN ISCAN
    RX bytes:694 acl:0 sco:0 events:25 errors:0
    TX bytes:353 acl:0 sco:0 commands:23 errors:0

Respectfully,
Judebert

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
