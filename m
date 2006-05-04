Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20060504092650.27196.qmail@web31015.mail.mud.yahoo.com>
From: Sergey Krivov <krivov@yahoo.com>
Subject: Re: [Bluez-devel] Motorola HT820 audio fidelity
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <445991B0.9030208@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 4 May 2006 02:26:50 -0700 (PDT)

Hi,

> maybe our defaults are too lossy. after calling
> sbc_init, you can change
> sbc.subbands (default 8), sbc.blocks (default 16),
> sbc.bitpool (default
> 32). subbands can be 4,8. blocks can be 4,8,12,16. i
> need to check the
> spec on bitpool ranges.

I tried to change bitpool to 53 (that is reccomended
value in a2dp specs for 8 subbands and 16 blocks) in
pcm_a2dp. i did not hear any difference. but maybe my
HP headphones are not good. The traffic did increase
by some amount.

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
