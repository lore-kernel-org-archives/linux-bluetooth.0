Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: wimpunk <kwdpggwxwumz@spammotel.com>
Date: Fri, 31 Aug 2007 17:00:06 +0200
Message-ID: <m0nlq4-81a.ln1@l29.abba.lin.vlaanderen.be>
References: <79be12f70708301153s7c6961e3jda270e4fe394d1ca@mail.gmail.com>
Mime-Version: 1.0
In-Reply-To: <79be12f70708301153s7c6961e3jda270e4fe394d1ca@mail.gmail.com>
Subject: Re: [Bluez-users] BlueZ Hcid and D-Bus On ARM
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

John Sample wrote:
> Has anyone here gotten hcid to connect to D-Bus on an embedded ARM 
> system?  I can get the dbus system daemon up an running, but everytime I 
> start hcid it dies right away and I get a "couldn't connect to D-Bus" 
> message in my syslog.  I don't know what else to even try - any 
> suggestions?
> 

John, I have the same problem.  Are you using kernel 2.4?
I think my problem is related to a missing sysfs but I didn't had time
to check that out.



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
