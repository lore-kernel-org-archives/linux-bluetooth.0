Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050419210412.75488.qmail@web54703.mail.yahoo.com>
From: Hiren Mandalia <hir100@yahoo.com>
Subject: RE: [Bluez-users] Bluetooth audio support
To: bluez-users@lists.sourceforge.net
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1005287598-1113944651=:75178"
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
Date: Tue, 19 Apr 2005 14:04:11 -0700 (PDT)

--0-1005287598-1113944651=:75178
Content-Type: text/plain; charset=us-ascii

with -b option it gives the following
 
$ pskey -d /dev/ttySB0
Physical device: /dev/ttSB0
Speed : 115200
Use BCSP : YES
Initiating read thread
BT SYS: Initializing BCSP
Failed to init BCSP


Marcel Holtmann <marcel@holtmann.org> wrote:
Hi Hiren,

> i have downloaded & installed the pskey utility. however when i do a 
> 
> pskey -d /dev/ttySB0, it gives me an error. the exact message is like
> this
> 
> 
> 
> $ pskey -d /dev/ttySB0
> 
> Physical device: /dev/ttSB0
> 
> Speed : 115200
> 
> Use BCSP : NO
> 
> Initiating read thread
> 
> Now trying to read firmware info
> 
> Timeout!!!
> 
> Error in reading firmware info
> 
> 
> 
> Can any1 guide why this error? Also if any1 could direct me to a
> 'pskey' manual. I couldn't find it online anywhere. for those of you
> don't recollect i'm trying to get bluetooth audio working (via SCO) on
> my ipaq 3870 with Familiar Linux v0.8.1

the iPAQ is using BCSP as transport protocol and I think you must tell
this to pskey. Maybe the parameter is "-b" or "-B".

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
--0-1005287598-1113944651=:75178
Content-Type: text/html; charset=us-ascii

<DIV>with -b option it gives the following</DIV>
<DIV>&nbsp;</DIV>
<DIV>$ pskey -d /dev/ttySB0<BR>Physical device: /dev/ttSB0<BR>Speed : 115200<BR>Use BCSP : YES<BR>Initiating read thread</DIV>
<DIV>BT SYS: Initializing BCSP</DIV>
<DIV>Failed to init BCSP<BR><BR><BR><B><I>Marcel Holtmann &lt;marcel@holtmann.org&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Hi Hiren,<BR><BR>&gt; i have downloaded &amp; installed the pskey utility. however when i do a <BR>&gt; <BR>&gt; pskey -d /dev/ttySB0, it gives me an error. the exact message is like<BR>&gt; this<BR>&gt; <BR>&gt; <BR>&gt; <BR>&gt; $ pskey -d /dev/ttySB0<BR>&gt; <BR>&gt; Physical device: /dev/ttSB0<BR>&gt; <BR>&gt; Speed : 115200<BR>&gt; <BR>&gt; Use BCSP : NO<BR>&gt; <BR>&gt; Initiating read thread<BR>&gt; <BR>&gt; Now trying to read firmware info<BR>&gt; <BR>&gt; Timeout!!!<BR>&gt; <BR>&gt; Error in reading firmware info<BR>&gt; <BR>&gt; <BR>&gt; <BR>&gt; Can any1 guide why this error? Also if any1 could direct me to a<BR>&gt; 'pskey' manual. I couldn't find it online anywhere. for those of you<BR>&gt; don't recollect i'm trying to get bluetooth audio working (via SCO) on<BR>&gt; my ipaq 3870 with Familiar Linux v0.8.1<BR><BR>the iPAQ is using BCSP as transport protocol and I
  think
 you must tell<BR>this to pskey. Maybe the parameter is "-b" or "-B".<BR><BR>Regards<BR><BR>Marcel<BR><BR><BR><BR><BR>-------------------------------------------------------<BR>This SF.Net email is sponsored by: New Crystal Reports XI.<BR>Version 11 adds new functionality designed to reduce time involved in<BR>creating, integrating, and deploying reporting solutions. Free runtime info,<BR>new features, or free trial, at: http://www.businessobjects.com/devxi/728<BR>_______________________________________________<BR>Bluez-users mailing list<BR>Bluez-users@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/bluez-users<BR></BLOCKQUOTE><p>
		<hr size=1>Do you Yahoo!?<br> 
Plan great trips with <a href="http://us.lrd.yahoo.com/_ylc=X3oDMTFmZ2htMTlyBF9TAzMyOTc1MDIEX3MDODYyNzYxNwRwb3MDMQRzZWMDbWFpbARzbGsDZm9vdGVy/SIG=10tesb5j9/**http%3a//travel.yahoo.com/">Yahoo! Travel</a>: Now <a href="http://us.lrd.yahoo.com/_ylc=X3oDMTFmMnFhajhhBF9TAzMyOTc1MDIEX3MDODYyNzYxNwRwb3MDMgRzZWMDbWFpbARzbGsDZm9vdGVy/SIG=12jqk5n45/**http%3a//travel.yahoo.com/p-travelguide-191500002-destination_guides_vacations-i">over 17,000 guides!</a>
--0-1005287598-1113944651=:75178--


-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
