Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michael Gorbach <mgorbach@yahoo.com>
To: bluez-users@lists.sourceforge.net
References: <20051202220703.C04EF953BA@sc8-sf-spam1.sourceforge.net>
In-Reply-To: <20051202220703.C04EF953BA@sc8-sf-spam1.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Message-Id: <200512021834.19314.mgorbach@yahoo.com>
Subject: [Bluez-users] Errors from hcid
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
Date: Fri, 2 Dec 2005 18:34:19 -0500

I've set up my dinovo bluetooth dongle after some playing around, using 
hid2hci. It is working ok ... but I am getting errors every 5 or 10 minutes 
in my 12th console and in /var/log/messages. They look like this:
Dec  2 18:21:16 swatBox hcid[11586]: Can't send D-BUS inquiry start message
Dec  2 18:21:20 swatBox hcid[11586]: Can't send D-BUS inquiry result message
Dec  2 18:21:24 swatBox hcid[11586]: Can't send D-BUS inquiry complete message
Dec  2 18:26:17 swatBox hcid[11586]: Can't send D-BUS inquiry start message
Dec  2 18:26:20 swatBox hcid[11586]: Can't send D-BUS inquiry result message
Dec  2 18:26:24 swatBox hcid[11586]: Can't send D-BUS inquiry complete message
Can anyone tell me what's going on here, and what i need to do to fix or at 
least get some more info on what's going on?

Thanks,
Michael Gorbach 


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
