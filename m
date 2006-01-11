Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20060111064537.14602.qmail@web50514.mail.yahoo.com>
From: Mahtab Hossain <mahtab_hossain2002@yahoo.com>
Subject: Re: [Bluez-users] hci_read_rssi command
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1136909383.7200.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1315026452-1136961937=:7870"
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
Date: Tue, 10 Jan 2006 22:45:37 -0800 (PST)

--0-1315026452-1136961937=:7870
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Marcel,
 
 You are right. I have fedora core 3 in my lab and I think it comes with this version of bluez.
 [root@70-52 mahtab]# rpm -qa bluez*
 bluez-bluefw-1.0-6
 bluez-pin-0.23-3
 bluez-hcidump-1.11-1
 bluez-utils-2.10-2
 bluez-libs-devel-2.10-2
 bluez-libs-2.10-2
 bluez-utils-cups-2.10-2
 
 I thought I had installed the recent bluez packages and was looking into the codes of bluez-2.24 packages. That explains the error.
 Anyway, I could solve the problem of my_hci_read_rssi function - it was a stupid typo. I should have literally copied your hci_read_rssi function rather than typing it myself. But again, I am not fond of your choice of variables either (rq, rp etc. :P which was the reason of my typo). :D
 
 As I will be making a GUI version considering only RSSI, LQ & TPL part, I think I will not go into installing the newer version of bluez (I also work on my ancient Laptop which has bluez-2.4-1).
 I have chosen GTK+ for dealing with the GUI version. Any suggestions on that?
 My work is to record RSSI, LQ and TPL correcponding to a location (i.e. location fingerprint) in a user-friendly way!
 
 Thanks
 Mahtab
 
 
 
Marcel Holtmann <marcel@holtmann.org> wrote: Hi Mahtab,

> My project is to work with rssi/tpl/lq. My initial goal is to read
> them and show them graphically with some handy features!
> 
> I have gone through hcitool.c (most of the code) and tried to exactly
> copy the necessary things only to retrieve RSSI. But, I couldn't call
> "hci_read_rssi" as them. Compiling my program gave this error:
> 
> mySignalScan.c:102: warning: implicit declaration of function
> `hci_read_rssi'
> mySignalScan.c: At top level:
> /tmp/cc4x36ri.o(.text+0x25b): In function `cmd_rssi':
> : undefined reference to `hci_read_rssi'
> collect2: ld returned 1 exit status

looks like you need to install a newer bluez-libs package.

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



		
---------------------------------
Yahoo! Photos – Showcase holiday pictures in hardcover
 Photo Books. You design it and we’ll bind it!
--0-1315026452-1136961937=:7870
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div id="RTEContent">Hi Marcel,<br> <br> You are right. I have fedora core 3 in my lab and I think it comes with this version of bluez.<br> [root@70-52 mahtab]# rpm -qa bluez*<br> bluez-bluefw-1.0-6<br> bluez-pin-0.23-3<br> bluez-hcidump-1.11-1<br> bluez-utils-2.10-2<br> bluez-libs-devel-2.10-2<br> bluez-libs-2.10-2<br> bluez-utils-cups-2.10-2<br> <br> I thought I had installed the recent bluez packages and was looking into the codes of bluez-2.24 packages. That explains the error.<br> Anyway, I could solve the problem of my_hci_read_rssi function - it was a stupid typo. I should have literally copied your hci_read_rssi function rather than typing it myself. But again, I am not fond of your choice of variables either (rq, rp etc. :P which was the reason of my typo). :D<br> <br> As I will be making a GUI version considering only RSSI, LQ &amp; TPL part, I think I will not go into installing the newer version of bluez (I also work on my ancient Laptop which has bluez-2.4-1).<br
 > I have
 chosen GTK+ for dealing with the GUI version. Any suggestions on that?<br> My work is to record RSSI, LQ and TPL correcponding to a location (i.e. location fingerprint) in a user-friendly way!<br> <br> Thanks<br> Mahtab<br> <br> <br> <br><b><i>Marcel Holtmann &lt;marcel@holtmann.org&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> Hi Mahtab,<br><br>&gt; My project is to work with rssi/tpl/lq. My initial goal is to read<br>&gt; them and show them graphically with some handy features!<br>&gt; <br>&gt; I have gone through hcitool.c (most of the code) and tried to exactly<br>&gt; copy the necessary things only to retrieve RSSI. But, I couldn't call<br>&gt; "hci_read_rssi" as them. Compiling my program gave this error:<br>&gt; <br>&gt; mySignalScan.c:102: warning: implicit declaration of function<br>&gt; `hci_read_rssi'<br>&gt; mySignalScan.c: At top level:<br>&gt; /tmp/cc4x36ri.o(.text+0x25b): In 
 function
 `cmd_rssi':<br>&gt; : undefined reference to `hci_read_rssi'<br>&gt; collect2: ld returned 1 exit status<br><br>looks like you need to install a newer bluez-libs package.<br><br>Regards<br><br>Marcel<br><br><br><br><br>-------------------------------------------------------<br>This SF.net email is sponsored by: Splunk Inc. Do you grep through log files<br>for problems?  Stop!  Download the new AJAX search engine that makes<br>searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!<br>http://ads.osdn.com/?ad_id=7637&amp;alloc_id=16865&amp;op=click<br>_______________________________________________<br>Bluez-users mailing list<br>Bluez-users@lists.sourceforge.net<br>https://lists.sourceforge.net/lists/listinfo/bluez-users<br></blockquote><br></div><p>
		<hr size=1>Yahoo! Photos – Showcase holiday pictures in hardcover<br> 
<a href="http://us.rd.yahoo.com/mail_us/taglines/photobooks/*http://pa.yahoo.com/*http://us.rd.yahoo.com/mail_us/taglines/photos/evt=38088/*http://pg.photos.yahoo.com/ph//page?.file=photobook_splash.html">Photo Books</a>. You design it and we’ll bind it!
--0-1315026452-1136961937=:7870--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
