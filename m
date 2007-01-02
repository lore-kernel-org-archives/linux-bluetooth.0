Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4599D5BB.4070601@st.com>
References: <31e679430612290415h450d7783w2419171822aec5e9@mail.gmail.com>
	<4595380D.3050004@xmission.com>  <4599D5BB.4070601@st.com>
Date: Tue, 02 Jan 2007 04:58:34 +0100
Message-Id: <1167710314.30886.9.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Bluetooth 2.0
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Mayank,

> >> I'm wondering if I could help the linux bluetooth subsystem by writing
> >> code for the new Bluetooth 2.0 Spec. So, is there any project taking
> >> care of this? Is there any activity for this?
> > 
> > There are some profiles that aren't implemented but 2.0 is mostly 
> > covered. The esco transport isn't done fwiw--it was introduced back in 1.2.
> 
> Don't think there are any new profiles as such.
> The only difference between 1.2 and 2.0 is EDR.

and some minor corrections here and there.

> > Marcel has been working on features that will be in "Lisbon" (2.1?) like 
> > simple pairing and extended inquiry.
> 
> Marcel, I was going through the 2.1 spec and was interested in working
> on features such as Extended Inquiry, Simple Pairing, Sniff Subrating etc.

Actually the Extended Inquiry is already supported with current systems
and it works quite well for the device name. The kernel basically has
preliminary Sniff Subrating support, but the actual used values still
need some tweaking to make use of it.

For Simple Pairing, I will wait until the final specification has been
published. The basic support for Simple Pairing however is ready.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
