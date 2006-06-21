Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Mingfan lu <lucharse@yahoo.com.cn>
In-Reply-To: <20060621085014.80178.qmail@web15802.mail.cnb.yahoo.com>
References: <20060621085014.80178.qmail@web15802.mail.cnb.yahoo.com>
Date: Wed, 21 Jun 2006 10:59:50 +0200
Message-Id: <1150880390.3950.25.camel@localhost>
Mime-Version: 1.0
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel]
	=?utf-8?b?5Zue5aSN77yaIFJlOiDlm57lpI3vvJogUmU6ICBS?=
	=?utf-8?b?Re+8miBSRTogRldE77yaIFJlOiBSZTpSZXF1ZXN0IHdpdGgJUlNTSQ==?=
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

Hi,

> I can't understand your test , why you set the mode 5? 
> what is the relation between  your result and the problem?   

it means that they support the inquiry mode command, but don't do
actually anything with it. Setting it to 5 is not allowed. So this
command should fail and later on it should retrieve only 0 or 1 as valid
values, but it doesn't. This leads to the conclusion that they only
store the inquiry mode value somewhere, but never evaluate it. And this
means they will never switch to Inquiry with RSSI as you have seen
before.

Regards

Marcel

> 



_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
