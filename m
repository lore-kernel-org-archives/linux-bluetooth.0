Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46015990.0@lwfinger.net>
Date: Wed, 21 Mar 2007 11:13:04 -0500
From: Larry Finger <larry.finger@lwfinger.net>
MIME-Version: 1.0
To: Zan Lynx <zlynx@acm.org>
References: <20070319205623.299d0378.akpm@linux-foundation.org>	<1174433034.62033.16.camel@localhost>
	<20070320223643.d8cbc3f6.akpm@linux-foundation.org>
In-Reply-To: <20070320223643.d8cbc3f6.akpm@linux-foundation.org>
Cc: reiserfs-dev@namesys.com, bluez-devel@lists.sourceforge.net,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Bluez-devel] 2.6.21-rc4-mm1
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

Andrew Morton wrote:
> On Tue, 20 Mar 2007 17:23:54 -0600 Zan Lynx <zlynx@acm.org> wrote:
> 
>> On Mon, 2007-03-19 at 20:56 -0800, Andrew Morton wrote:
>>> Temporarily at
>>>
>>>   http://userweb.kernel.org/~akpm/2.6.21-rc4-mm1/
>>>
>>> Will appear later at
>>>
>>>   ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.21-rc4/2.6.21-rc4-mm1/
>> First impressions:
>> Several of the same bugs as rc3-mm*:
>>       * Freezes immediately if I touch the wlan0 device after loading
>>         the new Broadcom wireless driver.

--snip--

>> 02:02.0 Network controller: Broadcom Corporation BCM4303 802.11b Wireless LAN Controller (rev 02)

I'm a little confused. The bcm43xx-mac80211 driver does not handle 802.11b devices, and the
bcm43xx-softmac driver should not freeze. Which one was configured here?

Larry

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
