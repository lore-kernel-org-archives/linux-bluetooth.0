Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4483B5E4.7000305@xmission.com>
Date: Sun, 04 Jun 2006 22:41:08 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <768ccca40606041514m77eea4cer437d3ea227d3eec8@mail.gmail.com>
In-Reply-To: <768ccca40606041514m77eea4cer437d3ea227d3eec8@mail.gmail.com>
Subject: Re: [Bluez-devel] Broadcom adapter
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

Eduardo

> I have been investigating a bit around the code. I am not familiar
> with bluez and my knowledge of BT is limited. However, I found that
> I'm getting -ERESTARTSYS (-512) errors in snd_card_bt_sco_thread
> coming from bt_sock_recvmsg. It looks like quite an exotic error code
> to me. Further I have difficulty tracking where it comes from. Is this
> code normal?

I haven't dug into it like you have, but it's not unexpected to see the
error happen there. We have no sco data arriving on hci, so recvmsg must
be interrupted by a signal instead.

I suspect broadcom has an equivalent to csr's nonvolatile setting for
hci vs. pcm audio delivery. Apparently no one has good enough docs to
know for sure. It would help if we knew that dongle had been
successfully used for sco under windows.

Brad



_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
