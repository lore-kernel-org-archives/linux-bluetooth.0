Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <bd5b16740708160923g17faaaecj77d3f9abd517a65a@mail.gmail.com>
Date: Thu, 16 Aug 2007 19:23:27 +0300
From: "Ohad Ben-Cohen" <ohad@bencohen.org>
To: Alok <develnewbie@gmail.com>
In-Reply-To: <1187271433.6440.18.camel@greatbear>
MIME-Version: 1.0
References: <1187271433.6440.18.camel@greatbear>
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Help regarding TI's Bluetooth chips.
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Alok,

On 8/16/07, Alok <develnewbie@gmail.com> wrote:
> 1. Is HCILL critical for TI's BT chips?

No. HCILL is TI's runtime power management protocol. It is not mandatory;
In fact it is off by default and a special command must be sent to the chip
in order to turn it on (usually it is the last command in the .bts file).
We are currently working on merging the HCILL patches to mainline.
If you are interested, take a look at:
http://article.gmane.org/gmane.linux.bluez.devel/12071

> 2. Has anyone tried a2dp on the brf63xx/brf61xx ? If so what is the
> minimum baud rate that is required ?

A safe minimum value would be 460kbps (although there are some bitpool values
that will make even a baud rate of ~200-300kbps enough).

> 3. I have currently selected the H4 driver. Do i need to select the bcsp driver instead?

HCILL is just an extension of H4 (a few single-byte commands with which the chip
can announce its power state, and the host can wake it up).
When HCILL is off, the BRF chips speak plain H4, so If you don't want HCILL,
 you should indeed use H4.
The BCSP is a communication protocol required for CSR BlueCore chips.
Don't use it.

All the best,
Ohad.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
