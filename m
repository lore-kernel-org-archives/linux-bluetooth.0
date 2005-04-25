Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20050425013050.76433.qmail@web20927.mail.yahoo.com>
From: Arch Sayo <a12chi@yahoo.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1864222659-1114392650=:75482"
Subject: [Bluez-devel] Adding services in the Service Class ID list
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
Date: Sun, 24 Apr 2005 18:30:50 -0700 (PDT)

--0-1864222659-1114392650=:75482
Content-Type: text/plain; charset=us-ascii

Hi,
 
I have been trying to add services in the Service Class ID list like as shown below:
 
Attribute Identifier : 0x1 - ServiceClassIDList
  Data Sequence
    UUID16 : 0x1112 - HeadsetAudioGateway
    UUID16 : 0x1203 - GenericAudio
 
It seemed that the 2 services have been added successfully.
However, when I use sdptool to browse for the services, only the last service is the one reflected in the service and not both.
 
Please advice as on how I can successfully add the 2 services in the service class ID list.
 
Thanks,
Arch

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1864222659-1114392650=:75482
Content-Type: text/html; charset=us-ascii

<DIV>Hi,</DIV>
<DIV>&nbsp;</DIV>
<DIV>I have been trying to add services in the Service Class ID list like as shown below:</DIV>
<DIV>&nbsp;</DIV>
<DIV>Attribute Identifier : 0x1 - ServiceClassIDList<BR>&nbsp; Data Sequence<BR>&nbsp;&nbsp;&nbsp; UUID16 : 0x1112 - HeadsetAudioGateway<BR>&nbsp;&nbsp;&nbsp; UUID16 : 0x1203 - GenericAudio</DIV>
<DIV>&nbsp;</DIV>
<DIV>It seemed that the 2 services have been added successfully.</DIV>
<DIV>However, when I use sdptool to browse for the services, only the last service is the one reflected in the service and not both.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Please advice as on how I can successfully add the 2 services in the service class ID list.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks,</DIV>
<DIV>Arch</DIV><p>__________________________________________________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>http://mail.yahoo.com 
--0-1864222659-1114392650=:75482--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
