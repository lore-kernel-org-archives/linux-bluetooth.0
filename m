Return-Path: <cyrus@holtmann.org>
Message-ID: <20080311102907.kkvnan148sgo8o8k@wmlab.csie.ncu.edu.tw>
Date: Tue, 11 Mar 2008 10:29:07 +0800
From: Ming-I Hsieh <mihs@wmlab.csie.ncu.edu.tw>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Cc: Bastien Nocera <hadess@hadess.net>
Subject: Re: [Bluez-devel] [PATCH] bluez-gnome access volatile
	while	adapter-changed
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

Hi, hadess

Thanks, I had got the patch from bugzilla and it work fine to fix this  
problem.

Regards, Mihs

Quoting &lt;&gt;:

>
> On Mon, 2008-03-10 at 14:36 +0800, Ming-I Hsieh wrote:
>> Hi, all
>>
>> This is a patch for this bug. This bug adddress at
>> bluetooth-device-select.c. While the dongle could be removed/inserted,
>> the gnome-applet may crash due to access a 0x0 priv.
>
> Good catch, but wrong fix, as we shouldn't even be listening to that
> signal anymore. If you could please test the patch I uploaded at:
> http://bugzilla.gnome.org/show_bug.cgi?id=519791#c4
>
> I'll post it here for Marcel to apply if it fixes the problem for you.
>
> Cheers
>
>



----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
