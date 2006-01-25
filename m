Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43D7F5C4.70101@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Talkie-Walkie application
References: <001f01c6212d$bfb82880$34208958@claudia>
In-Reply-To: <001f01c6212d$bfb82880$34208958@claudia>
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
Date: Wed, 25 Jan 2006 15:03:48 -0700

Michel

It sounds like you have the luxury of not worrying too much about
latency. Audio is one-way for a walkie-talkie function. Also, you're
writing the code on both ends so you don't have to use any specific
protocol. Choose accordingly.

You could model something after the sco test in bluez or you could model
it after the a2play/a2recv in the btsco project.

sco advantages:
 2-way audio
 low-latency
 low cpu use

a2dp advantages:
 higher quality audio, even stereo
 one-way audio

The SCO transport driver is only completely working for CSR chips.

Brad

> I 'm working on the feasability of a Talkie-Walkie Application
> with two dongles.
>  
>  
> Does somebody knows some books or other documentation which
> can give me information on how to make an audio application with bluez ?
>  
> In your opinion, what is (are) the main(s) problem(s) to realize such
> application ?
>  
>  
> As I have read on the mailing list, the best way to work with SCO
> links under linux
> is to use CSR Chipset. Does anyone know why these chipset is so suited
> to work with linux and so bluez ?
>  
>  
> thanks very much
>  
>  
> Michel  
>  
>  
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
