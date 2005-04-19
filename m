Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050419211741.73117.qmail@web54705.mail.yahoo.com>
From: Hiren Mandalia <hir100@yahoo.com>
Subject: RE: [Bluez-users] Bluetooth audio support
To: bluez-users@lists.sourceforge.net
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1558328112-1113945460=:70683"
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
Date: Tue, 19 Apr 2005 14:17:40 -0700 (PDT)

--0-1558328112-1113945460=:70683
Content-Type: text/plain; charset=us-ascii

hi Marcel,
 
the hciattach uses 230400.
 
i tried 
$ pskey -b -d /dev/ttySB0 -s 230400      but the same result. Failed to init BCSP...
 
regards,
hiren

Marcel Holtmann <marcel@holtmann.org> wrote:
Hi Hiren,

> with -b option it gives the following
> 
> $ pskey -d /dev/ttySB0
> Physical device: /dev/ttSB0
> Speed : 115200
> Use BCSP : YES
> Initiating read thread
> BT SYS: Initializing BCSP
> Failed to init BCSP

I think the speed is wrong. Check what is used by the hciattach command
of your distribution.

Regards

Marcel





-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

		
---------------------------------
Do you Yahoo!?
 Plan great trips with Yahoo! Travel: Now over 17,000 guides!
--0-1558328112-1113945460=:70683
Content-Type: text/html; charset=us-ascii

<DIV>hi Marcel,</DIV>
<DIV>&nbsp;</DIV>
<DIV>the hciattach uses 230400.</DIV>
<DIV>&nbsp;</DIV>
<DIV>i tried </DIV>
<DIV>$ pskey -b -d /dev/ttySB0 -s 230400&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; but the same result. Failed to init BCSP...</DIV>
<DIV>&nbsp;</DIV>
<DIV>regards,</DIV>
<DIV>hiren<BR><BR><B><I>Marcel Holtmann &lt;marcel@holtmann.org&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Hi Hiren,<BR><BR>&gt; with -b option it gives the following<BR>&gt; <BR>&gt; $ pskey -d /dev/ttySB0<BR>&gt; Physical device: /dev/ttSB0<BR>&gt; Speed : 115200<BR>&gt; Use BCSP : YES<BR>&gt; Initiating read thread<BR>&gt; BT SYS: Initializing BCSP<BR>&gt; Failed to init BCSP<BR><BR>I think the speed is wrong. Check what is used by the hciattach command<BR>of your distribution.<BR><BR>Regards<BR><BR>Marcel<BR><BR><BR><BR><BR><BR>-------------------------------------------------------<BR>This SF.Net email is sponsored by: New Crystal Reports XI.<BR>Version 11 adds new functionality designed to reduce time involved in<BR>creating, integrating, and deploying reporting solutions. Free runtime info,<BR>new features, or free trial, at: http://www.businessobjects.com/devxi/728<BR>_______________________________________________<BR>Bluez-users mailing
 list<BR>Bluez-users@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/bluez-users<BR></BLOCKQUOTE><p>
		<hr size=1>Do you Yahoo!?<br> 
Plan great trips with <a href="http://us.lrd.yahoo.com/_ylc=X3oDMTFmZ2htMTlyBF9TAzMyOTc1MDIEX3MDODYyNzYxNwRwb3MDMQRzZWMDbWFpbARzbGsDZm9vdGVy/SIG=10tesb5j9/**http%3a//travel.yahoo.com/">Yahoo! Travel</a>: Now <a href="http://us.lrd.yahoo.com/_ylc=X3oDMTFmMnFhajhhBF9TAzMyOTc1MDIEX3MDODYyNzYxNwRwb3MDMgRzZWMDbWFpbARzbGsDZm9vdGVy/SIG=12jqk5n45/**http%3a//travel.yahoo.com/p-travelguide-191500002-destination_guides_vacations-i">over 17,000 guides!</a>
--0-1558328112-1113945460=:70683--


-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
