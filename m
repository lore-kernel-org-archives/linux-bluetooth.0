Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] sniff mode 
In-reply-to: <EFCD68F7BFDB06468769D4D9EAAA938709664754@scsmsx401.amr.corp.intel.com> 
References: <EFCD68F7BFDB06468769D4D9EAAA938709664754@scsmsx401.amr.corp.intel.com>
From: Peter Stephenson <pws@csr.com>
Message-ID: <EXCHANGE038A5SG1XGj0000c0b6@exchange03.csr.com>
Content-Type: text/plain
MIME-Version: 1.0
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
Date: Mon, 14 Nov 2005 10:27:35 +0000

"Pering, Trevor" wrote:
> Thanks, Marcel. See the output below.  It says "Unsupported Feature of
> Parameter value" -- so, I suppose this means either that the feature
> isn't supported by my particular BT device, or that I'm getting
> something wrong :-).  This is a fairly new SilliconWave dongle, so I
> would assume it would work...   (I've also tried with other devices with
> similar results).

If you're doing this via raw HCI, make sure you or the host stack has
sent HCI_write_link_policy_settings (or
HCI_write_default_link_policy_settings) at both ends to allow sniff
mode.  I believe bluez does this if you have the hcid.conf set up
correctly.

pws


This message has been scanned for viruses by BlackSpider MailControl - www.blackspider.com


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
