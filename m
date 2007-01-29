Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <45BDCE90.5070906@st.com>
References: <D8CE9CFA707C894180BAC8CDD154F8460B033014@msiexch01.marvell.com>
	<45B5AD79.8020104@st.com> <1169573111.5861.12.camel@violet>
	<45BDCE90.5070906@st.com>
Date: Mon, 29 Jan 2007 11:55:29 +0100
Message-Id: <1170068129.15389.122.camel@violet>
Mime-Version: 1.0
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

Hi Mayank,

> > actually it is totally wrong. Sending the 3-DH5 bit only means that you
> > wanna enable DM1 and all EDR packets except 3-DH5, because setting that
> > bit means you disable that packet type. The corresponding response
> > should be DM1 + 3-DH5 bit set.
> > 
> > Since this is custom firmware, it is interpreting the bitmask of the
> > change connection packet type in the wrong way.
> > 
> > And to be clear on this, I don't care about the packet mask at all and
> > nobody should mess with it (except for testing). Let the link manager
> > decide which packet type to use. BlueZ can't make any intelligent
> > decision on which is the best packet type. It doesn't know anything
> > about the piconet it is using besides its handle.
> 
> OK. But my question is why display different packet lists in the command
> and event?
> < HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
>     handle 1 ptype 0x2000
>     Packet type: 3-DH5
> 
> ...
> 
> > HCI Event: Connection Packet Type Changed (0x1d) plen 5
>     status 0x00 handle 1 ptype 0x1306
>     Packet type: 2-DH1 2-DH3 2-DH5 3-DH1 3-DH3
> 
> Both of them should show the same packet list. Isn't it?

that must be a bug in their firmware. They should be the same with the
only exception of DM1.

My assumption is that change connection packet type is treating this
command as enable 3-DH5 only. However that is not what that command
means. It means enable DM1 and all 2-* and 3-* packets except 3-DH5.

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
