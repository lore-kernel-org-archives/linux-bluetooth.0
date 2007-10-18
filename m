Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <47179104.2000601@silicom.fr>
Date: Thu, 18 Oct 2007 18:59:48 +0200
From: Fabien Chevalier <fchevalier@silicom.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <008f01c81190$b044a270$10cde750$@savary@kerlink.fr>
In-Reply-To: <008f01c81190$b044a270$10cde750$@savary@kerlink.fr>
Content-Type: multipart/mixed; boundary="------------030301020200010701040708"
Subject: Re: [Bluez-devel] compile audio in bluez-utils-3.20
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------030301020200010701040708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Pierre,
> Hi,
> 
> I am a beginner with bluez and I hope that you will be able to inform me and
> to help itself. I wish that my PC be the headset of my phone.
> I wish that it embed audio profiles HFP and A2DP so that it can be used as
> headset/handsfree for a telephone or a walkman.

It will be done at some point in the future, but right now this is not 
implemented. Only the HFP audio gateway side an A2DP source is currently 
being actively developped.

> Then I make a make ... and I don't see *.o file in the audio directory
> ???!!! What can I do?

--enable-all does not enable audio service ;-)
You need to run with --enable-audio.

> 
> Also, does it exist an opensource project for handsfree profile with bluez?

Handsfree profile is basically in the pipe. If all goes as planned, it 
should come something like end of 2007/early 2008.

Regards,

Fabien Chevalier

--------------030301020200010701040708
Content-Type: text/x-vcard; charset=utf-8;
 name="fchevalier.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fchevalier.vcf"

begin:vcard
fn:Fabien CHEVALIER
n:CHEVALIER;Fabien
org:SILICOM
adr:;;4 rue de Jouanet; RENNES ATALANTE;;35700;FRANCE
email;internet:fchevalier@silicom.fr
title:Software & Studies Engineer
tel;work:+33 (0) 2 99 84 17 17
version:2.1
end:vcard


--------------030301020200010701040708
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--------------030301020200010701040708
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------030301020200010701040708--
