Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Timothy Murphy <tim@birdsnest.maths.tcd.ie>
Date: Wed, 01 Aug 2007 13:52:34 +0100
Message-ID: <f8pvmj$3tn$1@sea.gmane.org>
References: <d5920d1e0708010151h1610b190vb7618b71686cba05@mail.gmail.com>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Module bluez not found
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

Hamid MENOUAR wrote:

> Dear all,
> 
> In order to use Bluez to connect some bluetooth device on my computer,
> I have installed on my Linux FC2 the four following packages
> (bluez-libs, bluez-utils, bluez-firmware, bluez-hcidump).
> 
> And, when trying to load the Bluez module manually by doing "modprobe
> bluez" it says "FATAL: Module bluez not found."
> 
> Could anyone help me to explain and solve this?

Why do you think the module is called bluez?

Assuming you are using Fedora you can simply say (as root)
"service bluetooth restart".

Ps FC2 is very old.
You could get more advice from the Fedora list
if you ran Fedora-7 (or even FC6).

-- 
Timothy Murphy  
e-mail (<80k only): tim /at/ birdsnest.maths.tcd.ie
tel: +353-86-2336090, +353-1-2842366
s-mail: School of Mathematics, Trinity College, Dublin 2, Ireland


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
