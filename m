Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: wimpunk <kwdpggwxwumz@spammotel.com>
Date: Sun, 16 Sep 2007 16:42:38 +0200
Message-ID: <uvrvr4-re9.ln1@tisnix.motzarella.org>
References: <iafkr4-c36.ln1@tisnix.motzarella.org>	<20070912091328.GA6594@suse.de>	<699or4-p0q.ln1@tisnix.motzarella.org>
	<20070914090648.GA1085@suse.de>
Mime-Version: 1.0
In-Reply-To: <20070914090648.GA1085@suse.de>
Subject: Re: [Bluez-users] Bluetooth mouse not connecting using Lenny
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Stefan Seyfried wrote:
> On Thu, Sep 13, 2007 at 07:40:22PM +0200, wimpunk wrote:
>> Stefan Seyfried wrote:
> 
>>> No. I see similar looking problems sometimes, that is having to unplug
>>> the dongle before my mouse will reconnect again, but this surely has
>>> a different reason.
>> I'm using hidd - Bluetooth HID daemon version 3.7
>> Which version doesn't need HIDD?
> 
> You can disable the build of hidd since quite some time. In the openSUSE
> package we stopped using it wiht release 3.10. Anyway, for proper debugging,
> you should use the latest BlueZ-version. If you need to use the old version,
> get support from your distribution ;-)
> 

I replaced my BT dongle by another one and my mouse seems to work
perfect now.  It look likes it either was a kernel or hardware problem.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
