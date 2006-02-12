Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43EE8A78.8030501@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] a2play stops when scanning
References: <Pine.LNX.4.44.0602082335310.13414-100000@lvs-rs3> <43EA8708.1060302@xmission.com> <43EE5A8F.6090303@cs.bgu.ac.il>
In-Reply-To: <43EE5A8F.6090303@cs.bgu.ac.il>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Sat, 11 Feb 2006 18:08:08 -0700

Niv

I have to give a2play the "-p" flag to have it produce audio with no
artifacts. That gives us the most accurate packet timing (using the
real-time clock in a separate pthread).

Brad

> I tried to recreate it.
> managed to stop the audio when I ran the scan, but afterward it came back.
> I will test it better soon
> can you pls test if you can hear this mp3 using:
> mpg321 --au - Letters.mp3 |/uar/bin/a2play <bdaddr>
> 
> http://www.cs.bgu.ac.il/~nivv/Letters.mp3
> 
> It brakes up here.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
