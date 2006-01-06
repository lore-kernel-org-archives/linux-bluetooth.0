Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] open obex multisession
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20060106143636.31846.qmail@web53110.mail.yahoo.com>
References: <20060106143636.31846.qmail@web53110.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1136563548.4867.19.camel@localhost>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 06 Jan 2006 17:05:48 +0100

Hi Ermal,

> I tried to send a file to two cellphones at the same time using
> ussp-push.
> I excecuted it in two different consoles. By this time the conections
> freeze and i can't disconnect them anynmore, even using "hcitool dc".
> The only way to disconnect is restart the pc or disconnect the usb
> dongle.
> It gives me the same problem when using two dongles at the same time.
>  
> I saw that in the ussp-push code it binds the local socket in 0
> channel.
> I modified it and tried with diffrent channels for each connection but
> still nothing changed.
>  
> Is it possible what i am trying to do ?
> Acording to bluetooth specification i can make 7 connections
> simultaneously being the master. I controled the connections and i was
> the master.
>  
> is it bluez or open obex responsible for this error?

at the moment I have no idea. Send in the "hciconfig -a" output and
"hcitool info ..." from both phones. Also show us "hcidump -X -V" so we
can see what really happens.

Regards

Marcel





-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
