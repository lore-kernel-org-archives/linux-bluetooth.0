Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45B5AD79.8020104@st.com>
Date: Tue, 23 Jan 2007 12:08:49 +0530
From: Mayank BATRA <mayank.batra@st.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <D8CE9CFA707C894180BAC8CDD154F8460B033014@msiexch01.marvell.com>
In-Reply-To: <D8CE9CFA707C894180BAC8CDD154F8460B033014@msiexch01.marvell.com>
Subject: Re: [Bluez-devel] hcidump EDR packet type
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

Hi Quinton,

> Wondering someone can help to enlighten me on where hci packet type bit
> is reversed for  change connection packet type command (issued by
> hcitool) for EDR mode, based on the below hcidump, seems 0x2000 is
> passed down (which should be 0x1306), however, return message ptype
> 0x1306 is correct even decoding is not right.

In case you wanted to change the packet type to 3-DH5 0x2000 is
perfectly fine since EDR packets are inverted i.e. they will be selected
if the corresponding bit is 0 and not 1. Internally, before sending the
change connection packet type command all stacks (hopefully BlueZ as
well) will xor the packet mask with the EDR packet type list. Thus if
you enabled an EDR packet (eg 0x2000 for 3-DH5), the bit for 3-DH5 will
be made 0 and bits for remaining EDR packets shall be made 1.

0x1306 means that 3-DH5 and DM1 have been selected on the ACL link which
is logical since DM1 is by default selected on all ACL links and you
just changed the packet type to 3-DH5.

=> There is nothing wrong going on except hcidump should be corrected to
parse the packet type mask properly. Here it should have shown only DM1
and 3-DH5.

Best Regards,

Mayank



--
Random Quote Follows:
"In my opinion, shareware tends to combine the worst of commercial
software (no sources) with the worst of free software (no finishing
touches). I simply do not believe in the shareware market at all."
                                              -- Linus Torvalds

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
