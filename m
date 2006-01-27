Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43DA64E3.7010401@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] stream a2dp audio to pocket pc fails
References: <10798.1138350079@www023.gmx.net>
In-Reply-To: <10798.1138350079@www023.gmx.net>
Content-Type: text/plain; charset=windows-1252
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
Date: Fri, 27 Jan 2006 11:22:27 -0700

Marc

I'm glad to hear the linux side of things is working. I'm surprised to
hear that your ppc is running an a2dp sink... regardless, you'll have
better luck with the ppc stuff by asking on another list.

Brad

> I’d like to stream audio from my linux pc to a pocket pc ( ce.net WM 2003
> SE).
> 
> mpg123 --au - file.mp3 | sbc/sbcenc - | ./sbc/rcplay 00:0D:3C:30:32:AD –
> ./a2play -s -d -r 44100 00:0D:3C:30:32:AD /dev/dsp
> 
> The link is established and displayed as a2dp on both devices. The pocket pc
> even 
> receives packets from my linux pc but no audio is coming out of my pocket
> device.
> Where are these packets going?
> 
> If I receive the a2dp stream on my linux device via a2recv its works perect,
> incredible quality!!
> 
> Greets marc   
> 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
