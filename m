Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hci_read_rssi command
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20060111064537.14602.qmail@web50514.mail.yahoo.com>
References: <20060111064537.14602.qmail@web50514.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1136968410.26114.5.camel@localhost.localdomain>
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
Date: Wed, 11 Jan 2006 09:33:30 +0100

Hi Mahtab,

> You are right. I have fedora core 3 in my lab and I think it comes
> with this version of bluez.
> [root@70-52 mahtab]# rpm -qa bluez*
> bluez-bluefw-1.0-6
> bluez-pin-0.23-3
> bluez-hcidump-1.11-1
> bluez-utils-2.10-2
> bluez-libs-devel-2.10-2
> bluez-libs-2.10-2
> bluez-utils-cups-2.10-2
> 
> I thought I had installed the recent bluez packages and was looking
> into the codes of bluez-2.24 packages. That explains the error.
> Anyway, I could solve the problem of my_hci_read_rssi function - it
> was a stupid typo. I should have literally copied your hci_read_rssi
> function rather than typing it myself. But again, I am not fond of
> your choice of variables either (rq, rp etc. :P which was the reason
> of my typo). :D
> 
> As I will be making a GUI version considering only RSSI, LQ & TPL
> part, I think I will not go into installing the newer version of bluez
> (I also work on my ancient Laptop which has bluez-2.4-1).
> I have chosen GTK+ for dealing with the GUI version. Any suggestions
> on that?
> My work is to record RSSI, LQ and TPL correcponding to a location
> (i.e. location fingerprint) in a user-friendly way!

since graphical applications are event driven you might wanna use the
HCI raw interface directly instead of calling the API functions, but
that would be only a minor detail. Otherwise there shouldn't be any big
problems.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
