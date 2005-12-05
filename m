Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Andreas Beck <becka-bzus@bedatec.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] audio transfer from an pc and an headset (one way communication)
Message-ID: <20051205113634.GA5487@acs.uni-duesseldorf.de>
References: <20051205082921.35263.qmail@web36113.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051205082921.35263.qmail@web36113.mail.mud.yahoo.com>
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
Date: Mon, 5 Dec 2005 12:36:34 +0100

Swathi Mathur80 <swathi_mathur80@yahoo.com> wrote:
> I want to do an audio transfer from an PC to an
> headset and not from an headset to an PC. 

Direction doesn't quite matter, as it is a bidirectional link.

> I think i don't need the ALSA module as i don't intend to play
> the audio file on my PC. 

Wrong. You need it, as the headset gets mapped as an audio device
on the PC. 

> Can someone tell me what all the modules needed to be installed 

Read the bluetooth-alsa pages at http://bluetooth-alsa.sourceforge.net/


CU, Andy

-- 
= Andreas Beck                    |  Email :  <becka-sig@bedatec.de>         =


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
