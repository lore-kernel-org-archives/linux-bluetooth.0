Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] open obex multisession
From: "Collin R. Mulliner" <collin@betaversion.net>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20060106143636.31846.qmail@web53110.mail.yahoo.com>
References: <20060106143636.31846.qmail@web53110.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1136558831.31793.17.camel@panic>
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
Date: Fri, 06 Jan 2006 15:47:11 +0100

Hi,

> I tried to send a file to two cellphones at the same time using
> ussp-push.
long time ago since I used ussp-push, try some other tool like btobex or
obexftp

> I excecuted it in two different consoles. By this time the conections
> freeze and i can't disconnect them anynmore, even using "hcitool dc".
> The only way to disconnect is restart the pc or disconnect the usb
> dongle.
mmh did you get a kernel ups?

> It gives me the same problem when using two dongles at the same time.
the second dongle musst be used explecite otherwise only the first
dongle is used (right Marcel?)

> I saw that in the ussp-push code it binds the local socket in 0
> channel.
> I modified it and tried with diffrent channels for each connection but
> still nothing changed.
there is not local channel on outgoing connections

> Is it possible what i am trying to do ?
yes

> Acording to bluetooth specification i can make 7 connections
> simultaneously being the master. I controled the connections and i was
> the master.
are you sure? maybe on of the devices tryed a role switch
 
> is it bluez or open obex responsible for this error?
I guess you/ussp-push are/is the problem

> what can i do to fi x it and send files to more than one phone at the
> same time?

run hcidump and see what happens on the lower layers when you send the
files.

... Collin

--
Collin R. Mulliner <collin@betaversion.net>
BETAVERSiON Systems [www.betaversion.net]
info/pgp: finger collin@betaversion.net
Commander, there is no careful way to question a Klingon. --Odo



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
