Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45A1BAFF.6020305@st.com>
Date: Mon, 08 Jan 2007 09:01:11 +0530
From: Mayank BATRA <mayank.batra@st.com>
MIME-Version: 1.0
To: tom@ytram.com, BlueZ development <bluez-devel@lists.sourceforge.net>
References: <000501c731dd$9e7eec00$0cbbbac6@fte.local>
In-Reply-To: <000501c731dd$9e7eec00$0cbbbac6@fte.local>
Cc: thomaslloyd@yahoo.com
Subject: Re: [Bluez-devel] Error: Unsupported LMP Parameter Value
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

Hi Tom,

> It would be helpful to see the HCI Command that resulted in the HCI Event.
> Unfortunately that event is used for all mode changes and doesn't indicate
> what mode was requested.

Most probably it should be a request for sniff.

> If you've got a "Write Link Policy Settings" command in your trace it might
> be helpful to see that as well.

Actually the link policy settings are applicable only when the remote
side requests for sniff/park/hold.

Even if sniff mode is not enabled using write link policy settings
command and still the host requests for sniff mode, it will not be
rejected as long as the remote device has sniff mode enabled using the
same command.

> Sounds like the headset doesn't like the parameters in the power saving mode
> request. 

This is correct, the headset does not like the parameters in the sniff
command.

> Or, it could be that the headset doesn't support power saving mode
> that is being requested, but I think that causes a different status to be
> returned.

Correct, this results in an error code "LMP PDU not allowed".

Best Regards,

Mayank

---
Random Quote Follows:
I fear explanations explanatory of things explained.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
