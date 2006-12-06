Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45772B71.5020505@vasmac.com>
Date: Wed, 06 Dec 2006 15:43:29 -0500
From: Jose Vasconcellos <jose@vasmac.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <457655A2.6030001@xmission.com>
In-Reply-To: <457655A2.6030001@xmission.com>
Content-Type: multipart/mixed; boundary="------------090503010007080707000804"
Subject: Re: [Bluez-devel] org.bluez.Audio
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------090503010007080707000804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brad,

I'm a little unclear on the division of work between bt.audiod and
the audio library plugins. From the diagram, it seems that bt.audiod
handles the control as well as the audio streams. Does this mean
that the the audio samples get copied from the plugins to/from
bt.audiod? I'm not sure if the extra copying and latency is a good
thing.

I think that bt.audiod should only handle the audio control portion.
The audio plugins should do direct bluetooth I/O.

Jose

Brad Midgley wrote:
> Marcel
>
> I rewrote the dbus proposal. If what's here looks ok we can start
> thinking about the named pipe, ipc, or whatever we use for sending audio
> and file descriptors around.
>
> http://bluetooth-alsa.sourceforge.net/future.html
>
> Brad
>   

--------------090503010007080707000804
Content-Type: text/x-vcard; charset=utf-8;
 name="jose.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="jose.vcf"

begin:vcard
fn:Jose Vasconcellos
n:Vasconcellos;Jose
org:Vas & Mac Enterprises LLC
adr:;;P.O. Box 567;Red Bank;NJ;07701;USA
email;internet:jose@vasmac.com
title:Managing Member and CTO
tel;work:+1 732 978 4680 x102
tel;fax:+1 206 888 6951
url:http://www.vasmac.com
version:2.1
end:vcard


--------------090503010007080707000804
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------090503010007080707000804
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------090503010007080707000804--
