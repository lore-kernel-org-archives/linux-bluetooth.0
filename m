Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Fri, 1 Jun 2007 16:34:47 +0200
From: Andreas Gaufer <Andreas.Gaufer@bluecellnetworks.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20070601163447.0c678f57@localhost.localdomain>
In-Reply-To: <loom.20061226T054340-711@post.gmane.org>
References: <loom.20061226T054340-711@post.gmane.org>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] hci inquiry error with name scan
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Avaited,

i believe this is a bug in hci.c in the bluez-libs package. It returns
wrong names if multiple hci_read_remote_name calls are done in a short
period of time.

hci_send_req which is used by hci_read_remote_name returns data of the
first EVT_REMOTE_NAME_REQ_COMPLETE that occurs on the device even if it
does not match the bdaddres that was requested. 

This problem was also already noticed by Sjoerd Simons in June 2004 and
sent to this list with the subject "btaddr <-> name bug ?" (1)

I prepared a patch that should fix that problem. I will provide that
patch on this list as soon as I'm finished with stress-testing it.

Greetings

Andy


1) http://thread.gmane.org/gmane.linux.bluez.devel/2489/focus=2491


On Tue, 26 Dec 2006 04:47:47 +0000 (UTC)
Avaited <compuvikas@gmail.com> wrote:

> hi all 
> 
> I am facing a big problem with hci layer process. I have developed a platform
> and http wraper for bluetooth services using bluez.  I am searching all device
> present in vicinity by using hci.c function 'hci_scan()'. later for each
> number(BDADDR) i am searching its name by hci_read_remote_name(). Most of the
> time I am getting right name(i.e. what ever name i am giving to my devices ) But
> some time name get swaped with some one. Lisk in my case my mobile name was
> SHARK and my Machine name was VIKAS [0], VIKAS[1], my friends mobile was GOLD,
> SILVER. but when I had done scan name it returned me my mobile,s name as
> VIKAS[1]. I am surprise why this happened.
> 
> Is there any problem with present bluez stack I am using
> bluez-bluefw-1.0-6
> bluez-pin-0.23-3
> bluez-hcidump-1.11-1
> bluez-libs-2.10-2
> bluez-utils-2.10-2.1
> on redhat 4.0 Enterprise Edition
> with kernel 2.6.9-5.EL i386
> int getScanName(bdaddr_t *device_bt,char * device_name,bdaddr_t *dongle_bt)
> {
>         if((s = GetScanSock(dongle_bt)) < 0)    // this will connect to local dongle
>         {
>                 ERR_LOG(ERR,"Unable to open socket");
>                 return -s;
>         }
>         if(hci_read_remote_name(s, device_bt,sizeof(device_name),device_name,0) < 0)
>         {
>                 ERR_LOG(DBG,"No Name found");
>                 close(s);
>                 return -NOTFOUND;
>         }
>         ERR_LOG(DBG,"Name of Device hci scan  [%s] DeviceBT
> [%s]",device_name,device_bt);
>         close(s);
>         return 0;
> }
> this function get called for each device found in scan.
> 
> 
> I am in deep trouble to know what is problem with this.
> 
> Please help
> 
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel




-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
