Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20051219020816.22123.qmail@web36109.mail.mud.yahoo.com>
From: Swathi Mathur80 <swathi_mathur80@yahoo.com>
Subject: Re: [Bluez-users] don't find the module "snd_bt_sco"
To: bluez-users@lists.sourceforge.net
In-Reply-To: <43A319B5.9040100@bglug.it>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-767716231-1134958096=:21652"
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
Date: Sun, 18 Dec 2005 18:08:16 -0800 (PST)

--0-767716231-1134958096=:21652
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello jimmi,
 Thanks for giving the solution. Now i am able to load the module.
 Regards,
 Swathi

jimmi <jimmi@bglug.it> wrote: Swathi Mathur80 ha scritto:
> I am unable to find the module "snd_bt_sco". Where can i find this module ?
> Do you think i might have made any mistake in any of the steps which are 
> executed before.
> Can anyone help me with this.

I also had some problem because the "make install" couldn't copy the module.

If it was compiled correctly by "make" you may find the module 
"snd-bt-sco.ko" under btsco/kernel

You shall create the directory "/lib/modules/KERNELVERSION/extra", where 
KERNELVERSION is the kernel that you booted, and copy inside it the 
module. After that "modprobe snd-bt-sco" should work correctly.

Jimmi


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-767716231-1134958096=:21652
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div id="RTEContent">Hello jimmi,<br> Thanks for giving the solution. Now i am able to load the module.<br> Regards,<br> Swathi<br><br><b><i>jimmi &lt;jimmi@bglug.it&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> Swathi Mathur80 ha scritto:<br>&gt; I am unable to find the module "snd_bt_sco". Where can i find this module ?<br>&gt; Do you think i might have made any mistake in any of the steps which are <br>&gt; executed before.<br>&gt; Can anyone help me with this.<br><br>I also had some problem because the "make install" couldn't copy the module.<br><br>If it was compiled correctly by "make" you may find the module <br>"snd-bt-sco.ko" under btsco/kernel<br><br>You shall create the directory "/lib/modules/KERNELVERSION/extra", where <br>KERNELVERSION is the kernel that you booted, and copy inside it the <br>module. After that "modprobe snd-bt-sco" should work
 correctly.<br><br>Jimmi<br><br><br>-------------------------------------------------------<br>This SF.net email is sponsored by: Splunk Inc. Do you grep through log files<br>for problems?  Stop!  Download the new AJAX search engine that makes<br>searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!<br>http://ads.osdn.com/?ad_id=7637&amp;alloc_id=16865&amp;op=click<br>_______________________________________________<br>Bluez-users mailing list<br>Bluez-users@lists.sourceforge.net<br>https://lists.sourceforge.net/lists/listinfo/bluez-users<br></blockquote><br></div><p>__________________________________________________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>http://mail.yahoo.com 
--0-767716231-1134958096=:21652--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
