Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20060516104849.16848.qmail@web50514.mail.yahoo.com>
References: <20060516104849.16848.qmail@web50514.mail.yahoo.com>
Date: Mon, 29 May 2006 15:27:05 +0200
Message-Id: <1148909225.31689.52.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Request with RSSI
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Mahtab,

> In the previous emails from the archive, I read that "hci_inquiry"
> doesn't provide RSSI value on Inquiry. The suggestion was to use raw
> sockets to achieve it.
> 
> I had found Scott Gifford's code using exactly that approach (in the
> archive). But my problem is: I always get EVT_INQUIRY_RESULT, not the
> desired  EVT_INQUIRY_RESULT_WITH_RSSI.
> 
> I check the "mode" value usingn "hci_read_inquiry_mode" which gave me
> 1. Is it correct? I don't know what mode should be set for
> Request_with_RSSI.
> 
> Also, my hci_send_cmd looks like the following (copied from Scott's
> program):
> hci_send_cmd(dd, OGF_LINK_CTL, OCF_INQUIRY, INQUIRY_CP_SIZE, &cp);
> where
> cp.lap[2] = 0x9e
> cp.lap[1] = 0x8b
> cp.lap[0] = 0x33
> 
> I don't know what these values mean (I see exactly similar value for
> cp.lap in the hci_inquiry function from the bluez libraries). Could
> anyone give me any pointers to know more about them?

you need to call "hciconfig hci0 inqmode 1" first to switch this feature
on. You can also use inqmode option in hcid.conf.

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
